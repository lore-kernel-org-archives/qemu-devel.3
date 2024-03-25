Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6459ECD11DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMP-0004J6-3C; Mon, 25 Mar 2024 06:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3sU4BZggKCoo60267otou22uzs.q204s08-rs9sz121u18.25u@flex--smostafa.bounces.google.com>)
 id 1rohMK-0004IX-RS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:16 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3sU4BZggKCoo60267otou22uzs.q204s08-rs9sz121u18.25u@flex--smostafa.bounces.google.com>)
 id 1rohMI-0004Yi-NK
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:16 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4140225e68aso24136265e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361713; x=1711966513; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=26bo4OK1oRLPmUoPAhKQN+ii39gQbfEXqIUiZXYMfoE=;
 b=Xk580NFKumIeLjoakIclzfy4ZKt65yipAAg6GWG+wCJoSvmXWd4bZepTMUcwLP6Zm6
 6hoGjUxQBQZoQaiSz2iKpaMPAFrL31VgCRB730xLEv0QVVfNbgnSAAErPmJUdMmjl7TG
 fALTddWWjRbjvFhx0hB2LRqGJc1NvBwaOx2SiTwxYXpZdrVm1nXfuBSfKZ5M1QNkRXR7
 Dx8LWPmXwR9I165hAe/g1x9cMpNTTZ3zqHULU7J5xPRae9dlZCP5lGMNF+WBi4YYl5Cg
 EmPgq4pCscdx7/+I3jUIvwmcePa9yMYnrp6t7iSkg7U7YNvwYrmo3p1YZZhxcd02OPgh
 FdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361713; x=1711966513;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=26bo4OK1oRLPmUoPAhKQN+ii39gQbfEXqIUiZXYMfoE=;
 b=ro+MQW9qNjjZw5Zaxd8tSDt+F70NmWjkyMNIbOsH8y8FwvC1ssn8b/WQ6lI7s4kG2j
 0owAxkwv7lptHJSHKNmF/eA8rM6IJXBBHR4Yf8RFceomf/VcmKCKm6Ei/oq6mqvWn0uP
 lTs0hqkV1Rbp53O0E6Y2JU3XIbHPf70NOBQA6fqWMkDB9VICbaXAXpqnN+8PgwYiTxjj
 zcgfKV/igjv2AcdSo3OoMwEGu67Jmu8u0G4lxtM0LPAAlyGTfStVuOoOaE3d1s8WMs6X
 IHfGXOwfqHTVqxHvy/uUmpye1KhoVN1TMabGq+VsaRfOIO9npuvfoTG76wy4qTehjdBP
 RRQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmJl6wxdvlkpFydgBRGKkAVkdZXoT7rG8IpedrMT8fN9xe0tUcwT6caRD0TgUWi1lkfVLLuWJZGdMEWCc64JfEDgGtB8M=
X-Gm-Message-State: AOJu0Yx6iDbKtqdn3zEAO2Pw8fIhnqCNMjDvlAD3JZeAXonX+tOdoGFB
 XUioOeoPfGzQqsRd0+TAsXIP1F696j9cNDKPZ0Cvwwdq6pzguh3HvMmUxHW7nRhLwmm1p+/0XER
 elZ0+wWIRQA==
X-Google-Smtp-Source: AGHT+IGjTc2xwZSG2zw7LF89NYgfoR94W73ilRIlZK5sJd7P155JSlBqYhgjdPIBA53TGUdkz3rgJz1Eb8748A==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:22d7:b0:414:8889:5a5e with SMTP
 id 23-20020a05600c22d700b0041488895a5emr19187wmg.7.1711361713000; Mon, 25 Mar
 2024 03:15:13 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:00 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-5-smostafa@google.com>
Subject: [RFC PATCH 04/12] hw/arm/smmu: Support nesting in commands
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3sU4BZggKCoo60267otou22uzs.q204s08-rs9sz121u18.25u@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commands had assumptions about VMID and ASID being mutually exclusive
and the same for stage-1 and stage-2. As we are going to support
nesting, we need to implement them properly:
- CMD_TLBI_NH_ASID: Used to ignore VMID as it was not used in stage-1
  instances, now we read it from the command and invalidate by
  ASID + VMID if stage-2 exists.

- CMD_TLBI_NH_ALL: Use to invalidate all as VMID were not used in
  stage-1 instances, now it invalidates stage-1 by vmid, and this
  command is decoupled from CMD_TLBI_NSNH_ALL which invalidates all
  stages.

- CMD_TLBI_NH_VAA, SMMU_CMD_TLBI_NH_VA: Used to ignore VMID also.

