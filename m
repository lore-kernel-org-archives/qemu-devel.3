Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82881C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRuw-00023N-2D; Sun, 04 May 2025 01:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRus-00020Y-Co
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuq-0004I0-CS
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso4662820b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336566; x=1746941366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48VeJmtQLPOhxBVuGtRwfY5ps2vP+Hg73z2yA0rcj8A=;
 b=d3bIaTZG22g+5Aoaiox2TIuq1k/rss64CVkIj2nwSc2mRTUZ4reumLCay9JoRPEVoF
 n/2h3k7Td8+FnQVmmIorRpORumKMUvYsOHnjHLAjFA0sx+r45DvQEoFhWM3uURYjVocH
 iXVlcawswt6M8dUBkGAK/u0jv5gpYt7qhfpwiKLZHG+X/vvcvA/dJp+cBdwlr4l3tZPR
 4FC2RUhdsLEAok3tiIPBAgMjkj0JPvNzfd3q3bE0ZOk0OzxBKndC6oRpG1wDWX5nAByw
 bEMy/NacDUerA0gSGSlu1783Supa3xcdy+TaoIG3xxV9ec/YqzUiT0Sjgp9PsruK1L3F
 satw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336566; x=1746941366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48VeJmtQLPOhxBVuGtRwfY5ps2vP+Hg73z2yA0rcj8A=;
 b=p8DwJVB0Bp43ENK6xPqgDZaHVgNfZE/BSMY7G5JuSj2DRqSmMuXyIPIBt9Moz+BBJX
 9H/F27fBifuvXwdZNRvzxdIRkzL65PAdQ8EPQ0t9AnkZlMma/dpkQOWt4LfeVkTI5Vp2
 XDY+KcZ9UTOtKQUns7TJEgCDv183H0NEaIgYm8M8fYOx/OhORKQNC0NcMVsGoDhinu4R
 1SLa43/SlskVTmC6MvoW07XwOXu8viKci7QUq059fXB+gRgKkM10T67Vlko4BtnAs0cw
 ZNsZ0/UQJBPxzT9/edH/B5LJPL/VgnT+MiJwaF8A5dIC3SNlEqz5fOEHb8BEMfjjfHml
 xIpw==
X-Gm-Message-State: AOJu0YzsDhzN2RL0S81t5Ll2TyHYY/lX4tEZsPp0sxhkp2nFfg8U21JV
 PhtyZxgAhMtK/4gYm3LJX03iWiIBHNaQXtOsebowMp01gcXNUqK1ShEgXaRVZcgjZ10fOEnAtoz
 lkSU=
X-Gm-Gg: ASbGncuEVbTTPDNNVY4ITxRVLm6FBNZ7yFLU8xAXlJg1r/dJaxvFuAttNaACsudePIS
 KAJlhALtiFSbl+FaEaEnLYZCF7PYYvQl/inHLGC8VS09kwbEKPXsHqcBDQDHQbbmF/KG/CacIz0
 PkM82rplKqBDXPHBZ60Nfw39qUwDDeJ6xWPOUaPZiVgi2P/A2JDDy3pWBPZcoozJZ5pK4HEJn5z
 n9CXpjZZakv5Z7Jumt+PJ6e2hr+MmLmQ6RSTNS1EUGnCGPhaQovGI5FpvJTomrID0ytS/EshbAY
 F7enetoy8ehvk3C6am87yBy1HgdnLxV2H5IIwtk7
X-Google-Smtp-Source: AGHT+IEGCJ8bOHzgy9WrMpyjAziCFb1lEAaArfWX0xV8zNipX1Q0lcIdis5LRQByYZG4ALdALvRpJg==
X-Received: by 2002:aa7:9306:0:b0:73e:1e21:b653 with SMTP id
 d2e1a72fcca58-740672b165dmr5420738b3a.5.1746336566670; 
 Sat, 03 May 2025 22:29:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 07/40] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Date: Sat,  3 May 2025 22:28:41 -0700
Message-ID: <20250504052914.3525365-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow to get rid of CONFIG_KVM in target/arm/cpu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h  |  2 ++
 target/arm/cpu.c      | 31 -------------------------------
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 7b9c7c4a148..d156c790b66 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -221,4 +221,6 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5e951675c60..07f279fec8c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1099,37 +1099,6 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
-{
-#ifdef CONFIG_KVM
-    ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-    uint32_t linestate_bit;
-    int irq_id;
-
-    switch (irq) {
-    case ARM_CPU_IRQ:
-        irq_id = KVM_ARM_IRQ_CPU_IRQ;
-        linestate_bit = CPU_INTERRUPT_HARD;
-        break;
-    case ARM_CPU_FIQ:
-        irq_id = KVM_ARM_IRQ_CPU_FIQ;
-        linestate_bit = CPU_INTERRUPT_FIQ;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (level) {
-        env->irq_line_state |= linestate_bit;
-    } else {
-        env->irq_line_state &= ~linestate_bit;
-    }
-    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
-#endif
-}
-
 static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index e34d3f5e6b4..4806365cdc5 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -104,3 +104,8 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 97de8c7e939..8f68aa10298 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2468,3 +2468,32 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
         cpu->kvm_mte = true;
     }
 }
+
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
+{
+    ARMCPU *cpu = arm_cpu;
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    uint32_t linestate_bit;
+    int irq_id;
+
+    switch (irq) {
+    case ARM_CPU_IRQ:
+        irq_id = KVM_ARM_IRQ_CPU_IRQ;
+        linestate_bit = CPU_INTERRUPT_HARD;
+        break;
+    case ARM_CPU_FIQ:
+        irq_id = KVM_ARM_IRQ_CPU_FIQ;
+        linestate_bit = CPU_INTERRUPT_FIQ;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (level) {
+        env->irq_line_state |= linestate_bit;
+    } else {
+        env->irq_line_state &= ~linestate_bit;
+    }
+    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
+}
-- 
2.47.2


