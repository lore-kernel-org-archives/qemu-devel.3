Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A972F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcyM-00039E-Hq; Mon, 09 Mar 2026 11:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxd-000243-0U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxb-0000il-1D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b78b638eso9039480f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071757; x=1773676557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kLmnoVlDOq/MIF/zxycxp2Fm6cRvz4pHc+1xO/ulX7k=;
 b=Hu4jsRuQe1wpaOfda2y/hLmcTUwY62kEpMgc2/omH4m0iDMOrKLoqiOSjnnO+D/1Q9
 kQvVkbN45hFd2RUls203pjWCWTSfFU8KAfmzeVPCHuEkXA/UP3Dg2jp3Fkwst8nkgr+x
 oJTo9ocWXWHXg5wXrRPQ5gPHeLpWkh6T8ap9aMZuURMVNdTctZtyF55rNODFwcgd9Exr
 zIlVGDdprxBD+Ceah6J8T2hQXq0XwatSyBkisw3GRHMSo9bnv2jp5sWDGUQCI8krBzJH
 wIQD6KCe3j0DDTILOLmqu60FCOT286CtpaukgvACc+OA/Zb7KPvQVcPAaOGM0whPKg9y
 nI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071757; x=1773676557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kLmnoVlDOq/MIF/zxycxp2Fm6cRvz4pHc+1xO/ulX7k=;
 b=QUS5y43F3k0M/E8Xm2hmjnjHmJJrV01ntA9Tbo88oTcYp6uWbDzQMa6EHixUDujbXn
 qI+SPYDKhS91EZP8PITD9XSbBIHpvdJVHDBGrE/Jo1yEZ5hw/f1p9lGXBJhTJcW8FCUw
 XTgQL1556zFuRiYqnos1otYxXfVYV+1Rey6NI51gV/jE1Ato0S66hqBzPvMhiCPXSoKF
 nBgEI1E0tKZj1ej048iCONg0FFi1QSFwmQ/LB10h6YyalDE3dEejJ6VCb+9osDuH9HcB
 1BSp63rFBU8ws1yfuyBTmyHAK7AMPWMroDJnjH9IESMv3sRzC9M2YbYD2aIoSgEYI5Im
 ZaPA==
X-Gm-Message-State: AOJu0YwGJe+IW4yaL0fP+1jzRrSoiFYZosvOVM9BWyR7jNQjrxSWDSmx
 MWXFvB5iAgyGCwMz+vk4vVmMU/0ka9M5HbKjDibmcLeoSJcfvPtV2wFTsZW/BqSqkWAJY2wWi6J
 32ga3pJE=
X-Gm-Gg: ATEYQzyXlbg+g1wpjC1W1lPIkE6khgEoBTLXM+wWlUUtu62QR+/xNNGX9xfbaPxeFI9
 ObMWZnrvly8HpBio7ye40a/n9s7d/UcqotUUWrT4hLp+URcKNU45edVUZJ6u7wvr4Hca/czw4DL
 ziUde1YEBUnBfBiSM5KeLgtJ+YZ3tWBmXeET1ZWZVcbdiIz1susRZs0TqXSuFOidkEhIL207FII
 rrFqpRsxV2lo3oYR8BCY/WPSB6zhFzBukqoR3oHFDxrvTVmA6wF3P4xjCi4Uia1cVoHxKc6J3CZ
 +dN1gKUCg9xXAk42Oo6h4xRb5klTroQ55+N0j6GXYySU+7G2B4i+/eC/s3U9UkGDC1KKPJZq9Ik
 FxhitP/w8fJl+njtrGeYMElfwkw08NoJjDdFIJCDBIzOOah+FzXH9SAOKBx8rOMODpISroGdw+9
 4anaIPXnQVAVA+LePVChYRb9CMjklvaL7ZUMEFIz/rfdcbO96Y9sVsJJIZye542PPyZpE5C76vP
 98Su+tYJk0=
X-Received: by 2002:a05:6000:430b:b0:439:b671:1d8f with SMTP id
 ffacd0b85a97d-439da89c078mr17588122f8f.45.1773071756919; 
 Mon, 09 Mar 2026 08:55:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba66sm24259491f8f.20.2026.03.09.08.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/49] hw/sparc/sun4m: Use qdev GPIOs rather than
 qemu_allocate_irqs()
Date: Mon,  9 Mar 2026 16:52:02 +0100
Message-ID: <20260309155219.62400-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the sun4m machine creation code, we currently use qemu_allocate_irqs()
to set up the IRQ lines that act as the inbound IRQ lines to the CPUs.
This results in a memory leak:

