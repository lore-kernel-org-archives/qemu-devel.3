Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F069C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXu4-0003KN-Bf; Fri, 23 Feb 2024 10:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhR-0004jg-8e; Fri, 23 Feb 2024 10:42:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhP-00062F-6J; Fri, 23 Feb 2024 10:42:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d944e8f367so6713905ad.0; 
 Fri, 23 Feb 2024 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702973; x=1709307773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vGHQp4x6VgTBhAMEqIWE/EREDWDtBSx8VfzhNjTbj6A=;
 b=LD7efyHJo40ptt+9425hajfgxN5z2wshLmzGu/gUuJavvjVaMHMFux+li5EMBgKrgL
 YGmCX+So4Aurs4l+83rVSoy33St3cU18bhWqOPrayZf7RdQCeuyPdfVE+fJA+buGKJZ+
 DQrxDyfstkz8RFRtBm1TX/+r31z0PptIYmIVQHkg5UelWAbBpZMtkZxpLn795bTzTbMS
 kkquaouWWSM5rl90rpbaYiX/3rQCb/QQTKWitYUYc0F7DqvKr75WFOcJ3ITN/OLE0jST
 OeEONl1t5aiEaStWblV8niUHSp4Cl2Y9a8FYO0aRKEOlbYlaOgHiFKEuCJdFQIf0V/Gn
 oLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702973; x=1709307773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vGHQp4x6VgTBhAMEqIWE/EREDWDtBSx8VfzhNjTbj6A=;
 b=X+4n3NIc5faj0V4wklwbAjaTotHwhM5c3xeSwpyCBIlGuKPX/7aPoSrlCXKWcGYxE5
 CHYw02Lb+t0cv8Rpd0zXfKkFjWghoRkezhHKJRYrnMLyNFkpZq4+LNUsjHpPQUr8zubx
 RQu2ZS8H5sJTRxGh3aXiEMxL7EeiaexEbFMyFTE6FJlfBS9/szPbCwUJ4OXdn6sUoz2Q
 ki68KSQqBCLtyHWt5ruaemk+n7GqZ3ugdIlxWb9sreAbRm5sI1OsaJMLGNxck3nVCzaC
 9iYFSmYuWlkHkj9Z/RLjHJoj7TisYvo/4CYtokj9QKvKnIe5EO/621Xix5niiwDM+wXD
 p/wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzK9be0OMxzh3T1eaANWOFpyLi/ObDQ9QAXuwkQCZeTSRb9BUJOc/NepTnlane+DgEsYOCYeKY91ketTmU0+lqArQi
X-Gm-Message-State: AOJu0YysetgXUK2hhAUFNpQWkhDUAxZL/1xuzvIKHEHJz7VGk9AceFvv
 TPSfjiSDuvQECq1gAmStQWqvMflLLGXTdk080/wHwuJvzhiwh6TPhVorN7Sn
X-Google-Smtp-Source: AGHT+IHVVFc1nlIwIUSyqcpgBObWkHEtdytmwolUayPgsIvNEHhGP3kuAo/gLHUgkP3xBWZg2Vubwg==
X-Received: by 2002:a17:902:ee85:b0:1d9:f83e:3a54 with SMTP id
 a5-20020a170902ee8500b001d9f83e3a54mr131080pld.64.1708702971721; 
 Fri, 23 Feb 2024 07:42:51 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:42:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 00/47] ppc-for-9.0 queue
Date: Sat, 24 Feb 2024 01:41:19 +1000
Message-ID: <20240223154211.1001692-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The following changes since commit 3d54cbf269d63ff1d500b35b2bcf4565ff8ad485:

  Merge tag 'hw-misc-20240222' of https://github.com/philmd/qemu into staging (2024-02-22 15:44:29 +0000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-20240224

for you to fetch changes up to 4acc505d2236190efea94746e7f22e2c07bce5d6:

  target/ppc: optimise ppcemb_tlb_t flushing (2024-02-23 23:24:43 +1000)

