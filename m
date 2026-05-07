Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68F4CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11j-0004DM-58; Thu, 07 May 2026 11:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11h-00045P-CR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11f-0003xE-O2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so6672325e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169154; x=1778773954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Oz4bj5Nice9THOmF6naZCylbKzTECKP9+AuU7nwypw=;
 b=fliexAXAMbiZ7s+D/qdzKHZADMYL/VlAvutoY5BymdPTW+DdGsaq+NZYTAPa8Y0QwF
 7yHsV++ogo0ZFLZQo//uvb3IDT6Dm1eMB6WpHJj/qorhss+FSjPB1PA54Blu/pWQaMqr
 rSqT7V6HgZvPu2VBO9oG53E4cHOZRhCVcmvDmyHmGY5xSkglZ0BS+b55QboiB0SAZYiG
 fL2Q3SeBCWRFhRA3Cn1udxzcHMiNtoT2IWqxW0jVvVNn8zqLJaP58BPTfGwq0MwdSQPA
 Po/3HPBRq0Ejo7wqIAo8lc0qnf11kJ45wGZoM1M0LhfgJ5YdDvEW770sNUZBN9SejvZZ
 qCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169154; x=1778773954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Oz4bj5Nice9THOmF6naZCylbKzTECKP9+AuU7nwypw=;
 b=WMIH3+AhDQxINUFiuTdLlwN4BgynJ1lBHHbtlX2VquS8v095oJ7OzdjT/MINANE7xP
 eYIuuGtBlfD9pyDIN74A0UzHQvZhIAmpy6PUUpyII0JtV8tScl1Uol651Zoj9kJWpdZW
 NDDzHMuM0a0CWklSgXXx/xj8FCxMTQpsKpfWdNPF972Hq6dTM6TTC5xU5VUH/txIQDMU
 I2JUEhFTGFwk/ps22M4qM5q8CijIiSfT9AF0iNLhjsiV18hBeSMLG/g5YghGHGo53VZv
 qOZmubqEssxVJErHMG3U0IWpZmd76EB8WXG/Aj5ghrVoq2gW5XhCZBWXE8Nb0tuVmbsh
 oHFQ==
X-Gm-Message-State: AOJu0Yw582jUy5bFfnHQFM/FYqWn17tboME3AelM/M/9502aVfL8rwKX
 JXQljdP1q7T/laYnN1mA+XtTlV+X7hfMWcCmupvElaXBe6tdmoJOnpVabQRjS3jkQUUFuyh9xSr
 Z8jMU
X-Gm-Gg: AeBDies/icAVI7t/wksaENawhD6v3ZfWY+eYTOdOgEflQxhgtchdGkmHiFFmsZ8QR1h
 WRyHuyUXmEyJ98vYmjiZom8/l8YhN56mGofuj770q/ZdMPg+BjQvn4PE3bmwnHNMUMLOAa2mdkj
 2CCVnSkVyR9+XJbCm7DPRVP2dk3WNsOOrR70724Cl9xbzaEOWHsK0NnaffrFkzq8g9jsQTzH6Xo
 o1W1Z7yDDwoz6MCvQaaW4h+t3o6uB8kZdz+ImfWIui/l05SPhyxK3lnCWG4H+makl/YDAMF6gB0
 GCXVllNrQIiY1R910FcVpTDVLjnahptiN9Bq/E/5+ktMP4Yp6TbTIQB3BqPAMSEnnm0vPDDy28m
 sGfD8TRq3b+HFxSz9mTR+Vjl7vR4D/X1WuUZ+JbR87kJNuQ2lXYbELEnksOGZ8odJIRcEAEWgNH
 eX+C4VNJ9JiwytoG5LsySmFEDy606X+fc8PiSc7ODMH6Bt1kfLNKgXDXEFkn0DQj0TcpOuwRDab
 e2l8XwcnSLIu4O1hgcHFZsjyjWmW78=
X-Received: by 2002:a05:600d:8408:b0:48a:58e1:6d17 with SMTP id
 5b1f17b1804b1-48e52bd4f17mr102484465e9.20.1778169154128; 
 Thu, 07 May 2026 08:52:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/67] target/arm: GICv5 cpuif: Implement PPI enable register
Date: Thu,  7 May 2026 16:51:26 +0100
Message-ID: <20260507155154.1886557-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the GICv5 register which holds the enable state of PPIs:
ICC_PPI_ENABLER<n>_EL1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-40-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b0fc90a994..9b12b0114b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -606,6 +606,7 @@ typedef struct CPUArchState {
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
         uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
+        uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index ee97d98d7e..09cd56cbfa 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -219,6 +219,12 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, old | value);
 }
 
+static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -334,6 +340,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
+    {   .name = "ICC_PPI_ENABLER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 6,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[0]),
+        .writefn = gic_ppi_enable_write,
+    },
+    {   .name = "ICC_PPI_ENABLER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 7,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[1]),
+        .writefn = gic_ppi_enable_write,
+    },
     {   .name = "ICC_PPI_CPENDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 4,
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


