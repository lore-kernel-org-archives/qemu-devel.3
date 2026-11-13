Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E830606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1oGMcc4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnZD-0001Rd-Fx; Fri, 13 Nov 2026 04:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnZ0-000152-Jm
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:19 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYy-00062l-Ef
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso14892845ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562035; x=1795166835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YuPzNNXhmAaT4UyWYgVuYBYlY5/Chqo6IDGzlmZ2kHE=;
 b=o1oGMcc4/X01XECfbz3x2+t61CNvBbtYW2jM5mmsUNH9nJZRxGKZArj9kiRwAgsj2S
 x3hQFJSBT7tCNyDolOfBIqj99V3hKHBorYz6u3n1GjsMV1ifla3Erg/kp+GsGYb57xB8
 e1C7E2Ht9w9DRcKA45tXcXgMFdPhlR1jBK6gj/93doOSHpazVBQFn43WHdonL0rkjsiA
 YGK/nErzTYIL/nON0hLTx8yM81ZlWZ+GuGFQ9VC3E1kVwDjCisCcp2dLRp6kASwyBdRX
 +jTIwIEqDR6vtb/Zb0IJ3tXkbEKQQVgTTnO8oI8dMDpWgspoS2Ehqogpvl5qKCGgMz58
 Xj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562035; x=1795166835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YuPzNNXhmAaT4UyWYgVuYBYlY5/Chqo6IDGzlmZ2kHE=;
 b=BooSkwQiC/Lctuq59Stq1Vw7mSQYKMOWYh/6aD/Kjz/YEOSzoTPMxdKV4TpYURtKrg
 REiWxtXKbvRkdiQ9PRaM4SP5oZYDijImyVlyLRCKnRPS1zH41wmCWbXKHMtq0U/Y7Wtw
 2lZijMCFoXYBbBR0mQBPs/5GelUGDZ3zs55LDO9ZfG3ndzxuKSh13z1QM3v7OzB/YT+m
 1n9R4Izbwu4nqh1DNg51DS9pXLwMJNKkHEBpWMvRPefVCSZWW/6U9ergBLoU4VMVb0/G
 i5nJAT3FTsRrUa1BDy6I3O0dRCvfX9za8QCFJA9XIleQ4l/LmTcHsmV878K05iABsyZV
 lWMQ==
X-Gm-Message-State: APuU4Z9vZXDEIuh/IIcxzCTH4VUk9u4AcdL9azUyaCk0Y9XELccjw1hU
 GSTkZpo+TW6km3yx84fvkW//uGLkWkXktxI7+bEXQ5Ik079j9yyZcK6amYEP+gN9
X-Gm-Gg: AYBFou39JBJPEwAKIIZpMw+l7wNtdZnGccFroIXg/iPl2aS8xb89GIjVJXWF+QRxrdR
 D/9N7wtsZ6DmIHGoMDSpjh9QPHWxkrMSgGeri5zmYSqDEttN3yEzSj6eeZ4z/spSBcvc9sSrCZe
 bsmx6TGbLAJhU8D1g+tji5AhQEbp7IEixQgJPPOHTMuc/7Lgz/9dJP95/TR1VwkExPhjTb00Y9t
 2L4MJYP628xWpsZiI9LP7rhnMcZiMWGj9DcVWdaQOaNnwtnDk24pWc4eIiAk5hHlYAJB3TX7ZQo
 kFgPCUgK3AaKPwB+rcRVuJk3L1H/+nxvGsDKgduIHVBWhbKG6YUv8hW1XO/AWeoCnvmIdpTNOHh
 d+hmSqMKq5xC57u0F6hMNMU7KCqvEaq9tF07noebpuT8sQrDS7kODS3Sj5X2iiU88PUV49pj41F
 eTG+15UkmOgbMZOZuEVw6WDPAXgLuq3xx+X/IML4SF7DV7M3zjw8g9yvBmYNt9kEzdcvAUMVB/X
 kO8RyG49Z0ZDyKXhw8H9eJ7th5/VEjFm0v4zmuDEUzf9h00QnrMmTmmk8P+gDtKY70G40vgQ6Pq
 2bKA5MgNZYFlIXPtlcG9mBAowSzzBGOKFYtKoNRoXDvjjXlP1wF2ArRZwiY=
