Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E1CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpgN-0006wl-7e; Mon, 08 Apr 2024 10:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fvoTZggKCvktnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com>)
 id 1rtpgK-0006vv-QD
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:08 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fvoTZggKCvktnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com>)
 id 1rtpgH-0001JF-O6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:08 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60cc8d4e1a4so75563977b3.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585342; x=1713190142; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BCpk0bqjnQgYw45bmFeRBdeibilZssgbLzBrwwIszIA=;
 b=D+fK6fn+4w0LwLvWnZUHMGuuYVDSNGVxgebW4/ReTugO0cacubPjKCWceV2rmq6biV
 Pty2ap6ENWQrY86MobkvNBIv+Va2Ling8se56nFpicU+i00RaxXu6SEklEXeJCk8z/VR
 MyRRFwFJ3sFkFmlkJTnh49spYY1U3uR7Mgy0uKAyFunwJoVcqBbrFZBM4Zf0oIM1pJWA
 O+XcirUHwXZqJ2UH0nnIU+I3CY7OmZpoxzPXyzDmttFjlEkhmWaIbJv+fdZ23cQi8mJl
 CA14E3RcGKRFSjGZnSBDafwlV9ZwC8fkpxvZ40bqcYh73Un5d/CQJQtc4ViQkoUZW+Y1
 9c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585342; x=1713190142;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BCpk0bqjnQgYw45bmFeRBdeibilZssgbLzBrwwIszIA=;
 b=QHsO8/3W59gFZ52gi0pUvxELvplB1LCjAU0nMQ5JNMLrTKsJikuwCoV8/rTQGCDUOg
 R5o75yVqPGU5FE0Y/NTA+2CLiHAmpRJ62K0qK4BwlZJ0GhuD8ynwhaY3jMLuDmkp39Lx
 EgH/K9YHuPqIbjXamYoWI9KtzgWATevZdaES1QhSjezMpya9VXOcVdcVJxv2/fhnaGzF
 mKFUf8G9IJZLohS/niNESj8JAlB9+W6ybMZJxSlGwAtijg7Sf68LAuFHy9sKZyWvhUpc
 Y7wT6VM4XLuMrD4Ye+KzMTY0HP0GZpZ8URsa/SW9O+gIF312yzjV5hkWfMAcoidN0PWG
 /l/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWyWcZ2dj7PYoFDfy29RYW7ao/RSpqBL+G+f1d32ueFEQizQGfij11EvQ/giZToPdZdyZImZO/CQ+lwzEqYqTx8itH2rI=
X-Gm-Message-State: AOJu0YxQKjIl71xatHJyB9psvF5m3RSfHFvKIz43ra8XnmkZhJk6vadk
 XU4W095H8BZtaDIecr72D6kSwyBKgB2VuGB7ai5ld75n7eB44J5hSN6oWdbzJSGHF2gtfTk5zI9
 Cjko2a08rkw==
X-Google-Smtp-Source: AGHT+IHQ4jTTdpvQf+yX8IXPSjHwTo5O55siDyTFjW+nkl/JR5ZcB9Tiubk7sEaO7hp1ovpWE+u7ZjdkhOGxxw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:7b54:0:b0:618:24ca:381f with SMTP id
 w81-20020a817b54000000b0061824ca381fmr44771ywc.8.1712585342258; Mon, 08 Apr
 2024 07:09:02 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:06 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-2-smostafa@google.com>
Subject: [RFC PATCH v2 01/13] hw/arm/smmu: Use enum for SMMU stage
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3fvoTZggKCvktnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com;
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

Currently, translation stage is represented as an int, where 1 is stage-1 and
2 is stage-2, when nested is added, 3 would be confusing to represent nesting,
so we use an enum instead.

While keeping the same values, this is useful for:
 - Doing tricks with bit masks, where BIT(0) is stage-1 and BIT(1) is
   stage-2 and both is nested.
 - Tracing, as stage is printed as int.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c         | 14 +++++++-------
 hw/arm/smmuv3.c              | 15 ++++++++-------
 include/hw/arm/smmu-common.h | 11 +++++++++--
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 4caedb4998..3a7c350aca 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -304,7 +304,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     dma_addr_t baseaddr, indexmask;
-    int stage = cfg->stage;
+    SMMUStage stage = cfg->stage;
     SMMUTransTableInfo *tt = select_tt(cfg, iova);
     uint8_t level, granule_sz, inputsize, stride;
 
