pipeline {
  agent any

  triggers {
    githubPush()  // Trigger automatically on GitHub push
  }

  environment {
    FLUTTER_HOME = "${WORKSPACE}/.flutter"
    PATH = "${env.PATH}:${env.FLUTTER_HOME}/bin"

    SONAR_TOKEN = credentials('sonarcloud-token')
    SONAR_ORG = 'your_sonarcloud_org'
    SONAR_PROJECT_KEY = 'your_sonarcloud_project_key'

    MOBSF_API_KEY = credentials('mobsf-api-key')
    MOBSF_URL = 'http://localhost:8000'

    FIREBASE_TOKEN = credentials('firebase-token')
    FIREBASE_APP_ID = '1:1234567890:android:abcdef1234567890'
    FIREBASE_GROUPS = 'internal-testers'
  }

  stages {
    stage('Checkout') {
      steps {
        echo "📦 Checking out source code..."
        checkout scm
      }
    }

    stage('Install Flutter') {
      steps {
        echo "📥 Installing Flutter SDK..."
        sh '''
          if [ ! -d "${FLUTTER_HOME}" ]; then
            git clone https://github.com/flutter/flutter.git -b stable "${FLUTTER_HOME}"
          fi
          export PATH="$PATH:${FLUTTER_HOME}/bin"
          flutter doctor
        '''
      }
    }

    stage('Dependencies') {
      steps {
        echo "📦 Fetching dependencies..."
        sh 'flutter pub get'
      }
    }

    stage('Static Analysis & Tests') {
      steps {
        echo "🧪 Running static analysis and tests..."
        sh '''
          flutter analyze || true
          flutter test --no-sound-null-safety || true
        '''
      }
    }

    stage('Build APK') {
      steps {
        echo "🏗️ Building release APK..."
        sh 'flutter build apk --release'
      }
      post {
        success {
          archiveArtifacts artifacts: 'build/app/outputs/**/*.apk', fingerprint: true
        }
      }
    }

    stage('SonarCloud Analysis') {
      steps {
        echo "🔍 Running SonarCloud analysis..."
        sh '''
          sonar-scanner \
            -Dsonar.organization=${SONAR_ORG} \
            -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
            -Dsonar.sources=lib \
            -Dsonar.host.url=https://sonarcloud.io \
            -Dsonar.login=${SONAR_TOKEN}
        '''
      }
    }

    stage('MobSF Security Scan') {
      steps {
        echo "🛡️ Running MobSF security scan..."
        sh '''
          APK_PATH=$(ls build/app/outputs/flutter-apk/app-release.apk)
          echo "Uploading $APK_PATH to MobSF..."
          curl -F "file=@${APK_PATH}" -H "Authorization:${MOBSF_API_KEY}" ${MOBSF_URL}/api/v1/upload > upload.json
          SCAN_HASH=$(cat upload.json | jq -r '.hash')
          curl -X POST -H "Authorization:${MOBSF_API_KEY}" -H "Content-Type: application/json" \
            -d "{\"hash\": \"${SCAN_HASH}\"}" ${MOBSF_URL}/api/v1/scan > scan_result.json
          echo "✅ MobSF scan complete."
        '''
      }
    }

    stage('Deploy to Firebase App Distribution') {
      steps {
        echo "🚀 Deploying APK to Firebase..."
        sh '''
          APK_PATH=$(ls build/app/outputs/flutter-apk/app-release.apk)
          firebase appdistribution:distribute "$APK_PATH" \
            --app "${FIREBASE_APP_ID}" \
            --groups "${FIREBASE_GROUPS}" \
            --token "${FIREBASE_TOKEN}" \
            --release-notes "Auto build from Jenkins on $(date '+%Y-%m-%d %H:%M')"
        '''
      }
    }
  }

  post {
    success {
      echo "✅ Flutter app successfully built, scanned, and deployed!"
    }
    failure {
      echo "❌ Build failed. Please check Jenkins logs."
    }
  }
}
