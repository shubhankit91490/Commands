#!/bin/bash



alias gp="getPods"
alias st="generateStagingToken"
alias pt="generateProdToken"
alias dt="generateDevToken"
alias pf="portForward"
alias dp="describePod"


function getPods() {
    echo ""
    echo "command => kubectl get pods -n ${1:-hmsexp}"
    echo ""
    kubectl get pods -n ${1:-hmsexp}
}

function generateStagingToken() {
    echo
    echo "Generate kubernetes token for Staging"
    echo
    
    mkdir -p ${HOME}/.kube/certs/k8s-0.oyorooms.ms/ && cat << EOF > ${HOME}/.kube/certs/k8s-0.oyorooms.ms/k8s-ca.crt
-----BEGIN CERTIFICATE-----
MIIC0zCCAbugAwIBAgIMFcd0RfNvW1AedqlqMA0GCSqGSIb3DQEBCwUAMBUxEzAR
BgNVBAMTCmt1YmVybmV0ZXMwHhcNMTkwOTIyMTg0NzE4WhcNMjkwOTIxMTg0NzE4
WjAVMRMwEQYDVQQDEwprdWJlcm5ldGVzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA3Gs1dNE6j9hlUlbaXOhdH4nXJCZlRqRF9EG/FOe9AfLHG1o1G6RB
KKnAgW7GKsorgmlbZOdt97JQCW5V7Pf81kaSMVaFe533J5EratgvsLG9raftijqg
xXo6fOWBNChIbRp2AI28ssn8FGwDeMUZHPmxZPDpLvJASq19BcZe9vZrdRNI9L45
V4sjLqRpj+7WQEhq03HOntdxzz5zjVtBLcAfBvCWuxVoD9K4DLB8vGqfeQjM7AU1
Oa4U6gF2+5XiKqDbuD3q2CHKB/Lyeh0+fxcSD6G/ucnpXbHXArXm0mxqWSqgTELM
yMeJuzEAcyXCHdE2oQVMGZ2ysPBsAQXP3wIDAQABoyMwITAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAsLe8mvrx4qrP
BBRTes6Hb7ydXnpDBJ2GWlArKR8vRA9BeB+s78YW58vZIjfk3I+zxga+JnAKDOt8
WhkQoxqRtiO5VCfEI7E5pemLPzhBOZfvANG1et8ttUC/mKbVpoKGfL20r31y1aCj
vm1SodqB1E517Nd47F2xPDUOZYBbinEhEH4aBtSXsDZxZYRMY/UJ3wmEL8cjC31V
5BDN3Cc08L7hFX1sGizIUnPrUxOh6HkSS2/3rJgOp7ry+Mbcw1U+TfoACn1aBSOm
j5yt5YFFw1NAtpnLuM5W1Nwd5DpkcTOWD0CgaysxiFVnjsJXxtPpPg0EZtJO0nE8
z2POO2wivg==
-----END CERTIFICATE-----

EOF

    kubectl config set-cluster k8s-0.oyorooms.ms \
    --certificate-authority=${HOME}/.kube/certs/k8s-0.oyorooms.ms/k8s-ca.crt \
    --server=https://api.k8s-0.oyorooms.ms

    pbpaste | sh

    kubectl config set-context shubhankit.bansal1-k8s-0.oyorooms.ms \
    --cluster=k8s-0.oyorooms.ms \
    --user=shubhankit.bansal1-k8s-0.oyorooms.ms

    kubectl config use-context shubhankit.bansal1-k8s-0.oyorooms.ms
}

function generateProdToken() {
    echo
    echo "Generate kubernetes token for Production"
    echo
    mkdir -p ${HOME}/.kube/certs/k8s2.oyorooms.io/ && cat << EOF > ${HOME}/.kube/certs/k8s2.oyorooms.io/k8s-ca.crt
-----BEGIN CERTIFICATE-----
MIIC0zCCAbugAwIBAgIMFdpPJPngmmjd4ZcDMA0GCSqGSIb3DQEBCwUAMBUxEzAR
BgNVBAMTCmt1YmVybmV0ZXMwHhcNMTkxMTIzMDUwMDM5WhcNMjkxMTIyMDUwMDM5
WjAVMRMwEQYDVQQDEwprdWJlcm5ldGVzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAxJGNY9ZYzboErGQ8DQcbhB8zp2Np0bbPLfs9YYgNQyYJ48WH+BuZ
0JyGBKBWKwHcYL2+IDRjbEpIp5fDkrx9MR4BzZIXFhPbzDkUzL3ZHBGGyCJHfnAB
PIQOP6llUuiY3q3M5sZo5/YWDx7QKtg6skAWMev4t2+lmFgp1CoJCRdFcyzr1l9o
phHHIQ8jAmkvGnfzRFlBnVOl5Yv0HYsB+vmKFNHGmrIhGgk/NXCtnzpVbfcQ0RDE
LBZoIK5F+b5AfEQMGBNJ0XTYPedNqqcupx2qiKKEAKJPRXuTkvcG4p6knad6quHS
uT0mUwVcaQJIAWcYJohYl+IenN+4TdhNbwIDAQABoyMwITAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAYnqA6jWOiYYt
F98rImECWU0dl0kS7p8XCgRB7vLAkSFfM1G2JEQjzKwuPQX/kFwOajt4MlNg+uwm
KG9kFIUEqAk3EXmoOMXwBhK+mGS5RCpU9Cbctcin2y9E4fKxzG78n0WBb1Fi19+h
RuJmc9ooplPQlp//Yw5KXNdWr+k/rFp3JBFsIBbewYpH1gG6nW9BrBrPzyAc18Bi
NDdv38Bqkoj9ErOdpAwMpPt43N03Z3o+WRuWpA9gApd3ayVBW6ixCjeQUiIjvC4R
YTemAYm+TNbU6zN38ETN354XG0NkDdFYiZvtM0YSW870BWCy9RUd4NffjzoowECE
V6MoZ4leqg==
-----END CERTIFICATE-----

EOF

    kubectl config set-cluster k8s2.oyorooms.io \
    --certificate-authority=${HOME}/.kube/certs/k8s2.oyorooms.io/k8s-ca.crt \
    --server=https://api.k8s2.oyorooms.io

    pbpaste | sh

    kubectl config set-context shubhankit.bansal1-k8s2.oyorooms.io \
    --cluster=k8s2.oyorooms.io \
    --user=shubhankit.bansal1-k8s2.oyorooms.io

    kubectl config use-context shubhankit.bansal1-k8s2.oyorooms.io

}