- CMD_TLBI_S2_IPA: Now invalidates stage-2 only.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 34 +++++++++++++++++---------
 hw/arm/smmuv3.c              | 47 +++++++++++++++++++++++++++---------
 hw/arm/trace-events          |  7 +++---
 include/hw/arm/smmu-common.h |  4 +--
 4 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 677dcf9a13..f0905c28cf 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -129,22 +129,24 @@ void smmu_iotlb_inv_all(SMMUState *s)
     g_hash_table_remove_all(s->iotlb);
 }
 
-static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
-                                         gpointer user_data)
+static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
+                                              gpointer user_data)
 {
-    uint16_t asid = *(uint16_t *)user_data;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
+    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
+            (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
 }
 
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
-    uint16_t vmid = *(uint16_t *)user_data;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
+    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
+            (info->stage & SMMU_IOTLB_STAGE(*iotlb_key));
 }
 
 static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
@@ -198,16 +200,26 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                                 &info);
 }
 
-void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, uint16_t asid, uint16_t vmid)
 {
+    SMMUIOTLBPageInvInfo info = {
+        .asid = asid,
+        .vmid = vmid,
+    };
+
     trace_smmu_iotlb_inv_asid(asid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
 }
 
-inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid, SMMUStage stage)
 {
-    trace_smmu_iotlb_inv_vmid(vmid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
+    SMMUIOTLBPageInvInfo info = {
+        .vmid = vmid,
+        .stage = stage,
+    };
+
+    trace_smmu_iotlb_inv_vmid(vmid, stage);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &info);
 }
 
 /* VMSAv8-64 Translation */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b27bf297e1..9460fff0ed 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1060,7 +1060,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
     }
 }
 
-static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1085,9 +1085,9 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
     }
 
     if (!tg) {
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
+        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
-        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, SMMU_NESTED);
+        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, stage);
         return;
     }
 
@@ -1103,10 +1103,10 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
         uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
 
         num_pages = (mask + 1) >> granule;
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
+        trace_smmuv3_range_inval(vmid, asid, addr, tg,
+                                 num_pages, ttl, leaf, stage);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
-        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
-                            num_pages, ttl, SMMU_NESTED);
+        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl, stage);
         addr += mask + 1;
     }
 }
@@ -1237,25 +1237,48 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_TLBI_NH_ASID:
         {
             uint16_t asid = CMD_ASID(&cmd);
+            uint16_t vmid = CMD_VMID(&cmd);
 
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
+            /*
+             * VMID is only matched when stage 2 is supported for the Security
+             * state corresponding to the command queue that the command was
+             * issued in.
+             * QEMU ignores the field by setting to -1, similarly to what STE
+             * decoding does. And invalidation commands ignore VMID < 0.
+             */
+            if (!STAGE2_SUPPORTED(s)) {
+                vmid = -1;
+            }
 
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid(bs, asid);
+            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
+        {
+            uint16_t vmid = CMD_VMID(&cmd);
+
+            trace_smmuv3_cmdq_tlbi_nh(vmid);
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            QEMU_FALLTHROUGH;
+
+            /* See SMMU_CMD_TLBI_NH_ASID. */
+            if (!STAGE2_SUPPORTED(s)) {
+                vmid = -1;
+            }
+
+            smmu_iotlb_inv_vmid(bs, vmid, SMMU_STAGE_1);
+            break;
+        }
         case SMMU_CMD_TLBI_NSNH_ALL:
-            trace_smmuv3_cmdq_tlbi_nh();
+            trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
             break;
@@ -1265,7 +1288,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
@@ -1278,7 +1301,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_vmid(bs, vmid);
+            smmu_iotlb_inv_vmid(bs, vmid, SMMU_NESTED);
             break;
         }
         case SMMU_CMD_TLBI_S2_IPA:
@@ -1290,7 +1313,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3000c3bf14..73cec52d21 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -12,7 +12,7 @@ smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, ui
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
-smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
+smmu_iotlb_inv_vmid(uint16_t vmid, int stage) "IOTLB invalidate vmid=%d stage=%d"
 smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_iotlb_inv_stage(int stage) "Stage invalidate stage=%d"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
@@ -47,8 +47,9 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
-smmuv3_cmdq_tlbi_nh(void) ""
+smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
+smmuv3_cmdq_tlbi_nsnh(void) ""
+smmuv3_cmdq_tlbi_nh(uint16_t vmid) "vmid=%d"
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 695d6d10ad..6d3bf5316b 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -208,8 +208,8 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level, SMMUStage stage);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, uint16_t asid, uint16_t vmid);
+void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid, SMMUStage stage);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl,
                          SMMUStage stage);
-- 
2.44.0.396.g6e790dbe36-goog


