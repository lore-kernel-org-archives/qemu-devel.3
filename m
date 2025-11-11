Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E534FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzp-0007lt-5P; Tue, 11 Nov 2025 16:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzk-0007Z1-92
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzh-0001yj-EE
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3Twk6+8ae4PwFeo7u1w75GEqQK8dI54LHe5+TXEM+Q=;
 b=BDwQWADUmdFWMdBHwO3jSC20VvZC3ckhDEnJKj5G5x4GSb+4kphg9gGUgSn+v9cYodM5/h
 CxJMvwdzU+sSIJPny5bes5gndc/ByDLdaLuZL8kAIbPVbrNZ2Os461olJXnTylI+Vuwffl
 /TtNxf5TLPd3xjqo8JsOPxGs5UWopx8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-gQEaC3j3MB2v3uNOniggfQ-1; Tue,
 11 Nov 2025 16:33:37 -0500
X-MC-Unique: gQEaC3j3MB2v3uNOniggfQ-1
X-Mimecast-MFC-AGG-ID: gQEaC3j3MB2v3uNOniggfQ_1762896816
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 269801956089; Tue, 11 Nov 2025 21:33:36 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8519130044E7; Tue, 11 Nov 2025 21:33:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 16/28] block: replace TABs with space
Date: Tue, 11 Nov 2025 22:32:26 +0100
Message-ID: <20251111213238.181992-17-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-ID: <20251007163511.334178-1-thuth@redhat.com>
[kwolf: Fixed up vertical alignemnt]
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/nbd.h |  2 +-
 block/bochs.c       | 14 +++++------
 block/file-posix.c  | 58 ++++++++++++++++++++++-----------------------
 block/file-win32.c  | 38 ++++++++++++++---------------
 block/qcow.c        | 10 ++++----
 5 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 92987c76fd..ab40842da9 100644
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
index b099fb52fe..bfda88017d 100644
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
index 8b7c02d19a..12d12970fa 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -133,7 +133,7 @@
 #define FTYPE_FILE   0
 #define FTYPE_CD     1
 
-#define MAX_BLOCKSIZE	4096
+#define MAX_BLOCKSIZE 4096
 
 /* Posix file locking bytes. Libvirt takes byte 0, we start from higher bytes,
  * leaving a few more bytes for its future use. */
