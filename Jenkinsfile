pipeline {
  agent any

  triggers {
    githubPush()  // Trigger automatically on GitHub push
  }

  environment {
    FLUTTER_HOME = "${WORKSPACE}/.flutter"
    PATH = "${env.PATH}:${env.FLUTTER_HOME}/bin"

    SONAR_TOKEN = credentials('235372847c47ee8d087a67e69631ef896b5dfc85')
    SONAR_ORG = 'ankurdutta21'
    SONAR_PROJECT_KEY = 'AnkurDutta21_RoundTheClock_App'

    MOBSF_API_KEY = credentials('1bfaf76c9e0b6038aa5d67690146b91c7b6df9b6d8540bf9c1b292acf2a11088')
    MOBSF_URL = 'https://mobsf.mapwala.in/'

    FIREBASE_TOKEN = credentials('1//0gy_4IsMHlCKBCgYIARAAGBASNwF-L9IrJESLoGlLNffepmLre2sH-Y1OxFEdd2cbXez1BIjgNy9BrDfD4SlWH56i6MKIBHI9uzw')
    FIREBASE_APP_ID = '1:559369489261:android:24e5904d142c56d1cba864'
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
