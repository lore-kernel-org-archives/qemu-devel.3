Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFFCC41513
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu42-0001Y4-Bu; Sat, 22 Jun 2024 02:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3T-0000W2-Qr
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3R-0006V2-KZ
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719037013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26VrXM0DHOiKV7RbRMquU6833DYubbhko1Fn4Gg+sYw=;
 b=IVFTMP4xR4mquExcCglN6GjMOIAhoR7R9I6scCBR+wdX5+HEEjwwpI69/APUumd3Q0VzAO
 xpVGgejbvWuk8cVhh8N+99q1K1eQwJ9EkMxVmmrOoQNbHgXYsgdf3HOCPS7D5uSFgAmA/h
 YIEQlhPmiw4QIx59vmD/yiYDMX9PY5w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1UoEU_9bNGSDzM8OlXTHCQ-1; Sat, 22 Jun 2024 02:16:49 -0400
X-MC-Unique: 1UoEU_9bNGSDzM8OlXTHCQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6def6e9ef2so317182966b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719037007; x=1719641807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26VrXM0DHOiKV7RbRMquU6833DYubbhko1Fn4Gg+sYw=;
 b=jPeTLNtp4c9xcVsFpx2kgafjWvH9SVXSW8S/nLgvXjGi09Eikt7VjVi3M1ShG47jks
 akxYQBgC7c4z7MzY7QSOmeJ/4jzq+r0FaeWobWqY07/DIQjsng8uqSuihESU8AloZegP
 RhQ9kKf7oEdjEcIG28xkRB5wb6Sf028/8KceKilhBEeL8c9Zc0uNfM84LtsNSY/rlGZy
 V5JC9yHonE9wQRhxiTHe8IpTXHcY+igygpXuQJeSRWVp8dokc1fVEifn1id3Ecfb3WPj
 YJTwwlpwZZf02MOJqnhZJhC9s6u3p5e0wnI6eRSq5TeuH6LrUVPA2MuL8xOOrKJUTNjz
 P8cw==
X-Gm-Message-State: AOJu0YzVVFnsT1HwAIjdfsbYWkSDp5MTL02AxcxuOLQCJlYYgrcv6KbV
 geDEUWOsXHnGxXoTkz+Xp+uAXoNduKEgUVRwGNwBCHNeKVFxb1uIQcFaks8QDF+iiVpk0t5VYdB
 NGJPN669ANfmo/C3d43Ai0uqKDv/2jP/q/XIqmPZ6JqWNTNHh89NcqVS+Qz7I41EYRuugbZhNe0
 LKcx0Wt/72DZciT4yIU3Khfc1++BJKe0o2a4+g
X-Received: by 2002:a17:906:339a:b0:a6f:4287:f196 with SMTP id
 a640c23a62f3a-a6ffe2706a7mr37261066b.2.1719037007369; 
 Fri, 21 Jun 2024 23:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsBeFiVJUegOJ0SGTHzkx0ENXAcHRZaQWUiP6R4Fa649NiHQtH0QtfMsSpMTGnoOPAale4aA==
X-Received: by 2002:a17:906:339a:b0:a6f:4287:f196 with SMTP id
 a640c23a62f3a-a6ffe2706a7mr37259266b.2.1719037006749; 
 Fri, 21 Jun 2024 23:16:46 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf48b3bdsm155828766b.75.2024.06.21.23.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/23] block: remove separate bdrv_file_open callback
Date: Sat, 22 Jun 2024 08:15:54 +0200
Message-ID: <20240622061558.530543-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

