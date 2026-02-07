Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8CAEE0ADA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8d-0007Cc-0g; Sat, 07 Feb 2026 07:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8a-0007CE-2R
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:08 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8X-00035R-4V
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:07 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c93e0269cso2498824a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466203; x=1771071003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqUt3VRnKO0/pU94K0c5xLOUyYWLmsrVycHnTDp9Wik=;
 b=dmlNpVNNMripvANhoQ1+eA3oI0Q0mEodomP0mMB4JLrl2eO7BH8HF1vG/cMcoNfaqu
 1KmDiN1ZANVIBuQinr7bJPrNSiMDfxqb40EWhLoyi9N3rKNfBBsHaxOej8/bVvIWi23+
 Fpu/AbFN5XLRyN8gtyQdvCMCF0LjwKCSuwKYReX0tjlqArY21g7w26UnXW6o3RCHUjT1
 xvg9F1yQXTqg/xk0WvTKr9VkAgWqsD6cJHx5YyYOR6si6cN+rVi1fPxY8Kv7ooceIIDt
 xFaoy+5hCcQFWPKARGaBuX+zgl3j/9DfhARtHm0kppGDnwDRf+QWHxvPP8/vApMIWC1a
 76SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466203; x=1771071003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqUt3VRnKO0/pU94K0c5xLOUyYWLmsrVycHnTDp9Wik=;
 b=i3HTlR0cHg3xmZp73Hw+Hn643QmIlv2LHCG0J9qcywuy1i2iD3KBuFS6kXXBVOBKP6
 42EF+7+QzJnqnaMKfI6ZdP9TGbF9hLXQbYaN6acO9jQTtPDdy2/UsI68QsfZpnZLS1uO
 cB+KCq994OT8IFqNiRZ7Exa8gGT7UqlcAiNr7ToUa3U9KOCcQvg5nH/ZPVAAXnpnd6vf
 7lLyeZpljXOxd0sjsJP5R49h9WVBQ+nP8sQPFhqxTfU/jCJ9sVkBj+EUeRjEPjUzTEJ7
 JVikxqL3V4ow8Mgr9c1krLauFLLmenBtiQFdK547z53SngyZ7t4IDDqqG6hH3S474GvW
 zxAw==
X-Gm-Message-State: AOJu0YwbdaSXe5yAFi/5E4DJOdTPNWMKS6jp36RumK4lMvc+OVVjjooO
 a37fnRY+xdZ7ES7ImeZ9+JfnApvIEkURCkwhXuhAyHfM+9NWSsp/uego
X-Gm-Gg: AZuq6aLdONoNOJ1Va1uy3FJNweJ1dh0ET2QZlui+2+u0X6Pp23EkkEJ5FNpgWeqc0PB
 81wqBqrh5RGMntZH9Dq1llD0KaLbzD8robe/p/8enzC7qOw5t/cIiyOnTPTauUZ4u0phEjcMVvg
 8SwfjH8Pg1sUSpvnQkbCDn1u792Z+Hmt5KcmJZCexliTZzl6ZGoaY+aZBVrRXEc0dbwoFYNiLz3
 j6paDAbNW062rsZWUiHtIViTbQqzayr2rtvvD3qvtf3T53xYcFMeGhT2obVpx8SV06uhlXNPRQx
 2+1yjn0BGVz4fG6fh8/2qEXpCocWxZ2h1+p4MFlks4JiV/HTyKvohekUs2VvsoPGf5tOduNk40N
 7cBSWgogMkZQJSZFzXVC4AuHJaidkB5JU2usMYSA/QaCBObyZsTf9H2jSwPHT5tJyWUyu9sD1Jx
 6bJFR4/JQaKvkzsTigLDLmmO7ybWO75K1rJh36WM+x1B/MM8E=
