Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F3606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=fvPiaqEy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOO-0003Rt-1l; Tue, 10 Nov 2026 10:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOD-0003E7-IN
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:03 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOB-0008WU-11
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1261014f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323038; x=1794927838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBmUA4ULHIPhXNmPUl/ZT9VTepWI0SoxkcPZ2XoCmSQ=;
 b=fvPiaqEyVkNVqXVWE1aZZqlbIOfH5taQgLie1/p+a/s7oQa3d6p99OcNEDXmSI7TG2
 zXOJ/+Yj2j+13Cq7aSw8VC0HWuTgd0sdzurfDG0N7xVAiwuyoPB9QylgGqwj6u+HDVUg
 hZQm9Pv9IEvehhNFx+sSdSCw4/tHbRXl28Kxh7saAoFKdUVxO8rFhTWuFD8MEd6Tf35f
 3sB4cArAoxYySe9iQBeRgGfUIaOpG4jCYywLRvrGCihlA1mHmmXeh0jeyX8LMZtXl3wi
 YERZc/Iw9Ps0v9YN1MKIO6F+30i+TCp7a2T7X6dCWQHwgrK0ULnVBfvEy8gtC1YiKcI9
 LIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323038; x=1794927838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBmUA4ULHIPhXNmPUl/ZT9VTepWI0SoxkcPZ2XoCmSQ=;
 b=DFMPyGZ8kKG/9mlj20X4B5CEXNL2O6RrA/KSUbefBJU/rXtvNRJqRoYc+vb22+sogi
 dkzNCvGqB7/+VLu2x8llD8y+R8/mMzaRqf92yMpYe5E3i5847uE/0ifCNC0co9fF8jGF
 GfNXygyNePTzsDMhI7DpbV1C+Yvfhcv8pfIaCHSdm6xpZd45L5gmF6jWwhFSDxyumLQR
 EPdXFW5oKwxNSy3JskeCGUXEEPOLN9fbrVn2GofJqW+A2zWUTErytOnGfOnj39ayd9zy
 4SO1uA7yXGARWAfX18Wo/5mmkPswwZs2WrtPeXaFc/463SRQp7Kit6lGrzvWuZ4IbRAu
 MFEA==
X-Gm-Message-State: APuU4Z9Mtmr2qjwLLxxP/+ydlI7L8GOpbw7BX3uY8pajYMyUZ1FuHowK
 3GQ51cYMusSWI6nfja43dBM7qicC66PJlYoi9IwxxjxI/1leJnjGfRAwUpYTy/n7mcJgIgrws+x
 Mb2bXMQc=
X-Gm-Gg: AYBFou28hS16jYUmvPGKJvDXsDUjonl6sZBy9nBb0qH5DadT2pNCbTbVpaB5V6WUvfv
 pgwFWGccN2kCleK6B8/JndW/8FGi2prfd05dgxOrxSCbpt1Gb8w4+40r0AiHJr7ZfpCsM0HKylH
 lfL8Ag6L5NjQjD5BsRSCUg3YlHiCa6gudTYKam5bgTjRNqOrayER2jyR8m1S09hQtZ5w3Vkvd8s
 HfDA3waGxArEHDu4+g2aB3XH9PPdEeV3C1075Mjvo/z/57K2SXgtLxeRJ46zaAVoESYJwWWIN+J
 XkJ0W4ohuQJ1rVvlX150lJjxSFouxnSNrd0SsUh795VW8edGc537nDH59thD4Tw9oNsQb7YexF/
 6CEf5VkSCgul2fd1zRjfxwZ2g8D4jnEKQBPdRzf4e886Iayamk1p3UGMzV2HPUeMR+Es8DaHpQa
 rRVm0/F9q2sizSzPdTUrFUYyXF3inU5D1jl8tPzmOTRgulliuBm8MB8M1WKIBmY2IfE0WrK4GsY
 ZFca4hDK4f2fQ5akrjbkKtUmStGOeDLHWhj+HJq1bxF6L2zlSOu8UKFuqAdfLm8ug1wxa5vcBZT
 rjQwkCvLjVp8NnrjsKgC88EzOHTx8IWnfV6ZG8i3/rB5rytCSrEOucvx5+H8QIRN9R/IQogD
