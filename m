Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B7CC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 17:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttVXY-00087b-8j; Sat, 15 Mar 2025 13:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1ttVXL-0007yK-TR; Sat, 15 Mar 2025 13:43:07 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1ttVXG-00021n-FK; Sat, 15 Mar 2025 13:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1742060568; bh=zcrxujq8oAr4C4FYOrWGAxou0NszWeHnYrryhZrzvGk=;
 h=From:To:Cc:Subject:Date;
 b=rRHZFSLTyjZl39xX2mS+swkFcS6YphWhQcVQbb2pUM5alLvoTgIKK37eF+fBlRwAD
 GGC7/ankQlWz0aH3wBf11KfPBGPOAc6Ig1GoJKc5TWzKv35heK3weeVVxffBP9PDH3
 RAWTZDgNS5ROBaL2kwYLimfxDxm8ODMpQvDLKR/Y=
Received: from localhost.localdomain ([120.46.176.49])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id 799AC488; Sun, 16 Mar 2025 01:30:25 +0800
X-QQ-mid: xmsmtpt1742059825til0gwr29
Message-ID: <tencent_C6F198B4EA3ABA591C57084BA7125D04B306@qq.com>
X-QQ-XMAILINFO: NhJmSc9h8ndd8ukIdUi1fCOcmz27QYj9qtVMSPLvPeYC6fX6Aosj0defr9LV6w
 bIpWp4cWvTcNQRuao3bDVedjCSuUxr+xs3ZIf7CIc9LnuMGiR+V4pmW04JwktJmKoz6I42nBN4D9
 Q2xjfjw6UKd9zNQsTFowI7+YvBbEWc24Pa02MP5Rka6JtKq7IiYEOSifYx39dhNA2Y7IqDw1wOrO
 mQDMAL5D1XM20qt7wTTTkRT1+wDKwkuEc+7J8vojsUOyL1kSxoEJmnZbGqL0YYkXC/Ln0fXFLN2G
 ewCMJq2VaXo91eBKxQQebOBBxrmVieJ50LnNKXoy/Ux28m2pYpiBYbwFavGBeRAp4NoqPjZzW2CU
 9ZXXIh0lsKkmINdFf1Ul8gnRPVu/ICcE3GdMvE9/esakNFLTnw9JTrzCV+kDwtzYrhsx2+Njdsyn
 ZzTLHY9sexatbfZekgQLfV/30YU0fqfSZg5ruLxfEcjjhIxfEm9RCBaCMngNZPnc/EgFKC3SRRa+
 WFLTnHFHHrPGpuHzdhq0qGYtz82G1gfLbslWzCoA3ic2XwPU/YPvyHs6tJI/xYEVnh2qtVAEefQY
 dPdW8lS0lZfZ2gXkgIQUGG/GIyq2DZBDDeDHUcUaKqxKgqyiJU3/zGpPYiuAjGd7I5VgME4Q+XBz
 BmcXbiw/7RyNFHN5XE1P8pGQve9Wyldk/2WBH+cfML3ZKancB8hw3opPQdlvRy1h0qleioGwv/Ju
 XBhLAPFAJBYGPySREJg7WYb4vthrYmzBCik3T1dQdS49wvD+oTwQgDj8FKE5LyJZUqhT13FD2SuK
 ianIiAXiYfqZ0xy2uWpy4jk5TpvQvMj7RK+WzzSZqY19XPoE4wUtR9oWmWTJiad1RhE4MOGG0qo6
 EbbXL3E+M1y3D4nYoAbeh+Xj6NBTvxtHvrk8MMLI3ZOodWglbEIm/RDnUCmOMAz8Q3/Wuc6IYpN0
 yzpwkhbfM/9t+Q8qmXsg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: saz97 <sa.z@qq.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, saz97 <sa.z@qq.com>
Subject: [PATCH RFC v2] Integration coroutines into fuse export
Date: Sun, 16 Mar 2025 01:30:20 +0800
X-OQ-MSGID: <20250315173020.52011-1-sa.z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.54; envelope-from=sa.z@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Changzhi Xie <sa.z@qq.com>

This commit refactors the FUSE export to process read and write operations
using coroutines, improving concurrency and avoiding blocking the main loop.

