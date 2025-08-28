Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059D1CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau9-0003QV-UY; Thu, 28 Aug 2025 07:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau4-0003Lz-Li
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau2-0005lX-R2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3c6743a10e3so419586f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380889; x=1756985689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iam1hDuVEJ4IEWHLRQN0p7qFdPnVJgerGQJU7wZLLt8=;
 b=IIyJ8wGuotb0l+sdSf9Cj6iOlzc4rNsEMugoAwmP7QFiQFUFRujBq3ZOvR1+MH6iyC
 9uN0Kj9rXku0aWQhxHAiHj+/Y49qUFxgU0eFmNOKWZ/e9CthTzLdzkio2q93DQYjGTX4
 xuL4z50YihRialZ80mopWxkCkPGFb1TlIZP0B+CjEEQ973fwVanANMJy57qWk6sLqWqv
 9IpwUIqLlp2PwiAQN9x1kn/ay+4SByWoOSGdlC/n0MeSkTRnDm3s35dfipP5nYME+TJT
 00/rOZlwzSbEDW8YxSIODyyRBmNEa31RbsQAw/8wBUVBhrJDOUrylt9btjK2vquBtcek
 EWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380889; x=1756985689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iam1hDuVEJ4IEWHLRQN0p7qFdPnVJgerGQJU7wZLLt8=;
 b=LD73U4QxblA7f2cdPOrpUdwezXQOrStvvrKpzl7a3YBl+lltQAKkYl5y304bI02T9O
 fREEXDri93FJXLtyzCJ1T83maeT9KeKxwom6T62osGWLvCKTUDkDYwtZf+F0jxmXWasB
 MrIT6PWDUDYMKJQo6smLdjZxQr1SAsIlfhcpQJcsbYWo29zPrgKU4gKmlSNkgbcvtKSC
 jjigPNwnmli6Wyl4CrrYDw109mo4gBvNaGQxmIm3AVMbhx5Wd1IyoDFHuNcVjn1S4pHr
 jL7HpNblTIb4yjlQmz9VJ0f9AyT05V08JU6G0dni14p8xkE9tCvZeCVWdsnsra8+aBkm
 shMg==
X-Gm-Message-State: AOJu0YxQyXeOw+Nl4Mrp67CtHZaLqLLL6c80BGSqIEkGHVP7LH+xJub8
 //U6HoUnC6wnj2qCuzvggsAnv7tdjO5UG9DQxkw7RVxu1383q1VpkhXvSMhv2Scrg3xDCkdHkcF
 /X92o
X-Gm-Gg: ASbGncsp0cmGzbOv6OybOtlwtHf9LiiwlbpXul0KihHyFwWOJnRewaoQKgouKblGEKL
 oV4z+wS6pFfSJFVhrVF0omsFbLRr8xEN63Kb8O6bvUL8zy5MrbTS+UFW2tXGFS/O5PW6s6No8bf
 6dCwYYFMK5gDtXkM9H9BpThmIQMz0OJfSgjTRDyjOaCt4f9/Sqz64chGOQLHiS1hifo7s7dWdGk
 anUUwyI7VTngpElDzV2GOMCQ1k/t1l7OfpYBJ7pX4yU5sElEV0wnJ19dyelykUWcAvAL7imFNzp
 FD+6QzQw3bWeIrNofqxixyY7SS7jNyJNJpxfmaaATa18vzLqBU5SWcrVePWhajJiw2wxGpEpCrT
 X6uiWIvzhjFguLggLIQVG4zcLKkYg
X-Google-Smtp-Source: AGHT+IFss20RtRhdpwVp4fhbVZimEoadZXjKPdC6oLoKnl5A/duv7BW4/sKyi/MOKw20BMPXgMm0gA==
X-Received: by 2002:a5d:64e7:0:b0:3ca:6584:be0b with SMTP id
 ffacd0b85a97d-3ca6584c142mr10246675f8f.20.1756380888653; 
 Thu, 28 Aug 2025 04:34:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/32] hw/arm: add static NVDIMMs in device tree
Date: Thu, 28 Aug 2025 12:34:11 +0100
Message-ID: <20250828113430.3214314-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

NVDIMM is used for fast rootfs with EROFS, for example by kata
containers. To allow booting with static NVDIMM memory, add them to the
device tree in arm virt machine.

This allows users to boot directly with nvdimm memory devices without
having to rely on ACPI and hotplug.

Verified to work with command invocation:

./qemu-system-aarch64 \
  -M virt,nvdimm=on \
  -cpu cortex-a57 \
  -m 4G,slots=2,maxmem=8G \
  -object memory-backend-file,id=mem1,share=on,mem-path=/tmp/nvdimm,size=4G,readonly=off \
  -device nvdimm,id=nvdimm1,memdev=mem1,unarmed=off \
  -drive file=./debian-12-nocloud-arm64-commited.qcow2,format=qcow2 \
  -kernel ./vmlinuz-6.1.0-13-arm64 \
  -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=off"
  -initrd ./initrd.img-6.1.0-13-arm64 \
  -nographic \
  -serial mon:stdio

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20250807-nvdimm_arm64_virt-v2-1-b8054578bea8@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c |  8 +++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d391cd01bb1..1e57c4ab9ee 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "system/reset.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "system/device_tree.h"
 #include "qemu/config-file.h"
@@ -515,6 +516,29 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells,
+                             int64_t mem_base, int64_t size, int64_t node)
+{
+    int ret;
+
+    g_autofree char *nodename = g_strdup_printf("/pmem@%" PRIx64, mem_base);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
+    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells,
+                                       mem_base, scells, size);
+    if (ret) {
+        return ret;
+    }
+
+    if (node >= 0) {
+        return qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
+                                     node);
+    }
+
+    return 0;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms,
                  ARMCPU *cpu)
@@ -525,6 +549,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     unsigned int i;
     hwaddr mem_base, mem_len;
     char **node_path;
+    g_autofree MemoryDeviceInfoList *md_list = NULL;
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
@@ -628,6 +653,23 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    md_list = qmp_memory_device_list();
+    for (MemoryDeviceInfoList *m = md_list; m != NULL; m = m->next) {
+        MemoryDeviceInfo *mi = m->value;
+
+        if (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            PCDIMMDeviceInfo *di = mi->u.nvdimm.data;
+
+            rc = fdt_add_pmem_node(fdt, acells, scells,
+                                   di->addr, di->size, di->node);
+            if (rc < 0) {
+                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx64" node\n",
+                        di->addr);
+                goto fail;
+            }
+        }
+    }
+
     rc = fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9326cfc895f..1e63f40fbec 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2917,7 +2917,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (!vms->acpi_dev) {
+    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi-ged device");
         return;
@@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(ms->nvdimms_state);
     }
 
-    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
-                         dev, &error_abort);
+    if (vms->acpi_dev) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
+                             dev, &error_abort);
+    }
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
-- 
2.43.0


