Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0079CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeSY-0000Ii-Ih; Tue, 28 Oct 2025 03:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeST-0000IR-Kw
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:49:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeS3-0006wW-R2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:49:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso27836835e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637743; x=1762242543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=swfUf7YT2HN3IdIkPCfKk032w9FveEY2Y7oYC8RTyY0=;
 b=DGCXRVD1XMUzsdPnQAIGuIpn0ADua/3BcDNS5WS+px/opOJ0YqDzUF3baqX8NCQ3QB
 fiVrdDhEx3UYdzdoJV9Z2meK8VmMvSc+iyoPdUP2QeO8UB9bOW6gY7Nc+Mu5ci5SLPLn
 Qc/N9GUIXoJtnCwzeKFy8X0Dxrc7ZVFSWIcKdzZN9zBh3lx3k2Q+RXhB0qqctlOSmA+O
 5tuRZLGmm1Og7E6MvZh6JoimP9YRNxOQJsYVo9fUBCBCSQTjSaOEoFJpxJdnR/Y7JsTX
 hwW3rAq8Sx76WauYmUBoviecJRrw6F2t/9Id76/+CIkZ1GWTrFHaVFA4/BQRE5t1nNd0
 /6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637743; x=1762242543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swfUf7YT2HN3IdIkPCfKk032w9FveEY2Y7oYC8RTyY0=;
 b=KjGJp3z3SJEVCYSpzMWmClt7haAQu47DxuyHlBXouT8RZrY6bYLXhNjG56T5/mNhvw
 2txlV4HGyjJRmypLrot6dTQIa0+U3M7skTp9RO+P76X7VewedjkZcKzzaDW2vNHjaQRF
 ZvH09KDCmStoWIftkeSSZn+5raHtYeWi7Xli6xIs2fAOAyjW1bYcoe6K6i9K4Y6M6lLD
 SLXTWloKN6mI8BneBOL6JStWYV6IUyqPN9litm/9NLfA3PGnlV/323Gd6WVumiL1ooed
 91ReVppqRrVMRNSNZIL79x0053IlI5d0bwaEKkSdrZ/Pg6dUH4kaF/h2SOoQvC+Fd6Of
 MKpw==
X-Gm-Message-State: AOJu0YzqCKnGy/naYtdmRdYkFo8+XPBNTRbhr4cwTYaQSi9/h/qBDkel
 IP6DDTMy2B6xpENTFzeqwsz/RT8fjNVNhhUE1wFAE3VLmSvh/CgerfgCPE+bnNUNdurmnvodl/I
 ZCUDpF1A=
X-Gm-Gg: ASbGncv9V6hp1G6zOmczlfkmLrmAIx3qSk7HEAAgNYJ8dLxDfc17mhlNIWErgyqCXNc
 xgnVZAdk7JFuCo+SBYjXYCWI5cxGfSoc+9cp31ggK+P1/g5CpeHT976ZYFSRUOYxvPOu6G4EjxF
 tTbaMsw+DtEHFdfS0YJhBVX4w7c1LwZjajIJM4eQA2JP62f9biRgusnjP3+bRL/KfSPScsLFfx7
 0WImA5TJgAYGYz8zx7vTFB9EDrmrEjFujeU2F04/aWimAzCnQeaKdR72+yKI1pv4+o6n+yplTyu
 RxFJ6h/pVr/G3HRX94zkn3051tAWqhhG/cujLGnMR7ahuWAl1m3yuAbqbLPY0d1jM2PuXL19kW2
 TECLs6PD3+oa3t1hmhsxWA53/K4zHKsUH/Iqv/lXDtyCwlFa1DXoqz7N4GU+4iS1YR9qAhImWaZ
 gUZIiVho5hlXa9Cea138uuEdN0K2/zuKeQBKfBRF5uOljrsZJWjqdsmdg=
X-Google-Smtp-Source: AGHT+IHDwu4lqhNf9oq80u4Z7KnlXzHBu2pijclYUroTmuLMG3ugxkwcF7ZTvZYY/inIJnTjGDdBcQ==
X-Received: by 2002:a05:600c:4fd4:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-47717e4089amr19227235e9.33.1761637743471; 
 Tue, 28 Oct 2025 00:49:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02cd6dsm186480535e9.2.2025.10.28.00.49.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:49:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/23] Misc HW patches for 2025-10-28
