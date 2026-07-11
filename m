Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF1CC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifkW-0002Mn-PH; Sat, 11 Jul 2026 18:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifkQ-0002D2-7P; Sat, 11 Jul 2026 18:00:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifkO-0007y6-8L; Sat, 11 Jul 2026 18:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=32ly9JrxztZXfXdc+BkSY9lrMxJh2P7wCEom8Eu27FA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PzcljL8B1XrfF9prI//dLoo+kZpMJ0Xb3o2l5oo/RlyzRTEljHd6Jyd7IzEMkyhz5
 piJBgqze0vzWxnVUAKPVjS/tmmBWWfk7epN1BlG9zQ0boOPa3nUWsh9VJORvjr15RG
 tAgqRhPj8yKoLjczIaI4MKJohNOOFVNIvPpD1QZ9oQHcTRt7MMk6w0CRFraMGW5iKu
 Gc9YDovpG425TrEMDTGodhJge+zA2177at9iG0IG/knjUqJPRuk3mEydq2M66yi3Og
 TkIAp+HbxHtTZzGSW4QZRqm8CL4e0/0wbNmKj2pnUy1XueflHXDyGzTb9WdEcbznxI
 Alh9SVfNz3zDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50F831C0A98;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 087AC3EAF23;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 54D0A132FD; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 13/81] hw/9pfs: add max_xattr option
Date: Sun, 12 Jul 2026 00:57:51 +0300
Message-ID: <20260711215904.3757-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Previous patch introduced a limit of max. 1024 simultaneous xattr FIDs.

This patch introduces an option "max_attr" that allows to override this
limit, just for the case that some user might run into this limit for
some reason, even if unlikely; or for reducing the limit further down
(e.g. that default limit of 1024 would cap at max. 64 MiB host memory,
at least on Linux hosts where the limit per xattr is 64k).

This new "max_xattr" option can be specified with both -fsdev and
-virtfs command line options, with the "local" and the "synth" fs
drivers.

The previous limit of 1024 is preserved as the default value.

Link: https://lore.kernel.org/qemu-devel/b7631ac0d8dde0629bc7c4f2c4185d9f57b962b4.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit e6116a81f04c48af9530d984d16ef4ed4346e865)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 454761d81d7..1d931144f40 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -101,6 +101,8 @@ typedef struct FsDriverEntry {
     FsThrottle fst;
     mode_t fmode;
     mode_t dmode;
+    /* temporary storage for parse_opts only */
+    uint32_t max_xattr;
 } FsDriverEntry;
 
 struct FsContext {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 07a18c6e48d..c2c1e83611b 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -46,6 +46,9 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "max_xattr",
+            .type = QEMU_OPT_NUMBER,
         },
 
         THROTTLE_OPTS,
@@ -92,6 +95,9 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "max_xattr",
+            .type = QEMU_OPT_NUMBER,
         },
 
         { /*End of list */ }
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 57877dad0a7..f97103cf442 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -45,7 +45,7 @@ typedef struct FsDriverListEntry {
 static QTAILQ_HEAD(, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
 
-#define COMMON_FS_DRIVER_OPTIONS "id", "fsdriver", "readonly"
+#define COMMON_FS_DRIVER_OPTIONS "id", "fsdriver", "readonly", "max_xattr"
 
 static FsDriverTable FsDrivers[] = {
     {
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index aa48306b0ee..4708e170a42 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1527,6 +1527,15 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     const char *path = qemu_opt_get(opts, "path");
     const char *multidevs = qemu_opt_get(opts, "multidevs");
 
+    uint64_t val = qemu_opt_get_number(opts, "max_xattr",
+                                       V9FS_MAX_XATTR_DEFAULT);
+    if (val > UINT32_MAX) {
+        error_setg(errp, "max_xattr value '%s' too large",
+                   qemu_opt_get(opts, "max_xattr"));
+        return -1;
+    }
+    fse->max_xattr = val;
+
     if (!sec_model) {
         error_setg(errp, "security_model property not set");
         error_append_security_model_hint(errp);
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index b3743f61696..322dc3bb690 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -25,6 +25,8 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/cutils.h"
 #include "system/qtest.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
 
 /* Root node for synth file system */
 static V9fsSynthNode synth_root = {
@@ -629,12 +631,27 @@ static int synth_init(FsContext *ctx, Error **errp)
     return 0;
 }
 
+static int synth_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
+{
+    uint64_t val = qemu_opt_get_number(opts, "max_xattr",
+                                       V9FS_MAX_XATTR_DEFAULT);
+    if (val > UINT32_MAX) {
+        error_setg(errp, "max_xattr value '%s' too large",
+                   qemu_opt_get(opts, "max_xattr"));
+        return -1;
+    }
+    fse->max_xattr = val;
+
+    return 0;
+}
+
 static bool synth_has_valid_file_handle(int fid_type, V9fsFidOpenState *fs)
 {
     return false;
 }
 
 FileOperations synth_ops = {
+    .parse_opts   = synth_parse_opts,
     .init         = synth_init,
     .lstat        = synth_lstat,
     .readlink     = synth_readlink,
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 437588f9d5c..1b064a27fc5 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4505,8 +4505,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->reclaiming = false;
 
-    /* init xattr FID limit */
-    s->ctx.xattr_fid_limit = V9FS_MAX_XATTR_DEFAULT;
+    /* init xattr FID limit from fsdev config */
+    s->ctx.xattr_fid_limit = fse->max_xattr;
     s->ctx.xattr_fid_count = 0;
 
     rc = 0;
diff --git a/system/vl.c b/system/vl.c
index 246623b3196..806327bd39a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3254,7 +3254,7 @@ void qemu_init(int argc, char **argv)
                 QemuOpts *fsdev;
                 QemuOpts *device;
                 const char *writeout, *sock_fd, *socket, *path, *security_model,
-                           *multidevs;
+                           *multidevs, *max_xattr_str;
 
                 olist = qemu_find_opts("virtfs");
                 if (!olist) {
@@ -3318,6 +3318,11 @@ void qemu_init(int argc, char **argv)
                 if (multidevs) {
                     qemu_opt_set(fsdev, "multidevs", multidevs, &error_abort);
                 }
+                max_xattr_str = qemu_opt_get(opts, "max_xattr");
+                if (max_xattr_str) {
+                    qemu_opt_set(fsdev, "max_xattr", max_xattr_str,
+                                 &error_abort);
+                }
                 device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
                                           &error_abort);
                 qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-- 
2.47.3