X-Received: by 2002:a05:6000:4a0b:b0:492:7efe:3fc5 with SMTP id
 ffacd0b85a97d-49830111e38mr4738659f8f.23.1794323037628; 
 Tue, 10 Nov 2026 07:03:57 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:57 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 08/13] migration/rdma: Add producer/consumer tuning
 instrumentation
Date: Tue, 10 Nov 2026 16:02:42 +0100
Message-ID: <20261110150247.193208-9-dmitrii.omelchenko@cloud.ionos.com>
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

Add producer full-wait, ring occupancy and consumer idle counters, the
per-migration prodcons stats dump, and trace events for ring push,
barrier, wake, dispatch and consumer lifecycle.  Observability only; the
transfer path is unchanged.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c       | 75 +++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events | 13 ++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a0ff73e313..628afaccaf 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -32,6 +32,7 @@
 #include "qemu/thread.h"
 #include "qemu/sockets.h"
 #include "qemu/coroutine.h"
+#include "qemu/timer.h"
 #include "system/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
@@ -1213,7 +1214,9 @@ static int producer_flush_pending(RDMAContext *rdma);
 static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
                         const struct iovec *iov, size_t niov);
 static void ring_set_abort(RDMAContext *rdma);
+static unsigned ring_occupancy(RDMAContext *rdma);
 static void rdma_nbsent_stats_dump(RDMAContext *rdma);
+static void rdma_prodcons_stats_dump(RDMASendRing *r);
 
 /*
  * Consult the connection manager to see a work request
@@ -2616,6 +2619,7 @@ static int rdma_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
     }
 
     /* Complete all chunks in the ring before the next round. */
+    trace_rdma_ram_round_notify(ring_occupancy(rdma));
     if (ring_barrier(rdma, RDMA_CMD_FLUSH, 0, NULL, 0) < 0) {
         error_setg(errp, "RDMA consumer aborted during round drain");
         return -1;
@@ -2684,6 +2688,14 @@ static bool ring_empty(RDMASendRing *r)
     return (qatomic_load_acquire(&r->head) - r->tail) == 0;
 }
 
