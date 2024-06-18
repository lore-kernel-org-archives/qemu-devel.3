Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA177C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHZ-0004qZ-Gm; Tue, 18 Jun 2024 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHX-0004af-MN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:03 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHU-0006v0-4O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:02 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d07464aa9so39606a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726518; x=1719331318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/tagi0H3adLyS3W/8Dhxle+M9RlwA1PgWDySU+Dgls=;
 b=hJVuJ3hzyMHcP2ruGNYzpcLSvWENi187/ETMk2lDiKSLrhbY3e6YtVFUMjkoxHbQJ0
 eQw4XYY8VqojmtzI2QtKfCcLcmK5U3winUIPjenThLpZESl5CtFBrG0xnvO9ZhpBMAxf
 GRmc0Jdgp582rACKbsbDuXuGzgUFaAinLobi1w3goQNopB8CCsEhV2czUCzUZo7uLT3b
 1snHDMpyu7UC39WIdbr3BzMiaSjcX9F8vaJDyqxPYNPecALqPoF8SxX1/dzIt4BbF7Qu
 pjFpvanM7iPvtbV11IRjz9YsaHIPTbNXCFEID4PQxZh2WjIOTwe25rDyFAfvTyUhLmPT
 AKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726518; x=1719331318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/tagi0H3adLyS3W/8Dhxle+M9RlwA1PgWDySU+Dgls=;
 b=xElWcRmw7gOg3WQR///62B+Q9ruKPQJyctV0XfaENpOmL/w3CKxyAnbZbmRQU/Wb/I
 tc4n83I7lF5UxiWV0ZhHKV5SlcQUrr+YTR5LQ0iYHftbt9nwsz7CD4sZTmfgRCvezMk8
 Azs5qW10gv1h7B9V8O9zeIh4hkbZQB6+BzS9OJ1dBmreK4LvgsyUGNYYBXFFE8Akrup5
 /DhLifK6CJNvLv1MX0L6IE7N5D6yZJZEBdv7y+B4KzZ7olYUW2pCQKjvTE3GJ333K3XK
 TwEAnvji1HqsvB+IrK6HLXer+ovUCKJNkSKxmUotc6PWuPN/oVTY278fE+wpgvXeB3pF
 HBTg==
X-Gm-Message-State: AOJu0YyLVkVnB1AgKwBviedQ4EUhf46FVjsb7AsqFVmJ6bXN4yKrWiLU
 5cviNCU3aWXbNaMAoU7hDrIT5VSxEaLKOk+Gnc7WtUuQtHPwlCTacmI09vejF8o281oVhKcmbE6
 7
X-Google-Smtp-Source: AGHT+IFeO10JrnLn4Ubqpvwma3iAnjIxQR9Y0uR6/EkenoqnienXJCP1q4fGa3rDNgD28g7Vu0u2/A==
X-Received: by 2002:a50:ab53:0:b0:57a:2ccb:b3e5 with SMTP id
 4fb4d7f45d1cf-57cbd8e8c1dmr6587342a12.42.1718726518238; 
 Tue, 18 Jun 2024 09:01:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e5a3sm7813974a12.65.2024.06.18.09.01.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 13/76] hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
Date: Tue, 18 Jun 2024 17:59:35 +0200
Message-ID: <20240618160039.36108-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
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

PCMachineClass::enforce_aligned_dimm was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true. Remove it, simplifying pc_get_device_memory_range().
Update the comment in Avocado test_phybits_low_pse36().

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-14-philmd@linaro.org>
---
 include/hw/i386/pc.h                  |  3 ---
 hw/i386/pc.c                          | 14 +++-----------
 tests/avocado/mem-addr-space-check.py |  9 ++++-----
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5667b87ed0..ca72f8cab8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -74,8 +74,6 @@ typedef struct PCMachineState {
  *
  * Compat fields:
  *
- * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
- *                        backend's alignment value if provided
  * @acpi_data_size: Size of the chunk of memory at the top of RAM
  *                  for the BIOS ACPI tables and other BIOS
  *                  datastructures.
@@ -114,7 +112,6 @@ struct PCMachineClass {
     /* RAM / address space compat: */
     bool gigabyte_align;
     bool has_reserved_memory;
-    bool enforce_aligned_dimm;
     bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 215462e861..ff5683a8ee 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -728,7 +728,6 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
                                        hwaddr *base,
                                        ram_addr_t *device_mem_size)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineState *machine = MACHINE(pcms);
     ram_addr_t size;
     hwaddr addr;
@@ -736,10 +735,8 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
     size = machine->maxram_size - machine->ram_size;
     addr = ROUND_UP(pc_above_4g_end(pcms), 1 * GiB);
 
-    if (pcmc->enforce_aligned_dimm) {
-        /* size device region assuming 1G page max alignment per slot */
-        size += (1 * GiB) * machine->ram_slots;
-    }
+    /* size device region assuming 1G page max alignment per slot */
+    size += (1 * GiB) * machine->ram_slots;
 
     *base = addr;
     *device_mem_size = size;
@@ -1303,12 +1300,9 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
 static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
-    const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     const X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
-    const uint64_t legacy_align = TARGET_PAGE_SIZE;
     Error *local_err = NULL;
 
     /*
@@ -1333,8 +1327,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
-                     pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
@@ -1798,7 +1791,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-    pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->isa_bios_alias = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
index af019969c0..85541ea051 100644
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/avocado/mem-addr-space-check.py
@@ -31,11 +31,10 @@ def test_phybits_low_pse36(self):
         at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
         we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
         hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
-        for dimm alignment for all newer machines (see enforce_aligned_dimm
-        property for pc machines and pc_get_device_memory_range()). That leaves
-        total hotpluggable actual memory size of 59 GiB. If the VM is started
-        with 0.5 GiB of memory, maxmem should be set to a maximum value of
-        59.5 GiB to ensure that the processor can address all memory directly.
+        for dimm alignment for all machines. That leaves total hotpluggable
+        actual memory size of 59 GiB. If the VM is started with 0.5 GiB of
+        memory, maxmem should be set to a maximum value of 59.5 GiB to ensure
+        that the processor can address all memory directly.
         Note that 64-bit pci hole size is 0 in this case. If maxmem is set to
         59.6G, QEMU should fail to start with a message "phy-bits are too low".
         If maxmem is set to 59.5G with all other QEMU parameters identical, QEMU
-- 
2.41.0


