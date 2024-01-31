Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5855CC48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6Ja-0001wQ-Fc; Wed, 31 Jan 2024 03:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JV-0001ua-AI
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JT-0007sa-A5
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40fb3e278adso3647015e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691077; x=1707295877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd+SvcQVLHH71F1dqQ4YcF9V/XC9gxQZ0Gj03Wj4mVs=;
 b=R1jm0BVXQg8f0dobWOl/GbHEJg/vwoxqYA/XdiF6KxtUCXoXMGT93R5uqZy/snmSsD
 AmP93tS+qGTnAqM8zm0ESAkmGVDroXFksXOYkJaALjY/fJS2dBlsbqNh57pc5N5Q83aL
 gs+lr6V3l2HYVVM6tY6EUEnfYtZig6NClVezdEQZOSsfHsF8ULGxh6SmGhlNKMf3JW24
 74cKco/Det4fPWpfZUdA4875HlhODdVLEqQ+PiieqRP9HCdj9mh/yGOFesKa4W3Xtclh
 /r/iJGfv4V93q42t0mMgh8vW8aLDpnef+lOmOuMS6+YVND71B8vivB3b1OzmLC56/y/1
 0seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691077; x=1707295877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nd+SvcQVLHH71F1dqQ4YcF9V/XC9gxQZ0Gj03Wj4mVs=;
 b=ZvE1H8PGpheSbYTsmn0D0votIc6vmZpht1kqjPTv29oMnd8wtWo7QQtj8ZbP7tiqAH
 LLP2QdnYj+m0KsXnIZegAWqYcSS87YB30ln3h/wnqMv2ObSuQhma/kQ8CuP2zZ4jABpr
 QFf4y8UANdgPNsJa3Y2sK0zyULaZ3cYsxiQAkVdZG4jEEu9kWIEPR0+ytgz1GmIOZv5M
 aiuIKcwMcGf6UKUjSi0yXPn5KSKZ7kOkuEOvhg5V4IxxqMYGMzwijYJAcSm+fvAcgSBm
 8DzQdtMtGTFJzS0QrbO7/u4Pj00qaU/11eGYDRZAtzYiq5v8EciB7v1N99dbcSfNe9eA
 GcUw==
X-Gm-Message-State: AOJu0Yx+64LmA7r4QvLreHb04Cmgp/sAclI4JI/M7Wlc9LPEmG34xfrr
 7N3zj2LAb2YZzwE6AY4PGS2eObZnnExh4O+6GVNzuEQvMRjballXPdRNmTyQVlrBspTtLKyBsSY
 =
X-Google-Smtp-Source: AGHT+IGZuGchCmGZEzmNbClbRXQrcEONaVCnmjUwj6dOPUB/GQ4J/oMM/RbyjIKlBNSSLVQExk20fg==
X-Received: by 2002:a05:600c:4f4d:b0:40f:b65c:6127 with SMTP id
 m13-20020a05600c4f4d00b0040fb65c6127mr13707wmq.35.1706691076930; 
 Wed, 31 Jan 2024 00:51:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW3EdcYwuOOtWQtQOtDwqZxAM0tPC7i5yjZvXVtPCmGM5zroGQ5QxMPAd8VDCNaWArftqPz19sceHdgvvuBamLkPnf7BQtlxho=
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:16 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH v3 7/9] leon3: implement multiprocessor
Date: Wed, 31 Jan 2024 09:50:45 +0100
Message-Id: <20240131085047.18458-8-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x329.google.com
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

This allows to register more than one CPU on the leon3_generic machine.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/sparc/leon3.c | 98 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 317eb57336..252aff72cd 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -54,6 +54,8 @@
 #define LEON3_PROM_OFFSET    (0x00000000)
 #define LEON3_RAM_OFFSET     (0x40000000)
 
+#define MAX_CPUS  4
+
 #define LEON3_UART_OFFSET  (0x80000100)
 #define LEON3_UART_IRQ     (3)
 
@@ -67,8 +69,11 @@
 #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
 
 typedef struct ResetData {
-    SPARCCPU *cpu;
-    uint32_t  entry;            /* save kernel entry in case of reset */
+    struct CPUResetData {
+        int id;
+        SPARCCPU *cpu;
+    } info[MAX_CPUS];
+    uint32_t entry;             /* save kernel entry in case of reset */
 } ResetData;
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
@@ -124,17 +129,19 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
     stl_p(p++, 0x01000000); /* nop */
 }
 
-static void main_cpu_reset(void *opaque)
+static void leon3_cpu_reset(void *opaque)
 {
-    ResetData *s   = (ResetData *)opaque;
-    CPUState *cpu = CPU(s->cpu);
-    CPUSPARCState  *env = &s->cpu->env;
+    struct CPUResetData *info = (struct CPUResetData *) opaque;
+    int id = info->id;
+    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    CPUState *cpu = CPU(s->info[id].cpu);
+    CPUSPARCState *env = cpu_env(cpu);
 
     cpu_reset(cpu);
 
-    cpu->halted = 0;
-    env->pc     = s->entry;
-    env->npc    = s->entry + 4;
+    cpu->halted = cpu->cpu_index != 0;
+    env->pc = s->entry;
+    env->npc = s->entry + 4;
 }
 
 static void leon3_cache_control_int(CPUSPARCState *env)
@@ -168,8 +175,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    /* No SMP support yet, only CPU #0 available so far.  */
-    grlib_irqmp_ack(env->irq_manager, 0, intno);
+    CPUState *cpu = CPU(env_cpu(env));
+    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
 }
 
 /*
@@ -211,6 +218,19 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
     }
 }
 
+static void leon3_start_cpu_async_work(CPUState *cpu, run_on_cpu_data data)
+{
+    cpu->halted = 0;
+}
+
+static void leon3_start_cpu(void *opaque, int n, int level)
+{
+    CPUState *cs = CPU(opaque);
+
+    assert(level == 1);
+    async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
+}
+
 static void leon3_irq_manager(CPUSPARCState *env, int intno)
 {
     leon3_irq_ack(env, intno);
@@ -236,16 +256,20 @@ static void leon3_generic_hw_init(MachineState *machine)
     AHBPnp *ahb_pnp;
     APBPnp *apb_pnp;
 
-    /* Init CPU */
-    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
-    env = &cpu->env;
+    reset_info = g_malloc0(sizeof(ResetData));
 
-    cpu_sparc_set_id(env, 0);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        /* Init CPU */
+        cpu = SPARC_CPU(cpu_create(machine->cpu_type));
+        env = &cpu->env;
 
-    /* Reset data */
-    reset_info        = g_new0(ResetData, 1);
-    reset_info->cpu   = cpu;
-    qemu_register_reset(main_cpu_reset, reset_info);
+        cpu_sparc_set_id(env, i);
+
+        /* Reset data */
+        reset_info->info[i].id = i;
+        reset_info->info[i].cpu = cpu;
+        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
+    }
 
     ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
@@ -263,14 +287,28 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
+    object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
+                            &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
-    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
-                                        env, "pil", 1);
-    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
+
+    for (i = 0; i < machine->smp.cpus; i++) {
+        cpu = reset_info->info[i].cpu;
+        env = &cpu->env;
+        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_start_cpu,
+                                            cpu, "start_cpu", 1);
+        qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                                           "start_cpu", 0));
+        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
+                                            env, "pil", 1);
+        qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                                           "pil", 0));
+        env->irq_manager = irqmpdev;
+        env->qemu_irq_ack = leon3_irq_manager;
+    }
+
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
-    env->irq_manager = irqmpdev;
-    env->qemu_irq_ack = leon3_irq_manager;
     grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
                             2, 0, GRLIB_APBIO_AREA);
@@ -344,10 +382,13 @@ static void leon3_generic_hw_init(MachineState *machine)
             uint8_t *bootloader_entry;
 
             bootloader_entry = memory_region_get_ram_ptr(prom);
-            write_bootloader(env, bootloader_entry, entry);
-            env->pc = LEON3_PROM_OFFSET;
-            env->npc = LEON3_PROM_OFFSET + 4;
+            write_bootloader(&reset_info->info[0].cpu->env, bootloader_entry,
+                             entry);
             reset_info->entry = LEON3_PROM_OFFSET;
+            for (i = 0; i < machine->smp.cpus; i++) {
+                reset_info->info[i].cpu->env.pc = LEON3_PROM_OFFSET;
+                reset_info->info[i].cpu->env.npc = LEON3_PROM_OFFSET + 4;
+            }
         }
     }
 
@@ -386,6 +427,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->init = leon3_generic_hw_init;
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
+    mc->max_cpus = MAX_CPUS;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
-- 
2.25.1


