Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BFCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4L-0002eX-0L; Tue, 16 Sep 2025 14:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4I-0002cF-Te
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4G-0001YX-Jm
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3e98c5adbbeso1450508f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045973; x=1758650773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PbrztbKMumAKAK+ciUoiCyLvP3Il2zk4UOyXQe+mDyw=;
 b=E1cVuYwxMxBba4JLJzmfFLxl16/O2vMUuUjp23xOkFnrb4UCEcqLsxdlKrh5WpT2LZ
 7PbR2JxY7ViJcuOOwLZlQPj4RqaPuM6cw00SY4y4kYOBILVAgJphcfy+PUWDzpRi8Syc
 BcPj8M7kFWP75l245jVoMhe32363y0BXPpzt8Cid3XuDyhMO4Y4r6sIoRq6gMsh68oXq
 Mg3sTAouOejJsegyfKu2OI3XACd2KS6JFauuTuMFqskAXibrKcny7RFXsVvXGJ2E5fW2
 H84E4RF+cCVpm8XF2V22/qywujgl/jS5JifPIKyXpZ1A8Hh64L8zCpo4ciRH6u6g9Uz6
 p/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045973; x=1758650773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PbrztbKMumAKAK+ciUoiCyLvP3Il2zk4UOyXQe+mDyw=;
 b=wfZGpTbRFzIXu/1mQjoZFOeeHtovBhogJdS8posrxRstGXmLzuCnXmX9hZwF6J1s43
 ufALg6xiGPOkFPRTk3g4M3kTD/yxG2KMSxu6Io7UNJ1vgf2oBSQowQoSKAYCxVB6oKbu
 p51inAHyqzyyBrhWSV6D1+12CG1zXc0Krp2wybDiR+Fwf3einZBlX/uOH34L8HWpuPIV
 sThtl/BoJlz5OZGPdAQtgnDcSmpfuaUk2v7P4Gn6S8wKVS5FAVx/AAzaFMXiavbOW1EK
 cLpiiB3P55HlKlTAsDfLodiO4Eg6APqCzQ3MmBEP78umUMLlKscEdLcsUI/Hlhqt7oZt
 bnCg==
X-Gm-Message-State: AOJu0YzxN8skyx2XG3Im6uHSRGaauPImAxmtsrQrCQ5RLL1P/zb8u022
 ETd7oCNwXiLwQrB/6KEuidcZvO/BYS9HbE1+p61UKXj7Nyp9mEjDJzw7aaEpUmsiCLFjzFhiOhJ
 2AWHn
X-Gm-Gg: ASbGnctubTNcN9+gJXIoAkDL7ZUY7IhWMZCEK8po/8taJsGzyWANbRaF1t4QYIyq/BD
 SJ1WFNpyE4+uaUoeGrBxIO1rAGqfh9GCLzEuvo3TDNbWKZQ3SCgPIwsn7uWonKQanDyTf3pETjz
 OtDd5qVbk1Pi9EJvXtrLpDfi7qOpjjW4hd5cv9epZPFHnd5sNz8Vkzyw5qEDxvmPOn6Rk755ALX
 g41kigbZsswpRT+oYquasIqe9sp84bZuWLj6jbdPy3jzhwnT1J/oFcOIw85XuskDIgCVpjESHC9
 1O6TIFEslh/0KXlvKa32c7X/WRS2oOCe3ohOB5YFVaRoAmhoC+Hyfs5GLwmlXsY6OFLjUeJCbxk
 lJZ3QEbtij6YNfoFs+wTOUTr2hCkI
X-Google-Smtp-Source: AGHT+IEwDQh4mNwUK0ekWPt/BpSWj/tfLLNQ0+AupN90YQLq+HeE5FVE7KX2Q9c/Yg/WGmnpI5hHNA==
X-Received: by 2002:a05:6000:1845:b0:3ec:d740:a6f3 with SMTP id
 ffacd0b85a97d-3ecd740b60dmr2954481f8f.31.1758045973446; 
 Tue, 16 Sep 2025 11:06:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Tue, 16 Sep 2025 19:05:34 +0100
Message-ID: <20250916180611.1481266-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Hi; here's an arm pullreq; various miscellaneous new features
and bug fixes.

thanks
-- PMM

The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:

  Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250916

for you to fetch changes up to aaf042299acf83919862c7d7dd5fc36acf4e0671:

  hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response (2025-09-16 17:32:06 +0100)

----------------------------------------------------------------
target-arm queue:
 * tests, scripts: Don't import print_function from __future__
 * Implement FEAT_ATS1A
 * Remove deprecated pxa CPU family
 * arm/kvm: report registers we failed to set
 * Expose SME registers to GDB via gdbstub
 * linux-user/aarch64: Generate ESR signal records
 * hw/arm/raspi4b: remove redundant check in raspi_add_memory_node
 * hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
 * system: drop the -old-param option

----------------------------------------------------------------
Cornelia Huck (1):
      arm/kvm: report registers we failed to set

Nicolin Chen (1):
      hw/arm/virt: Add an SMMU_IO_LEN macro

Osama Abdelkader (1):
      hw/arm/raspi4b: remove redundant check in raspi_add_memory_node

Peter Maydell (7):
      tests, scripts: Don't import print_function from __future__
      target/arm: Remove deprecated pxa CPU family
      target/arm: Remove XScale and iWMMXt translate.c code
      target/arm: Remove iwmmxt helper functions
      target/arm: Drop ARM_FEATURE_XSCALE handling
      target/arm: Drop ARM_FEATURE_IWMMXT handling
      system: drop the -old-param option

