Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2D606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=FVMalcxp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOZ-00047d-Hv; Tue, 10 Nov 2026 10:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOF-0003Hc-Dw
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOD-00004y-IM
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so21379125e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323040; x=1794927840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PEbTPI/qyKxqRmY+I5qxg6KvizpRcLX6eTefYNr+pp4=;
 b=FVMalcxp+mcCt5GY21VT91FRUzulwOOYa7IZWEaBrj5PPzJRwLkGxVFnCxobNsnrxs
 429Uejg4cKTfJX5Tm3tOiqAKLP1/CMwbAd0EK4OXPx5P9A+DUlguoyGh1jY8F3NAJbYr
 HeNzMtGm727H16oJ03CQc0zauWXfJLYxZFkCMdUbenfmNz/BFm7wjaVOri6FGZC0q78L
 9N2fQrLcBNNgeyXRNNXyRaMJH16oDftW0nQlJzhY55lLhZLSYDvBQzu1WfgHtlOgWugo
 KIrWIRFv+STjMTcFnlkS1ure/RE8s5yMwnRMV7iY+z3srC7WB9njQiK+0bZU0USXPJLO
 SrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323040; x=1794927840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PEbTPI/qyKxqRmY+I5qxg6KvizpRcLX6eTefYNr+pp4=;
 b=JEpDLECw0oaf1wauJUxgKMU66r0JVjgJMXsEyR9ybS58aCT98PnItv+ruvuimCCcER
 KQeHOgY8dSglmd9XtFcq2/AH2xjtbf9aaJ+7n35RM+vlUD8a8oxtTlbFuxuCPpcTChy/
 ajx7YyHfOF/HCSFwDQtyg6S/kAJAB/akbJe0rNmspgJiUrydw+ax2F9jwwlDfG7wk/QH
 UNNBOvKyjR4U+cCnagj7wSqPd+Gxp7GbJbC8Z6DzZ0xGowV9UJssjX4AvRvbxMYPOXox
 zhGC4AgoqZB0unh8shtSoeOuWT4AAUsjQqEniWMG7buYEACI4G9nEItbXLokM4+umphU
 QYAg==
X-Gm-Message-State: APuU4Z8w2hMU3YXELqDPTOGVsJP2wONzz5VAY5VNmJLgZuTLgHsTvVZP
 RDpNXf2UXaFvda6W/RyqY+Yb1XE0eAAKXnpak/sREMhXVP5qD+LMtQJjZrg38xAvzxFGy1UsPYa
 l0eJK0lk=
X-Gm-Gg: AYBFou2Rg4EAkgWoHJkqdPhXJ2kNJQNsm8RlHWGpc25SPR+CU6knGk7oUjaB30A6wNX
 1g7Lq1HLe7ybQ6eea/rmPxf+0PwCWNwokxK3xC9Zfvl6oil7+xeDEts39vkTFizMeG5Y4wLpQ0h
 1VVoExBSS3V/vrXitkRK/vg91Y1SY4rnS6EOXqRDzUFSdIrqW9Oa1wZvOT4ZG9QsuohMudFsd+s
 opbnlvBJt787Ctzu/HCPDyt85I9UqUwPIaxHgNT5utfUjPyRHCa+c35zFn7vipsH/CDE3CyZGUX
 Z1vrHGsribhe2olZRUVC3MJ8/vK/oQukz4Ip0algPfwFCldWfQivBR8kW3E6hQ4HCZYOxMjMX9e
 9JwVGCcXIvuXc63zfofTY5yr0wQ43wFD1WbjVw7IaWYHAiHVHRnNlmREbxpChlTLRSPqjguQLEo
 kUNzu43yTD3sZGQ/aU+7BgPRw7asb9rXlzNK3zpf/3cVW156829EC/p+12CDFQIZG99zyFWyRFr
 diixSY4TNWRxyPrmRbO7H9wcIaHsQ47mHI/rlLaeSQBQenTXluqcSbuNB1lg6yqnndMug1TlOvN
 BMzcW/OAjyHPEYVhlHpE083H9j0gFwNW3h0Ms1sGpf0wF22YO5JKYWFeSfRMbV7HMnBCRrAd
X-Received: by 2002:a05:600d:82e1:b0:4af:79ee:f660 with SMTP id
 5b1f17b1804b1-4ba02357df3mr61019855e9.31.1794323040083; 
 Tue, 10 Nov 2026 07:04:00 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:59 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 09/13] migration/rdma: drain the send ring in
 batches
