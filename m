Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A76C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8TA-0000Zn-Lq; Fri, 25 Sep 2026 12:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Do-0007xH-19
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:24 -0400
Received: from mail-wm2-x08.google.com ([2a00:1450:4864:31::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dl-000612-65
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:23 -0400
Received: by mail-wm2-x08.google.com with SMTP id
 5b1f17b1804b1-49e8361492fso4359585e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351540; x=1790956340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDHXhYLoaGfkzyQh3NRvDgSSgSWl+Zi7fDwtmLD0Jl0=;
 b=UCkjeX9ATb4YJp3NqITu9ie4+KdOPhVvCV0gQr6pxehTy7ug+9rCSSbs6TfN80gRjE
 5RQspJiulXBLQSkfEwkuFKRWAw2ySGngxQl8HdV9nVStoxzR7q/Z8RFMIQKuATgi+O4w
 kxi4m8uMnk33rO9/UxwpWXsdAp9l/5usZ1H2RDXRFSmw4iL5yov+8vaTzzErYox5qvU/
 kzaJwsILRuoGliG8Hqh7UTeW3OXm4g4iZNUNj6X0rMk1lF8cBXMs1NRtHQZsyEu3iYyi
 CXNqODXf9kwhni38qpwZWwP5BWRq81xQzFEQp99UYCOS2KW+4uBee2op92Iv2be5QMtN
 VDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351540; x=1790956340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDHXhYLoaGfkzyQh3NRvDgSSgSWl+Zi7fDwtmLD0Jl0=;
 b=14j+J/v79KbaJV+7wQf/do2yK6Ymjkew2+rsNO9rwglX/UYFIKMLE6A3YU2Txb1pL9
 OxkfmmsDDUPMwokNoth88lIMrDuvs5ujWmwTmtrBLcloN7R25wW85FMA9JKrHPw29bhN
 WJLlERAXK2jldaRu/kEz3Wa/briwqIM7nqMxnwKmc5/Qmqm3wI/zIPFozQNJQc76YTwL
 nZiSrwQPul5Q8rq8aSPY7PwDUe8xopXZSDLlLt6VpHnWePdAPvJieFGQWK3ZdBJ8Aj+4
 Q2IHnHs8XnONeWHu8cJf1pKYwGJs7NMPeXk1pJQK4s/95ojnbD8vbY14Db/r1PQ1Yi25
 HlRw==
X-Gm-Message-State: AFuF++nKPUM4lbwDgV0sXlMb51A1SkDfjluiVq3vluXET4JvsBE2OQ+r
 0fDH5XaN/eoXncFMKgfb0Axou3sia6PYwmjOTCqeqMQED39f6rDLWVZm0TukGLiO2JbYDoK/sJM
 fqK09RKoRXlzJ
X-Gm-Gg: AYBFou06+b+IL1eKACn+mHkfNyjW+IVuWkbdwubvPo7I4eQLqrTdOG+Vz6RnXK9CYQQ
 67O4GFpMNPfNJnp8/5xpJYZPfm4zwTIkNsToiVTzm9p44Dfzbgsd8Es+qWnpcFBilnOSiFz0KhM
 lHxSt65tmre1RBQAZL95paPyXKZ5yPlqTxd8aVo3ND8oYBDpDjC3q55ddURLccpZ2kcwTB9cAdu
 zzM3S8LeVIS6fb9P6Hv3HvK003lmjkXJ5uAP00cjtOj/L0gvYc/pcOAeg0kvbe/aZ5RfUE8/KBw
 y6GMzVaevSS0MOh8kWmkZesyGwLEFmTGdMrZASx7vCpEQJNYQt6KKVMkredhFcc7ZtFaZdw4X/b
 j+BZKXBOX9FVeBKCGAlQGLJplDwBe60uwiWcuQFzKG+bYXBmiXagqj4HhRY5HRcqPqgD9grbu+J
 E2+hFMbkfglmR9B0E9aR+pO98bfTml5bOdYtpftImbv7mxJs+IRWO581y8103x2ppJAhpFne+P9
 2g+DrruRUp+WmmoHVfOAjQAgDX2fHopEr1pRIvUWg==
X-Received: by 2002:a05:600c:3e06:b0:49f:f099:6f9b with SMTP id
 5b1f17b1804b1-49ff0997088mr46675435e9.13.1790351539513; 
 Fri, 25 Sep 2026 08:52:19 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:18 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 11/13] migration/rdma: batch chunk registration in one
 round-trip
Date: Fri, 25 Sep 2026 17:51:46 +0200
Message-ID: <20260925155149.843870-12-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::8;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x08.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:02 -0400
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

Split qemu_rdma_write_one() into three helpers: write_one posts one
dirty span of an already-registered chunk (both pin modes),
write_compress handles an all-zero span, and write_register folds
several never-seen chunks into one REGISTER_REQUEST.  The consumer scans
a run of WRITE commands, posting ready and zero spans inline and
registering the never-seen chunks in a single round-trip before posting
them.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 372 ++++++++++++++++++++++++++++-------------------
 1 file changed, 223 insertions(+), 149 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index bffc7d33ef..aa1a81619f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1208,6 +1208,7 @@ static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
 static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent);
 static void rdma_nbsent_full(RDMAContext *rdma);
 static void rdma_nbsent_zero(RDMAContext *rdma);
