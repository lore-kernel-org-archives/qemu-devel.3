Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0ACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqIc-0000cq-ME; Wed, 03 Jun 2026 14:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIS-0000Y8-FJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIP-0003Zw-N7
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so688640f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780511188; x=1781115988; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9RYFdzZI9nhf0uIHPze27sdjwQc/3jiSP/AQ6IK1uAY=;
 b=AhPdDWGoN6dq433xggT82d2uLceu87ELOD//9AQdsHeH1aWUjyAVWPMY83cFJTfcci
 u/ivy6rC7XPmIuW33Wh4lNqGLX2ucI/mKm0RXYnmBbpwSp9Da/C3XtmNXvctY7gdfl0s
 D7lKhuP0+7snlU1Q6pMpRsyiyF0TysgfAdi0UjT9FlVh77iPkUj0F5MtmIIHxk+tA8e5
 vmYxUkKaSxwJgXSN3pS+Nd2UsmZHRw0HqqoeRhXybKMivAacwdQCYXd/2yMlI2wrw6Pr
 b9pHXub1BnTIwGjWILON5l1OyCjUu+/yLt+D8tCPlMu+7Ux71Zp+CbXKApoVjByJEGXJ
 4afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511188; x=1781115988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9RYFdzZI9nhf0uIHPze27sdjwQc/3jiSP/AQ6IK1uAY=;
 b=gZMiazuz9ezK+Pgseuz30B4lLzyl85z8W93EzXWLQC/htkKZf9/hm5f3k8DIhhnY6n
 giBMSgObg6oKQR37B+EoIEKODFumh2vYzFC2QT5HNqmEi0mNMF/Jjvc9R1RdWMQJW+EF
 EVQot7vIxaiuLWoNj3pgKu3UER8aEX2tmXH2+8kHU5KA3IJfKuiDLpOIgyMVCFQo/xyb
 J92c91FCDSpHywUqU++6xUnbvHug9NumdlHhGWxJw4JpCz0oDCirJPTvxKUpuj6jJ1dY
 RdE0Xo8yUosr+6xT28COVjaYv0HRScGxpauEprYAMSccdfSlU4oDhhkCF74MKFhaJYeL
 EhCg==
X-Gm-Message-State: AOJu0YwPPLjoQTOGLKVknztPrC36QZhMcpD/qMFJ9BOy5XHrWfWWaVFX
 vHmPqBakXFpYNkKlN+OaHePl7pheAfl+C9giZZtmg1tzQozToa6HiUpp6xwPnV1w/49WEyLCMtY
 f/koxJJc=
X-Gm-Gg: Acq92OGJfNw1jehZzXan/1Rs+xs8tM0WdrCzSFzCCmAL8eZ2qDNr0W9wteQqP2Qpi11
 ghtuUtYT/SBEItjwgi6RKArLg3TJA2rPxh51lcsDD80vUYm4wX3aT7jzoLFDTaE4UUp6ZKTfdVF
 Zni0IDPA/koGdlcJqwLgVGsVvmA2OA+FOTs79MVLDWT4CI7dWbgRIrX8eKUmgwJc1/1JrlkBjR2
 vLO3KYgKBWkf/GjfLciemcvuGFr+YET6pJ9r/X74BTCGdxgCW0AJ/vnkOceCpjdqxXxGbhLJthh
 b1IeEaHfx9Hm3syHRm9ob+crFtower/fTMfPtACPycE3DytSQDbfqECkcxp+ioMzeR5OVfgQo9F
 qhWY2K+NuOVytbUmZ/4lIx/+qmpFlYEE5rcSY0KI3iLHIW0EXNAbbu26QUXnar0XAJiwNkQLB6Z
 ZY5lCT+Xucf59Y48bS7F84OX0cBUp7+5yVnJrCQlw8X4JhJLwb
X-Received: by 2002:a05:6000:2082:b0:460:1c93:6eb6 with SMTP id
 ffacd0b85a97d-4602743465dmr802286f8f.20.1780511188154; 
 Wed, 03 Jun 2026 11:26:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d530:6a6b:58a7:e220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm9793127f8f.13.2026.06.03.11.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:26:27 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 03 Jun 2026 19:26:22 +0100
