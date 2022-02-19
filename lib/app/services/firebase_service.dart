import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  var firestore =  FirebaseFirestore.instance;

  /// Obtiene todos los registros de una coleccion
  Future<QuerySnapshot> getData(String collection) {
    return firestore.collection(collection).get();
  }

  /// Obtiene el stream de una coleccion
  Stream<QuerySnapshot> getCollectionSnapshot(String collection) {
    return firestore.collection(collection).snapshots();
  }

  /// Obtiene un documento dentro de una coleccion median su ID
  Future<QuerySnapshot> getDataById(String documentId, String collection) {
    return firestore
        .collection(collection)
        .where('uid', isEqualTo: documentId)
        .get();
  }

  /// Guarda un documento dentro de una coleccion
  Future<bool> save(Map<String, dynamic> document, String collection) async {
    try {
      String _documentId = document['id'];

      if (_documentId != null) {
        firestore.collection(collection).doc(_documentId).set(document);
        return true;
      } else {
        String _id = createId(collection);
        firestore.collection(collection).doc(_id).set({'id': _id, ...document});
        return true;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /// Actualiza un documento ([data] debe ir en formato json {})
  Future updateDocument(documentID, data, collection) {
    return firestore.doc('$collection/$documentID').update(data);
  }

  /// Borra un documento de una coleccion
  deleteDocument(documentId, collection) {
    return firestore.collection(collection).doc(documentId)..delete();
  }

  /// Crea un id único en firebase
  createId(collection) {
    CollectionReference _collRef = firestore.collection(collection);
    DocumentReference _docReferance = _collRef.doc();
    return _docReferance.id;
  }

  /// Obtiene la referencia de un documento
  DocumentReference getDocumentReference({
    required String collection,
    required String documentId,
  }) {
    return firestore.collection(collection).doc(documentId);
  }

  /// Retorna un documento dado su id y en que coleccion se encuentra
  Future<DocumentSnapshot> getDocument(documentId, collection) {
    return firestore.collection(collection).doc(documentId).get();
  }

  /// Obtiene el stream de una coleccion pero filtrada
  Stream<QuerySnapshot> getCollectionSnapshotQuery(
    String collection,
    String property,
    String equal,
  ) {
    return firestore
        .collection(collection)
        .where(property, isEqualTo: equal)
        .snapshots();
  }

  /// Obtiene una coleccion con un parametro de filtrado
  Future<QuerySnapshot> getCollection(
    String collection,
    String property,
    dynamic equal,
  ) {
    if (property != null) {
      return firestore
          .collection(collection)
          .where(property, isEqualTo: equal)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  /// Obtiene una coleccion con una query custom
  Future<QuerySnapshot> getCollectionCustomQuery(Query query) {
    return query.get();
  }

  /// Obtiene el stream de una coleccion pero ordenada
  Stream<QuerySnapshot> getOrderedCollectionSnapshot(
    String collection,
    property,
    bool desc,
  ) {
    return firestore
        .collection(collection)
        .orderBy(property, descending: desc)
        .snapshots();
  }

  /// Obtiene la siguiente subsecuencia de datos dad una coleccion
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshot(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot lastDocument,
    String filterProperty,
    dynamic filterValue,
  ) async {
    if (filterProperty == null || filterValue == null) {
      var _pageUserQuery = firestore
          .collection(collection)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(lastDocument);
      }

      return await _pageUserQuery.get();
    } else {
      var _pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(lastDocument);
      }

      return await _pageUserQuery.get();
    }
  }

  Future<QuerySnapshot> getNextQuerySnapshot(
    DocumentSnapshot lastDocument,
    Query query,
  ) async {
    var _pageQuery = query;

    if (lastDocument != null) {
      _pageQuery = _pageQuery.startAfterDocument(lastDocument);
    }

    return await _pageQuery.get();
  }

  /// Obtiene la anteriror subsecuencia de datos dada una coleccion
  Future<QuerySnapshot> getBackPaginatedCollectionSnapshot(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot lastDocument,
    DocumentSnapshot firtsDocument,
    String filterProperty,
    dynamic filterValue,
  ) async {
    if (filterProperty == null || filterValue == null) {
      var _pageUserQuery = firestore
          .collection(collection)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(firtsDocument);
      }

      return await _pageUserQuery.get();
    } else {
      var _pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(firtsDocument);
      }

      return await _pageUserQuery.get();
    }
  }

  /// Obtiene el stream de una coleccion
  Stream<DocumentSnapshot> getCollectionByIDSnapshot(
    String collection,
    String id,
  ) {
    return firestore.collection(collection).doc(id).snapshots();
  }

  /// Guarda un documento dentro de una coleccion con un id custom
  Future<bool> saveWithCustomId(
    Map<String, dynamic> document,
    String collection,
    String customId,
  ) async {
    try {
      CollectionReference collRef = firestore.collection(collection);
      DocumentReference docReferance = collRef.doc(customId);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .set({'id': customId, ...document});
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}

final Database database = Database();