+/* Producer-side snapshot of queued-but-unprocessed commands in the ring. */
+static unsigned ring_occupancy(RDMAContext *rdma)
+{
+    RDMASendRing *r = rdma->send_ring;
+
+    return r->head - qatomic_read(&r->tail);
+}
+
 static void ring_set_abort(RDMAContext *rdma)
 {
     RDMASendRing *r = rdma->send_ring;
@@ -2703,6 +2715,7 @@ static void ring_wake_producer(RDMASendRing *r)
 {
     smp_mb();   /* order the *_waiting load below vs the sleeper's store */
     if (qatomic_read(&r->producer_waiting)) {
+        trace_rdma_ring_wake_producer();
         qemu_mutex_lock(&r->wait_lock);
         qemu_cond_broadcast(&r->not_full);
         qemu_cond_broadcast(&r->barrier_cv);
@@ -2715,20 +2728,38 @@ static void ring_wake_consumer(RDMASendRing *r)
 {
     smp_mb();   /* order the *_waiting load below vs the sleeper's store */
     if (qatomic_read(&r->consumer_waiting)) {
+        trace_rdma_ring_wake_consumer();
         qemu_mutex_lock(&r->wait_lock);
         qemu_cond_signal(&r->not_empty);
         qemu_mutex_unlock(&r->wait_lock);
     }
 }
 
+static const char *rdma_cmd_type_str(RDMACmdType type)
+{
+    switch (type) {
+    case RDMA_CMD_WRITE:    return "WRITE";
+    case RDMA_CMD_FLUSH:    return "FLUSH";
+    case RDMA_CMD_REG_STOP: return "REG_STOP";
+    case RDMA_CMD_FILE:     return "FILE";
+    case RDMA_CMD_FINISH:   return "FINISH";
+    default:                return "UNKNOWN";
+    }
+}
+
 static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
 {
     RDMASendRing *r = rdma->send_ring;
+    unsigned occupancy;
 
     /* SETUP starts the consumer before any WRITE/FLUSH/REG_STOP/FILE. */
     assert(r);
+    trace_rdma_ring_push_begin(rdma_cmd_type_str(cmd->type),
+                               cmd->chunk_index);
 
     if (ring_full(r)) {
+        int64_t wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+
         qemu_mutex_lock(&r->wait_lock);
         r->producer_waiting = true;
         smp_mb();                       /* pair with ring_wake_producer() */
@@ -2737,12 +2768,23 @@ static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
         }
         r->producer_waiting = false;
         qemu_mutex_unlock(&r->wait_lock);
+
+        wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - wait_ns;
+        r->pushwait_total_ns += wait_ns;
+        if ((uint64_t)wait_ns > r->pushwait_max_ns) {
+            r->pushwait_max_ns = wait_ns;
+        }
+        trace_rdma_ring_push_full_wait(cmd->type, wait_ns);
     }
     if (qatomic_read(&r->abort)) {
         return -1;
     }
     r->ring[r->head & RDMA_SEND_RING_MASK] = *cmd;
     qatomic_store_release(&r->head, r->head + 1);   /* publish payload+slot */
+    occupancy = r->head - qatomic_read(&r->tail);
+    if (occupancy > r->occupancy_max) {
+        r->occupancy_max = occupancy;
+    }
     ring_wake_consumer(r);
     return 0;
 }
@@ -2798,8 +2840,10 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
                         const struct iovec *iov, size_t niov)
 {
     RDMASendRing *r = rdma->send_ring;
+    int64_t wait_ns;
     unsigned seq;
     RDMACmd cmd;
+    int ret;
 
     assert(r);          /* consumer started at SETUP; see ring_push() */
 
@@ -2813,6 +2857,7 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
     if (seq == 0) {                 /* seq 0 is the "no barrier" sentinel */
         seq = ++r->barrier_next_seq;
     }
+    trace_rdma_ring_barrier_begin(type, seq);
     cmd = (RDMACmd){
         .type = type,
         .flags = flags,
@@ -2822,10 +2867,16 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
     };
 
     if (ring_push(rdma, &cmd) < 0) {
+        trace_rdma_ring_barrier_end(type, seq, 0, -1);
         return -1;
     }
 
-    return ring_wait_barrier(r, seq);
+    /* time spent blocked waiting for the consumer to complete the barrier */
+    wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    ret = ring_wait_barrier(r, seq);
+    wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - wait_ns;
+    trace_rdma_ring_barrier_end(type, seq, wait_ns, ret);
+    return ret;
 }
 
 static bool ring_pop(RDMASendRing *r, RDMACmd *cmd)
@@ -2853,12 +2904,21 @@ static void ring_barrier_complete(RDMASendRing *r, unsigned seq)
 /* Consumer: sleep until the ring is non-empty or aborted. */
 static void ring_idle_wait(RDMASendRing *r)
 {
+    int64_t start_ns, idle_ns;
+
     qemu_mutex_lock(&r->wait_lock);
     r->consumer_waiting = true;
     smp_mb();                           /* pair with ring_wake_consumer() */
+    start_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    trace_rdma_consumer_idle_begin();
     while (ring_empty(r) && !r->abort) {
         qemu_cond_wait(&r->not_empty, &r->wait_lock);
     }
+    idle_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_ns;
+    trace_rdma_consumer_idle_end(idle_ns);
+    if ((uint64_t)idle_ns > r->idle_max_ns) {
+        r->idle_max_ns = idle_ns;
+    }
     r->consumer_waiting = false;
     qemu_mutex_unlock(&r->wait_lock);
 }
@@ -2876,6 +2936,7 @@ static int rdma_consumer_reg_stop(RDMAContext *rdma, uint64_t flags,
             return -1;
         }
         rdma_nbsent_stats_dump(rdma);
+        rdma_prodcons_stats_dump(rdma->send_ring);
     }
     return qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, errp);
 }
