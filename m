Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E400CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6m-0003c1-Rc; Thu, 28 Mar 2024 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6k-0003K1-4S
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:02 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6i-0002IU-9C
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:01 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so1282122a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641358; x=1712246158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlOZmiJcfWhY/E5lc2Om2vdspo8I2MenAyugtnCqPJ8=;
 b=f21uSOyCySSMOqPB44Usm/FXaQQGWzlQgVB1SPVdp5pwWlRj5e+0ehCrabNYUgcQ6Q
 bfXglLE1eZrwidEBkvwC3x0Bo/wevvxz8BYjaHRuvd4Z/5LL0Dkw5VyFHbqfVDwRDojQ
 Fy4bYKwlwQXLP9nntSXMAsjBYt5FOcWhzgeRbZoC309Bcf/oQgnBwOuZ22h5y5EzhXiH
 vwWKox+bmLobJHNqTMhEnFztGc3Uu/IKRE7NZ17cftXZn21dyfcPhMbiJ6YhlY4Id8nV
 h5tw4V/ZR/nXVKk+0KYuZ8haP/OxUBTO/QcK62DPpmOutKriFdfXEt6JAmhn47934ZGm
 r2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641358; x=1712246158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlOZmiJcfWhY/E5lc2Om2vdspo8I2MenAyugtnCqPJ8=;
 b=XtTRM9E8GHvSrG2yGlKo9Df6QA0yyx6BfQxKSNe2WYWkXeeveRYj4UXAIOS+JRD4xJ
 h7bZpsPOS7U76CXMnl4ihjvrExk6KBKPS3EyylWOjnyh3FGDG2v7dsFILXY8r2A4/qMG
 u8YmBuGikkRwVKCdHmjNcLp4qNkCxC+qWQBSZ8AjB1N1L5rL2p+GbotXVQIdBkZAhb7x
 FQqDtQ5iEKuWGY27I47D/H8IAaEL2EhwD/SrWdEMxRMGllSI7bGNrqrXyRibhjrpuYIK
 w91/eHe/cBLjUVH/vHmH5ORDAEw4zppn8HcSI5fZlfr1mNtoLzTtKT6SfBLb/NYLZXn9
 0HiA==
X-Gm-Message-State: AOJu0Yy8s6ucyMIUhGVzHe8X55GY9SygVkyyNF6XjcvVqqqEAdoQCtCg
 3UE0kr8jToM+UfG0KEnfwGSsiNvqjMJB+BcWiDgN4yjw9JuTEQtkzbUuFJfo05cbQxaJhDmm+OM
 +
X-Google-Smtp-Source: AGHT+IEHlPzirbO0NxvTAiaCR1AzHmEf11L/n2EPgKkmIcgFqhAD5O/Yt/mmGevQB4ExiPCyjyrkcg==
X-Received: by 2002:a50:d650:0:b0:56b:cda3:6de6 with SMTP id
 c16-20020a50d650000000b0056bcda36de6mr2166952edj.42.1711641358386; 
 Thu, 28 Mar 2024 08:55:58 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 g20-20020aa7c594000000b0056be0d1cd83sm954932edq.97.2024.03.28.08.55.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>
Subject: [RFC PATCH-for-9.1 12/29] hw/i386/pc: Move acpi_build_enabled to
 PcPciMachineState
Date: Thu, 28 Mar 2024 16:54:20 +0100
Message-ID: <20240328155439.58719-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Since only PCI-based machines use the 'acpi_build_enabled',
move it to PcPciMachineState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-build.h  | 2 +-
 include/hw/i386/pc.h  | 3 ++-
 hw/i386/acpi-build.c  | 8 ++++----
 hw/i386/pc.c          | 5 ++---
 hw/i386/xen/xen-hvm.c | 3 ++-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 31de5bddbd..4c1511c432 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -10,7 +10,7 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 #define ACPI_PCIHP_SEJ_BASE 0x8
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
-void acpi_setup(PCMachineState *pcms);
+void acpi_setup(PcPciMachineState *ppms);
 Object *acpi_get_i386_pci_host(void);
 
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index dd5ee448ef..67f8f4730b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -41,7 +41,6 @@ typedef struct PCMachineState {
     SmbiosEntryPointType smbios_entry_point_type;
     const char *south_bridge;
 
-    bool acpi_build_enabled;
     bool smbus_enabled;
     bool sata_enabled;
     bool hpet_enabled;
@@ -61,6 +60,8 @@ typedef struct PcPciMachineState {
 
     Notifier machine_done;
 
+    bool acpi_build_enabled;
+
     CXLState cxl_devices_state;
 } PcPciMachineState;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e702d5e9d2..ee0e99a2fa 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2749,9 +2749,9 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-void acpi_setup(PCMachineState *pcms)
+void acpi_setup(PcPciMachineState *ppms)
 {
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    X86MachineState *x86ms = X86_MACHINE(ppms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
@@ -2765,7 +2765,7 @@ void acpi_setup(PCMachineState *pcms)
         return;
     }
 
-    if (!pcms->acpi_build_enabled) {
+    if (!ppms->acpi_build_enabled) {
         ACPI_BUILD_DPRINTF("ACPI build disabled. Bailing out.\n");
         return;
     }
@@ -2778,7 +2778,7 @@ void acpi_setup(PCMachineState *pcms)
     build_state = g_malloc0(sizeof *build_state);
 
     acpi_build_tables_init(&tables);
-    acpi_build(&tables, MACHINE(pcms));
+    acpi_build(&tables, MACHINE(ppms));
 
     /* Now expose it all to Guest */
     build_state->table_mr = acpi_add_rom_blob(acpi_build_update,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 47fe3a7c02..f184808e3e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -627,7 +627,7 @@ static void pc_pci_machine_done(Notifier *notifier, void *data)
 
     fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
 
-    acpi_setup(pcms);
+    acpi_setup(ppms);
 }
 
 /* setup pci memory address space mapping into system address space */
@@ -1687,9 +1687,8 @@ static void pc_machine_initfn(Object *obj)
 static void pc_pci_machine_initfn(Object *obj)
 {
     PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
-    PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->acpi_build_enabled = true;
+    ppms->acpi_build_enabled = true;
 
     cxl_machine_init(obj, &ppms->cxl_devices_state);
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 7745cb3963..ce48d51842 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -586,6 +586,7 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
 void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     MachineState *ms = MACHINE(pcms);
+    PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);
     unsigned int max_cpus = ms->smp.max_cpus;
     int rc;
     xen_pfn_t ioreq_pfn;
@@ -624,7 +625,7 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
     xen_ram_init(pcms, ms->ram_size, ram_memory);
 
     /* Disable ACPI build because Xen handles it */
-    pcms->acpi_build_enabled = false;
+    ppms->acpi_build_enabled = false;
 
     return;
 
-- 
2.41.0


