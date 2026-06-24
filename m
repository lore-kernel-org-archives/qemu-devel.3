Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911C8CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHm5-00079q-MS; Wed, 24 Jun 2026 03:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkT-0005Rf-IQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:22 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkR-00038R-Dt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:13 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c88b59bfba7so276613a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782285008; x=1782889808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjpcTIVOjjU2T3U84XrTlI69hFe/P5txjri+hVbKO1s=;
 b=o4GYFbqa4rFOG1XcCteEzJywCEzIKR1WszZ9hy+H0dFnbZv+jD1m4tXzSiKnkHQIxY
 wsu0aePXtVz9VF+ftFMwN7/PkNyi8NtzMHl9lvfsYKu6uuJU4i5sAgECkGssaS6aA728
 bE0tDaX1tuujK4PeBOKvM31obfUcOwPTaTZVxl6LkQJmgQ2YGkeQGhZikIiZKFm1RHfj
 sMyvHksz+2XJEieiaFfAk/ytm++gbpalCCL7dg/nZA6heVo+CMkvH1/j1S1VZFYm/VxQ
 aLlxTukKw9v1ZHdHOKtFZjEqtgzITaKzQl52j1XZDqzVdabpkY2EmcRItayyVQW+LhQe
 G9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782285008; x=1782889808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjpcTIVOjjU2T3U84XrTlI69hFe/P5txjri+hVbKO1s=;
 b=lIcrE+Ia1kFfoEwx2Rbbe0WYmhFU2NT2dQhYNBtBhx+6NJkDu6HSvH9ynWjvylxTPb
 CkuycegEgkQ6vgNJuP9+0qCdOqFUMrzFIy/avtLVrPivkdnrY4h3NDkb+McY9fcSNMko
 a1eiSljPh9WuYU75hkV7b/+BvoA6U2CkKI5jPFerVRJUJlcXAcnlFQZaREXTdZaeHdAi
 igBnJZPgqEuD17TpJkltFYjlPXW1blAnS7rEU1mFqji955orXFZg1nsx6J755772dlac
 OujD2dseqMFSdExP5+axH3rdcX/qARXNFrUCmi5uqbknCpq3Jh5Z/MY8p/ckQlGdo5id
 y1Pw==
X-Gm-Message-State: AOJu0YzrW3p6EiGLd/6xGpNsVB5jvreWyX8A+TNablVtD3Xrwyt8cQ0N
 n23bLo573Actt6LHYj4F7J0lgNKIpRI7jgGwRAiwdD5w2WFClc49De5Bvlq2aHqInP0=
X-Gm-Gg: AfdE7cn7ufhMHQCWatCrrjwg5viuCopkiBOPg7GaV9cVZopH7WiH5YP223r/WKGxRtl
 kq3gsA0qm85uhjkXCMV5PWF9ffRWjx+cO5mM+D/mncN6/AgqXjdqTmvukviOc13SdZmpGRhtTiM
 /+j+IgzwRfUIzu1qOJO53zMieF3j8H8USxJ7aP3tQqsHjDjjkurjM8PMaL11leN3NJfGkaqJZTL
 guH/vZhEFrI1fl0Sp0mj9LrHQnnE6tHNXYRXf/HC/REUq/2qOg25i+u1DgRr3+AystLqGXteA6O
 iYFjPyGVBbsg/Tn9+8frwm34QzfTq4gQCsbMRYlrrelPkgJQ6Z5COtphI2K819nIhJ6WzPJhKQU
 B6TYvdBcVFo6ULTytXuxxu/2ECWtN6Y5uNElLNxVSYxGgWt1Yf4oWGsdfkmspMh7zZGG0vXOx2M
 2avhVqhM+0pxky7MF49gLFKBt7gq5CuM6puOUv//DQXfSviamdCkyo
X-Received: by 2002:a05:6300:670a:b0:3a1:ed2a:1a4f with SMTP id
 adf61e73a8af0-3bd2cef5684mr2763547637.16.1782285008035; 
 Wed, 24 Jun 2026 00:10:08 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.10.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:10:07 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 17/17] tests/unit/iothread: Update the
 iothread_get_aio_context
Date: Wed, 24 Jun 2026 15:08:51 +0800
Message-ID: <20260624070851.13342-18-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52d.google.com
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

Update the iothread_get_aio_context and the
iothread_put_aio_context for tests.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 tests/unit/iothread.c             | 16 ++++++++++------
 tests/unit/iothread.h             |  6 +++++-
 tests/unit/test-aio-multithread.c |  5 ++++-
 tests/unit/test-bdrv-drain.c      | 18 +++++++++++++-----
 tests/unit/test-block-iothread.c  | 21 ++++++++++++++-------
 5 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/tests/unit/iothread.c b/tests/unit/iothread.c
index a363bf8f70..6cac850035 100644
--- a/tests/unit/iothread.c
+++ b/tests/unit/iothread.c
@@ -30,12 +30,21 @@ struct IOThread {
     bool stopping;
 };
 
+AioContext *iothread_get_aio_context(IOThread *iothread, IOThreadHolder *holder)
+{
+    return iothread->ctx;
+}
+
+void iothread_put_aio_context(IOThread *iothread, IOThreadHolder *holder)
+{
+}
+
 static void iothread_init_gcontext(IOThread *iothread)
 {
     GSource *source;
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
     iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
@@ -113,8 +122,3 @@ IOThread *iothread_new(void)
     qemu_mutex_unlock(&iothread->init_done_lock);
     return iothread;
 }
