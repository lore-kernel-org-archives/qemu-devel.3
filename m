Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C14CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7d-0005EA-MN; Thu, 28 Mar 2024 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7L-0004aW-DN
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:44 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7J-0002Ve-JZ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:39 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso1315132a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641396; x=1712246196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvS5b4mOvRgBMXReEbw8mHkHwY6O9r1j8WjPX6hg3zo=;
 b=yQG8nxLXUsIhy97Z2qz79nI0mLusIbLwc+Tc7VKe9VPE5pjS7zcap8QMh/mRsgQ7ZW
 acP9BMOTPrkud7/D6oBuEc1L2r5a5l251CNJBuEPpK5XPAR6u4YFFSu0M9y8jW5DY0O9
 kxbkfknwbJHfpemXOJliVEk7jYjWp/xYTqjiDZEz+LLPOiRfj1FVFqyHSKiq1YmKdqSq
 9Tqy9Ud7x9iVzK9SFA+CDY4/TN5fMzEsKrOy5K91FfLbfKXxTdRKvUZNXqJ0vDKB3zaO
 lXlcafmrg5JxBDvJYar9mQ1DzP0DHsPzM7OJpT00yKMhe56EOl3KvBgDjAixyPv/TJSt
 QJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641396; x=1712246196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mvS5b4mOvRgBMXReEbw8mHkHwY6O9r1j8WjPX6hg3zo=;
 b=nUQi8Dbz3W+CzXeMtTtAaMso+TV57+lNUGnfwKEb2RrO3fXo8BIfst3I0FToGm3ykB
 R2CyeZ3ASRGEENnI1bKiRGj/IJ27JzYAdf9PZdx410g242VnIc4nz3xMDqVywLrjN09V
 Y/Xfo0FYLnqxL+V6y+dvbatN4gIay+yukJMgdGtrtqEhJt6VrI9C9pJaadBemC/1FEsJ
 nti/iPkpj2pDy2XuWtpS5Gxm+FROT2jlgO09DYRg3Ll00xPTqu8ohO2tlFGShONwj0Qp
 dYS8ZsENXvIFEKyt/DhquCSqdbNfcpmxN/Q9X2zX2xMlVGJ6P83U48xLSOLBJ1Gf1k5J
 RkhQ==
X-Gm-Message-State: AOJu0Yxm5KRxtBAtDz7IZLFNtP4IVQzZ0OFbYuyoHAxxGMisky5LA87r
 NJAoTUs+cRf0T3pBr7Cel8b/H8M6/6g98p01sqRlzR16TSO5UZ6qPP1D9pGB+Vayej/xF+rR0pS
 +
X-Google-Smtp-Source: AGHT+IHfWPHo1qaEN4DNEm3R8wOVj4A4iUDXGogGmGPb4Wx0aiRPAERFSIayiOeRYDhmlaAPcH41sw==
X-Received: by 2002:a50:d6d7:0:b0:568:a9f3:b3fb with SMTP id
 l23-20020a50d6d7000000b00568a9f3b3fbmr2267809edj.8.1711641395712; 
 Thu, 28 Mar 2024 08:56:35 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 l13-20020a056402028d00b0056bfa6ad5eesm959518edv.91.2024.03.28.08.56.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:35 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 18/29] hw/i386/pc: Inline has_reserved_memory()
Date: Thu, 28 Mar 2024 16:54:26 +0100
Message-ID: <20240328155439.58719-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

All PCI-based machines have the has_reserved_memory
field set to %true. Simplify by using an inlined helper
checking whether the machine is PCI-based or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/pc.c         | 17 ++++++++++-------
 hw/i386/pc_piix.c    |  1 -
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 758dd5f29b..df4c813854 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -91,7 +91,6 @@ typedef struct PCMachineClass {
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
-    bool has_reserved_memory;
     bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 093a7c35f7..e36d76656b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -671,6 +671,11 @@ void xen_load_linux(PCMachineState *pcms)
 #define PC_ROM_ALIGN       0x800
 #define PC_ROM_SIZE        (PC_ROM_MAX - PC_ROM_MIN_VGA)
 
+static bool has_reserved_memory(PCMachineState *pcms)
+{
+    return pc_machine_is_pci_enabled(pcms);
+}
+
 static hwaddr pc_above_4g_end(PCMachineState *pcms)
 {
     X86MachineState *x86ms = X86_MACHINE(pcms);
@@ -702,12 +707,11 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
 
 static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineState *ms = MACHINE(pcms);
     hwaddr cxl_base;
     ram_addr_t size;
 
-    if (pcmc->has_reserved_memory &&
+    if (has_reserved_memory(pcms) &&
         (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &cxl_base, &size);
         cxl_base += size;
@@ -760,7 +764,7 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
      * calculating the highest possible GPA so that we can properly report
      * if someone configures them on a CPU that cannot possibly address them.
      */
-    if (pcmc->has_reserved_memory &&
+    if (has_reserved_memory(pcms) &&
         (ms->ram_size < ms->maxram_size)) {
         hwaddr devmem_start;
         ram_addr_t devmem_size;
@@ -891,7 +895,7 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
     }
 
-    if (!pcmc->has_reserved_memory &&
+    if (!has_reserved_memory(pcms) &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
 
@@ -901,7 +905,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     /* initialize device memory address space */
-    if (pcmc->has_reserved_memory &&
+    if (has_reserved_memory(pcms) &&
         (machine->ram_size < machine->maxram_size)) {
         ram_addr_t device_mem_size;
         hwaddr device_mem_base;
@@ -1024,7 +1028,7 @@ uint64_t pc_pci_hole64_start(void)
 
     if (ppms->cxl_devices_state.is_enabled) {
         hole64_start = pc_get_cxl_range_end(pcms);
-    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
+    } else if (has_reserved_memory(pcms) && (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &hole64_start, &size);
         if (!pcmc->broken_reserved_end) {
             hole64_start += size;
@@ -1752,7 +1756,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     pcmc->smbios_defaults = true;
-    pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0bc14da768..e6178f8653 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -830,7 +830,6 @@ static void isapc_machine_options(MachineClass *m)
     m->rom_file_has_mr = false;
     pcmc->smbios_defaults = false;
     pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-- 
2.41.0


