Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA2CD1297
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpgU-0006zA-2d; Mon, 08 Apr 2024 10:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hfoTZggKCgIuoquvchciqqing.eqosgow-fgxgnpqpipw.qti@flex--smostafa.bounces.google.com>)
 id 1rtpgP-0006y0-Uy
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:13 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hfoTZggKCgIuoquvchciqqing.eqosgow-fgxgnpqpipw.qti@flex--smostafa.bounces.google.com>)
 id 1rtpgM-0001Mc-To
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:13 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-617fffab703so19063997b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585349; x=1713190149; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=I6ATJsy3meUvTXvscx3wXoJMQXTicy2M4jxU0ba4BEQ=;
 b=cIth8oyOjlMRcR9R9E4tBIHxpOMmq1L+efBNRb6Oq/m5o59b3eo8Fj1S8LwMJMpmQR
 cCIuSDTp9mJ1BiqpBHbdpYTJaD18pALWt3DEiwxfhW1u7KhzpSyHCgpBDrP9/uXLxxZj
 fTbRC9z+7Rfr3aBorA9SQXojMSHx6R8kNU/sHW5toFqrL9xI8k5AySjc7629bJCBtf77
 T0QGNhcyahRlx5laxYtBOCvXJK6xG0KIrnmXdsRKjNbgCcqqw5VklwcFSi/7snUgc1Ev
 aLeQ8y6HBMfoz9IWs3mcIEJbCI4lm/uBO4m43Y3UK/PHRRTsV2BhqAzCOsWMYteWgopA
 sfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585349; x=1713190149;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6ATJsy3meUvTXvscx3wXoJMQXTicy2M4jxU0ba4BEQ=;
 b=KCIMNsvslTfWIpYVcGWwCuasaAhj0/CEpLpywd8qsRc2ttRUDa0wZICAyev0keJkjF
 B5Yvqg1O/yt6HkfFzuYNJTjt8C6r7kPEoKsyZtU/Trb3DJoq/jJGFizWoGC7Pvo1h8h9
 yVFV5FkBDm16seD8lD3Jz+uYQV44Hjf9ijjVYpq+iG9XamJOz7fYqWasJbcbYXzrQocJ
 kPw43BBCavuvelpxDoruvQE/2AgmN2KnXbemwq63J7W3pi0jS3VPpsgR++VsBzC2BAFa
 B/iMuHDbaBS0HKYEiBcEjESrfPytffZLpL7cXemwTIl1pATrsCTJRIrSATQMiDLiv6Bx
 /rOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq3HS85pA9eWSGbZRT1veFDjccpsgeWyU7cKuDDvvhvGD6WDNFtTLKwW4tUejivxUfFr+iR/ejKdHoe+pvdXLWH798Sag=
X-Gm-Message-State: AOJu0YxULINyQa4kp4+D++pJc+Wq/DEcCUOmeXUSaZicrFf2Rcg39JEb
 mg51dgOBdxWdhgh6J14mBJfK9bokfhC47Y+tCQQTJsgq2veh0hjAlR8nePvttA9J7IJGwB6IVeQ
 dLz4QlnkZVA==
X-Google-Smtp-Source: AGHT+IFXhj1dMnd9bT4RTIIS37SU46vpA7CZ6O2Z8X347JAcK6N9p9bX08nMAvw66FJ0i9MlUzBFuX5qt0wigg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1502:b0:dd9:1b94:edb5 with SMTP
 id q2-20020a056902150200b00dd91b94edb5mr705407ybu.10.1712585349473; Mon, 08
 Apr 2024 07:09:09 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:09 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-5-smostafa@google.com>
Subject: [RFC PATCH v2 04/13] hw/arm/smmuv3: Translate CD and TT using stage-2
 table
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3hfoTZggKCgIuoquvchciqqing.eqosgow-fgxgnpqpipw.qti@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

