import 'package:assignment_map/screens/add_place.dart';
import 'package:assignment_map/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:assignment_map/providers/user_places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreens extends ConsumerStatefulWidget {
  const PlacesScreens({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreens> {
  late Future<void>
      _placesFuture; //will connect to FutureBuilder in child and Late is used cuz it will give the value in future whenever it is called

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    //WidgetRef ref is no longer pass to build instead ref is now general available property
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesList(
                      places: userPlaces,
                    ),
        ),
        // PlacesList(
        //   places: userPlaces,
        // ),
      ),
    );
  }
}