Date: Tue, 28 Oct 2025 08:48:36 +0100
Message-ID: <20251028074901.22062-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The following changes since commit 36076d24f04ea9dc3357c0fbe7bb14917375819c:

  Merge tag 'next-pr-pull-request' of https://gitlab.com/berrange/qemu into staging (2025-10-25 10:42:55 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251028

for you to fetch changes up to 7dbe2d7df094aa8af2d8fcdf08fccce70b1ca5bc:

  hw/riscv: Widen OpenSBI dynamic info struct (2025-10-28 08:19:18 +0100)

----------------------------------------------------------------
Misc HW patches

Various fixes and cleanups:
- Set FPCR exception flag bits for HPPA non-trapped exceptions
- Convert VirtIONet::vlans from pointer to array
  and remove VMSTATE_BUFFER_POINTER_UNSAFE()
- Remove redundant QOM typedef when OBJECT_DECLARE_SIMPLE_TYPE() is used
- Have various QDev / SysBus helpers take a const device argument
- Improve errors when loaders parse images
- Remove IntelIOMMUState::dma_translation leftover
- Remove most target_[u]long uses in hw/riscv/
- Fix DS1225Y MemoryRegion owner
- Simplification refactors on Raven PCI Host Bridge
----------------------------------------------------------------

Akihiko Odaki (1):
  nw/nvram/ds1225y: Fix nvram MemoryRegion owner

Anton Johansson (2):
  hw/riscv: Use generic hwaddr for firmware addresses
  hw/riscv: Widen OpenSBI dynamic info struct

BALATON Zoltan (5):
  hw/pci-host/raven: Simplify creating PCI facing part
  hw/pci-host/raven: Simplify PCI facing part
  hw/pci-host/raven: Simplify host bridge type declaration
  hw/pci-host/raven: Use DEFINE_TYPES macro
  hw/pci-host/raven: Simplify PCI bus creation

Clément Mathieu--Drif (1):
  hw/i386/intel_iommu: Remove an unused state field

Michael Tokarev (2):
  hw/net/virtio-net: make VirtIONet.vlans an array instead of a pointer
  migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE macro

Nguyen Dinh Phi (1):
  qom: remove redundant typedef when use OBJECT_DECLARE_SIMPLE_TYPE

Peter Maydell (1):
  target/hppa: Set FPCR exception flag bits for non-trapped exceptions

Philippe Mathieu-Daudé (4):
  hw/qdev: Have qdev_get_gpio_out_connector() take const DeviceState arg
  hw/sysbus: Have various helpers take a const SysBusDevice argument
  hw/uefi: Include missing 'system/memory.h' header
  hw/int/loongarch: Include missing 'system/memory.h' header

