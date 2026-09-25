Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C035C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Uq-0001WH-69; Fri, 25 Sep 2026 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dr-0007yp-Ju
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:27 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dp-00062B-PZ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:27 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so636252f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351544; x=1790956344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GIOmBx1IGb/7oU+3HeMgEeumH7X5vzideD5xlFaVCN8=;
 b=acERh8Wotn7bHAjqkVvALTHm9kXJu5kGg9DSLmozzmhYUI874FCpzZCUDJ/O4l6ZCK
 oz96eG/LFAZSwh3hcLStx5ugCuOl5xFz29BA+Qq8ihEvPOq4yQivXxAEP8AreFNHoYrx
 oXErWE8oXJoclsV+B2pqQncIbzr9t6kdFAIoIfSdubfTPQtKw92gkK/4givJX/cr0xNJ
 Cq+09mz5f9ar6TZAapJRtokbX7EJKjFXdaombQkT0uXnxxNTv4PZVAmelUQOwqSNa/UQ
 PLOUuUvFpQ1b4BBRjMGjIpWfu9sFfgqb0KwB9Ogc7bNlbFNnCpa8ciQ8xTJ/cNnSZG3a
 SQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351544; x=1790956344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GIOmBx1IGb/7oU+3HeMgEeumH7X5vzideD5xlFaVCN8=;
 b=UwZhmuSaLnpNAFdkmgb2W/7hQlF0bdTIWXhultGHsRk3GG9kebKIJFKBpoAGWK4KjM
 UL5Bbj1PiZSNNx1oZhMYPAJIVqESgV9PvKOiR80AGtlsohRnUqZNqa86z5IhqjWNFukO
 GhLSdPWIk45Jurd6a0zSKNsXLnGHgAJX+b19c1h12iMzPd6zO7jNmboHdpJ830EOdNMp
 3znuK+nCMovB7vSMRVMoCvayGPtID4eRkHHSQYs9qTXQM7R4u0XwNck5Qwl2cV+o7J/f
 vVzXTaQMpH36a0g2UwX/FGfwtziPuChUciFuOh4xS6ODkSE20i8hxHeU4LRxoV3Ob9Mg
 clpQ==
X-Gm-Message-State: AFuF++kV+HrSGteCWFjXRabtvaeUTyJNukpfkyRXx4MpBgqeyfCwZxx9
 FKVm/VnVU5KQB0jVjGfUPAfPhWO6mtK29BiZOOXkmcKBFRlnOyODDWsdl0l+FwyCcEVI7CVHivx
 lkHTMm5AnDw==
X-Gm-Gg: AYBFou1dJqrmBptZpPiPIl/+AAKUzCL3sDPiN55O3ijG51pSdVcZEakjw3reoNM3VNo
 +8KTQtBBIMOgBMdO+O8aYBxTqS79G3F8nfmWhw04l0cWufqV8TMtcnnb5idfBq7ndMxg31g1DeK
 eSh8/Zdq7er3ZNc+IQzMddXPoxKAbzN+8aUD3M1N1P7CoMUNrTC717naJdy/1IKHtlJoAZrSYxJ
 wzuew8OacPxbozKJCUxaVVvlI6KGUmB36LehqwdDRX3FxLbDaJw+DdaLrDF60/EH9FB4S23Rkoh
 8m5DxVhR/TOWI6lu2/5EVr7Tnx7ZgPJxowDt6GR5thBmVG0Kz4WgJX9DGoW25Wt21zcwQ3B5EF2
 WmRmkB6a0MlTktMpdtLnE4AhKLK3ow7iQpgHsS8ljCUue478aZc8XeNXzkLudtui8k1Bo7/0LeO
 4YHl4baAGSErE8c0S2mh2FANUJsU7ZEORbCzCUMhU2kLfxFy/AqelrLCTYPf4MkqZktEwLI7MRZ
 OLaGVWKM98zvB6hmlz1yoe/om/mAraBHWOHH4l5TnflAd7kIJke
X-Received: by 2002:a05:600c:348e:b0:49e:8191:e5cb with SMTP id
 5b1f17b1804b1-49ff06b2ef6mr49202885e9.5.1790351544332; 
 Fri, 25 Sep 2026 08:52:24 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:23 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 13/13] migration/rdma: negotiate batched chunk registration
Date: Fri, 25 Sep 2026 17:51:48 +0200
Message-ID: <20260925155149.843870-14-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:30::10;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr2-x10.google.com
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

From: Jack Wang <jinpu.wang@cloud.ionos.com>

An old peer echoes REGISTER_RESULT.repeat unchanged but only sends one
result, so a batched source would read stale rkeys for the rest.
Negotiate RDMA_CAPABILITY_REG_BATCH like PIN_ALL and cap requests at
one chunk when unsupported; check resp.len instead of resp.repeat.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c       | 37 ++++++++++++++++++++++++++++++++++---
 migration/trace-events |  1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 863165de26..29a2480448 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -75,12 +75,15 @@ static inline uint64_t rdma_merge_max(void)
  * Capabilities for negotiation.
  */
 #define RDMA_CAPABILITY_PIN_ALL 0x01