Subject: [PATCH v2 3/6] target/arm/ptw.c: Add Granule Bypass Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-jmac-gpc3b-v2-3-115c51936962@linaro.org>
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
In-Reply-To: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/ptw.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0a5201763a..e4cc415ce5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -341,11 +341,22 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         .space = ARMSS_Root,
     };
     const uint64_t gpccr = config.gpccr;
+    const uint64_t gpcbw = config.gpcbw;
     unsigned pps, pgs, l0gptsz, level = 0;
     uint64_t tableaddr, pps_mask, align, entry, index;
     MemTxResult result;
     int gpi;
 
+    const uint64_t BW_ADDR_SHIFT = 30;
+    const uint64_t BW_SIZE_SHIFT = 30;
+    const uint64_t BW_STRIDE_SHIFT = 40;
+
+    uint64_t bw_size_field = FIELD_EX64(gpcbw, GPCBW, BWSIZE);
+    uint64_t bw_stride_field = FIELD_EX64(gpcbw, GPCBW, BWSTRIDE);
+    uint64_t bw_addr = FIELD_EX64(gpcbw, GPCBW, BWADDR) << BW_ADDR_SHIFT;
+    uint64_t bw_size = 0;
+    uint64_t bw_stride = 0;
+
     /*
      * We assume Granule Protection Check is enabled when
      * calling this function (GPCCR.GPC == 1).
@@ -397,6 +408,58 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         goto fault_walk;
     }
 
+    /* At this point, GPCCR_EL3 is valid */
+
+    /*
+     * GPC Priority 1 (R_GMGRR):
+     * If GPCCR_EL3.GPCBW is 1 and the configuration GPCBW
+     * is invalid, the access fails as GPT walk fault at level 0.
+     */
+    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
+        /* BWSIZE, BWSTRIDE have a limited number of acceptable values. */
+        switch (bw_size_field) {
+        case 0b000:
+        case 0b001:
+        case 0b010:
+        case 0b100:
+        case 0b110:
+            bw_size = 1ULL << (bw_size_field + BW_SIZE_SHIFT);
+            break;
+        default: /* Reserved value */
+            goto fault_walk;
+        }
+        switch (bw_stride_field) {
+        case 0b00000:
+        case 0b00010:
+        case 0b00100:
+        case 0b00110:
+        case 0b00111:
+        case 0b01000:
+        case 0b01001:
+        case 0b01010:
+        case 0b10000:
+            bw_stride = 1ULL << (bw_stride_field + BW_STRIDE_SHIFT);
+            break;
+        default: /* Reserved value */
+            goto fault_walk;
+        }
+        /*
+         * GPCBW is invalid if the base address is:
+         * not aligned to the size programmed in BWSIZE, or
+         * greater than or equal to the stride value configured by BWSTRIDE.
+         */
+        uint64_t bw_size_mask = MAKE_64BIT_MASK(0, bw_size_field +
+                                                BW_SIZE_SHIFT);
+
+        if (bw_addr & bw_size_mask) {
+            goto fault_walk;
+        }
+
+        if (bw_addr >= bw_stride) {
+            goto fault_walk;
+        }
+    }
+
     /* Note this field is read-only and fixed at reset. */
     l0gptsz = 30 + FIELD_EX64(gpccr, GPCCR, L0GPTSZ);
 
@@ -431,6 +494,23 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         goto fault_fail;
     }
 
+    /*
+     * Bypass window check.
+     * I_JJLRM: Granule Protection Table (GPT) lookups can be skipped
+     * in portions of the memory map by using GPC bypass windows.
+     * I_XNHTX: The GPC bypass window check (...) is performed
+     * immediately after priority 3.
+     */
+    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
+        uint64_t bw_stride_mask = MAKE_64BIT_MASK(0, bw_stride);
+        uint64_t effective_address = paddress & bw_stride_mask;
+
+        if (effective_address >= bw_addr &&
+            effective_address < bw_addr + bw_size) {
+            return true;
+        }
+    }
+
     /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
     tableaddr = config.gptbr << 12;
     if (tableaddr & ~pps_mask) {
@@ -3817,6 +3897,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
         };
         struct ARMGranuleProtectionConfig config = {
             .gpccr = env->cp15.gpccr_el3,
+            .gpcbw = env->cp15.gpcbw_el3,
             .gptbr = env->cp15.gptbr_el3,
             .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
             .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),

-- 
2.43.0


