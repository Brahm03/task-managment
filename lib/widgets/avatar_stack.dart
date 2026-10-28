import 'package:flutter/material.dart';
import 'package:task_managment/providers/project_provider.dart';

/// Overlapping round avatars ("People working" in the design).
class AvatarStack extends StatelessWidget {
  final List<Person> people;
  final double size;
  final double step;

  const AvatarStack(
      {super.key, required this.people, this.size = 30, this.step = 20});

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) return SizedBox(height: size);
    return SizedBox(
      height: size,
      width: size + step * (people.length - 1),
      child: Stack(
        children: [
          for (int i = 0; i < people.length; i++)
            Positioned(left: step * i, child: Avatar(person: people[i], size: size)),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final Person person;
  final double size;

  const Avatar({super.key, required this.person, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: size * 0.02),
        image: DecorationImage(
            image: AssetImage(person.image), fit: BoxFit.cover),
      ),
    );
  }
}
