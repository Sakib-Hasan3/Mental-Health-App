// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  // 📁 Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // 📂 Collection references (Firestore এ "টেবিল" এর মতো)
  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference get _mentorsCollection => _firestore.collection('mentors');
  CollectionReference get _appointmentsCollection => _firestore.collection('appointments');
  CollectionReference get _chatMessagesCollection => _firestore.collection('chat_messages');
  
  // 👤 ইউজার সেভ করা
  Future<void> saveUser(UserModel user) async {
    await _usersCollection.doc(user.id).set(user.toMap());
  }
  
  // 👤 ইউজারের ডাটা পড়া
  Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot doc = await _usersCollection.doc(userId).get();
    
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
  
  // 👨‍🏫 সব মেন্টরদের লিস্ট আনা
  Stream<QuerySnapshot> getAllMentors() {
    return _mentorsCollection
        .where('isVerified', isEqualTo: true) // শুধু verified mentor
        .orderBy('rating', descending: true) // rating অনুযায়ী সাজানো
        .snapshots(); // real-time updates
  }
  
  // 📅 অ্যাপয়েন্টমেন্ট বুক করা
  Future<void> bookAppointment({
    required String userId,
    required String mentorId,
    required DateTime dateTime,
    required String sessionType,
  }) async {
    await _appointmentsCollection.add({
      'userId': userId,
      'mentorId': mentorId,
      'dateTime': Timestamp.fromDate(dateTime),
      'sessionType': sessionType, // '30min', '45min', '60min'
      'status': 'pending', // pending, confirmed, completed, cancelled
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
  // 💬 চ্যাট মেসেজ সেভ করা
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String message,
  }) async {
    await _chatMessagesCollection.doc(chatId).collection('messages').add({
      'senderId': senderId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }
  
  // 💬 রিয়েল-টাইম চ্যাট মেসেজ পড়া
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _chatMessagesCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}