X-Received: by 2002:a17:90b:4c8f:b0:354:7e46:4ab8 with SMTP id
 98e67ed59e1d1-3549bc3e1f4mr8070810a91.18.1770466203215; 
 Sat, 07 Feb 2026 04:10:03 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:10:02 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 4/7] fuse: refactor FUSE request handler
Date: Sat,  7 Feb 2026 20:08:58 +0800
Message-ID: <20260207120901.17222-5-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207120901.17222-1-hibriansong@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=hibriansong@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch implements the CQE handler for FUSE-over-io_uring. Upon
receiving a FUSE request via a Completion Queue Entry (CQE), the
handler processes the request and submits the response back to the
kernel via the FUSE_IO_URING_CMD_COMMIT_AND_FETCH command.

Additionally, the request processing logic shared between legacy and
io_uring modes has been extracted into fuse_co_process_request_common().
The execution flow now dispatches requests to the appropriate
mode-specific logic based on the uring_started flag.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c | 400 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 301 insertions(+), 99 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 867752555a..c117e081cd 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -138,8 +138,8 @@ struct FuseQueue {
      * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
      * This however is just the first part of the buffer; every read is given
      * a vector of this buffer (which should be enough for all normal requests,
-     * which we check via the static assertion in FUSE_IN_OP_STRUCT()) and the
-     * spill-over buffer below.
+     * which we check via the static assertion in FUSE_IN_OP_STRUCT_LEGACY())
+     * and the spill-over buffer below.
      * Therefore, the size of this buffer plus FUSE_SPILLOVER_BUF_SIZE must be
      * FUSE_MIN_READ_BUFFER or more (checked via static assertion below).
      */
@@ -912,6 +912,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
     }

     fuse_co_process_request(q, spillover_buf);
+    qemu_vfree(spillover_buf);

 no_request:
     fuse_dec_in_flight(exp);
@@ -1684,100 +1685,75 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
 }

 /*
- * For use in fuse_co_process_request():
+ * For use in fuse_co_process_request_common():
  * Returns a pointer to the parameter object for the given operation (inside of
- * queue->request_buf, which is assumed to hold a fuse_in_header first).
- * Verifies that the object is complete (queue->request_buf is large enough to
- * hold it in one piece, and the request length includes the whole object).
+ * in_buf, which is assumed to hold a fuse_in_header first).
+ * Verifies that the object is complete (in_buf is large enough to hold it in
+ * one piece, and the request length includes the whole object).
+ * Only performs verification for legacy FUSE.
  *
  * Note that queue->request_buf may be overwritten after yielding, so the
  * returned pointer must not be used across a function that may yield!
  */
