Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913E4C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8SV-0008Vp-Mo; Fri, 25 Sep 2026 12:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dg-0007uD-Am
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:16 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dd-0005yy-9E
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:16 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso13765705e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351532; x=1790956332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pf2ATrAliPD5ewLoMgWuEE/Tzn/xf6Ocf52nYwtMr4A=;
 b=jBGU/fsZ9flxushMFVBlqJygjXpFGn4SJtNCpEJOorscQ0VH/p/w4BYfaLMEpmjhL7
 a5EM8Anng8YMVjvZ/BQW5ElNwGdTcOdOk9U2lj5bm9JZiyIa/WUBIg6Y9l6KazOzQaUO
 pwUipJFv2dFQ8FwPeeea4kp5t/QtVOH+f4YWorhh34EQcfd/lGFbREnSNDAN3s2IE1LR
 AZDW9+XJd9u5kbgS1ZghX1plTa1+sxACGcADHcN1W6ybiduo10gWI6smVYvopb4K1EZg
 HTbweoDPDUsvpt/6eTJ2+LVkgJmFjd5fRrtyOUs+0fXce3HbP8oyLj5LD9qByr0S+zWX
 HjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351532; x=1790956332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pf2ATrAliPD5ewLoMgWuEE/Tzn/xf6Ocf52nYwtMr4A=;
 b=FlAg2jAARtF52goepppcsQtMaJnWgWghypP6T0B2NTFf2Z1aRQKmIXkfQA1GtzHXcm
 vK039TDDyaw0knt9q8+oj7ecIyZXHvV908BJphGwVde9Qpiw4VKsiLVVLZ8vpWgDtorB
 ashNnKnOAHcJHUz1MuPYQIuEnnrjmJT5MZh22zSy9BpJt/3exSs7H7WMLX9+GyMCmwYo
 DXztrY1m9i31ae2P0co6/sqbPyeEzPGBwknK1NrKeJMWRQLbGjgpv4wVz6gEDZ0YmMKv
 aoXdKAUAexmBpQCh7+T5Dsu21lULDyxR4Mr93F3xBzIE+rjKs0sUS3P+N1k9vOC4xbQc
 RQCw==
X-Gm-Message-State: AFuF++m2RV5+Oos7Scy0awgMb5KeYxc54iMdKhHnLTqZazyMt4oh+5OU
 O+8WR2MIOxP0W3JGuqDDG5yq4bPtAkoKuBrRcYPoH/hcWDyP9dZwWDQkCAt4TzJNoTXzr5IsT9U
 8QrY5m48Jbg==
X-Gm-Gg: AYBFou1XBe0uLN3xbUJVpyxDkv9UINVuOJDayI2FSjvQ33xUdvfaz1aNe9cms7wA1lG
 ldqnWQhakUYmSDZ+Y1qkqB7M6cx2SANhBKGX5gioQmdYtVvWfihDRt2T5DJUoMjPiNOklbYpEB8
 ivrJVIed1z7/ehof8nbsl9BM7WltTShuEdgFkQoAwTcpcK5sYrsKn0Q2sw9hQeDRLT/5WZ+zADZ
 YriI1G91tzr/j1y6y77XYSdPhZUhreQ+wQSozq2BjPN/qUCamUu2immhOl8uumS+lBtNgomv41F
 e8VxIQC7pniawaze1G4vzR4g9AGFnL8W/ZmV6JIhcNFqNiS5OjQo4YtRj4v6G4ZiT6z40kNcu8h
 /w04g9PSh/KH0663WsddOaIY3RGrfwmYNolsMcxBaPF5UyUAWm9VZDVaVa576coXAmr9w6X4OZn
 VDo7FBaMAoEkHJM2rTQLXIg5x7UcNycHXit6LTbIwKG/BseS20p2suq+rMkmdRKNsH25/xQUcYS
 R3q3hotaiP/4kNyMB/p47T4AfZ30LUKzmlnII0hbQ==
X-Received: by 2002:a05:600c:4eca:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49fe66caac9mr111280715e9.5.1790351531803; 
 Fri, 25 Sep 2026 08:52:11 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:11 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 07/13] migration/rdma: Switch the producer onto the send
 ring