----------------------------------------------------------------
Let's try this PR again. Since the previous attempt, I dropped the empty
already merged pci/raven patch. Also added several missed R-B tags.

A bunch more testing showed up some issues with the new avocado
tests. FreeBSD artifact URL availability is marginal so dropped that
for now. ppc_hv_tests.py sometimes hangs due to a bug in console
interaction so marked it flaky so it's not gated behind the fix for
that.

* Avocado tests for ppc64 run guests with emulated or nested hypervisor
* facilities, among other things.  Update ppc64 CPU defaults to Power10.
* Add a new powernv10-rainier machine to better capture differences
  between the different Power10 systems.
* Implement more device models for powernv.
* 4xx TLB flushing performance and correctness improvements.
* Correct gdb implementation to access some important SPRs.
* Misc cleanups and bug fixes.

----------------------------------------------------------------
Chalapathi V (3):
      hw/ppc: Add pnv nest pervasive common chiplet model
      hw/ppc: Add N1 chiplet model
      hw/ppc: N1 chiplet wiring

Cédric Le Goater (1):
      spapr: Tag pseries-2.1 - 2.11 machines as deprecated

Glenn Miles (9):
      misc/pca9552: Fix inverted input status
      misc/pca9552: Let external devices set pca9552 inputs
      ppc/pnv: New powernv10-rainier machine type
      ppc/pnv: Add pca9552 to powernv10-rainier for PCIe hotplug power control
      ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
      ppc/pnv: Use resettable interface to reset child I2C buses
      misc: Add a pca9554 GPIO device model
      ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
      ppc/pnv: Test pnv i2c master and connected devices

Harsh Prateek Bora (2):
      ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ range for CPU IPIs.
      ppc/spapr: Initialize max_cpus limit to SPAPR_IRQ_NR_IPIS.

Nicholas Piggin (27):
      target/ppc: Fix lxv/stxv MSR facility check
      target/ppc: Fix crash on machine check caused by ifetch
      tests/avocado: mark boot_linux.py long runtime instead of flaky
      tests/avocado: improve flaky ppc/pnv boot_linux_console.py test
      tests/avocado: ppc add powernv10 boot_linux_console test
      tests/avocado: Add ppc pseries and powernv hash MMU tests
      tests/avocado: Add pseries KVM boot_linux test
      tests/avocado: ppc add hypervisor tests
      tests/avocado: Use default CPU for pseries machine
      ppc/pnv: Update skiboot to v7.1
      target/ppc: Rename registers to match ISA
      ppc/spapr: change pseries machine default to POWER10 CPU
      ppc/pnv: Change powernv default to powernv10
      target/ppc: Rename TBL to TB on 64-bit
      target/ppc: Improve timebase register defines naming
      target/ppc: Fix move-to timebase SPR access permissions
      ppc/pnv: Add POWER9/10 chiptod model
      ppc/pnv: Wire ChipTOD model to powernv9 and powernv10 machines
      ppc/pnv: Implement the ChipTOD to Core transfer
      target/ppc: Implement core timebase state machine and TFMR
      target/ppc: Add SMT support to time facilities
      target/ppc: Fix 440 tlbwe TLB invalidation gaps
      target/ppc: Factor out 4xx ppcemb_tlb_t flushing
      target/ppc: 4xx don't flush TLB for a newly written software TLB entry
      target/ppc: 4xx optimise tlbwe_lo TLB flushing
      target/ppc: 440 optimise tlbwe TLB flushing
      target/ppc: optimise ppcemb_tlb_t flushing

Philippe Mathieu-Daudé (4):
      hw/ppc/spapr: Add missing license
      hw/ppc/spapr_hcall: Allow elision of softmmu_resize_hpt_prep
      hw/ppc/spapr_hcall: Rename {softmmu -> vhyp_mmu}_resize_hpt_pr
      hw/ppc/spapr: Rename 'softmmu' -> 'vhyp_mmu'

