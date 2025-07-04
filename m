Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE38EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLt-00025Y-Er; Fri, 04 Jul 2025 07:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLR-0001jF-3a
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLJ-0002AN-AT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235e1d710d8so11771875ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627551; x=1752232351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4kV/Uoy7xuWTFkJ4+ZiDUka5k5Lq4ngZAN/mU/DYTM=;
 b=g+ije4tGWkRsYuw6a4uR6VYQvXvVdFxu5aprbzmIRQjXmVz3qnwVjl7Ib0bSVI43OO
 1Icx2KjG3YJ5bEicSkQ1rR2WhJIOYyLnilcXH9dspJUB/tp+r4kY5N1N3dAvrHqaG7Ej
 G5zYTCeg8JEuSeedOOjeUbIpvOmnS7Y+LLHC6WuD8UXw8thSaXWwX4Act9Z6ha8BTalh
 7685MWfkhjkt8n+NSePXlVmVzMrWa2QT7U9z048kV7e24k21qq42h7scXqS5uwqLIC+g
 LSBrnq6ePmmycYVo9okml2d62nuEQ1ROCh7KRukjz4n+riTPGoWBRue9qCjzTqgdpJC/
 BJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627551; x=1752232351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4kV/Uoy7xuWTFkJ4+ZiDUka5k5Lq4ngZAN/mU/DYTM=;
 b=cJta2oJzEZkSMz8WtszBJtndw0qWMdfQCw8Cc3UNLycs/eL2DyQelw1IraWrYfJUYX
 GePklcXmd4+1mg+jHSdYBDheSENqlS0DKiqh8tRznZKtyN5TnzjYsueIYn0uNivfL49d
 YmT0rF//AoE1CaimH4w7BfwZlRpv1lgs8LOP2yGhnnHXr6YVv5aODIvOQNtF/p021ysZ
 PTmBi4lcPZXyhnCq2euUVvd9vm4HxiNAKHosc9j+9usmryJ5/yavY+lwKU/NDEWdXnlg
 YOZWy6lvmNUnmB6F2qNNzmzUslbTMLbng5qW47dWyytAd+5w6C7bnLKW7Sb0vlW4N7OP
 meZw==
X-Gm-Message-State: AOJu0YwQfIOu6wTml1DPV0kECIw4C8kEayuWAZsE5qAJi8NFHs11JywO
 1L33YM6zWOxmNugGuTJRW0+hoR1cOsTEhJY+9/scMghgtFrwPfE1l7OaPLbSdg==
X-Gm-Gg: ASbGnctSulHuzDp/QHwpR799+5rDxLFyqHFzH0lk3atybGksQQjKUXt1namazp+aQ9O
 0x5nQPXjBoGQ7XoC8ETx4h2HeTKHeDEym2Ct9Y/73KV/jX+bQDTPhWxQCmIcoTZh90Q2/Rp4/JI
 o7Jv6zu1buhfyMM7OMoSt8IhaMmpSlNsUAeqA2chy4lI1vlr50yET/bUTOU1FszNut02UvUg6b6
 upWhd1z3V4Cr7K/m0FBagLmlSXsZA/19Gd/XtqJaNyUwAti3inCR8OURGnZ9K4WEnaIC33ebWeQ
 J3DOx7T+7IxWqd6Lg3vLAdXx0mDHxTuWcZkGh3nt7XlU51n6Oh/ewGDsYYmvsmAmP0r64L/8GAX
 04mAbm2oAXkOF2KtmtFH29+1ywk5vfxGMKZudUhKxBY7X9y6MSmjNZwvsyGLZ2SPRhLU=
X-Google-Smtp-Source: AGHT+IEif8nePPUF9/GLQTMRlB6NEKWpCCGMfkwD+Dt7/rBp3mcKY5xdPxgf4E6F9hM180/zhcrUTg==
X-Received: by 2002:a17:902:ea06:b0:236:8df9:ab38 with SMTP id
 d9443c01a7336-23c860d4f93mr40786045ad.34.1751627551103; 
 Fri, 04 Jul 2025 04:12:31 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/40] riscv-to-apply queue
Date: Fri,  4 Jul 2025 21:11:27 +1000
Message-ID: <20250704111207.591994-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit c77283dd5d79149f4e7e9edd00f65416c648ee59:

  Merge tag 'pull-request-2025-07-02' of https://gitlab.com/thuth/qemu into staging (2025-07-03 06:01:41 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250704

for you to fetch changes up to dc8bffc4eb0a93d3266cea1b17f8848dea5b915c:

  target: riscv: Add Svrsw60t59b extension support (2025-07-04 21:09:49 +1000)

----------------------------------------------------------------
Second RISC-V PR for 10.1

* sstc extension fixes
* Fix zama16b order in isa_edata_arr
* Profile handling fixes
* Extend PMP region up to 64
* Remove capital 'Z' CPU properties
* Add missing named features
* Support atomic instruction fetch (Ziccif)
* Add max_satp_mode from host cpu
* Extend and configure PMP region count
* Fix PPN field of Translation-reponse register
* Use qemu_chr_fe_write_all() in DBCN_CONSOLE_WRITE_BYTE
* Fix fcvt.s.bf16 NaN box checking
* Avoid infinite delay of async xmit function
* Device tree reg cleanups
* Add Kunminghu CPU and platform
* Fix missing exit TB flow for ldff_trans
* Fix migration failure when aia is configured as aplic-imsic
* Fix MEPC/SEPC bit masking for IALIGN
* Add a property to set vill bit on reserved usage of vsetvli instruction
* Add Svrsw60t59b extension support

----------------------------------------------------------------
Alexandre Ghiti (1):
      target: riscv: Add Svrsw60t59b extension support