Vishal Chourasia (6):
  hw/core/loader: Use qemu_open() instead of open() in get_image_size()
  hw/core/loader: capture Error from load_image_targphys
  hw/core/loader: improve error handling in image loading functions
  hw/core/loader: add check for zero size in load_image_targphys_as
  hw/core/loader: Pass errp to load_image_targphys_as()
  hw/ppc: Pass error_fatal to load_image_targphys()

 hw/net/fsl_etsec/etsec.h                  |   1 -
 include/hw/char/serial.h                  |   1 -
 include/hw/i386/intel_iommu.h             |   1 -
 include/hw/input/lasips2.h                |   6 +-
 include/hw/intc/loongarch_dintc.h         |   2 +-
 include/hw/intc/loongarch_extioi_common.h |   1 +
 include/hw/intc/loongarch_pch_msi.h       |   1 +
 include/hw/intc/loongarch_pic_common.h    |   1 +
 include/hw/intc/loongson_ipi_common.h     |   1 +
 include/hw/loader.h                       |   8 +-
 include/hw/misc/auxbus.h                  |   7 +-
 include/hw/misc/bcm2835_mphi.h            |   7 +-
 include/hw/misc/npcm7xx_pwm.h             |   7 +-
 include/hw/pci-host/pnv_phb3.h            |   6 +-
 include/hw/pci-host/pnv_phb4.h            |   8 +-
 include/hw/ppc/mac_dbdma.h                |   7 +-
 include/hw/qdev-core.h                    |   3 +-
 include/hw/riscv/boot.h                   |  18 ++--
 include/hw/riscv/boot_opensbi.h           |  14 +--
 include/hw/riscv/iommu.h                  |   3 -
 include/hw/scsi/scsi.h                    |   7 +-
 include/hw/sysbus.h                       |  10 +--
 include/hw/uefi/var-service.h             |   1 +
 include/hw/vfio/vfio-container-legacy.h   |   5 +-
 include/hw/virtio/virtio-net.h            |   2 +-
 include/hw/virtio/virtio-serial.h         |   5 +-
 include/migration/vmstate.h               |   9 --
 include/net/can_emu.h                     |   7 +-
 backends/cryptodev-lkcf.c                 |   1 -
 hw/alpha/dp264.c                          |   4 +-
 hw/arm/armv7m.c                           |   2 +-
 hw/arm/boot.c                             |   5 +-
 hw/arm/digic_boards.c                     |   2 +-
 hw/arm/highbank.c                         |   3 +-
 hw/arm/raspi.c                            |   2 +-
 hw/arm/vexpress.c                         |   2 +-
 hw/char/ipoctal232.c                      |   9 +-
 hw/char/xen_console.c                     |   1 -
 hw/core/generic-loader.c                  |   5 +-
 hw/core/gpio.c                            |   3 +-
 hw/core/guest-loader.c                    |   4 +-
 hw/core/loader.c                          |  42 ++++++---
 hw/core/sysbus.c                          |  10 +--
 hw/dma/pl330.c                            |   6 +-
 hw/hppa/machine.c                         |   5 +-
 hw/i386/multiboot.c                       |   2 +-
 hw/i386/x86-common.c                      |   4 +-
 hw/ipmi/ipmi_bmc_sim.c                    |   2 +-
 hw/loongarch/boot.c                       |   5 +-
 hw/m68k/an5206.c                          |   2 +-
 hw/m68k/mcf5208.c                         |   4 +-
 hw/m68k/next-cube.c                       |   2 +-
 hw/m68k/q800.c                            |   7 +-
 hw/m68k/virt.c                            |   4 +-
 hw/microblaze/boot.c                      |   5 +-
 hw/mips/boston.c                          |   2 +-
 hw/mips/fuloong2e.c                       |   9 +-
 hw/mips/jazz.c                            |   2 +-
 hw/mips/loongson3_virt.c                  |  10 ++-
 hw/mips/malta.c                           |   9 +-
 hw/net/virtio-net.c                       |   9 +-
 hw/net/xen_nic.c                          |   2 -
 hw/nubus/nubus-device.c                   |   2 +-
 hw/nvram/ds1225y.c                        |   2 +-
 hw/openrisc/boot.c                        |   5 +-
 hw/pci-host/bonito.c                      |   7 +-
 hw/pci-host/raven.c                       | 105 +++++++---------------
 hw/pci/pci.c                              |   2 +-
 hw/ppc/amigaone.c                         |  13 +--
 hw/ppc/e500.c                             |  20 +----
 hw/ppc/mac_newworld.c                     |  19 ++--
 hw/ppc/mac_oldworld.c                     |  19 ++--
 hw/ppc/pef.c                              |   1 -
 hw/ppc/pegasos2.c                         |  10 +--
 hw/ppc/pnv.c                              |  27 ++----
 hw/ppc/ppc440_bamboo.c                    |   9 +-
 hw/ppc/prep.c                             |  19 ++--
 hw/ppc/sam460ex.c                         |   8 +-
 hw/ppc/spapr.c                            |  17 +---
 hw/ppc/virtex_ml507.c                     |  11 +--
 hw/riscv/boot.c                           |  49 +++++-----
 hw/riscv/microchip_pfsoc.c                |   2 +-
 hw/riscv/sifive_u.c                       |   2 +-
 hw/riscv/spike.c                          |   4 +-
 hw/riscv/virt.c                           |   2 +-
 hw/rx/rx-gdbsim.c                         |   2 +-
 hw/s390x/ipl.c                            |   8 +-
 hw/sh4/r2d.c                              |   8 +-
 hw/smbios/smbios.c                        |   2 +-
 hw/sparc/leon3.c                          |   4 +-
 hw/sparc/sun4m.c                          |   8 +-
 hw/sparc64/sun4u.c                        |   7 +-
 hw/usb/dev-mtp.c                          |   7 +-
 hw/usb/dev-uas.c                          |   7 +-
 hw/xtensa/xtfpga.c                        |   3 +-
 system/device_tree.c                      |   2 +-
 target/hppa/fpu_helper.c                  |   7 +-
 97 files changed, 321 insertions(+), 434 deletions(-)

-- 
2.51.0