Direct leak of 128 byte(s) in 1 object(s) allocated from:
    #0 0x5a23c1281ec3 in malloc (/home/pm215/qemu/build/sparc-san/qemu-system-sparc+0xdf1ec3) (BuildId: e6aa10be01feb5524656dd083997bc82b85e3e93)
    #1 0x79e8f78f0ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5a23c1a94e54 in qemu_extend_irqs /home/pm215/qemu/build/sparc-san/../../hw/core/irq.c:77:51
    #3 0x5a23c1a39e03 in cpu_devinit /home/pm215/qemu/build/sparc-san/../../hw/sparc/sun4m.c:802:17
    #4 0x5a23c1a39e03 in sun4m_hw_init /home/pm215/qemu/build/sparc-san/../../hw/sparc/sun4m.c:838:9

The leak is unimportant as it is a "once at startup" leak, but
fixing it helps in getting a clean leak-sanitizer test run.

Switch the sun4m code to handle CPU interrupt lines in the same way
as the leon3 machine does: the machine init code uses
qdev_init_gpio_in to create GPIO lines on the CPU objects.  This is a
little bit odd as ideally the CPU would do that itself, but for these
32-bit SPARC machines the machine and the CPU are very closely
coupled already (the functions handling the IRQ lines modify data
fields inside the CPU).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20260307112931.3322532-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/sun4m.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 29bc26ebcb7..b9f8236be54 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -341,7 +341,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
 static DeviceState *slavio_intctl_init(hwaddr addr,
                                        hwaddr addrg,
                                        unsigned int smp_cpus,
-                                       qemu_irq **parent_irq)
+                                       DeviceState **cpus)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -354,7 +354,8 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
 
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < MAX_PILS; j++) {
-            sysbus_connect_irq(s, i * MAX_PILS + j, parent_irq[i][j]);
+            sysbus_connect_irq(s, i * MAX_PILS + j,
+                               qdev_get_gpio_in_named(cpus[i], "pil", j));
         }
     }
     sysbus_mmio_map(s, 0, addrg);
@@ -785,22 +786,25 @@ static const TypeInfo ram_info = {
     .class_init    = ram_class_init,
 };
 
-static void cpu_devinit(const char *cpu_type, unsigned int id,
-                        uint64_t prom_addr, qemu_irq **cpu_irqs)
+static DeviceState *cpu_devinit(const char *cpu_type, unsigned int id,
+                                uint64_t prom_addr)
 {
     SPARCCPU *cpu;
     CPUSPARCState *env;
+    DeviceState *cpudev;
 
     cpu = SPARC_CPU(object_new(cpu_type));
     env = &cpu->env;
+    cpudev = DEVICE(cpu);
 
     qemu_register_reset(sun4m_cpu_reset, cpu);
     object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
                              &error_abort);
-    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
+    qdev_init_gpio_in_named(cpudev, cpu_set_irq, "pil", MAX_PILS);
+    qdev_realize_and_unref(cpudev, NULL, &error_fatal);
     cpu_sparc_set_id(env, id);
-    *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
     env->prom_addr = prom_addr;
+    return cpudev;
 }
 
 static void dummy_fdc_tc(void *opaque, int irq, int level)
@@ -813,13 +817,14 @@ static void sun4m_hw_init(MachineState *machine)
     DeviceState *slavio_intctl;
     unsigned int i;
     Nvram *nvram;
-    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
+    qemu_irq slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
     qemu_irq fdc_tc;
     unsigned long kernel_size;
     uint32_t initrd_size;
     DriveInfo *fd[MAX_FD];
     FWCfgState *fw_cfg;
     DeviceState *dev, *ms_kb_orgate, *serial_orgate;
+    DeviceState *cpus[MAX_CPUS];
     SysBusDevice *s;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
@@ -835,7 +840,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     /* init CPUs */
     for(i = 0; i < smp_cpus; i++) {
-        cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
+        cpus[i] = cpu_devinit(machine->cpu_type, i, hwdef->slavio_base);
     }
 
     /* Create and map RAM frontend */
@@ -855,7 +860,7 @@ static void sun4m_hw_init(MachineState *machine)
     slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
                                        hwdef->intctl_base + 0x10000ULL,
                                        smp_cpus,
-                                       cpu_irqs);
+                                       cpus);
 
     for (i = 0; i < 32; i++) {
         slavio_irq[i] = qdev_get_gpio_in(slavio_intctl, i);
-- 
2.53.0


