Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DEBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOErV-0006jq-JI; Mon, 01 Jul 2024 07:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EI2CZggKCm8fZbfgNSNTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--smostafa.bounces.google.com>)
 id 1sOEpo-0002ky-II
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:42 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EI2CZggKCm8fZbfgNSNTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--smostafa.bounces.google.com>)
 id 1sOEpb-0005Sm-Db
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:36 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4258675a4f9so3380685e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831824; x=1720436624; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nrrOdBSglOcwc85QEPbyeeoGCPengTnNdMy+0E35hk8=;
 b=mdNkf/PDSOaIxpBHvVatfvaoEE3h0eW67Uk9wV2ND8pIQlDU322QpV9kMeb0S74+30
 hxy7ZLVSTJfu77si6rrDdT0MgfIFCvcNrUNbDuJGIjJ4BdEvRQ8o8KLeJsi2ggFwcYun
 r9d4+103axhAzHXWmq1rqfmfiMeNAHPxLva97QuSUrXBUdire2wb8189UINoRTa40eX1
 cU3cFPw6F1s2tupPz7uShQGKxq9hvJEbxuk0YZEtgCt2YWRbTVfNPF7Zi6NEkCmPRoN2
 htf7g1oQ5l9wz4bcZlvlg3IBnTisj0KQbEg75xoD23SkjbzuuUzUtVe4iKOUUlCt7dia
 VXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831824; x=1720436624;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nrrOdBSglOcwc85QEPbyeeoGCPengTnNdMy+0E35hk8=;
 b=OfdryBV0uP8oXD4e4n+khDzPce+ZQ1WrI9kDUW1J3VDOq76KJClATFoM1xoiPMB9I+
 cAtHkdNtNvDSzRlA5AG/tQdfXgKXPR1zipL5oOddgc9lk1CYQN+KiZFVN1+zFHOxne6y
 pJrJrVctLTC7A4wU+x4Bov++Adir/PEIeqntbKdLiy5oewSSKx+nkR9NTAFaBNtGURkw
 j4RBlhl+4cYHBq9nPKEoyQ4r3qqAW3tHmpAdkIUnK27OnuYOi4ig+GZFjIM+6RkmJa8k
 TJYnDyMinMEGIkftRfSZr6l8dSTgWy9NVd0XGMPL9yKgeKCBqS1uXmFt3MXM5nynhGN4
 ddhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl6gKDDckn0qWWtRKvyC6s4G2aTMMaDKKSZ9jAJkZ6iuAqjH1ApYCOVFP2gsemZ7LY+MX5AKMvYTOYIZilZdYRJEg0vDI=
X-Gm-Message-State: AOJu0YxG9S8FmK0uCSkfXjBvOj0nM52uwJytehfRN/LtUTIAE63JrJ8D
 Ofx5jdiJkQO1uPMeZiCsRV4sKjGAkzxCA/3LJXT5wWCzRFNK9PNukRCRennOezw4WdTQNuVrEg0
 vJTyuWotkkQ==
X-Google-Smtp-Source: AGHT+IFr9vjH7vIkUsu0vMpKSKV1Di9Zz2iiIrHiCMq1gFCJkl4CaaVXQVd9oV7aCNRCTvsFXBNDWPD8zOZh1w==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:4f06:b0:425:7ac6:96f5 with SMTP
 id 5b1f17b1804b1-4257ac698dbmr244115e9.0.1719831824275; Mon, 01 Jul 2024
 04:03:44 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:38 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-17-smostafa@google.com>
Subject: [PATCH v4 16/19] hw/arm/smmuv3: Handle translation faults according
 to SMMUPTWEventInfo
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3EI2CZggKCm8fZbfgNSNTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 36eb6f514a..6c18dc0acf 100644
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
@@ -919,7 +920,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr = addr;
                 event->u.f_translation.addr2 = ptw_info.addr;
@@ -928,7 +929,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
@@ -937,7 +938,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr = addr;
                 event->u.f_access.addr2 = ptw_info.addr;
@@ -946,7 +947,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr = addr;
                 event->u.f_permission.addr2 = ptw_info.addr;
-- 
2.45.2.803.g4e1b14247a-goog


