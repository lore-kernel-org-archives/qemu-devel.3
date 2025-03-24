Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70114C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twcqs-0003ay-8z; Mon, 24 Mar 2025 04:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1twcqn-0003aB-DV; Mon, 24 Mar 2025 04:08:01 -0400
Received: from out203-205-221-235.mail.qq.com ([203.205.221.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1twcqj-0006wY-8J; Mon, 24 Mar 2025 04:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1742803660; bh=sDm5F++MQx8tv1ijd6HJU2F5moglJ2hGeXZ1HHaAySQ=;
 h=From:To:Cc:Subject:Date;
 b=Kz1ggdHBFTgsKdwLF7q6nl9qfaGnbrT9VPyo17EQmCiN4u8Mz9eDqswcr5kc7oZGX
 3IX3ix+pRWZeQmOAzhMRK5oa4SgHAga6QhvKA7gPk2sglAlS2q75QhFR7i5V7JMhN2
 fGM0MAWIoXRGY9y6rjalRMskpqtT6ff4pYSx0z/4=
Received: from localhost.localdomain ([120.46.176.49])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id 1E686019; Mon, 24 Mar 2025 16:07:38 +0800
X-QQ-mid: xmsmtpt1742803658t4zc496o2
Message-ID: <tencent_4F432E3A4DE9149849C736550BD0FDE2BE09@qq.com>
X-QQ-XMAILINFO: MgRVKi3YcRBIli7uSvWfJGahoZkvYcAvAtcpkDIMV30MfMdHBijWQvJfmUbbBA
 mp8OjttE5JerAyEe7A9JQIXpicFiKlXr1JUm8WhlRrImq1UFvcxHg20P8MJIoTKq5NQmBq5QXfa6
 4zGC7guitXN+oGajueeL88701F6oUUuK6a5RPOkoh6WO1HduyuSjILik31p+CdLh7C/6yj1HJMg+
 av3zasva/LwCNFhyp+X6dCwihGPwui9bzeFSrkvSy2n2JV1BQc+XSaBjOoLxNaKfUiXtPqG4cgNJ
 GLSQbbwgZUYfgmQLeaBWQKH1G8St/eww8oBRvDfoyq1yCs/bzJqhOcCfGnQC033gmNAgfqH+xfJY
 3krNHdXzRxXYhe/uSG519BXQeDMNWLszPAAgyOrYG+H0XK0wMqwz8YnUu/M03MeK+AfeEEgf7laV
 JTQo2DHZnLiHDa3GZVENOPsEOhk5a4uGJYUD6CBxSVZdf/VARiRcFwL0eBQVrYFsD2Fmzfkj9uHV
 Gb8FLUdLprkPgOCCcLvdCug+Cp4pQqQZnNnyhmXu/xhK1ByN+wqRe0V2JYvnPAZg611mqDy110Jk
 5Jw5anXD+Tw/n6vRmPp6L7yWROy8jY5H5E8lokNW7W0jX9q/Mxj23QSY3lb7PBbbeK/SxVKoE+c2
 H746/2PkSnKKs1IT4m8M7pdONfj3DpCjdHe1vyCnxZmZp01XaLy76TrRd/mrkDmvGpwmZbkhyCCe
 +8vqTtuA4leZH5Qx6VwEp5Yu7+X/HoRlQuw5xJt70oLrfBhdjqsJ3w7OuT2cuy3vmRLbtoydaKIF
 ADIBTqjNMSZLwr/1lHiQ4KPPvGTI0T5DSitF4AjF0d51guELbXnGDZdfuON8nfmGyegSsqHw7GL8
 IdSSAoGHKW3FVGYGsjh0Rh3SJUI7eO8v7ReklZoV4/iViLQomauI7yegd+PzedkA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: saz97 <sa.z@qq.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, saz97 <sa.z@qq.com>
Subject: [PATCH 1/1 RFC V3] Integration coroutines into fuse export
Date: Mon, 24 Mar 2025 16:07:31 +0800
X-OQ-MSGID: <20250324080731.150678-1-sa.z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.235; envelope-from=sa.z@qq.com;
 helo=out203-205-221-235.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
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

Signed-off-by: Changzhi Xie <sa.z@qq.com>

This commit refactors the FUSE export to process read and write operations
using coroutines, improving concurrency and avoiding blocking the main loop.

The main changes include:
1.  Move read_from_fuse_export into coroutine
2.  Move read/write processing into coroutine fuse_read_coroutine and fuse_write_coroutine
3.  Remove fuse_buf from FuseExport, and have a separate struct fuse_buf for every request
---
 block/export/fuse.c | 188 +++++++++++++++++++++++++++++---------------
 1 file changed, 125 insertions(+), 63 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 465cc9891d..896cb55e3a 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -49,7 +49,6 @@ typedef struct FuseExport {
     BlockExport common;
 
     struct fuse_session *fuse_session;
-    struct fuse_buf fuse_buf;
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
@@ -64,6 +63,14 @@ typedef struct FuseExport {
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
 
@@ -281,13 +288,10 @@ fail:
     return ret;
 }
 
-/**
- * Callback to be invoked when the FUSE session FD can be read from.
- * (This is basically the FUSE event loop.)
- */
-static void read_from_fuse_export(void *opaque)
+static void coroutine_fn read_from_fuse_export_coroutine(void *opaque)
 {
     FuseExport *exp = opaque;
+    struct fuse_buf buf = {};
     int ret;
 
     blk_exp_ref(&exp->common);
@@ -295,13 +299,13 @@ static void read_from_fuse_export(void *opaque)
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
     if (qatomic_fetch_dec(&exp->in_flight) == 1) {
@@ -309,6 +313,20 @@ out:
     }
 
     blk_exp_unref(&exp->common);
+
+    free(buf.mem);
+
+}
+
+/**
+ * Callback to be invoked when the FUSE session FD can be read from.
+ * (This is basically the FUSE event loop.)
+ */
+static void read_from_fuse_export(void *opaque)
+{
+    Coroutine *co;
+    co = qemu_coroutine_create(read_from_fuse_export_coroutine, opaque);
+    qemu_coroutine_enter(co);
 }
 
 static void fuse_export_shutdown(BlockExport *blk_exp)
@@ -347,7 +365,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
         fuse_session_destroy(exp->fuse_session);
     }
 
-    free(exp->fuse_buf.mem);
     g_free(exp->mountpoint);
 }
 
@@ -417,7 +434,7 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
         return;
     }
 
-    allocated_blocks = bdrv_get_allocated_file_size(blk_bs(exp->common.blk));
+    allocated_blocks = bdrv_co_get_allocated_file_size(blk_bs(exp->common.blk));
     if (allocated_blocks <= 0) {
         allocated_blocks = DIV_ROUND_UP(length, 512);
     } else {
@@ -570,102 +587,147 @@ static void fuse_open(fuse_req_t req, fuse_ino_t inode,
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