-#define FUSE_IN_OP_STRUCT(op_name, queue) \
+#define FUSE_IN_OP_STRUCT_LEGACY(op_name, queue) \
     ({ \
         const struct fuse_in_header *__in_hdr = \
             (const struct fuse_in_header *)(queue)->request_buf; \
         const struct fuse_##op_name##_in *__in = \
             (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
         const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
-        uint32_t __req_len; \
         \
-        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < __param_len); \
+        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < \
+                          (sizeof(struct fuse_in_header) + \
+                           sizeof(struct fuse_##op_name##_in))); \
         \
-        __req_len = __in_hdr->len; \
+        uint32_t __req_len = __in_hdr->len; \
         if (__req_len < __param_len) { \
             warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
                         __req_len, __param_len); \
             ret = -EINVAL; \
-            break; \
+            __in = NULL; \
         } \
         __in; \
     })

 /*
- * For use in fuse_co_process_request():
+ * For use in fuse_co_process_request_common():
  * Returns a pointer to the return object for the given operation (inside of
  * out_buf, which is assumed to hold a fuse_out_header first).
- * Verifies that out_buf is large enough to hold the whole object.
+ * Only performs verification for legacy FUSE.
+ * Note: Buffer size verification is done via static assertions in the caller
+ * (fuse_co_process_request) where out_buf is a local array.
  *
- * (out_buf should be a char[] array.)
+ * (out_buf should be a char[] array in the caller.)
  */
-#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
+#define FUSE_OUT_OP_STRUCT_LEGACY(op_name, out_buf) \
     ({ \
         struct fuse_out_header *__out_hdr = \
             (struct fuse_out_header *)(out_buf); \
         struct fuse_##op_name##_out *__out = \
             (struct fuse_##op_name##_out *)(__out_hdr + 1); \
         \
-        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
-                          sizeof(out_buf)); \
-        \
         __out; \
     })

 /**
- * Process a FUSE request, incl. writing the response.
- *
- * Note that yielding in any request-processing function can overwrite the
- * contents of q->request_buf.  Anything that takes a buffer needs to take
- * care that the content is copied before yielding.
- *
- * @spillover_buf can contain the tail of a write request too large to fit into
- * q->request_buf.  This function takes ownership of it (i.e. will free it),
- * which assumes that its contents will not be overwritten by concurrent
- * requests (as opposed to q->request_buf).
+ * Shared helper for FUSE request processing. Handles both legacy and io_uring
+ * paths.
  */
-static void coroutine_fn
-fuse_co_process_request(FuseQueue *q, void *spillover_buf)
+static void coroutine_fn fuse_co_process_request_common(
+    FuseExport *exp,
+    uint32_t opcode,
+    uint64_t req_id,
+    void *in_buf,
+    void *spillover_buf,
+    void *out_buf,
+    void (*send_response)(void *opaque, uint32_t req_id, int ret,
+                          const void *buf, void *out_buf),
+    void *opaque /* FuseQueue* or FuseUringEnt* */)
 {
-    FuseExport *exp = q->exp;
-    uint32_t opcode;
-    uint64_t req_id;
-    /*
-     * Return buffer.  Must be large enough to hold all return headers, but does
-     * not include space for data returned by read requests.
-     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is indeed
-     * large enough.)
-     */
-    char out_buf[sizeof(struct fuse_out_header) +
-                 MAX_CONST(sizeof(struct fuse_init_out),
-                 MAX_CONST(sizeof(struct fuse_open_out),
-                 MAX_CONST(sizeof(struct fuse_attr_out),
-                 MAX_CONST(sizeof(struct fuse_write_out),
-                           sizeof(struct fuse_lseek_out)))))];
-    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
-    /* For read requests: Data to be returned */
     void *out_data_buffer = NULL;
-    ssize_t ret;
-
-    /* Limit scope to ensure pointer is no longer used after yielding */
-    {
-        const struct fuse_in_header *in_hdr =
-            (const struct fuse_in_header *)q->request_buf;
-
-        opcode = in_hdr->opcode;
-        req_id = in_hdr->unique;
-    }
+    int ret = 0;

 #ifdef CONFIG_LINUX_IO_URING
     /*
@@ -1794,15 +1770,32 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)

     switch (opcode) {
     case FUSE_INIT: {
-        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
-        ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
-                           in->max_readahead, in);
+        FuseQueue *q = opaque;
+        const struct fuse_init_in *in =
+            FUSE_IN_OP_STRUCT_LEGACY(init, q);
+        if (!in) {
+            break;
+        }
+
+        struct fuse_init_out *out =
+            FUSE_OUT_OP_STRUCT_LEGACY(init, out_buf);
+
+        ret = fuse_co_init(exp, out, in->max_readahead, in);
         break;
     }

-    case FUSE_OPEN:
-        ret = fuse_co_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
+    case FUSE_OPEN: {
+        struct fuse_open_out *out;
+
+        if (exp->uring_started) {
+            out = out_buf;
+        } else {
+            out = FUSE_OUT_OP_STRUCT_LEGACY(open, out_buf);
+        }
+
+        ret = fuse_co_open(exp, out);
         break;
+    }

     case FUSE_RELEASE:
         ret = 0;
@@ -1812,37 +1805,105 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
         ret = -ENOENT; /* There is no node but the root node */
         break;

-    case FUSE_GETATTR:
-        ret = fuse_co_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
+    case FUSE_GETATTR: {
+        struct fuse_attr_out *out;
+
+        if (exp->uring_started) {
+            out = out_buf;
+        } else {
+            out = FUSE_OUT_OP_STRUCT_LEGACY(attr, out_buf);
+        }
+
+        ret = fuse_co_getattr(exp, out);
         break;
+    }

     case FUSE_SETATTR: {
-        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, q);
-        ret = fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
-                              in->valid, in->size, in->mode, in->uid, in->gid);
+        const struct fuse_setattr_in *in;
+        struct fuse_attr_out *out;
+
+        if (exp->uring_started) {
+            in = in_buf;
+            out = out_buf;
+        } else {
+            FuseQueue *q = opaque;
+            in = FUSE_IN_OP_STRUCT_LEGACY(setattr, q);
+            if (!in) {
+                break;
+            }
+
+            out = FUSE_OUT_OP_STRUCT_LEGACY(attr, out_buf);
+        }
+
+        ret = fuse_co_setattr(exp, out, in->valid, in->size, in->mode,
+                              in->uid, in->gid);
         break;
     }

     case FUSE_READ: {
-        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, q);
+        const struct fuse_read_in *in;
+
+        if (exp->uring_started) {
+            in = in_buf;
+        } else {
+            FuseQueue *q = opaque;
+            in = FUSE_IN_OP_STRUCT_LEGACY(read, q);
+            if (!in) {
+                break;
+            }
+        }
+
         ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
         break;
     }

     case FUSE_WRITE: {
-        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, q);
-        uint32_t req_len;
-
-        req_len = ((const struct fuse_in_header *)q->request_buf)->len;
-        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
-                               in->size)) {
-            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
-                        req_len - sizeof(struct fuse_in_header) - sizeof(*in),
-                        in->size);
-            ret = -EINVAL;
-            break;
-        }
+        const struct fuse_write_in *in;
+        struct fuse_write_out *out;
+        const void *in_place_buf;
+        const void *spill_buf;
+
+        if (exp->uring_started) {
+            FuseUringEnt *ent = opaque;
+
+            in = in_buf;
+            out = out_buf;
+
+            assert(in->size <= ent->req_header.ring_ent_in_out.payload_sz);

+            /*
+             * In uring mode, the "out_buf" (ent->payload) actually holds the
+             * input data for WRITE requests.
+             */
+            in_place_buf = NULL;
+            spill_buf = out_buf;
+        } else {
+            FuseQueue *q = opaque;
+            in = FUSE_IN_OP_STRUCT_LEGACY(write, q);
+            if (!in) {
+                break;
+            }
+
+            out = FUSE_OUT_OP_STRUCT_LEGACY(write, out_buf);
+
+            /* Additional check for WRITE: verify the request includes data */
+            uint32_t req_len =
+                ((const struct fuse_in_header *)(q->request_buf))->len;
+
+            if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
+                        in->size)) {
+                warn_report("FUSE WRITE truncated; received %zu bytes of %"
+                    PRIu32,
+                    req_len - sizeof(struct fuse_in_header) - sizeof(*in),
+                    in->size);
+                ret = -EINVAL;
+                break;
+            }
+
+            /* Legacy buffer setup */
+            in_place_buf = in + 1;
+            spill_buf = spillover_buf;
+        }
         /*
          * poll_fuse_fd() has checked that in_hdr->len matches the number of
          * bytes read, which cannot exceed the max_write value we set
@@ -1856,13 +1917,24 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
          * fuse_co_write() takes care to copy its contents before potentially
          * yielding.
          */