-
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
diff --git a/tests/unit/iothread.h b/tests/unit/iothread.h
index eb4d0c77f8..42992c171d 100644
--- a/tests/unit/iothread.h
+++ b/tests/unit/iothread.h
@@ -17,9 +17,13 @@
 #include "qemu/thread.h"
 
 typedef struct IOThread IOThread;
+typedef struct IOThreadHolder IOThreadHolder;
+
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     IOThreadHolder *holder);
+void iothread_put_aio_context(IOThread *iothread, IOThreadHolder *holder);
 
 IOThread *iothread_new(void);
 void iothread_join(IOThread *iothread);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 #endif
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 9179cdc6a3..92fa210ddc 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -69,7 +69,7 @@ static void create_aio_contexts(void)
 
     for (i = 0; i < NUM_CONTEXTS; i++) {
         threads[i] = iothread_new();
-        ctx[i] = iothread_get_aio_context(threads[i]);
+        ctx[i] = iothread_get_aio_context(threads[i], NULL);
     }
 
     qemu_event_init(&done_event, false);
@@ -87,6 +87,9 @@ static void join_aio_contexts(void)
     for (i = 0; i < NUM_CONTEXTS; i++) {
         aio_context_ref(ctx[i]);
     }
+    for (i = 0; i < NUM_CONTEXTS; i++) {
+        iothread_put_aio_context(threads[i], NULL);
+    }
     for (i = 0; i < NUM_CONTEXTS; i++) {
         iothread_join(threads[i]);
     }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 43b0ba8648..05e52e89ac 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -537,8 +537,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
 
     IOThread *a = iothread_new();
     IOThread *b = iothread_new();
-    AioContext *ctx_a = iothread_get_aio_context(a);
-    AioContext *ctx_b = iothread_get_aio_context(b);
+    AioContext *ctx_a = iothread_get_aio_context(a, NULL);
+    AioContext *ctx_b = iothread_get_aio_context(b, NULL);
 
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
@@ -612,6 +612,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
 
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_put_aio_context(a, NULL);
+    iothread_put_aio_context(b, NULL);
 
 out:
     iothread_join(a);
@@ -762,7 +764,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
         AioContext *ctx;
 
         iothread = iothread_new();
-        ctx = iothread_get_aio_context(iothread);
+        ctx = iothread_get_aio_context(iothread, NULL);
         blk_set_aio_context(blk_src, ctx, &error_abort);
     }
 
@@ -892,6 +894,10 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     bdrv_unref(src_overlay);
     bdrv_unref(target);
 
+    if (use_iothread) {
+        iothread_put_aio_context(iothread, NULL);
+    }
+
     if (iothread) {
         iothread_join(iothread);
     }
@@ -1398,8 +1404,8 @@ static void test_set_aio_context(void)
     BlockDriverState *bs;
     IOThread *a = iothread_new();
     IOThread *b = iothread_new();
-    AioContext *ctx_a = iothread_get_aio_context(a);
-    AioContext *ctx_b = iothread_get_aio_context(b);
+    AioContext *ctx_a = iothread_get_aio_context(a, NULL);
+    AioContext *ctx_b = iothread_get_aio_context(b, NULL);
 
     bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
@@ -1410,6 +1416,8 @@ static void test_set_aio_context(void)
     bdrv_try_change_aio_context(bs, qemu_get_aio_context(), NULL, &error_abort);
 
     bdrv_unref(bs);
+    iothread_put_aio_context(a, NULL);
+    iothread_put_aio_context(b, NULL);
     iothread_join(a);
     iothread_join(b);
 }
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 5273ff235a..8b7ac6f980 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -466,7 +466,7 @@ static void test_sync_op(const void *opaque)
 {
     const SyncOpTest *t = opaque;
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     BlockBackend *blk;
     BlockDriverState *bs;
     BdrvChild *c;
@@ -493,6 +493,7 @@ static void test_sync_op(const void *opaque)
 
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 typedef struct TestBlockJob {
@@ -549,7 +550,7 @@ BlockJobDriver test_job_driver = {
 static void test_attach_blockjob(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     BlockBackend *blk;
     BlockDriverState *bs;
     TestBlockJob *tjob;
@@ -595,6 +596,7 @@ static void test_attach_blockjob(void)
 
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 /*
@@ -612,7 +614,7 @@ static void test_attach_blockjob(void)
 static void test_propagate_basic(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_verify;
@@ -658,6 +660,7 @@ static void test_propagate_basic(void)
     bdrv_unref(bs_b);
     bdrv_unref(bs_a);
     blk_unref(blk);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 /*
@@ -676,7 +679,7 @@ static void test_propagate_basic(void)
 static void test_propagate_diamond(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_c, *bs_verify;
@@ -736,12 +739,13 @@ static void test_propagate_diamond(void)
     bdrv_unref(bs_c);
     bdrv_unref(bs_b);
     bdrv_unref(bs_a);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 static void test_propagate_mirror(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     AioContext *main_ctx = qemu_get_aio_context();
     BlockDriverState *src, *target, *filter;
     BlockBackend *blk;
@@ -807,12 +811,13 @@ static void test_propagate_mirror(void)
     blk_unref(blk);
     bdrv_unref(src);
     bdrv_unref(target);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 static void test_attach_second_node(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     AioContext *main_ctx = qemu_get_aio_context();
     BlockBackend *blk;
     BlockDriverState *bs, *filter;
@@ -840,12 +845,13 @@ static void test_attach_second_node(void)
     bdrv_unref(filter);
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 static void test_attach_preserve_blk_ctx(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_get_aio_context(iothread, NULL);
     BlockBackend *blk;
     BlockDriverState *bs;
 
@@ -871,6 +877,7 @@ static void test_attach_preserve_blk_ctx(void)
     blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_put_aio_context(iothread, NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.49.0


