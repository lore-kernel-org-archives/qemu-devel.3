Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BCBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnU-0002hx-AF; Tue, 23 Apr 2024 18:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmm-0001er-TQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOml-0006El-0Z
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbWNq6LXfF07q0WwdpALQ89s0jTdYCSmSn6hXqYiU0Y=;
 b=bggX/98wbP6TxZiLPcQ/qpSElu0hkNa2F2H9gnQFcPdRS3IXDbVo9qrbnITgnpxcSKLuy2
 1dv35WNfXU7eeoKxk16P3oSQSHTkd8K6P8PkGcjjoKaJdUOzZjPB7gDI2HY74T6eImxpNS
 R442IiIsQobN16kJXsIcaQq5SkhC7Es=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-UVoWTV87P6qtwgOUhAuIfw-1; Tue, 23 Apr 2024 18:38:45 -0400
X-MC-Unique: UVoWTV87P6qtwgOUhAuIfw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-434ed2e412fso27795521cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911924; x=1714516724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbWNq6LXfF07q0WwdpALQ89s0jTdYCSmSn6hXqYiU0Y=;
 b=gf7+R9MAZi+djJvGGYKGVer7u73qrJ4l/OLUb6mpxPLUUyjhWNKqjMTHbMZWKwlQg1
 IsphsLOMJERyZr3Z4WLaATU1UXlzg836A3rpaLweMJ+XE7ClxDZVA+5vXYH2iptpOb23
 P6d4anemmlYMvBLyYcqiBWe/srZjC0LTpekGp7LjkLODtp3IPTrsPi6IVLCaCrUpNrVT
 2R8QtttZMT61kjiLh1fKVdiGt/WzLKNFSFP8FBycisuN7DKqTUFJVgUfUN6Y34i7xg27
 tvokJnchWLflXLuyWV9jNycZ7UE6FduOqQaseA/nfWMoylNTD7FlM0L2UqG0Iq+1M/0Y
 kedw==
X-Gm-Message-State: AOJu0Yxh/MVOFvsmVURiMbzW1OPsnItuV98g3EDDu+DUvwfOMQ/Co6n8
 PupOt2Yo/tpCaaFDqPQFh8dp/tSco/W0TsmP5MGteaI7pHW60kf65J6La36ljq/vHgKQmTwmnFJ
 Px1sZaUYSDg7DNuyZLfel4DelmHBxzl3P50wcMPyWjQOPO6sGWS8djxL8794gC0u/7TADNMhMED
 2E9k69R+JNfdsmrYBjJGYH4EMHDyYBISH17g==
X-Received: by 2002:a05:620a:28c3:b0:790:8734:1cbb with SMTP id
 l3-20020a05620a28c300b0079087341cbbmr1018139qkp.4.1713911924230; 
 Tue, 23 Apr 2024 15:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHocqZylN3YqY1OoBOWtj3KqjdwGMDjrsrph2vn5AzxhjsZkJ+T0X8YEwL5S9+GQBS9QvtEtw==
X-Received: by 2002:a05:620a:28c3:b0:790:8734:1cbb with SMTP id
 l3-20020a05620a28c300b0079087341cbbmr1018102qkp.4.1713911923544; 
 Tue, 23 Apr 2024 15:38:43 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/26] migration: Add Error** argument to add_bitmaps_to_list()
Date: Tue, 23 Apr 2024 18:38:11 -0400
Message-ID: <20240423223813.3237060-25-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

This allows to report more precise errors in the migration handler
dirty_bitmap_save_setup().

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20240329105627.311227-1-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/block-dirty-bitmap.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 542a8c297b..a7d55048c2 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -481,13 +481,13 @@ static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
 
 /* Called with the BQL taken. */
 static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
-                               const char *bs_name, GHashTable *alias_map)
+                               const char *bs_name, GHashTable *alias_map,
+                               Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
     SaveBitmapState *dbms;
     GHashTable *bitmap_aliases;
     const char *node_alias, *bitmap_name, *bitmap_alias;
-    Error *local_err = NULL;
 
     /* When an alias map is given, @bs_name must be @bs's node name */
     assert(!alias_map || !strcmp(bs_name, bdrv_get_node_name(bs)));
@@ -504,8 +504,8 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
     bitmap_name = bdrv_dirty_bitmap_name(bitmap);
 
     if (!bs_name || strcmp(bs_name, "") == 0) {
-        error_report("Bitmap '%s' in unnamed node can't be migrated",
-                     bitmap_name);
+        error_setg(errp, "Bitmap '%s' in unnamed node can't be migrated",
+                   bitmap_name);
         return -1;
     }
 
@@ -525,9 +525,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
     }
 
     if (node_alias[0] == '#') {
-        error_report("Bitmap '%s' in a node with auto-generated "
-                     "name '%s' can't be migrated",
-                     bitmap_name, node_alias);
+        error_setg(errp, "Bitmap '%s' in a node with auto-generated "
+                   "name '%s' can't be migrated",
+                   bitmap_name, node_alias);
         return -1;
     }
 
@@ -538,8 +538,7 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
             continue;
         }
 
-        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
-            error_report_err(local_err);
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
             return -1;
         }
 
@@ -558,9 +557,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
             }
         } else {
             if (strlen(bitmap_name) > UINT8_MAX) {
-                error_report("Cannot migrate bitmap '%s' on node '%s': "
-                             "Name is longer than %u bytes",
-                             bitmap_name, bs_name, UINT8_MAX);
+                error_setg(errp, "Cannot migrate bitmap '%s' on node '%s': "
+                           "Name is longer than %u bytes",
+                           bitmap_name, bs_name, UINT8_MAX);
                 return -1;
             }
             bitmap_alias = bitmap_name;
@@ -599,7 +598,7 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
 }
 
 /* Called with the BQL taken. */
-static int init_dirty_bitmap_migration(DBMSaveState *s)
+static int init_dirty_bitmap_migration(DBMSaveState *s, Error **errp)
 {
     BlockDriverState *bs;
     SaveBitmapState *dbms;
@@ -643,7 +642,7 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
             }
 
             if (bs && bs->drv && !bs->drv->is_filter) {
-                if (add_bitmaps_to_list(s, bs, name, NULL)) {
+                if (add_bitmaps_to_list(s, bs, name, NULL, errp)) {
                     goto fail;
                 }
                 g_hash_table_add(handled_by_blk, bs);
@@ -656,7 +655,8 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
             continue;
         }
 
-        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs), alias_map)) {
+        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs), alias_map,
+                                errp)) {
             goto fail;
         }
     }
@@ -1218,9 +1218,7 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
 
-    if (init_dirty_bitmap_migration(s) < 0) {
-        error_setg(errp,
-                   "Failed to initialize dirty tracking bitmap for blocks");
+    if (init_dirty_bitmap_migration(s, errp) < 0) {
         return -1;
     }
 
-- 
2.44.0


