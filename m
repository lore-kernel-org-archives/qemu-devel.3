Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E9EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnF-0004uE-Ca; Thu, 15 May 2025 06:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn6-0004Zu-RM
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn3-0008A7-DV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso8443035e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304772; x=1747909572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FaYh3VlkdCKvRFw8QcW3CmdcVFOTvth6Gi2E4GKc2o0=;
 b=SoGHyxcdaYad3YIv8OXhwph8u+Uhm5dQp5ivoC0mvcAFqVy4HREf3OZec+OzG+zEnM
 +a4Yh2WdauFc4MF6tNq0fO5Lm0rC6SATWgOaJQxugpzst5av7mdvduDtWKR8DdKMyL6V
 gUTITw+UAxwTyXJaZ0FV9qDdm2s2dbLjlo1Voi7iqBocQBcfjoBs4r40Jk6MnChrZOp5
 b+P/a3FSMLjgR7ln4My99+swe4Nrk8GYnQC5V8zl0a9hjDT7VbPJ7P2XBmJ7U0BM4eg1
 C5cOCLgdcatyvzof5L8hzm81sDZy6wue2b5vMo93fcrxTUcQ/m4pkxzDw8fOnTXKK5Bh
 NJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304772; x=1747909572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FaYh3VlkdCKvRFw8QcW3CmdcVFOTvth6Gi2E4GKc2o0=;
 b=L6IpuxRCUeFMGeMoebrr48EFgcCz3RH8RcNVDutCoBddOYbhR06Y22OXF7sQgw1nzo
 HrZLMG2hjn7N2R1QP21XKiKDjCG1EZj43l+so+wPgey4CxC4Hs2CvWW/79LWY7Y5I/bu
 3DmwgJfchF8mP5Sg7Q//tLK4+kd0hH77tG9ZUDfQEnhYDdarMuon2iw//+7tiuQHTIkw
 U7ZCNy88naS+twdPjjo6F0uOcOdBZZOzQHWmMeYoPfUFt5xx8N89kIwaMOKSO2ICiRBK
 q+g72DuJ0wEAZ9hFNeNxnHO6+VPPMQgyJh/jElxP7nAIXemcvibDbdRWgS+xXQ9DkiBI
 yjkw==
X-Gm-Message-State: AOJu0Yzn2n2oAl/qhaBxpfweMFH7c9RiGGOF2X6OEmLAZM5YhDT7SC2B
 vaLEYwkeyIu0k7lALq0F1dTSUGmdewSbjZkPoy1NrZBoVFz8Guc87xmdCyWnsWJK3c9JzzEjbc9
 /iCg=
X-Gm-Gg: ASbGncvNzTYlC7lwW454UwbtEDKOno3H7b7g1JsJxGKZKz67odNDwBbLNmad+yAdoIj
 Ud39YLmbTKFm4l/ui44ay/dHxfVHkXMPRzXoFrRwFA1sCj7tVYRnfcbzlevrBs5kGcX10fGFXeu
 qFCS1mBDIZYorJ5AMqpnD5438ABdSSELtcJuzAFAZ7cxKpwBdWjbwtoCWMPyQHOTtaRXFxsXxg7
 rUcHjDydRxLVlX0B1S5pjAtESa3+/4u6Sm6lvcNJ8Fr6Yplc5i+uSS3g9TixLDW7UmHerxqzbcq
 C9Cy+T712lm97yJnl7tS1p7Sr+SNRvwK7U0qb/IScTBfjMACvOUSMINzVw==
X-Google-Smtp-Source: AGHT+IHmftD+xzsMbG/Jkyt9an0Ksi6TPsxijDqvYl8g3N8P0FMFBum89vWX9qjJ9GxI0uYxYMf2Fw==
X-Received: by 2002:a05:600c:540f:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-442f96e88damr23789105e9.10.1747304771617; 
 Thu, 15 May 2025 03:26:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/58] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Date: Thu, 15 May 2025 11:25:04 +0100
Message-ID: <20250515102546.2149601-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allow to get rid of CONFIG_KVM in target/arm/cpu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-7-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h  |  2 ++
 target/arm/cpu.c      | 31 -------------------------------
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 5bf5d56648f..b638e09a687 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -216,4 +216,6 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 603f08d05a0..66047693415 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1098,37 +1098,6 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
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
index 85911e30242..82668d64385 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2428,3 +2428,32 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
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
2.43.0


