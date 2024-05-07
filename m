Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DF1C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4F7P-0007gL-7Z; Tue, 07 May 2024 03:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7M-0007fk-UR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7J-0004Ol-IJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d6uNgPV+Xc59StsW5rnTX10dlVLFM5J/r5XHX8X8xDQ=;
 b=eCyDByQB5FRvf+KHSDz/GJE1RN8TGaaoPucSp9J5IbXMWhe0qlelitnbzX6QF8wHL0mkUW
 nEtMxzLJl55nikgZm/tUk9q43OiToRxsgh93WAMDmkGtY09QXTlF5B6RlUznCiJwfBk9HO
 9oG87JNcsMgULsz41TFacrIvOpZR290=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-zBExPBzqOh65MUSNX-JRpw-1; Tue, 07 May 2024 03:19:59 -0400
X-MC-Unique: zBExPBzqOh65MUSNX-JRpw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59ab39c8b6so180372366b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066397; x=1715671197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6uNgPV+Xc59StsW5rnTX10dlVLFM5J/r5XHX8X8xDQ=;
 b=u3yMlEqys7dJq3dk561l5d5LTl3pP4LGfVu1Cq0NHrxgQblimhMR3RWvAyhuzfP1nX
 SLXD4pGpjVUbrtIe2sgzVxPZ2PnCETg8sf2Kat88m7CkMlUCa+cgD8KCwj56MA1pc3nP
 aj5rl3BH6E+kUutXbtkCjvB9U5PHiIYsZarNMq9LUAJ9hT4IoKqskkbmYKszCyYJq/W/
 1QUqEPi1WTbffj9Vhpp7RRabqgTMP80ejxOjlzU1rDWYBCaWi5ahEYlD58D3i3Ifu5hN
 ny6ehK7qVXRDfXCiyHqJSCs+ZpbxrZWWrOrCrhAN7smc6eRNLQbKQtwGp7VMnxLVFX0z
 RKRQ==
X-Gm-Message-State: AOJu0YzgRvzbVeLTStbGqhaobLC3v2mdxXHZQenl/kP2//oN/HdY/S2x
 ct7J2qZK8Wn4BlF+RmUOkriAOchKoQEo/HOjZ2dcJx+5QAxukSMnv+i7D+VKMpUWiAPgQNH6A0N
 ZEW5Ca840cO3A747EZ+kfNBHJnlMLrimEw54UVEQkmgDedNlKyNq+lLp9aYmCANkNV8iJDNB489
 8iDL7NgL3+oqw8QOCdnrpEaqw/kmWp+h+qAA90
X-Received: by 2002:a17:907:ca01:b0:a59:8cd2:5b2c with SMTP id
 uk1-20020a170907ca0100b00a598cd25b2cmr6101611ejc.39.1715066396848; 
 Tue, 07 May 2024 00:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXQhun8j2jl9fwMP078ZCx75dFsxiNYpk+N7TINUWm0A2q0qD67XTnZoDCRVdUjcWQ1lD7aQ==
X-Received: by 2002:a17:907:ca01:b0:a59:8cd2:5b2c with SMTP id
 uk1-20020a170907ca0100b00a598cd25b2cmr6101597ejc.39.1715066396399; 
 Tue, 07 May 2024 00:19:56 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a170906604e00b00a58a3238522sm6064435ejj.207.2024.05.07.00.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 00:19:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 2/4] kconfig: express dependency of individual boards on libfdt
