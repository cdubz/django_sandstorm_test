1. Set up app and start dev server

        git clone git@github.com:cdubz/django_sandstorm_test.git
        cd django_sandstorm_test
        vagrant-spk vm up
        vagrant-spk dev
        
1. Visit [http://local.sandstorm.io:6080/](http://local.sandstorm.io:6080/),
create grain, and test login with username `admin` and password `admin`. Confirm
form submits successfully.

1. Pack SPK

        vagrant-spk pack ~/django_sandstorm_test.spk
        
1. Install on Sandstorm server with HTTPS and test login again. Confirm form
submit fails with "Referer checking failed - no Referer." error.

1. Fix it :man_shrugging:
