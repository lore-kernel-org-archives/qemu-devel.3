Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442FAC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nF-0003jc-Ms; Sun, 12 May 2024 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66nC-0003f7-8B
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66nA-0006Ai-C5
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QW9slmgUMBgN92tL/jIafWR7wfUVS6WiVT+oj3PWMQ4=;
 b=Lwea6S22glnlBy2aZtD3ZnYynnvceF0p62TDpMKzlCY5xtEIoceSM/jzLOeGWURDc2DGZw
 Gc4QMCpls95AnwIkHcKewPeriCUHg+pyHcwe2W4uaWgNRVBwo358QIAGOGLk7wujbwD4nG
 3VN7ipzvZ7RiCPK3Mpm11m1utlNsj5c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-QTO42i03MJ6IaWl4qpPnqA-1; Sun, 12 May 2024 06:50:52 -0400
X-MC-Unique: QTO42i03MJ6IaWl4qpPnqA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so219070066b.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511051; x=1716115851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QW9slmgUMBgN92tL/jIafWR7wfUVS6WiVT+oj3PWMQ4=;
 b=lMDq1Vdyp1arzVOd1AdBH+jStWLAbwW4M1cuU+REam/J6urcfjtLfAj2SUGDQHIrn6
 u2P12ZyhTbKtjIEXqA/k0omk+JkNLNENbkg+YR1DK9SrZPKbg7AmdACmKfKmpe8h6INb
 z40FnPr6n5++Se3zFqKYdyhSfpqueDtBVn5AQu8H+upKgZVVoRGJeJ3KIq3oK+rb9Nft
 eHjV663rDZfg3X3ba72fSeeCQWaFXo/7AwMseoUDZZiCOgg+de1M/bc8rDouhor9q7DZ
 1FlnlTIEKa7FeU7B90xlQYLx/5UV+gsSICcn9tEu/HxUcM/5gHmGf1sBLLfX5m7ghEET
 F0vw==
X-Gm-Message-State: AOJu0YzB7hG2D3rQ8CY9qyCT91RHmZLipYx7XiweEEuIPsv934DDdHRY
 Ey2z8ypuFrgs45H1ZDok2R6464RY9PV1Ol5Mshlink3LWcOqszDHsD9oYOPXy57uiZFgK6f5zjn
 huyNZ5qTSPgCJ63GKxLhZriQ/v5YKCJRwJWbXHYKZ46IHuxxNc8b+uMWzHBUd2qKtVyukvc3tfQ
 6RPG7TXRb+svw7AJkJGWRsiEE7II1C8hvQzES2
X-Received: by 2002:a50:d6d9:0:b0:572:9c4c:2503 with SMTP id
 4fb4d7f45d1cf-5734d70378fmr4756941a12.38.1715511050902; 
 Sun, 12 May 2024 03:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH088AjG8HxrJ4zh0JdZsq8xzT5+8GUR+PbIHYc+a4YmHYwnJ5ik3zOw8zQcvYRZm9O1vXfOQ==
X-Received: by 2002:a50:d6d9:0:b0:572:9c4c:2503 with SMTP id
 4fb4d7f45d1cf-5734d70378fmr4756930a12.38.1715511050385; 
 Sun, 12 May 2024 03:50:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea65f8sm4571569a12.17.2024.05.12.03.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/27] kconfig: express dependency of individual boards on
 libfdt
Date: Sun, 12 May 2024 12:49:43 +0200
Message-ID: <20240512104945.130198-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that boards are enabled by default and the "CONFIG_FOO=y"
entries are gone from configs/devices/, there cannot be any more
a conflicts between the default contents of configs/devices/
and a failed "depends on" clause.

With this change, each individual board or target can express
whether it needs FDT.  It can then include the common code in the
build via "select DEVICE_TREE", which will also as tell meson to link
with libfdt.