Date: Tue,  7 May 2024 09:19:46 +0200
Message-ID: <20240507071948.105022-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507071948.105022-1-pbonzini@redhat.com>
References: <20240507071948.105022-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
whether it needs FDT.  It can also include it in the
build via "select DEVICE_TREE", instead of having each hw/*/meson.build
file do it by hand, and this will bring in more components
such as CONFIG_GUEST_LOADER.

This allows building non-microvm x86 emulators without having
libfdt available.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               |  1 +
 Kconfig.host              |  3 +++
 hw/arm/Kconfig            |  5 +++++
 hw/arm/meson.build        |  2 +-
 hw/core/Kconfig           |  9 ++++++++-
 hw/core/meson.build       |  2 +-
 hw/i386/Kconfig           |  3 ++-
 hw/loongarch/Kconfig      |  3 ++-
 hw/loongarch/meson.build  |  2 +-
 hw/mips/Kconfig           |  1 +
 hw/mips/meson.build       |  2 +-
 hw/openrisc/Kconfig       |  2 ++
 hw/openrisc/meson.build   |  4 ++--
 hw/ppc/Kconfig            | 15 ++++++++-------
 hw/ppc/meson.build        |  4 +---
 hw/riscv/Kconfig          |  4 ++++
 hw/riscv/meson.build      |  2 +-
 hw/rx/Kconfig             |  3 ++-
 hw/xtensa/Kconfig         |  1 +
 system/meson.build        |  2 +-
 target/arm/Kconfig        |  2 ++
 target/microblaze/Kconfig |  1 +
 target/openrisc/Kconfig   |  1 +
 target/riscv/Kconfig      |  2 ++
 24 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/meson.build b/meson.build
index 530f92c0a9c..3ae95215083 100644
--- a/meson.build
+++ b/meson.build
@@ -2986,6 +2986,7 @@ host_kconfig = \
   (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
   (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
   (x11.found() ? ['CONFIG_X11=y'] : []) + \
+  (fdt.found() ? ['CONFIG_FDT=y'] : []) + \
   (have_vhost_user ? ['CONFIG_VHOST_USER=y'] : []) + \
   (have_vhost_vdpa ? ['CONFIG_VHOST_VDPA=y'] : []) + \
   (have_vhost_kernel ? ['CONFIG_VHOST_KERNEL=y'] : []) + \
diff --git a/Kconfig.host b/Kconfig.host
index f6a2a131e6c..17f405004b3 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -23,6 +23,9 @@ config IVSHMEM
 config TPM
     bool
 
+config FDT
+    bool
+
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
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 6808135c1f7..aefde0c69a3 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'), fdt)
+arm_ss.add(files('boot.c'))
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index 9397503656d..24411f59306 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -4,8 +4,14 @@ config EMPTY_SLOT
 config PTIMER
     bool
 
+config DEVICE_TREE
+    bool
+    # fail the build if libfdt not found
+    depends on FDT
+
 config FITLOADER
     bool
+    depends on DEVICE_TREE
 
 config GENERIC_LOADER
     bool
@@ -14,13 +20,14 @@ config GENERIC_LOADER
 config GUEST_LOADER
     bool
     default y
-    depends on TCG
+    depends on TCG && DEVICE_TREE
 
 config OR_IRQ
     bool
 
 config PLATFORM_BUS
     bool
+    depends on DEVICE_TREE
 
 config REGISTER
     bool
diff --git a/hw/core/meson.build b/hw/core/meson.build
index f20d4143f7a..a3d9bab9f42 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -16,7 +16,7 @@ common_ss.add(files('cpu-common.c'))
 common_ss.add(files('machine-smp.c'))
 system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
 system_ss.add(when: 'CONFIG_GENERIC_LOADER', if_true: files('generic-loader.c'))
-system_ss.add(when: ['CONFIG_GUEST_LOADER', fdt], if_true: files('guest-loader.c'))
+system_ss.add(when: 'CONFIG_GUEST_LOADER', if_true: files('guest-loader.c'))
 system_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
 system_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 4362164962c..5af47f4bf2f 100644
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
index 78640505630..830cfef72db 100644
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
diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index d306d82c2ee..bce7ebac97e 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -3,7 +3,7 @@ loongarch_ss.add(files(
     'fw_cfg.c',
     'boot.c',
 ))
-loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'), fdt])
+loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('virt.c'))
 loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
 
 hw_arch += {'loongarch': loongarch_ss}
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 9bccb363eb9..e540e10e094 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -83,6 +83,7 @@ config MIPS_BOSTON
     depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
+    select DEVICE_TREE
     select FITLOADER
     select MIPS_CPS
     select PCI_EXPRESS_XILINX
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index f06d88f3430..ca37c42d900 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -9,7 +9,7 @@ if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
-mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: [files('boston.c'), fdt])
+mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
 endif
 
 hw_arch += {'mips': mips_ss}
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
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
index 2dbc6365bb7..82f1f0ef1cc 100644
--- a/hw/openrisc/meson.build
+++ b/hw/openrisc/meson.build
@@ -1,7 +1,7 @@
 openrisc_ss = ss.source_set()
 openrisc_ss.add(files('cputimer.c'))
 openrisc_ss.add(files('boot.c'))
-openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: [files('openrisc_sim.c'), fdt])
-openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: [files('virt.c'), fdt])
+openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
+openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
 
 hw_arch += {'openrisc': openrisc_ss}
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
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index d096636ee7f..3ebbf329bcc 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -3,9 +3,7 @@ ppc_ss.add(files(
   'ppc.c',
   'ppc_booke.c',
 ))
-ppc_ss.add(when: 'CONFIG_FDT_PPC', if_true: [files(
-  'fdt.c',
-), fdt])
+ppc_ss.add(when: 'CONFIG_FDT_PPC', if_true: files('fdt.c'))
 ppc_ss.add(when: 'CONFIG_FW_CFG_PPC', if_true: files('fw_cfg.c'))
 
 # IBM pSeries (sPAPR)
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
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2f7ee81be3c..f872674093a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,5 @@
 riscv_ss = ss.source_set()
-riscv_ss.add(files('boot.c'), fdt)
+riscv_ss.add(files('boot.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
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
diff --git a/system/meson.build b/system/meson.build
index 25e21172505..d67328538d0 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -32,7 +32,7 @@ if have_tpm
 endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
-system_ss.add(when: fdt, if_true: files('device_tree.c'))
+system_ss.add(when: 'CONFIG_DEVICE_TREE', if_true: [fdt, files('device_tree.c')])
 if host_os == 'linux'
   system_ss.add(files('async-teardown.c'))
 endif
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


