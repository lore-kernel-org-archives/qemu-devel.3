Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B04AC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBo-0000kT-Sv; Wed, 04 Jun 2025 09:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBF-0007Vd-Jd
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBC-0004ow-Ig
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYgzoamigJ65sPztnH94WA7ARVDEqmnvP0auSWkmL2Y=;
 b=Grbl/pBpDEmIezuD8eneL5lXZ2KeAb9/DWmrTVAmo3F39VTJo5fTw14r3LgJNxm6meOy7T
 dxuqTuenSKe4VQXYaUVTFaajgYR3may7CL/qw6PEDz7PZ3UpZsTadjngjXNzWWCy+5daTK
 VU5dj9PPy0+vmPc8OroYzeuJjDkiaks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-BE49NyxeOJSlA98sRC6VHg-1; Wed, 04 Jun 2025 09:29:16 -0400
X-MC-Unique: BE49NyxeOJSlA98sRC6VHg-1
X-Mimecast-MFC-AGG-ID: BE49NyxeOJSlA98sRC6VHg_1749043755
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d57a0641so46679825e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043755; x=1749648555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYgzoamigJ65sPztnH94WA7ARVDEqmnvP0auSWkmL2Y=;
 b=LKcofGq/FbgyE5heyagwiW4mv1KKbh2j1L27zfETb5MUAaHy4ckhdN/r+/4P/0AngL
 6JurpSnMlUQ4Dljv05fM60qf+8+gN/5I1g0uIBS0/vOykXzFEWgt8SwGOyfxAUIdcSLf
 bWv3JWxOkM2DlP4ufOLiUctk+qJygE24JTXFAre4qZjuAJEtCK+J1jsY7HYxkK01LDD2
 BGeV7aQbCDkR+IvBmnccc0uaAS2rk4OdAfH90M4sRSDJqZ6lbsa3m2LiBi3d+zj9h/X/
 T5kQp7E6IinOcXCV9ngRFnZQeO10Mgpa7Ap23wuBjLInIUMSkmG4+IujfpwOMN08Qkbi
 2Czg==
X-Gm-Message-State: AOJu0YzHf7wlnM0P/JoMgKLVEh03eTp59rkSq7W8tFXvwaZPyN5zTKHR
 5RCQfV4/A0onhZLBnvV+tIp0NEJjZ01bzRGjxKqc1fCReSQr5HIzQcfmYT/ohqz1opQvphSl1ku
 PUVu12mzFsgdJveuZ2N7qrio1gxcCuBoOuCWEVDTtlaMXZRuZZPmYFUXw
X-Gm-Gg: ASbGncu4KiLtGG/0FRNAsyL+6c8IfjM55pPYIPQGjOuBndanuwqKXvw+zLVFO0i5okw
 wTC+6fqrBhcow9tB2g2yftcTVqQOegFnu3quDcs0cYNFVMpFMTk+mifoiAN8YBA829IpDVNDt00
 TrT6UJWsokPpALtYp0dxtWaJRsEm7ib7QXc0tm/b6FO//gmwFhk+y6gJvbKEPycTo9UgvxrNFnY
 wQG1seXl7xuwgWLu3PqCYqBloVvVbj3kgc83DqY9wTp8upwI7UbfD/KoJQiBVIHppWsy0ufCYmW
 7+9ZZ04kKUThQHjeHqI6MgnfRAO7npK8HIbWeJzmfjvRM0ziaRQGe4RIr03Og3mg0ejLEg==
X-Received: by 2002:a05:600c:828f:b0:43d:ac5:11e8 with SMTP id
 5b1f17b1804b1-451f0b26621mr20612045e9.21.1749043754666; 
 Wed, 04 Jun 2025 06:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHojcYhzz8M/VhB9/UDQ/JmZsr4gwLdPi9PdM4tgiZPNby7Vr3LHfVKNUWh0/m1v8PuSg2BQ==
X-Received: by 2002:a05:600c:828f:b0:43d:ac5:11e8 with SMTP id
 5b1f17b1804b1-451f0b26621mr20611685e9.21.1749043754125; 
 Wed, 04 Jun 2025 06:29:14 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a00d4sm22091996f8f.92.2025.06.04.06.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:11 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 15/21] fuse: Process requests in coroutines
Date: Wed,  4 Jun 2025 15:28:07 +0200
Message-ID: <20250604132813.359438-16-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Make fuse_process_request() a coroutine_fn (fuse_co_process_request())
and have read_from_fuse_fd() launch it inside of a newly created
coroutine instead of running it synchronously.  This way, we can process
requests in parallel.