Richard Henderson (12):
      linux-user/aarch64: Split out signal_for_exception
      linux-user/aarch64: Check syndrome for EXCP_UDEF
      linux-user/aarch64: Generate ESR signal records
      target/arm: Add prot_check parameter to pmsav8_mpu_lookup
      target/arm: Add in_prot_check to S1Translate
      target/arm: Skip permission check from arm_cpu_get_phys_page_attrs_debug
      target/arm: Introduce get_phys_addr_for_at
      target/arm: Skip AF and DB updates for AccessType_AT
      target/arm: Add prot_check parameter to do_ats_write
      target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
      target/arm: Remove outdated comment for ZCR_EL12
      target/arm: Implement FEAT_ATS1A

Shameer Kolothum (10):
      hw/arm/smmu-common: Check SMMU has PCIe Root Complex association
      hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
      hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
      hw/arm/virt: Factor out common SMMUV3 dt bindings code
      hw/pci: Introduce pci_setup_iommu_per_bus() for per-bus IOMMU ops retrieval
      hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
      qemu-options.hx: Document the arm-smmuv3 device
      bios-tables-test: Allow for smmuv3 test data.
      qtest/bios-tables-test: Add tests for legacy smmuv3 and smmuv3 device
      qtest/bios-tables-test: Update tables for smmuv3 tests

Stéphane Graber (1):
      hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response

Vacha Bhavsar (3):
      target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
      target/arm: Added support for SME register exposure to GDB
      target/arm: Added test case for SME register exposure to GDB

 docs/about/deprecated.rst                          |   34 -
 docs/about/removed-features.rst                    |   26 +
 docs/system/arm/emulation.rst                      |    1 +
 configure                                          |    6 +
 bsd-user/arm/target_arch_elf.h                     |    1 -
 gdbstub/internals.h                                |   22 +-
 include/hw/arm/smmu-common.h                       |    1 +
 include/hw/arm/virt.h                              |    1 +
 include/hw/pci/pci.h                               |    2 +
 include/hw/pci/pci_bridge.h                        |    1 +
 include/hw/pci/pci_bus.h                           |    1 +
 include/system/system.h                            |    1 -
 target/arm/cpregs.h                                |   29 +-
 target/arm/cpu-features.h                          |    5 +
 target/arm/cpu.h                                   |   30 +-
 target/arm/internals.h                             |   26 +-
 target/arm/tcg/helper.h                            |   95 --
 target/arm/tcg/translate.h                         |    2 -
 hw/arm/boot.c                                      |   81 +-
 hw/arm/raspi4b.c                                   |   22 +-
 hw/arm/smmu-common.c                               |   37 +-
 hw/arm/smmuv3.c                                    |    2 +
 hw/arm/virt-acpi-build.c                           |  201 ++-
 hw/arm/virt.c                                      |  111 +-
 hw/core/sysbus-fdt.c                               |    3 +
 hw/pci-bridge/pci_expander_bridge.c                |    1 -
 hw/pci/pci.c                                       |   31 +
 hw/usb/dev-network.c                               |    2 +-
 linux-user/aarch64/cpu_loop.c                      |  162 ++-
 linux-user/aarch64/signal.c                        |   34 +-
 linux-user/arm/elfload.c                           |    1 -
 linux-user/arm/signal.c                            |   67 -
 system/globals.c                                   |    1 -
 system/vl.c                                        |    4 -
 target/arm/cpu.c                                   |   21 -
 target/arm/gdbstub.c                               |   10 +-
 target/arm/gdbstub64.c                             |  119 ++
 target/arm/helper.c                                |   59 -
 target/arm/kvm.c                                   |   86 ++
 target/arm/machine.c                               |   21 -
 target/arm/ptw.c                                   |   71 +-
 target/arm/tcg/cpregs-at.c                         |   69 +-
 target/arm/tcg/cpu32.c                             |  163 ---
 target/arm/tcg/cpu64.c                             |    1 +
 target/arm/tcg/hflags.c                            |   13 +-
 target/arm/tcg/iwmmxt_helper.c                     |  672 ----------
 target/arm/tcg/m_helper.c                          |    4 +-
 target/arm/tcg/op_helper.c                         |    6 -
 target/arm/tcg/translate.c                         | 1324 +-------------------
 tests/qtest/bios-tables-test.c                     |   86 ++
 qemu-options.hx                                    |   14 +-
 scripts/userfaultfd-wrlat.py                       |    1 -
 target/arm/tcg/meson.build                         |    2 -
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev       |  Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy    |  Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev       |  Bin 0 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy    |  Bin 0 -> 276 bytes
 tests/guest-debug/test_gdbstub.py                  |    1 -
 tests/tcg/aarch64/Makefile.target                  |   29 +
 tests/tcg/aarch64/gdbstub/test-mte.py              |    1 -
 tests/tcg/aarch64/gdbstub/test-sme.py              |  117 ++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py        |    1 -
 tests/tcg/aarch64/gdbstub/test-sve.py              |    1 -
 tests/tcg/multiarch/gdbstub/interrupt.py           |    1 -
 tests/tcg/multiarch/gdbstub/memory.py              |    1 -
 tests/tcg/multiarch/gdbstub/sha1.py                |    1 -
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py  |    1 -
 .../tcg/multiarch/gdbstub/test-qxfer-auxv-read.py  |    1 -
 .../multiarch/gdbstub/test-qxfer-siginfo-read.py   |    1 -
 .../multiarch/gdbstub/test-thread-breakpoint.py    |    1 -
 tests/tcg/s390x/gdbstub/test-signals-s390x.py      |    1 -
 tests/tcg/s390x/gdbstub/test-svc.py                |    1 -
 72 files changed, 1151 insertions(+), 2794 deletions(-)
 delete mode 100644 target/arm/tcg/iwmmxt_helper.c
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py

