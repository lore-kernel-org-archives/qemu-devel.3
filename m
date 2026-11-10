Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45F606AA56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=cYz7d6Nc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOX-0003vn-9Z; Tue, 10 Nov 2026 10:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOM-0003Rx-HC
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:11 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOK-00006J-NC
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so331822f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323047; x=1794927847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ImtER38+8BXt0eYwkx/DPb2E36sZjdh5N917W2Hc1Nk=;
 b=cYz7d6NclRqMtyyvEWYz8aMhbwN+0BJoZr1zdXJ46Ls71XImA9XA5pKAhdIzAANWNC
 wDLilhJy5STdjEY9yJSDPCCjHFKaucdGKMBxQb848DLbpRduF7gqEDOaZnCxOe28RIvI
 dCs5NM4XDo6JbW/fenf7BI8KG9IcVbDpgrSXFEIM6WmeiOJKdTcjMFC1h8rSEOhiwpiz
 j9Y6jm2IA0ESM0WN5aoUZC0dmgmB5glaLyiZ/ZhMuBkRDMSQaUckOzzGT71JU11Y0Ln/
 NQ38V5heRw/rIix/W2GlVkLP//y9NR1o58XdAEOC2KwLsyobcot+Z5vZL1CBzKckGQX5
 pRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323047; x=1794927847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ImtER38+8BXt0eYwkx/DPb2E36sZjdh5N917W2Hc1Nk=;
 b=pVc+mh2MotVbPUevYIyPgTFOIwFDjVki5D7FC0WKhmg/kcu/t3mk+rE1ZHdJUkfgg5
 1jpXBZPPn0Rs5XR/TPYoEbsAvKRl4JRziIwCCvLKNMtHP2DM1maHq9VEdy5xjNAJZQvq
 10WbKkXHcOb3YSuFx4LkFSxoR/Txy7/V+Hf6GjyCVG02jrxeKsVyDdmzWCgzLldfnV/o
 hot0gWNI8PVRPdPy84ceuuahkXmHFHJ/SQY2SN0TTsjyafMzS4AHQTqe0jc5E0c1lGDs
 Fruy1X4fJOo1kfZeBkSv9WuYuMf/uPpOwCtHHv/bh9B6evMnyUtg+8yH0ZMKzKQS+99S
 IJbw==
X-Gm-Message-State: APuU4Z88dsRTNOhR4q+KDDrOsZf5ymRJAoQkFj3wO8W0uKk5i2tRhK6z
 dslhYnq60oX6ismXzVJsdVwrKWI+bjCN3sXLn4Z3GGfjaVb73q/jb25BRYR6+P60hrdnpPCAEf6
 Bh0gf7Og=
X-Gm-Gg: AYBFou2IERqW2O2cRndD2KRdufGVGUBsbXa+7OJ0EDmuiWRLYSzPSkdwH3MLWK492AX
 cqLpoQE0o4hKBKlhb1v2dGmwhG1ftrKbwlz35auzHg1JGofsnouWmeC0GrROcY6cKECRVZ8PeKx
 VRw2Wg1fJjipTh+FAQQ5HWWe2xrwRRB+ll7agwRwO86edEk4xnOjlZJ71W9MiluncWLVI4S3WsC
 ea03WZ5hCoe9a/x3Q7U6qaB5VjqCsO3nTSph4KbgIVvIUS1DX5GTCm7Gpe3rQGZNNnyxRrWVjfj
 MbpflGc8FoJo7ZrwBeTfERcucnOErgCO4c4oDOhFf5fZaZeJrRhR5L1GXS6QSLsLQPuJ+0np2pG
 98495+NEbi5A1yzFXdL+UdPfoFaU1mBALaQZV6o2mirrirR+WlXXYu5REBtQqtLMj+2E4HMBIC1
 zukD7ixQ9qBfpSGUMVlmDB1J8MNRSBOMaG94+Qk3sm+q4Ax/sqK48Ml9J8mvUxEud/69Q2bf22G
 XJ42CCl89IU1PSrDZ8vixVFyivsPZQ45isPIJAjo7BKQZJI1/G1NUcZeqqLCBd63CLT/8bt4gSC
 BLhdByDIg4NhZbBI9pTJQmhsQs4FBu7q5WtPbj23EOYYxMlAPGpfJ+ovffWBf1JkODdnGu5N
X-Received: by 2002:a05:6000:46c4:b0:492:564f:a1af with SMTP id
 ffacd0b85a97d-4982ecf67b5mr3402380f8f.26.1794323047231; 
 Tue, 10 Nov 2026 07:04:07 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:04:06 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 12/13] migration/rdma: trace batching and register
 runs
