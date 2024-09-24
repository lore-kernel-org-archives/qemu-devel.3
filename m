Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7962FCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrD-0002zv-MY; Tue, 24 Sep 2024 18:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrB-0002zS-Ek
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDr9-0001bA-63
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so4690317b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216281; x=1727821081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XQlrvcgJbB3asWcCqRiPRtngIvm+3WS+P7+LUT4jrhE=;
 b=SEmeuPAtJvwc6q1vw1TdZgb/4GufawcSmwe+XUVYKfZ70WWJKoEblPRY83WqRRyt2F
 G3JOguF9o5m5cUiwuZwOAXoz55FaJP0ltt4iSZQEnKEgp9jrVEK/kyLuauNqVsE2XGmp
 7SSBNHhg49HMNNIfQBFYJPgQ3WMYh9O6+FFI0YwV84pnwmoGohC3JYlt9Inof+hFxM1+
 msG7o8raW3ebpTkBWfCi6Uf8ZipRV2XZdj+CTem7lGXqMAZ33Lb4BorwsKQz71B/qUf4
 St8iVmZ3MP3pGjFqDh9ZjkxDJKjUlk9KpZWLtPN0d/D6Fm3CSJAe15DuyPg67YlRtRRO
 2pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216281; x=1727821081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQlrvcgJbB3asWcCqRiPRtngIvm+3WS+P7+LUT4jrhE=;
 b=N5tPOEVbcGTwYb2+N7rYy0PFQjnNml4fGFfdajfSQMVQkgj9k/SO3cDDLg5vllJKNc
 7ZBNnMPiUSXJIOiCyW4SDjJga9cYIp9QMr3asLBrZDH6ybyVKVkfB2sN1D3+a+A4mydm
 cjNPVcDkNkSXP921mBNb7/UVY1wFXo+xcnoq2zeiOoEl20gbN5bTJMWH8lgjLQvvSanG
 Jb/jv6uz2ra1QU8PrNRQ8rNyyVa6j+u43WlqNyYg49KA8g5qvSJlbXKpBcxJqaknGctH
 qDhDY+iUbOWdTbUYILRQyAGcCZVQWIZQYH80eegKt2mzq1Q24NtmWD1tHCjZKna+401X
 v1RQ==
X-Gm-Message-State: AOJu0YyGuzZyYdf+thXZvpPV66sePwTEbvYYIm6+sidGnDxqaSYU09Qf
 7C4FABhd/+QlIoW7J95moJ6JEHDx2sidZvOYTp3FPowzyOuYeJrJtNWN1w==
X-Google-Smtp-Source: AGHT+IEs2kwCpzT8uUGiwayrP7z9Ilpjwr27P2gqUnPBxe46Sp7VLgyH9wKkcqoiGdgTOi6jwlYErw==
X-Received: by 2002:a05:6a00:130b:b0:714:1fc3:79f4 with SMTP id
 d2e1a72fcca58-71b0aaa1c84mr1018250b3a.5.1727216281255; 
 Tue, 24 Sep 2024 15:18:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:00 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/47] riscv-to-apply queue
Date: Wed, 25 Sep 2024 08:17:01 +1000
Message-ID: <20240924221751.2688389-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:

  Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240925-1

for you to fetch changes up to 6bfa92c5757fe7a9580e1f6e065076777cae650f:

  bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files (2024-09-24 12:53:16 +1000)

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
* RISC-V IOMMU support
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

Daniel Henrique Barboza (5):
      target/riscv/tcg/tcg-cpu.c: consider MISA bit choice in implied rule
      pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
      test/qtest: add riscv-iommu-pci tests
      qtest/riscv-iommu-test: add init queues test
      docs/specs: add riscv-iommu

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

Tomasz Jeznach (9):
      exec/memtxattr: add process identifier to the transaction attributes
      hw/riscv: add riscv-iommu-bits.h
      hw/riscv: add RISC-V IOMMU base emulation
      hw/riscv: add riscv-iommu-pci reference device
      hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
      hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
      hw/riscv/riscv-iommu: add ATS support
      hw/riscv/riscv-iommu: add DBG support
      hw/intc: riscv-imsic: Fix interrupt state updates.

