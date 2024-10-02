Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0CBCF3197
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsGR-0005V4-7o; Wed, 02 Oct 2024 01:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGN-0005Uh-FQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGL-0004pC-64
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b58f2e1f4so26698025ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848259; x=1728453059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHVyGbEwDIdcbZnDdpX8H/p6kbbafcCWjiRjQD8RfFs=;
 b=dUfTeJJen6mGVNmCErXnowGcVADHQOZyYQ8rJU0ZNRacYuGQJDzqoXxP2n+2XczTgg
 swNVhUsaNYWmW9IgDsNQ+iyi15xZEKw96qcvrpAghPODEzeD7upJtCiZnTMQE28YH5wB
 BcVSsfh6kwiSvY0MUlVYBPGYlHwHUu/1KJf5lCKrJQtuut6NFw+emhAlTFx3tMOP20bc
 sJVfxSznq0QUtj7e7Qo/NhI52n7eAVvbC9ERwyINc70okJl98dzCbFSSOO/8yWv2k9vQ
 gpTgFDTw4qogFo+s24LoMwW5aAnhe+ng5Od8EcbdICSbHH4QIl4t/HCXZqEqLKrZ7HBp
 yJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848259; x=1728453059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHVyGbEwDIdcbZnDdpX8H/p6kbbafcCWjiRjQD8RfFs=;
 b=SkDugj/fAEsLMmOZ3qTGcR6Vm6gzUTtPH140JfKZz+i022YwlSHmeiEyx0vgfAlYFd
 ERHnMmp1PU3iZ0eTCadzXzz7Om2FCMYh/f8LCoUqZFWQaYmMrYh6iRwFBuy2lVmoy4XY
 E4XjRKJxwjuSU9GcXdS9Pi9TO6YQw3uWF9ALm9IG89mX+Vx5qGNttgzXJBbxNd0YvwFu
 57mgKUHAAAE1tEHA3Km/eR5NHEUQ0+0morM0Ynqc+zz9EAtmEuEiiR/g5S6fxEmg0+SU
 pgT9MBXNTTXGxXmmWlx+uPxqtHbRJG5IMIxESK5xPHgdRHHeul6HTus2YdbjmX8qxa8f
 6fBQ==
X-Gm-Message-State: AOJu0YxWEaRHON4/9j2GesiO4c/qDV6h0M1REm1hmrhqRv0xZk2ASVJd
 RKuWN7E54Sln6CWt8r91pl9vDX7VzyeyPYwV27Yt33167U/9cpyusvBzKq3o
X-Google-Smtp-Source: AGHT+IEaLNXBXnDG1NadOmt7C2hGReWOAt8EcgePUwFtCelEpc/rEurGbbQDXi4PTUP2ZrtQEuXT6A==
X-Received: by 2002:a17:903:1105:b0:20b:814:dc28 with SMTP id
 d9443c01a7336-20bc5a5e538mr25917255ad.41.1727848259248; 
 Tue, 01 Oct 2024 22:50:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:50:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 00/35] riscv-to-apply queue
Date: Wed,  2 Oct 2024 15:50:13 +1000
Message-ID: <20241002055048.556083-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:

  Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241002

for you to fetch changes up to 74b493244d0624afed22606e76fc7fca62777401:

  bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files (2024-10-02 15:11:52 +1000)

----------------------------------------------------------------
RISC-V PR for 9.2

* Add a property to set vl to ceil(AVL/2)
* Enable numamem testing for RISC-V
* Consider MISA bit choice in implied rule
* Fix the za64rs priv spec requirements
* Enable Bit Manip for OpenTitan Ibex CPU
* Fix the group bit setting of AIA with KVM
* Stop timer with infinite timecmp
* Add 'fcsr' register to QEMU log as a part of F extension
* Fix riscv64 build on musl libc
* Add preliminary textra trigger CSR functions
* RISC-V bsd-user support
* Respect firmware ELF entry point
* Add Svvptc extension support
* Fix masking of rv32 physical address
* Fix linking problem with semihosting disabled
* Fix IMSIC interrupt state updates

----------------------------------------------------------------
Alexandre Ghiti (1):
      target: riscv: Add Svvptc extension support

Alistair Francis (1):
      target: riscv: Enable Bit Manip for OpenTitan Ibex CPU

Alvin Chang (2):
      target/riscv: Preliminary textra trigger CSR writting support
      target/riscv: Add textra matching condition for the triggers

Andrew Jones (3):
      target/riscv/kvm: Fix the group bit setting of AIA
      target/riscv: Stop timer with infinite timecmp
      target/riscv32: Fix masking of physical address

Daniel Henrique Barboza (1):
      target/riscv/tcg/tcg-cpu.c: consider MISA bit choice in implied rule

Haibo Xu (3):
      tests/acpi: Add empty ACPI SRAT data file for RISC-V
      tests/qtest/bios-tables-test.c: Enable numamem testing for RISC-V
      tests/acpi: Add expected ACPI SRAT AML file for RISC-V

Jason Chien (1):
      target/riscv: Add a property to set vl to ceil(AVL/2)

Maria Klauchek (1):
      target/riscv/cpu.c: Add 'fcsr' register to QEMU log as a part of F extension

