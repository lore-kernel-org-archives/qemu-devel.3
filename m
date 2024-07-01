Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF080C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEqS-0004Ew-4a; Mon, 01 Jul 2024 07:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Eo2CZggKCnEhbdhiPUPVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--smostafa.bounces.google.com>)
 id 1sOEpi-0002dp-9I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:34 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Eo2CZggKCnEhbdhiPUPVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--smostafa.bounces.google.com>)
 id 1sOEpc-0005Sx-5a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:29 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e03623b24ddso4976952276.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831826; x=1720436626; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=sNbHX8nqDYpOLRvymfwhnJH75L2FVhdf8IpttBXPNL4=;
 b=a4W1dbbiGXvF84siVjDpEpHZl74hosbUxjUgZ5A3X90Wkjpf0kcLqZvWDziURRaU/V
 mhApaGx+9okOpnsKqlgiRVIbwj3xRfYC6bVhf10AB5FhFMAQNJn23kNJVVM8mcR7PiUD
 /pktXZxMi7YNdXjWTQU4uFF1LF3sRiKcuSVFaEPggexeBO8pUdI9gKTTYK0CQso5BeXc
 WF87lgrDW8aWqh/WerDfc6BThIm3VbMwpJ7DMjeW1jT3e5V4oEUkxcsSHYkxzm11DAgA
 dkC4Emf1Rhr2V/VksJiuIHW7ovYN/uUZCcA23dLwbb1Y1aKd2Vm93A/yYuRuP1NhTcSc
 KpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831826; x=1720436626;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sNbHX8nqDYpOLRvymfwhnJH75L2FVhdf8IpttBXPNL4=;
 b=oNrjcjaPuVZ+aKk4Lr20jqSyYCJqh3P06DWxVciutc4eWYC/8ENwd/AswQRyTKw8hS
 Oul2GGdEvPVeQejULSdld+f1mz4bg0J0zMqbejjrSLGh8X23PQL3WriHOHS1v5f0QJ93
 5MUbbOxOe6d23imfUht+X62dOY8Oe2IdyfZLsYc4EwDA5DHm0mGEgAvF6/0hr/kiHPD4
 Ph+Pf99gPSZCeBSko2oYOS5feuQ0d9o2KfsOZNr4FAxXIhUR76KrOxgmBqRs2H7lUJZp
 ZXd58YBwlFjOFl6VTcvirJgCO5cCw8fMXHpw2EXfeJUnO9EqveMN4dUaMhrxdxaZBH4C
 QRbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS6dbJi+i5TgAR/fFGWcEyZ/+dr7LhYa8qKhEJac4OD0Z3OwO7U8AtLMOQVWHVatqKPt1xuFPWC+lFOAyaGTYmY72Jo/c=
X-Gm-Message-State: AOJu0YwqKA+PiYHTQOt6p7i+/r32T+EwovOY1TGca3ROaOjp8gcxL0mo
 cCTSpJQa5VBcmFuNreqUbC9lTqfrf7YsM6tmkRO6xvaTjShwKdipYkzRiduKIP4K0NJcUTE2MaI
 oan+ajQN6gg==
X-Google-Smtp-Source: AGHT+IG9LUycpUctA+hUPQMuLbv0IwlMNM88J6rS7LprZNCXDvKBB2hWGR8rlIoR8I6PGZDwkYIWTuhS/ZMyzg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:dbd3:0:b0:e03:60b4:b7a with SMTP id
 3f1490d57ef6-e036eb22e40mr249373276.6.1719831826547; Mon, 01 Jul 2024
 04:03:46 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:39 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-18-smostafa@google.com>
Subject: [PATCH v4 17/19] hw/arm/smmuv3: Support and advertise nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3Eo2CZggKCnEhbdhiPUPVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

Everything is in place, consolidate parsing of STE cfg and setting
translation stage.

Advertise nesting if stage requested is "nested".

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6c18dc0acf..807f26f2da 100644
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
2.45.2.803.g4e1b14247a-goog


