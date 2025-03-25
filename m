Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78547C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3Zd-00013d-7J; Tue, 25 Mar 2025 08:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZU-00013K-3E
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZQ-0005Qt-N4
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso51056605e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742906389; x=1743511189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2z/hIXHE7gA8BhYXkl6xq/yq0lVd9BDreez7QJtYPY=;
 b=m9WRlwJHP9SK5VChRHDcN1xdyTmMrfLrum5PyBr7nUEWayzymlohgKuQf6Sc4YlQYa
 ppJZD93f8AVUI6/mnWyzKourhj5A07mYeNJlRJ5UtU+loIoNY7T2StBFHakWpeArqA45
 2sHWfKZlO0b/sX5IZz2uitk4YdLZlfkcVTxZg+kmvmfxAm8PEWkHUYSJK5Rw2+kLLOtu
 0Qfsk/qaXbhC0W5J1c1bp9VHHTgYIDMtqwwHWuOIP28ZA78yfW2b76HfYnwUQ06gdY63
 CRINwz5gvzCi8KRbnsn+NFRw0SvRZ9Fpczv4z/d3fmvd7sA4j/5XTKzQDLjxwy/Lu5iE
 S0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906389; x=1743511189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2z/hIXHE7gA8BhYXkl6xq/yq0lVd9BDreez7QJtYPY=;
 b=tQgN2+CxXe26CSt/FynvpDdB6Au5fiAvElAapalDDF2DLnRrfagKWdM4q/uoCveUOF
 7GRpaorR4zSB4ZI6FceB7odwyLVK2Y6cDLzJI03asAxlCkZi0UcxJsJ/Kn1Nxv9XedvF
 m85v0hOMSdn0F9AORrrrx32grztLHxirqrFA2zYXFw7OLlamPwIlZocynYNB1+lthX6M
 3ZxLBHeRhlxq+aFiOxHtjryzoVVYmKqBB8Z/FmmrGFcEXqKlfnPbxe7iFTiwI/LsndcR
 dafdgJJOMy5+8qHrregeOP0CQWT3uq3R/YkI/409HAh+zVwy52fXMv5kqQ4iKSB+mdyh
 IXVQ==
X-Gm-Message-State: AOJu0YxesDa1F8V8yQkJHd+WGvpnmjy0443IXTlh9KXZr5gdzaKUe9X8
 wdsyyS48Y63SeUV53OkqtnGK2yE9BDEV6PYvaByTUUJsstYBBk/rq/N9vbvHzA47GTbWgHki0qU
 A
X-Gm-Gg: ASbGncs2TB+UJEpBu+yBI094+Ffkv39tMWuVwMqZhPVhVwbuf/IQIBHAVQ129lWshrY
 6yg0BAQSRnJCMNPr0c/QrixIsfgBKk8gfLDJ6neX2ctaL7POSqB6OyH6Kin/9IHWmygxLuclnLa
 yLLJnVq8r+qlu4uv4wh7bEYk4f+En44yYO9Zg72gN2QPCy2brgm77A2nU6JXq3xMq1EmTIMydO2
 CoThpso66lmMqYHUimySmAJudRnQVIf8wadkCFOhJyKLBAYFqc6bmjqIhuraSbsCbzamFEXH2qz
 f/FPoovsnR7lqhQUbsqwzv1mgPNtXCK5SUu+VA+dZzd53l0Z94OTJRrgx/SxakXZEBF62VhWHa1
 55GEehrFT39tK993pjrs=
X-Google-Smtp-Source: AGHT+IG9yiV4LDXT9THcYlG/8oJgx4mKTpH1S3WCVNqBx8h6pmiyBSvwDMWq1uWKn6X312M14fgFXg==
X-Received: by 2002:a05:6000:4188:b0:391:487f:27e7 with SMTP id
 ffacd0b85a97d-3997f947b9dmr11278702f8f.55.1742906389418; 
 Tue, 25 Mar 2025 05:39:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6667sm13835492f8f.72.2025.03.25.05.39.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 05:39:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 4/4] target/sparc: Move hardware fields from
 CPUSPARCState to SPARCCPU
Date: Tue, 25 Mar 2025 13:39:27 +0100
Message-ID: <20250325123927.74939-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325123927.74939-1-philmd@linaro.org>
References: <20250325123927.74939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Keep CPUSPARCState for architectural fields, move Leon3
hardware specific fields to SPARCCPU.

Reset the Leon3 specific 'cache_control' field in
leon3_cpu_reset() instead of sparc_cpu_reset_hold().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h          | 10 +++++-----
 hw/sparc/leon3.c            | 35 ++++++++++++++++++-----------------
 target/sparc/cpu.c          |  1 -
 target/sparc/int32_helper.c |  8 ++++++--
 target/sparc/ldst_helper.c  | 12 ++++++------
 5 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 462bcb6c0e6..abb71c314dc 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -543,11 +543,6 @@ struct CPUArchState {
 #define SOFTINT_REG_MASK (SOFTINT_STIMER|SOFTINT_INTRMASK|SOFTINT_TIMER)
 #endif
     sparc_def_t def;
-
-    /* Leon3 */
-    DeviceState *irq_manager;
-    void (*qemu_irq_ack)(CPUSPARCState *env, int intno);
-    uint32_t cache_control;
 };
 
 /**
@@ -560,6 +555,11 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUSPARCState env;
+
+    /* Leon3 */
+    DeviceState *irq_manager;
+    void (*qemu_irq_ack)(SPARCCPU *cpu, int intno);
+    uint32_t cache_control;
 };
 
 /**
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0aeaad3becc..06966861744 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -152,6 +152,7 @@ static void leon3_cpu_reset(void *opaque)
     int id = info->id;
     ResetData *s = container_of(info, ResetData, info[id]);
     CPUState *cpu = CPU(s->info[id].cpu);
+    SPARCCPU *scpu = SPARC_CPU(cpu);
     CPUSPARCState *env = cpu_env(cpu);
 
     cpu_reset(cpu);
@@ -159,41 +160,41 @@ static void leon3_cpu_reset(void *opaque)
     cpu->halted = cpu->cpu_index != 0;
     env->pc = s->entry;
     env->npc = s->entry + 4;
+    scpu->cache_control = 0;
 }
 
-static void leon3_cache_control_int(CPUSPARCState *env)
+static void leon3_cache_control_int(SPARCCPU *cpu)
 {
     uint32_t state = 0;
 
-    if (env->cache_control & CACHE_CTRL_IF) {
+    if (cpu->cache_control & CACHE_CTRL_IF) {
         /* Instruction cache state */
-        state = env->cache_control & CACHE_STATE_MASK;
+        state = cpu->cache_control & CACHE_STATE_MASK;
         if (state == CACHE_ENABLED) {
             state = CACHE_FROZEN;
             trace_int_helper_icache_freeze();
         }
 
-        env->cache_control &= ~CACHE_STATE_MASK;
-        env->cache_control |= state;
+        cpu->cache_control &= ~CACHE_STATE_MASK;
+        cpu->cache_control |= state;
     }
 
-    if (env->cache_control & CACHE_CTRL_DF) {
+    if (cpu->cache_control & CACHE_CTRL_DF) {
         /* Data cache state */
-        state = (env->cache_control >> 2) & CACHE_STATE_MASK;
+        state = (cpu->cache_control >> 2) & CACHE_STATE_MASK;
         if (state == CACHE_ENABLED) {
             state = CACHE_FROZEN;
             trace_int_helper_dcache_freeze();
         }
 
-        env->cache_control &= ~(CACHE_STATE_MASK << 2);
-        env->cache_control |= (state << 2);
+        cpu->cache_control &= ~(CACHE_STATE_MASK << 2);
+        cpu->cache_control |= (state << 2);
     }
 }
 
-static void leon3_irq_ack(CPUSPARCState *env, int intno)
+static void leon3_irq_ack(SPARCCPU *cpu, int intno)
 {
-    CPUState *cpu = CPU(env_cpu(env));
-    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
+    grlib_irqmp_ack(cpu->irq_manager, CPU(cpu)->cpu_index, intno);
 }
 
 /*
@@ -248,10 +249,10 @@ static void leon3_start_cpu(void *opaque, int n, int level)
     async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
 }
 
-static void leon3_irq_manager(CPUSPARCState *env, int intno)
+static void leon3_irq_manager(SPARCCPU *cpu, int intno)
 {
-    leon3_irq_ack(env, intno);
-    leon3_cache_control_int(env);
+    leon3_irq_ack(cpu, intno);
+    leon3_cache_control_int(cpu);
 }
 
 static void leon3_generic_hw_init(MachineState *machine)
@@ -320,8 +321,8 @@ static void leon3_generic_hw_init(MachineState *machine)
         qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
                                     qdev_get_gpio_in_named(DEVICE(cpu),
                                                            "pil", 0));
-        env->irq_manager = irqmpdev;
-        env->qemu_irq_ack = leon3_irq_manager;
+        cpu->irq_manager = irqmpdev;
+        cpu->qemu_irq_ack = leon3_irq_manager;
     }
 
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 37406227cb7..d62ad6c4db2 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -78,7 +78,6 @@ static void sparc_cpu_reset_hold(Object *obj, ResetType type)
     env->pc = 0;
     env->npc = env->pc + 4;
 #endif
-    env->cache_control = 0;
     cpu_put_fsr(env, 0);
 }
 
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index f0266061023..a902702559d 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -168,8 +168,12 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
 #if !defined(CONFIG_USER_ONLY)
     /* IRQ acknowledgment */
-    if ((intno & ~15) == TT_EXTINT && env->qemu_irq_ack != NULL) {
-        env->qemu_irq_ack(env, intno);
+    if ((intno & ~15) == TT_EXTINT) {
+        SPARCCPU *cpu = env_archcpu(env);
+
+        if (cpu->qemu_irq_ack != NULL) {
+            cpu->qemu_irq_ack(cpu, intno);
+        }
     }
 #endif
 }
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d4de32d3c48..0a11360ccaf 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -513,7 +513,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
 
 /* Leon3 cache control */
 
-static void leon3_cache_control_st(CPUSPARCState *env, target_ulong addr,
+static void leon3_cache_control_st(SPARCCPU *cpu, target_ulong addr,
                                    uint64_t val, int size)
 {
     DPRINTF_CACHE_CONTROL("st addr:%08x, val:%" PRIx64 ", size:%d\n",
@@ -534,7 +534,7 @@ static void leon3_cache_control_st(CPUSPARCState *env, target_ulong addr,
         val &= ~CACHE_CTRL_IP;
         val &= ~CACHE_CTRL_DP;
 
-        env->cache_control = val;
+        cpu->cache_control = val;
         break;
     case 0x04:              /* Instruction cache configuration */
     case 0x08:              /* Data cache configuration */
@@ -546,7 +546,7 @@ static void leon3_cache_control_st(CPUSPARCState *env, target_ulong addr,
     };
 }
 
-static uint64_t leon3_cache_control_ld(CPUSPARCState *env, target_ulong addr,
+static uint64_t leon3_cache_control_ld(SPARCCPU *cpu, target_ulong addr,
                                        int size)
 {
     uint64_t ret = 0;
@@ -558,7 +558,7 @@ static uint64_t leon3_cache_control_ld(CPUSPARCState *env, target_ulong addr,
 
     switch (addr) {
     case 0x00:              /* Cache control */
-        ret = env->cache_control;
+        ret = cpu->cache_control;
         break;
 
         /* Configuration registers are read and only always keep those
@@ -599,7 +599,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         case 0x08:          /* Leon3 Instruction Cache config */
         case 0x0C:          /* Leon3 Date Cache config */
             if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
-                ret = leon3_cache_control_ld(env, addr, size);
+                ret = leon3_cache_control_ld(env_archcpu(env), addr, size);
             } else {
                 qemu_log_mask(LOG_UNIMP,
                               "%08x: unimplemented access size: %d\n", addr,
@@ -819,7 +819,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
         case 0x08:          /* Leon3 Instruction Cache config */
         case 0x0C:          /* Leon3 Date Cache config */
             if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
-                leon3_cache_control_st(env, addr, val, size);
+                leon3_cache_control_st(env_archcpu(env), addr, val, size);
             } else {
                 qemu_log_mask(LOG_UNIMP,
                               "%08x: unimplemented access size: %d\n", addr,
-- 
2.47.1


