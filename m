Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E665C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tx-0002K9-CD; Wed, 30 Apr 2025 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tn-0002Cb-7i
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:59 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tl-0002fI-4z
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so7127533a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025136; x=1746629936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX/hJH1gLLVfS0bwh/LZYqdKvfx19Rxb8RxfxI3LnbE=;
 b=q5R8dlZ0mTEJnmI/p9CwaweAFcufMaGurUJUwD8lkfvAXuD8bcCOfgyjC5rRRk8ur6
 ITyt/FIg/A36OwIQj5IZ2eOylOeCf1QeZ9hWV+n5gzLqQv4/kPY0xceUTmDv2jd50FCV
 kkQwIUp1EaHLAN3TRr8mH/SO8SXuhNRnx1EuFRQJigztUap+sJVaaJwPdUBWl6qiStGX
 I9kW71WnoSr6ofc72uEa0Ht9sFCzqmYvs2Am2IpgVx6wV8AIsQdV7ontty6SJnoHCEMA
 MJjixKyUxJQ+TtmXzxsEYheCbnp1ieX4PMSXRElLcqVA5HUJRgnhvkFYchu/mfTbOcaf
 bXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025136; x=1746629936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX/hJH1gLLVfS0bwh/LZYqdKvfx19Rxb8RxfxI3LnbE=;
 b=Vx+LqNnc0fKBpX35QdcXUuesCo1VFG7V7m0FtIc0uGQj+tsfg5GYmiEo7CQv3r9cla
 G6ZfNpqILwHwXnGto5EuqFcYNPX3cx9KYoul0bWB3mbMNulyUiOdoAh+56bbbrDI9N1T
 QFIzumFm0Cl7KVppoDvVBonC29jZjTC3m44smPt3+AZ1qOhHM3a6X9uvUnY72fA697Hh
 8Di5MGZzAbyBfH5f36WsrdD5xDu8dFkO+WZJsQJBNSTL5YKdxtio79iYoYHG2xrKWJnJ
 X3k7xOIU9fUAwQsioC3hKkMnSoaBqml2ocXTTviKdHPS8WVZQjwwrudDYIPQjkKQA4IL
 Zc1w==
X-Gm-Message-State: AOJu0YxL40ko1Mm0kFGe4HNAvM46s6mMyYqW8kEUSpwbk+WqYg+b06Ch
 QX6F6PY8+sBKFFOQo8cCNdOa1ng5h9ObxO3BPnOkHudVKBhq6iQQe/PB1UAKZZqkdIZGO4rpF/8
 k
X-Gm-Gg: ASbGncs3x9FdBae1CbsouBLOUWOsj27xvg+bYyY1uODXzq1lZsSWP9G3QRizJJ7GYN5
 w04braQmXp64GQnoJ8vjgdS8Ub/Ib1Tr6ZnHHr/XxAf8PzCjsOq8E+tcqvEc5NyKGA/+yrNM/2f
 uancPIKuzJ4QYsHVFbrRmhFYdG4GeWlv5aIsETI2Badqht5X9Ys25vDOpWKAEG5dVfHO6m+t/Tl
 32S0wDTzSxqFzM3ixVQRphhkVs4FzLuktViMPHslRWY5wHTlnvCqHQv+WA89PK24yBAVtC4Wdl0
 mfYkzSWImgs3eV2UM4afNAjY7a0vs/EOZePDGO29
X-Google-Smtp-Source: AGHT+IGRjjiEH+IBiShXoujq9YBdCredlo8Tlf7FnR1GflfbdHF/SogYBgWNL1xlnSq0hXKTupdl1A==
X-Received: by 2002:a17:90b:3806:b0:2f2:a664:df20 with SMTP id
 98e67ed59e1d1-30a343e80afmr5103795a91.7.1746025135869; 
 Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/12] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Date: Wed, 30 Apr 2025 07:58:31 -0700
Message-ID: <20250430145838.1790471-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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