-        ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
-                            in->offset, in->size, in + 1, spillover_buf);
+        ret = fuse_co_write(exp, out, in->offset, in->size,
+                            in_place_buf, spill_buf);
         break;
     }

     case FUSE_FALLOCATE: {
-        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, q);
+        const struct fuse_fallocate_in *in;
+
+        if (exp->uring_started) {
+            in = in_buf;
+        } else {
+            FuseQueue *q = opaque;
+            in = FUSE_IN_OP_STRUCT_LEGACY(fallocate, q);
+            if (!in) {
+                break;
+            }
+        }
+
         ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
         break;
     }
@@ -1877,9 +1949,23 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)

 #ifdef CONFIG_FUSE_LSEEK
     case FUSE_LSEEK: {
-        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, q);
-        ret = fuse_co_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
-                            in->offset, in->whence);
+        const struct fuse_lseek_in *in;
+        struct fuse_lseek_out *out;
+
+        if (exp->uring_started) {
+            in = in_buf;
+            out = out_buf;
+        } else {
+            FuseQueue *q = opaque;
+            in = FUSE_IN_OP_STRUCT_LEGACY(lseek, q);
+            if (!in) {
+                break;
+            }
+
+            out = FUSE_OUT_OP_STRUCT_LEGACY(lseek, out_buf);
+        }
+
+        ret = fuse_co_lseek(exp, out, in->offset, in->whence);
         break;
     }
 #endif