+static void rdma_reg_batch_record(RDMASendRing *r, unsigned count);
 
 static void rdma_consumer_start(RDMAContext *rdma);
 static void rdma_consumer_stop(RDMAContext *rdma);
@@ -1806,149 +1807,41 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     return 0;
 }
 
-/*
- * Write an actual chunk of memory using RDMA.
- *
- * If we're using dynamic registration on the dest-side, we have to
- * send a registration command first.
- */
-static int qemu_rdma_write_one(RDMAContext *rdma,
-                               int current_index, uint64_t current_addr,
-                               uint64_t length, Error **errp)
+/* Post one dirty span of an already-registered chunk (both pin modes). */
+static int qemu_rdma_write_one(RDMAContext *rdma, int current_index,
+                               uint64_t current_addr, uint64_t length,
+                               Error **errp)
 {
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
-    int reg_result_idx, ret;
-    uint64_t chunk, chunks;
-    uint64_t chunk_size = migrate_rdma_chunk_size();
+    RDMALocalBlock *block = &rdma->local_ram_blocks.block[current_index];
+    uint64_t chunk;
     uint8_t *chunk_start, *chunk_end;
-    RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
-    RDMARegister reg;
-    RDMARegisterResult *reg_result;
-    RDMAControlHeader resp = { .type = RDMA_CONTROL_REGISTER_RESULT };
-    RDMAControlHeader head = { .len = sizeof(RDMARegister),
-                               .type = RDMA_CONTROL_REGISTER_REQUEST,
-                               .repeat = 1,
-                             };
 
     sge.addr = (uintptr_t)(block->local_host_addr +
-                            (current_addr - block->offset));
+                           (current_addr - block->offset));
     sge.length = length;
 
-    chunk = ram_chunk_index(block->local_host_addr,
-                            (uint8_t *)(uintptr_t)sge.addr);
+    chunk = ram_chunk_index(block->local_host_addr, (uint8_t *)sge.addr);
     chunk_start = ram_chunk_start(block, chunk);
-    chunks = length / chunk_size;
-
-    if (chunks && ((length % chunk_size) == 0)) {
-        chunks--;
-    }
-
-    trace_rdma_write_one_top(chunks + 1,
-                                  (chunks + 1) * chunk_size / 1024 / 1024);
+    chunk_end = ram_chunk_end(block, chunk);
 
