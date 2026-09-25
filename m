Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08948C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8SP-00083i-3K; Fri, 25 Sep 2026 12:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DZ-0007s3-Um
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:10 -0400
Received: from mail-wr2-x13.google.com ([2a00:1450:4864:30::13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DX-0005xX-TU
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:09 -0400
Received: by mail-wr2-x13.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so674184f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351526; x=1790956326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vF6kFcDMQ1VuXLdbyXfYLNVRnEpNUNDUbAvytuAdsMo=;
 b=BmG4kewkHlK0+9Uq6dqchujzQO2qWUtwWFDDXd91VrdsqHCRk22BC9mGm/nwDkFjZb
 11RAoBx1e3+4aTpgTSy5ruOVMVNxyoCSYjNC6Ui+of9KTiN2XJK0TAyKwak4PDRl+rVO
 wPfMvnFDIfb33peIm+XVzwZDh6QJYXZO9JVqtBWT80iGN1Ukvnu1zduoU6maE2WwVzRb
 al37e+IdgbOQ9QVJzEfIhhaQsJlqL3AUO/kx+7B3B5hwgdkSh97nmiguTyYbRxH4o+7S
 7YA5iN1qgh/w3Df0hEFgW8jP1+WLpvfjmUtlki7xhbgC4yxb3BZEzSueL7CXTWQZ8e3x
 qJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351526; x=1790956326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vF6kFcDMQ1VuXLdbyXfYLNVRnEpNUNDUbAvytuAdsMo=;
 b=ZwnirxRx1mW1Omsd1cf7I7sX2VolR7Rb71VO48QjMhHPNbsT+xfwVUBAx2dp+hcEpD
 8yhsi7Rsq/515nCpsSJQVCme0jdhk78qMDBruluHI7OzuBnEaLaQQxme2nQ8W5WGa7rU
 dFs/w0GEkCtf7TeUqhrdZvhtqLF7cAHLb3/39Rv0tVZCAXNqq+SWogH3cZxbbkgYPAMD
 iZsgNRsWfahX1hq8RN35fc2z9if8dDv4Uwn0rKXoU8d1g/0wsXMvfEU3v0PS2zwCMPXT
 LnSdllUJqUICPjyg7YwylfA8U4o8r5vCwsetXfxjJ+D6TqAL0Mmd8yZuzzAGXiCkHf6w
 nVTg==
X-Gm-Message-State: AFuF++kjyNAF2FNQKJ+HRruhYx+TGH62av/qQLiZtNmkDi7yQPgqEKCO
 rlQ9ci+kX2DrC93fO9Cc+aIn4xQCdff9zywsYq+R6K2cNizI2SNZeK0VRCG+9aGapdcOsOfZUq4
 +Zwnuw60WPw==
X-Gm-Gg: AYBFou040ymqPl8udkw0NyNKD7/Pl1bKCCRR++2Sir+P/xzTFMo3vA8fGNxMhVZxOo0
 xd/dP89TorXCEG67R7HUk003pjByAGsU1pCs5bsSwvImTZ3r+9QCLcLlDCOfbhjZ0976yFkgjhV
 DVqyW2AXCxfswTmgwGzsW9mY2B305B/v2MRYWI1GPEadZdxsYFw+dYtf4ff8SBtldRBC/wz0WZW
 y5SGlu3qvc2/rYPsbidESRNGJIGKd+qG2gjo6AAieIiQu7tBi3VzBXiLsgOOYxv/P5oSAUJt68w
 tg+rekgN6VCAfeq7TdW+PGMoLUOk0DB0AP8wDw8lGuD4gkfyHqEijuui7/+7A/O0vCqnLiGK6E9
 rkkDeLTtzEJi7IogyPx+SmSMU8Dlr7zw1SywzYmh5xBPC1WS3v1jdsYseecBok/7osWaBKV1fuy
 LN/IDrVM+KUGaQP1Zme4UUHhlJAG6vvWG32Wvq1nhNae66EqdUYCWckjszN0D7N8CqW2RTdYBx0
 jlFk47YYTDr3eYhvRLETHTRcuRyA05povNH+WPJEg==
X-Received: by 2002:a05:600d:486:20b0:49f:e941:e26 with SMTP id
 5b1f17b1804b1-49ff06b2f01mr36998955e9.4.1790351526029; 
 Fri, 25 Sep 2026 08:52:06 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:05 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 04/13] migration/rdma: Add the send consumer thread (drain
 only)
Date: Fri, 25 Sep 2026 17:51:39 +0200
Message-ID: <20260925155149.843870-5-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:30::13;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr2-x13.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:04:59 -0400
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

Create and join the consumer thread in rdma_consumer_start/stop and add
the ring operations it needs to drain and shut down: ring_pop,
ring_advance_tail, ring_idle_wait and ring_set_abort.
rdma_consumer_dispatch handles only RDMA_CMD_FINISH (drain the CQ and
exit).  The old send path is still in charge, so the ring carries only
the FINISH pushed at teardown.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 120 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2d4807c6b8..c3070b7a92 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2111,7 +2111,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
     Error *err = NULL;
 
-    /* Free the send ring before touching the QP. */
+    /* Stop and join the consumer before touching the QP it owns. */
     rdma_consumer_stop(rdma);
 
     if (rdma->cm_id && rdma->connected) {
@@ -2764,6 +2764,37 @@ static bool ring_full(RDMASendRing *r)
     return (r->head - qatomic_load_acquire(&r->tail)) >= RDMA_SEND_RING_SIZE;
 }
 
+static bool ring_empty(RDMASendRing *r)
+{
+    return (qatomic_load_acquire(&r->head) - r->tail) == 0;
+}
+
+static void ring_set_abort(RDMAContext *rdma)
+{
+    RDMASendRing *r = rdma->send_ring;
+
+    if (!r) {
+        return;
+    }
+    qemu_mutex_lock(&r->wait_lock);
+    qatomic_set(&r->abort, true);
+    qemu_cond_broadcast(&r->not_full);
+    qemu_cond_broadcast(&r->not_empty);
+    qemu_cond_broadcast(&r->barrier_cv);
+    qemu_mutex_unlock(&r->wait_lock);
+}
+
+static void ring_wake_producer(RDMASendRing *r)
+{
+    smp_mb();   /* order the *_waiting load below vs the sleeper's store */
+    if (qatomic_read(&r->producer_waiting)) {
+        qemu_mutex_lock(&r->wait_lock);
+        qemu_cond_broadcast(&r->not_full);
+        qemu_cond_broadcast(&r->barrier_cv);
+        qemu_mutex_unlock(&r->wait_lock);
+    }
+}
+
 /* Producer -> wake the consumer if it is idle on an empty ring. */
 static void ring_wake_consumer(RDMASendRing *r)
 {
@@ -2800,10 +2831,84 @@ static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
     return 0;
 }
 
-/*
- * Producer: allocate the send ring once (idempotent).  The consumer
- * thread that drains it is created in a later change.
- */
+static bool ring_pop(RDMASendRing *r, RDMACmd *cmd)
+{
+    if (ring_empty(r)) {
+        return false;
+    }
+    *cmd = r->ring[r->tail & RDMA_SEND_RING_MASK];   /* after load_acquire */
+    return true;
+}
+
+static void ring_advance_tail(RDMASendRing *r)
+{
+    qatomic_store_release(&r->tail, r->tail + 1);
+    ring_wake_producer(r);
+}
+
+/* Consumer: sleep until the ring is non-empty or aborted. */
+static void ring_idle_wait(RDMASendRing *r)
+{
+    qemu_mutex_lock(&r->wait_lock);
+    r->consumer_waiting = true;
+    smp_mb();                           /* pair with ring_wake_consumer() */
+    while (ring_empty(r) && !r->abort) {
+        qemu_cond_wait(&r->not_empty, &r->wait_lock);
+    }
+    r->consumer_waiting = false;
+    qemu_mutex_unlock(&r->wait_lock);
+}
+
+static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
+                                  bool *stop)
+{
+    Error *err = NULL;
+    int ret = 0;
+
+    switch (cmd->type) {
+    case RDMA_CMD_FINISH:
+        ret = qemu_rdma_drain_cq(rdma, &err);
+        *stop = true;
+        break;
+    default:
+        break;
+    }
+    if (ret < 0 && err) {
+        error_report_err(err);
+    }
+    return ret;
+}
+
+static void *rdma_consumer_thread(void *opaque)
+{
+    RDMAContext *rdma = opaque;
+    RDMASendRing *r = rdma->send_ring;
+    bool stop = false;
+
+    rcu_register_thread();
+
+    while (!qatomic_read(&r->abort) && !stop) {
+        RDMACmd cmd;
+
+        if (ring_pop(r, &cmd)) {
+            if (rdma_consumer_dispatch(rdma, &cmd, &stop) < 0) {
+                ring_set_abort(rdma);
+                break;
+            }
+            ring_advance_tail(r);
+            continue;
+        }
+        ring_idle_wait(r);
+    }
+
+    if (qatomic_read(&r->abort)) {
+        /* make the failure visible to the producer's rdma_errored() checks */
+        rdma->errored = true;
+    }
+    rcu_unregister_thread();
+    return NULL;
+}
+
 static void rdma_consumer_start(RDMAContext *rdma)
 {
     RDMASendRing *r;
@@ -2820,9 +2925,10 @@ static void rdma_consumer_start(RDMAContext *rdma)
     rdma->pend_block = -1;        /* no pending WRITE span yet */
     /* Producer-only flag (migration thread + cleanup, never concurrent). */
     rdma->consumer_started = true;
+    qemu_thread_create(&rdma->consumer_thread, "rdma-send",
+                       rdma_consumer_thread, rdma, QEMU_THREAD_JOINABLE);
 }
 
-/* Producer: tear down the send ring. */
 static void rdma_consumer_stop(RDMAContext *rdma)
 {
     RDMASendRing *r = rdma->send_ring;
@@ -2835,6 +2941,8 @@ static void rdma_consumer_stop(RDMAContext *rdma)
     if (!qatomic_read(&r->abort)) {
         ring_push(rdma, &cmd);
     }
+    qemu_thread_join(&rdma->consumer_thread);
+
     qemu_mutex_destroy(&r->wait_lock);
     qemu_cond_destroy(&r->not_full);
     qemu_cond_destroy(&r->not_empty);
-- 
2.39.5


