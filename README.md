For the seek of clarity and trying to ilustrate my usual process to approach a development and tackel different phases you can find that I have divided the development in 3 PRs.
First, for the rover's class, and second, for the plateau's one. Both are covering the "happy path" assuming that no invalid input was going to be provided.
The third PR tries to cover the basic use cases for validation, assuming that the input provided could be poluted with invalid characters and/or wrong coordinates.

TO DO:
I am not super happy with the all the content in the last PR. Test are green :) but code could be cleaner and doesn't feels good that the MarsRover's class deals with the responsability of knowing where are the other deployed rovers in order to prevent collisions.

For running the tests provided, you will need the Minitest gem. Open a
terminal window and run the following command to install minitest:

    gem install minitest
Or:
    bundle install

If you would like color output, you can `require 'minitest/pride'` in
the test file, or note the alternative instruction, below, for running
the test file.

In order to run the test, you can run the test file from the mars_rover
directory. Running the following command:

    ruby mars_rover_test.rb
    ruby plateau_test.rb

