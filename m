Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97193C5AC81
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gz-00052J-JN; Thu, 06 Aug 2026 16:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gY-0004Rb-02
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:26 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gU-000547-Mf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:25 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so1068112a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048041; x=1786652841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X9i2b0/bv1/lcQlTp+wSwwnIvPyYL1lQMTbimEi5moo=;
 b=I5TSr2zWmvuQUHRWFj6ptUPJygTnh8+YC3RQ+8u/td9iIAiYAIdnxvwFKODQ4Wex6y
 VLKgWy/D/8tAzEGvmJIO/gA7W2wMuTDY8U1SeHsKLOMnLZYaPROYX1bOZC6fxNDeqPOH
 a9Z5YjlHLBQFO9nktRY/mEYs1+A9m2BmkXkVNKHeSnLG9uQnHPSG31YvFX10h7fJSLnN
 /5nyayL7qW3vsKdMr9EXlR1P1ij5DkYKyYxuVSZxOaVJl8N8aukr5AzV5rg0SeVWnp49
 JKTbBd9KetMjB5QQN8I9uGAvDcH/VtAcV2h62RuaLLTZW/SXREtowBUhTrW9ODLfX40S
 mWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048041; x=1786652841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X9i2b0/bv1/lcQlTp+wSwwnIvPyYL1lQMTbimEi5moo=;
 b=GxhfMrXAABsUE/QiutCBnqp5qhIDBCmD4ywYj5op+lSif+J8JSsyHo1c3Q+Yv+3/0z
 THCKTpgn4C8cD6dxAFUAT8hANX9UFxiYtK/JbJKJoycEcGuo3UYbuXeVHvjL5IvxJUn5
 RD2bX/WWP4tnWMf7+f6kbMQEwP0ciqtwReKRz5c5qjcGWt1TGesFo5cCB8pURz76VsZi
 rczZVMzlrnJiTxg5kujcErJFrv/2LpwO47Q20JSY8j8ppef7qsVgo0u7HlonqcPYVKtk
 Pqu71KTdqnK/oNFHrV1Wokynkeybr0ov609+8Jg2IH8GVXax03igl8FGi26dAX1zSWjn
 GrgQ==
X-Gm-Message-State: AOJu0YwzeOpBC7b/LEJFJg4/AD6H/QiBsQ7GPO1QVe0TZ/iFQQCePDdf
 Q67+QAVTc7XM4CX82uAiIxITZz2GJbGfBxcN3MBrzbgbvYfq6dbgehqIE8iHlAeu9jPvNUHt
X-Gm-Gg: AR+sD10Bq/1ZmADWk+xqAw75yW7E/PK5324M5XC5V7CLiNP3bJJ9Tvt25Zq9EpMc2c5
 NikgZktQkMljFcbLeAT+GbBK4I7pmY4vnHBJ7vdRUZa7KentHCQufHPNf9Iz9zM+TnLn+eB7PFs
 jZf6rl6R8PqykQcqZEx6JzcjJ6/Sw2DJeeG9Vc9nHe0l9ydtw5qANb1Xq2pciRJ8w/iKaSGrHCP
 TxhFFeHYSuvi1s9cUYuEBhW/M/Zef8GGjsEAe2WZBq9MZL6iCPBGrEdvcSdX+IE/kPIHRBUkPQY
 Gv27iu06UvTrNXHw29jk4Ykda0nLpZgp7FL5xZ+Ll6Ol2R/9wfEoSgzEuyxseEyb1qo6qJuiaeQ
 NDBJvUQyhpVxem1iMCuSx45DAkvMFmazVbcsQ9sENFK3kyXXm12eNVGLEkDZauQhix3oUDONLr8
 7d/m5QUFBidNHhPTL/hX/hjpsHUG/aYxSCFiuqMUFpbrJkQlRxQLz8ACvJnuRLuMcDJa0ilPWQV
 kfQS7qz19h/Z8s0/QlO62tIwT4=
X-Received: by 2002:a17:90a:c887:b0:38e:4e61:c9e with SMTP id
 98e67ed59e1d1-3908986dcf8mr3422564a91.21.1786048040885; 
 Thu, 06 Aug 2026 13:27:20 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:27:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 15/15] tests/unit/iothread: update AioContext ref/put
 helpers
Date: Fri,  7 Aug 2026 04:25:24 +0800
Message-ID: <20260806202531.243806-16-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1036.google.com
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
iothread_put_aio_context().

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 tests/unit/iothread.c             | 17 +++++++++++------
 tests/unit/iothread.h             |  6 +++++-
 tests/unit/test-aio-multithread.c |  5 ++++-
 tests/unit/test-bdrv-drain.c      | 18 +++++++++++++-----
 tests/unit/test-block-iothread.c  | 21 ++++++++++++++-------
 5 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/tests/unit/iothread.c b/tests/unit/iothread.c
index a363bf8f70..af3e264e02 100644
--- a/tests/unit/iothread.c
+++ b/tests/unit/iothread.c
@@ -30,12 +30,22 @@ struct IOThread {
     bool stopping;
 };
 
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             IOThreadHolder *holder)
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
@@ -113,8 +123,3 @@ IOThread *iothread_new(void)
     qemu_mutex_unlock(&iothread->init_done_lock);
     return iothread;
 }
-
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
diff --git a/tests/unit/iothread.h b/tests/unit/iothread.h
index eb4d0c77f8..49e97b43d4 100644
--- a/tests/unit/iothread.h
+++ b/tests/unit/iothread.h
@@ -17,9 +17,13 @@
 #include "qemu/thread.h"
 
 typedef struct IOThread IOThread;
+typedef struct IOThreadHolder IOThreadHolder;
+
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             IOThreadHolder *holder);
+void iothread_put_aio_context(IOThread *iothread, IOThreadHolder *holder);
 
 IOThread *iothread_new(void);
 void iothread_join(IOThread *iothread);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 #endif
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 9179cdc6a3..a63e54fe62 100644
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
+        iothread_put_aio_context(threads[i], NULL);
+    }
     for (i = 0; i < NUM_CONTEXTS; i++) {
         iothread_join(threads[i]);
     }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 43b0ba8648..b9b153f95d 100644
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
+    iothread_put_aio_context(a, NULL);
+    iothread_put_aio_context(b, NULL);
 
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
+    AioContext *ctx_a = iothread_ref_and_get_aio_context(a, NULL);
+    AioContext *ctx_b = iothread_ref_and_get_aio_context(b, NULL);
 
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
index 5273ff235a..391b28b73a 100644
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
+    iothread_put_aio_context(iothread, NULL);
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
+    iothread_put_aio_context(iothread, NULL);
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
+    iothread_put_aio_context(iothread, NULL);
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
+    iothread_put_aio_context(iothread, NULL);
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
+    iothread_put_aio_context(iothread, NULL);
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
+    iothread_put_aio_context(iothread, NULL);
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
+    iothread_put_aio_context(iothread, NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.53.0


