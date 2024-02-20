Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5416DC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRkB-00054b-33; Tue, 20 Feb 2024 10:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjy-0004zu-2V
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:09:02 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjv-0003o5-1X
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:09:01 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d220ad10b3so46184201fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708441736; x=1709046536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1TV5sCnl17G7fDWs4b3B3U9yT3t3/ekFX78vUNTAvs=;
 b=k2QAQiX0h9hdemJUtCtmdVOTsNNCQ6lmb1AcH+ap8T7w9jLEMBcYr5pRGXrkSLntdq
 kIkTtEvC9d4gCbDUpB0hvNs4x3YgD+rq/m+2pnApAgFpfJXweCMhZ5+d3HgrQkCW4wVO
 TqEVQqbLod52zOm0MA3+Phv0bnQsltFfDr5g6LUMFucY51SCr91AecxdWQSAxUCoLlfg
 Ko6frg9Z6Axv+ELpXocXyOCak6j4B3PzXY7kAru6zfXAEUWqd0dzzZOwufST3GXp9AWR
 KjguGrLZ13ieUtWdQ5IP/TnCDUJlBeVFuNa7z5hOiWGbO05c6haNnjvig1/rZslaK4Kf
 1zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708441736; x=1709046536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1TV5sCnl17G7fDWs4b3B3U9yT3t3/ekFX78vUNTAvs=;
 b=mtdhc38Pz7EhEidMtPzDa6+EJkTUe6ycCaygrJpG8BFeod1pY/grsRx3PB/OwYsReF
 qJ+WtK1jR1D9/94NKnK12MXFO0JjUJHa4telWy9P8rvHGUR1kqg6qBVWmfDBjWxUVHSh
 Baf+7R09i6LodsqhyHiN9kQoAwPASd1+zjiBI02xCI8+Gxz1OfapuMbk82YSwoLdrnzJ
 El6tF/ZjMLJfxCWq5wcPvGu3QHHzHkImXxxoNsKgTpxCkiaGmsoYVEK6xohAJTn6GpxT
 1jZEoqFGH9Bmg8yPrrws9v9BDlkI4jgTpjcUO3QamCzu8VoiDgOXmIuQYe+N82lGDywN
 0CpA==
X-Gm-Message-State: AOJu0YzHj2SoJpc7y7/S0GgeAideJAR49HB7XZzLwlPlWO7fQ/y1t5HK
 HBiq9di++Csy6DlK6ThK90aDu4/lL0EejxifzjINKp5fKzsOB9dqQguP+E0DBCxcAEfU5L10BuE
 F
X-Google-Smtp-Source: AGHT+IGb+FdbrT00j0U8Uxf+mqkoGDX+JU4NnFMo1mEZ2CqrmobuIE9ddAMt5g5MnwXrf/PPUWnLpw==
X-Received: by 2002:a2e:9858:0:b0:2d2:31f4:35c with SMTP id
 e24-20020a2e9858000000b002d231f4035cmr4858299ljj.25.1708441736022; 
 Tue, 20 Feb 2024 07:08:56 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 ay5-20020a5d6f05000000b0033d1ef15821sm13635990wrb.25.2024.02.20.07.08.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 07:08:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/4] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_handler()
Date: Tue, 20 Feb 2024 16:08:32 +0100
Message-ID: <20240220150833.13674-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220150833.13674-1-philmd@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Only s390x was using the 'cpu_index' argument, but since the
previous commit it isn't anymore (it use the first cpu).
Since this argument is now completely unused, remove it. Have
the callback return a boolean indicating failure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nmi.h           | 11 ++++++++++-
 hw/core/nmi.c              |  3 +--
 hw/hppa/machine.c          |  8 +++++---
 hw/i386/x86.c              |  7 ++++---
 hw/intc/m68k_irqc.c        |  6 ++++--
 hw/m68k/q800-glue.c        |  6 ++++--
 hw/misc/macio/gpio.c       |  6 ++++--
 hw/ppc/pnv.c               |  6 ++++--
 hw/ppc/spapr.c             |  6 ++++--
 hw/s390x/s390-virtio-ccw.c |  6 ++++--
 10 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index fff41bebc6..c70db941c9 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -37,7 +37,16 @@ typedef struct NMIState NMIState;
 struct NMIClass {
     InterfaceClass parent_class;
 
-    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
+    /**
+     * nmi_handler: Callback to handle NMI notifications.
+     *
+     * @n: Class #NMIState state
+     * @errp: pointer to error object
+     *
+     * On success, return %true.
+     * On failure, store an error through @errp and return %false.
+     */
+    bool (*nmi_handler)(NMIState *n, Error **errp);
 };
 
 void nmi_monitor_handle(int cpu_index, Error **errp);
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index f5220111c1..409164d445 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -40,8 +40,7 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
-        nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
-        if (ns->err) {
+        if (!nc->nmi_handler(n, &ns->err)) {
             return -1;
         }
     }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5fcaf5884b..75b61a0683 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -673,13 +673,15 @@ static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
     cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
 }
 