Date: Fri, 25 Sep 2026 17:51:42 +0200
Message-ID: <20260925155149.843870-8-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::11;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:01 -0400
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

Move the migration thread off the QP: qemu_rdma_save_page enqueues chunk
writes (ring_push_write), qio_channel_rdma_writev and the round/finish
notifiers post FILE/FLUSH/REG_STOP barriers, and the consumer reaps
completions.  Drop the per-page merge machinery (qemu_rdma_write /
buffer_mergeable / write_flush / current_*) now that the consumer owns
the transfer, and make errors set the sticky ring abort so both sides
unwind.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 417 +++++++++++++++++++++--------------------------
 1 file changed, 189 insertions(+), 228 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 5ec6a87819..a0ff73e313 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -327,7 +327,7 @@ typedef struct RDMAContext {
      */
     int control_ready_expected;
 
-    /* number of outstanding writes */
+    /* number of outstanding writes (consumer thread only) */
     int nb_sent;
 
     /* nb_sent statistics */
@@ -336,15 +336,6 @@ typedef struct RDMAContext {
     uint64_t nbsent_full_hits;      /* posts that hit a full SQ */
     uint64_t nbsent_zero_hits;      /* drains to zero */
 
-    /* store info about current buffer so that we can
-       merge it with future sends */
-    uint64_t current_addr;
-    uint64_t current_length;
-    /* index of ram block the current buffer belongs to */
-    int current_index;
-    /* index of the chunk in the current ram block */
-    int current_chunk;
-
     /* producer/consumer split (source side) */
     RDMASendRing *send_ring;      /* SPSC ring; allocated at consumer start */
     QemuThread consumer_thread;
@@ -1216,6 +1207,12 @@ static void rdma_nbsent_zero(RDMAContext *rdma);
 
 static void rdma_consumer_start(RDMAContext *rdma);
 static void rdma_consumer_stop(RDMAContext *rdma);
+static int ring_push_write(RDMAContext *rdma, uint32_t bidx, uint32_t cidx,
+                           uint64_t offset, uint64_t length);
+static int producer_flush_pending(RDMAContext *rdma);
+static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
+                        const struct iovec *iov, size_t niov);
+static void ring_set_abort(RDMAContext *rdma);
 static void rdma_nbsent_stats_dump(RDMAContext *rdma);
 
 /*
@@ -1987,151 +1984,24 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     return 0;
 }
 
-/* Consumer: write one whole chunk */
+/* Consumer: write one dirty span (offset/length are block-relative bytes) */
 static int qemu_rdma_write_chunk(RDMAContext *rdma, uint32_t block_index,
-                                 uint32_t chunk_index, Error **errp)
+                                 uint64_t offset, uint64_t length, Error **errp)
 {
     RDMALocalBlock *block = &rdma->local_ram_blocks.block[block_index];
-    uint64_t chunk_off = (uint64_t)chunk_index * migrate_rdma_chunk_size();
-    uint64_t len = block->length - chunk_off;
     int ret;
 
-    if (len > migrate_rdma_chunk_size()) {
-        len = migrate_rdma_chunk_size();
-    }
-
     /* write_one wants current_addr in ram_addr_t space (block->offset based) */
-    ret = qemu_rdma_write_one(rdma, block_index, block->offset + chunk_off,
-                              len, errp);
-    if (ret < 0) {
-        return -1;
-    }
-    if (ret == 0) {
-        rdma->nb_sent++;
-        trace_rdma_write_flush(rdma->nb_sent);
-        rdma_nbsent_inc(rdma, rdma->nb_sent);
-    }
-    return 0;
-}
-
-/*
- * Push out any unwritten RDMA operations.
- *
- * We support sending out multiple chunks at the same time.
- * Not all of them need to get signaled in the completion queue.
- */
-static int qemu_rdma_write_flush(RDMAContext *rdma, Error **errp)
-{
-    int ret;
-
-    if (!rdma->current_length) {
-        return 0;
-    }
-
-    ret = qemu_rdma_write_one(rdma, rdma->current_index, rdma->current_addr,
-                              rdma->current_length, errp);
-
+    ret = qemu_rdma_write_one(rdma, block_index, block->offset + offset,
+                              length, errp);
     if (ret < 0) {
         return -1;
     }
-
     if (ret == 0) {
         rdma->nb_sent++;
         trace_rdma_write_flush(rdma->nb_sent);
         rdma_nbsent_inc(rdma, rdma->nb_sent);
     }
-
-    rdma->current_length = 0;
-    rdma->current_addr = 0;
-
-    return 0;
-}
-
-static inline bool qemu_rdma_buffer_mergeable(RDMAContext *rdma,
-                    uint64_t offset, uint64_t len)
-{
-    RDMALocalBlock *block;
-    uint8_t *host_addr;
-    uint8_t *chunk_end;
-
-    if (rdma->current_index < 0) {
-        return false;
-    }
-
-    if (rdma->current_chunk < 0) {
-        return false;
-    }
-
-    block = &(rdma->local_ram_blocks.block[rdma->current_index]);
-    host_addr = block->local_host_addr + (offset - block->offset);
-    chunk_end = ram_chunk_end(block, rdma->current_chunk);
-
-    if (rdma->current_length == 0) {
-        return false;
-    }
-
-    /*
-     * Only merge into chunk sequentially.
-     */
-    if (offset != (rdma->current_addr + rdma->current_length)) {
-        return false;
-    }
-
-    if (offset < block->offset) {
-        return false;
-    }
-
-    if ((offset + len) > (block->offset + block->length)) {
-        return false;
-    }
-
-    if ((host_addr + len) > chunk_end) {
-        return false;
-    }
-
-    return true;
-}
-
-/*
- * We're not actually writing here, but doing three things:
- *
- * 1. Identify the chunk the buffer belongs to.
- * 2. If the chunk is full or the buffer doesn't belong to the current
- *    chunk, then start a new chunk and flush() the old chunk.
- * 3. To keep the hardware busy, we also group chunks into batches
- *    and only require that a batch gets acknowledged in the completion
- *    queue instead of each individual chunk.
- */
-static int qemu_rdma_write(RDMAContext *rdma,
-                           uint64_t block_offset, uint64_t offset,
-                           uint64_t len, Error **errp)
-{
-    uint64_t current_addr = block_offset + offset;
-    uint64_t index = rdma->current_index;
-    uint64_t chunk = rdma->current_chunk;
-
-    /* If we cannot merge it, we flush the current buffer first. */
-    if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
-        if (qemu_rdma_write_flush(rdma, errp) < 0) {
-            return -1;
-        }
-        rdma->current_length = 0;
-        rdma->current_addr = current_addr;
-
-        qemu_rdma_search_ram_block(rdma, block_offset,
-                                   offset, len, &index, &chunk);
-        rdma->current_index = index;
-        rdma->current_chunk = chunk;
-    }
-
-    /* merge it */
-    rdma->current_length += len;
-
-    /* flush it if buffer is too large */
-    if (rdma->current_length >= rdma_merge_max()) {
-        return qemu_rdma_write_flush(rdma, errp);
-    }
-
     return 0;
 }
 
