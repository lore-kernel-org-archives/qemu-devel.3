Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17E0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSx-0007tB-9c; Fri, 02 May 2025 12:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSb-0007mY-R0
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSZ-0006T0-TG
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWyBexoIRamceh81lwn3HjKOZqVQpjEmVJQs01FKpAY=;
 b=QB/S1ybB50ldWk0iPXKIaY/zBxgjDsQYsDDJC+/hchMbYINcnBMcNdalw4baJJzL4O2FNW
 ge8RFOC8R9xpr+TItLbjSJkoow/eqzcU77ntehp7/EpoxaV4q8tvL3dF3f+9C7d6UdDyTy
 qQ2W6nb+TWlA+nn59k8c6D8RQbDCSDo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-VN9kUWymNd2kaz8XCCclCw-1; Fri, 02 May 2025 12:41:58 -0400
X-MC-Unique: VN9kUWymNd2kaz8XCCclCw-1
X-Mimecast-MFC-AGG-ID: VN9kUWymNd2kaz8XCCclCw_1746204117
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c0a3ff7e81so395724685a.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204117; x=1746808917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWyBexoIRamceh81lwn3HjKOZqVQpjEmVJQs01FKpAY=;
 b=c8XmgHx4whyCjkp7XViuuzD5N5n3cUyfH3ulNywmboxqtr+92H4E2c1Uqn9AISyuGi
 Z6gQENDyJsnv/PlQHmLJV9ZtHjFTo6MjNz2fbtVNN8//HoapjJD5YI1nAKn7v0Hn7Hi3
 RMKD54H5U5tiZz9Y4ceYQgMaz9/Io49AEyvmTbvY6HW38InzriIrsKpKSkcJgYTzQgXy
 ldENZCkhgGCOno8TlnGGWx6ecXeANcpzGXm6myzRO+BKfkUTv743oJV/1LhAfToiG5Lf
 VkveQYV//3ZmzmEH5gspM1mNMjwLCN/8Mqa0qTqx6OrcPVASRPLs699RkUgBXq/erMCX
 csIA==
X-Gm-Message-State: AOJu0YyixUOVzf461XWtSuJyKWk3w/Dh0UDPAusfQY6ZHcZTpEwqc4Bs
 UznnVRzEWi8l9Zuui6ypYLx2zCSJXskRuwUMxouw2MRLvfQTDrDCIhJE7LD88BBnoJt6kEBReWb
 r4p6X4YS/9xLmMIezlnPhXLrTI+0zYwXGjfduiP5YIycBNFRvPe3p3kUvaDy//+no+qiOjLcfwp
 kN+qwzkzbKL5bcD6AsHoCQuJmWgMzNruCbUQ==
X-Gm-Gg: ASbGnctje8L70CVaOCvp+lYoYBTiRVyUL/hHLTOC8r3tIddJfkFuxcPAcSuGvtXrgoo
 9pI+t+wSFEcg8N+ypuCEixZ+RLrLnbIT90raILcIyIThcwYUyiciGtRdifNwrcWz+bs3bfKvG/7
 6ZibwQyrm2ZqYjpaaFZlN1DgAAOeJXP9RgV082Ve0Mx/TnwakO2WdD2vcCLhzEEqFirn39Grl6Q
 flYVNvfAQzihaE00s17Gqi3V+eOIwudelxQJVaVfN7G/7POfQoSrHt6Zv2WPuYKwynVLqxqGwzw
X-Received: by 2002:a05:620a:4250:b0:7ca:cb02:7942 with SMTP id
 af79cd13be357-7cad5b2ceefmr543326985a.1.1746204117149; 
 Fri, 02 May 2025 09:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKqEkhHjvg0mCk6OQPEWL8nZ6Q7kStsPaPjAIduQB21nCkakaVJnePEOgLpO2KhMSeHtEWPw==
X-Received: by 2002:a05:620a:4250:b0:7ca:cb02:7942 with SMTP id
 af79cd13be357-7cad5b2ceefmr543323185a.1.1746204116734; 
 Fri, 02 May 2025 09:41:56 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 08/14] migration: refactor channel discovery mechanism
Date: Fri,  2 May 2025 12:41:35 -0400
Message-ID: <20250502164141.747202-9-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

The various logical migration channels don't have a
standardized way of advertising themselves and their
connections may be seen out of order by the migration
destination. When a new connection arrives, the incoming
migration currently make use of heuristics to determine
which channel it belongs to.

The next few patches will need to change how the multifd
and postcopy capabilities interact and that affects the
channel discovery heuristic.

Refactor the channel discovery heuristic to make it less
opaque and simplify the subsequent patches.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250411114534.3370816-3-ppandit@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 130 +++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 60 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 54fce997aa..f18cadcc5e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -95,6 +95,9 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
+/* Migration channel types */
+enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
+
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -941,9 +944,8 @@ static void migration_incoming_setup(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!mis->from_src_file) {
-        mis->from_src_file = f;
-    }
+    assert(!mis->from_src_file);
+    mis->from_src_file = f;
     qemu_file_set_blocking(f, false);
 }
 