bdrv_file_open and bdrv_open are completely equivalent, they are
never checked except to see which one to invoke.  So merge them
into a single one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/block_int-common.h | 3 ---
 block.c                          | 4 +---
 block/blkdebug.c                 | 2 +-
 block/blkio.c                    | 2 +-
 block/blkverify.c                | 2 +-
 block/curl.c                     | 8 ++++----
 block/file-posix.c               | 8 ++++----
 block/file-win32.c               | 4 ++--
 block/gluster.c                  | 6 +++---
 block/iscsi.c                    | 4 ++--
 block/nbd.c                      | 6 +++---
 block/nfs.c                      | 2 +-
 block/null.c                     | 4 ++--
 block/nvme.c                     | 2 +-
 block/rbd.c                      | 3 ++-
 block/ssh.c                      | 2 +-
 block/vvfat.c                    | 2 +-
 17 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 761276127ed..ebb4e56a503 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -248,9 +248,6 @@ struct BlockDriver {
     int GRAPH_UNLOCKED_PTR (*bdrv_open)(
         BlockDriverState *bs, QDict *options, int flags, Error **errp);
 
-    /* Protocol drivers should implement this instead of bdrv_open */
-    int GRAPH_UNLOCKED_PTR (*bdrv_file_open)(
-        BlockDriverState *bs, QDict *options, int flags, Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
 
     int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create)(
diff --git a/block.c b/block.c
index dd14ba85fc3..c1cc313d216 100644
--- a/block.c
+++ b/block.c
@@ -1655,9 +1655,7 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     bs->opaque = g_malloc0(drv->instance_size);
 
     assert(!drv->bdrv_needs_filename || bs->filename[0]);
-    if (drv->bdrv_file_open) {
-        ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
-    } else if (drv->bdrv_open) {
+    if (drv->bdrv_open) {
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
     } else {
         ret = 0;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 9da8c9eddc2..c95c818c388 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -1073,7 +1073,7 @@ static BlockDriver bdrv_blkdebug = {
     .is_filter              = true,
 
     .bdrv_parse_filename    = blkdebug_parse_filename,
-    .bdrv_file_open         = blkdebug_open,
+    .bdrv_open              = blkdebug_open,
     .bdrv_close             = blkdebug_close,
     .bdrv_reopen_prepare    = blkdebug_reopen_prepare,
     .bdrv_child_perm        = blkdebug_child_perm,
diff --git a/block/blkio.c b/block/blkio.c
index 882e1c297b4..1a38064ce76 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -1088,7 +1088,7 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
  */
 #define BLKIO_DRIVER_COMMON \
     .instance_size           = sizeof(BDRVBlkioState), \
-    .bdrv_file_open          = blkio_file_open, \
+    .bdrv_open               = blkio_file_open, \
     .bdrv_close              = blkio_close, \
     .bdrv_co_getlength       = blkio_co_getlength, \
     .bdrv_co_truncate        = blkio_truncate, \
diff --git a/block/blkverify.c b/block/blkverify.c
index ec45d8335ed..5a9bf674d9c 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -321,7 +321,7 @@ static BlockDriver bdrv_blkverify = {
     .instance_size                    = sizeof(BDRVBlkverifyState),
 
     .bdrv_parse_filename              = blkverify_parse_filename,
-    .bdrv_file_open                   = blkverify_open,
+    .bdrv_open                        = blkverify_open,
     .bdrv_close                       = blkverify_close,
     .bdrv_child_perm                  = bdrv_default_perms,
     .bdrv_co_getlength                = blkverify_co_getlength,
diff --git a/block/curl.c b/block/curl.c
index 419f7c89ef2..ef5252d00b5 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -1034,7 +1034,7 @@ static BlockDriver bdrv_http = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
@@ -1053,7 +1053,7 @@ static BlockDriver bdrv_https = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
@@ -1072,7 +1072,7 @@ static BlockDriver bdrv_ftp = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
@@ -1091,7 +1091,7 @@ static BlockDriver bdrv_ftps = {
 
     .instance_size              = sizeof(BDRVCURLState),
     .bdrv_parse_filename        = curl_parse_filename,
-    .bdrv_file_open             = curl_open,
+    .bdrv_open                  = curl_open,
     .bdrv_close                 = curl_close,
     .bdrv_co_getlength          = curl_co_getlength,
 
diff --git a/block/file-posix.c b/block/file-posix.c
index be25e35ff6e..f3bd946afac 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3886,7 +3886,7 @@ BlockDriver bdrv_file = {
     .bdrv_needs_filename = true,
     .bdrv_probe = NULL, /* no probe for protocols */
     .bdrv_parse_filename = raw_parse_filename,
-    .bdrv_file_open = raw_open,
+    .bdrv_open      = raw_open,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit = raw_reopen_commit,
     .bdrv_reopen_abort = raw_reopen_abort,
@@ -4257,7 +4257,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_needs_filename = true,
     .bdrv_probe_device  = hdev_probe_device,
     .bdrv_parse_filename = hdev_parse_filename,
-    .bdrv_file_open     = hdev_open,
+    .bdrv_open          = hdev_open,
     .bdrv_close         = raw_close,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
@@ -4396,7 +4396,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
-    .bdrv_file_open     = cdrom_open,
+    .bdrv_open          = cdrom_open,
     .bdrv_close         = raw_close,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
@@ -4522,7 +4522,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
-    .bdrv_file_open     = cdrom_open,
+    .bdrv_open          = cdrom_open,
     .bdrv_close         = raw_close,
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
diff --git a/block/file-win32.c b/block/file-win32.c
index 48b790d9173..7e1baa1ece6 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -746,7 +746,7 @@ BlockDriver bdrv_file = {
     .instance_size	= sizeof(BDRVRawState),
     .bdrv_needs_filename = true,
     .bdrv_parse_filename = raw_parse_filename,
-    .bdrv_file_open     = raw_open,
+    .bdrv_open          = raw_open,
     .bdrv_refresh_limits = raw_probe_alignment,
     .bdrv_close         = raw_close,
     .bdrv_co_create_opts = raw_co_create_opts,
@@ -920,7 +920,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_needs_filename = true,
     .bdrv_parse_filename = hdev_parse_filename,
     .bdrv_probe_device	= hdev_probe_device,
-    .bdrv_file_open	= hdev_open,
+    .bdrv_open     	= hdev_open,
     .bdrv_close		= raw_close,
     .bdrv_refresh_limits = hdev_refresh_limits,
 
diff --git a/block/gluster.c b/block/gluster.c
index d0999903dfe..f8b415f3812 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1551,7 +1551,7 @@ static BlockDriver bdrv_gluster = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
@@ -1580,7 +1580,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster+tcp",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
@@ -1609,7 +1609,7 @@ static BlockDriver bdrv_gluster_unix = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster+unix",
     .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
+    .bdrv_open                    = qemu_gluster_open,
     .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
diff --git a/block/iscsi.c b/block/iscsi.c
index 2ff14b74724..979bf90cb79 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2429,7 +2429,7 @@ static BlockDriver bdrv_iscsi = {
 
     .instance_size          = sizeof(IscsiLun),
     .bdrv_parse_filename    = iscsi_parse_filename,
-    .bdrv_file_open         = iscsi_open,
+    .bdrv_open              = iscsi_open,
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = bdrv_co_create_opts_simple,
     .create_opts            = &bdrv_create_opts_simple,
@@ -2468,7 +2468,7 @@ static BlockDriver bdrv_iser = {
 
     .instance_size          = sizeof(IscsiLun),
     .bdrv_parse_filename    = iscsi_parse_filename,
-    .bdrv_file_open         = iscsi_open,
+    .bdrv_open              = iscsi_open,
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = bdrv_co_create_opts_simple,
     .create_opts            = &bdrv_create_opts_simple,
diff --git a/block/nbd.c b/block/nbd.c
index 589d28af833..d464315766e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -2146,7 +2146,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_co_create_opts        = bdrv_co_create_opts_simple,
     .create_opts                = &bdrv_create_opts_simple,
-    .bdrv_file_open             = nbd_open,
+    .bdrv_open                  = nbd_open,
     .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
@@ -2174,7 +2174,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_co_create_opts        = bdrv_co_create_opts_simple,
     .create_opts                = &bdrv_create_opts_simple,
-    .bdrv_file_open             = nbd_open,
+    .bdrv_open                  = nbd_open,
     .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
@@ -2202,7 +2202,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_co_create_opts        = bdrv_co_create_opts_simple,
     .create_opts                = &bdrv_create_opts_simple,
-    .bdrv_file_open             = nbd_open,
+    .bdrv_open                  = nbd_open,
     .bdrv_reopen_prepare        = nbd_client_reopen_prepare,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
diff --git a/block/nfs.c b/block/nfs.c
index 60240a8733d..0500f60c08f 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -888,7 +888,7 @@ static BlockDriver bdrv_nfs = {
 #endif
     .bdrv_co_truncate               = nfs_file_co_truncate,
 
-    .bdrv_file_open                 = nfs_file_open,
+    .bdrv_open                      = nfs_file_open,
     .bdrv_close                     = nfs_file_close,
     .bdrv_co_create                 = nfs_file_co_create,
     .bdrv_co_create_opts            = nfs_file_co_create_opts,
diff --git a/block/null.c b/block/null.c
index 4808704ffd3..6fa64d20d86 100644
--- a/block/null.c
+++ b/block/null.c
@@ -283,7 +283,7 @@ static BlockDriver bdrv_null_co = {
     .protocol_name          = "null-co",
     .instance_size          = sizeof(BDRVNullState),
 
-    .bdrv_file_open         = null_file_open,
+    .bdrv_open              = null_file_open,
     .bdrv_parse_filename    = null_co_parse_filename,
     .bdrv_co_getlength      = null_co_getlength,
     .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,
@@ -304,7 +304,7 @@ static BlockDriver bdrv_null_aio = {
     .protocol_name          = "null-aio",
     .instance_size          = sizeof(BDRVNullState),
 
-    .bdrv_file_open         = null_file_open,
+    .bdrv_open              = null_file_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
     .bdrv_co_getlength      = null_co_getlength,
     .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,
diff --git a/block/nvme.c b/block/nvme.c
index 3a3c6da73d2..c84914af6dd 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1630,7 +1630,7 @@ static BlockDriver bdrv_nvme = {
     .create_opts              = &bdrv_create_opts_simple,
 
     .bdrv_parse_filename      = nvme_parse_filename,
-    .bdrv_file_open           = nvme_file_open,
+    .bdrv_open                = nvme_file_open,
     .bdrv_close               = nvme_close,
     .bdrv_co_getlength        = nvme_co_getlength,
     .bdrv_probe_blocksizes    = nvme_probe_blocksizes,
diff --git a/block/rbd.c b/block/rbd.c
index 84bb2fa5d71..9c0fd0cb3f7 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1815,8 +1815,9 @@ static const char *const qemu_rbd_strong_runtime_opts[] = {
 static BlockDriver bdrv_rbd = {
     .format_name            = "rbd",
     .instance_size          = sizeof(BDRVRBDState),
+
     .bdrv_parse_filename    = qemu_rbd_parse_filename,
-    .bdrv_file_open         = qemu_rbd_open,
+    .bdrv_open              = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
     .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
     .bdrv_co_create         = qemu_rbd_co_create,
diff --git a/block/ssh.c b/block/ssh.c
index a88171d4b53..1344822ed85 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1362,7 +1362,7 @@ static BlockDriver bdrv_ssh = {
     .protocol_name                = "ssh",
     .instance_size                = sizeof(BDRVSSHState),
     .bdrv_parse_filename          = ssh_parse_filename,
-    .bdrv_file_open               = ssh_file_open,
+    .bdrv_open                    = ssh_file_open,
     .bdrv_co_create               = ssh_co_create,
     .bdrv_co_create_opts          = ssh_co_create_opts,
     .bdrv_close                   = ssh_close,
diff --git a/block/vvfat.c b/block/vvfat.c
index 9d050ba3aea..086fedf4745 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3258,7 +3258,7 @@ static BlockDriver bdrv_vvfat = {
     .instance_size          = sizeof(BDRVVVFATState),
 
     .bdrv_parse_filename    = vvfat_parse_filename,
-    .bdrv_file_open         = vvfat_open,
+    .bdrv_open              = vvfat_open,
     .bdrv_refresh_limits    = vvfat_refresh_limits,
     .bdrv_close             = vvfat_close,
     .bdrv_child_perm        = vvfat_child_perm,
-- 
2.45.2