X-Received: by 2002:a17:903:1aab:b0:2ed:3ca1:848d with SMTP id
 d9443c01a7336-2ee0ddb1fc5mr21098705ad.25.1794562034856; 
 Fri, 13 Nov 2026 01:27:14 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:27:13 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 13/14] tests/unit/iothread: update AioContext ref/put
 helpers
Date: Fri, 13 Nov 2026 17:26:04 +0800
Message-ID: <20261113092605.942292-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the unit-test IOThread stubs and callers to use
iothread_ref_and_get_aio_context() together with the matching
iothread_unref_and_put_aio_context().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 tests/unit/iothread.c             | 18 ++++++++++++------
 tests/unit/iothread.h             |  7 ++++++-
 tests/unit/test-aio-multithread.c |  5 ++++-
 tests/unit/test-bdrv-drain.c      | 18 +++++++++++++-----
 tests/unit/test-block-iothread.c  | 21 ++++++++++++++-------
 5 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/tests/unit/iothread.c b/tests/unit/iothread.c
index a363bf8f70..790cd2dce7 100644
--- a/tests/unit/iothread.c
+++ b/tests/unit/iothread.c
@@ -30,12 +30,23 @@ struct IOThread {
     bool stopping;
 };
 
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             IOThreadHolder *holder)
+{
+    return iothread->ctx;
+}
+
+void iothread_unref_and_put_aio_context(IOThread *iothread,
+                                        IOThreadHolder *holder)
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
@@ -113,8 +124,3 @@ IOThread *iothread_new(void)
     qemu_mutex_unlock(&iothread->init_done_lock);
     return iothread;
 }
-
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
diff --git a/tests/unit/iothread.h b/tests/unit/iothread.h
index eb4d0c77f8..9bdac074c0 100644
--- a/tests/unit/iothread.h
+++ b/tests/unit/iothread.h
@@ -17,9 +17,14 @@
 #include "qemu/thread.h"
 
 typedef struct IOThread IOThread;
+typedef struct IOThreadHolder IOThreadHolder;
+
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             IOThreadHolder *holder);
+void iothread_unref_and_put_aio_context(IOThread *iothread,
+                                        IOThreadHolder *holder);
 
 IOThread *iothread_new(void);
 void iothread_join(IOThread *iothread);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 #endif
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 9179cdc6a3..66ba5a466b 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -69,7 +69,7 @@ static void create_aio_contexts(void)
 
     for (i = 0; i < NUM_CONTEXTS; i++) {
         threads[i] = iothread_new();
-        ctx[i] = iothread_get_aio_context(threads[i]);
+        ctx[i] = iothread_ref_and_get_aio_context(threads[i], NULL);
     }
 
     qemu_event_init(&done_event, false);
@@ -87,6 +87,9 @@ static void join_aio_contexts(void)
     for (i = 0; i < NUM_CONTEXTS; i++) {
         aio_context_ref(ctx[i]);
     }
+    for (i = 0; i < NUM_CONTEXTS; i++) {
+        iothread_unref_and_put_aio_context(threads[i], NULL);
+    }
     for (i = 0; i < NUM_CONTEXTS; i++) {
         iothread_join(threads[i]);
     }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 43b0ba8648..05c31ffca8 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -537,8 +537,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
 
     IOThread *a = iothread_new();
     IOThread *b = iothread_new();