function generateDevToken() {
    echo
    echo "Generate kubernetes token for Development"
    echo
    mkdir -p ${HOME}/.kube/certs/dev-k8s.oyorooms.ms/ && cat << EOF > ${HOME}/.kube/certs/dev-k8s.oyorooms.ms/k8s-ca.crt
-----BEGIN CERTIFICATE-----
MIIC0zCCAbugAwIBAgIMFVObldg9iFfnVgPXMA0GCSqGSIb3DQEBCwUAMBUxEzAR
BgNVBAMTCmt1YmVybmV0ZXMwHhcNMTgwOTEwMDkwMjQ1WhcNMjgwOTA5MDkwMjQ1
WjAVMRMwEQYDVQQDEwprdWJlcm5ldGVzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA8CCrsrdqwyRlo01wQluGP5ixlvmJI6ANvedILhWBrmX4BbjsKFAE
HdBeMDqUOM6aAcLGo0GxCt3oROpcqVaHKn0CZXC/QMEckToyRa5yFaxaH2E8OAzJ
cTUNl9G5eiuzBJttC71ApRFM+25SCCMioJkPP6o3PiVb9MvhW+f+h8RBaZXrQl5e
4Jz2jqa0VP70zxfVg9xJBlIvtSnFz1BIv3FpehMuBACZTSdFBvcHLW2Cb6b4mmds
dFxsSZuu0YrTi0nSL9l9y3rzqAzA0xlG/zkYx/Uxpkz2FhtNJY9rYLjUnA2PyTkR
xdLTP/CrOHAMmIaRNyfrEFInQFs8RmOA5wIDAQABoyMwITAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAW4LOw2389Jox
tmS/DMOG5dbTf3LIPzkAC93ujLSy5qkE0kuQluPef+bITuPz4QUo64BJvTNHmInh
qKz71Ajjn2tKKiWAP4j4gAfkD3hWPVO8pTK+NQjXpXcFWUD6tm8t5S2uYn5MkHYb
DP/CPWw5utUYNt9QGNwIHoTj4bOCKZfglU8Rg83LAoI4qPnT/fUKQGEbwD2DlxYS
ohBI0DiGzS4cYYQ1h6p2D3LcjjRlFB3P9g9oaKn4mi+4yVFW5yG8jubPvSqfVaaq
a+2AHAtW2Uy7tCLT/78L1uFf0OgE1+OrMHnuDWs7cg3W5Hn5YwZ4Nayn0dkRZGll
+Oib88UfZw==
-----END CERTIFICATE-----

EOF

    kubectl config set-cluster dev-k8s.oyorooms.ms \
    --certificate-authority=${HOME}/.kube/certs/dev-k8s.oyorooms.ms/k8s-ca.crt \
    --server=https://api.dev-k8s.oyorooms.ms

    pbpaste | sh

    kubectl config set-context shubhankit.bansal1-dev-k8s.oyorooms.ms \
    --cluster=dev-k8s.oyorooms.ms \
    --user=shubhankit.bansal1-dev-k8s.oyorooms.ms

    kubectl config use-context shubhankit.bansal1-dev-k8s.oyorooms.ms

}

function portForward() {
    echo
    echo "Command for port forward:"
    echo "COMMAND => kubectl port-forward $(pbpaste) 3000:8081 -n ${1:-hmsexp}"
    echo
    kubectl port-forward $(pbpaste) 3000:8081 -n ${1:-hmsexp}
}

function describePod() {
    echo 
    echo "Command for describe pod"
    echo "COMMAND => kubectl describe pod $(pbpaste) -n ${1:-hmsexp}"
    echo
    kubectl describe pod $(pbpaste) -n ${1:-hmsexp}
}
