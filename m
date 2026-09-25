Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6244DC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Tx-00015r-Sm; Fri, 25 Sep 2026 12:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Do-0007xi-UH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:24 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dn-00061e-6A
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:24 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48882c1f261so204307f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351542; x=1790956342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lNWrB/oV8rNLv19MecIm7xnc9TkBjo7V49u7kMzEQRM=;
 b=CV63rIYIKR7u+zG6tpmKkUC7OTT8uSRqfR0XVitHGve6b4124H801bjkq1rtscw4pQ
 HYhikNWxW6hBSgVhlCTxMxmJxm2/unof3ZNQ8oylueb4y8oUCujxWlWJ0/1X5gpsWmFz
 IbUWJyuVHicW2m+A4guoDfBgEqX9atDEBOIMuPmSDmwaAdBMQI3VOeJjicfXfxXdg9uu
 qUhTN/AF9KX2YWvOAG6pj7CM0/Mk5eMqLvfvJSp96EZtkCK0GOwWRRxKwJr+xTFgvS8A
 h2Xe1Rn/dqGzVyPYtBOplGJBdz5BOYcEGhBbpTvXiA6CKOyE4Gw/o5v+wS8tGHjk/wiN
 wXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351542; x=1790956342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lNWrB/oV8rNLv19MecIm7xnc9TkBjo7V49u7kMzEQRM=;
 b=cv26bzMpvsLG9H/oCtv86ranfxpAgvFasPFIYwSQSpdiuEhB8c4LOo0VzZ0NQMtMWR
 69UaqTHU71I9NxHYerPp/XRJJtg3o3hGY5lRn3k9gkMNd1V9TSE8zs1Y7+38k6hDMslX
 56c9h8gxxXqOXz+1I2K1P+K5N78oNHsqiOFAWhqrqxEL9nLSdLVGsmeg76xyEOCp0XvB
 6/CY/9SjFXCUJ5CNobCxkuEA/tUCNTgcIWuOHhPpLy7vJslpTi8OwwPh2qzpkWqaaS4l
 zP1JIaOptnUkQ9PL12ri/uUPbWbPmxoNOU/j7KPp0qPoQGCaSaOHQGoX9a5+VJWI5LyH
 FOUQ==
X-Gm-Message-State: AFuF++mk8aPLnhcx4Xz35dcuSq74j3cIU9dA7c1Jo8SIaIeBkVKJE9xe
 ituLOHfb0hQ/THUvYSJs1OChhqQYHA44lMtnTckbD6oXqw/gEghciR7oD+sTFbAgxv6BlenFUVs
 SqFVe1hGMiw==
X-Gm-Gg: AYBFou3ZRyKRqUov8gIi223NmhDwQkxVuBNGtxOkdFOSpbc8Ec7IgndLLlDkW/VpNYl
 YhTcYf+HsisJsON9O3IEL1e0gKeEfaUACAtLbg7EapBHl8bF6nvABTZ/jFPe3/ev+c8W8EmZAMf
 oQrO7mTkhY15s8I9lZTTug3+X/MLwD6RaDCuAZzMQFwevzmv8wLQuXZB9yRFwkgemTzBn8YYDp9
 qP42EsgITFSPOban0b7QPGaLupp7lsSlh+F6whS1rQeP8SDqp45Qaw1HjeiZalZnjloRjyGTkdx
 9iBRKb8K8E69Es/1J4AvTXo2vUNIYKzf80XICk5x13K+cdQheJUIAgeO/YSgyXLVOAOk/OEOJ+5
 U+kxsjyVPKVl9A54u/MiHUYE0jz8maUIM6fPZVxqv0vTdspinstzcAwro4hMQdKymwICjrcGANl
 yt3dudFSIo1MPRScbTvlove79dFEnb4vGjJXVBRz1Fa/FPuD5gWfWGYGMSdzrryq9Bt5G1LgvLT
 bHgaEqdYIo6MSu/OVEmkaWhHPsa2AIp/mPcLduO4g==
X-Received: by 2002:a05:600c:8b5b:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49fe66f17damr107180165e9.10.1790351541928; 
 Fri, 25 Sep 2026 08:52:21 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:21 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 12/13] migration/rdma: trace batching and register runs
Date: Fri, 25 Sep 2026 17:51:47 +0200
Message-ID: <20260925155149.843870-13-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:30::f;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
index 833351a03f..e05ca23f32 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -243,10 +243,13 @@ rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory
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
@@ -258,7 +261,7 @@ rdma_consumer_thread_stop(bool aborted) "consumer thread stopped, aborted=%d"
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


