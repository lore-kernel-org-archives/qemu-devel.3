Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C82FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR40-0000pv-Ek; Thu, 18 Jul 2024 09:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3q-0008NO-Ut
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3o-0004VP-JF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so3125705e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308838; x=1721913638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+FR9ItM1E+ZFzcj4FqnB5x/ksRo36l8sRb32O5wsYr8=;
 b=lETkxEMVcqp2NopLM15J1FEY0tsfo2zxaS5OKWxtdav/OhFYfo/daU5oQaYYy4M71n
 sUp7vLNwpPxeKWy0GqR8l8dlQuwWqWqOhkaVf4C4NPamIyuTjI/1czUun9Yc+ocG1sQN
 /zi1+3Q+oZPjjhF6I5pwbj8CCIZoy0lQPt+hNk0+vaYxGihbCK5RcGkEAXQTTzhgyXez
 3i9tVrTKHDcyCTTFgPukBQ7PvjQuXw0Z4e4/Ye9GCM41Bpk224rcLpIiLaEyXjcBQBlz
 86yRg9ZoatfkZLpB/6SCdUWUJE57KG+fnGs9Slhf75gsYZ7SQbAkDswgDAhmmbSO4ggK
 Ebug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308838; x=1721913638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FR9ItM1E+ZFzcj4FqnB5x/ksRo36l8sRb32O5wsYr8=;
 b=K+OBV1YvIOfjzcXjinuHUQj+OpeUx+4JH/gusbxymlm0tlUAJNyU0B+Sd1CxGuhiHU
 TxqUx2h3c48q1gbVW2wWpzq5p2IhA81+4ICXUNoxmi56b7vAbwgJoRW4eNxqFKIOBN+b
 iKkMDSGeIwwIXsRG/V6VMvSS0msdKxqlw/z2fWL9GjKSlVQlpd5KVDSkRPHHwlLzdl93
 F1YTIruX3rSocuR3nNVn4HzCgLRwbYeM2lcIehwY5wgesFEAqQv8gc+/8QET47hX6ig7
 luI1ErhRs8QaNaPAmcc0LWdaPmLoARYhocdhH9btWbdREOXfQm2J1iLGt+jm6H0L9E4t
 O+KQ==
X-Gm-Message-State: AOJu0Yz4Z480KTfwmUiiqBAW1td+tLl1lzVEcDDX2UKs3f2Ak83NpE8f
 0kL7a8KtCjMSP+jLcV+0gLjwEeV1O1kfa1YtoJL/jdfL5xgyC6sG56EKqupV5oJp18ep9EUz9rZ
 F
X-Google-Smtp-Source: AGHT+IEjIVo1VXpz2TKA2akunUSc38fBsxVdKE5U8n+kcvuiFXGCEdWYk5kaXA8Ts2DxZw4tQR6C9Q==
X-Received: by 2002:a05:600c:1d20:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427c2cad3c2mr41347395e9.4.1721308838723; 
 Thu, 18 Jul 2024 06:20:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/26] hw/arm/smmu: Support nesting in the rest of commands
Date: Thu, 18 Jul 2024 14:20:19 +0100
Message-Id: <20240718132028.697927-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mostafa Saleh <smostafa@google.com>

Some commands need rework for nesting, as they used to assume S1
and S2 are mutually exclusive:

- CMD_TLBI_NH_ASID: Consider VMID if stage-2 is supported
- CMD_TLBI_NH_ALL: Consider VMID if stage-2 is supported, otherwise
  invalidate everything, this required a new vmid invalidation
  function for stage-1 only (ASID >= 0)

Also, rework trace events to reflect the new implementation.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-15-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 16 ++++++++++++++++
 hw/arm/smmuv3.c              | 28 ++++++++++++++++++++++++++--
 hw/arm/trace-events          |  4 +++-
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index eaee867e45c..d1a4a64551d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -215,6 +215,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e7f9c758fa6..00d7579cd3d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -178,6 +178,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
     return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
 }
 
+static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
+                                            gpointer user_data)
+{
+    int vmid = *(int *)user_data;
+    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
+
+    return (SMMU_IOTLB_VMID(*iotlb_key) == vmid) &&
+           (SMMU_IOTLB_ASID(*iotlb_key) >= 0);
+}
+
 static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
                                               gpointer user_data)
 {
@@ -288,6 +298,12 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
 }
 
+inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
+{
+    trace_smmu_iotlb_inv_vmid_s1(vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
+}
+
 /* VMSAv8-64 Translation */
 
 /**
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 847fc566762..b05f2ab929b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1349,25 +1349,49 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_TLBI_NH_ASID:
         {
             int asid = CMD_ASID(&cmd);
+            int vmid = -1;
 
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
+            /*
+             * VMID is only matched when stage 2 is supported, otherwise set it
+             * to -1 as the value used for stage-1 only VMIDs.
+             */
+            if (STAGE2_SUPPORTED(s)) {
+                vmid = CMD_VMID(&cmd);
+            }
+
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
+            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
+        {
+            int vmid = -1;
+
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
+
+            /*
+             * If stage-2 is supported, invalidate for this VMID only, otherwise
+             * invalidate the whole thing.
+             */
+            if (STAGE2_SUPPORTED(s)) {
+                vmid = CMD_VMID(&cmd);
+                trace_smmuv3_cmdq_tlbi_nh(vmid);
+                smmu_iotlb_inv_vmid_s1(bs, vmid);
+                break;
+            }
             QEMU_FALLTHROUGH;
+        }
         case SMMU_CMD_TLBI_NSNH_ALL:
-            trace_smmuv3_cmdq_tlbi_nh();
+            trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
             break;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 4aa71b1b196..593cc571da7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -13,6 +13,7 @@ smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "base
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
+smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
@@ -47,7 +48,8 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
-smmuv3_cmdq_tlbi_nh(void) ""
+smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
+smmuv3_cmdq_tlbi_nsnh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
-- 
2.34.1