@@ -2510,8 +2380,7 @@ static RDMAContext *qemu_rdma_data_init(InetSocketAddress *saddr, Error **errp)
     RDMAContext *rdma = NULL;
 
     rdma = g_new0(RDMAContext, 1);
-    rdma->current_index = -1;
-    rdma->current_chunk = -1;
+    rdma->pend_block = -1;        /* no pending WRITE span yet */
 
     rdma->host = g_strdup(saddr->host);
     rdma->port = atoi(saddr->port);
@@ -2561,7 +2430,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
     RDMAContext *rdma;
-    int ret;
     ssize_t done = 0;
 
     RCU_READ_LOCK_GUARD();
@@ -2578,22 +2446,28 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
+    if (!rdma->consumer_started) {
+        /* Setup phase: no consumer yet, no queued RAM writes -> send inline. */
+        done = qemu_rdma_write_file(rdma, iov, niov, errp);
+        if (done < 0) {
+            rdma->errored = true;
+            return -1;
+        }
+        return done;
+    }
+
     /*
-     * Push out any writes that
-     * we're queued up for VM's ram.
+     * Consumer owns the QP.  Route through the ring so this control message
+     * is ordered after all chunk writes queued so far; block until it has
+     * been sent (iov stays valid for the duration).
      */
-    ret = qemu_rdma_write_flush(rdma, errp);
-    if (ret < 0) {
-        rdma->errored = true;
+    if (ring_barrier(rdma, RDMA_CMD_FILE, 0, iov, niov) < 0) {
+        error_setg(errp, "RDMA consumer aborted during control write");
         return -1;
     }
-
-    done = qemu_rdma_write_file(rdma, iov, niov, errp);
-    if (done < 0) {
-        rdma->errored = true;
-        return -1;
+    for (size_t i = 0; i < niov; i++) {
+        done += iov[i].iov_len;
     }
-
     return done;
 }
 
@@ -2705,10 +2579,6 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
 /* Block until all outstanding writes have been delivered by the hardware. */
 static int qemu_rdma_drain_cq(RDMAContext *rdma, Error **errp)
 {
-    if (qemu_rdma_write_flush(rdma, errp) < 0) {
-        return -1;
-    }
-
     while (rdma->nb_sent) {
         if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL) < 0) {
             error_setg(errp, "rdma migration: completion polling error");
@@ -2745,7 +2615,16 @@ static int rdma_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
         return -1;
     }
 
-    return qemu_rdma_drain_cq(rdma, errp);
+    /* Complete all chunks in the ring before the next round. */
+    if (ring_barrier(rdma, RDMA_CMD_FLUSH, 0, NULL, 0) < 0) {
+        error_setg(errp, "RDMA consumer aborted during round drain");
+        return -1;
+    }
+    /*
+     * The FLUSH barrier already flushed any pending span; start the next
+     * round with a clean accumulator (no cross-round merging).
+     */
+    return 0;
 }
 
 static NotifierWithReturn rdma_ram_round_notifier = {
@@ -2846,6 +2725,7 @@ static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
 {
     RDMASendRing *r = rdma->send_ring;
 
+    /* SETUP starts the consumer before any WRITE/FLUSH/REG_STOP/FILE. */
     assert(r);
 
     if (ring_full(r)) {
@@ -2867,6 +2747,87 @@ static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
     return 0;
 }
 
+static int ring_push_write(RDMAContext *rdma, uint32_t bidx, uint32_t cidx,
+                           uint64_t offset, uint64_t length)
+{
+    RDMACmd cmd = {
+        .type = RDMA_CMD_WRITE,
+        .block_index = bidx,
+        .chunk_index = cidx,
+        .offset = offset,
+        .length = length,
+    };
+    return ring_push(rdma, &cmd);
+}
+
+/* Producer: enqueue the accumulated contiguous span (if any) as one WRITE. */
+static int producer_flush_pending(RDMAContext *rdma)
+{
+    int ret;
+
+    if (rdma->pend_block < 0) {
+        return 0;
+    }
+    ret = ring_push_write(rdma, rdma->pend_block, rdma->pend_chunk,
+                          rdma->pend_offset, rdma->pend_length);
+    rdma->pend_block = -1;
+    return ret;
+}
+
+/* Producer: block until the consumer has completed barrier seq (or abort). */
+static int ring_wait_barrier(RDMASendRing *r, unsigned seq)
+{
+    if ((int)(qatomic_load_acquire(&r->barrier_done_seq) - seq) < 0) {
+        qemu_mutex_lock(&r->wait_lock);
+        r->producer_waiting = true;
+        smp_mb();                       /* pair with ring_wake_producer() */
+        while ((int)(qatomic_load_acquire(&r->barrier_done_seq) - seq) < 0 &&
+               !r->abort) {
+            qemu_cond_wait(&r->barrier_cv, &r->wait_lock);
+        }
+        r->producer_waiting = false;
+        qemu_mutex_unlock(&r->wait_lock);
+    }
+    /* A completed barrier is success even after a late abort. */
+    return (int)(qatomic_load_acquire(&r->barrier_done_seq) - seq) >= 0 ?
+           0 : -1;
+}
+
+/* Producer: enqueue a barrier command and wait for its completion. */
+static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
+                        const struct iovec *iov, size_t niov)
+{
+    RDMASendRing *r = rdma->send_ring;
+    unsigned seq;
+    RDMACmd cmd;
+
+    assert(r);          /* consumer started at SETUP; see ring_push() */
+
+    /* Order any accumulated writes ahead of this barrier. */
+    if (producer_flush_pending(rdma) < 0) {
+        return -1;
+    }
+
+    seq = ++r->barrier_next_seq;
+
+    if (seq == 0) {                 /* seq 0 is the "no barrier" sentinel */
+        seq = ++r->barrier_next_seq;
+    }
+    cmd = (RDMACmd){
+        .type = type,
+        .flags = flags,
+        .iov = iov,
+        .niov = niov,
+        .seq = seq,
+    };
+
+    if (ring_push(rdma, &cmd) < 0) {
+        return -1;
+    }
+
+    return ring_wait_barrier(r, seq);
+}
+
 static bool ring_pop(RDMASendRing *r, RDMACmd *cmd)
 {
     if (ring_empty(r)) {
@@ -2928,7 +2889,7 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
     switch (cmd->type) {
     case RDMA_CMD_WRITE:
         ret = qemu_rdma_write_chunk(rdma, cmd->block_index,
-                                    cmd->chunk_index, &err);
+                                    cmd->offset, cmd->length, &err);
         break;
     case RDMA_CMD_FLUSH:
         ret = qemu_rdma_drain_cq(rdma, &err);
@@ -2973,6 +2934,15 @@ static void *rdma_consumer_thread(void *opaque)
             ring_advance_tail(r);
             continue;
         }
+        if (rdma->nb_sent > 0) {
+            /* Ring empty but writes in flight: reap (bounded, error-aware). */
+            if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE,
+                                         NULL) < 0) {
+                ring_set_abort(rdma);
+                break;
+            }
+            continue;
+        }
         ring_idle_wait(r);
     }
 