-    chunk_end = ram_chunk_end(block, chunk + chunks);
-
-    if (!rdma->pin_all) {
+    if (rdma->pin_all) {
+        send_wr.wr.rdma.rkey = block->remote_rkey;
+    } else {
         if (!block->remote_keys[chunk]) {
-            /*
-             * This chunk has not yet been registered, so first check to see
-             * if the entire chunk is zero. If so, tell the other size to
-             * memset() + madvise() the entire chunk without RDMA.
-             */
-
-            if (buffer_is_zero((void *)(uintptr_t)sge.addr, length)) {
-                RDMACompress comp = {
-                                        .offset = current_addr,
-                                        .value = 0,
-                                        .block_idx = current_index,
-                                        .length = length,
-                                    };
-
-                head.len = sizeof(comp);
-                head.type = RDMA_CONTROL_COMPRESS;
-
-                trace_rdma_write_one_zero(chunk, sge.length,
-                                               current_index, current_addr);
-
-                compress_to_network(rdma, &comp);
-                ret = qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL, errp);
-
-                if (ret < 0) {
-                    return -1;
-                }
-
-                /*
-                 * TODO: Here we are sending something, but we are not
-                 * accounting for anything transferred.  The following is wrong:
-                 *
-                 * stat64_add(&mig_stats.rdma_bytes, sge.length);
-                 *
-                 * because we are using some kind of compression.  I
-                 * would think that head.len would be the more similar
-                 * thing to a correct value.
-                 */
-                qatomic_add(&mig_stats.zero_pages,
-                            sge.length / qemu_target_page_size());
-                return 1;
-            }
-
-            /*
-             * Otherwise, tell other side to register.
-             */
-            reg.current_index = current_index;
-            reg.current_addr = current_addr;
-            reg.chunks = chunks;
-
-            trace_rdma_write_one_sendreg(chunk, sge.length, current_index,
-                                              current_addr);
-
-            register_to_network(rdma, &reg);
-            ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                    &resp, &reg_result_idx, NULL, errp);
-            if (ret < 0) {
-                return -1;
-            }
-
-            /* try to overlap this single registration with the one we sent. */
-            if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
-                                                &sge.lkey, NULL, chunk,
-                                                chunk_start, chunk_end)) {
-                error_setg(errp, "cannot get lkey");
-                return -1;
-            }
-
-            reg_result = (RDMARegisterResult *)
-                    rdma->wr_data[reg_result_idx].control_curr;
-
-            network_to_result(reg_result);
-
-            trace_rdma_write_one_recvregres(block->remote_keys[chunk],
-                                                 reg_result->rkey, chunk);
-
-            block->remote_keys[chunk] = reg_result->rkey;
-            block->remote_host_addr = reg_result->host_addr;
-        } else {
-            /* already registered before */
-            if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
-                                                &sge.lkey, NULL, chunk,
-                                                chunk_start, chunk_end)) {
-                error_setg(errp, "cannot get lkey!");
-                return -1;
-            }
+            error_setg(errp, "rdma: write_one on unregistered chunk %" PRIu64,
+                       chunk);
+            return -1;
         }
-
         send_wr.wr.rdma.rkey = block->remote_keys[chunk];
-    } else {
-        send_wr.wr.rdma.rkey = block->remote_rkey;
+    }
 
-        if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
-                                                     &sge.lkey, NULL, chunk,
-                                                     chunk_start, chunk_end)) {
-            error_setg(errp, "cannot get lkey!");
-            return -1;
-        }
+    /* Local MR (idempotent): pins our own memory so the NIC can read it. */
+    if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr, &sge.lkey,
+                                        NULL, chunk, chunk_start, chunk_end)) {
+        error_setg(errp, "cannot get lkey");
+        return -1;
     }
 
     /*
@@ -1956,18 +1849,17 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
      * We will use this information at the time of completion
      * to identify the completed write in trace output.
      */
-    send_wr.wr_id = qemu_rdma_make_wrid(RDMA_WRID_RDMA_WRITE,
-                                        current_index, chunk);
-
+    send_wr.wr_id = qemu_rdma_make_wrid(RDMA_WRID_RDMA_WRITE, current_index,
+                                        chunk);
     send_wr.opcode = IBV_WR_RDMA_WRITE;
     send_wr.send_flags = IBV_SEND_SIGNALED;
     send_wr.sg_list = &sge;
     send_wr.num_sge = 1;
     send_wr.wr.rdma.remote_addr = block->remote_host_addr +