Date: Tue, 10 Nov 2026 16:02:43 +0100
Message-ID: <20261110150247.193208-10-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::32d;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm1-x32d.google.com
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

The consumer snapshots ring occupancy, processes up to
RDMA_CONSUMER_BATCH_MAX commands, and advances the tail once per batch
instead of once per command.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 81 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 628afaccaf..db1f1e3fc6 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -67,6 +67,9 @@ static inline uint64_t rdma_merge_max(void)
 #define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
 #define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
 
+/* Max WRITE commands the consumer drains per pass. */
+#define RDMA_CONSUMER_BATCH_MAX 128
+
 #define RDMA_CONTROL_VERSION_CURRENT 1
 /*
  * Capabilities for negotiation.
@@ -2688,6 +2691,12 @@ static bool ring_empty(RDMASendRing *r)
     return (qatomic_load_acquire(&r->head) - r->tail) == 0;
 }
 
+/* Consumer-side count of published, unconsumed commands. */
+static unsigned ring_avail(RDMASendRing *r)
+{
+    return qatomic_load_acquire(&r->head) - r->tail;
+}
+
 /* Producer-side snapshot of queued-but-unprocessed commands in the ring. */
 static unsigned ring_occupancy(RDMAContext *rdma)
 {
@@ -2879,18 +2888,10 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
     return ret;
 }
 
-static bool ring_pop(RDMASendRing *r, RDMACmd *cmd)
+/* Consumer: release n drained slots at once, waking a blocked producer once. */
+static void ring_advance_tail_by(RDMASendRing *r, unsigned n)
 {
-    if (ring_empty(r)) {
-        return false;
-    }
-    *cmd = r->ring[r->tail & RDMA_SEND_RING_MASK];   /* after load_acquire */
-    return true;
-}
-
-static void ring_advance_tail(RDMASendRing *r)
-{
-    qatomic_store_release(&r->tail, r->tail + 1);
+    qatomic_store_release(&r->tail, r->tail + n);
     ring_wake_producer(r);
 }
 
@@ -2986,29 +2987,63 @@ static void *rdma_consumer_thread(void *opaque)
     trace_rdma_consumer_thread_start();
 
     while (!qatomic_read(&r->abort) && !stop) {
-        RDMACmd cmd;
+        unsigned avail = ring_avail(r);
+        unsigned batch, processed = 0;
+
+        if (avail == 0) {
+            /*
+             * Ring empty: reap ready completions without blocking, then
+             * sleep until the next push so a new command wakes us at once.
+             * Round draining is handled by RDMA_CMD_FLUSH.
+             */
+            while (rdma->nb_sent > 0) {
+                uint64_t wr_id;
+
+                if (qemu_rdma_poll(rdma, rdma->send_cq, &wr_id, NULL) < 0) {
+                    ring_set_abort(rdma);
+                    break;
+                }
+                if (wr_id == RDMA_WRID_NONE) {
+                    break;              /* nothing more ready right now */
+                }
+            }
+            if (qatomic_read(&r->abort)) {
+                break;
+            }
+            ring_idle_wait(r);
+            continue;
+        }
+
+        /*
+         * Drain up to RDMA_CONSUMER_BATCH_MAX commands, or fewer if that is
+         * all that is queued, then publish tail once for the whole batch.
+         */
+        batch = avail < RDMA_CONSUMER_BATCH_MAX ? avail
+                                                : RDMA_CONSUMER_BATCH_MAX;
+
+        while (processed < batch) {
+            unsigned idx = r->tail + processed;
+            RDMACmd cmd = r->ring[idx & RDMA_SEND_RING_MASK];
 
-        if (ring_pop(r, &cmd)) {
             if (rdma_consumer_dispatch(rdma, &cmd, &stop) < 0) {
                 ring_set_abort(rdma);
                 break;
             }
+            processed++;
             if (cmd.seq) {
                 ring_barrier_complete(r, cmd.seq);
             }
-            ring_advance_tail(r);
-            continue;
-        }
-        if (rdma->nb_sent > 0) {
-            /* Ring empty but writes in flight: reap (bounded, error-aware). */
-            if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE,
-                                         NULL) < 0) {
-                ring_set_abort(rdma);
+            if (stop) {
                 break;
             }
-            continue;
         }
-        ring_idle_wait(r);
+
+        if (processed) {
+            ring_advance_tail_by(r, processed);
+        }
+        if (qatomic_read(&r->abort)) {
+            break;
+        }
     }
 
     if (qatomic_read(&r->abort)) {
-- 
2.39.5