@@ -392,7 +392,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
     info->type = SMMU_PTW_ERR_TRANSLATION;
 
 error:
-    info->stage = 1;
+    info->stage = SMMU_STAGE_1;
     tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
@@ -415,7 +415,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
                           dma_addr_t ipa, IOMMUAccessFlags perm,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
-    const int stage = 2;
+    const SMMUStage stage = SMMU_STAGE_2;
     int granule_sz = cfg->s2cfg.granule_sz;
     /* ARM DDI0487I.a: Table D8-7. */
     int inputsize = 64 - cfg->s2cfg.tsz;
@@ -513,7 +513,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
     info->type = SMMU_PTW_ERR_TRANSLATION;
 
 error:
-    info->stage = 2;
+    info->stage = SMMU_STAGE_2;
     tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
@@ -532,9 +532,9 @@ error:
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
              SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
-    if (cfg->stage == 1) {
+    if (cfg->stage == SMMU_STAGE_1) {
         return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
-    } else if (cfg->stage == 2) {
+    } else if (cfg->stage == SMMU_STAGE_2) {
         /*
          * If bypassing stage 1(or unimplemented), the input address is passed
          * directly to stage 2 as IPA. If the input address of a transaction
@@ -543,7 +543,7 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
          */
         if (iova >= (1ULL << cfg->oas)) {
             info->type = SMMU_PTW_ERR_ADDR_SIZE;
-            info->stage = 1;
+            info->stage = SMMU_STAGE_1;
             tlbe->entry.perm = IOMMU_NONE;
             return -EINVAL;
         }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9eb56a70f3..50e5a72d54 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -34,7 +34,8 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
-#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == 1) ? (cfg)->record_faults : \
+#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
+                                 (cfg)->record_faults : \
                                  (cfg)->s2cfg.record_faults)
 
 /**
@@ -402,7 +403,7 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 
 static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
 {
-    cfg->stage = 2;
+    cfg->stage = SMMU_STAGE_2;
 
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
@@ -678,7 +679,7 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
     /* we support only those at the moment */
     cfg->aa64 = true;
-    cfg->stage = 1;
+    cfg->stage = SMMU_STAGE_1;
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
@@ -762,7 +763,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return ret;
     }
 
-    if (cfg->aborted || cfg->bypassed || (cfg->stage == 2)) {
+    if (cfg->aborted || cfg->bypassed || (cfg->stage == SMMU_STAGE_2)) {
         return 0;
     }
 
@@ -882,7 +883,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    if (cfg->stage == 1) {
+    if (cfg->stage == SMMU_STAGE_1) {
         /* Select stage1 translation table. */
         tt = select_tt(cfg, addr);
         if (!tt) {
@@ -919,7 +920,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
              * nesting is not supported. So it is sufficient to check the
              * translation stage to know the TLB stage for now.
              */
-            event.u.f_walk_eabt.s2 = (cfg->stage == 2);
+            event.u.f_walk_eabt.s2 = (cfg->stage == SMMU_STAGE_2);
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
@@ -935,7 +936,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
         /* All faults from PTW has S2 field. */
-        event.u.f_walk_eabt.s2 = (ptw_info.stage == 2);
+        event.u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
         g_free(cached_entry);
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5ec2e6c1a4..b3c881f0ee 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -49,8 +49,15 @@ typedef enum {
     SMMU_PTW_ERR_PERMISSION,  /* Permission fault */
 } SMMUPTWEventType;
 
+/* SMMU Stage */
+typedef enum {
+    SMMU_STAGE_1 = 1,
+    SMMU_STAGE_2,
+    SMMU_NESTED,
+} SMMUStage;
+
 typedef struct SMMUPTWEventInfo {
-    int stage;
+    SMMUStage stage;
     SMMUPTWEventType type;
     dma_addr_t addr; /* fetched address that induced an abort, if any */
 } SMMUPTWEventInfo;
@@ -88,7 +95,7 @@ typedef struct SMMUS2Cfg {
  */
 typedef struct SMMUTransCfg {
     /* Shared fields between stage-1 and stage-2. */
-    int stage;                 /* translation stage */
+    SMMUStage stage;           /* translation stage */
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
-- 
2.44.0.478.gd926399ef9-goog