Anton Blanchard (1):
      target/riscv: Fix fcvt.s.bf16 NaN box checking

Charalampos Mitrodimas (2):
      target/riscv: Fix MEPC/SEPC bit masking for IALIGN
      tests/tcg/riscv64: Add test for MEPC bit masking

Daniel Henrique Barboza (9):
      target/riscv/cpu.c: fix zama16b order in isa_edata_arr[]
      target/riscv/tcg: restrict satp_mode changes in cpu_set_profile
      target/riscv/tcg: decouple profile enablement from user prop
      target/riscv: add profile->present flag
      target/riscv: remove capital 'Z' CPU properties
      target/riscv/cpu.c: add 'sdtrig' in riscv,isa
      target/riscv/cpu.c: add 'ssstrict' to riscv, isa
      target/riscv/cpu.c: do better with 'named features' doc
      target/riscv: use qemu_chr_fe_write_all() in DBCN_CONSOLE_WRITE_BYTE

Florian Lugou (1):
      hw/char: sifive_uart: Avoid infinite delay of async xmit function

Huang Borong (2):
      target/riscv: Add BOSC's Xiangshan Kunminghu CPU
      hw/riscv: Initial support for BOSC's Xiangshan Kunminghu FPGA prototype

Jay Chang (2):
      target/riscv: Extend PMP region up to 64
      target/riscv: Make PMP region count configurable

Jim Shu (5):
      target/riscv: Add the checking into stimecmp write function.
      hw/intc: riscv_aclint: Fix mtime write for sstc extension
      target/riscv: Fix VSTIP bit in sstc extension.
      target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed
      target/riscv: support atomic instruction fetch (Ziccif)

Joel Stanley (12):
      hw/riscv/virt: Fix clint base address type
      hw/riscv/virt: Use setprop_sized_cells for clint
      hw/riscv/virt: Use setprop_sized_cells for memory
      hw/riscv/virt: Use setprop_sized_cells for aplic
      hw/riscv/virt: Use setprop_sized_cells for aclint
      hw/riscv/virt: Use setprop_sized_cells for plic
      hw/riscv/virt: Use setprop_sized_cells for virtio
      hw/riscv/virt: Use setprop_sized_cells for reset
      hw/riscv/virt: Use setprop_sized_cells for uart
      hw/riscv/virt: Use setprop_sized_cells for rtc
      hw/riscv/virt: Use setprop_sized_cells for iommu
      hw/riscv/virt: Use setprop_sized_cells for pcie

Max Chou (1):
      target/riscv: rvv: Fix missing exit TB flow for ldff_trans

Meng Zhuo (1):
      target/riscv/kvm: add max_satp_mode from host cpu

Nutty Liu (1):
      hw/riscv/riscv-iommu: Fix PPN field of Translation-reponse register

Vasilis Liaskovitis (1):
      target/riscv: Add a property to set vill bit on reserved usage of vsetvli instruction

liu.xuemei1@zte.com.cn (1):
      migration: Fix migration failure when aia is configured as aplic-imsic

 MAINTAINERS                                 |   7 +
 docs/system/riscv/xiangshan-kunminghu.rst   |  39 +++++
 docs/system/target-riscv.rst                |   1 +
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/riscv-iommu-bits.h                 |   1 +
 include/hw/riscv/xiangshan_kmh.h            |  68 +++++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.h                          |  19 ++-
 target/riscv/cpu_bits.h                     |  63 +++++++-
 target/riscv/helper.h                       |   2 +-
 target/riscv/internals.h                    |  27 ++++
 target/riscv/time_helper.h                  |   1 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 hw/char/sifive_uart.c                       |   6 +-
 hw/intc/riscv_aclint.c                      |   5 +
 hw/intc/riscv_aplic.c                       |  12 +-
 hw/intc/riscv_imsic.c                       |  10 +-
 hw/riscv/riscv-iommu.c                      |   9 +-
 hw/riscv/virt.c                             |  66 ++++-----
 hw/riscv/xiangshan_kmh.c                    | 220 ++++++++++++++++++++++++++++
 target/riscv/cpu.c                          | 144 +++++++++++++++---
 target/riscv/cpu_helper.c                   |   3 +-
 target/riscv/csr.c                          | 192 +++++++++++++++++++++++-
 target/riscv/fpu_helper.c                   |   2 +-
 target/riscv/kvm/kvm-cpu.c                  |  18 ++-
 target/riscv/machine.c                      |   3 +-
 target/riscv/op_helper.c                    |   4 +-
 target/riscv/pmp.c                          |  28 ++--
 target/riscv/riscv-qmp-cmds.c               |   2 +-
 target/riscv/tcg/tcg-cpu.c                  | 186 +++++++++++------------
 target/riscv/time_helper.c                  |  65 +++++++-
 target/riscv/translate.c                    |  46 ++++--
 target/riscv/vector_helper.c                |  12 +-
 target/riscv/insn_trans/trans_rvv.c.inc     |  10 +-
 hw/riscv/Kconfig                            |   9 ++
 hw/riscv/meson.build                        |   1 +
 tests/data/acpi/riscv64/virt/RHCT           | Bin 400 -> 416 bytes
 tests/tcg/riscv64/Makefile.softmmu-target   |   4 +
 tests/tcg/riscv64/test-mepc-masking.S       |  73 +++++++++
 39 files changed, 1151 insertions(+), 212 deletions(-)
 create mode 100644 docs/system/riscv/xiangshan-kunminghu.rst
 create mode 100644 include/hw/riscv/xiangshan_kmh.h
 create mode 100644 hw/riscv/xiangshan_kmh.c
 create mode 100644 tests/tcg/riscv64/test-mepc-masking.S

