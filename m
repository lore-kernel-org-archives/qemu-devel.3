Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB9E68950
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFZ-0007CS-61; Wed, 30 Oct 2024 23:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFW-0007CF-TX
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFU-0003sC-T7
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso5815315ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346807; x=1730951607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P8eqvkfwFvQorBMJ4XRJsxCi/uRH/Csmoy5FNIpHbE0=;
 b=Lc9BgZAdc5ZTbhOGw6yIXWqWgHTtSjfssAdgFsiHPiJpnMOhJggEhhCMp8X13RbaxA
 aRj2g9OO9fo1IFvkhzQeX27ZyxZ7aWES2V2SxgH1wxZcWJQka5UeJSLlM4U52v18CeS3
 06ZvNA8NrkfLaGvt04XqY2rsPMzOv6QRn15uttLL/phr74GcmZ1/ignJQ0JHcCmDmRwm
 gqJ9c+Ve6lSbm1s4TVy+2QP6z7ccWKNpe8e5bOd3FpDQVWVHOZf2pGkAqm5u3IfuFAyy
 bkZJVBs9c0ojh9QL+s8+fUNNntLDuF9r2l/UiyCgnFJ9hPmDBjErlfB/Lu4L0bhlsaeQ
 LzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346807; x=1730951607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P8eqvkfwFvQorBMJ4XRJsxCi/uRH/Csmoy5FNIpHbE0=;
 b=iFUQy5UAnRk29PfENr8/vhhGoo05N2d2J87FrAZe/XxNF1uSoPWh/AzMKXJlSlQ65Q
 1GyceBsajmHZg8n8KDWkU2R6tUhrKPtDhU2p406jKYHOJ8Co5QhTB9utpJp2Xfx3Xxat
 idcnjVJmO4h4dnxng0984v7ESzuYS+QjR2jzGSYw9ue6eBLlLnd7IbIMxlBSF8N2lMbq
 5aN7hQ6hO4m+95vgL7nYdp5kRW2mO2L19Iwtzz7pdQonQxIwIOCt6UBdh3ELHnGyvZ9C
 BNmeJMUH1GdqNf+G4NgDBMfw7bJiDtUYYsJUaY4GaISEX4ip/JVREOV+X2I89erIJpsP
 hP/A==
X-Gm-Message-State: AOJu0YxiKuA/iNeqzqlrYTAQe8tMSR3X42QYSlBsPsXULG8ODRwi9yRg
 /xXnzuLSHuuSbeLFUuQNQhwhMETMhuM5FK/vWJZ8hxmv6DYuguWCvU5/UG/Y
X-Google-Smtp-Source: AGHT+IEiuOVayWChDZEXKVqt7I+/F17Hf06yWjMTN1LtzkTLhUdkyFVVXpgCr1IuHPDjvJJq2yBYPw==
X-Received: by 2002:a17:903:11cd:b0:20c:6f55:2195 with SMTP id
 d9443c01a7336-210c6c920a2mr239115865ad.47.1730346806629; 
 Wed, 30 Oct 2024 20:53:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/50] riscv-to-apply queue
Date: Thu, 31 Oct 2024 13:52:28 +1000
Message-ID: <20241031035319.731906-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241031-1

for you to fetch changes up to c128d39edeff337220fc536a3e935bcba01ecb49:

  target/riscv: Fix vcompress with rvv_ta_all_1s (2024-10-31 13:51:24 +1000)

----------------------------------------------------------------
RISC-V PR for 9.2

* Fix an access to VXSAT
* Expose RV32 cpu to RV64 QEMU
* Don't clear PLIC pending bits on IRQ lowering
* Make PLIC zeroth priority register read-only
* Set vtype.vill on CPU reset
* Check and update APLIC pending when write sourcecfg
* Avoid dropping charecters with HTIF
* Apply FIFO backpressure to guests using SiFive UART
* Support for control flow integrity extensions
* Support for the IOMMU with the virt machine
* set 'aia_mode' to default in error path
* clarify how 'riscv-aia' default works

----------------------------------------------------------------
Alistair Francis (2):
      hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
      hw/char: sifive_uart: Print uart characters async

Anton Blanchard (1):
      target/riscv: Fix vcompress with rvv_ta_all_1s

Daniel Henrique Barboza (6):
      pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
      test/qtest: add riscv-iommu-pci tests
      qtest/riscv-iommu-test: add init queues test
      docs/specs: add riscv-iommu
      target/riscv/kvm: set 'aia_mode' to default in error path
      target/riscv/kvm: clarify how 'riscv-aia' default works

Deepak Gupta (20):
      target/riscv: expose *envcfg csr and priv to qemu-user as well
      target/riscv: Add zicfilp extension
      target/riscv: Introduce elp state and enabling controls for zicfilp
      target/riscv: save and restore elp state on priv transitions
      target/riscv: additional code information for sw check
      target/riscv: tracking indirect branches (fcfi) for zicfilp
      target/riscv: zicfilp `lpad` impl and branch tracking
      disas/riscv: enable `lpad` disassembly
      target/riscv: Expose zicfilp extension as a cpu property
      target/riscv: Add zicfiss extension
      target/riscv: introduce ssp and enabling controls for zicfiss
      target/riscv: tb flag for shadow stack instructions
      target/riscv: mmu changes for zicfiss shadow stack protection
      target/riscv: AMO operations always raise store/AMO fault
      target/riscv: update `decode_save_opc` to store extra word2
      target/riscv: implement zicfiss instructions
      target/riscv: compressed encodings for sspush and sspopchk
      disas/riscv: enable disassembly for zicfiss instructions
      disas/riscv: enable disassembly for compressed sspush/sspopchk
      target/riscv: Expose zicfiss extension as a cpu property

