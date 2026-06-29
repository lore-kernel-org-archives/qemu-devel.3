Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30665C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgA-00079D-RT; Mon, 29 Jun 2026 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfj-0006wg-95
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAff-0007QG-RY
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c0c15bd6b8fso327931666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734459; x=1783339259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NE0FUuP3qSW1y1JInNt898EU0WBaDbtQtzuimcKJcCA=;
 b=vCGUqz55TsXWaczdLEvpe5WBnhjv++Cbsr6VhNEQr32v5OI8/k18g2mJQwWWJ5LrM+
 uAcAa2/ovrmsG64a3J8qSHiGF9fDMrSwd2NJQsH3LAz54ywhXy8TUf2iCPyIiEoNMtnx
 bfnpOub2mdXEN013ftRyU+1pMpjUnTsWGUC2dqlryyMF7K6cPUzlG5TDBICB1MRIuySs
 j9vThUsFgHUxAn9nWeNOMVqBWOEFRO6K2rhJ/tZoeewGMAGBeeCngKhFDzPuYlO1LB8V
 O3QFeglqDyEDfkjukqDykya4iUAdVdOSZ2hVxdGtphoavpLvmhlQWg5Bk/9Tlz0U5Mwc
 1/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734459; x=1783339259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NE0FUuP3qSW1y1JInNt898EU0WBaDbtQtzuimcKJcCA=;
 b=ptnC0r2Yf2RaEsPGTgkZKE9YFNPAP34N6L5RgvLAJJdg1E+Q6C4EQHeCfZe+t4M84n
 UXra4DtpBioynEVLO780FOrX5KwYNr85EA94Par+OXl6K4TMnUSBIIaqwt5wbMySXc9V
 FnbYJJd6rkJfk8Ed87xyOLxfl74r+fM8J3gAI9LJo04a7/EObsOOLXyF+AWOU2+SrSUU
 yh407s1njeiYaaAghmT/norCIWOZCATAUlpqeGgSHeYNHrEwxd+EJuCyhph/+a7ArC97
 DCqTA9rqBTOCLjns+ahAt6BwUkglaetnou0Z3aSZA/NqCWZQY8raTKimNofsXKDkkliD
 NRmA==
X-Gm-Message-State: AOJu0YzQWzCRh0o14eKZeAO55JUP51GvD/3AO+TN3KbkaOVTRZHD9j92
 adWVXYN7HHlXI8u20Tzni9PdiauzgWHhqtMkHp5c4CTNt2n1JdkeF1JXidly/pqiB40l3GcS55M
 BFsX5
X-Gm-Gg: AfdE7ckP4ODVZfJHmNmdIfW54FPBq/cCl/VuZD3K7LtK27xy03FYMYhkUGhTNE1Crk3
 Dsn2C+YDf0mOPSWcXub2A54hvsdZZwx5of+6Y2lluPnfN/NLVT12z/UHJ/klENx8pPi3SteMWC3
 YSuIsas8mkog9sdoQCCfDlKTP2cVGFEiwKFAr10ha90BSwpVqgz3ig7SZRGhHABvuqkKnSPUSqk
 74ZEOqbEhKlUjvehi4SIzJ4yHA3Kssgjqvks4/e+BTreFoNNvsoAz1kVYXT/jUinhNNrUpmEViS
 zX2agVjC01Ui3nCs45R0tFSvjsofsPVDb/ByX86MZj0gIfqrQOpI1DwHz+zyQMNGNkbk+hX5W91
 m8b8NVlqIGjMclvuGG68tfn91O4RNodIwHqZ+y1++BpAUPbzyQoynWPTJ57tI2hyY8anm3oLlA5
 d1fWZ1DQetfYt1pxFBm8+3hQg7G+f92456iOt2E6esZQLWhczjl15Ydia4MxM4EwRJk6nMli2Ia
 NGpJHctskAW4ULTQQRfNA==
X-Received: by 2002:a17:907:1c84:b0:c12:6f47:1d30 with SMTP id
 a640c23a62f3a-c126f471e3bmr108812166b.65.1782734459218; 
 Mon, 29 Jun 2026 05:00:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/54] hw/intc/gicv5: Define and use GICV5_PENDING_IRQ_NONE
Date: Mon, 29 Jun 2026 13:00:02 +0100
Message-ID: <20260629120032.1645265-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

The GICv5PendingIrq struct representation of "there is no pending
interrupt" sets the prio field to PRIO_IDLE, and generally to avoid
confusion we also set the intid to 0.  We want to return this value
or initialize some variable to it in several places in the GICv5
implementation, and the support for the virtual interrupt domain
introduces more.

Define a convenience macro for this special-case struct value, and
use it instead of opencoding either the structure initializer or
explicit assignment to the two fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260615105029.2898872-6-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c               | 6 ++----
 include/hw/intc/arm_gicv5_types.h | 4 ++++
 target/arm/tcg/gicv5-cpuif.c      | 7 +++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 0fa3d6b601..08878193df 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -429,8 +429,7 @@ static void irs_recalc_hppi(GICv5 *s, GICv5Domain domain, uint32_t iaffid)
     ARMCPU *cpu = cpuidx >= 0 ? cs->cpus[cpuidx] : NULL;
     GICv5PendingIrq best;
 
-    best.intid = 0;
-    best.prio = PRIO_IDLE;
+    best = GICV5_PENDING_IRQ_NONE;
 
     if (!cpu) {
         /* Nothing happens for iaffids targeting nonexistent CPUs */
@@ -526,8 +525,7 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
     GICv5Common *cs = ARM_GICV5_COMMON(s);
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        s->hppi[domain][i].intid = 0;
-        s->hppi[domain][i].prio = PRIO_IDLE;
+        s->hppi[domain][i] = GICV5_PENDING_IRQ_NONE;
         gicv5_forward_interrupt(cs->cpus[i], domain);
     }
 }
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index de4f78a149..851286b1b5 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -105,6 +105,10 @@ typedef struct GICv5PendingIrq {
     uint8_t prio;
 } GICv5PendingIrq;
 
+/* A GICv5PendingIrq struct initializer for "no pending interrupt" */
+#define GICV5_PENDING_IRQ_NONE \
+    ((GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE })
+
 /* Fields in a generic 32-bit INTID, per R_TJPHS */
 FIELD(INTID, ID, 0, 24)
 FIELD(INTID, TYPE, 29, 3)
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index a868adca66..1cdd4103d0 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -144,7 +144,7 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
 
     if (!(env->gicv5_cpuif.icc_cr0[domain] & R_ICC_CR0_EN_MASK)) {
         /* If cpuif is disabled there is no HPPI */
-        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
+        return GICV5_PENDING_IRQ_NONE;
     }
 
     irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5_iaffid);
@@ -168,7 +168,7 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
     if (best.prio == PRIO_IDLE ||
         best.prio > env->gicv5_cpuif.icc_pcr[domain] ||
         best.prio >= gic_running_prio(env, domain)) {
-        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
+        return GICV5_PENDING_IRQ_NONE;
     }
     return best;
 }
@@ -258,8 +258,7 @@ static void gic_recalc_ppi_hppi(CPUARMState *env)
      * enabled, pending and not active.
      */
     for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_hppi); i++) {
-        env->gicv5_cpuif.ppi_hppi[i].intid = 0;
-        env->gicv5_cpuif.ppi_hppi[i].prio = PRIO_IDLE;
+        env->gicv5_cpuif.ppi_hppi[i] = GICV5_PENDING_IRQ_NONE;
     };
 
     for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_active); i++) {
-- 
2.43.0


