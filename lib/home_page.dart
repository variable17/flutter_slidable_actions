import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './caredose_icons_icons.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _DoseItem {
  const _DoseItem(
    this.index,
    this.date,
    this.foodDirection,
    this.medicinesDetail,
  );

  final int index;
  final String date;
  final String foodDirection;
  final List<String> medicinesDetail;
}

class _MyHomePageState extends State<MyHomePage> {
  SlidableController slidableController;
  final List<_DoseItem> items = List.generate(
    20,
    (i) => _DoseItem(
          i,
          '2019-12-01',
          'No Direction',
          [
            '1 Tab Crocin Cold N Flue 03/19',
            '1 Tab Crocin Cold N Flue 03/19',
            '1 Tab Crocin Cold N Flue 03/19',
            '1 Tab Crocin Cold N Flue 03/19',
            '1 Tab Crocin Cold N Flue 03/19',
            '1 Tab Crocin Cold N Flue 03/19',
          ],
        ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _buildList(context, Axis.vertical)),
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        return _getSlidableWithDelegates(context, index, Axis.horizontal);
      },
      itemCount: items.length,
    );
  }

  Widget _getSlidableWithDelegates(
      BuildContext context, int index, Axis direction) {
    final _DoseItem item = items[index];

    return Slidable.builder(
      key: Key(item.index.toString()),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dimiss Delete');
          setState(() {
            items.removeAt(index);
          });
        },
      ),
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.15,
      child: VerticalListItem(items[index]),
      secondaryActionDelegate: SlideActionBuilderDelegate(
          actionCount: 3,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                color: renderingMode == SlidableRenderingMode.slide
                    ? Color(0xff3bac30).withOpacity(animation.value)
                    : Color(0xff3bac30),
                iconWidget: Text(
                  'Taken',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () => _showSnackBar(context, 'More'),
                closeOnTap: false,
              );
            } else if (index == 1) {
              return IconSlideAction(
                color: renderingMode == SlidableRenderingMode.slide
                    ? Color(0xfff8bc45).withOpacity(animation.value)
                    : Color(0xfff8bc45),
                iconWidget: Text(
                  'Late',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () => _showSnackBar(context, 'More'),
                closeOnTap: false,
              );
            } else {
              return IconSlideAction(
                color: renderingMode == SlidableRenderingMode.slide
                    ? Color(0xffff8c8c).withOpacity(animation.value)
                    : Color(0xffff8c8c),
                iconWidget: Text(
                  'Missed',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () => _showSnackBar(context, 'More'),
                closeOnTap: false,
              );
            }
          }),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);

  final _DoseItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(item.date),
        children: <Widget>[
          Container(
            child: Text('Body'),
          )
        ],
        trailing: Icon(
          CaredoseIcons.morning,
          size: 30,
        ),
      ),
    );
  }
}
