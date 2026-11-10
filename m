Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE19606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=fI7+Xmbb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOQ-0003XL-Lg; Tue, 10 Nov 2026 10:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO3-00037V-MP
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO1-0008UP-9J
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so802172f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323028; x=1794927828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vF6kFcDMQ1VuXLdbyXfYLNVRnEpNUNDUbAvytuAdsMo=;
 b=fI7+Xmbb03IdDayKUPDc8M/fAqN6AWY72BCbdlVZjPdP0tNeH7rtjlmRjP3ROwMiQK
 MgdZbofGsK8CKEsXPfxJeEkHEDpl9HocwA5OqwlX1N/cb8Nfcdh2ETXmUEo6Kyv8au3L
 D68qGz2gMmi0JZ8UQIV5BodJ9v1iy9WJegNREPHbT2zcRefgMbmOme+HjmTPRdOLzTXd
 fSwqiK/Dle8ouQnRBPkqypc5Ob+OvxUuqBeCE0V7InhvT0DcLW9q/M8AnJzfgBLsIday
 xXvHCs5P1TBmg024mTZTMvOw5l8ohuJw2js63B0SnfRllFxxKjgb4BvZViFKliwPo02A
 iFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323028; x=1794927828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vF6kFcDMQ1VuXLdbyXfYLNVRnEpNUNDUbAvytuAdsMo=;
 b=2MvYH5NDbCkGyk8yIBIJLIDKv2VihtNBjDFnkRWUFylluG8Fn20t8agq/UF9cU34Eg
 n3Q1mWM8qaUGxOivw0U1dd+aafOJWSFERKv3m6pE4SiQJnvCotIePWiHjA4SWxOEbwG1
 tsq2QULNwUr05OjRtaKqZ9Jk1Sw7tYSwljKwaXNYaehmT+PZat+sYDshC6G9T6ZCOtiy
 dfadCxKYIsxsaF51QGP9uGdBtLvIVa4SVVMV7qASFC9n8KSbTsvPjB3OI8UiZ/Dblf/s
 wkJoLf0UMc1E9YhK28XN3TfFG6bQW1BAkdxwfb3E6/yxD455+FuEPeXo9NXfbZadCvvc
 PVjA==
X-Gm-Message-State: APuU4Z+me0y6dQDedXvbpl7sevpPdfB5oEiq3ar/bVF+hKMV0+w2a4XR
 HrCwF1NEiHxKj0ig4fo+T3i4OmclbEz5pBBIsC2C8kXO31ItRwpTUBZ+XGbHgkSDcKkevPmA/hH
 MvOcKLzI=
X-Gm-Gg: AYBFou0BeTN91jT05S0t8Y5dq+ti8nOKtzxw+SrmQTG6kCbsxRHhUMyw5llyrEdxfcn
 sfbfX+gNqoXa6u8EqfVkmMpqnAyIlsestY9tQ6v8CowObO/IOoXEStpfbkTLpAM7++DSq7oiat/
 O0pbTJyRzFw/jLuyMmFHOcb3WJ6oKIkVTD3dixuO/rZT7/8yfkIUmKv6J6f4qJ70DFwaouS8jyv
 Y/dptCGQDWQQi9CDzWv0jGSCjbAGAyKIBVH3sFg1qB2xhW9aqjzeMzuiVyIWJZGDlBQFxCxuZYr
 D4t3qepIB3GXnmYKxWFdbUzXaqKYqa9M/fcG5nAiWTuqNWT3rv5J1UiuWgg88Jj+CzoxkoIAIue
 26JUVilIJADugSxztrG2i4RpsORp0l/J98+Ltlj4iXlXg5CGkbBtLAr4IAerWLYvf7N97Rob1tb
 fY3PXC1HIkqPJ4ifZ69qh1WWI3in42f3+c213IRbq+xNu5963WIGOpbTVG/NeWq7bI+SE/2aULV
 6k3JZ+e47v5deovFm6EBDkw0MZ2tOC5UYDspANeew1x7wXLJxyuA6K9euZLULBNlHViawtBUym8
 7+PcKVsxgOiPzeE0SRod9wbLNANR/xJf1i3o3Q+bA3/7yiQQiSMilDfgLP6Aj8Z5lbU/ahUJ
X-Received: by 2002:a05:6000:2997:20b0:48b:108:48cf with SMTP id
 ffacd0b85a97d-4982f2b5c98mr4118648f8f.25.1794323027666; 
 Tue, 10 Nov 2026 07:03:47 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:47 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 04/13] migration/rdma: Add the send consumer thread
 (drain only)
Date: Tue, 10 Nov 2026 16:02:38 +0100
Message-ID: <20261110150247.193208-5-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::435;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


