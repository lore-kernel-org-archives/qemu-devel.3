Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932BBEF99EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5AD-0003qf-PB; Fri, 13 Feb 2026 21:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr5AC-0003p5-G0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr5AA-0004dJ-If
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so2885005e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035217; x=1771640017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxZmHoD4NLKTu0jEJRVbx1DWKJRYt99sqgMKoBjz8/o=;
 b=kXJuLaPMkah1BijVX7sJCFlsCmU4hqY88s0bpLJGUC1jnrhZJVxmAgCzF+QNzuc/CF
 4c6pmhDVnDJ8DSQpjXG8NTHTTpd5XWfSjAypXS635do6T4A90kdlB8iq0cYylOlAGNvU
 19mPw2kmFtXb+QP8Gs0sluM/aec/7RMsSiZRX7EHOSApLW54cRzJtJVeN8kfzr3ubveC
 1yGFp+czouu70WTAa6Tvc/MMebWo17uizog4m3rxJM1cdPn2eRqXi2Gt0MTjybqr3k52
 ojlNvzNesaMSamF8DeyoDDLQi5MZWv4z4AqtRLHgwwIFsCdbdLIGmOoT51KpCE/ry0A9
 H/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035217; x=1771640017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CxZmHoD4NLKTu0jEJRVbx1DWKJRYt99sqgMKoBjz8/o=;
 b=j8X3DROP1+RpSg2KNIn5MVtMS9BtV6Tjvy/AvdXpPuwrjZ4LqFr7PnexlWw8dOBxwG
 oFKFiG0QluOK74+W2fEknIqbUnVHyavuSSM6vrvySSYvghX6HMand/r6a3EU9RNQ9vwo
 1ojYEAU4NZRSoL2crrj3Kdrn1NU+1SthU23ktXw3YpcH+dNd7PDdisn7JenmT4c0Mu36
 VDnLp+dt/v5I5UqtAnGCFiPJuS14lF6JoBlFfnJy4uhiSnR2joc5/3bqHXpuj8KQ3FKh
 x4jVDrKK9bAoPBClI9tbKDi2ZVl3daLE5J8zCrZaqH/vRsYYnkp7V0fo3/Dg1NMOJZu3
 3CIQ==
X-Gm-Message-State: AOJu0Yx7AbrGenWR4qclBqwrdCTqd4zLYaW8R86SNwd4IvLi6dnoTfdZ
 kuW8L5SXNiP5Cx0YHKhp8xBNUYCMRPz+vwy7+n+HA9osfZ86z5qi0MAepXaa3O/CsM9/1PlpVik
 awyRGt2k=
X-Gm-Gg: AZuq6aLk4IucDEyrVl+7haeG4CTBHfI0M2HHbkLQ3BC5uZB7Fg1lQHkHAhcdTvVdMlc
 M2lPVGFatXtEt/tTjV2iMEQHnfWsRyInxnn3e2zeGYVASCFZUSb6NajEZl8PHUcliCc8hxt8XOS
 gQm/+8SbPuRRkfbVacdrcSgXt28kRt9lQ5ZB51dkFtMyto/9GXV2OTqwa714HYvz8he015YzKyw
 yZXZmrPStB1/f5ihkltHoqXyajHXUjL8FmNUcSkvDGGVFf3MdiueHE4WiG9PoxfH+JKbDS1rNG3
 lpJZL1rlfNSoVC+ZNkUdqtvXsbcRk4QzOVGQpbORz3ASLHvViy04BAqZGuxYX/1VvZ9Av356gfs
 hqAa3K2OsvWI4sbAYY2O/ITEZcfXCzKDR6ta9JmJ7hhIm16Xfvz+z98F13kSrtP4bTrXFCO4Cf+
 gcr9A1ha3JzEczoaeu9bLZBeMUTDRYcJxzjfqA+Hc6oGjqs5jlhNF5tre3dG2EG0OZhMZWbOD9
X-Received: by 2002:a05:600c:3e06:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-48379bac81dmr19399765e9.8.1771035216806; 
 Fri, 13 Feb 2026 18:13:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0deeasm216705805e9.12.2026.02.13.18.13.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:13:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
