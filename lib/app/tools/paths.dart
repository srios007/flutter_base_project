class Paths {
  factory Paths() {
    return _instance;
  }

  Paths._();
  static final Paths _instance = Paths._();

  // Datos estaticos

  static String images = "assets/images";
  static String icons = "assets/icons";
  static String data = "assets/data";
  static String rive = "assets/rive/";

  // Rutas de firebase
  final usersCollection = "Users";
  final metadataCollection = "Metadata";
  final branchesCollection = "Branches";
  final invitationsCollection = "Invitations";
  final lockersCollection = "Lockers";
  final warehousesCollection = "Warehouses";
  final loadsCollection = "Loads";
  final invoiceCollection = "Invoices";
  final loadLogsCollection = "LoadLogs";
  final guidesCollection = "Guides";
  final massiveLogsCollection = "MassiveLogs";
  final inquiriesCollection = "Inquiries";
  final ordersCollection = "Orders";
  final couponsCollection = "Coupons";
  final paymentsCollection = "Payments";
  final quotesCollection = "Quotes";
  final shippingsCollection = "Shippings";

  // Imágenes
  final String logo = "https://firebasestorage.googleapis.com/";
}

Paths paths = Paths();