This allows building non-microvm x86 emulators without having
libfdt available.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Kconfig.host              |  1 -
 hw/arm/Kconfig            |  5 +++++
 hw/i386/Kconfig           |  3 ++-
 hw/loongarch/Kconfig      |  3 ++-
 hw/mips/Kconfig           |  3 ++-
 hw/openrisc/Kconfig       |  2 ++
 hw/ppc/Kconfig            | 15 ++++++++-------
 hw/riscv/Kconfig          |  4 ++++
 hw/rx/Kconfig             |  3 ++-
 hw/xtensa/Kconfig         |  1 +
 target/arm/Kconfig        |  2 ++
 target/microblaze/Kconfig |  1 +
 target/openrisc/Kconfig   |  1 +
 target/riscv/Kconfig      |  2 ++
 14 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/Kconfig.host b/Kconfig.host
index a0d4a52131e..17f405004b3 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -25,7 +25,6 @@ config TPM
 
 config FDT
     bool
-    select DEVICE_TREE
 
 config VHOST_USER
     bool
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 98c264ed219..8b97683a45e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM_VIRT
     select ACPI
     select ARM_SMMUV3
     select GPIO_KEY
+    select DEVICE_TREE
     select FW_CFG_DMA
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
@@ -265,6 +266,7 @@ config SBSA_REF
     default y
     depends on TCG && AARCH64
     imply PCI_DEVICES
+    select DEVICE_TREE
     select AHCI
     select ARM_SMMUV3
     select GPIO_KEY
@@ -347,6 +349,7 @@ config VEXPRESS
     bool
     default y
     depends on TCG && ARM
+    select DEVICE_TREE
     select A9MPCORE
     select A15MPCORE
     select ARM_MPTIMER
@@ -492,6 +495,7 @@ config XLNX_ZYNQMP_ARM
     select CPU_CLUSTER
     select DDC
     select DPCD
+    select DEVICE_TREE
     select SDHCI
     select SSI
     select SSI_M25P80
@@ -509,6 +513,7 @@ config XLNX_VERSAL
     depends on TCG && AARCH64
     select ARM_GIC
     select CPU_CLUSTER
+    select DEVICE_TREE
     select PL011
     select CADENCE
     select VIRTIO_MMIO
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 40b1e445808..f4a33b6c082 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -115,7 +115,8 @@ config Q35
 config MICROVM
     bool
     default y
-    depends on I386
+    depends on I386 && FDT
+    select DEVICE_TREE
     select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
     select APIC
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index ad77502445a..90a0dba9d59 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -1,7 +1,8 @@
 config LOONGARCH_VIRT
     bool
     default y
-    depends on LOONGARCH64
+    depends on LOONGARCH64 && FDT
+    select DEVICE_TREE
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
     imply VIRTIO_VGA
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 9bccb363eb9..a7f26edebe8 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -80,9 +80,10 @@ config MIPS_CPS
 config MIPS_BOSTON
     bool
     default y
-    depends on MIPS64 && !TARGET_BIG_ENDIAN
+    depends on MIPS64 && !TARGET_BIG_ENDIAN && FDT
     imply PCI_DEVICES
     imply TEST_DEVICES
+    select DEVICE_TREE
     select FITLOADER
     select MIPS_CPS
     select PCI_EXPRESS_XILINX
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 9c9015e0a5d..76b953c62c2 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -2,6 +2,7 @@ config OR1K_SIM
     bool
     default y
     depends on OPENRISC
+    select DEVICE_TREE
     select SERIAL
     select OPENCORES_ETH
     select OMPIC
@@ -14,6 +15,7 @@ config OR1K_VIRT
     imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
+    select DEVICE_TREE
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
     select GOLDFISH_RTC
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 78f83e78ce5..347212f4dba 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -1,7 +1,7 @@
 config PSERIES
     bool
     default y
-    depends on PPC64
+    depends on PPC64 && FDT
     imply USB_OHCI_PCI
     imply PCI_DEVICES
     imply TEST_DEVICES
