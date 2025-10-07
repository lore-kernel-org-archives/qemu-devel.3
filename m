Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC572CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qs-0005zw-Th; Tue, 07 Oct 2025 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qe-0005qW-3i
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QL-0002JN-Ht
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so32551185e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846330; x=1760451130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fePF+CNK01A50MBnR5x5T/juuliOVBOVncbNMYtPEwA=;
 b=yclG4zRPi7pCj9szxHiWL2bMPa88g94jOG0+d6B86188jq2DzA9ofxVu7Kop2sUzW0
 n/Ev9oZGBksI+U1yt7vJsw4EnO/MS6d37jHpyZi8MFr7M6VWpFZxYkqE21t3m2ENjejf
 hivWwpLFpA680ehvtUdoTGwxiaffazYLTA7+oK8sbI1ucMIcC7khCLbKhNL+YWLonzh+
 hpOfmqDoj/+GZLs55S+6bykh/eWqqRe+HzddOWdbEBkdVEjRFUWf1CanQsKhg36fDSb9
 7Yf1IlHZrRGtk6Z87uZOxQmwgId0s58ngHY+CPgoLoNiB4vwDDacaNhTc1WJhM8P00SH
 Iiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846330; x=1760451130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fePF+CNK01A50MBnR5x5T/juuliOVBOVncbNMYtPEwA=;
 b=hfy8mJTZ5Qsf0gSW/ER4RBbTe7xO7toSyAg+0Ai8wGrKk2aU2y7phtjN5QTXe0x89Z
 Y74aeQP7iVDP+xeNjVDDMxUBOOiqYvz6CgZHKMpDTpQ9jNttYdPquI4Ebv4IjIQaLCMB
 r/pYhprd5f6f8cLFdHbCIE6VJJDbBZeGWHOhXdqemcSMQ0/Ej7y8JVWVDzHXP49X7a84
 sNL0o5q3dtX0VN/Y3OGLHPKRROllc5+Sy/qnZM57yAxLIGyr4JayGIMeStKDShbY7lpE
 skqk3SS/9/E4crlAEKjxo9rJW4A68e5VEk7xkOeZTDkCMHHRoWlMEDi91AP8o1TrLdRl
 8mow==
X-Gm-Message-State: AOJu0YyFvdu1q4vm5AcZDJ2HB4OJMi5ThbyoClhoVEhfQd4qM1RYDNcu
 gjZSMfBlywnJ01uLGExy3KQxWS2wjtjMXzxFR+IFsQESO6e1eZFiMgXz9M9x30SE0V+F9uR9kiS
 kTpsR
X-Gm-Gg: ASbGncsLTpzsTNUQ4kd6fULuJCAMNgCqppiu0vlWrefhhr7w2H+DxmAsysGUpe96jLm
 JvzBeWGLfQxOsdzhtZt5o2qzUngEcSeUjHSmIQa0tK7VcttWQp4PjVx2vnWqr9Nxjj0CXg9scMQ
 KfzAX4+NQdcBWMoF7JMYeCjQk0eqw8qx7rHvfzUkV5tsVwy9A+rxfLulE4G/s1zFXEg17HMtkd0
 nGPO5csF0aILl/IdDARdAJRhYDaDkaQ7iPDF1CN0638bJ3PeiPMUYRHkBvIT+/308HVxCXiFnvt
 dvnV8hxv5PSS+pSWuHnzPjpkXxqeIMXEL/JXL4/blxNwiTvrd8MIGWbNdChsortITdwGdEBQ+X2
 W8OOjKIFIhEHgacM9EGC0o8uu2e3uVFJYotMwHCp3wkIPm6zZptvpE6xh
X-Google-Smtp-Source: AGHT+IFMgHnmctS68vA45Rc17nq8KkUvCKardHYMXDs9R5JZbhiPNiw3nsP89ZTFi4cMZ3IY2kdmIw==
X-Received: by 2002:a05:600c:6207:b0:45d:dbf0:4831 with SMTP id
 5b1f17b1804b1-46fa28d54f0mr25898685e9.0.1759846330184; 
 Tue, 07 Oct 2025 07:12:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/62] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Date: Tue,  7 Oct 2025 15:11:02 +0100
Message-ID: <20251007141123.3239867-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc.michel@amd.com>

To align with current branding and ensure coherency with the upcoming
versal2 machine, rename the xlnx-versal-virt machine to amd-versal-virt.
Keep an alias of the old name to the new one for command-line backward
compatibility.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-42-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst         | 26 +++++++++++---------
 hw/arm/xlnx-versal-virt.c                    | 11 ++++++---
 tests/functional/aarch64/test_xlnx_versal.py |  6 ++---
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index c5f35f28e4f..2c63fbf519f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -1,19 +1,23 @@
-Xilinx Versal Virt (``xlnx-versal-virt``)
-=========================================
+AMD Versal Virt (``amd-versal-virt``)
+=====================================
 