-static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool hppa_nmi(NMIState *n, Error **errp)
 {
     CPUState *cs;
 
     CPU_FOREACH(cs) {
         cpu_interrupt(cs, CPU_INTERRUPT_NMI);
     }
+
+    return true;
 }
 
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
@@ -705,7 +707,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
 
-    nc->nmi_monitor_handler = hppa_nmi;
+    nc->nmi_handler = hppa_nmi;
 }
 
 static const TypeInfo HP_B160L_machine_init_typeinfo = {
@@ -741,7 +743,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
 
-    nc->nmi_monitor_handler = hppa_nmi;
+    nc->nmi_handler = hppa_nmi;
 }
 
 static const TypeInfo HP_C3700_machine_init_typeinfo = {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 684dce90e9..0d756c4857 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -512,9 +512,8 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool x86_nmi(NMIState *n, Error **errp)
 {
-    /* cpu index isn't used */
     CPUState *cs;
 
     CPU_FOREACH(cs) {
@@ -526,6 +525,8 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
             cpu_interrupt(cs, CPU_INTERRUPT_NMI);
         }
     }
+
+    return true;
 }
 
 static long get_file_size(FILE *f)
@@ -1416,7 +1417,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
-    nc->nmi_monitor_handler = x86_nmi;
+    nc->nmi_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 4b11fb9f72..acc9348218 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -71,9 +71,11 @@ static void m68k_irqc_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), m68k_set_irq, M68K_IRQC_LEVEL_NUM);
 }
 
-static void m68k_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool m68k_nmi(NMIState *n, Error **errp)
 {
     m68k_set_irq(n, M68K_IRQC_LEVEL_7, 1);
+
+    return true;
 }
 
 static const VMStateDescription vmstate_m68k_irqc = {
@@ -99,7 +101,7 @@ static void m68k_irqc_class_init(ObjectClass *oc, void *data)
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
     device_class_set_props(dc, m68k_irqc_properties);
-    nc->nmi_monitor_handler = m68k_nmi;
+    nc->nmi_handler = m68k_nmi;
     dc->reset = m68k_irqc_reset;
     dc->vmsd = &vmstate_m68k_irqc;
     ic->get_statistics = m68k_irqc_get_statistics;
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index b5a7713863..f92bd5064a 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -159,13 +159,15 @@ static void glue_auxmode_set_irq(void *opaque, int irq, int level)
     s->auxmode = level;
 }
 
-static void glue_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool glue_nmi(NMIState *n, Error **errp)
 {
     GLUEState *s = GLUE(n);
 
     /* Hold NMI active for 100ms */
     GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 1);
     timer_mod(s->nmi_release, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
+
+    return true;
 }
 
 static void glue_nmi_release(void *opaque)
@@ -238,7 +240,7 @@ static void glue_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_glue;
     device_class_set_props(dc, glue_properties);
     rc->phases.hold = glue_reset_hold;
-    nc->nmi_monitor_handler = glue_nmi;
+    nc->nmi_handler = glue_nmi;
 }
 
 static const TypeInfo glue_info_types[] = {
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 549563747d..9ac93d9ed5 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -183,10 +183,12 @@ static void macio_gpio_reset(DeviceState *dev)
     macio_set_gpio(s, 1, true);
 }
 
-static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool macio_gpio_nmi(NMIState *n, Error **errp)
 {
     macio_set_gpio(MACIO_GPIO(n), 9, true);
     macio_set_gpio(MACIO_GPIO(n), 9, false);
+
+    return true;
 }
 
 static void macio_gpio_class_init(ObjectClass *oc, void *data)
@@ -196,7 +198,7 @@ static void macio_gpio_class_init(ObjectClass *oc, void *data)
 
     dc->reset = macio_gpio_reset;
     dc->vmsd = &vmstate_macio_gpio;
-    nc->nmi_monitor_handler = macio_gpio_nmi;
+    nc->nmi_handler = macio_gpio_nmi;
 }
 
 static const TypeInfo macio_gpio_init_info = {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..f572f8d0ce 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2321,13 +2321,15 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool pnv_nmi(NMIState *n, Error **errp)
 {
     CPUState *cs;
 
     CPU_FOREACH(cs) {
         async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
     }
+
+    return true;
 }
 
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
@@ -2351,7 +2353,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
-    nc->nmi_monitor_handler = pnv_nmi;
+    nc->nmi_handler = pnv_nmi;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d72d286d8..7327bf3429 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3505,13 +3505,15 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool spapr_nmi(NMIState *n, Error **errp)
 {
     CPUState *cs;
 
     CPU_FOREACH(cs) {
         async_run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
     }
+
+    return true;
 }
 
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
@@ -4672,7 +4674,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
-    nc->nmi_monitor_handler = spapr_nmi;
+    nc->nmi_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ba1fa6472f..817f414767 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -603,9 +603,11 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
+static bool s390_nmi(NMIState *n, Error **errp)
 {
     s390_cpu_restart(S390_CPU(first_cpu));
+
+    return true;
 }
 
 static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
@@ -774,7 +776,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
-    nc->nmi_monitor_handler = s390_nmi;
+    nc->nmi_handler = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
 
-- 
2.41.0


