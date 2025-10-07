Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED150CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 16:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Af8-0002s1-9P; Tue, 07 Oct 2025 12:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Af6-0002rg-Iu
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 12:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Af1-00058l-2G
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 12:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759854931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QuFvBdyxrxb6fZzYKYyUpvh38Hjse9aP2tUk8PitTWM=;
 b=F6qww3CGcFjx7z0MdbJjR81YksDSkzxaERT+hz7kCNnlq0GACCv+cEBsGJ1sV7oG/AHCIL
 mumF1svMuaOldl+6AbjXruw3kW+WsgFvHpv69to4Z6eHaOG1fBBWp4bZcV+A/YmnDv1BnR
 9/tNMEG/JtDpZlBOTQxiqBMRWFTV25c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-1iMXFONaP6u7NFk92nP63w-1; Tue,
 07 Oct 2025 12:35:19 -0400
X-MC-Unique: 1iMXFONaP6u7NFk92nP63w-1
X-Mimecast-MFC-AGG-ID: 1iMXFONaP6u7NFk92nP63w_1759854917
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADB901956096; Tue,  7 Oct 2025 16:35:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3236C19560A2; Tue,  7 Oct 2025 16:35:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v4] block: replace TABs with space
Date: Tue,  7 Oct 2025 18:35:11 +0200
Message-ID: <20251007163511.334178-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yeqi Fu <fufuyqqqqqq@gmail.com>

Bring the block files in line with the QEMU coding style, with spaces
for indentation. This patch partially resolves the issue 371.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/371
Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
Message-ID: <20230325085224.23842-1-fufuyqqqqqq@gmail.com>
[thuth: Rebased the patch to the current master branch]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I came accross this old patch today - it fell through the cracks
 in 2023, but I think it's still worth to get the coding style
 finally fixed in these files.

 include/block/nbd.h |  2 +-
 block/bochs.c       | 14 +++++++-------
 block/file-posix.c  |  6 +++---
 block/file-win32.c  | 18 +++++++++---------
 block/qcow.c        | 10 +++++-----
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 92987c76fd6..ab40842da9a 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -296,7 +296,7 @@ enum {
     NBD_CMD_BLOCK_STATUS = 7,
 };
 
-#define NBD_DEFAULT_PORT	10809
+#define NBD_DEFAULT_PORT 10809
 
 /* Maximum size of a single READ/WRITE data buffer */
 #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)
diff --git a/block/bochs.c b/block/bochs.c
index b099fb52fe8..bfda88017d9 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -300,15 +300,15 @@ static void bochs_close(BlockDriverState *bs)
 }
 
 static BlockDriver bdrv_bochs = {
-    .format_name	= "bochs",
-    .instance_size	= sizeof(BDRVBochsState),
-    .bdrv_probe		= bochs_probe,
-    .bdrv_open		= bochs_open,
+    .format_name         = "bochs",
+    .instance_size       = sizeof(BDRVBochsState),
+    .bdrv_probe          = bochs_probe,
+    .bdrv_open           = bochs_open,
     .bdrv_child_perm     = bdrv_default_perms,
     .bdrv_refresh_limits = bochs_refresh_limits,
-    .bdrv_co_preadv = bochs_co_preadv,
-    .bdrv_close		= bochs_close,
-    .is_format          = true,
+    .bdrv_co_preadv      = bochs_co_preadv,
+    .bdrv_close          = bochs_close,
+    .is_format           = true,
 };
 
 static void bdrv_bochs_init(void)
diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674ced..8be4404c78c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -133,7 +133,7 @@
 #define FTYPE_FILE   0
 #define FTYPE_CD     1
 
-#define MAX_BLOCKSIZE	4096
+#define MAX_BLOCKSIZE 4096
 
 /* Posix file locking bytes. Libvirt takes byte 0, we start from higher bytes,
  * leaving a few more bytes for its future use. */
@@ -4578,7 +4578,7 @@ static BlockDriver bdrv_host_cdrom = {
     .protocol_name      = "host_cdrom",
     .instance_size      = sizeof(BDRVRawState),
     .bdrv_needs_filename = true,
-    .bdrv_probe_device	= cdrom_probe_device,
+    .bdrv_probe_device = cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
     .bdrv_open          = cdrom_open,
     .bdrv_close         = raw_close,
@@ -4704,7 +4704,7 @@ static BlockDriver bdrv_host_cdrom = {
     .protocol_name      = "host_cdrom",
     .instance_size      = sizeof(BDRVRawState),
     .bdrv_needs_filename = true,
-    .bdrv_probe_device	= cdrom_probe_device,
+    .bdrv_probe_device = cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
     .bdrv_open          = cdrom_open,
     .bdrv_close         = raw_close,
diff --git a/block/file-win32.c b/block/file-win32.c
index af9aea631cb..16bcef88c68 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -741,9 +741,9 @@ static QemuOptsList raw_create_opts = {
 };
 
 BlockDriver bdrv_file = {
-    .format_name	= "file",
-    .protocol_name	= "file",
-    .instance_size	= sizeof(BDRVRawState),
+    .format_name = "file",
+    .protocol_name = "file",
+    .instance_size = sizeof(BDRVRawState),
     .bdrv_needs_filename = true,
     .bdrv_parse_filename = raw_parse_filename,
     .bdrv_open          = raw_open,
@@ -914,14 +914,14 @@ done:
 }
 
 static BlockDriver bdrv_host_device = {
-    .format_name	= "host_device",
-    .protocol_name	= "host_device",
-    .instance_size	= sizeof(BDRVRawState),
+    .format_name = "host_device",
+    .protocol_name = "host_device",
+    .instance_size = sizeof(BDRVRawState),
     .bdrv_needs_filename = true,
     .bdrv_parse_filename = hdev_parse_filename,
-    .bdrv_probe_device	= hdev_probe_device,
-    .bdrv_open     	= hdev_open,
-    .bdrv_close		= raw_close,
+    .bdrv_probe_device = hdev_probe_device,
+    .bdrv_open = hdev_open,
+    .bdrv_close = raw_close,
     .bdrv_refresh_limits = hdev_refresh_limits,
 
     .bdrv_aio_preadv    = raw_aio_preadv,
diff --git a/block/qcow.c b/block/qcow.c
index 8a3e7591a92..b442bfe8357 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1184,11 +1184,11 @@ static const char *const qcow_strong_runtime_opts[] = {
 };
 
 static BlockDriver bdrv_qcow = {
-    .format_name	= "qcow",
-    .instance_size	= sizeof(BDRVQcowState),
-    .bdrv_probe		= qcow_probe,
-    .bdrv_open		= qcow_open,
-    .bdrv_close		= qcow_close,
+    .format_name            = "qcow",
+    .instance_size          = sizeof(BDRVQcowState),
+    .bdrv_probe             = qcow_probe,
+    .bdrv_open              = qcow_open,
+    .bdrv_close             = qcow_close,
     .bdrv_child_perm        = bdrv_default_perms,
     .bdrv_reopen_prepare    = qcow_reopen_prepare,
     .bdrv_co_create         = qcow_co_create,
-- 
2.51.0


