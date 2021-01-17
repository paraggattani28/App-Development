import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project3/models/stayfit_users.dart';
import 'package:project3/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  Future<void> updateUserData(String email, String mobile, String address,
      String username, String imageLink, bool register) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'mobile': mobile,
      'address': address,
      'username': username,
      'imageLink': imageLink,
      'register': register,
    });
  }

  Stream<QuerySnapshot> get user {
    return userCollection.snapshots();
  }

  Future deleteuser() {
    return userCollection.document(uid).delete();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        email: snapshot.data['email'],
        username: snapshot.data['username'],
        mobile: snapshot.data['mobile'],
        address: snapshot.data['address'],
        imageLink: snapshot.data['imageLink'],
        register: snapshot.data['register']);
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  final CollectionReference userVideoDocument =
      Firestore.instance.collection('userVideo');
  Future<void> updateYogaData(
      String title, String details, String videoLink) async {
    return await userVideoDocument.document(uid).collection('yoga_videos').add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get yogaData {
    return userVideoDocument
        .document(uid)
        .collection('yoga_videos')
        .snapshots();
  }

  Future<void> updateKarateData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('karate_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get karateData {
    return userVideoDocument
        .document(uid)
        .collection('karate_videos')
        .snapshots();
  }

  Future<void> updateJudoData(
      String title, String details, String videoLink) async {
    return await userVideoDocument.document(uid).collection('judo_videos').add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get judoData {
    return userVideoDocument
        .document(uid)
        .collection('judo_videos')
        .snapshots();
  }

  Future<void> updateAkhadaData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('akhada_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get akhadaData {
    return userVideoDocument
        .document(uid)
        .collection('akhada_videos')
        .snapshots();
  }

  Future<void> updateCardioData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('cardio_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get cardioData {
    return userVideoDocument
        .document(uid)
        .collection('cardio_videos')
        .snapshots();
  }

  Future<void> updateCircuitData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('circuit_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get circuitData {
    return userVideoDocument
        .document(uid)
        .collection('circuit_videos')
        .snapshots();
  }

  Future<void> updateCrossfitData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('crossfit_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get crossfitData {
    return userVideoDocument
        .document(uid)
        .collection('crosffit_videos')
        .snapshots();
  }

  Future<void> updateResistanceData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('resistance_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get resistanceData {
    return userVideoDocument
        .document(uid)
        .collection('resistance_videos')
        .snapshots();
  }

  Future<void> updateZumbaData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('zumba_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get zumbaData {
    return userVideoDocument
        .document(uid)
        .collection('zumba_videos')
        .snapshots();
  }

  Future<void> updateHiitData(
      String title, String details, String videoLink) async {
    return await userVideoDocument.document(uid).collection('hiit_videos').add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get hiitData {
    return userVideoDocument
        .document(uid)
        .collection('hiit_videos')
        .snapshots();
  }

  Future<void> updateFlexibilityData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('flexibility_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get flexibilityData {
    return userVideoDocument
        .document(uid)
        .collection('flexibility_videos')
        .snapshots();
  }

  Future<void> updateStrengthData(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document(uid)
        .collection('strength_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get strengthData {
    return userVideoDocument
        .document(uid)
        .collection('strength_videos')
        .snapshots();
  }
  // final CollectionReference karateDocument =
  //     Firestore.instance.collection('karate');
  // Future<void> updateKarateData(
  //     String title, String details, String videoLink) async {
  //   return await karateDocument.document(uid).collection('karate_videos').add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get karateData {
  //   return karateDocument.document(uid).collection('karate_videos').snapshots();
  // }

  // final CollectionReference judoDocument =
  //     Firestore.instance.collection('judo');
  // Future<void> updateJudoData(
  //     String title, String details, String videoLink) async {
  //   return await judoDocument.document(uid).collection('judo_videos').add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get judoData {
  //   return judoDocument.document(uid).collection('judo_videos').snapshots();
  // }

  // final CollectionReference akhadaDocument =
  //     Firestore.instance.collection('akhada');
  // Future<void> updateAkhadaData(
  //     String title, String details, String videoLink) async {
  //   return await akhadaDocument.document(uid).collection('akhada_videos').add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get akhadaData {
  //   return akhadaDocument.document(uid).collection('akhada_videos').snapshots();
  // }

  // final CollectionReference cardioDocument =
  //     Firestore.instance.collection('cardio');
  // Future<void> updateCardioData(
  //     String title, String details, String videoLink) async {
  //   return await cardioDocument.document(uid).collection('cardio_videos').add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get cardioData {
  //   return cardioDocument.document(uid).collection('cardio_videos').snapshots();
  // }

  // final CollectionReference circuitDocument =
  //     Firestore.instance.collection('circuit');
  // Future<void> updateCircuitData(
  //     String title, String details, String videoLink) async {
  //   return await circuitDocument
  //       .document(uid)
  //       .collection('circuit_videos')
  //       .add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get circuitData {
  //   return circuitDocument
  //       .document(uid)
  //       .collection('circuit_videos')
  //       .snapshots();
  // }

  // final CollectionReference crossfitDocument =
  //     Firestore.instance.collection('crossfit');
  // Future<void> updateCrossfitData(
  //     String title, String details, String videoLink) async {
  //   return await crossfitDocument
  //       .document(uid)
  //       .collection('crossfit_videos')
  //       .add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get crossfitData {
  //   return crossfitDocument
  //       .document(uid)
  //       .collection('crossfit_videos')
  //       .snapshots();
  // }

  // final CollectionReference resistanceDocument =
  //     Firestore.instance.collection('resistance');
  // Future<void> updateResistanceData(
  //     String title, String details, String videoLink) async {
  //   return await resistanceDocument
  //       .document(uid)
  //       .collection('resistance_videos')
  //       .add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get resistanceData {
  //   return resistanceDocument
  //       .document(uid)
  //       .collection('resistance_videos')
  //       .snapshots();
  // }

  // final CollectionReference zumbaDocument =
  //     Firestore.instance.collection('zumba');
  // Future<void> updateZumbaData(
  //     String title, String details, String videoLink) async {
  //   return await zumbaDocument.document(uid).collection('zumba_videos').add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get zumbaData {
  //   return zumbaDocument.document(uid).collection('zumba_videos').snapshots();
  // }

  // final CollectionReference hiitDocument =
  //     Firestore.instance.collection('hiit');
  // Future<void> updateHiitData(
  //     String title, String details, String videoLink) async {
  //   return await hiitDocument.document(uid).collection('hiit_videos').add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get hiitData {
  //   return hiitDocument.document(uid).collection('hiit_videos').snapshots();
  // }

  // final CollectionReference flexibilityDocument =
  //     Firestore.instance.collection('flexibility');
  // Future<void> updateFlexibilityData(
  //     String title, String details, String videoLink) async {
  //   return await flexibilityDocument
  //       .document(uid)
  //       .collection('flexibility_videos')
  //       .add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get flexibilityData {
  //   return flexibilityDocument
  //       .document(uid)
  //       .collection('flexibility_videos')
  //       .snapshots();
  // }

  // final CollectionReference strengthDocument =
  //     Firestore.instance.collection('strength');
  // Future<void> updateStrengthData(
  //     String title, String details, String videoLink) async {
  //   return await strengthDocument
  //       .document(uid)
  //       .collection('strength_videos')
  //       .add({
  //     'title': title,
  //     'details': details,
  //     'videoLink': videoLink,
  //   });
  // }

  // Stream<QuerySnapshot> get strengthData {
  //   return strengthDocument
  //       .document(uid)
  //       .collection('strength_videos')
  //       .snapshots();
  // }
}

class DatabaseHome {
  final CollectionReference userVideoDocument =
      Firestore.instance.collection('homeVideo');
  Future<void> updateYogaDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('yoga')
        .collection('yoga_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get yogaData {
    return userVideoDocument
        .document('yoga')
        .collection('yoga_videos')
        .snapshots();
  }

  Future<void> updateKarateDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('karate')
        .collection('karate_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get karateData {
    return userVideoDocument
        .document('karate')
        .collection('karate_videos')
        .snapshots();
  }

  Future<void> updateJudoDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('judo')
        .collection('judo_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get judoData {
    return userVideoDocument
        .document('judo')
        .collection('judo_videos')
        .snapshots();
  }

  Future<void> updateAkhadaDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('akhada')
        .collection('akhada_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get akhadaData {
    return userVideoDocument
        .document('akhada')
        .collection('akhada_videos')
        .snapshots();
  }

  Future<void> updateCardioDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('cardio')
        .collection('cardio_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get cardioData {
    return userVideoDocument
        .document('cardio')
        .collection('cardio_videos')
        .snapshots();
  }

  Future<void> updateCircuitDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('circuit')
        .collection('circuit_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get circuitData {
    return userVideoDocument
        .document('circuit')
        .collection('circuit_videos')
        .snapshots();
  }

  Future<void> updateCrossfitDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('crossfit')
        .collection('crossfit_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get crossfitData {
    return userVideoDocument
        .document('crossfit')
        .collection('crosffit_videos')
        .snapshots();
  }

  Future<void> updateResistanceDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('resistance')
        .collection('resistance_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get resistanceData {
    return userVideoDocument
        .document('resistance')
        .collection('resistance_videos')
        .snapshots();
  }

  Future<void> updateZumbaDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('zumba')
        .collection('zumba_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get zumbaData {
    return userVideoDocument
        .document('zumba')
        .collection('zumba_videos')
        .snapshots();
  }

  Future<void> updateHiitDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('hiit')
        .collection('hiit_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get hiitData {
    return userVideoDocument
        .document('hiit')
        .collection('hiit_videos')
        .snapshots();
  }

  Future<void> updateFlexibilityDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('flexibility')
        .collection('flexibility_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get flexibilityData {
    return userVideoDocument
        .document('flexibility')
        .collection('flexibility_videos')
        .snapshots();
  }

  Future<void> updateStrengthDataHome(
      String title, String details, String videoLink) async {
    return await userVideoDocument
        .document('strength')
        .collection('strength_videos')
        .add({
      'title': title,
      'details': details,
      'videoLink': videoLink,
    });
  }

  Stream<QuerySnapshot> get strengthData {
    return userVideoDocument
        .document('strength')
        .collection('strength_videos')
        .snapshots();
  }
}
