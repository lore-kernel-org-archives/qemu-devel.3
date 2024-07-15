Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82704C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLe-0006lu-6o; Mon, 15 Jul 2024 04:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yOGUZggKChsJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com>)
 id 1sTHLP-0005jW-Ob
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:08 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yOGUZggKChsJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com>)
 id 1sTHLO-00047b-1F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:03 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-65be82a3241so73607137b3.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033160; x=1721637960; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Chw4FqJ0T5QGDw52fywH0TUhHtoJV74548yvdKTYn6E=;
 b=v5aBd+SyHX61/3NsItv/1uVlkInB847VYPjyOy85bWR+r8y5c0In23LQo6XG+RJVeh
 XgptQUELl0cljXo7i/ZTLF/9czI+XuHmFNrmVnGDLBBc0w932lIiR6OT38jgq3RpvlHZ
 fNWCMMA2qYJ9/QcgIErR4HvBwjAru99Hb9SqM79TFM16qDlOZ1lcgnsTbidTneVV5lhE
 /SWdxZD8GyTjcFudEfMMYF+vBQyHvyBJx/M1g8cH1HUa9mCRbGSZGY4dCq7+OvUDni2W
 xRThLlNrZsoh9/o7wUIZwyk9JtNS/fKRtyUhCve2faMRVdgiCXzC6WUcxHNvDo2oDT9K
 iLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033160; x=1721637960;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Chw4FqJ0T5QGDw52fywH0TUhHtoJV74548yvdKTYn6E=;
 b=bPxHJ6i2nJpqJ1aQ3NePIeTUzIqXHy97zaVxV+e1SbYaxQpuVbyKnqeUvvgavIWNh5
 ANzL3y7y9KhdsPrugaJMX5a345AId/b+VETh0ooz0johV/ostgCqMxCDJdBPSrBG1F0x
 OJgXUN5xX28RY0dvLBC9utGsVVQHeoJgUlfQYq39MW6aQsDlchcXP12Eq3+7ueABVx1Z
 HX5nhR6zs71HfsuovLtyN4ICAZwM1LcYb39tsuFjBLuCu/kDHwR5CM1zAZlKrHBYElRh
 MMs/0kpxc8AS7L9o75Z7DTtMgN/pLtH2J9phYR79doLhq9KgUsxzO/POUR8VrzaqWov3
 f+vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFCP5tp1SVoakcXhTLx8DmcWCRDZmTz7OrpfxHY6mHSCIPzxsSSIGSTJtf9boJswqcwLwnoo5J8/6iO4tLjfYt+yUOk5g=
X-Gm-Message-State: AOJu0YxUtvMxOBr4H8RC72j5kPQtZIbnfIVcS8i2kiYgq98RZg5/aDk/
 MRMPjkwJbfwqx/Xzk0WuA6XDZnIBfNFlbZX4kCAe2+Y7y0WyJkxcxGS1b73TNTCkpzGMj05jXU+
 lpEpBWyv9SA==
X-Google-Smtp-Source: AGHT+IHC2a1XPeyJXvu9U4qmKRTZiNQ2yXDn0+7juZiM3/fD24czItRVjP3r5cyRm2yEgZGsUMdpQpXynY5FPg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:3510:b0:64b:5dc3:e4fe with SMTP
 id 00721157ae682-658ee699c87mr4766677b3.1.1721033160342; Mon, 15 Jul 2024
 01:46:00 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:14 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-15-smostafa@google.com>
Subject: [PATCH v5 14/18] hw/arm/smmu: Support nesting in the rest of commands
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3yOGUZggKChsJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
---
 hw/arm/smmu-common.c         | 16 ++++++++++++++++
 hw/arm/smmuv3.c              | 28 ++++++++++++++++++++++++++--
 hw/arm/trace-events          |  4 +++-
 include/hw/arm/smmu-common.h |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index bf35806b02..67cb134d23 100644
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
index cfee42add4..9a88b83511 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1353,25 +1353,49 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
index 4aa71b1b19..593cc571da 100644
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
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b3a937190b..d38687581b 100644
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
-- 
2.45.2.993.g49e7a77208-goog