These are the benchmark results, compared to (a) the original results
with libfuse, and (b) the results after switching away from libfuse
(i.e. before this patch):

file:                  (vs. libfuse / vs. no libfuse)
  read:
    seq aio:   120.6k ±1.1k (+ 53 % / + 58 %)
    rand aio:  113.3k ±5.9k (+188 % / +325 %)
    seq sync:   52.4k ±0.4k (+ 61 % / + 10 %)
    rand sync:  10.4k ±0.4k (+  6 % / +  3 %)
  write:
    seq aio:    79.8k ±0.8k (+ 29 % / + 37 %)
    rand aio:   79.0k ±0.6k (+ 29 % / + 36 %)
    seq sync:   41.5k ±0.3k (+ 49 % / + 15 %)
    rand sync:  41.4k ±0.2k (+ 50 % / + 15 %)
null:
  read:
    seq aio:   266.1k ±1.5k (+ 24 % / -  1 %)
    rand aio:  264.1k ±2.5k (+ 24 % / ±  0 %)
    seq sync:  135.6k ±3.2k (+ 50 % / +  1 %)
    rand sync: 134.7k ±3.0k (+ 50 % / +  2 %)
  write:
    seq aio:   281.0k ±1.8k (+ 38 % / +  2 %)
    rand aio:  288.1k ±6.1k (+ 43 % / +  6 %)
    seq sync:  142.2k ±3.1k (+ 65 % / +  9 %)
    rand sync: 141.1k ±2.9k (+ 66 % / + 11 %)

So for non-AIO cases (and the null driver, which does not yield), there
is little change; but for file AIO, results greatly improve, resolving
the performance issue we saw before (when switching away from libfuse).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 194 ++++++++++++++++++++++++++------------------
 1 file changed, 113 insertions(+), 81 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index ec3a307229..75d80da616 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -27,6 +27,7 @@
 #include "block/qapi.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
+#include "qemu/coroutine.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/block-backend.h"
@@ -86,6 +87,12 @@ typedef struct FuseExport {
     gid_t st_gid;
 } FuseExport;
 
+/* Parameters to the request processing coroutine */
+typedef struct FuseRequestCoParam {
+    FuseExport *exp;
+    int got_request;
+} FuseRequestCoParam;
+
 static GHashTable *exports;
 
 static void fuse_export_shutdown(BlockExport *exp);
@@ -99,7 +106,7 @@ static int mount_fuse_export(FuseExport *exp, Error **errp);
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
-static void fuse_process_request(FuseExport *exp);
+static void coroutine_fn fuse_co_process_request(FuseExport *exp);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -346,17 +353,20 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
 }
 
 /**
- * Try to read and process a single request from the FUSE FD.
+ * Try to read a single request from the FUSE FD.
+ * Takes a FuseExport pointer in `opaque`.
+ *
+ * Assumes the export's in-flight counter has already been incremented.
+ *
+ * If a request is available, process it.
  */
-static void read_from_fuse_fd(void *opaque)
+static void coroutine_fn co_read_from_fuse_fd(void *opaque)
 {
     FuseExport *exp = opaque;
     int fuse_fd = exp->fuse_fd;
     ssize_t ret;
     const struct fuse_in_header *in_hdr;
 
-    fuse_inc_in_flight(exp);
-
     if (unlikely(exp->halted)) {
         goto no_request;
     }
@@ -391,12 +401,28 @@ static void read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    fuse_process_request(exp);
+    fuse_co_process_request(exp);
 
 no_request:
     fuse_dec_in_flight(exp);
 }
 