Date: Sat, 14 Feb 2026 03:12:38 +0100
Message-ID: <20260214021240.58657-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

If a dimension is not set, have the machine init code set
the default value by calling the ppc_graphic_dimensions()
helper, common to all PowerPC machines. Declare local
variables to avoid using the global ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/ppc.h    |  2 ++
 hw/ppc/mac_newworld.c   | 10 ++++++----
 hw/ppc/mac_oldworld.c   | 10 ++++++----
 hw/ppc/ppc.c            |  8 ++++++++
 hw/ppc/prep.c           |  4 ++++
 hw/ppc/spapr.c          |  4 ++++
 system/globals-target.c |  6 ------
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index cb51d704c6d..14cc09ab22b 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -102,6 +102,8 @@ enum {
     ARCH_MAC99_U3,
 };
 
+void ppc_graphic_dimensions(int *width, int *height, int *depth);
+
 #define FW_CFG_PPC_WIDTH        (FW_CFG_ARCH_LOCAL + 0x00)
 #define FW_CFG_PPC_HEIGHT       (FW_CFG_ARCH_LOCAL + 0x01)
 #define FW_CFG_PPC_DEPTH        (FW_CFG_ARCH_LOCAL + 0x02)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 7275563a155..daf0029c01a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
     DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
     hwaddr nvram_addr = 0xFFF04000;
     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
+    int graphic_width, graphic_height, graphic_depth;
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
@@ -432,10 +433,6 @@ static void ppc_core99_init(MachineState *machine)
 
     pci_vga_init(pci_bus);
 
-    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
-        graphic_depth = 15;
-    }
-
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* The NewWorld NVRAM is not located in the MacIO device */
@@ -480,6 +477,11 @@ static void ppc_core99_init(MachineState *machine)
     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
 
+    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
+    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
+        graphic_depth = 15;
+    }
+
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index e679d338985..ea1f778877c 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
     DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
+    int graphic_width, graphic_height, graphic_depth;
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
@@ -288,10 +289,6 @@ static void ppc_heathrow_init(MachineState *machine)
         pci_create_simple(pci_bus, -1, "pci-ohci");
     }
 
-    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
-        graphic_depth = 15;
-    }
-
     /* No PCI init: the BIOS will do it */
 
     dev = qdev_new(TYPE_FW_CFG_MEM);
@@ -321,6 +318,11 @@ static void ppc_heathrow_init(MachineState *machine)
     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
 
+    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
+    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
+        graphic_depth = 15;
+    }
+
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a512d4fa647..d7b4466d701 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -29,6 +29,7 @@
 #include "qemu/timer.h"
 #include "exec/cpu-interrupt.h"
 #include "system/cpus.h"
+#include "system/system.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
@@ -1557,3 +1558,10 @@ void ppc_irq_reset(PowerPCCPU *cpu)
         kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
     }
 }
+
+void ppc_graphic_dimensions(int *width, int *height, int *depth)
+{
+    *width = graphic_width ?: 800;
+    *height = graphic_height ?: 600;
+    *depth = graphic_depth ?: 32;
+}
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c4efd1d3908..7077b047b25 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -43,6 +43,7 @@
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/reset.h"
+#include "system/system.h"
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
@@ -250,6 +251,7 @@ static void ibm_40p_init(MachineState *machine)
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
+    int graphic_width, graphic_height, graphic_depth;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -412,6 +414,8 @@ static void ibm_40p_init(MachineState *machine)
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
 
+    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
+
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 274f38785f2..c50c7da34d5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1143,6 +1143,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
     int chosen;
+    int graphic_width, graphic_height, graphic_depth;
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
 
@@ -1177,6 +1178,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
         if (machine->boot_config.has_menu && machine->boot_config.menu) {
             _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", true)));
         }
+
+        ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
+
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_width));
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_height));
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_depth));
diff --git a/system/globals-target.c b/system/globals-target.c
index 17a27a06218..ffa6c308b59 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -9,12 +9,6 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
 int graphic_width;
 int graphic_height;
 int graphic_depth;
-#else
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 32;
-#endif
-- 
2.52.0


