String timeAgo(String dateString) {
  if (dateString.isEmpty) return '';
  final date = DateTime.tryParse(dateString);
  if (date == null) return '';

  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inSeconds < 0) return 'Just now';
  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes == 1) return '1 min ago';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours == 1) return '1 hour ago';
  if (diff.inHours < 24) return '${diff.inHours} hours ago';
  if (diff.inDays == 1) return 'Yesterday';
  if (diff.inDays < 7) return '${diff.inDays} days ago';
  if (diff.inDays < 14) return '1 week ago';
  if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} weeks ago';
  if (diff.inDays < 60) return '1 month ago';
  return '${(diff.inDays / 30).floor()} months ago';
}
