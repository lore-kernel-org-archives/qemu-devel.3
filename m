Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D262C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Xf-0006II-Ox; Mon, 17 Jun 2024 03:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xe-0006HB-G1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:38 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xb-0002Is-Jz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6ef793f4b8so420379866b.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608354; x=1719213154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4GxrLrwuscCW965PEoGdFuOYAiJgmw5yLVhtIAV2tE=;
 b=QW5Dzbw/JCz9dzRCjVhTYvYnzSC+QiTcKXb/dEzQyzTIC78M25EAUKx5niImWOKVQB
 tW74pnWTXE1Ein8B/zFB2s5hmKtt3hKaWYQI0HLVjCkpHU/dGJIIyJ5mwT6NrrkSTNLs
 E/NUNG+Z9myOaOtbHX5N+KIyT4+WMIQwYxgdXqvTXkrum7QEhnOqY5wclpUcbb05ZZfZ
 SfcL8MoUTAJBfE+zfHwd84sUR4aqE3xMeJICuqX0KptO6KmqaUJjwAdlmdMCKQvsBegI
 ptYW/mXonRtT6172B6S/49CmOCM7iNt4JioXGumPsMPlwiQ8Y9V380RH3tPpy03h65/0
 fqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608354; x=1719213154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4GxrLrwuscCW965PEoGdFuOYAiJgmw5yLVhtIAV2tE=;
 b=FAKxnZ8FGdvLO8QIIn3XxObpFtjGeR/NVEN/oGyFEc3HrIdLfu1RgbazGVJ3xiEcST
 Zhr05/kYTQ8glYoEFjiYP4n4S44YvUj9NfRdVU2aAL1eb8Q7oGgLzTjiKfbj07HqdYFg
 jYvpLFu4yc5ISHZRsnYpnnXO13/ovqGz8LYmo0uAF1GSsM/r3Wj0CVMZ2E6q9iv9aSFW
 QCCXirSYfPr1prYMdeWRPf3TqkwkaTa1/LtfqSsGgl8IJ+wa/b/l6luog86ELsC7kjSp
 SDoMNrWw7dbcv6H3dE7Hqypv2yDdNdZwjDaxIe8OyeIT4L0CDwvtJ7o4M00KTz+g6PKl
 AWQQ==
X-Gm-Message-State: AOJu0YxY70Mk7A1muDyCw06wnkuBhb+jz5hixBcOe9qpYoZ2X0h/TEbn
 ly8I+b/kO1kEVN3ozV0DHNVIYoT694vz5/LDB5oamJYwFAJyoFdAHKg3PyXXVQOie5ztmCJlryv
 d4fk=
X-Google-Smtp-Source: AGHT+IGoAuzOPScfuNRmCwG3jHowMVU4uvvGEJMdGIsQ3F1CfOLt8K4ivMBmj38k2nYw9G36t0miSw==
X-Received: by 2002:a17:906:ca0d:b0:a6f:fbc:b3f3 with SMTP id
 a640c23a62f3a-a6f60dc89cbmr530751566b.47.1718608353929; 
 Mon, 17 Jun 2024 00:12:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41a91sm492762466b.172.2024.06.17.00.12.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 13/23] hw/i386/pc: Remove
 PCMachineClass::enforce_aligned_dimm
Date: Mon, 17 Jun 2024 09:11:08 +0200
Message-ID: <20240617071118.60464-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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


