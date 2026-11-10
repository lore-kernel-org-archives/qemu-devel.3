Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17829606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=gRcDKxCB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOG-0003JZ-H5; Tue, 10 Nov 2026 10:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO7-0003Ar-11
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO3-0008Ua-R4
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:54 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-491971ac844so2074798f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323030; x=1794927830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RpbJfFtFXtW5DVtUKxFYbq48SJgv8dFmBAbxHxL31/s=;
 b=gRcDKxCBEsFfDCGkx86hqMu4KXcGiSOEuQz+RWbuy6mC8K7zrLmQB2+HOeCWndXbWZ
 sjurjbh1oT51lYyDO5FKgLv4V6WUppjI5Hs9Lj2Favlbb0rHNFK/0k4Catv+O+aZBHh3
 CpZ/SeFTkxKmvgEcIKDGEGFhT7J9mRwNuvWzVGcC9+iCvrTX6skgLN1jYvdW/0ageMUC
 N+S17Kf1HCUHN0CywfrOBImGqoYrizY8m2VHYqLGfWkdgnK7MNVBHNB3xj7X32XgYOOi
 FVE3KOc00/MCasQMpm4xw3fXvp4/w73xzFLLbwwsgaF4OFVeO8pU8KYFdBCVMtKFRsHA
 FteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323030; x=1794927830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RpbJfFtFXtW5DVtUKxFYbq48SJgv8dFmBAbxHxL31/s=;
 b=wVl7kXEcUGQaslWsbfsdU6/WaRBtrccQhDR2623eg2XLfJN1IsqmK2zt+XkU6zvBCB
 UlZqaedR2YUvutDRZE3W6BCqM/1bhiv/j4fqtG3ARYryKPrinRtdbwYKwHRyxfMY7GAS
 XAW0WE8foKvohsmCOwzaK4NFwGSsn5PT6fPvsY08DzFy3nWKjgORnHb5MonSGGsvBXVf
 JGdBTlD/lbXYP0jD9Lk7SE/3u+DBAyhRfePfq9Xpt5KQBd/lCpCJAD+MFL9PTf845KNM
 7agZj2O8FEFLMttgjVgmk1NrjUzI4WGvietqjPfdtZjGRt4jgY2gKEoL/SoH5Yj9ujId
 dIKQ==
X-Gm-Message-State: APuU4Z8Q1htyOsIs3RhUZWVOzS2DaKydWj6lejPkZwDi01BhRyNygdE8
 nHNNSIxBZ9GeINx99iOjLTy8LgntHvx7wgk3MjF6SflAHfhSeRHu44Wpsy+0JAsHj2llWl5iSnR
 ubV9pR0s=
X-Gm-Gg: AYBFou3ct7i+RgTnbfZb1YEoTL0CR1HcpYmvP2BDrVA+ixpXyKIFGzOo2iYn64kqvGb
 HLaIZffs5xmyAg36/HWB0M91xvhJMR68tb5gun4Mh6/r870F09KIuCM0DLPEVl4Qt4yjUOtRjyr
 Rv+sw4MUXJItJpH2LhF1enngcztde6j+reb1/GEjuyTlatB2dqLe0T5RZYJedl+lJvai17jXNej
 nN+cHHVbhgON50Ndz5oj5UcV0B8TS+Sv35OrG2KW1x5ZJwZNrhM/8nTfjq5pun4SV/2pPEsdHCc
 ldot5IA416D7iB18ybDd3kOK0jlJcqet9nACV4r/7MtijjhyNBMsVwr8XU4P2cuGFwBW8KsFnDq
 TaIW6Dcpzn01k/sfkYmlhQ5s+DxuLwXwv5rrqAVAAoZ5AlNij2gDwmTXKHAv8yBL2yEkkPI1TOK
 iwM5QgIldwYxkDESx8Gi0R4+ERXeLcXGvdsg80xzQc2g0G3rohZlInHEYTaiZez84KYBqaCnYeB
 bbfzUYhOB2nX17GnQsyI2LNxpLa//m7OxS5ALftpNxIqCpVUdODBVkOhHaTZiZ36DwKP0pVkyK7
 VRIUXmEm2zG2wpz55N52cx6m2BSpgDwdUoSeHv+T29428KJsnGj00idbCINBXZxuJSq24FfC
X-Received: by 2002:adf:e001:0:20b0:48b:1296:52ec with SMTP id
 ffacd0b85a97d-4982ecf642cmr4185972f8f.18.1794323030234; 
 Tue, 10 Nov 2026 07:03:50 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:49 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 05/13] migration/rdma: Handle write/flush/reg-stop
 on the consumer