@@ -995,28 +997,19 @@ void migration_fd_process_incoming(QEMUFile *f)
     migration_incoming_process();
 }
 
-/*
- * Returns true when we want to start a new incoming migration process,
- * false otherwise.
- */
-static bool migration_should_start_incoming(bool main_channel)
+static bool migration_has_main_and_multifd_channels(void)
 {
-    /* Multifd doesn't start unless all channels are established */
-    if (migrate_multifd()) {
-        return migration_has_all_channels();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    if (!mis->from_src_file) {
+        /* main channel not established */
+        return false;
     }
 
-    /* Preempt channel only starts when the main channel is created */
-    if (migrate_postcopy_preempt()) {
-        return main_channel;
+    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
+        return false;
     }
 
-    /*
-     * For all the rest types of migration, we should only reach here when
-     * it's the main channel that's being created, and we should always
-     * proceed with this channel.
-     */
-    assert(main_channel);
+    /* main and all multifd channels are established */
     return true;
 }
 
@@ -1025,59 +1018,81 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     QEMUFile *f;
-    bool default_channel = true;
+    uint8_t channel;
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_mapped_ram() &&
-        !migrate_postcopy_ram() &&
-        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
-        /*
-         * With multiple channels, it is possible that we receive channels
-         * out of order on destination side, causing incorrect mapping of
-         * source channels on destination side. Check channel MAGIC to
-         * decide type of channel. Please note this is best effort, postcopy
-         * preempt channel does not send any magic number so avoid it for
-         * postcopy live migration. Also tls live migration already does
-         * tls handshake while initializing main channel so with tls this
-         * issue is not possible.
-         */
-        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), errp);
+    if (!migration_has_main_and_multifd_channels()) {
+        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+            /*
+             * With multiple channels, it is possible that we receive channels
+             * out of order on destination side, causing incorrect mapping of
+             * source channels on destination side. Check channel MAGIC to
+             * decide type of channel. Please note this is best effort,
+             * postcopy preempt channel does not send any magic number so
+             * avoid it for postcopy live migration. Also tls live migration
+             * already does tls handshake while initializing main channel so
+             * with tls this issue is not possible.
+             */
+            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
+                                              sizeof(channel_magic), errp);
+            if (ret != 0) {
+                return;
+            }
 
-        if (ret != 0) {
+            channel_magic = be32_to_cpu(channel_magic);
+            if (channel_magic == QEMU_VM_FILE_MAGIC) {
+                channel = CH_MAIN;
+            } else if (channel_magic == MULTIFD_MAGIC) {
+                assert(migrate_multifd());
+                channel = CH_MULTIFD;
+            } else if (!mis->from_src_file &&
+                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+                /* reconnect main channel for postcopy recovery */
+                channel = CH_MAIN;
+            } else {
+                error_setg(errp, "unknown channel magic: %u", channel_magic);
+                return;
+            }
+        } else if (mis->from_src_file && migrate_multifd()) {
+            /*
+             * Non-peekable channels like tls/file are processed as
+             * multifd channels when multifd is enabled.
+             */
+            channel = CH_MULTIFD;
+        } else if (!mis->from_src_file) {
+            channel = CH_MAIN;
+        } else {
+            error_setg(errp, "non-peekable channel used without multifd");
             return;
         }
-
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
     } else {
-        default_channel = !mis->from_src_file;
+        assert(migrate_postcopy_preempt());
+        channel = CH_POSTCOPY;
     }
 
     if (multifd_recv_setup(errp) != 0) {
         return;
     }
 
-    if (default_channel) {
+    if (channel == CH_MAIN) {
         f = qemu_file_new_input(ioc);
         migration_incoming_setup(f);
-    } else {
+    } else if (channel == CH_MULTIFD) {
         /* Multiple connections */
-        assert(migration_needs_multiple_sockets());
-        if (migrate_multifd()) {
-            multifd_recv_new_channel(ioc, &local_err);
-        } else {
-            assert(migrate_postcopy_preempt());
-            f = qemu_file_new_input(ioc);
-            postcopy_preempt_new_channel(mis, f);
-        }
+        multifd_recv_new_channel(ioc, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (channel == CH_POSTCOPY) {
+        assert(!mis->postcopy_qemufile_dst);
+        f = qemu_file_new_input(ioc);
+        postcopy_preempt_new_channel(mis, f);
+        return;
     }
 
-    if (migration_should_start_incoming(default_channel)) {
+    if (migration_has_main_and_multifd_channels()) {
         /* If it's a recovery, we're done */
         if (postcopy_try_recover()) {
             return;
@@ -1094,18 +1109,13 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
  */
 bool migration_has_all_channels(void)
 {
-    MigrationIncomingState *mis = migration_incoming_get_current();
-
-    if (!mis->from_src_file) {
+    if (!migration_has_main_and_multifd_channels()) {
         return false;
     }
 
-    if (migrate_multifd()) {
-        return multifd_recv_all_channels_created();
-    }
-
-    if (migrate_postcopy_preempt()) {
-        return mis->postcopy_qemufile_dst != NULL;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
+        return false;
     }
 
     return true;
-- 
2.48.1