Evgenii Prokopiev (1):
      target/riscv/csr.c: Fix an access to VXSAT

LIU Zhiwei (2):
      target/riscv: Add max32 CPU for RV64 QEMU
      tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU

Rob Bradford (1):
      target/riscv: Set vtype.vill on CPU reset

Sergey Makarov (2):
      hw/intc: Make zeroth priority register read-only
      hw/intc: Don't clear pending bits on IRQ lowering

TANG Tiancheng (6):
      target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
      target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
      target/riscv: Correct SXL return value for RV32 in RV64 QEMU
      target/riscv: Detect sxl to set bit width for RV32 in RV64
      target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
      target/riscv: Enable RV32 CPU support in RV64 QEMU

Tomasz Jeznach (8):
      exec/memtxattr: add process identifier to the transaction attributes
      hw/riscv: add riscv-iommu-bits.h
      hw/riscv: add RISC-V IOMMU base emulation
      hw/riscv: add riscv-iommu-pci reference device
      hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
      hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
      hw/riscv/riscv-iommu: add ATS support
      hw/riscv/riscv-iommu: add DBG support

Yong-Xuan Wang (1):
      hw/intc/riscv_aplic: Check and update pending when write sourcecfg

 docs/specs/index.rst                           |    1 +
 docs/specs/pci-ids.rst                         |    2 +
 docs/specs/riscv-iommu.rst                     |   90 +
 docs/system/riscv/virt.rst                     |   13 +
 configs/targets/riscv64-softmmu.mak            |    2 +-
 meson.build                                    |    1 +
 disas/riscv.h                                  |    4 +
 hw/riscv/riscv-iommu-bits.h                    |  421 +++++
 hw/riscv/riscv-iommu.h                         |  130 ++
 hw/riscv/trace.h                               |    1 +
 include/exec/memattrs.h                        |    5 +
 include/hw/char/sifive_uart.h                  |   16 +-
 include/hw/pci/pci.h                           |    1 +
 include/hw/riscv/boot.h                        |    4 +-
 include/hw/riscv/boot_opensbi.h                |   29 +
 include/hw/riscv/iommu.h                       |   36 +
 target/riscv/cpu-qom.h                         |    1 +
 target/riscv/cpu.h                             |   36 +-
 target/riscv/cpu_bits.h                        |   17 +
 target/riscv/cpu_cfg.h                         |    2 +
 target/riscv/cpu_user.h                        |    1 +
 target/riscv/internals.h                       |    3 +
 target/riscv/pmp.h                             |    3 +-
 tests/qtest/libqos/riscv-iommu.h               |  101 +
 target/riscv/insn16.decode                     |    4 +
 target/riscv/insn32.decode                     |   26 +-
 disas/riscv.c                                  |   77 +-
 hw/char/riscv_htif.c                           |   12 +-
 hw/char/sifive_uart.c                          |   97 +-
 hw/intc/riscv_aplic.c                          |   51 +-
 hw/intc/sifive_plic.c                          |   15 +-
 hw/riscv/boot.c                                |   35 +-
 hw/riscv/riscv-iommu-pci.c                     |  202 ++
 hw/riscv/riscv-iommu.c                         | 2399 ++++++++++++++++++++++++
 hw/riscv/sifive_u.c                            |    3 +-
 hw/riscv/virt.c                                |   33 +-
 target/riscv/cpu.c                             |   43 +-
 target/riscv/cpu_helper.c                      |  209 ++-
 target/riscv/csr.c                             |   88 +-
 target/riscv/kvm/kvm-cpu.c                     |   22 +-
 target/riscv/machine.c                         |   38 +
 target/riscv/op_helper.c                       |   17 +
 target/riscv/pmp.c                             |    7 +-
 target/riscv/tcg/tcg-cpu.c                     |   29 +
 target/riscv/translate.c                       |   44 +-
 target/riscv/vector_helper.c                   |    2 +-
 tests/qtest/libqos/riscv-iommu.c               |   76 +
 tests/qtest/riscv-iommu-test.c                 |  210 +++
 target/riscv/insn_trans/trans_privileged.c.inc |    8 +-
 target/riscv/insn_trans/trans_rva.c.inc        |    4 +-
 target/riscv/insn_trans/trans_rvd.c.inc        |    4 +-
 target/riscv/insn_trans/trans_rvf.c.inc        |    4 +-
 target/riscv/insn_trans/trans_rvh.c.inc        |    8 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |   61 +-
 target/riscv/insn_trans/trans_rvvk.c.inc       |   10 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc    |    4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc      |    4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc  |  114 ++
 target/riscv/insn_trans/trans_svinval.c.inc    |    6 +-
 hw/riscv/Kconfig                               |    4 +
 hw/riscv/meson.build                           |    1 +
 hw/riscv/trace-events                          |   17 +
 tests/avocado/tuxrun_baselines.py              |   16 +
 tests/qtest/libqos/meson.build                 |    4 +
 tests/qtest/meson.build                        |    1 +
 65 files changed, 4790 insertions(+), 139 deletions(-)
 create mode 100644 docs/specs/riscv-iommu.rst
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/riscv-iommu-test.c
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
 create mode 100644 hw/riscv/trace-events

