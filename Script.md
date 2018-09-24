So let's quick look at the project

Overhere i have a folder WWDC, which include all of the code files, storyboard, as well as configuration and image resources

I already grouped business logic classes together and put them into a folder

Then we have a folder for UnitTests which has some tests for model serialization, as well as view model and utility class.

So let's try to run and see the result.

As you can see, this is just a simple app which will display some WWDC videos on the screen. And when you touch on any video it will open the player and start playing that video.

It is able to select a suitable subtitle language for you as well, just over here.

So okay, this kind of app is very suitable with Apple TV. Because initially we used TV to watch video, but now for convinience we are using mobile phone to watch, but of course watching on tv will bring you better experience and more enjoyable. 

And now i will show you how build an Apple TV app on the project i have shown not long time ago.

So i will start by adding a new target, and to distinguish with iOS i will name it WWDC_tvOS. 

As you can see here, Xcode creates 2 folders, one is WWDC_tvOS for Apple TV app logic. Actually you can put Apple TV code anywhere but better to clarify and put it only here.

Another one is WWDC_tvOSTests for unit tests particularly for tvOS.

Let's try to make a run. Here you can see we have 2 options, one is WWDC for iOS and the another one is WWDC_tvOS for Apple TV. I will run on the second scheme.

Oops. It run successfully already. On the screen is an Apple TV simulator. It's all white because we did not add anything to it.

Let's start adding some to them

Because i wanna share business logic code to them so i will move it out of WWDC folder. And put it at the same level with WWDC and WWDC_tvOS folder.

Let open the Inspector bar. Over here you see these files is only marked for iOS target. Now i will add it to tvOS target as well. 

Let's make a run and see

It fails because there is no such framework SwiftyJSON found. It's good because it demonstrate that now the compiler received those files as input source code. 

Let's try to add dependencies to tvOS target

I can just simply add dependencies like this, but it's not a good idea to keep repeating codes like that. Instead i will make a function to add all shared pods and will call it in each target

Nice. Once again it compiles successfully