Date: Tue, 10 Nov 2026 16:02:46 +0100
Message-ID: <20261110150247.193208-13-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::436;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x436.google.com
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

Add trace points for the consumer batch drain, the WRITE run, and the
batched REGISTER_REQUEST, and log the peak register batch size at
migration end.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c       | 6 +++++-
 migration/trace-events | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index aa1a81619f..863165de26 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1940,6 +1940,7 @@ static int qemu_rdma_write_register(RDMAContext *rdma, RDMARegister *regs,
     head.repeat = count;
 
     rdma_reg_batch_record(rdma->send_ring, count);
+    trace_rdma_write_register_batch(count);
 
     if (qemu_rdma_exchange_send(rdma, &head, (uint8_t *)net,
                                 &resp, &reg_result_idx, NULL, errp) < 0) {
@@ -2970,6 +2971,7 @@ static int qemu_rdma_write_run(RDMAContext *rdma, RDMASendRing *r,
         n++;
     }
 
+    trace_rdma_write_run(n);
     if (regn == 0) {
         return (int)n;
     }
@@ -3072,6 +3074,7 @@ static void *rdma_consumer_thread(void *opaque)
          */
         batch = avail < RDMA_CONSUMER_BATCH_MAX ? avail
                                                 : RDMA_CONSUMER_BATCH_MAX;
+        trace_rdma_consumer_batch(batch, avail);
 
         while (processed < batch) {
             unsigned idx = r->tail + processed;
@@ -3542,7 +3545,8 @@ static void rdma_nbsent_stats_dump(RDMAContext *rdma)
 static void rdma_prodcons_stats_dump(RDMASendRing *r)
 {
     trace_rdma_prodcons_stats(r->idle_max_ns, r->pushwait_max_ns,
-                              r->pushwait_total_ns, r->occupancy_max);
+                              r->pushwait_total_ns, r->occupancy_max,
+                              r->reg_batch_max);
 }
 
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
diff --git a/migration/trace-events b/migration/trace-events
index e38c125426..ea4a1996d3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -247,10 +247,13 @@ rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory
 rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
 rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 rdma_write_flush(int sent) "sent total: %d"
+rdma_write_run(uint32_t n) "consumer write run: %" PRIu32 " chunks"
+rdma_write_register_batch(uint32_t count) "batch register: %" PRIu32 " chunks"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
 rdma_nbsent_stats(uint64_t max, uint64_t posts, uint64_t full_hits, uint64_t zero_hits) "nb_sent max %" PRIu64 " posts %" PRIu64 " full-queue hits %" PRIu64 " drains to zero %" PRIu64
 rdma_consumer_dispatch(int type, uint32_t bidx, uint32_t cidx, uint32_t seq) "cmd type=%d block=%" PRIu32 " chunk=%" PRIu32 " seq=%" PRIu32
+rdma_consumer_batch(uint32_t batch, uint32_t occupancy) "consumer batch: draining %" PRIu32 " of %" PRIu32 " queued"
 rdma_ring_wake_producer(void) "waking blocked producer"
 rdma_ring_wake_consumer(void) "waking idle consumer"
 rdma_ring_push_begin(const char *type, uint32_t chunk_index) "push begin type=%s chunk_index=%" PRIu32
@@ -262,7 +265,7 @@ rdma_consumer_thread_stop(bool aborted) "consumer thread stopped, aborted=%d"
 rdma_consumer_idle_begin(void) "consumer idle: waiting for commands"
 rdma_consumer_idle_end(int64_t idle_ns) "consumer idle: woke after %" PRId64 " ns"
 rdma_ram_round_notify(uint32_t occupancy) "ram round notify: ring occupancy=%" PRIu32
-rdma_prodcons_stats(uint64_t idle_max, uint64_t pushwait_max, uint64_t pushwait_total, uint64_t occupancy_max) "idle max %" PRIu64 " ns, push full-wait max %" PRIu64 " ns total %" PRIu64 " ns, ring occupancy max %" PRIu64
+rdma_prodcons_stats(uint64_t idle_max, uint64_t pushwait_max, uint64_t pushwait_total, uint64_t occupancy_max, uint64_t reg_batch_max) "idle max %" PRIu64 " ns, push full-wait max %" PRIu64 " ns total %" PRIu64 " ns, ring occupancy max %" PRIu64 ", register batch max %" PRIu64
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.39.5