@@ -4562,20 +4562,20 @@ static void coroutine_fn cdrom_co_lock_medium(BlockDriverState *bs, bool locked)
 }
 
 static BlockDriver bdrv_host_cdrom = {
-    .format_name        = "host_cdrom",
-    .protocol_name      = "host_cdrom",
-    .instance_size      = sizeof(BDRVRawState),
-    .bdrv_needs_filename = true,
-    .bdrv_probe_device	= cdrom_probe_device,
-    .bdrv_parse_filename = cdrom_parse_filename,
-    .bdrv_open          = cdrom_open,
-    .bdrv_close         = raw_close,
-    .bdrv_reopen_prepare = raw_reopen_prepare,
-    .bdrv_reopen_commit  = raw_reopen_commit,
-    .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_co_create_opts = bdrv_co_create_opts_simple,
-    .create_opts         = &bdrv_create_opts_simple,
-    .mutable_opts        = mutable_opts,
+    .format_name            = "host_cdrom",
+    .protocol_name          = "host_cdrom",
+    .instance_size          = sizeof(BDRVRawState),
+    .bdrv_needs_filename    = true,
+    .bdrv_probe_device      = cdrom_probe_device,
+    .bdrv_parse_filename    = cdrom_parse_filename,
+    .bdrv_open              = cdrom_open,
+    .bdrv_close             = raw_close,
+    .bdrv_reopen_prepare    = raw_reopen_prepare,
+    .bdrv_reopen_commit     = raw_reopen_commit,
+    .bdrv_reopen_abort      = raw_reopen_abort,
+    .bdrv_co_create_opts    = bdrv_co_create_opts_simple,
+    .create_opts            = &bdrv_create_opts_simple,
+    .mutable_opts           = mutable_opts,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
 
     .bdrv_co_preadv         = raw_co_preadv,
@@ -4688,20 +4688,20 @@ static void coroutine_fn cdrom_co_lock_medium(BlockDriverState *bs, bool locked)
 }
 
 static BlockDriver bdrv_host_cdrom = {
-    .format_name        = "host_cdrom",
-    .protocol_name      = "host_cdrom",
-    .instance_size      = sizeof(BDRVRawState),
-    .bdrv_needs_filename = true,
-    .bdrv_probe_device	= cdrom_probe_device,
-    .bdrv_parse_filename = cdrom_parse_filename,
-    .bdrv_open          = cdrom_open,
-    .bdrv_close         = raw_close,
-    .bdrv_reopen_prepare = raw_reopen_prepare,
-    .bdrv_reopen_commit  = raw_reopen_commit,
-    .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_co_create_opts = bdrv_co_create_opts_simple,
-    .create_opts         = &bdrv_create_opts_simple,
-    .mutable_opts       = mutable_opts,
+    .format_name            = "host_cdrom",
+    .protocol_name          = "host_cdrom",
+    .instance_size          = sizeof(BDRVRawState),
+    .bdrv_needs_filename    = true,
+    .bdrv_probe_device      = cdrom_probe_device,
+    .bdrv_parse_filename    = cdrom_parse_filename,
+    .bdrv_open              = cdrom_open,
+    .bdrv_close             = raw_close,
+    .bdrv_reopen_prepare    = raw_reopen_prepare,
+    .bdrv_reopen_commit     = raw_reopen_commit,
+    .bdrv_reopen_abort      = raw_reopen_abort,
+    .bdrv_co_create_opts    = bdrv_co_create_opts_simple,
+    .create_opts            = &bdrv_create_opts_simple,
+    .mutable_opts           = mutable_opts,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/block/file-win32.c b/block/file-win32.c
index af9aea631c..0efb609e1d 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -741,16 +741,16 @@ static QemuOptsList raw_create_opts = {
 };
 
 BlockDriver bdrv_file = {
-    .format_name	= "file",
-    .protocol_name	= "file",
-    .instance_size	= sizeof(BDRVRawState),
-    .bdrv_needs_filename = true,
-    .bdrv_parse_filename = raw_parse_filename,
-    .bdrv_open          = raw_open,
-    .bdrv_refresh_limits = raw_probe_alignment,
-    .bdrv_close         = raw_close,
-    .bdrv_co_create_opts = raw_co_create_opts,
-    .bdrv_has_zero_init = bdrv_has_zero_init_1,
+    .format_name            = "file",
+    .protocol_name          = "file",
+    .instance_size          = sizeof(BDRVRawState),
+    .bdrv_needs_filename    = true,
+    .bdrv_parse_filename    = raw_parse_filename,
+    .bdrv_open              = raw_open,
+    .bdrv_refresh_limits    = raw_probe_alignment,
+    .bdrv_close             = raw_close,
+    .bdrv_co_create_opts    = raw_co_create_opts,
+    .bdrv_has_zero_init     = bdrv_has_zero_init_1,
 
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
@@ -914,15 +914,15 @@ done:
 }
 
 static BlockDriver bdrv_host_device = {
-    .format_name	= "host_device",
-    .protocol_name	= "host_device",
-    .instance_size	= sizeof(BDRVRawState),
-    .bdrv_needs_filename = true,
-    .bdrv_parse_filename = hdev_parse_filename,
-    .bdrv_probe_device	= hdev_probe_device,
-    .bdrv_open     	= hdev_open,
-    .bdrv_close		= raw_close,
-    .bdrv_refresh_limits = hdev_refresh_limits,
+    .format_name            = "host_device",
+    .protocol_name          = "host_device",
+    .instance_size          = sizeof(BDRVRawState),
+    .bdrv_needs_filename    = true,
+    .bdrv_parse_filename    = hdev_parse_filename,
+    .bdrv_probe_device      = hdev_probe_device,
+    .bdrv_open              = hdev_open,
+    .bdrv_close             = raw_close,
+    .bdrv_refresh_limits    = hdev_refresh_limits,
 
     .bdrv_aio_preadv    = raw_aio_preadv,
     .bdrv_aio_pwritev   = raw_aio_pwritev,
diff --git a/block/qcow.c b/block/qcow.c
index 8a3e7591a9..b442bfe835 100644
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
2.51.1


