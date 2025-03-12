Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAD6C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLoB-0006Pr-W9; Wed, 12 Mar 2025 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1tsFUU-0007wR-Tb; Wed, 12 Mar 2025 02:22:55 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1tsFU9-0005rP-4E; Wed, 12 Mar 2025 02:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1741760534; bh=fer9u3Eyo9RhguUPg0aqgJVKB0n6DkoBDnHgRFwuAkc=;
 h=From:To:Cc:Subject:Date;
 b=rb8Q6ntqQcD4BlvsFS7sP1fqdRRCH5pADQNurmwncm6U6XmCNi43ABs6g+ddboAZE
 MwTf+uuDgFdPW++Ckg4Pjz2q5CTroFiIJuY587Hbu0d2vcXDKE2rdBkA8zX+RDCJgi
 /0wfFUkYlZp9p3GOlJyAMSMUqeRS6XdmaIwHyyOM=
Received: from localhost.localdomain ([120.46.176.49])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 58C0D488; Wed, 12 Mar 2025 14:22:12 +0800
X-QQ-mid: xmsmtpt1741760532thju2zv5y
Message-ID: <tencent_804E383A2E66E5311E555C748FB8E8109A07@qq.com>
X-QQ-XMAILINFO: M8F5Ju5R+mONNrv6JjyLwYk/x6V1b7rRZM8G0FP+XjIiws9ozm07SRv0Mf4lQR
 FjvPMgl2kQF4hO5r8Xerqf/1nxb1jlyuB0xNoTHGo812L6Kg51PwzfghHxNhVtFbUru0K97bqMV1
 Y7JoOQIDWDrMpuXQRmAljpPaaUykMcBFP8/MCs+L4+NY9GGqWYrBwo0T4xUiSs9C+8F1si2Iq2Xp
 qaaSVdy6KG45+yhC8ipnCNhm5AYL8jsLoyQc4zXYMaLAhiVKITiYP34mYh/+dmcTNiHnbILPMedC
 o8z7TP2QixxOwThMgzfB0rVmat5Xv6fDeMpNabh+V6NG+0PYa7mH59Y6BjRZAwGD69faWXuJnhYB
 E9t60UsxaUR4yLZNxrew6FFOCmGL2RFEx9eCGd6w7HkqbR0Tec/+fecEfxVgwzuMmyh38qleCdhn
 SyM4YoOpasJzpd/5ur5GS6Eh0eL2d16JgmzwpEBjrWWcIFVyFVU8MmJUvj18lWTtLs35qDq+heod
 0UUaq7QoOYIycVp5aYDZ0J7USX0TcuxP8Bzvk3HSoQ3cf+mbihmA8vADfIEXQWBQa2xCOi3tFjWb
 2w8Q+qmaZVcfCO+p0A7RcVE5E212r9dOCBEvHyFnSF3eVRxLXImttXXaADEcSLMw2+mcR00tncBp
 0SH/UwDlAQwQqhkwrFUIMeMbuoDbLRdBDxeHffJLluGgQgoUuQVpawrdljuQsd9OpIPd+PBJkGKn
 Xx32otXK63XfbxKNUlxSmEwwd5jX6b5k7iDweFvsxAhrTFFQOGQKBQr580z8X8rxow8V4ok8iEwd
 lY06DYmbp8pj5ibigjHcioGS0r9IyIBY5/W+nsnN3O8QYR7hYOqr0fGMIprHs8sCL4c9hM6yihS/
 KxAHdWDY9l78i105H1oadPSFADpTWDVQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: saz97 <sa.z@qq.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, hreitz@redhat.com,
 stefanha@redhat.com, saz97 <sa.z@qq.com>
Subject: [PATCH 1/2] Demo for integration coroutin into fuse export
Date: Wed, 12 Mar 2025 14:22:05 +0800
X-OQ-MSGID: <20250312062205.335002-1-sa.z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.47; envelope-from=sa.z@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Mar 2025 09:07:35 -0400
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

Signed-off-by: Changzhi Xie <sa.z@qq.com>
---
 block/export/fuse.c | 167 ++++++++++++++++++++++++++++++--------------
 1 file changed, 114 insertions(+), 53 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 465cc9891d..f47117a00d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -64,6 +64,16 @@ typedef struct FuseExport {
     gid_t st_gid;
 } FuseExport;
 
+typedef struct FuseIORequest {
+    fuse_req_t req;
+    fuse_ino_t inode;
+    size_t size;
+    off_t offset;
+    struct fuse_file_info *fi;
+    FuseExport *exp;
+    char *write_buf;
+} FuseIORequest;
+
 static GHashTable *exports;
 static const struct fuse_lowlevel_ops fuse_ops;
 