According to the user manual (ARM IHI 0070 F.b),
In "5.2 Stream Table Entry":
 [51:6] S1ContextPtr
 If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
 stage 2 and the programmed value must be within the range of the IAS.

In "5.4.1 CD notes":
 The translation table walks performed from TTB0 or TTB1 are always performed
 in IPA space if stage 2 translations are enabled.

So translate both the CD and the TTBx in this patch if nested
translation is requested.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c              | 49 ++++++++++++++++++++++++++++++------
 include/hw/arm/smmu-common.h | 17 +++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 897f8fe085..a7cf543acc 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -337,14 +337,36 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
+                                                 SMMUTransCfg *cfg,
+                                                 SMMUEventInfo *event,
+                                                 IOMMUAccessFlags flag,
+                                                 SMMUTLBEntry **out_entry);
 /* @ssid > 0 not supported yet */
-static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
-                       CD *buf, SMMUEventInfo *event)
+static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
+                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
 {
     dma_addr_t addr = STE_CTXPTR(ste);
     int ret, i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     trace_smmuv3_get_cd(addr);
+
+    if (cfg->stage == SMMU_NESTED) {
+        CALL_FUNC_CFG_S2(cfg, status, smmuv3_do_translate, s, addr,
+                         cfg, event, IOMMU_RO, &entry);
+        /*
+         * It is not clear what should happen if this fails, so we return here
+         * which gets propagated as a translation error.
+         */
+        if (status != SMMU_TRANS_SUCCESS) {
+            return -EINVAL;
+        }
+
+        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
+    }
+
     /* TODO: guarantee 64-bit single-copy atomicity */
     ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
                           MEMTXATTRS_UNSPECIFIED);
@@ -659,10 +681,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
     return 0;
 }
 
-static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
+static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
+                     CD *cd, SMMUEventInfo *event)
 {
     int ret = -EINVAL;
     int i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -713,6 +738,17 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
         tt->tsz = tsz;
         tt->ttb = CD_TTB(cd, i);
+
+        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
+        if (cfg->stage == SMMU_NESTED) {
+            CALL_FUNC_CFG_S2(cfg, status, smmuv3_do_translate, s,
+                             tt->ttb, cfg, event, IOMMU_RO, &entry);
+            /* See smmu_get_cd(). */
+            if (status != SMMU_TRANS_SUCCESS) {
+                return -EINVAL;
+            }
+            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
+        }
         if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
             goto bad_cd;
         }
@@ -767,12 +803,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return 0;
     }
 
-    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
+    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
     if (ret) {
         return ret;
     }
 
-    return decode_cd(cfg, &cd, event);
+    return decode_cd(s, cfg, &cd, event);
 }
 
 /**
@@ -942,8 +978,7 @@ epilogue:
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = cached_entry->entry.perm;
-        entry.translated_addr = cached_entry->entry.translated_addr +
-                                    (addr & cached_entry->entry.addr_mask);
+        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm,
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 96eb017e50..2772175115 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -37,6 +37,23 @@
 #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
                                              VMSA_BIT_LVL(isz, strd, lvl)) - 1)
 
+#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
+                                             ((addr) & (ent)->entry.addr_mask);
+
+/*
+ * From nested context, some functions might need to translate IPA addresses.
+ * As cfg has SMMU_NESTED, this won't work, this macro calls a function with
+ * making it a stage-2 cfg and then restore it after.
+ */
+#define CALL_FUNC_CFG_S2(cfg, ret, fn, ...)  ({ \
+                                                   int asid = cfg->asid; \
+                                                   cfg->stage = SMMU_STAGE_2; \
+                                                   cfg->asid = -1; \
+                                                   ret = fn(__VA_ARGS__); \
+                                                   cfg->asid = asid; \
+                                                   cfg->stage = SMMU_NESTED; \
+                                              })
+
 /*
  * Page table walk error types
  */
-- 
2.44.0.478.gd926399ef9-goog


