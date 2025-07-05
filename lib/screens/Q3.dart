import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // BUG 1: 'selectedUser' was declared as non-nullable without initialization
  // String selectedUser;

  // FIX: Make it nullable to avoid LateInitializationError
  String? selectedUser;

  // BUG 4: Using a single list ('users') for both display and data mutations caused search to permanently alter data
  // List<String> users = ['Alice', 'Bob', 'Charlie', 'Diana'];

  // FIX: Use separate lists for full data and filtered view
  List<String> allUsers = ['Alice', 'Bob', 'Charlie', 'Diana'];
  List<String> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    // FIX: Initialize the filtered list from the master list
    filteredUsers = List.from(allUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: searchUsers,
              decoration: InputDecoration(
                hintText: 'Search users...',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Selected User Display
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              // BUG 1 CONTINUED: Accessing 'selectedUser.toUpperCase()' caused null crash if no selection
              // 'Selected: ${selectedUser.toUpperCase()}'

              // FIX: Check if selectedUser is null first
              selectedUser != null
                  ? 'Selected: ${selectedUser!.toUpperCase()}'
                  : 'No user selected',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // User List
          // BUG 2: ListView.builder inside Column without height constraint causes runtime exception
          // ListView.builder(...)

          // FIX: Wrap ListView in Expanded to give it a bounded height
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredUsers[index]),
                  onTap: () {
                    setState(() {
                      selectedUser = filteredUsers[index];
                    });
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        // BUG 6: If selected user was deleted, it still remained selected
                        // No check for selectedUser when deleting

                        // FIX: Clear selection if it's the one being deleted
                        if (selectedUser == filteredUsers[index]) {
                          selectedUser = null;
                        }

                        // BUG 4 CONTINUED: Mutation to filtered list affects original data
                        // users.removeAt(index);

                        // FIX: Remove from master list instead
                        allUsers.remove(filteredUsers[index]);

                        // Refresh filtered list after deletion
                        searchUsers('');
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // BUG 3: FloatingActionButton was wrongly placed inside Column, which breaks layout
      // FloatingActionButton(
      //   onPressed: () => addUser(),
      //   child: Icon(Icons.add),
      // ),

      // FIX: Use the scaffold's floatingActionButton property
      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        child: Icon(Icons.add),
      ),
    );
  }

  // Search Function
  void searchUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(allUsers);
      } else {
        filteredUsers = allUsers
            .where((user) => user.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  //Add New User
  void addUser() {
    setState(() {
      String newUser = 'New User ${allUsers.length + 1}';
      allUsers.add(newUser);
      //  Re-apply search to reflect changes
      searchUsers('');
    });
  }
}
