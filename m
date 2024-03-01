Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37428C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gS-0006T0-F9; Fri, 01 Mar 2024 13:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gK-0006PU-5Z
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gF-0008KF-PC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:27 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412bb23e5c5so13708415e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317942; x=1709922742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3Hu107iW344nRvBUzZVDNr0+oMATVeZKj7eB9sfDUQ=;
 b=gIpRDTRAz2yB//DGQ5YAGb+i+UOHB/RGIuIqyrm4hmxuX/uHsW9+A2qTaZ4r+6QaiC
 Jmpe1awuIcP8tGSm0Feh3CsbzRONpSPpcfUiDKNPUFWFPNMQf+yGONlPLjyCFMc1Wm01
 TRJst+4lh0kryfydqYb3St3c+tSbyc4MIEgpulc3IMiZRkR1bpcNYyNhqCoKpmYzGpkT
 hZx6JHqOkpTDPyDBSzE38s5iRv1dSZkfK4f9sosP/XcoLGV1Jam99+1OaylthiX3S1me
 +uK9oQJCuiwxO/TI41jMtYYLyIwoSl/yA+QhdQV9ZTCLwyjUTX4MFfvIDFx5xXQGT5uJ
 3IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317942; x=1709922742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3Hu107iW344nRvBUzZVDNr0+oMATVeZKj7eB9sfDUQ=;
 b=k6l4q8/7j15ZJvzKICWONtao+qbF9HRgxGTTpuJm3d6+jYCJJKcXm8japtFXL9pQvR
 /zgfYnHKn0sXrl+Dqtk3yCKUIfy6REF1I2DQ4sYaL4t1EQ9IwCbnFFizd5p540G5sLrb
 cBTKZwlOatZq1SjqJcKNzqSTOD5bLbko8FmIEeuZOAgZrVoQR1oa8ba/I+JlbjpP+MBl
 ZMJkAsTHftVsG7mQ1UNeDGFvkuvpl/YM/4U4tHcXkdX/pHDrM8cEQNabQQORzSjmG7ys
 IabxbMmm2V4ZFVTcNUKFADy15nny79Rb1bVe4TxHmyetNbZxXr0k/+uVwt9mF13sxmco
 yVkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOmgth+f0GL1M4TcIcDvNnqazW8mbfOotQ7pL9torQ8WVwuZOtUSh1WDQWba9jOidGhjFpaquALZBwDJD8Y8ZUYoOfPhQ=
X-Gm-Message-State: AOJu0YwbKn5t+QjXHoNvs/m85XQFJuC/gNtUyaDAcLNCxa7cmyncJqc5
 Zkk1829q0AZ2E8xuEhj9jiemUw37ifUWMqrwGwAH9q4FP3bZgHIkiW8wyQj92Iw=
X-Google-Smtp-Source: AGHT+IEMyhUzMydCiWsZmKoX8F79c0mzD0sZrJ7tZlm4jyRXvFJdFhMqkmVXqsjIH8Ok114zAyFeZA==
X-Received: by 2002:a05:600c:4fcc:b0:412:b8ce:a0f7 with SMTP id
 o12-20020a05600c4fcc00b00412b8cea0f7mr3095242wmq.5.1709317942482; 
 Fri, 01 Mar 2024 10:32:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 3/8] target/arm: use FIELD macro for CNTHCTL bit definitions
Date: Fri,  1 Mar 2024 18:32:14 +0000
Message-Id: <20240301183219.2424889-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We prefer the FIELD macro over ad-hoc #defines for register bits;
switch CNTHCTL to that style before we add any more bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 19 +++++++++++++++++--
 target/arm/helper.c    |  9 ++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c93acb270cc..6553e414934 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -224,8 +224,23 @@ FIELD(VTCR, SL2, 33, 1)
 #define HSTR_TTEE (1 << 16)
 #define HSTR_TJDBX (1 << 17)
 
-#define CNTHCTL_CNTVMASK      (1 << 18)
-#define CNTHCTL_CNTPMASK      (1 << 19)
+FIELD(CNTHCTL, EL0PCTEN, 0, 1)
+FIELD(CNTHCTL, EL0VCTEN, 1, 1)
+FIELD(CNTHCTL, EVNTEN, 2, 1)
+FIELD(CNTHCTL, EVNTDIR, 3, 1)
+FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTHCTL, EL0VTEN, 8, 1)
+FIELD(CNTHCTL, EL0PTEN, 9, 1)
+FIELD(CNTHCTL, EL1PCTEN, 10, 1)
+FIELD(CNTHCTL, EL1PTEN, 11, 1)
+FIELD(CNTHCTL, ECV, 12, 1)
+FIELD(CNTHCTL, EL1TVT, 13, 1)
+FIELD(CNTHCTL, EL1TVCT, 14, 1)
+FIELD(CNTHCTL, EL1NVPCT, 15, 1)
+FIELD(CNTHCTL, EL1NVVCT, 16, 1)
+FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTHCTL, CNTVMASK, 18, 1)
+FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 978df6f2823..1c82d12a883 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2652,8 +2652,8 @@ static void gt_update_irq(ARMCPU *cpu, int timeridx)
      * It is RES0 in Secure and NonSecure state.
      */
     if ((ss == ARMSS_Root || ss == ARMSS_Realm) &&
-        ((timeridx == GTIMER_VIRT && (cnthctl & CNTHCTL_CNTVMASK)) ||
-         (timeridx == GTIMER_PHYS && (cnthctl & CNTHCTL_CNTPMASK)))) {
+        ((timeridx == GTIMER_VIRT && (cnthctl & R_CNTHCTL_CNTVMASK_MASK)) ||
+         (timeridx == GTIMER_PHYS && (cnthctl & R_CNTHCTL_CNTPMASK_MASK)))) {
         irqstate = 0;
     }
 
@@ -2968,12 +2968,11 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
     uint32_t oldval = env->cp15.cnthctl_el2;
-
     raw_write(env, ri, value);
 
-    if ((oldval ^ value) & CNTHCTL_CNTVMASK) {
+    if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
         gt_update_irq(cpu, GTIMER_VIRT);
-    } else if ((oldval ^ value) & CNTHCTL_CNTPMASK) {
+    } else if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
 }
-- 
2.34.1


