Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B2EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9M-0006Yu-MM; Fri, 08 Mar 2024 06:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9I-0006XW-9r
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY8z-0001Mi-NP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso15501695ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896323; x=1710501123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A6IIbrqJZkXOvG2Gdd5VDi3UGBuGvM83Fnh65GNOBvs=;
 b=YLnjtqSnIsnYqDoASKYvWNGe0kBr8MT3EnNHsFRudA4l4X7bawu9OIU88WN48VQqKg
 hBaWpuEkr6c5wUBXnjSEGu7GzawZKQgKHWxDxIAejv0VLkpjwgiY9wG1bjmyy4U/oHto
 Sxg+2XjtUM/W28zjNBHeHyhyFhLRx1ZyQ7xRPWzqeF14/dcyj0yz6QT3X10ZLGysT+3j
 oJAsJwbU89jEkqD+gpDUEyznKI6DWqAQ0nu7xlbpBNt4UqbvPA/bQD7WADSiKgOXiIB+
 40mMOjPft+3cdoiGt7T0Jw/S7CBNsozrP8Byl7Y6durfHhkk6jgeUNxdYYuj3K52K5Oj
 JEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896323; x=1710501123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6IIbrqJZkXOvG2Gdd5VDi3UGBuGvM83Fnh65GNOBvs=;
 b=VA6PTmBOTFBrRu/ItPN1kZ5DsP07PAKDF+m8n8uA9oZeA8KmLHLAEVcU9kMmdtxtBy
 9rxrbeZD5ETcreZ3N7I1Q+LzkHPQG+A9beeMSXpF4HVZ9Kwv2VKvA+nceM76SPrCCVyG
 99uuPON+jIy2nG9V2qTvfI6jsBOVZmdKkcVP96RHvILrGPv6/OsTweLX8ckhNOZkrJVS
 ch9U5J43Sy7xU7vMqH5NMsqIfMpL6uHIZQdkuzvDcrvVO6PCeUbg+ce0YSw1HSi71Y+q
 HX3OYyOMq9HLBB4UUIXjCw/C66JfpMdq0hyBaiRlbodsVlqwbQF7rK8lHxac+1ghdsmz
 L9cw==
X-Gm-Message-State: AOJu0Yy3BA8nGA/ntC5c+zNYe/IAHMSqYIEXdICPZFA3seT2OwskgjpQ
 7sJtjL7UDkV3KjeAOSwu/0VFVM6/7cu/s6siS8t8lkNWtvpxFLeuOu5p1gRhoeXoIw==
X-Google-Smtp-Source: AGHT+IFIf79G0dRAjfjmX/0pYSqJ/Gk2VV8ifDlpz5dznk/0vVpwEGrHsBcLP1xkHK7+5Ek3saDQIw==
X-Received: by 2002:a17:902:ecc2:b0:1dc:fc0b:3d0 with SMTP id
 a2-20020a170902ecc200b001dcfc0b03d0mr13133280plh.14.1709896323469; 
 Fri, 08 Mar 2024 03:12:03 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/34] riscv-to-apply queue
Date: Fri,  8 Mar 2024 21:11:18 +1000
Message-ID: <20240308111152.2856137-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:

  Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240308-1

for you to fetch changes up to 301876597112218c1e465ecc2b2fef6b27d5c27b:

  target/riscv: fix ACPI MCFG table (2024-03-08 21:00:37 +1000)

----------------------------------------------------------------
RISC-V PR for 9.0

* Update $ra with current $pc in trans_cm_jalt
* Enable SPCR for SCPI virt machine
* Allow large kernels to boot by moving the initrd further away in RAM
* Sync hwprobe keys with kernel
* Named features riscv,isa, 'svade' rework
* FIX xATP_MODE validation
* Add missing include guard in pmu.h
* Add SRAT and SLIT ACPI tables
* libqos fixes and add a riscv machine
* Add Ztso extension
* Use 'zfa' instead of 'Zfa'
* Update KVM exts to Linux 6.8
* move ratified/frozen exts to non-experimental
* Ensure mcountinhibit, mcounteren, scounteren, hcounteren are 32-bit
* mark_vs_dirty() before loads and stores
* Remove 'is_store' bool from load/store fns
* Fix shift count overflow
* Fix setipnum_le write emulation for APLIC MSI-mode
* Fix in_clrip[x] read emulation
* Fix privilege mode of G-stage translation for debugging
* Fix ACPI MCFG table for virt machine

----------------------------------------------------------------
Alexandre Ghiti (1):
      hw: riscv: Allow large kernels to boot by moving the initrd further away in RAM

Andrew Jones (3):
      target/riscv: Reset henvcfg to zero
      target/riscv: Gate hardware A/D PTE bit updating
      target/riscv: Promote svade to a normal extension

Anup Patel (2):
      hw/intc/riscv_aplic: Fix setipnum_le write emulation for APLIC MSI-mode
      hw/intc/riscv_aplic: Fix in_clrip[x] read emulation

Christoph Müllner (4):
      linux-user/riscv: Add Zicboz extensions to hwprobe
      linux-user/riscv: Sync hwprobe keys with Linux
      linux-user/riscv: Add Ztso extension to hwprobe
      tests: riscv64: Use 'zfa' instead of 'Zfa'