+/* Peer replies to a batched REGISTER_REQUEST with one result per chunk. */
+#define RDMA_CAPABILITY_REG_BATCH 0x02
 
 /*
  * Add the other flags above to this list of known capabilities
  * as they are introduced.
  */
-static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
+static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL |
+                                     RDMA_CAPABILITY_REG_BATCH;
 
 /*
  * A work request ID is 64-bits and we split up these bits
@@ -352,6 +355,7 @@ typedef struct RDMAContext {
     uint64_t pend_length;         /* span length in bytes (within one chunk) */
 
     bool pin_all;
+    bool reg_batch;   /* peer negotiated RDMA_CAPABILITY_REG_BATCH */
 
     /*
      * infiniband-specific variables for opening the device
@@ -1947,6 +1951,14 @@ static int qemu_rdma_write_register(RDMAContext *rdma, RDMARegister *regs,
         return -1;
     }
 
+    /* resp.repeat is echoed back unchanged by old peers; resp.len is not. */
+    if (resp.len != count * sizeof(RDMARegisterResult)) {
+        error_setg(errp, "rdma: REGISTER_RESULT size mismatch: "
+                   "requested %u chunks (%zu bytes), peer returned %u bytes",
+                   count, count * sizeof(RDMARegisterResult), resp.len);
+        return -1;
+    }
+
     results = (RDMARegisterResult *)rdma->wr_data[reg_result_idx].control_curr;
     for (i = 0; i < count; i++) {
         RDMALocalBlock *block =
@@ -2172,6 +2184,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
         cap.flags |= RDMA_CAPABILITY_PIN_ALL;
     }
 
+    cap.flags |= RDMA_CAPABILITY_REG_BATCH;
+
     caps_to_network(&cap);
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
@@ -2219,6 +2233,13 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
         rdma->pin_all = false;
     }
 
+    rdma->reg_batch = !!(cap.flags & RDMA_CAPABILITY_REG_BATCH);
+    if (!rdma->reg_batch) {
+        warn_report("RDMA: Server does not support batched chunk "
+                    "registration. Will register one chunk per request.");
+    }
+    trace_rdma_connect_reg_batch_outcome(rdma->reg_batch);
+
     trace_rdma_connect_pin_all_outcome(rdma->pin_all);
 
     rdma_ack_cm_event(cm_event);
@@ -2952,6 +2973,14 @@ static int qemu_rdma_write_run(RDMAContext *rdma, RDMASendRing *r,
                 return -1;
             }
         } else {
+            bool new_chunk = (int)cmd->block_index != last_bidx ||
+                             (int64_t)cmd->chunk_index != last_cidx;
+
+            /* Cap at one never-seen chunk per request without REG_BATCH. */
+            if (new_chunk && nreg == 1 && !rdma->reg_batch) {
+                break;
+            }
+
             /* Defer: record every span for a post-registration write. */
             reg_ring_idx[regn++] = pos + n;
             /*
@@ -2959,8 +2988,7 @@ static int qemu_rdma_write_run(RDMAContext *rdma, RDMASendRing *r,
              * non-decreasing within a run, so a repeat chunk is the last one
              * queued; add each chunk to the REGISTER batch only once.
              */
-            if ((int)cmd->block_index != last_bidx ||
-                (int64_t)cmd->chunk_index != last_cidx) {
+            if (new_chunk) {
                 regs[nreg].current_index = cmd->block_index;
                 regs[nreg].current_addr = addr;
                 nreg++;
@@ -3663,6 +3691,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (cap.flags & RDMA_CAPABILITY_PIN_ALL) {
         rdma->pin_all = true;
     }
+    if (cap.flags & RDMA_CAPABILITY_REG_BATCH) {
+        rdma->reg_batch = true;
+    }
 
     rdma->cm_id = cm_event->id;
     verbs = cm_event->id->verbs;
diff --git a/migration/trace-events b/migration/trace-events
index e05ca23f32..3c5da0fd14 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -223,6 +223,7 @@ rdma_cleanup_disconnect(void) ""
 rdma_close(void) ""
 rdma_connect_pin_all_requested(void) ""
 rdma_connect_pin_all_outcome(bool pin) "%d"
+rdma_connect_reg_batch_outcome(bool reg_batch) "%d"
 rdma_dest_init_trying(const char *host, const char *ip) "%s => %s"
 rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but can't query port information"
 rdma_dump_id(const char *who, const char *name, const char *dev_name, const char *dev_path, const char *ibdev_path, int transport, const char *transport_name) "%s RDMA Device opened: kernel name %s uverbs device name %s, infiniband_verbs class device path %s, infiniband class device path %s, transport: (%d) %s"
-- 
2.39.5