The main changes include:
1.  Introduce FuseIORequest structure to encapsulate I/O parameters and state
2.  Move read/write processing into coroutine fuse_read_coroutine and fuse_write_coroutine
3.  Use blk_co_pread/pwrite for async block layer access
---
 block/export/fuse.c | 189 +++++++++++++++++++++++++++++++-------------
 1 file changed, 132 insertions(+), 57 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 465cc9891d..3314f64706 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -39,6 +39,7 @@
 
 #ifdef __linux__
 #include <linux/fs.h>
+#include <linux/fuse.h>
 #endif
 
 /* Prevent overly long bounce buffer allocations */
@@ -49,7 +50,6 @@ typedef struct FuseExport {
     BlockExport common;
 
     struct fuse_session *fuse_session;
-    struct fuse_buf fuse_buf;
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
@@ -64,6 +64,14 @@ typedef struct FuseExport {
     gid_t st_gid;
 } FuseExport;
 
+typedef struct FuseIORequest {
+    fuse_req_t req;
+    size_t size;
+    off_t offset;
+    FuseExport *exp;
+    char *write_buf;
+} FuseIORequest;
+
 static GHashTable *exports;
 static const struct fuse_lowlevel_ops fuse_ops;
 
@@ -288,6 +296,7 @@ fail:
 static void read_from_fuse_export(void *opaque)
 {
     FuseExport *exp = opaque;
+    struct fuse_buf buf = {};
     int ret;
 
     blk_exp_ref(&exp->common);
@@ -295,20 +304,30 @@ static void read_from_fuse_export(void *opaque)
     qatomic_inc(&exp->in_flight);
 
     do {
-        ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
+        ret = fuse_session_receive_buf(exp->fuse_session, &buf);
     } while (ret == -EINTR);
     if (ret < 0) {
         goto out;
     }
 
-    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
+    fuse_session_process_buf(exp->fuse_session, &buf);
 
 out:
+    struct fuse_in_header *in = (struct fuse_in_header *)buf.mem;
+
+    if (in->opcode == FUSE_WRITE || in->opcode == FUSE_READ) {
+        g_free(buf.mem);
+        return;
+    }
+
     if (qatomic_fetch_dec(&exp->in_flight) == 1) {
         aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
     }
 
     blk_exp_unref(&exp->common);
+
+    g_free(buf.mem);
+
 }
 
 static void fuse_export_shutdown(BlockExport *blk_exp)
@@ -347,7 +366,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
         fuse_session_destroy(exp->fuse_session);
     }
 
-    free(exp->fuse_buf.mem);
     g_free(exp->mountpoint);
 }
 
@@ -570,102 +588,159 @@ static void fuse_open(fuse_req_t req, fuse_ino_t inode,
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
     }
 
-    ret = blk_pread(exp->common.blk, offset, size, buf, 0);
+    buffer = qemu_try_blockalign(blk_bs(exp->common.blk), io_req->size);
+    if (!buffer) {
+        fuse_reply_err(io_req->req, ENOMEM);
+        goto cleanup;
+    }
+
+    ret = blk_co_pread(exp->common.blk, io_req->offset,
+                       io_req->size, buffer, 0);
     if (ret >= 0) {
-        fuse_reply_buf(req, buf, size);
+        fuse_reply_buf(io_req->req, buffer, io_req->size);
     } else {
-        fuse_reply_err(req, -ret);
+        fuse_reply_err(io_req->req, -ret);
+    }
+
+    qemu_vfree(buffer);
+
+cleanup:
+    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
+        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
     }
 
-    qemu_vfree(buf);
+    blk_exp_unref(&exp->common);
+
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
+    }
+
+cleanup:
+    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
+        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
     }
+
+    blk_exp_unref(&exp->common);
+
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
+
+    *io_req = (FuseIORequest) {
+        .req = req,
+        .size = size,
+        .offset = offset,
+        .exp = exp,
+    };
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
+    *io_req = (FuseIORequest) {
+        .req = req,
+        .size = size,
+        .offset = offset,
+        .exp = exp,
+        .write_buf = g_memdup2_qemu(buf, size),
+    };
+
+    Coroutine *co = qemu_coroutine_create(fuse_write_coroutine, io_req);
+    qemu_coroutine_enter(co);
 }
 
 /**
-- 
2.34.1


