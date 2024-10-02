Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5363CF318A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 01:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svnnW-0008By-Ui; Tue, 01 Oct 2024 21:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnmp-00073V-6W
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:04:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnmk-0002t9-7w
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:04:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20bb610be6aso13770295ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727831046; x=1728435846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4xBP2QStnLr7rsEthjKQX61QbXunCSIN41n1uqfLQg=;
 b=A1ghET7f1ZZYGeZy9u7R0IN1WslLztWl00uxdiNw6Kj8skKjsmrVIrEhxhqaJFF3rV
 F2VPgvcdJTy17SrWHnQZ/6ztYGPCSoI6rdIU7y8qtKvhYbrtXK6q55wE7vbHeKoHkulg
 n9vVHC8aHuuRbbqGIfxhA1a1CZTe1aJmkSk9JL73b3600v/Hg8VSZ1kMtjL8LEkY2vp0
 t4tt5A4X5f2+riH0d7fR04FwAIFhZvlAOLcSB+kIZ/LCGX3x745Rjiouzc2/EShYl/E6
 iohpHsLIImhrLgmtOchEGGWDNQoYPHuCbcQmIKinQxxnWQk5WE0wQ0fPBPQNSH5ms9F+
 xiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727831046; x=1728435846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4xBP2QStnLr7rsEthjKQX61QbXunCSIN41n1uqfLQg=;
 b=ZdNSaBEArA3gx1VmNF0kQ0cgPtIwLEYhLjqA7OyFEOrV8/f53RJVx2IyWs7Tr/ETDT
 tYBoaR7RM2+ReyBiDvkHJ8TXmRTfSBmN9lnPI52YzcArjHR7j1xJGcOr4TCFykbZgxWi
 E6N+vVVd0uL5JkPUzKfemTOwytL8e1qE4866ZiJR8qi+zfeBK7pBZdK84ybrAoVS9KIZ
 wWR9uVWX8vhGnwZA4sZUCl2ZV5J9TOgjtw1caQIxPufSUwssVUqFJi5NX+1UiKFdsw1u
 AvbwlXRuLQfT9VXslCfs8+KrCWkSIF7Oxo6cK2Ays9c3ylA8f5T1NUth70C+RkmgaW6O
 X/JQ==
X-Gm-Message-State: AOJu0YwZjjqfYaZZkz1mT8h/dV2BqmTTVF8jA738PCVHnRedTOSvIxSg
 Er29Pxppf2VwR/1w/MAC0+X8KOvV0F+IxE7QjkTiWUO29pndid2SifsIhmrHNk/gdNgQ8QtjqaA
 T
X-Google-Smtp-Source: AGHT+IFKwn6hRa7axY+4I2WoKF87sv0Ow6OQUcPQVSBh0neOm6xuzUjyOm0JViO9ZQqD4TkyXUMHag==
X-Received: by 2002:a17:902:cec1:b0:205:5d12:3f24 with SMTP id
 d9443c01a7336-20bc5a15e22mr19433895ad.20.1727831045888; 
 Tue, 01 Oct 2024 18:04:05 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d63971sm76061295ad.4.2024.10.01.18.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 18:04:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 12/12] docs/specs: add riscv-iommu
Date: Tue,  1 Oct 2024 22:03:07 -0300
Message-ID: <20241002010314.1928515-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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

Add a simple guideline to use the existing RISC-V IOMMU support we just
added.

This doc will be updated once we add the riscv-iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-iommu.rst | 90 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst | 13 ++++++
 3 files changed, 104 insertions(+)
 create mode 100644 docs/specs/riscv-iommu.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 6495ed5ed9..ff5a1f03da 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -36,3 +36,4 @@ guest hardware that is specific to QEMU.
    vmgenid
    rapl-msr
    rocker
+   riscv-iommu
diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
new file mode 100644
index 0000000000..463f4cffb6
--- /dev/null
+++ b/docs/specs/riscv-iommu.rst
@@ -0,0 +1,90 @@
+.. _riscv-iommu:
+
+RISC-V IOMMU support for RISC-V machines
+========================================
+
+QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
+version 1.0 `iommu1.0`_.
+
+The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
+RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
+device.
+
+riscv-iommu-pci reference device
+--------------------------------
+
+This device implements the RISC-V IOMMU emulation as recommended by the section
+"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device with base
+class 08h, sub-class 06h and programming interface 00h.
+
+As a reference device it doesn't implement anything outside of the specification,
+so it uses a generic default PCI ID given by QEMU: 1b36:0014.
+
+To include the device in the 'virt' machine:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci,[optional_pci_opts] (...)
+
+This will add a RISC-V IOMMU PCI device in the board following any additional
+PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
+defined by the spec but its operation is OS dependent.
+
+As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
+does not have support for features like VFIO passthrough.  The IOMMU emulation
+was tested using a public Ventana Micro Systems kernel repository in
+`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
+enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
+is feature complete feel free to use the kernel available in the Ventana Micro Systems
+mirror.
+
+The current Linux kernel support will use the IOMMU device to create IOMMU groups
+with any eligible cards available in the system, regardless of factors such as the
+order in which the devices are added in the command line.
+
+This means that these command lines are equivalent as far as the current
+IOMMU kernel driver behaves:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        (...)
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        (...)
+
+Both will create iommu groups for the two e1000e cards.
+
+Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
+considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
+use the riscv-iommu-pci device with the existing kernel support we need to emulate
+a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt	\
+     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
+
+Several options are available to control the capabilities of the device, namely:
+
+- "bus": the bus that the IOMMU device uses
+- "ioatc-limit": size of the Address Translation Cache (default to 2Mb)
+- "intremap": enable/disable MSI support
+- "ats": enable ATS support
+- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
+- "s-stage": enable s-stage support
+- "g-stage": enable g-stage support
+
+.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+
+.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
+
+.. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 9a06f95a34..8e9a2e4dda 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -84,6 +84,19 @@ none``, as in
 
 Firmware images used for pflash must be exactly 32 MiB in size.
 
+riscv-iommu support
+-------------------
+
+The board has support for the riscv-iommu-pci device by using the following
+command line:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
+
+Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU support
+works.
+
 Machine-specific options
 ------------------------
 
-- 
2.45.2


