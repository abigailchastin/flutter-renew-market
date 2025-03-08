import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants/app_theme.dart';
import 'package:flutter_application/datas/mock_post.dart';
import 'package:flutter_application/models/post_model.dart';
import 'package:flutter_application/widgets/custom_input_field.dart';
import 'package:image_picker/image_picker.dart';


class PostAploudScreen extends StatefulWidget {
  @override
  _PostAploudScreenState createState() => _PostAploudScreenState();
}

class _PostAploudScreenState extends State<PostAploudScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _selectedImage; // To store the picked image


  // Method to pick an image
  Future<void> _pickImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _selectedImage = photo;
      });
    }
  }
  void _addPost() {
  if (_formKey.currentState!.validate()) {
    final newPost = PostModel(
  postId: 'post_${mockPosts.length + 1}',
  title: titleController.text,
  description: descriptionController.text,
  price: num.tryParse(priceController.text) ?? 0,
  images: [
    'https://raw.githubusercontent.com/devSWF/MicroLearnable-Resources/refs/heads/main/Practical%20Application%20Project/Assets/Images/default_image.png'
  ],
  sellerId: 'user_001',
  sellerName: 'John Doe',
  location: const GeoPoint(37.7749, -122.4194), // 임시 위치 값
  isAvailable: true,
  createdAt: Timestamp.now(),
);
 setState(() {
        mockPosts.add(newPost);
        titleController.clear();
        priceController.clear();
        descriptionController.clear();
        
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully added!')));
  }
}

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo Upload
                Text(
                  "Photo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(
                                File(_selectedImage!.path),
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? Icon(Icons.camera_alt_outlined, color: Colors.black54, size: 40)
                        : null,
                  ),
                ),

                SizedBox(height: 20),

                // Title
                Text(
                  "Title",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                CustomInputField(
                  isnum: false,
                  lines: 1,
                  validatorMessage: 'Title cannot be empty',
                  controller: titleController,
                ),
                SizedBox(height: 20),

                // Price
                Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                CustomInputField(
                  isnum: true,
                  lines: 1,
                  validatorMessage: 'Price cannot be empty',
                  controller: priceController,
                ),
                SizedBox(height: 20),

                // Description
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                CustomInputField(
                  isnum: false,
                  lines: 5,
                  validatorMessage: 'Description cannot be empty',
                  controller: descriptionController,
                ),
                SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                    onPressed: _addPost,
                  child: Text(
                    'Add a Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
