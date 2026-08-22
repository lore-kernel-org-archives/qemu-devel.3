Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C52C5DF9C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMj-00043g-Cn; Sat, 22 Aug 2026 17:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMi-00042y-IU
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:35:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMg-0000ma-Il
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:35:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso29592205ad.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434497; x=1788039297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iiKC3bRLwWYp06/joq+pyoTs6m2P49xoeita0l+E+4c=;
 b=s2bh41guehRgTkJCSaGoUHLHTomORSP8r0/gyQCzdCcm84zHjRK3PWrmNng9TuV3dg
 JK1rNG4IyrltVn43rNDCbZ5vWfvHsyn2O+9uN/qiXPOI5HasfcOEft9Zv5NY6xIBa7kk
 RSy6cAemZ4lDqmLF3tp0V4nSA47KvPHbUGtj13FNnHYy6x6qmlWYW/25/TxxYmCbz2Eh
 MTT3hSHQE5kygHX8EOUSm/VgwKmeaKD/MtEM6h9NCav2Vim5sGNm+1x5cqgH2tVAELGO
 OPts6tW0IFYczviL1514rGp4uHm+TTwbvtFJeRxVl+klkeeLg43ihA4bN2toOS9t7e7+
 oczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434497; x=1788039297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iiKC3bRLwWYp06/joq+pyoTs6m2P49xoeita0l+E+4c=;
 b=A2UnK6kLgSvjfvurb6iQTdUxXpMbwlmsiK9tMLKMNMANPnMY+e5aXO7WaZwhAMGQHw
 TYQMNnXgSH2MR5amiBPzcTPFjB/Q1tf20aHu4mL26IyCaFrprgp+fGs4OIqDgoIEb26l
 LZ9wWjj2YjMYyRyHb8/toSNpcHJGuBepz2qQD4sf6DbL8OQNyvf04dRW2cIaKT3zb586
 1MR+ewy+dO4ekXO3qhOFVOsati3a6XUATXv1UEjP3t3XLO0Ptg3JSQrWVjedZSfDKWqW
 N8sXp/JLFsUX8GNYdgrpydSeAYLBscYiUxhMhEMVlSnAOgmfvAwNnuBh54Pk1COnGg0A
 ax8g==
X-Gm-Message-State: AFuF++n6kB9R/xnUPs3p0Vi4Lpf8gia6RdmEHKNuKn1hepuJzDnF2DOj
 mGWIoJXceB3GBxnDoSK5qXcaSZy/FH8AgeOE9gW5VlvxzrstLl3erBL6AcC9FnW6pUnm2wAF
X-Gm-Gg: AR+sD12Am1rufoGGPp5b3Utdlo+f0Qd2QyS9RB+4EvW44jTT+Br86kKDbZs4kPW4WzS
 G1sjwnRo7SOCnuKuG2QrG82IhhwrO2K+UGXtSMHqDZ/+04sDr83YdJATqs3GYYCTRxVr+vdxfdP
 wl1nGkIPWQYjuNsLuftLXuJq/IBT6naKjqcjhWgzyED1MHC1G9EvqXrjn7cmYA3v4hGmulYdUou
 n5zT3YyX/1W2BO9/u5r7RSTsOZqNo2RJJoneCJUebqrDQ4r43CEY0bM+JizFiVzDuKq5whjj/Q1
 Fivg72hCxiOO9K+4ZTCMf2EhE3QrZYwTPGWf+O8uHzTp/5SRHZtEX7lfTxIxmCpRqfVw2j7RaJL
 xnYW7ZIzJdtHjbIYjtS6Vh3EfpcnmxcDh1axAendPuHi0tzXIi678Mrz8bIqh47JyIJ4wiU838G
 5Ymor2+l0B+H22q67ue6gAhNsaK57RmxI62G5GTiQoxKVDKGauYLRJmmQykjCYJjGy+xzFdFGpI
 fmdokSX
X-Received: by 2002:a17:902:f68d:b0:2ca:660:b1d with SMTP id
 d9443c01a7336-2d64b025d01mr266665905ad.11.1787434497007; 
 Sat, 22 Aug 2026 14:34:57 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:56 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 15/15] tests/unit/iothread: update AioContext ref/put
 helpers
Date: Sun, 23 Aug 2026 05:33:38 +0800
Message-ID: <20260822213343.661939-16-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update the unit-test IOThread stubs and callers to use
iothread_ref_and_get_aio_context() together with the matching
iothread_unref_and_put_aio_context().

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
2.55.0