@@ -1888,20 +1974,12 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
         ret = -ENOSYS;
     }

-    /* Ignore errors from fuse_write*(), nothing we can do anyway */
+    send_response(opaque, req_id, ret, out_data_buffer, out_buf);
+
     if (out_data_buffer) {
-        assert(ret >= 0);
-        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
-                                out_data_buffer, ret);
         qemu_vfree(out_data_buffer);
-    } else {
-        fuse_write_response(q->fuse_fd, req_id, out_hdr,
-                            ret < 0 ? ret : 0,
-                            ret < 0 ? 0 : ret);
     }

-    qemu_vfree(spillover_buf);
-
 #ifdef CONFIG_LINUX_IO_URING
     if (unlikely(opcode == FUSE_INIT) && uring_initially_enabled) {
         if (exp->is_uring && !exp->uring_started) {
@@ -1910,7 +1988,8 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
              * If io_uring mode was requested for this export but it has not
              * been started yet, start it now.
              */
-            struct fuse_init_out *out = FUSE_OUT_OP_STRUCT(init, out_buf);
+            struct fuse_init_out *out =
+                FUSE_OUT_OP_STRUCT_LEGACY(init, out_buf);
             fuse_uring_start(exp, out);
         } else if (ret == -EOPNOTSUPP) {
             /*
@@ -1923,12 +2002,135 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
     }
 #endif
 }
+/* Helper to send response for legacy */
+static void send_response_legacy(void *opaque, uint32_t req_id, int ret,
+                                 const void *buf, void *out_buf)
+{
+    FuseQueue *q = (FuseQueue *)opaque;
+    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
+    if (buf) {
+        assert(ret >= 0);
+        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr, buf, ret);
+    } else {
+        fuse_write_response(q->fuse_fd, req_id, out_hdr,
+                            ret < 0 ? ret : 0,
+                            ret < 0 ? 0 : ret);
+    }
+}
+
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf)
+{
+    FuseExport *exp = q->exp;
+    uint32_t opcode;
+    uint64_t req_id;
+
+    /*
+     * Return buffer.  Must be large enough to hold all return headers, but does
+     * not include space for data returned by read requests.
+     */
+    char out_buf[sizeof(struct fuse_out_header) +
+        MAX_CONST(sizeof(struct fuse_init_out),
+        MAX_CONST(sizeof(struct fuse_open_out),
+        MAX_CONST(sizeof(struct fuse_attr_out),
+        MAX_CONST(sizeof(struct fuse_write_out),
+                  sizeof(struct fuse_lseek_out)))))] = {0};
+
+    /* Verify that out_buf is large enough for all output structures */
+    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
+        sizeof(struct fuse_init_out) > sizeof(out_buf));
+    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
+        sizeof(struct fuse_open_out) > sizeof(out_buf));
+    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
+        sizeof(struct fuse_attr_out) > sizeof(out_buf));
+    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
+        sizeof(struct fuse_write_out) > sizeof(out_buf));
+#ifdef CONFIG_FUSE_LSEEK
+    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
+        sizeof(struct fuse_lseek_out) > sizeof(out_buf));
+#endif
+
+    /* Limit scope to ensure pointer is no longer used after yielding */
+    {
+        const struct fuse_in_header *in_hdr =
+            (const struct fuse_in_header *)q->request_buf;
+
+        opcode = in_hdr->opcode;
+        req_id = in_hdr->unique;
+    }
+
+    fuse_co_process_request_common(exp, opcode, req_id, NULL, spillover_buf,
+                                   out_buf, send_response_legacy, q);
+}

 #ifdef CONFIG_LINUX_IO_URING