@@ -3014,6 +2984,7 @@ static void rdma_consumer_stop(RDMAContext *rdma)
     }
     /* Ask the consumer to drain and exit; if it already aborted, just join. */
     if (!qatomic_read(&r->abort)) {
+        producer_flush_pending(rdma);   /* order the last span before FINISH */
         ring_push(rdma, &cmd);
     }
     qemu_thread_join(&rdma->consumer_thread);
@@ -3298,7 +3269,8 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     Error *err = NULL;
     RDMAContext *rdma;
-    int ret;
+    RDMALocalBlock *block;
+    uint64_t bidx, first_chunk, chunk_size, pos, end;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
@@ -3313,60 +3285,46 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
 
     qemu_fflush(f);
 
-    /*
-     * Add this page to the current 'chunk'. If the chunk
-     * is full, or the page doesn't belong to the current chunk,
-     * an actual RDMA write will occur and a new chunk will be formed.
-     */
-    ret = qemu_rdma_write(rdma, block_offset, offset, size, &err);
-    if (ret < 0) {
-        error_report_err(err);
-        goto err;
-    }
+    qemu_rdma_search_ram_block(rdma, block_offset, offset, size,
+                               &bidx, &first_chunk);
+    block = &rdma->local_ram_blocks.block[bidx];
+    chunk_size = migrate_rdma_chunk_size();
 
     /*
-     * Drain the Completion Queue if possible, but do not block,
-     * just poll.
-     *
-     * If nothing to poll, the end of the iteration will do this
-     * again to make sure we don't overflow the request queue.
+     * Split the dirty range into per-chunk segments (a WRITE never crosses a
+     * chunk boundary) and coalesce with the pending span: pages are scanned
+     * in increasing order, so contiguous dirty pages extend one span, and we
+     * enqueue only the actually-dirty bytes instead of whole chunks.
      */
