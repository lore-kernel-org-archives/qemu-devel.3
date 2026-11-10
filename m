Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061560A260F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=aqkZHFCL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOm-0004cw-IQ; Tue, 10 Nov 2026 10:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOP-0003VL-DP
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:13 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnON-00006Z-B7
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:13 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so1163872f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323050; x=1794927850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8/fnIwOyMPZFbMQyXhlAspomxQ19P3a4f+ayL8e+Yr0=;
 b=aqkZHFCLkRz7bKUaA9Lv2/XtPgRUQQ6FfX5bdLQ1cgabld1rQjKZF+uukiQ6R1j9Kv
 xuX28sILxSd8Za5cVkt1N4FJCiVYtf+m3g8rn+5CK6vzy/DK4PFG8XiC0BZAOWo+75Zt
 hH2MSCYajikuhM+lCb8zWiKg785Bgh6DYTCkiMvgKIGdqaP1mK5DN3df5RqPHAPVbacK
 ABmzMI0G3OAdpDXTa9jFS5Hf0amtL5vtQeBclyCLi9YkQTgkJwVgl35KrgVNsB6X4xpm
 801OO5LD+CZkJN7Jl4BugAw79yFakKPVeajbbMLB6bTvtayLR+wXDgCywADUlAfWn49e
 niag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323050; x=1794927850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8/fnIwOyMPZFbMQyXhlAspomxQ19P3a4f+ayL8e+Yr0=;
 b=fEA31uG4kWEXOPUvboKl9rYSqZPG/uoV7yEsK+nSNm1j6mhgipudMXDL958UX+ZB0a
 hiuNE8nrsfmeRQdq1c/WZZJGGqV8iG9ybl5yhn2dxJLJ5wa5Uvfd3txvMOqDjFB6Ff0Y
 uLtskrjISwdXxyYCxrwGGMkFB61/91CaqYQUwNDb6i/82mlF27iWTFg+Vrn968vBHfdf
 mRFNYS70Pqyu8hR/s0b1/00xD9HKzhXqCYiOcIgd4xRCu2E0y9rBPmkigwsqP5zfp9bF
 PwoFRtChi45Aw1D+XBrEEHW8beUqiWDI75B8+Xx7jMq6VrCkx3GToo1WVu9AwnaiYlJe
 2u+A==
X-Gm-Message-State: APuU4Z88/a1u1c+hlNxg8ETTrQIP08b+EFy06CR19hJCewth6Fdq6VE9
 XhL7hy3tn9UI1+GPu5sSKCJb80ctsJvaeDaC8suWuiKiBYdDTvTWo7NrNm+ZNWKI3e+tEMqcTke
 xrXg8e4Q=
X-Gm-Gg: AYBFou0NF79WvMcdcbpwVLojdM4Rqa5MXD0+BkDdwd8W/1w4r+JO83A53gY6oiVU76b
 AEGc9pyTnfA1Ax4KgSP5KZzBR1YGsPavYQv8OBaQ+W5/CyurAYZWV3dmScz+Yk6Sz80lH2k7c3d
 yeR+zU2kbY3m9M609EOhlyZJQZuTZVIH+T28NQRXF9D4e+u2XC27VVAV4NMzhmASAXCadbTs/X/
 Ot56Zk94AY5z9tthkDDWKkrMaqTC2yhcu9FYqLJGX2uoRubBty6vm7OpxVqOGM9mzaxHyEFpvgQ
 my+kYqR/ffC3m6ZxWsPBQOMlQkapvB5/8iGsasX9xWxDEm9GMBueeZNmKzoZVgpmMwoNee0PiE9
 5E9GdqJE8Z5QeAzMvCOzLnYQJ4LMOPC0aPGjrwPwWR/hqC+zUdA2KYdADF+HmPLFPxOX85WkU+k
 ges/1+aA8e1300DGCIprYusO8DN/yver6ZVbnw+XT2lcHktAipUXWgIaVK9KbQ92wHUgYzAS3/3
 DJxMouGY50aydq1ryRwNrmoghTfhhNrZJIbnSm7gWD0nh0ys7CIv3Jt/B7zHSyyk4LBcYAYD7ZT
 h1ipw8uq4HdxFh9PclD0oThox2OfjHUehmvLVhGWvAVno9LiEtpMLZv4eSq3KeYU3ZZeg2mX
X-Received: by 2002:a05:6000:15d4:b0:48e:68d5:81a6 with SMTP id
 ffacd0b85a97d-4982f59465bmr4472835f8f.34.1794323049691; 
 Tue, 10 Nov 2026 07:04:09 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:04:09 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 13/13] migration/rdma: negotiate batched chunk
 registration
Date: Tue, 10 Nov 2026 16:02:47 +0100
Message-ID: <20261110150247.193208-14-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::429;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x429.google.com
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
index ea4a1996d3..c55024e24c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -227,6 +227,7 @@ rdma_cleanup_disconnect(void) ""
 rdma_close(void) ""
 rdma_connect_pin_all_requested(void) ""
 rdma_connect_pin_all_outcome(bool pin) "%d"
+rdma_connect_reg_batch_outcome(bool reg_batch) "%d"
 rdma_dest_init_trying(const char *host, const char *ip) "%s => %s"
 rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but can't query port information"
 rdma_dump_id(const char *who, const char *name, const char *dev_name, const char *dev_path, const char *ibdev_path, int transport, const char *transport_name) "%s RDMA Device opened: kernel name %s uverbs device name %s, infiniband_verbs class device path %s, infiniband class device path %s, transport: (%d) %s"
-- 
2.39.5