+static void fuse_uring_prep_sqe_commit(struct io_uring_sqe *sqe, void *opaque)
+{
+    FuseUringEnt *ent = opaque;
+    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
+
+    ent->last_cmd = FUSE_IO_URING_CMD_COMMIT_AND_FETCH;
+
+    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
+    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, ent->req_commit_id);
+}
+
+static void
+fuse_uring_send_response(FuseUringEnt *ent, uint32_t req_id, int ret,
+                         const void *out_data_buffer)
+{
+    FuseExport *exp = ent->rq->q->exp;
+
+    struct fuse_uring_req_header *rrh = &ent->req_header;
+    struct fuse_out_header *out_header = (struct fuse_out_header *)&rrh->in_out;
+    struct fuse_uring_ent_in_out *ent_in_out =
+        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
+
+    /* FUSE_READ */
+    if (out_data_buffer && ret > 0) {
+        memcpy(ent->req_payload, out_data_buffer, ret);
+    }
+
+    out_header->error  = ret < 0 ? ret : 0;
+    out_header->unique = req_id;
+    ent_in_out->payload_sz = ret > 0 ? ret : 0;
+
+    /* Commit and fetch a uring entry */
+    blk_exp_ref(&exp->common);
+    aio_add_sqe(fuse_uring_prep_sqe_commit, ent, &ent->fuse_cqe_handler);
+}
+
+/* Helper to send response for uring */
+static void send_response_uring(void *opaque, uint32_t req_id, int ret,
+                                const void *out_data_buffer, void *payload)
+{
+    FuseUringEnt *ent = (FuseUringEnt *)opaque;
+
+    fuse_uring_send_response(ent, req_id, ret, out_data_buffer);
+}
+
 static void coroutine_fn fuse_uring_co_process_request(FuseUringEnt *ent)
 {
-    /* TODO */
-    (void)ent;
+    FuseExport *exp = ent->rq->q->exp;
+    struct fuse_uring_req_header *rrh = &ent->req_header;
+    struct fuse_uring_ent_in_out *ent_in_out =
+        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
+    struct fuse_in_header *in_hdr =
+        (struct fuse_in_header *)&rrh->in_out;
+    uint32_t opcode = in_hdr->opcode;
+    uint64_t req_id = in_hdr->unique;
+
+    ent->req_commit_id = ent_in_out->commit_id;
+
+    if (unlikely(ent->req_commit_id == 0)) {
+        error_report("If this happens kernel will not find the response - "
+            "it will be stuck forever - better to abort immediately.");
+        fuse_export_halt(exp);
+        return;
+    }
+
+    fuse_co_process_request_common(exp, opcode, req_id, &rrh->op_in,
+        NULL, ent->req_payload, send_response_uring, ent);
 }
 #endif /* CONFIG_LINUX_IO_URING */

--
2.43.0