Date: Tue, 10 Nov 2026 16:02:39 +0100
Message-ID: <20261110150247.193208-6-dmitrii.omelchenko@cloud.ionos.com>
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

Extend rdma_consumer_dispatch to run the real send work off the ring:
RDMA_CMD_WRITE posts one chunk via qemu_rdma_write_chunk, RDMA_CMD_FLUSH
drains the CQ, and RDMA_CMD_REG_STOP sends REGISTER_FINISHED (draining
and dumping stats first on FINISH).  The thread acks barrier commands
via ring_barrier_complete.  The producer still drives the old inline
path, so the ring still carries only FINISH.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index c3070b7a92..d11f6e0da8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1216,6 +1216,7 @@ static void rdma_nbsent_zero(RDMAContext *rdma);
 
 static void rdma_consumer_start(RDMAContext *rdma);
 static void rdma_consumer_stop(RDMAContext *rdma);
+static void rdma_nbsent_stats_dump(RDMAContext *rdma);
 
 /*
  * Consult the connection manager to see a work request
@@ -1986,6 +1987,33 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     return 0;
 }
 
+/* Consumer: write one whole chunk */
+static int qemu_rdma_write_chunk(RDMAContext *rdma, uint32_t block_index,
+                                 uint32_t chunk_index, Error **errp)
+{
+    RDMALocalBlock *block = &rdma->local_ram_blocks.block[block_index];
+    uint64_t chunk_off = (uint64_t)chunk_index * migrate_rdma_chunk_size();
+    uint64_t len = block->length - chunk_off;
+    int ret;
+
+    if (len > migrate_rdma_chunk_size()) {
+        len = migrate_rdma_chunk_size();
+    }
+
+    /* write_one wants current_addr in ram_addr_t space (block->offset based) */
+    ret = qemu_rdma_write_one(rdma, block_index, block->offset + chunk_off,
+                              len, errp);
+    if (ret < 0) {
+        return -1;
+    }
+    if (ret == 0) {
+        rdma->nb_sent++;
+        trace_rdma_write_flush(rdma->nb_sent);
+        rdma_nbsent_inc(rdma, rdma->nb_sent);
+    }
+    return 0;
+}
+
 /*
  * Push out any unwritten RDMA operations.
  *
@@ -2846,6 +2874,13 @@ static void ring_advance_tail(RDMASendRing *r)
     ring_wake_producer(r);
 }
 
+/* Consumer: publish barrier completion. */
+static void ring_barrier_complete(RDMASendRing *r, unsigned seq)
+{
+    qatomic_store_release(&r->barrier_done_seq, seq);
+    ring_wake_producer(r);
+}
+
 /* Consumer: sleep until the ring is non-empty or aborted. */
 static void ring_idle_wait(RDMASendRing *r)
 {
@@ -2859,6 +2894,23 @@ static void ring_idle_wait(RDMASendRing *r)
     qemu_mutex_unlock(&r->wait_lock);
 }
 
+/* Consumer: send REGISTER_FINISHED; for FINISH drain and dump stats first. */
+static int rdma_consumer_reg_stop(RDMAContext *rdma, uint64_t flags,
+                                  Error **errp)
+{
+    RDMAControlHeader head = { .len = 0,
+                               .type = RDMA_CONTROL_REGISTER_FINISHED,
+                               .repeat = 1 };
+
+    if (flags == RAM_CONTROL_FINISH) {
+        if (qemu_rdma_drain_cq(rdma, errp) < 0) {
+            return -1;
+        }
+        rdma_nbsent_stats_dump(rdma);
+    }
+    return qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, errp);
+}
+
 static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
                                   bool *stop)
 {
@@ -2866,6 +2918,16 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
     int ret = 0;
 
     switch (cmd->type) {
+    case RDMA_CMD_WRITE:
+        ret = qemu_rdma_write_chunk(rdma, cmd->block_index,
+                                    cmd->chunk_index, &err);
+        break;
+    case RDMA_CMD_FLUSH:
+        ret = qemu_rdma_drain_cq(rdma, &err);
+        break;
+    case RDMA_CMD_REG_STOP:
+        ret = rdma_consumer_reg_stop(rdma, cmd->flags, &err);
+        break;
     case RDMA_CMD_FINISH:
         ret = qemu_rdma_drain_cq(rdma, &err);
         *stop = true;
@@ -2895,6 +2957,9 @@ static void *rdma_consumer_thread(void *opaque)
                 ring_set_abort(rdma);
                 break;
             }
+            if (cmd.seq) {
+                ring_barrier_complete(r, cmd.seq);
+            }
             ring_advance_tail(r);
             continue;
         }
-- 
2.39.5