-                                (current_addr - block->offset);
+                                  (current_addr - block->offset);
 
     trace_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_addr,
-                                   sge.length);
+                              sge.length);
 
     if (!qemu_rdma_post_send(rdma, &send_wr, errp)) {
         return -1;
@@ -1986,27 +1878,86 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     qatomic_add(&mig_stats.rdma_bytes, sge.length);
     ram_transferred_add(sge.length);
     rdma->total_writes++;
+    rdma->nb_sent++;
+    trace_rdma_write_flush(rdma->nb_sent);
+    rdma_nbsent_inc(rdma, rdma->nb_sent);
+    return 0;
+}
 
+/* Zero an all-zero span on the destination without RDMA (pin_all=off). */
+static int qemu_rdma_write_compress(RDMAContext *rdma, int current_index,
+                                    uint64_t current_addr, uint64_t length,
+                                    Error **errp)
+{
+    RDMALocalBlock *block = &rdma->local_ram_blocks.block[current_index];
+    uint64_t chunk = (current_addr - block->offset) / migrate_rdma_chunk_size();
+    RDMACompress comp = {
+        .offset = current_addr,
+        .value = 0,
+        .block_idx = current_index,
+        .length = length,
+    };
+    RDMAControlHeader head = { .len = sizeof(comp),
+                               .type = RDMA_CONTROL_COMPRESS,
+                               .repeat = 1 };
+
+    trace_rdma_write_one_zero(chunk, length, current_index, current_addr);
+
+    compress_to_network(rdma, &comp);
+    if (qemu_rdma_exchange_send(rdma, &head, (uint8_t *)&comp,
+                                NULL, NULL, NULL, errp) < 0) {
+        return -1;
+    }
+    qatomic_add(&mig_stats.zero_pages, length / qemu_target_page_size());
     return 0;
 }
 