@@ -570,102 +580,153 @@ static void fuse_open(fuse_req_t req, fuse_ino_t inode,
     fuse_reply_open(req, fi);
 }
 
-/**
- * Handle client reads from the exported image.
- */
-static void fuse_read(fuse_req_t req, fuse_ino_t inode,
-                      size_t size, off_t offset, struct fuse_file_info *fi)
+static void coroutine_fn fuse_read_coroutine(void *opaque)
 {
-    FuseExport *exp = fuse_req_userdata(req);
+    FuseIORequest *io_req = opaque;
+    FuseExport *exp = io_req->exp;
     int64_t length;
-    void *buf;
+    void *buffer;
     int ret;
 
-    /* Limited by max_read, should not happen */
-    if (size > FUSE_MAX_BOUNCE_BYTES) {
-        fuse_reply_err(req, EINVAL);
-        return;
+    if (io_req->size > FUSE_MAX_BOUNCE_BYTES) {
+        fuse_reply_err(io_req->req, EINVAL);
+        goto cleanup;
     }
 
-    /**
-     * Clients will expect short reads at EOF, so we have to limit
-     * offset+size to the image length.
-     */
     length = blk_getlength(exp->common.blk);
     if (length < 0) {
-        fuse_reply_err(req, -length);
-        return;
+        fuse_reply_err(io_req->req, -length);
+        goto cleanup;
     }
 
-    if (offset + size > length) {
-        size = length - offset;
+    if (io_req->offset + io_req->size > length) {
+        io_req->size = length - io_req->offset;
     }
 
-    buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
-    if (!buf) {
-        fuse_reply_err(req, ENOMEM);
-        return;
+    if (io_req->size == 0) {
+        fuse_reply_buf(io_req->req, NULL, 0);
+        goto cleanup;
+    }
+
+    buffer = qemu_try_blockalign(blk_bs(exp->common.blk), io_req->size);
+    if (!buffer) {
+        fuse_reply_err(io_req->req, ENOMEM);
+        goto cleanup;
     }
 
-    ret = blk_pread(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pread(exp->common.blk, io_req->offset,
+                       io_req->size, buffer, 0);
     if (ret >= 0) {
-        fuse_reply_buf(req, buf, size);
+        fuse_reply_buf(io_req->req, buffer, io_req->size);
     } else {
-        fuse_reply_err(req, -ret);
+        fuse_reply_err(io_req->req, -ret);
     }
 
-    qemu_vfree(buf);
+    qemu_vfree(buffer);
+
+cleanup:
+    g_free(io_req);
 }
 
-/**
- * Handle client writes to the exported image.
- */
-static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
-                       size_t size, off_t offset, struct fuse_file_info *fi)
+static void coroutine_fn fuse_write_coroutine(void *opaque)
 {
-    FuseExport *exp = fuse_req_userdata(req);
+    FuseIORequest *io_req = opaque;
+    FuseExport *exp = io_req->exp;
     int64_t length;
     int ret;
 
-    /* Limited by max_write, should not happen */
-    if (size > BDRV_REQUEST_MAX_BYTES) {
-        fuse_reply_err(req, EINVAL);
-        return;
+    if (io_req->size > BDRV_REQUEST_MAX_BYTES) {
+        fuse_reply_err(io_req->req, EINVAL);
+        goto cleanup;
     }
 
     if (!exp->writable) {
-        fuse_reply_err(req, EACCES);
-        return;
+        fuse_reply_err(io_req->req, EACCES);
+        goto cleanup;
     }
 
-    /**
-     * Clients will expect short writes at EOF, so we have to limit
-     * offset+size to the image length.
-     */
     length = blk_getlength(exp->common.blk);
     if (length < 0) {
-        fuse_reply_err(req, -length);
-        return;
+        fuse_reply_err(io_req->req, -length);
+        goto cleanup;
     }
 
-    if (offset + size > length) {
+    if (io_req->offset + io_req->size > length) {
         if (exp->growable) {
-            ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
+            ret = fuse_do_truncate(exp, io_req->offset + io_req->size,
+                                   true, PREALLOC_MODE_OFF);
             if (ret < 0) {
-                fuse_reply_err(req, -ret);
-                return;
+                fuse_reply_err(io_req->req, -ret);
+                goto cleanup;
             }
         } else {
-            size = length - offset;
+            io_req->size = MAX(0, length - io_req->offset);
+            if (io_req->size == 0) {
+                fuse_reply_write(io_req->req, 0);
+                goto cleanup;
+            }
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pwrite(exp->common.blk, io_req->offset, io_req->size,
+                        io_req->write_buf, 0);
     if (ret >= 0) {
-        fuse_reply_write(req, size);
+        fuse_reply_write(io_req->req, io_req->size);
     } else {
-        fuse_reply_err(req, -ret);
+        fuse_reply_err(io_req->req, -ret);
     }
+
+cleanup:
+    g_free(io_req->write_buf);
+    g_free(io_req);
+}
+
+/**
+ * Handle client reads from the exported image.
+ */
+static void fuse_read(fuse_req_t req, fuse_ino_t inode,
+                      size_t size, off_t offset, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    FuseIORequest *io_req = g_new(FuseIORequest, 1);
+    io_req->req = req;
+    io_req->inode = inode;
+    io_req->size = size;
+    io_req->offset = offset;
+    io_req->fi = fi;
+    io_req->exp = exp;
+
+    Coroutine *co = qemu_coroutine_create(fuse_read_coroutine, io_req);
+    qemu_coroutine_enter(co);
+}
+
+
+/**
+ * Handle client writes to the exported image.
+ */
+static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
+                       size_t size, off_t offset, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    FuseIORequest *io_req = g_new(FuseIORequest, 1);
+
+    io_req->write_buf = g_try_malloc(size);
+    if (!io_req->write_buf) {
+        fuse_reply_err(req, ENOMEM);
+        g_free(io_req);
+        return;
+    }
+    memcpy(io_req->write_buf, buf, size);
+
+    io_req->req = req;
+    io_req->inode = inode;
+    io_req->size = size;
+    io_req->offset = offset;
+    io_req->fi = fi;
+    io_req->exp = exp;
+
+    Coroutine *co = qemu_coroutine_create(fuse_write_coroutine, io_req);
+    qemu_coroutine_enter(co);
 }
 
 /**
-- 
2.34.1


From 3d2d317a49eb4cbf401294c6e19c72533eeeefad Mon Sep 17 00:00:00 2001
From: saz97 <sa.z@qq.com>
Date: Wed, 12 Mar 2025 13:47:01 +0800
Subject: [PATCH 2/2] allocate independent fuse_buffor each coroutine and store
 fuse_file_info copy instead of pointerin FuseIORequest

Signed-off-by: Changzhi Xie <sa.z@qq.com>
---
 block/export/fuse.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index f47117a00d..69ffe4f0ca 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -69,7 +69,7 @@ typedef struct FuseIORequest {
     fuse_ino_t inode;
     size_t size;
     off_t offset;
-    struct fuse_file_info *fi;
+    struct fuse_file_info fi;
     FuseExport *exp;
     char *write_buf;
 } FuseIORequest;
@@ -298,6 +298,10 @@ fail:
 static void read_from_fuse_export(void *opaque)
 {
     FuseExport *exp = opaque;
+    struct fuse_buf buf = {
+        .mem = g_malloc(FUSE_MAX_BOUNCE_BYTES),
+        .size = FUSE_MAX_BOUNCE_BYTES,
+    };
     int ret;
 
     blk_exp_ref(&exp->common);
@@ -314,6 +318,7 @@ static void read_from_fuse_export(void *opaque)
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
+    g_free(buf.mem);
     if (qatomic_fetch_dec(&exp->in_flight) == 1) {
         aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
     }
@@ -689,12 +694,15 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
 {
     FuseExport *exp = fuse_req_userdata(req);
     FuseIORequest *io_req = g_new(FuseIORequest, 1);
-    io_req->req = req;
-    io_req->inode = inode;
-    io_req->size = size;
-    io_req->offset = offset;
-    io_req->fi = fi;
-    io_req->exp = exp;
+
+    *io_req = (FuseIORequest) {
+        .req = req,
+        .inode = inode,
+        .size = size,
+        .offset = offset,
+        .exp = exp,
+        .fi = *fi,
+    };
 
     Coroutine *co = qemu_coroutine_create(fuse_read_coroutine, io_req);
     qemu_coroutine_enter(co);
@@ -710,20 +718,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
     FuseExport *exp = fuse_req_userdata(req);
     FuseIORequest *io_req = g_new(FuseIORequest, 1);
 
-    io_req->write_buf = g_try_malloc(size);
-    if (!io_req->write_buf) {
-        fuse_reply_err(req, ENOMEM);
-        g_free(io_req);
-        return;
-    }
-    memcpy(io_req->write_buf, buf, size);
-
-    io_req->req = req;
-    io_req->inode = inode;
-    io_req->size = size;
-    io_req->offset = offset;
-    io_req->fi = fi;
-    io_req->exp = exp;
+    *io_req = (FuseIORequest) {
+        .req = req,
+        .inode = inode,
+        .size = size,
+        .offset = offset,
+        .exp = exp,
+        .fi = *fi,
+        .write_buf = g_memdup2_qemu(buf, size),
+    };
 
     Coroutine *co = qemu_coroutine_create(fuse_write_coroutine, io_req);
     qemu_coroutine_enter(co);
-- 
2.34.1