Vladimir Isaev (1):
      target/riscv: fix za64rs enabling

Warner Losh (2):
      bsd-user: Add generic RISC-V64 target definitions
      bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files

 docs/specs/index.rst                      |    1 +
 docs/specs/pci-ids.rst                    |    2 +
 docs/specs/riscv-iommu.rst                |   90 ++
 docs/system/riscv/virt.rst                |   13 +
 configs/targets/riscv64-bsd-user.mak      |    4 +
 meson.build                               |    1 +
 bsd-user/riscv/target.h                   |   20 +
 bsd-user/riscv/target_arch.h              |   27 +
 bsd-user/riscv/target_arch_cpu.h          |  148 ++
 bsd-user/riscv/target_arch_elf.h          |   42 +
 bsd-user/riscv/target_arch_reg.h          |   88 ++
 bsd-user/riscv/target_arch_signal.h       |   75 +
 bsd-user/riscv/target_arch_sigtramp.h     |   41 +
 bsd-user/riscv/target_arch_sysarch.h      |   41 +
 bsd-user/riscv/target_arch_thread.h       |   47 +
 bsd-user/riscv/target_arch_vmparam.h      |   53 +
 bsd-user/riscv/target_syscall.h           |   38 +
 hw/riscv/riscv-iommu-bits.h               |  421 +++++
 hw/riscv/riscv-iommu.h                    |  149 ++
 hw/riscv/trace.h                          |    1 +
 include/exec/memattrs.h                   |    5 +
 include/hw/pci/pci.h                      |    1 +
 include/hw/riscv/boot.h                   |    4 +-
 include/hw/riscv/iommu.h                  |   36 +
 target/riscv/cpu_bits.h                   |   10 +
 target/riscv/cpu_cfg.h                    |    2 +
 target/riscv/debug.h                      |    3 +
 tests/qtest/libqos/riscv-iommu.h          |  101 ++
 bsd-user/riscv/signal.c                   |  170 ++
 bsd-user/riscv/target_arch_cpu.c          |   29 +
 hw/intc/riscv_imsic.c                     |   50 +-
 hw/riscv/boot.c                           |   11 +-
 hw/riscv/microchip_pfsoc.c                |    2 +-
 hw/riscv/opentitan.c                      |    3 +-
 hw/riscv/riscv-iommu-pci.c                |  202 +++
 hw/riscv/riscv-iommu.c                    | 2431 +++++++++++++++++++++++++++++
 hw/riscv/shakti_c.c                       |   13 +-
 hw/riscv/sifive_u.c                       |    4 +-
 hw/riscv/spike.c                          |    5 +-
 hw/riscv/virt.c                           |   37 +-
 target/riscv/cpu.c                        |   16 +-
 target/riscv/cpu_helper.c                 |    8 +-
 target/riscv/debug.c                      |  114 +-
 target/riscv/kvm/kvm-cpu.c                |    4 +-
 target/riscv/tcg/tcg-cpu.c                |   13 +-
 target/riscv/time_helper.c                |    1 +
 target/riscv/vector_helper.c              |    2 +
 tests/qtest/bios-tables-test.c            |   28 +
 tests/qtest/libqos/riscv-iommu.c          |   76 +
 tests/qtest/riscv-iommu-test.c            |  220 +++
 util/cpuinfo-riscv.c                      |    1 +
 hw/riscv/Kconfig                          |    4 +
 hw/riscv/meson.build                      |    1 +
 hw/riscv/trace-events                     |   17 +
 target/riscv/Kconfig                      |    4 +-
 tests/data/acpi/riscv64/virt/SRAT.numamem |  Bin 0 -> 108 bytes
 tests/qtest/libqos/meson.build            |    4 +
 tests/qtest/meson.build                   |    1 +
 58 files changed, 4877 insertions(+), 58 deletions(-)
 create mode 100644 docs/specs/riscv-iommu.rst
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
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 bsd-user/riscv/signal.c
 create mode 100644 bsd-user/riscv/target_arch_cpu.c
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/riscv-iommu-test.c
 create mode 100644 hw/riscv/trace-events
 create mode 100644 tests/data/acpi/riscv64/virt/SRAT.numamem

