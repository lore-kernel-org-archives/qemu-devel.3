Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178ACCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3NjJ-000529-Ca; Mon, 29 Sep 2025 19:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1v3NjI-00051c-G4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1v3NjA-00082r-5V
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759190176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nsdqgWsgOWAFUBvQ3bR49EO/Yc+EpJMv8F9acZTCgM0=;
 b=CulZJThBZ1PgtEIFkJ1Az246n7WHlubcgIsn3JIi+svyhbGlKi1VXPxN2AksoE1j9V/o/9
 uZoaVpXQtIbUt/L19ja4OK/k13ozaDPviPgPs/je0TvR/Oki6B/tC8uO/E3omuchMA6MC+
 B6jz5hjvyjb4wAnmUY+4cP8UhSwqaxw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-ZXiDPXQSPuupjRKnL8c91Q-1; Mon, 29 Sep 2025 19:54:53 -0400
X-MC-Unique: ZXiDPXQSPuupjRKnL8c91Q-1
X-Mimecast-MFC-AGG-ID: ZXiDPXQSPuupjRKnL8c91Q_1759190093
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-859b89cd3f2so1184270585a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759190093; x=1759794893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nsdqgWsgOWAFUBvQ3bR49EO/Yc+EpJMv8F9acZTCgM0=;
 b=CM8taIfpYqtIzvDkxaZrubsUgdswbUeQPa84QvwVAheMvyX8lKxeYONYznEIzvyOLp
 7pEDgXhI5c3DT+SL8ONo0FWMl989JOErdxZXlG9wNru8lcIp+pbfSE2yht/Aj0JRXIWM
 u/7T82ZajldWM9WIYuIdv1Rl9+a3oYCAgldhdiRh+oC8XluqfXDLIK6xvDvm/cOxHL7n
 eXCyYiSilTa6I3NPR9DZrkFzCLn90fHgGtxqgjdh76jC/D1yRt9Do8FPuojtI/AaUTcg
 +qo2oTV7gkdFjHxwyIO8BdfvcHjuY3RFZfQtbm8FadchqxhvI1i7u6RockPx8Rb2EW69
 9lZw==
X-Gm-Message-State: AOJu0YzAaSR/hXQTadYBVRVctSv74eaxeprChJeOQKF2BOTj+pQzbRl+
 +41LwP3CKa1OTFI+/B5m/ysyfoCjJTZQ0TRsmVZcq/Mlukk18gvRO23cp6lYYuNnopYmlSaxjLu
 BR/JJUjEzFeurfACCOcODUowNUAwMVGxl+aB2iJaAg9anGpEpgkdymnlB0XGqliwi0i7mmtoyLk
 xw1DTPI8YXkgZFHO4NIcKpwX+aSZ1PUdBIVdesHGFOLg==
X-Gm-Gg: ASbGncvRSFdT3XErIugSyv9R4yFpmWY90gP/0J21Onm9GL6oY/BcXHoEHUAW87oRlRl
 AuL1Kl7B/ZUntVZehhiF93ERRNxbIFssn7GH6HUmoJ/s9qrXeXrKsP9xL2iEM9vTO2x3PDBFtDi
 w/uaMzk6QWCcm21W2nqMEu5HegGTUZ4bf0jmGrj73c+kHieweyYR8rxzVqFSVkR3RfCuz2cnuZq
 mVwiQuPVOG2WOIn9K2njNb3Ung3TfSd9x0cw1WB2zrXA0QnjtknIUAJEbmdjnbola1B4SG2LPSA
 vzOgerSPEV1uwKKWN1vazweEpwcVoktwiwxRzqoCAjjV4kzVknLjbFV7+5NU57P8yRk10w==
X-Received: by 2002:a05:620a:298f:b0:858:f75a:c922 with SMTP id
 af79cd13be357-85adf5d27cbmr2643621185a.6.1759190093080; 
 Mon, 29 Sep 2025 16:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGguOZg5gCRZ6Hj6TooLH68Rd7o/f3PrbedUQkwS7wBAipA3y22SNEWeF141jCYs7TbZz8kFA==
X-Received: by 2002:a05:620a:298f:b0:858:f75a:c922 with SMTP id
 af79cd13be357-85adf5d27cbmr2643618985a.6.1759190092641; 
 Mon, 29 Sep 2025 16:54:52 -0700 (PDT)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28a8a7e0sm935159385a.22.2025.09.29.16.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 16:54:52 -0700 (PDT)
From: Chandan <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chandan <csomani@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH] block: enable stats-intervals for virtio-blk devs with
 -blockdev
Date: Mon, 29 Sep 2025 16:52:42 -0700
Message-ID: <20250929235244.686567-1-csomani@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch allows the stats-intervals.* flag to be used with
-blockdev. Stats collection is initialized for virtio-blk devices
at their time of creation. However, it is limited to just virtio-blk
devices for now.