Daniel Henrique Barboza (12):
      target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
      target/riscv: add riscv,isa to named features
      target/riscv: add remaining named features
      hw/riscv/virt.c: create '/soc/pci@...' fdt node earlier
      hw/riscv/virt.c: add virtio-iommu-pci hotplug support
      hw/riscv/virt.c: make aclint compatible with 'qtest' accel
      tests/libqos: add riscv/virt machine nodes
      linux-headers: Update to Linux v6.8-rc6
      target/riscv/kvm: update KVM exts to Linux 6.8
      target/riscv: move ratified/frozen exts to non-experimental
      trans_rvv.c.inc: mark_vs_dirty() before loads and stores
      trans_rvv.c.inc: remove 'is_store' bool from load/store fns

Frank Chang (1):
      target/riscv: Add missing include guard in pmu.h

Haibo Xu (1):
      hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables

Hiroaki Yamamoto (1):
      target/riscv: Fix privilege mode of G-stage translation for debugging

Ilya Chugin (1):
      target/riscv: fix ACPI MCFG table

Irina Ryapolova (2):
      target/riscv: FIX xATP_MODE validation
      target/riscv: UPDATE xATP write CSR

Jason Chien (1):
      target/riscv: Update $ra with current $pc in trans_cm_jalt()

Palmer Dabbelt (1):
      RISC-V: Add support for Ztso

Sia Jee Heng (2):
      hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location
      hw/riscv/virt-acpi-build.c: Generate SPCR table

Vadim Shakirov (1):
      target/riscv: mcountinhibit, mcounteren, scounteren, hcounteren is 32-bit

demin.han (1):
      target/riscv: Fix shift count overflow

 include/hw/acpi/acpi-defs.h                    |  33 ++++++
 include/hw/acpi/aml-build.h                    |   4 +
 include/standard-headers/drm/drm_fourcc.h      |  10 +-
 include/standard-headers/linux/ethtool.h       |  41 +++++---
 include/standard-headers/linux/virtio_config.h |   8 +-
 include/standard-headers/linux/virtio_pci.h    |  68 ++++++++++++
 include/standard-headers/linux/virtio_pmem.h   |   7 ++
 linux-headers/asm-generic/unistd.h             |  15 ++-
 linux-headers/asm-mips/mman.h                  |   2 +-
 linux-headers/asm-mips/unistd_n32.h            |   5 +
 linux-headers/asm-mips/unistd_n64.h            |   5 +
 linux-headers/asm-mips/unistd_o32.h            |   5 +
 linux-headers/asm-powerpc/unistd_32.h          |   5 +
 linux-headers/asm-powerpc/unistd_64.h          |   5 +
 linux-headers/asm-riscv/kvm.h                  |  40 +++++++
 linux-headers/asm-s390/unistd_32.h             |   5 +
 linux-headers/asm-s390/unistd_64.h             |   5 +
 linux-headers/asm-x86/kvm.h                    |   3 +
 linux-headers/asm-x86/unistd_32.h              |   5 +
 linux-headers/asm-x86/unistd_64.h              |   5 +
 linux-headers/asm-x86/unistd_x32.h             |   5 +
 linux-headers/linux/iommufd.h                  |  79 ++++++++++++++
 linux-headers/linux/kvm.h                      | 140 +++++++++----------------
 linux-headers/linux/userfaultfd.h              |  29 ++++-
 linux-headers/linux/vfio.h                     |   1 +
 target/riscv/cpu.h                             |   8 +-
 target/riscv/cpu_cfg.h                         |  13 ++-
 target/riscv/pmu.h                             |   5 +
 hw/acpi/aml-build.c                            |  53 ++++++++++
 hw/arm/virt-acpi-build.c                       |  68 +++++-------
 hw/intc/riscv_aplic.c                          |  37 +++++--
 hw/riscv/boot.c                                |  12 +--
 hw/riscv/virt-acpi-build.c                     | 103 +++++++++++++++++-
 hw/riscv/virt.c                                |  97 ++++++++++++-----
 linux-user/syscall.c                           | 104 ++++++++++++++++--
 target/riscv/cpu.c                             |  94 +++++++++++------
 target/riscv/cpu_helper.c                      |  21 +++-
 target/riscv/csr.c                             |  58 +++++-----
 target/riscv/kvm/kvm-cpu.c                     |  29 +++++
 target/riscv/machine.c                         |  16 +--
 target/riscv/tcg/tcg-cpu.c                     |  34 +++---
 target/riscv/translate.c                       |   3 +
 target/riscv/vector_helper.c                   |   5 +-
 tests/qtest/libqos/riscv-virt-machine.c        | 137 ++++++++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc        |  11 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |  16 ++-
 target/riscv/insn_trans/trans_rvv.c.inc        |  97 +++++++++--------
 target/riscv/insn_trans/trans_rvzce.c.inc      |   6 +-
 tests/qtest/libqos/meson.build                 |   1 +
 tests/tcg/riscv64/Makefile.target              |   2 +-
 50 files changed, 1213 insertions(+), 347 deletions(-)
 create mode 100644 tests/qtest/libqos/riscv-virt-machine.c