@@ -26,7 +26,7 @@ config SPAPR_RNG
 config POWERNV
     bool
     default y
-    depends on PPC64
+    depends on PPC64 && FDT
     imply PCI_DEVICES
     imply TEST_DEVICES
     select ISA_IPMI_BT
@@ -52,7 +52,7 @@ config PPC405
 config PPC440
     bool
     default y
-    depends on PPC
+    depends on PPC && FDT
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply E1000_PCI
@@ -71,7 +71,7 @@ config PPC4XX
 config SAM460EX
     bool
     default y
-    depends on PPC
+    depends on PPC && FDT
     select PFLASH_CFI01
     select IDE_SII3112
     select M41T80
@@ -168,19 +168,19 @@ config E500
 config E500PLAT
     bool
     default y
-    depends on PPC
+    depends on PPC && FDT
     select E500
 
 config MPC8544DS
     bool
     default y
-    depends on PPC
+    depends on PPC && FDT
     select E500
 
 config VIRTEX
     bool
     default y
-    depends on PPC
+    depends on PPC && FDT
     select PPC4XX
     select PFLASH_CFI01
     select SERIAL
@@ -193,6 +193,7 @@ config FW_CFG_PPC
     bool
 
 config FDT_PPC
+    select DEVICE_TREE
     bool
 
 config VOF
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5f5f9e31bb0..a2030e3a6ff 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -12,6 +12,7 @@ config MICROCHIP_PFSOC
     depends on RISCV64
     select CADENCE_SDHCI
     select CPU_CLUSTER
+    select DEVICE_TREE
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
@@ -37,6 +38,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
     select PCI
@@ -82,6 +84,7 @@ config SIFIVE_U
     depends on RISCV32 || RISCV64
     select CADENCE
     select CPU_CLUSTER
+    select DEVICE_TREE
     select RISCV_ACLINT
     select SIFIVE_GPIO
     select SIFIVE_PDMA
@@ -99,6 +102,7 @@ config SPIKE
     bool
     default y
     depends on RISCV32 || RISCV64
+    select DEVICE_TREE
     select RISCV_NUMA
     select HTIF
     select RISCV_ACLINT
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index b2fa2b7eec3..aa9242d1ef6 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -8,5 +8,6 @@ config RX62N_MCU
 config RX_GDBSIM
     bool
     default y
-    depends on RX
+    depends on RX && FDT
+    select DEVICE_TREE
     select RX62N_MCU
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index 443b415c2ba..8ea283a7a3b 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -15,6 +15,7 @@ config XTENSA_XTFPGA
     bool
     default y
     depends on XTENSA
+    imply DEVICE_TREE
     select OPENCORES_ETH
     select PFLASH_CFI01
     select SERIAL
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index 5847c5a74a7..7f8a2217ae1 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -6,6 +6,8 @@ config ARM
     # translate.c v7m helpers under ARM_V7M.
     select ARM_V7M if TCG
 
+    select DEVICE_TREE # needed by boot.c
+
 config AARCH64
     bool
     select ARM
diff --git a/target/microblaze/Kconfig b/target/microblaze/Kconfig
index a5410d9218d..e91d58d88f2 100644
--- a/target/microblaze/Kconfig
+++ b/target/microblaze/Kconfig
@@ -1,2 +1,3 @@
 config MICROBLAZE
     bool
+    select DEVICE_TREE # needed by boot.c
diff --git a/target/openrisc/Kconfig b/target/openrisc/Kconfig
index e0da4ac1dfc..cd66c2e3b6c 100644
--- a/target/openrisc/Kconfig
+++ b/target/openrisc/Kconfig
@@ -1,2 +1,3 @@
 config OPENRISC
     bool
+    select DEVICE_TREE # needed by boot.c
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index adb7de3f37d..5f30df22f2f 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,7 +1,9 @@
 config RISCV32
     bool
     select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
     select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    select DEVICE_TREE # needed by boot.c
-- 
2.45.0