Saif Abrar (1):
      target/ppc: Update gdbstub to read SPR's CFAR, DEC, HDEC, TB-L/U

 MAINTAINERS                                  |  11 +-
 docs/about/deprecated.rst                    |   8 +
 docs/devel/testing.rst                       |  11 +
 hw/misc/Kconfig                              |   4 +
 hw/misc/meson.build                          |   1 +
 hw/misc/pca9552.c                            |  58 ++-
 hw/misc/pca9554.c                            | 328 +++++++++++++++
 hw/ppc/Kconfig                               |   2 +
 hw/ppc/meson.build                           |   5 +-
 hw/ppc/pnv.c                                 | 131 +++++-
 hw/ppc/pnv_chiptod.c                         | 586 +++++++++++++++++++++++++++
 hw/ppc/pnv_i2c.c                             | 146 +------
 hw/ppc/pnv_n1_chiplet.c                      | 173 ++++++++
 hw/ppc/pnv_nest_pervasive.c                  | 208 ++++++++++
 hw/ppc/spapr.c                               |  12 +-
 hw/ppc/spapr_hcall.c                         |  12 +-
 hw/ppc/spapr_irq.c                           |   6 +-
 hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} |  13 +-
 hw/ppc/trace-events                          |   4 +
 include/hw/i2c/pnv_i2c_regs.h                | 143 +++++++
 include/hw/misc/pca9552.h                    |   3 +-
 include/hw/misc/pca9554.h                    |  36 ++
 include/hw/misc/pca9554_regs.h               |  19 +
 include/hw/ppc/pnv.h                         |   3 +
 include/hw/ppc/pnv_chip.h                    |   5 +
 include/hw/ppc/pnv_chiptod.h                 |  53 +++
 include/hw/ppc/pnv_n1_chiplet.h              |  32 ++
 include/hw/ppc/pnv_nest_pervasive.h          |  32 ++
 include/hw/ppc/pnv_xscom.h                   |  18 +
 include/hw/ppc/spapr.h                       |   9 +-
 include/hw/ppc/spapr_irq.h                   |  14 +-
 pc-bios/skiboot.lid                          | Bin 2527240 -> 2527328 bytes
 target/ppc/cpu.h                             |  57 ++-
 target/ppc/cpu_init.c                        |  20 +-
 target/ppc/excp_helper.c                     |  36 +-
 target/ppc/gdbstub.c                         |  40 +-
 target/ppc/helper_regs.c                     |  41 +-
 target/ppc/mmu_helper.c                      | 105 +++--
 target/ppc/ppc-qmp-cmds.c                    |   4 +
 target/ppc/tcg-stub.c                        |  15 -
 target/ppc/timebase_helper.c                 | 309 +++++++++++++-
 target/ppc/translate.c                       |  42 +-
 target/ppc/translate/vsx-impl.c.inc          |   2 +-
 tests/avocado/boot_linux.py                  |  17 +-
 tests/avocado/boot_linux_console.py          |  11 +-
 tests/avocado/migration.py                   |   1 -
 tests/avocado/ppc_hv_tests.py                | 202 +++++++++
 tests/avocado/ppc_powernv.py                 |  23 +-
 tests/avocado/ppc_pseries.py                 |  20 +-
 tests/qtest/meson.build                      |   1 +
 tests/qtest/pca9552-test.c                   |   6 +-
 tests/qtest/pnv-host-i2c-test.c              | 491 ++++++++++++++++++++++
 tests/qtest/pnv-xscom-test.c                 |  61 +--
 tests/qtest/pnv-xscom.h                      |  80 ++++
 54 files changed, 3318 insertions(+), 352 deletions(-)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 hw/ppc/pnv_chiptod.c
 create mode 100644 hw/ppc/pnv_n1_chiplet.c
 create mode 100644 hw/ppc/pnv_nest_pervasive.c
 rename hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} (97%)
 create mode 100644 include/hw/i2c/pnv_i2c_regs.h
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 include/hw/ppc/pnv_n1_chiplet.h
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
 create mode 100644 tests/avocado/ppc_hv_tests.py
 create mode 100644 tests/qtest/pnv-host-i2c-test.c
 create mode 100644 tests/qtest/pnv-xscom.h