Signed-off-by: Chandan <csomani@redhat.com>
---
 block.c                          | 50 ++++++++++++++++++++++++++++++++
 hw/block/virtio-blk.c            |  6 ++++
 include/block/block_int-common.h |  4 +++
 qapi/block-core.json             |  6 +++-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 8848e9a7ed..e455d04e97 100644
--- a/block.c
+++ b/block.c
@@ -38,7 +38,9 @@
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
+#include "qobject/qlist.h"
 #include "qobject/qnull.h"
+#include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
@@ -3956,6 +3958,35 @@ out:
     return bs_snapshot;
 }
 
+static bool bdrv_parse_stats_intervals(BlockDriverState *bs, QList *intervals,
+                                  Error **errp)
+{
+    unsigned i = 0;
+    const QListEntry *entry;
+    bs->num_stats_intervals = qlist_size(intervals);
+
+    if (bs->num_stats_intervals > 0) {
+        bs->stats_intervals = g_new(uint64_t, bs->num_stats_intervals);
+    }
+
+    for (entry = qlist_first(intervals); entry; entry = qlist_next(entry)) {
+        if (qobject_type(entry->value) == QTYPE_QNUM) {
+            uint64_t length = qnum_get_int(qobject_to(QNum, entry->value));
+
+            if (length > 0 && length <= UINT_MAX) {
+                bs->stats_intervals[i++] = length;
+            } else {
+                error_setg(errp, "Invalid interval length: %" PRId64, length);
+                return false;
+            }
+        } else {
+            error_setg(errp, "The specification of stats-intervals is invalid");
+            return false;
+        }
+    }
+    return true;
+}
+
 /*
  * Opens a disk image (raw, qcow2, vmdk, ...)
  *
@@ -3987,6 +4018,8 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     Error *local_err = NULL;
     QDict *snapshot_options = NULL;
     int snapshot_flags = 0;
+    QDict *interval_dict = NULL;
+    QList *interval_list = NULL;
 
     assert(!child_class || !flags);
     assert(!child_class == !parent);
@@ -4205,6 +4238,19 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
         g_free(child_key_dot);
     }
 
+    qdict_extract_subqdict(options, &interval_dict, "stats-intervals.");
+    qdict_array_split(interval_dict, &interval_list);
+
+    if (qdict_size(interval_dict) != 0) {
+        error_setg(errp, "Invalid option stats-intervals.%s",
+                   qdict_first(interval_dict)->key);
+        goto close_and_fail;
+    }
+
+    if (!bdrv_parse_stats_intervals(bs, interval_list, errp)) {
+        goto close_and_fail;
+    }
+
     /* Check if any unknown options were used */
     if (qdict_size(options) != 0) {
         const QDictEntry *entry = qdict_first(options);
@@ -4261,6 +4307,8 @@ close_and_fail:
     bdrv_unref(bs);
     qobject_unref(snapshot_options);
     qobject_unref(options);
+    qobject_unref(interval_dict);
+    qobject_unref(interval_list);
     error_propagate(errp, local_err);
     return NULL;
 }
@@ -5190,6 +5238,8 @@ static void GRAPH_UNLOCKED bdrv_close(BlockDriverState *bs)
     bs->full_open_options = NULL;
     g_free(bs->block_status_cache);
     bs->block_status_cache = NULL;
+    g_free(bs->stats_intervals);
+    bs->stats_intervals = NULL;
 
     bdrv_release_named_dirty_bitmaps(bs);
     assert(QLIST_EMPTY(&bs->dirty_bitmaps));
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9bab2716c1..b730c67940 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1814,6 +1814,12 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
                          conf->conf.lcyls,
                          conf->conf.lheads,
                          conf->conf.lsecs);
+
+    if (bs->stats_intervals) {
+        for (i = 0; i < bs->num_stats_intervals; i++) {
+            block_acct_add_interval(blk_get_stats(s->blk), bs->stats_intervals[i]);
+        }
+    }
 }
 
 static void virtio_blk_device_unrealize(DeviceState *dev)
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 034c0634c8..1b4b7c636d 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1277,6 +1277,10 @@ struct BlockDriverState {
 
     /* array of write pointers' location of each zone in the zoned device. */
     BlockZoneWps *wps;
+
+    /* Array of intervals for collecting IO stats */
+    uint64_t *stats_intervals;
+    unsigned int num_stats_intervals;
 };
 
 struct BlockBackendRootState {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index dc6eb4ae23..dbb53296b1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4771,6 +4771,9 @@
 # @force-share: force share all permission on added nodes.  Requires
 #     read-only=true.  (Since 2.10)
 #
+# @stats-intervals: #optional list of intervals for collecting I/O
+#                   statistics, in seconds (default: none)
+#
 # Since: 2.9
 ##
 { 'union': 'BlockdevOptions',
@@ -4782,7 +4785,8 @@
             '*read-only': 'bool',
             '*auto-read-only': 'bool',
             '*force-share': 'bool',
-            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
+            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
+            '*stats-intervals': ['int'] },
   'discriminator': 'driver',
   'data': {
       'blkdebug':   'BlockdevOptionsBlkdebug',
-- 
2.51.0


