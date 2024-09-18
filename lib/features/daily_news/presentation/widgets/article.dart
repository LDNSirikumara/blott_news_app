import 'package:blott_app/config/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  final String? source;
  final String? date;
  final String? title;
  final String? imgUrl;
  final String? url;
  const Article({
    super.key,
    this.source,
    this.date,
    this.title,
    this.imgUrl,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.primary,
        onTap: _onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          height: 132,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(context),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _source(),
                          _date(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _title(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imgUrl ?? '',
        imageBuilder: (context, imageProvider) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.08), image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const CupertinoActivityIndicator(),
                ),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                ),
                child: const Icon(Icons.error),
              ),
            ));
  }

  Future<void> _onTap() async {
    final Uri _url = Uri.parse(url ?? '');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget _source() {
    return Text(
      source ?? '',
      style: TextStyle(
        color: AppColors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    );
  }

  Widget _date() {
    return Text(
      date ?? '',
      style: TextStyle(
        color: AppColors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    );
  }

  Widget _title() {
    return Text(
      title ?? '',
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        height: 1.1,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }
}
