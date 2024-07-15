Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C2BC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLi-0007CS-1b; Mon, 15 Jul 2024 04:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3z-GUZggKCiIQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com>)
 id 1sTHLX-0006Ed-5k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:11 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3z-GUZggKCiIQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com>)
 id 1sTHLV-00048f-Fy
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:10 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e0353b731b8so6937288276.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033167; x=1721637967; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0SzSfEc0SLDVHh1GJe0Fzz1n1p2oM3+UJXhVVnM1uKM=;
 b=vQWcltHzsShdi9mSY2BbH4iyo+4AhpPvCDm+hofFyh/TiOM45GmzdvJ3v3R3SR6VwA
 HqDf3aMLfMjUMLDBwJCVkAVrMKX0KV3FJJgQfxdcRxRSs7weHzZ12JKps9lyfOVv6Lz5
 g3eKimvQe6z/xgvEBzGFSAyh3LSlPDL0UFu9hvSHkxlpXSw6gAHvWZ+HqyEJc6P40ADw
 sLT4M8UMPX+4oTQreo8nD5lNIytEEeWLFxdZBCn3UbfJd4YboG9dDpH9tqMC/dSG0edO
 O8ZQlOvWIexhRWzxw9t2gTKx6XDvxhdT1e4jKHKvZb7aNBs/c4KomLVZSdtIHJYtOyQK
 uT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033167; x=1721637967;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0SzSfEc0SLDVHh1GJe0Fzz1n1p2oM3+UJXhVVnM1uKM=;
 b=HImMHVjXJNdNoUm6iSMtxWGxhuXEgnxLuEUR7di6tQNxCxUgybqt7AftcTX8UQ+3sg
 7xP9W8H2Jgae8ya0ScRbol1uwf3cFPMSAiDnQRi3oWm/rTQekEiUgF9UhpttHnD32Xop
 GCkqAOEh/eDCidPg4+kevurbizQtxBoQ6kRxmVVkuiA/hMEEy98QQxXhKBcwtj1ie33/
 NWTTVNlW+TQGujjAYfnxayFuf2o8N4atd06a59gf64n+rcIb+dGLkU1wjEEo7SGYb9hy
 tAWnNV6H+JsjTq24HA0hKhm3MhG57S398e9phjk+ZhD0IU7M4F31FUP0vlLtn1YZwQGg
 Ilkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnLSwsirDFZaouyH3sSbRU5LLMGCrIBdC80fQmK5YYG5+3D8LhOvIo5h/r2HHtMZi/YGZ3byo16EtZgoE9E8KLzlRpH/E=
X-Gm-Message-State: AOJu0YyN7r9bhZZoEt5RDaOup0l4YLHUW4co0JUW8xQzCJ2VdHXK+7pb
 ZUOBf+B9ZwIfyVF0+wc93ei/gEkzc9HmP2mbj7fnjvC5UgMz2GlBH0PEyLEL67qLLurezh7yR9f
 0yzXOWg21kA==
X-Google-Smtp-Source: AGHT+IG2pk0XWFiODdVXCH3m1dD+tWhY1SoheTx2eYfNnAcE0pgm1XQjh6XKF/9ZNzXwaO/lKLw82rAKXlWz5A==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:240a:b0:e03:a2f7:739 with SMTP
 id 3f1490d57ef6-e041b134c1bmr30803276.8.1721033167057; Mon, 15 Jul 2024
 01:46:07 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:17 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-18-smostafa@google.com>
Subject: [PATCH v5 17/18] hw/arm/smmuv3: Support and advertise nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3z-GUZggKCiIQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Everything is in place, consolidate parsing of STE cfg and setting
translation stage.

Advertise nesting if stage requested is "nested".

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d052a2ba24..32b1f4cb75 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -261,6 +261,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
         s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+    } else if (s->stage && !strcmp("nested", s->stage)) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
     } else {
         s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
     }
@@ -425,8 +428,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 
 static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
 {
-    cfg->stage = SMMU_STAGE_2;
-
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
                       "SMMUv3 AArch32 tables not supported\n");
@@ -509,6 +510,27 @@ bad_ste:
     return -EINVAL;
 }
 
+static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
+{
+
+    if (STE_CFG_ABORT(config)) {
+        cfg->aborted = true;
+        return;
+    }
+    if (STE_CFG_BYPASS(config)) {
+        cfg->bypassed = true;
+        return;
+    }
+
+    if (STE_CFG_S1_ENABLED(config)) {
+        cfg->stage = SMMU_STAGE_1;
+    }
+
+    if (STE_CFG_S2_ENABLED(config)) {
+        cfg->stage |= SMMU_STAGE_2;
+    }
+}
+
 /* Returns < 0 in case of invalid STE, 0 otherwise */
 static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
@@ -525,13 +547,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
 
     config = STE_CONFIG(ste);
 
-    if (STE_CFG_ABORT(config)) {
-        cfg->aborted = true;
-        return 0;
-    }
+    decode_ste_config(cfg, config);
 
-    if (STE_CFG_BYPASS(config)) {
-        cfg->bypassed = true;
+    if (cfg->aborted || cfg->bypassed) {
         return 0;
     }
 
@@ -704,7 +722,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
 
     /* we support only those at the moment */
     cfg->aa64 = true;
-    cfg->stage = SMMU_STAGE_1;
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
-- 
2.45.2.993.g49e7a77208-goog


