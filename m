Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5915C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLZ-0006Sw-ET; Mon, 15 Jul 2024 04:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3zOGUZggKCh8NHJNO5A5BJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--smostafa.bounces.google.com>)
 id 1sTHLT-00060Z-TU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:11 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3zOGUZggKCh8NHJNO5A5BJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--smostafa.bounces.google.com>)
 id 1sTHLS-00048G-8U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:07 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-426724679f0so26575775e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033164; x=1721637964; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=s69Mr04NY6qoAF7uIAiGzjwI8ISorJ9nbI/mR7x4wgc=;
 b=WtrMRC7xoygITcuyrTgRNG6J4LNBYBRQqluCCu8fmJAnE3yFsxRR9mHZNdlLLerHm+
 5oejNh7Wq5MZH6ePZOhWok3ORfyzmIDXyhZDgfaZgzigqqq6Q8nakTAMyrTsC1k4vjNf
 xqxXbrUjwkF/VczFQaashy4N9sC+Kbs9LNmsiTStam48AGoKwrfx/STN6pNPI9nhh2TL
 OVK+xiJS6593o5fYTEdCcLDtpz82lHY4/EDxOnv98udlJotBWp4bT/wfR4TZvv/ZHgSG
 TVjS7ID1HbySqNRqw1WpYJYylU1GYqmErNccE8095bQpgfKRASQMHOckTUi1Y8pNIlNE
 E31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033164; x=1721637964;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s69Mr04NY6qoAF7uIAiGzjwI8ISorJ9nbI/mR7x4wgc=;
 b=vxhiC0043lCodddMV4J+Q7CH8tPkNpZLDXLT3dIBKrIxV8lGMDwH/qBbs3isy33GsI
 SXwBhTSLGeFV3y0lFGHwU8r1Plj6S9XxTu8NO/Cz8oo6aLkd9XCpXTFF1y+NJ+Fd82TM
 Xm1dp9JaTYMU7PB86PDEq2ftmf5G1KRrjaLlnb0UTEAc9Rj9M2l9eP0sp2716CO9lyYi
 6PDq5AB30Fr0TdTp6Dmnj+Xr5ZQOvN2QrEl88fIF3AyndOdNqTnMR/Gr8MgPyH/0x175
 xrIKGEoIg+xJBL5txwjZN0hmjCUNWLKKD+OhJnifKpkLD7v+Lh4TryoTNCNm4xVZXUyZ
 jByQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVihWbCCXMeEyE9Dxokd7/oXBR3cjfR2mX25IATzPFP/8D+6T/3Zerr5AqMCJnMlFJs1WJyCdq5w/0U0lSulPFpYGW1ruY=
X-Gm-Message-State: AOJu0Yw9KLdQLBeS/KHOGzqwaTw6brlv6QeKbys+DYvZiMEuFOf0lzVU
 y/2+QBykSiMKEv4St2nvVDw15XW3LDW5W34XoDKtMJChxfJ4mU3fdDEl2IIqwjVICaW0f4a/5Vw
 31F24SRY0cw==
X-Google-Smtp-Source: AGHT+IFlVVm+FGobKoSjPiE9yCTFm1VWz0/8JhGHfsjqZkHW9w42e90RTwYd2hCESfFkWPEy6wfT8rV7WRS07Q==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:6b18:b0:426:627e:46f6 with SMTP
 id 5b1f17b1804b1-427a25f645fmr180675e9.4.1721033164481; Mon, 15 Jul 2024
 01:46:04 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:16 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-17-smostafa@google.com>
Subject: [PATCH v5 16/18] hw/arm/smmuv3: Handle translation faults according
 to SMMUPTWEventInfo
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3zOGUZggKCh8NHJNO5A5BJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x349.google.com
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

Previously, to check if faults are enabled, it was sufficient to check
the current stage of translation and check the corresponding
record_faults flag.

However, with nesting, it is possible for stage-1 (nested) translation
to trigger a stage-2 fault, so we check SMMUPTWEventInfo as it would
have the correct stage set from the page table walk.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 84cd314b33..d052a2ba24 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -34,9 +34,10 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
-#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
-                                 (cfg)->record_faults : \
-                                 (cfg)->s2cfg.record_faults)
+#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
+                                        (cfg)->record_faults) || \
+                                        ((ptw_info).stage == SMMU_STAGE_2 && \
+                                        (cfg)->s2cfg.record_faults))
 
 /**
  * smmuv3_trigger_irq - pulse @irq if enabled and update
@@ -933,7 +934,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr2 = ptw_info.addr;
                 event->u.f_translation.class = class;
@@ -941,7 +942,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
                 event->u.f_addr_size.class = class;
@@ -949,7 +950,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr2 = ptw_info.addr;
                 event->u.f_access.class = class;
@@ -957,7 +958,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr2 = ptw_info.addr;
                 event->u.f_permission.class = class;
-- 
2.45.2.993.g49e7a77208-goog


