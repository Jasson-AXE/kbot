pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS', defaultValue: 'linux')
        choice(name: 'ARCH', choices: ['x86', 'x64', 'arm'], description: 'Pick architecture', defaultValue: 'x64')
    }
    stages {
        stage('Example') {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
            }
        }
    }
}