-/* Consumer: write one dirty span (offset/length are block-relative bytes) */
-static int qemu_rdma_write_chunk(RDMAContext *rdma, uint32_t block_index,
-                                 uint64_t offset, uint64_t length, Error **errp)
+/*
+ * Register a batch of never-seen non-zero chunks in one REGISTER_REQUEST
+ * (pin_all=off); regs[] carry current_index/current_addr in host order.  One
+ * control round-trip, then cache each chunk's remote rkey/host_addr so the
+ * following write_one() calls can post.
+ */
+static int qemu_rdma_write_register(RDMAContext *rdma, RDMARegister *regs,
+                                    unsigned count, Error **errp)
 {
-    RDMALocalBlock *block = &rdma->local_ram_blocks.block[block_index];
-    int ret;
+    RDMARegister net[RDMA_CONSUMER_BATCH_MAX];
+    RDMARegisterResult *results;
+    RDMAControlHeader resp = { .type = RDMA_CONTROL_REGISTER_RESULT };
+    RDMAControlHeader head = { .type = RDMA_CONTROL_REGISTER_REQUEST };
+    int reg_result_idx;
+    unsigned i;
 
-    /* write_one wants current_addr in ram_addr_t space (block->offset based) */
-    ret = qemu_rdma_write_one(rdma, block_index, block->offset + offset,
-                              length, errp);
-    if (ret < 0) {
+    assert(count >= 1 && count <= RDMA_CONSUMER_BATCH_MAX);
+
+    /* network-order copy to send; regs[] stays host-order for caching below */
+    for (i = 0; i < count; i++) {
+        net[i] = regs[i];
+        net[i].chunks = 0;              /* exactly one chunk per entry */
+        register_to_network(rdma, &net[i]);
+    }
+    head.len = count * sizeof(RDMARegister);
+    head.repeat = count;
+
+    rdma_reg_batch_record(rdma->send_ring, count);
+
+    if (qemu_rdma_exchange_send(rdma, &head, (uint8_t *)net,
+                                &resp, &reg_result_idx, NULL, errp) < 0) {
         return -1;
     }
-    if (ret == 0) {
-        rdma->nb_sent++;
-        trace_rdma_write_flush(rdma->nb_sent);
-        rdma_nbsent_inc(rdma, rdma->nb_sent);
+
+    results = (RDMARegisterResult *)rdma->wr_data[reg_result_idx].control_curr;
+    for (i = 0; i < count; i++) {
+        RDMALocalBlock *block =
+            &rdma->local_ram_blocks.block[regs[i].current_index];
+        uint64_t chunk =
+            (regs[i].current_addr - block->offset) / migrate_rdma_chunk_size();
+
+        network_to_result(&results[i]);
+        trace_rdma_write_one_recvregres(block->remote_keys[chunk],
+                                        results[i].rkey, chunk);
+        block->remote_keys[chunk] = results[i].rkey;
+        block->remote_host_addr = results[i].host_addr;
     }
     return 0;
 }
@@ -2679,6 +2630,7 @@ struct RDMASendRing {
     uint64_t pushwait_total_ns;  /* total producer wait on a full ring */
     uint64_t occupancy_max;      /* peak queued commands */
     uint64_t idle_max_ns;        /* longest consumer wait on an empty ring */
+    uint64_t reg_batch_max;      /* largest batched REGISTER_REQUEST */
 };
 
 static bool ring_full(RDMASendRing *r)
@@ -2942,6 +2894,105 @@ static int rdma_consumer_reg_stop(RDMAContext *rdma, uint64_t flags,
     return qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, errp);
 }
 
+/*
+ * Dirty-span parameters for a ring WRITE command: block, block-relative
+ * offset, migration address and length.  The span is the actually-dirtied
+ * byte range (within one chunk), not the whole chunk.
+ */
+static void rdma_get_chunk_args(RDMAContext *rdma, const RDMACmd *cmd,
+                                RDMALocalBlock **block, uint64_t *off,
+                                uint64_t *addr, uint64_t *len)
+{
+    RDMALocalBlock *b = &rdma->local_ram_blocks.block[cmd->block_index];
+
+    *block = b;
+    *off = cmd->offset;
+    *addr = b->offset + cmd->offset;
+    *len = cmd->length;
+}
+
+/*
+ * Consumer: process the maximal run of consecutive RDMA_CMD_WRITE commands at
+ * ring position 'pos' (at most 'max'), stopping at the first barrier.  Each
+ * command carries one dirty span.  Post ready (already registered / pin_all)
+ * and zero spans as they are met; defer spans whose chunk needs registering,
+ * register those chunks in one batched REGISTER_REQUEST, then post the spans.
+ * Returns the WRITE commands consumed, or -1.
+ */
+static int qemu_rdma_write_run(RDMAContext *rdma, RDMASendRing *r,
+                               unsigned pos, unsigned max, Error **errp)
+{
+    unsigned reg_ring_idx[RDMA_CONSUMER_BATCH_MAX]; /* deferred span writes */
+    RDMARegister regs[RDMA_CONSUMER_BATCH_MAX];     /* distinct chunks to reg */
+    unsigned n = 0, regn = 0, nreg = 0, i;
+    int last_bidx = -1;             /* last chunk queued into regs[] */
+    int64_t last_cidx = -1;
+
+    /* Phase 1: scan the run; post ready/zero now, defer never-registered. */
+    while (n < max) {
+        RDMACmd *cmd = &r->ring[(pos + n) & RDMA_SEND_RING_MASK];
+        RDMALocalBlock *block;
+        uint64_t off, addr, len;
+
+        if (cmd->type != RDMA_CMD_WRITE) {
+            break;
+        }
+        rdma_get_chunk_args(rdma, cmd, &block, &off, &addr, &len);
+
+        if (rdma->pin_all || block->remote_keys[cmd->chunk_index]) {
+            if (qemu_rdma_write_one(rdma, cmd->block_index, addr, len,
+                                    errp) < 0) {
+                return -1;
+            }
+        } else if (buffer_is_zero((void *)(uintptr_t)
+                       (block->local_host_addr + off), len)) {
+            if (qemu_rdma_write_compress(rdma, cmd->block_index, addr, len,
+                                         errp) < 0) {
+                return -1;
+            }
+        } else {
+            /* Defer: record every span for a post-registration write. */
+            reg_ring_idx[regn++] = pos + n;
+            /*
+             * Registration is per whole chunk.  Chunk indices arrive
+             * non-decreasing within a run, so a repeat chunk is the last one
+             * queued; add each chunk to the REGISTER batch only once.
+             */
+            if ((int)cmd->block_index != last_bidx ||
+                (int64_t)cmd->chunk_index != last_cidx) {
+                regs[nreg].current_index = cmd->block_index;
+                regs[nreg].current_addr = addr;
+                nreg++;
+                last_bidx = cmd->block_index;
+                last_cidx = cmd->chunk_index;
+            }
+        }
+        n++;
+    }
+
+    if (regn == 0) {
+        return (int)n;
+    }
+
+    /* Phase 2: one REGISTER_REQUEST for the deduped deferred chunks. */
+    if (qemu_rdma_write_register(rdma, regs, nreg, errp) < 0) {
+        return -1;
+    }
+
+    /* Phase 3: post every deferred span (chunks are now registered). */
+    for (i = 0; i < regn; i++) {
+        RDMACmd *cmd = &r->ring[reg_ring_idx[i] & RDMA_SEND_RING_MASK];
+        RDMALocalBlock *block;
+        uint64_t off, addr, len;
+
+        rdma_get_chunk_args(rdma, cmd, &block, &off, &addr, &len);
+        if (qemu_rdma_write_one(rdma, cmd->block_index, addr, len, errp) < 0) {
+            return -1;
+        }
+    }
+    return (int)n;
+}
+
 static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
                                   bool *stop)
 {
@@ -2953,8 +3004,8 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
 
     switch (cmd->type) {
     case RDMA_CMD_WRITE:
-        ret = qemu_rdma_write_chunk(rdma, cmd->block_index,
-                                    cmd->offset, cmd->length, &err);
+        /* WRITE runs are handled in bulk by qemu_rdma_write_run(). */
+        g_assert_not_reached();
         break;
     case RDMA_CMD_FLUSH:
         ret = qemu_rdma_drain_cq(rdma, &err);
@@ -2981,6 +3032,7 @@ static void *rdma_consumer_thread(void *opaque)
 {
     RDMAContext *rdma = opaque;
     RDMASendRing *r = rdma->send_ring;
+    Error *err = NULL;
     bool stop = false;
 
     rcu_register_thread();
@@ -3025,6 +3077,21 @@ static void *rdma_consumer_thread(void *opaque)
             unsigned idx = r->tail + processed;
             RDMACmd cmd = r->ring[idx & RDMA_SEND_RING_MASK];
 
+            /* WRITE runs are drained in bulk with batched registration. */
+            if (cmd.type == RDMA_CMD_WRITE) {
+                int n = qemu_rdma_write_run(rdma, r, idx,
+                                            batch - processed, &err);
+                if (n < 0) {
+                    if (err) {
+                        error_report_err(err);
+                    }
+                    ring_set_abort(rdma);
+                    break;
+                }
+                processed += (unsigned)n;
+                continue;
+            }
+
             if (rdma_consumer_dispatch(rdma, &cmd, &stop) < 0) {
                 ring_set_abort(rdma);
                 break;
@@ -3447,6 +3514,13 @@ static void rdma_nbsent_zero(RDMAContext *rdma)
     rdma->nbsent_zero_hits++;
 }
 
+static void rdma_reg_batch_record(RDMASendRing *r, unsigned count)
+{
+    if (count > r->reg_batch_max) {
+        r->reg_batch_max = count;
+    }
+}
+
 static void rdma_stats_reset(RDMAContext *rdma)
 {
     rdma->nbsent_max = 0;
-- 
2.39.5