-Xilinx Versal is a family of heterogeneous multi-core SoCs
+AMD Versal is a family of heterogeneous multi-core SoCs
 (System on Chip) that combine traditional hardened CPUs and I/O
 peripherals in a Processing System (PS) with runtime programmable
 FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
 
+QEMU implements the Versal Series variant of Versal SoCs, with the
+``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
+backward compatibility.
+
 More details here:
-https://www.xilinx.com/products/silicon-devices/acap/versal.html
+https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
 
 The family of Versal SoCs share a single architecture but come in
 different parts with different speed grades, amounts of PL and
 other differences.
 
-The Xilinx Versal Virt board in QEMU is a model of a virtual board
+The AMD Versal Virt board in QEMU is a model of a virtual board
 (does not exist in reality) with a virtual Versal SoC without I/O
 limitations. Currently, we support the following cores and devices:
 
@@ -74,7 +78,7 @@ Direct Linux boot of a generic ARM64 upstream Linux kernel:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 2G \
       -serial mon:stdio -display none \
       -kernel arch/arm64/boot/Image \
       -nic user -nic user \
@@ -87,7 +91,7 @@ Direct Linux boot of PetaLinux 2019.2:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64  -M xlnx-versal-virt -m 2G \
+  $ qemu-system-aarch64  -M amd-versal-virt -m 2G \
       -serial mon:stdio -display none \
       -kernel petalinux-v2019.2/Image \
       -append "rdinit=/sbin/init console=ttyAMA0,115200n8 earlycon=pl011,mmio,0xFF000000,115200n8" \
@@ -100,7 +104,7 @@ version of ATF tries to configure the CCI which we don't model) and U-boot:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 2G \
       -serial stdio -display none \
       -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
       -device loader,file=petalinux-v2019.2/u-boot.elf \
@@ -125,7 +129,7 @@ Boot Linux as DOM0 on Xen via U-Boot:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 4G \
       -serial stdio -display none \
       -device loader,file=petalinux-v2019.2/u-boot.elf,cpu-num=0 \
       -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
@@ -153,7 +157,7 @@ Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 4G \
       -serial stdio -display none \
       -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
       -device loader,file=petalinux-v2019.2/u-boot.elf \
@@ -227,7 +231,7 @@ To use a different index value, N, from default of 1, add:
   is highly recommended (albeit with usage complexity).
 
   Better yet, do not use actual product data when running guest image
-  on this Xilinx Versal Virt board.
+  on this AMD Versal Virt board.
 
 Using CANFDs for Versal Virt
 """"""""""""""""""""""""""""
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 274a7ef9889..6ef56103a75 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,5 +1,5 @@
 /*
- * Xilinx Versal Virtual board.
+ * AMD/Xilinx Versal Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
@@ -26,7 +26,7 @@
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
-#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
+#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
@@ -55,6 +55,7 @@ struct VersalVirt {
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
+    const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
@@ -72,7 +73,8 @@ static void fdt_create(VersalVirt *s)
 
     /* Header */
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
-    qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
+    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
+                     sizeof(versal_compat));
 }
 
 static void fdt_add_clk_node(VersalVirt *s, const char *name,
@@ -348,7 +350,8 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
 
-    mc->desc = "Xilinx Versal Virtual development board";
+    mc->desc = "AMD Versal Virtual development board";
+    mc->alias = "xlnx-versal-virt";
     mc->init = versal_virt_init;
     mc->min_cpus = num_cpu;
     mc->max_cpus = num_cpu;
diff --git a/tests/functional/aarch64/test_xlnx_versal.py b/tests/functional/aarch64/test_xlnx_versal.py
index 4b9c49e5d64..95e5c44771f 100755
--- a/tests/functional/aarch64/test_xlnx_versal.py
+++ b/tests/functional/aarch64/test_xlnx_versal.py
@@ -6,7 +6,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 
-class XlnxVersalVirtMachine(LinuxKernelTest):
+class AmdVersalVirtMachine(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
         ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/main/'
@@ -20,8 +20,8 @@ class XlnxVersalVirtMachine(LinuxKernelTest):
          '/ubuntu-installer/arm64/initrd.gz'),
         'e7a5e716b6f516d8be315c06e7331aaf16994fe4222e0e7cfb34bc015698929e')
 
-    def test_aarch64_xlnx_versal_virt(self):
-        self.set_machine('xlnx-versal-virt')
+    def test_aarch64_amd_versal_virt(self):
+        self.set_machine('amd-versal-virt')
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
 
-- 
2.43.0


