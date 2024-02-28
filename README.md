# Sveta
A program that finds the matching piece of clothes to complete your style

my email: anastasia@phiskills.com

video-explanation: https://youtu.be/lG5kgUMmZvs

Google_collab: https://colab.research.google.com/drive/1wG141iCm7_vvQmsIwiyUhkW6hSJ1lzhQ?usp=sharing


## Idea

The idea of my project was to create a program that finds the matching piece of clothes to complete your style, shows you similar to your items, products and so on. And I called it Sveta.

## Data

As there is no data yet, I needed to start from scratch. So, we need to find where and how to get it. For that, I used Shopify - one of the most used e-commerce platforms. The advantage of this platform is that you can easily scrap the data from many brands that use Shopify. As they use a common platform, there is always the same structure of the data, which makes work easier.

The first notebook to collect the data that I’ll use for my machine learning - is Elixir Livebook. It has a lot of advantages: very easy tools to scrap, built-in functions to manipulate data and generate apis to save data. It was much faster with this than with Python. One of the cool features of Elixir livebook is the smart cells that allow you access to complex features without any need to code them, such as db, requests or data viz.

As each Shopify store puts the information about the product in different places there’s no common rule, so for that, I need to extract the information.

## Data vis

And the best way is to use the idea of a search engine. For that, I grouped relevant sources of information like product_id and title, and in the case of details, I grouped them into title, product_type, and tags after that, I can use this to extract common keywords such as gender, colour and so on.

Here I built my pipeline using a pipe operator where each function's result is the next function's argument. I'm using the function of enum module to count all the words that are in every description of products(направить мышку на любую функцию, чтобы продемонстрировать сразу документацию)

With this smart cell, we can easily make a graph of all the counted words, and by looking at it, I started to decide which classes are better to take.

## Clean Data

So, after deciding what classes to make I created filters to extract classes. After extracting putting it into df.

After picking up classes I was curious to see what was the frequency of the genders for each of the classes. That’s how, for example, all blazers, polo and trousers that we had were for men. But also, you can see from this diagram that there are different images for each type of clothes. So, we can start building a model when we already have our images and classes.

## API

For building API, I used Phoenix, which generates API without coding plus creating databases.

## ML

For my api_url, I used ngrok - a cross-platform application that enables developers to expose a local development server to the Internet with minimal effort. For that you need to create an account, and after can start it easily with terminal.

So, we request our api and check how many elements do we have. Now we can create a folder images, that is going to make another folders inside according to the categories that I defined earlier. And with a counter, it will make an index for an image.

Load our data into the model using the image data off the disk with tf.keras.utils.image_dataset_from_directory, which will generate a tf.data.Dataset.

We need to define some parameters for the loader. 

And for developing the model, we’ll use a validation split: 80% of the images for training and 20 - for validation.

We can find the class names in the class_names attribute on these datasets. These correspond to the directory names in alphabetical order.

As TensorFlow Hub's convention for image models is to expect float inputs in the [0, 1] range, we should use the tf.keras.layers.Rescaling the preprocessing layer to achieve this.

We should finish the input pipeline by using buffered prefetching with Dataset.prefetch, so we can yield the data from disk without I/O blocking issues. Dataset.cache keeps the images in memory after they're loaded off the disk during the first epoch. This will ensure the dataset does not become a bottleneck while training your model.

Here I selected a MobileNetV2 pre-trained model from TensorFlow Hub and wrapped it as a Keras layer. Then we pass train ds to the model. The result is a 1001-element vector of logits, rating the probability of each class for the image.

Now we need to decode the predictions with ImageNetLabels. ImageNet is a research training dataset with a wide variety of categories.

With this code, we can check how these predictions align with the images. As we see the results are far from perfect, but at the same time it's understandable as all these classes are not the one that the model was trained on.

TensorFlow Hub also distributes models without the top classification layer. These can be used to easily perform transfer learning.

Next I created the feature extractor by wrapping the pre-trained model as a Keras layer with hub.KerasLayer. And used the trainable=False argument to freeze the variables, so that the training only modifies the new classifier layer.

The feature extractor returns a 1280-long vector for each image (the image batch size remains at 32 in this example).

To complete the model, I wrapped the feature extractor layer in a tf.keras.Sequential model and added a fully-connected layer for classification.

## For training the model …

During its training process, it’s important to take into consideration such a value as accuracy. In simple words, it’s a way of assessing the performance of a model, where accuracy means the number of classifications a model correctly predicts divided by the total number of predictions made. And according to my model it was 0.96 -which is very good.

To check the predictions I obtained the ordered list of class names from the model predictions. And now we should plot the model predictions to visually see the result. According to this we can say that our model predicted all the labels correctly

Now we need to export our trained model as a SavedModel for reusing it later. Confirm that we can reload the SavedModel and that the model is able to output the same results.

The most important thing about this model building is to know if our model just learned all the images by heart or if it really understood the differences between all the images. For that, I took a random link to the clothes picture and put it into our model.

To say a few words about my future plans according to this project. As now this app is mostly B2C so that next steps would be
I want to improve my model so it can detect images better for multiple categories.
I would like to implement segmentation to apply to looks so it can either complete your outfit or provide wardrobe extension ideas.
Create a mobile app for the easy use of Sveta’s help. For starters, I was thinking that a person would be able to add a picture of his clothes. Then Sveta will propose to him different variants of how she can help.
After all that, I was planning to make a Shopify app out of it that completes product information with feature extraction from the images. So that’s how this product can target not only B2C but also B2B.