+/**
+ * Try to read and process a single request from the FUSE FD.
+ * (To be used as a handler for when the FUSE FD becomes readable.)
+ * Takes a FuseExport pointer in `opaque`.
+ */
+static void read_from_fuse_fd(void *opaque)
+{
+    FuseExport *exp = opaque;
+    Coroutine *co;
+
+    co = qemu_coroutine_create(co_read_from_fuse_fd, exp);
+    /* Decremented by co_read_from_fuse_fd() */
+    fuse_inc_in_flight(exp);
+    qemu_coroutine_enter(co);
+}
+
 static void fuse_export_shutdown(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
@@ -470,8 +496,9 @@ static bool is_regular_file(const char *path, Error **errp)
  * Process FUSE INIT.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
-                         uint32_t max_readahead, uint32_t flags)
+static ssize_t coroutine_fn
+fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
+             uint32_t max_readahead, uint32_t flags)
 {
     const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
 
@@ -510,17 +537,18 @@ static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
  * Let clients get file attributes (i.e., stat() the file).
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
+static ssize_t coroutine_fn
+fuse_co_getattr(FuseExport *exp, struct fuse_attr_out *out)
 {
     int64_t length, allocated_blocks;
     time_t now = time(NULL);
 
-    length = blk_getlength(exp->common.blk);
+    length = blk_co_getlength(exp->common.blk);
     if (length < 0) {
         return length;
     }
 
-    allocated_blocks = bdrv_get_allocated_file_size(blk_bs(exp->common.blk));
+    allocated_blocks = bdrv_co_get_allocated_file_size(blk_bs(exp->common.blk));
     if (allocated_blocks <= 0) {
         allocated_blocks = DIV_ROUND_UP(length, 512);
     } else {
@@ -547,8 +575,9 @@ static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
     return sizeof(*out);
 }
 
-static int fuse_do_truncate(const FuseExport *exp, int64_t size,
-                            bool req_zero_write, PreallocMode prealloc)
+static int coroutine_fn
+fuse_co_do_truncate(const FuseExport *exp, int64_t size, bool req_zero_write,
+                    PreallocMode prealloc)
 {
     uint64_t blk_perm, blk_shared_perm;
     BdrvRequestFlags truncate_flags = 0;
@@ -577,8 +606,8 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
         }
     }
 
-    ret = blk_truncate(exp->common.blk, size, true, prealloc,
-                       truncate_flags, NULL);
+    ret = blk_co_truncate(exp->common.blk, size, true, prealloc,
+                          truncate_flags, NULL);
 
     if (add_resize_perm) {
         /* Must succeed, because we are only giving up the RESIZE permission */
@@ -599,9 +628,9 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
  * they cannot be given non-owner access.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
-                            uint32_t to_set, uint64_t size, uint32_t mode,
-                            uint32_t uid, uint32_t gid)
+static ssize_t coroutine_fn
+fuse_co_setattr(FuseExport *exp, struct fuse_attr_out *out, uint32_t to_set,
+                uint64_t size, uint32_t mode, uint32_t uid, uint32_t gid)
 {
     int supported_attrs;
     int ret;
@@ -638,7 +667,7 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
             return -EACCES;
         }
 
-        ret = fuse_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
+        ret = fuse_co_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
         if (ret < 0) {
             return ret;
         }
@@ -657,7 +686,7 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
         exp->st_gid = gid;
     }
 
-    return fuse_getattr(exp, out);
+    return fuse_co_getattr(exp, out);
 }
 
 /**
@@ -665,7 +694,8 @@ static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
  * just acknowledge the request.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
+static ssize_t coroutine_fn
+fuse_co_open(FuseExport *exp, struct fuse_open_out *out)
 {
     *out = (struct fuse_open_out) {
         .open_flags = FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES,
@@ -679,8 +709,8 @@ static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
  * Returns the buffer (read) size on success, and -errno on error.
  * After use, *bufptr must be freed via qemu_vfree().
  */
-static ssize_t fuse_read(FuseExport *exp, void **bufptr,
-                         uint64_t offset, uint32_t size)
+static ssize_t coroutine_fn
+fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
 {
     int64_t blk_len;
     void *buf;
@@ -695,7 +725,7 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -709,7 +739,7 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
         return -ENOMEM;
     }
 