-    while (1) {
-        uint64_t wr_id, wr_id_in;
-        ret = qemu_rdma_poll(rdma, rdma->recv_cq, &wr_id_in, NULL);
-
-        if (ret < 0) {
-            error_report("rdma migration: polling error");
-            goto err;
-        }
-
-        wr_id = wr_id_in & RDMA_WRID_TYPE_MASK;
-
-        if (wr_id == RDMA_WRID_NONE) {
-            break;
-        }
-    }
-
-    while (1) {
-        uint64_t wr_id, wr_id_in;
-        ret = qemu_rdma_poll(rdma, rdma->send_cq, &wr_id_in, NULL);
-
-        if (ret < 0) {
-            error_report("rdma migration: polling error");
-            goto err;
-        }
-
-        wr_id = wr_id_in & RDMA_WRID_TYPE_MASK;
-
-        if (wr_id == RDMA_WRID_NONE) {
-            break;
+    pos = (block_offset + offset) - block->offset;
+    end = pos + size;
+    while (pos < end) {
+        uint64_t c = pos / chunk_size;
+        uint64_t seg_end = MIN(end, (c + 1) * chunk_size);
+        uint64_t seg_len = seg_end - pos;
+
+        if (rdma->pend_block == (int)bidx && rdma->pend_chunk == (uint32_t)c &&
+            rdma->pend_offset + rdma->pend_length == pos) {
+            rdma->pend_length += seg_len;       /* extend the current span */
+        } else {
+            if (producer_flush_pending(rdma) < 0) {
+                error_setg(&err, "rdma migration: consumer aborted");
+                goto err;
+            }
+            rdma->pend_block = bidx;
+            rdma->pend_chunk = c;
+            rdma->pend_offset = pos;
+            rdma->pend_length = seg_len;
         }
+        pos = seg_end;
     }
 
     return RAM_SAVE_CONTROL_DELAYED;
 
 err:
+    error_report_err(err);
     rdma->errored = true;
+    ring_set_abort(rdma);
     return -1;
 }
 
@@ -3991,20 +3949,25 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
         return -1;
     }
 