@@ -2886,6 +2947,9 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
     Error *err = NULL;
     int ret = 0;
 
+    trace_rdma_consumer_dispatch(cmd->type, cmd->block_index,
+                                 cmd->chunk_index, cmd->seq);
+
     switch (cmd->type) {
     case RDMA_CMD_WRITE:
         ret = qemu_rdma_write_chunk(rdma, cmd->block_index,
@@ -2919,6 +2983,7 @@ static void *rdma_consumer_thread(void *opaque)
     bool stop = false;
 
     rcu_register_thread();
+    trace_rdma_consumer_thread_start();
 
     while (!qatomic_read(&r->abort) && !stop) {
         RDMACmd cmd;
@@ -2950,6 +3015,7 @@ static void *rdma_consumer_thread(void *opaque)
         /* make the failure visible to the producer's rdma_errored() checks */
         rdma->errored = true;
     }
+    trace_rdma_consumer_thread_stop(qatomic_read(&r->abort));
     rcu_unregister_thread();
     return NULL;
 }
@@ -3363,6 +3429,13 @@ static void rdma_nbsent_stats_dump(RDMAContext *rdma)
                             rdma->nbsent_full_hits, rdma->nbsent_zero_hits);
 }
 
+/* Producer/consumer ring stats for the whole migration (consumer at FINISH). */
+static void rdma_prodcons_stats_dump(RDMASendRing *r)
+{
+    trace_rdma_prodcons_stats(r->idle_max_ns, r->pushwait_max_ns,
+                              r->pushwait_total_ns, r->occupancy_max);
+}
+
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
diff --git a/migration/trace-events b/migration/trace-events
index 2fdd684115..e38c125426 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -250,6 +250,19 @@ rdma_write_flush(int sent) "sent total: %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
 rdma_nbsent_stats(uint64_t max, uint64_t posts, uint64_t full_hits, uint64_t zero_hits) "nb_sent max %" PRIu64 " posts %" PRIu64 " full-queue hits %" PRIu64 " drains to zero %" PRIu64
+rdma_consumer_dispatch(int type, uint32_t bidx, uint32_t cidx, uint32_t seq) "cmd type=%d block=%" PRIu32 " chunk=%" PRIu32 " seq=%" PRIu32
+rdma_ring_wake_producer(void) "waking blocked producer"
+rdma_ring_wake_consumer(void) "waking idle consumer"
+rdma_ring_push_begin(const char *type, uint32_t chunk_index) "push begin type=%s chunk_index=%" PRIu32
+rdma_ring_push_full_wait(int type, int64_t wait_ns) "push full-wait type=%d wait=%" PRId64 " ns"
+rdma_ring_barrier_begin(int type, uint32_t seq) "barrier begin type=%d seq=%" PRIu32
+rdma_ring_barrier_end(int type, uint32_t seq, int64_t wait_ns, int ret) "barrier end type=%d seq=%" PRIu32 " wait=%" PRId64 " ns ret=%d"
+rdma_consumer_thread_start(void) "consumer thread started"
+rdma_consumer_thread_stop(bool aborted) "consumer thread stopped, aborted=%d"
+rdma_consumer_idle_begin(void) "consumer idle: waiting for commands"
+rdma_consumer_idle_end(int64_t idle_ns) "consumer idle: woke after %" PRId64 " ns"
+rdma_ram_round_notify(uint32_t occupancy) "ram round notify: ring occupancy=%" PRIu32
+rdma_prodcons_stats(uint64_t idle_max, uint64_t pushwait_max, uint64_t pushwait_total, uint64_t occupancy_max) "idle max %" PRIu64 " ns, push full-wait max %" PRIu64 " ns total %" PRIu64 " ns, ring occupancy max %" PRIu64
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.39.5