-    ret = blk_pread(exp->common.blk, offset, size, buf, 0);
+    ret = blk_co_pread(exp->common.blk, offset, size, buf, 0);
     if (ret < 0) {
         qemu_vfree(buf);
         return ret;
@@ -721,11 +751,12 @@ static ssize_t fuse_read(FuseExport *exp, void **bufptr,
 
 /**
  * Handle client writes to the exported image.  @buf has the data to be written
- * and will be copied to a bounce buffer before polling for the first time.
+ * and will be copied to a bounce buffer before yielding for the first time.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
-                          uint64_t offset, uint32_t size, const void *buf)
+static ssize_t coroutine_fn
+fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
+              uint64_t offset, uint32_t size, const void *buf)
 {
     void *copied;
     int64_t blk_len;
@@ -740,9 +771,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
         return -EACCES;
     }
 
-    /*
-     * Must copy to bounce buffer before calling aio_poll() (to allow nesting)
-     */
+    /* Must copy to bounce buffer before potentially yielding */
     copied = blk_blockalign(exp->common.blk, size);
     memcpy(copied, buf, size);
 
@@ -750,7 +779,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         ret = blk_len;
         goto fail_free_buffer;
@@ -758,7 +787,8 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
 
     if (offset + size > blk_len) {
         if (exp->growable) {
-            ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset + size, true,
+                                      PREALLOC_MODE_OFF);
             if (ret < 0) {
                 goto fail_free_buffer;
             }
@@ -767,7 +797,7 @@ static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
+    ret = blk_co_pwrite(exp->common.blk, offset, size, copied, 0);
     if (ret < 0) {
         goto fail_free_buffer;
     }
@@ -788,8 +818,9 @@ fail_free_buffer:
  * Let clients perform various fallocate() operations.
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
-                              uint32_t mode)
+static ssize_t coroutine_fn
+fuse_co_fallocate(FuseExport *exp,
+                  uint64_t offset, uint64_t length, uint32_t mode)
 {
     int64_t blk_len;
     int ret;
@@ -798,7 +829,7 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         return -EACCES;
     }
 
-    blk_len = blk_getlength(exp->common.blk);
+    blk_len = blk_co_getlength(exp->common.blk);
     if (blk_len < 0) {
         return blk_len;
     }
@@ -817,14 +848,14 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
 
         if (offset > blk_len) {
             /* No preallocation needed here */
-            ret = fuse_do_truncate(exp, offset, true, PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
                 return ret;
             }
         }
 
-        ret = fuse_do_truncate(exp, offset + length, true,
-                               PREALLOC_MODE_FALLOC);
+        ret = fuse_co_do_truncate(exp, offset + length, true,
+                                  PREALLOC_MODE_FALLOC);
     }
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     else if (mode & FALLOC_FL_PUNCH_HOLE) {
@@ -835,8 +866,9 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         do {
             int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
 
-            ret = blk_pwrite_zeroes(exp->common.blk, offset, size,
-                                    BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
+            ret = blk_co_pwrite_zeroes(exp->common.blk, offset, size,
+                                       BDRV_REQ_MAY_UNMAP |
+                                       BDRV_REQ_NO_FALLBACK);
             if (ret == -ENOTSUP) {
                 /*
                  * fallocate() specifies to return EOPNOTSUPP for unsupported
@@ -854,8 +886,8 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
     else if (mode & FALLOC_FL_ZERO_RANGE) {
         if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + length > blk_len) {
             /* No need for zeroes, we are going to write them ourselves */
-            ret = fuse_do_truncate(exp, offset + length, false,
-                                   PREALLOC_MODE_OFF);
+            ret = fuse_co_do_truncate(exp, offset + length, false,
+                                      PREALLOC_MODE_OFF);
             if (ret < 0) {
                 return ret;
             }
@@ -864,8 +896,8 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
         do {
             int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
 
-            ret = blk_pwrite_zeroes(exp->common.blk,
-                                    offset, size, 0);
+            ret = blk_co_pwrite_zeroes(exp->common.blk,
+                                       offset, size, 0);
             offset += size;
             length -= size;
         } while (ret == 0 && length > 0);
@@ -882,9 +914,9 @@ static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
  * Let clients fsync the exported image.
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_fsync(FuseExport *exp)
+static ssize_t coroutine_fn fuse_co_fsync(FuseExport *exp)
 {
-    return blk_flush(exp->common.blk);
+    return blk_co_flush(exp->common.blk);
 }
 
 /**
@@ -892,9 +924,9 @@ static ssize_t fuse_fsync(FuseExport *exp)
  * notes this to be a way to return last-minute errors.)
  * Return 0 on success (no 'out' object), and -errno on error.
  */
-static ssize_t fuse_flush(FuseExport *exp)
+static ssize_t coroutine_fn fuse_co_flush(FuseExport *exp)
 {
-    return blk_flush(exp->common.blk);
+    return blk_co_flush(exp->common.blk);
 }
 
 #ifdef CONFIG_FUSE_LSEEK
@@ -902,8 +934,9 @@ static ssize_t fuse_flush(FuseExport *exp)
  * Let clients inquire allocation status.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
-static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
-                          uint64_t offset, uint32_t whence)
+static ssize_t coroutine_fn
+fuse_co_lseek(FuseExport *exp, struct fuse_lseek_out *out,
+              uint64_t offset, uint32_t whence)
 {
     if (whence != SEEK_HOLE && whence != SEEK_DATA) {
         return -EINVAL;
@@ -913,8 +946,8 @@ static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
         int64_t pnum;
         int ret;
 
-        ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
-                                      offset, INT64_MAX, &pnum, NULL, NULL);
+        ret = bdrv_co_block_status_above(blk_bs(exp->common.blk), NULL,
+                                         offset, INT64_MAX, &pnum, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -931,7 +964,7 @@ static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
              * and @blk_len (the client-visible EOF).
              */
 
-            blk_len = blk_getlength(exp->common.blk);
+            blk_len = blk_co_getlength(exp->common.blk);
             if (blk_len < 0) {
                 return blk_len;
             }
@@ -1066,14 +1099,14 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
 }
 
 /*
- * For use in fuse_process_request():
+ * For use in fuse_co_process_request():
  * Returns a pointer to the parameter object for the given operation (inside of
  * exp->request_buf, which is assumed to hold a fuse_in_header first).
  * Verifies that the object is complete (exp->request_buf is large enough to
  * hold it in one piece, and the request length includes the whole object).
  *
- * Note that exp->request_buf may be overwritten after polling, so the returned
- * pointer must not be used across a function that may poll!
+ * Note that exp->request_buf may be overwritten after yielding, so the returned
+ * pointer must not be used across a function that may yield!
  */
 #define FUSE_IN_OP_STRUCT(op_name, export) \
     ({ \
@@ -1097,7 +1130,7 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
     })
 
 /*
- * For use in fuse_process_request():
+ * For use in fuse_co_process_request():
  * Returns a pointer to the return object for the given operation (inside of
  * out_buf, which is assumed to hold a fuse_out_header first).
  * Verifies that out_buf is large enough to hold the whole object.
@@ -1120,12 +1153,11 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
 /**
  * Process a FUSE request, incl. writing the response.
  *
- * Note that polling in any request-processing function can lead to a nested
- * read_from_fuse_fd() call, which will overwrite the contents of
- * exp->request_buf.  Anything that takes a buffer needs to take care that the
- * content is copied before potentially polling.
+ * Note that yielding in any request-processing function can overwrite the
+ * contents of exp->request_buf.  Anything that takes a buffer needs to take
+ * care that the content is copied before yielding.
  */
-static void fuse_process_request(FuseExport *exp)
+static void coroutine_fn fuse_co_process_request(FuseExport *exp)
 {
     uint32_t opcode;
     uint64_t req_id;
@@ -1146,7 +1178,7 @@ static void fuse_process_request(FuseExport *exp)
     void *out_data_buffer = NULL;
     ssize_t ret;
 
-    /* Limit scope to ensure pointer is no longer used after polling */
+    /* Limit scope to ensure pointer is no longer used after yielding */
     {
         const struct fuse_in_header *in_hdr =
             (const struct fuse_in_header *)exp->request_buf;
@@ -1158,13 +1190,13 @@ static void fuse_process_request(FuseExport *exp)
     switch (opcode) {
     case FUSE_INIT: {
         const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, exp);
-        ret = fuse_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
-                        in->max_readahead, in->flags);
+        ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
+                           in->max_readahead, in->flags);
         break;
     }
 
     case FUSE_OPEN:
-        ret = fuse_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
+        ret = fuse_co_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
         break;
 
     case FUSE_RELEASE:
@@ -1176,19 +1208,19 @@ static void fuse_process_request(FuseExport *exp)
         break;
 
     case FUSE_GETATTR:
-        ret = fuse_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
+        ret = fuse_co_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
         break;
 
     case FUSE_SETATTR: {
         const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, exp);
-        ret = fuse_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
-                           in->valid, in->size, in->mode, in->uid, in->gid);
+        ret = fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
+                              in->valid, in->size, in->mode, in->uid, in->gid);
         break;
     }
 
     case FUSE_READ: {
         const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, exp);
-        ret = fuse_read(exp, &out_data_buffer, in->offset, in->size);
+        ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
         break;
     }
 
@@ -1216,33 +1248,33 @@ static void fuse_process_request(FuseExport *exp)
 
         /*
          * Passing a pointer to `in` (i.e. the request buffer) is fine because
-         * fuse_write() takes care to copy its contents before potentially
-         * polling.
+         * fuse_co_write() takes care to copy its contents before potentially
+         * yielding.
          */
-        ret = fuse_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
-                         in->offset, in->size, in + 1);
+        ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
+                            in->offset, in->size, in + 1);
         break;
     }
 
     case FUSE_FALLOCATE: {
         const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, exp);
-        ret = fuse_fallocate(exp, in->offset, in->length, in->mode);
+        ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
         break;
     }
 
     case FUSE_FSYNC:
-        ret = fuse_fsync(exp);
+        ret = fuse_co_fsync(exp);
         break;
 
     case FUSE_FLUSH:
-        ret = fuse_flush(exp);
+        ret = fuse_co_flush(exp);
         break;
 
 #ifdef CONFIG_FUSE_LSEEK
     case FUSE_LSEEK: {
         const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, exp);
-        ret = fuse_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
-                         in->offset, in->whence);
+        ret = fuse_co_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
+                            in->offset, in->whence);
         break;
     }
 #endif
-- 
2.49.0