-    AioContext *ctx_a = iothread_get_aio_context(a);
-    AioContext *ctx_b = iothread_get_aio_context(b);
+    AioContext *ctx_a = iothread_ref_and_get_aio_context(a, NULL);
+    AioContext *ctx_b = iothread_ref_and_get_aio_context(b, NULL);
 
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
@@ -612,6 +612,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
 
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_unref_and_put_aio_context(a, NULL);
+    iothread_unref_and_put_aio_context(b, NULL);
 
 out:
     iothread_join(a);
@@ -762,7 +764,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
         AioContext *ctx;
 
         iothread = iothread_new();
-        ctx = iothread_get_aio_context(iothread);
+        ctx = iothread_ref_and_get_aio_context(iothread, NULL);
         blk_set_aio_context(blk_src, ctx, &error_abort);
     }
 
@@ -892,6 +894,10 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     bdrv_unref(src_overlay);
     bdrv_unref(target);
 
+    if (use_iothread) {
+        iothread_unref_and_put_aio_context(iothread, NULL);
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
+    AioContext *ctx_a = iothread_ref_and_get_aio_context(a, NULL);
+    AioContext *ctx_b = iothread_ref_and_get_aio_context(b, NULL);
 
     bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
@@ -1410,6 +1416,8 @@ static void test_set_aio_context(void)
     bdrv_try_change_aio_context(bs, qemu_get_aio_context(), NULL, &error_abort);
 
     bdrv_unref(bs);
+    iothread_unref_and_put_aio_context(a, NULL);
+    iothread_unref_and_put_aio_context(b, NULL);
     iothread_join(a);
     iothread_join(b);
 }
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 5273ff235a..fc9735d056 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -466,7 +466,7 @@ static void test_sync_op(const void *opaque)
 {
     const SyncOpTest *t = opaque;
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     BlockBackend *blk;
     BlockDriverState *bs;
     BdrvChild *c;
@@ -493,6 +493,7 @@ static void test_sync_op(const void *opaque)
 
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 typedef struct TestBlockJob {
@@ -549,7 +550,7 @@ BlockJobDriver test_job_driver = {
 static void test_attach_blockjob(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     BlockBackend *blk;
     BlockDriverState *bs;
     TestBlockJob *tjob;
@@ -595,6 +596,7 @@ static void test_attach_blockjob(void)
 
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 /*
@@ -612,7 +614,7 @@ static void test_attach_blockjob(void)
 static void test_propagate_basic(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_verify;
@@ -658,6 +660,7 @@ static void test_propagate_basic(void)
     bdrv_unref(bs_b);
     bdrv_unref(bs_a);
     blk_unref(blk);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 /*
@@ -676,7 +679,7 @@ static void test_propagate_basic(void)
 static void test_propagate_diamond(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_c, *bs_verify;
@@ -736,12 +739,13 @@ static void test_propagate_diamond(void)
     bdrv_unref(bs_c);
     bdrv_unref(bs_b);
     bdrv_unref(bs_a);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 static void test_propagate_mirror(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     AioContext *main_ctx = qemu_get_aio_context();
     BlockDriverState *src, *target, *filter;
     BlockBackend *blk;
@@ -807,12 +811,13 @@ static void test_propagate_mirror(void)
     blk_unref(blk);
     bdrv_unref(src);
     bdrv_unref(target);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 static void test_attach_second_node(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     AioContext *main_ctx = qemu_get_aio_context();
     BlockBackend *blk;
     BlockDriverState *bs, *filter;
@@ -840,12 +845,13 @@ static void test_attach_second_node(void)
     bdrv_unref(filter);
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 static void test_attach_preserve_blk_ctx(void)
 {
     IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *ctx = iothread_ref_and_get_aio_context(iothread, NULL);
     BlockBackend *blk;
     BlockDriverState *bs;
 
@@ -871,6 +877,7 @@ static void test_attach_preserve_blk_ctx(void)
     blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
     bdrv_unref(bs);
     blk_unref(blk);
+    iothread_unref_and_put_aio_context(iothread, NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.53.0


