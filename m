Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174E4C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCVC-0007IC-71; Thu, 08 Feb 2024 17:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV9-0007HW-9I
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:11 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV2-0005E5-GG
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:11 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3a77f27524so33791166b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429842; x=1708034642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+sbS1QwX/gsxCqYTOaBHcFunWzBKDsUd+myGLHH3IA=;
 b=kYp7wAR0wxRtq9z97lKL4ccDopjCA0YADnNfYkycILCuJfLigxbXFkK1gE8wNwKH2j
 91azF/2yuDhrHmnGZVFnc8w8WYu7AkRUhztFpvr4eqV+U9FqdNv+cZjeAuykpj66ShPo
 6mDUcc7Zg62BFMAeKgfN0B/1Fu78HWaiye/Zo87S05gQLm6rrAs9HrGPXdb3U/rL/wQn
 DOrjbAGzK6liJFhgl5//apWSqJciKVg9ed9aNHfhIIfDJoNnyjAKs6wGndty7wAOwk6D
 Ujh4c0FN16y49qdB0GpWvjVskSDEqzlKo6GYNJZMJxWXxHCZ4TuceZQcApid16Te9Yf9
 ELoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429842; x=1708034642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+sbS1QwX/gsxCqYTOaBHcFunWzBKDsUd+myGLHH3IA=;
 b=uyztfdF5Y6c61sux1tZFn5d70f4BJovHA9zjVq7soBa8LtnWTNd51MXkZRYSKRtxuf
 RUVPCe1T/6Mo8BVxK8GDUhH9QEjp5RP8xMaLviNArkmiRMpt+8BL8UbbsLkWVJQIwgib
 dKRdRqKSvX0cQlkU7Rew/S+9+LIAaxyon3ewPa+f2r0v4PlhWmZ1kLkjft0AVq06N77E
 cyVbyebxCOQxsq0cdIY63QLc4MCOE9MOJkP1rYRmdVDKsbG7ffJuy2nORuDrgP0clYwi
 HHFToMFqHZ/5Lhfb8fXchxACLIPJ8i6IMPoBLwXtMJ50Dqvei2+Z27t2NXXEjEexU/gG
 HDmA==
X-Gm-Message-State: AOJu0YwizgYUaD+sHabMkmG1E9CNxBAOKNG/2yvHn1PGzuMCmBXVdJgt
 +LI2BUSyx5BY+TiFBah3CaXqPmyhdyzAHtuSSw64K0wBckPejxO2uvcY+I6Q
X-Google-Smtp-Source: AGHT+IHnLwWssXDQhYvd42Fg3tl3ZBvZmgVvUsGqnnMBpr9jvIhODvlj+038nJGJ4MYvT7+lc1A1DA==
X-Received: by 2002:a17:906:bcf4:b0:a38:3f84:1a67 with SMTP id
 op20-20020a170906bcf400b00a383f841a67mr441121ejb.17.1707429841707; 
 Thu, 08 Feb 2024 14:04:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVu6RsUJhGgSWDiobHrZBqXUU3AoH/zy/nscoI8WVCMDIE0hVzx5Wv9sv+uQNb6bmkH6L++CgUUMo+ikkSdxaUutL9B7CyTnnuLwWcL+vGcJySqbG0Ki8AxNL3A8CyCXWpxu9l3RydCbSZYXeHIVs9PqvOIs74PxNVz9guTMhuDE8/uPm7WbklIShHDGNCcFEv7xnWJheBcui/rhkGIe1o5K+tkmJrMKmqSGV8ef8WtbTtbBOkB
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:04:01 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 5/9] hw/i386/pc: Defer smbios_set_defaults() to machine_done
Date: Thu,  8 Feb 2024 23:03:45 +0100
Message-ID: <20240208220349.4948-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.001, TVD_PH_BODY_META_ALL=1.771,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Handling most of smbios data generation in the machine_done notifier is similar
to how the ARM virt machine handles it which also calls smbios_set_defaults()
there. The result is that all pc machines are freed from explicitly worrying
about smbios setup.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/fw_cfg.h     |  3 ++-
 include/hw/i386/pc.h |  1 -
 hw/i386/fw_cfg.c     | 12 +++++++++++-
 hw/i386/pc.c         |  2 +-
 hw/i386/pc_piix.c    | 10 ----------
 hw/i386/pc_q35.c     |  9 ---------
 6 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 86ca7c1c0c..1e1de6b4a3 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -10,6 +10,7 @@
 #define HW_I386_FW_CFG_H
 
 #include "hw/boards.h"
+#include "hw/i386/pc.h"
 #include "hw/nvram/fw_cfg.h"
 
 #define FW_CFG_IO_BASE     0x510
@@ -22,7 +23,7 @@
 FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                uint16_t boot_cpus,
                                uint16_t apic_id_limit);
-void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
+void fw_cfg_build_smbios(PCMachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 287f1ab553..0e6c41e908 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -12,7 +12,6 @@
 #include "hw/hotplug.h"
 #include "qom/object.h"
 #include "hw/i386/sgx-epc.h"
-#include "hw/firmware/smbios.h"
 #include "hw/cxl/cxl.h"
 
 #define HPET_INTCAP "hpet-intcap"
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 7362daa45a..98a478c276 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -48,15 +48,25 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     return NULL;
 }
 
-void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
+void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
 {
 #ifdef CONFIG_SMBIOS
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
     unsigned i, array_count;
+    MachineState *ms = MACHINE(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
+    if (pcmc->smbios_defaults) {
+        /* These values are guest ABI, do not change */
+        smbios_set_defaults("QEMU", mc->desc, mc->name,
+                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
+                            pcms->smbios_entry_point_type);
+    }
+
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 45738d8548..369c21fb99 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -699,7 +699,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (x86ms->fw_cfg) {
-        fw_cfg_build_smbios(MACHINE(pcms), x86ms->fw_cfg);
+        fw_cfg_build_smbios(pcms, x86ms->fw_cfg);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4ca2dc08e7..5addaae978 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -36,7 +36,6 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
-#include "hw/firmware/smbios.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
@@ -226,15 +225,6 @@ static void pc_init1(MachineState *machine,
                                                &error_abort);
     }
 
-    if (pcmc->smbios_defaults) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc,
-                            mc->name, pcmc->smbios_legacy_mode,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index fe0c2849fd..5184abda92 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -45,7 +45,6 @@
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/display/ramfb.h"
-#include "hw/firmware/smbios.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
 #include "hw/intc/ioapic.h"
@@ -199,14 +198,6 @@ static void pc_q35_init(MachineState *machine)
         rom_memory = system_memory;
     }
 
-    if (pcmc->smbios_defaults) {
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc,
-                            mc->name, pcmc->smbios_legacy_mode,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
-    }
-
     /* create pci host bus */
     phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
 
-- 
2.43.0