Mark Corbin (15):
      bsd-user: Implement RISC-V CPU initialization and main loop
      bsd-user: Add RISC-V CPU execution loop and syscall handling
      bsd-user: Implement RISC-V CPU register cloning and reset functions
      bsd-user: Implement RISC-V TLS register setup
      bsd-user: Add RISC-V ELF definitions and hardware capability detection
      bsd-user: Define RISC-V register structures and register copying
      bsd-user: Add RISC-V signal trampoline setup function
      bsd-user: Implement RISC-V sysarch system call emulation
      bsd-user: Add RISC-V thread setup and initialization support
      bsd-user: Define RISC-V VM parameters and helper functions
      bsd-user: Define RISC-V system call structures and constants
      bsd-user: Define RISC-V signal handling structures and constants
      bsd-user: Implement RISC-V signal trampoline setup functions
      bsd-user: Implement 'get_mcontext' for RISC-V
      bsd-user: Implement set_mcontext and get_ucontext_sigreturn for RISCV

Milan P. Stanić (1):
      util/util/cpuinfo-riscv.c: fix riscv64 build on musl libc

Samuel Holland (1):
      hw/riscv: Respect firmware ELF entry point

Thomas Huth (1):
      target/riscv/cpu_helper: Fix linking problem with semihosting disabled

Tomasz Jeznach (1):
      hw/intc: riscv-imsic: Fix interrupt state updates.

Vladimir Isaev (1):
      target/riscv: fix za64rs enabling

Warner Losh (2):
      bsd-user: Add generic RISC-V64 target definitions
      bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files

 configs/targets/riscv64-bsd-user.mak      |   4 +
 bsd-user/riscv/target.h                   |  20 ++++
 bsd-user/riscv/target_arch.h              |  27 +++++
 bsd-user/riscv/target_arch_cpu.h          | 148 ++++++++++++++++++++++++++
 bsd-user/riscv/target_arch_elf.h          |  42 ++++++++
 bsd-user/riscv/target_arch_reg.h          |  88 ++++++++++++++++
 bsd-user/riscv/target_arch_signal.h       |  75 +++++++++++++
 bsd-user/riscv/target_arch_sigtramp.h     |  41 +++++++
 bsd-user/riscv/target_arch_sysarch.h      |  41 +++++++
 bsd-user/riscv/target_arch_thread.h       |  47 +++++++++
 bsd-user/riscv/target_arch_vmparam.h      |  53 ++++++++++
 bsd-user/riscv/target_syscall.h           |  38 +++++++
 include/hw/riscv/boot.h                   |   4 +-
 target/riscv/cpu_bits.h                   |  10 ++
 target/riscv/cpu_cfg.h                    |   2 +
 target/riscv/debug.h                      |   3 +
 bsd-user/riscv/signal.c                   | 170 ++++++++++++++++++++++++++++++
 bsd-user/riscv/target_arch_cpu.c          |  29 +++++
 hw/intc/riscv_imsic.c                     |  50 +++++----
 hw/riscv/boot.c                           |  11 +-
 hw/riscv/microchip_pfsoc.c                |   2 +-
 hw/riscv/opentitan.c                      |   3 +-
 hw/riscv/shakti_c.c                       |  13 ++-
 hw/riscv/sifive_u.c                       |   4 +-
 hw/riscv/spike.c                          |   5 +-
 hw/riscv/virt.c                           |   4 +-
 target/riscv/cpu.c                        |  16 ++-
 target/riscv/cpu_helper.c                 |   8 +-
 target/riscv/debug.c                      | 114 ++++++++++++++++++--
 target/riscv/kvm/kvm-cpu.c                |   4 +-
 target/riscv/tcg/tcg-cpu.c                |  13 ++-
 target/riscv/time_helper.c                |   1 +
 target/riscv/vector_helper.c              |   2 +
 tests/qtest/bios-tables-test.c            |  28 +++++
 util/cpuinfo-riscv.c                      |   1 +
 target/riscv/Kconfig                      |   4 +-
 tests/data/acpi/riscv64/virt/SRAT.numamem | Bin 0 -> 108 bytes
 37 files changed, 1068 insertions(+), 57 deletions(-)
 create mode 100644 configs/targets/riscv64-bsd-user.mak
 create mode 100644 bsd-user/riscv/target.h
 create mode 100644 bsd-user/riscv/target_arch.h
 create mode 100644 bsd-user/riscv/target_arch_cpu.h
 create mode 100644 bsd-user/riscv/target_arch_elf.h
 create mode 100644 bsd-user/riscv/target_arch_reg.h
 create mode 100644 bsd-user/riscv/target_arch_signal.h
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
 create mode 100644 bsd-user/riscv/target_arch_sysarch.h
 create mode 100644 bsd-user/riscv/target_arch_thread.h
 create mode 100644 bsd-user/riscv/target_arch_vmparam.h
 create mode 100644 bsd-user/riscv/target_syscall.h
 create mode 100644 bsd-user/riscv/signal.c
 create mode 100644 bsd-user/riscv/target_arch_cpu.c
 create mode 100644 tests/data/acpi/riscv64/virt/SRAT.numamem