-    qemu_fflush(f);
-
-    if (flags == RAM_CONTROL_FINISH) {
-        rdma_nbsent_stats_dump(rdma);
-    }
+    trace_rdma_registration_stop(flags);
 
-    ret = qemu_rdma_write_flush(rdma, &err);
+    qemu_fflush(f);
 
-    if (ret < 0) {
-        error_report_err(err);
-        goto err;
-    }
+    if (flags != RAM_CONTROL_SETUP) {
+        /*
+         * ROUND / FINISH: the consumer sends REGISTER_FINISHED, ordered
+         * after all chunk writes queued so far.  For FINISH it also drains
+         * outstanding writes and dumps the stats first.
+         */
+        if (ring_barrier(rdma, RDMA_CMD_REG_STOP, flags, NULL, 0) < 0) {
+            error_report("rdma migration: consumer aborted at registration"
+                         " stop");
+            goto err;
+        }
+        return 0;
 
-    if (flags == RAM_CONTROL_SETUP) {
+    } else {
+        /* SETUP runs on the producer, before the consumer exists. */
         RDMAControlHeader resp = {.type = RDMA_CONTROL_RAM_BLOCKS_RESULT };
         RDMALocalBlocks *local = &rdma->local_ram_blocks;
         int reg_result_idx, nb_dest_blocks;
@@ -4072,26 +4035,24 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
                     rdma->dest_blocks[i].remote_host_addr;
             local->block[i].remote_rkey = rdma->dest_blocks[i].remote_rkey;
         }
-    }
-
-    trace_rdma_registration_stop(flags);
 
-    head.type = RDMA_CONTROL_REGISTER_FINISHED;
-    ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, &err);
+        head.type = RDMA_CONTROL_REGISTER_FINISHED;
+        ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL,
+                                      NULL, &err);
 
-    if (ret < 0) {
-        error_report_err(err);
-        goto err;
-    }
+        if (ret < 0) {
+            error_report_err(err);
+            goto err;
+        }
 
-    if (flags == RAM_CONTROL_SETUP) {
-        /* Setup complete: allocate the send ring (consumer added later). */
+        /* Setup complete: start the consumer; it now owns all QP work. */
         rdma_consumer_start(rdma);
     }
 
     return 0;
 err:
     rdma->errored = true;
+    ring_set_abort(rdma);
     return -1;
 }
 
-- 
2.39.5


