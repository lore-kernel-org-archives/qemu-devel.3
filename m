Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43873C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCD0-0005EW-AS; Mon, 29 Jun 2026 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6116a81f04c48af9530d984d16ef4ed4346e865@kylie.crudebyte.com>)
 id 1weCCy-00059W-3E; Mon, 29 Jun 2026 09:39:32 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6116a81f04c48af9530d984d16ef4ed4346e865@kylie.crudebyte.com>)
 id 1weCCw-0004SB-8K; Mon, 29 Jun 2026 09:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=0lgtlrURqWz5Gn2WSuhieTwwdPcSyX0FnmFV4/UGTHg=; b=I3uiS
 h6LI1lvorb0P2DPHgxm1slY4PDz76HyfXjhAIK/BJs1rT3/FhqtDvTFE37rPW9EKTpmod+ShQlbmj
 9cV8K9rfy5YOonU7+Hyr5EN/v6dxhiW82luu933UJr5ly9+rwUELlq5QOhzUKAei/t1Dvo21VGHde
 mg2PWfNdlLvhP+WEkAaS4IV8aEuRh58CJDCGYvfxIBGJwO0hUCe/Dd0Z4ywT5diW7LUzlqibHOM0B
 ulZtowNOGLYPeKkePaGEiSBKFZq57STEW3TjopD6AHw/wGscAkq7K6rflH2TwSKE/h63YHvdaiQbM
 jNwAeMqfi3TTGIdLiL7InJR6py4y1LSWRqenmA2qP2e8VGFY5uYd+ivFpxVpMrtCjUJmYtlhDOgV0
 69Cs1P6xDue/syJv5DybmgBkv6mE2gO7cWBs+5Oqpc+mIeunt2uhhLNt2a29bRMo/pF8J//qpbvif
 iME2RMX8ODYCJ49jXm36Ueif4nn54KawAh8/BpV4glmKc81RUYsd9kxdypAAUsLiVHeJTLlAQA7td
 /5Ya9WR0MntO0+KObwGWbYUd3AqfSt5pTAhEuhpMuPlw0JSgETXqopAmEfAHeNphWOqPdxfL+fS3f
 VjSrFbLlIVVPyHvKj/Yd7qbnBO+Pb7VVGG/JdcFk/UyefY0nXUtukzKOTe5hB8=;
Message-ID: <e6116a81f04c48af9530d984d16ef4ed4346e865.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 10/23] hw/9pfs: add max_xattr option
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=e6116a81f04c48af9530d984d16ef4ed4346e865@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 fsdev/file-op-9p.h      |  2 ++
 fsdev/qemu-fsdev-opts.c |  6 ++++++
 fsdev/qemu-fsdev.c      |  2 +-
 hw/9pfs/9p-local.c      |  9 +++++++++
 hw/9pfs/9p-synth.c      | 17 +++++++++++++++++
 hw/9pfs/9p.c            |  4 ++--
 system/vl.c             |  7 ++++++-
 7 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 454761d81d..1d931144f4 100644
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
index 07a18c6e48..c2c1e83611 100644
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
index 57877dad0a..f97103cf44 100644
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
index aa48306b0e..4708e170a4 100644
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
index b3743f6169..322dc3bb69 100644
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
index e737629581..d1ec3c0c14 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4483,8 +4483,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->reclaiming = false;
 
-    /* init xattr FID limit */
-    s->ctx.xattr_fid_limit = V9FS_MAX_XATTR_DEFAULT;
+    /* init xattr FID limit from fsdev config */
+    s->ctx.xattr_fid_limit = fse->max_xattr;
     s->ctx.xattr_fid_count = 0;
 
     rc = 0;
diff --git a/system/vl.c b/system/vl.c
index 1c0da7df29..1d14e2e207 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3260,7 +3260,7 @@ void qemu_init(int argc, char **argv)
                 QemuOpts *fsdev;
                 QemuOpts *device;
                 const char *writeout, *sock_fd, *socket, *path, *security_model,
-                           *multidevs;
+                           *multidevs, *max_xattr_str;
 
                 olist = qemu_find_opts("virtfs");
                 if (!olist) {
@@ -3324,6 +3324,11 @@ void qemu_init(int argc, char **argv)
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


