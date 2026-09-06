Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93418C79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3InK-0002G9-L4; Sun, 06 Sep 2026 15:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InH-0002FF-HN; Sun, 06 Sep 2026 15:44:47 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InD-0006wr-Lp; Sun, 06 Sep 2026 15:44:47 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdLJ80895zBqYp;
 Sun,  6 Sep 2026 21:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723880;
 bh=JcVT2D6mAa815I53mJbfP77rpZ/pEfqWuXcB3jlmKEM=;
 h=From:To:Cc:Subject:Date:From;
 b=XL5K9/zSXCfF0cbQzRJ4wi0tLGqqvV/P+cLDmY0hpQO3NFqmq1CLrmA9TVNYg9POz
 rzpEaVfhyWoZ2os8E9+tAw6DCYxGYJb9piPF2LQfZJay+wjebdMR3UzyJJ6KnudX5S
 vU2FQ4QQBiUebmvfM9kV92lzC+Tv4Tu6f9i/Tvom3z8P7HfdEr0bkLhieClhrkWxkS
 EsVn7QfSbd8yeIe1pcdflS0hpJ8R7n6xbl4aMJaqyN4nCcSqjwzVqqN0sYU4I8rwOy
 Xm1g1QkLHwBKXaJWGUgFphzRMSGTN9Xy4tvRPhrl2BcEXM5Xo4cu2bektu1Uaypdd8
 8wPuu850vYFTA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJ73XlFz7wHs;
 Sun,  6 Sep 2026 21:44:39 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [RFC PATCH v3 00/36] arm: add Raspberry Pi Pico/RP2040 machine
Date: Sun,  6 Sep 2026 21:43:59 +0200
Message-ID: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This RFC adds a Raspberry Pi Pico / RP2040 machine to QEMU.

The work continues the RP2040/Pico RFC posted by Alex Bennee in 2022:

  https://patchew.org/QEMU/20220110175104.2908956-1-alex.bennee%40linaro.org/

The target is intended primarily for debugging bare-metal Pico firmware and
for running firmware tests in CI without physical hardware. It provides a
functional, test-oriented model rather than a cycle-accurate RP2040 model.

The machine supports two boot paths. The default synthetic ROM implements
the RP2040 boot protocol and selected ROM service tables, with optional
QEMU-accelerated helpers for firmware testing. Alternatively, users may
supply an RP2040 mask ROM image with -bios to exercise the modeled hardware
path. QEMU does not ship that image, and USB BOOTSEL mass storage is not
currently supported.

Implemented functionality includes:

  * dual Cortex-M0+ cores, SRAM and external XIP flash;
  * ELF, UF2 and raw -kernel loading;
  * optional persistent raw flash-file backing;
  * UART0/UART1, pin multiplexing and DMA request signaling;
  * SIO FIFOs, spinlocks, divider, interpolators and multicore launch;
  * clocks, PLLs, oscillators, resets, power state, watchdog and alarms;
  * IO_BANK0, IO_QSPI, pads, BUSCTRL, SYSINFO, SYSCFG, TBMAN and VREG;
  * XIP/SSI flash commands, NOR programming rules and busy faults;
  * RP2040 DMA transfers, chaining, rings, sniffing and UART/XIP DREQ;
  * synthetic boot ROM memory, bit, float, double and flash helpers.

Changes since RFC v2
====================

RFC v2 is archived at:

  https://patchew.org/QEMU/20260829234308.33725-1-gilles.grimaud%40univ-lille.fr/

The series has been rebased onto QEMU upstream commit ff1d2d19d7e2 and
reworked in response to review by Alex Bennee and Peter Maydell:

  * Armv6-M CONTROL.nPRIV handling is now an independent generic Arm patch.
    The Cortex-M0+ MPU patch reuses the compatible PMSAv7 storage and
    translation path without changing VTOR or advertising ARM_FEATURE_V7.
    Dedicated tests cover privilege transitions, MPU register behavior,
    region priority and access faults.
  * The RP2040 is dual-core from the initial SoC patch. Each CPU has its own
    memory container, PPB, NVIC, SysTick and banked SIO view over the shared
    board address space.
  * Per-processor IO_BANK0, IO_QSPI and SIO interrupt outputs remain distinct
    through interrupt and SYSCFG NMI routing.
  * SYSINFO and SYSCFG, and TBMAN and VREG, are now separate patches. Shared
    register definitions remove duplication between models and qtests. All
    RP2040 devices are selected by CONFIG_RP2040 rather than per-device
    Kconfig symbols.
  * Speculative MEMPOWERDOWN memory overlays have been removed. The register
    remains visible, but does not invent access-fault behavior not justified
    by the documentation.
  * The ROSC seed is now a typed uint64 property. An explicit zero seed is
    distinguished from an unset property and covered by qtest.
  * XIP now uses a ROMD-backed region during normal execution and switches to
    device callbacks while flash is busy. This preserves modeled busy faults
    while reducing a small matrix benchmark from about 5.7 seconds to about
    5.6 milliseconds on the same host.
  * Findings retained from the experimental PatchPilot review were checked
    against the datasheet. SSI writes no longer cause flash side effects
    before the controller and flash are active, and watchdog REASON survives
    a watchdog reset before clearing on a later hardware reset.
  * Synthetic floating-point NaN comparisons were corrected against the boot
    ROM behavior. The DMA controller is marked non-migratable until active
    transfer state can be restored consistently.

The Arm system-mode guest tests now use Meson check-tcg and are compiled
from source with the Arm TCG cross compiler.

Validation
==========

The final arm-softmmu build succeeds. All 46 arm-softmmu check-tcg tests and
all 19 RP2040 qtests pass. The series was checked with
scripts/checkpatch.pl --strict.

Known limitations
=================

PIO, ADC, I2C, PWM, the general-purpose SPI controllers, RTC, SWD/debug
fabric, wireless Pico W hardware and external GPIO signal transport are not
implemented. USB is intentionally shallow and does not implement BOOTSEL
mass storage. Timing and multicore synchronization are functional rather
than cycle accurate. These limits are described in the machine manual.

A tree matching this posting is available for testing at:

  https://github.com/2xs/qemu-rp2040-pico/tree/rp2040-pico-rfc-v3


Gilles Grimaud (36):
  target/arm: enforce Armv6-M NVIC limits
  target/arm: allow Armv6-M to set CONTROL.nPRIV
  target/arm: support Cortex-M0+ MPU
  hw/char/pl011: expose DMA request outputs
  hw/misc: add common RP2040 peripheral definitions
  hw/arm: add RP2040 SoC and Raspberry Pi Pico machine
  tests/tcg/arm: add Raspberry Pi Pico smoke tests
  tests/tcg/arm: test the RP2040 Cortex-M0+ MPU
  hw/misc: add RP2040 SYSINFO
  hw/misc: add RP2040 SYSCFG
  hw/misc: add RP2040 voltage regulator
  hw/misc: add RP2040 testbench manager
  hw/misc: add RP2040 crystal and ring oscillators
  hw/misc: add RP2040 PLL and clock controller
  hw/misc: add RP2040 reset and power state controllers
  hw/misc: add RP2040 watchdog
  hw/misc: add RP2040 pad controls
  hw/misc: add RP2040 IO_BANK0
  hw/misc: add RP2040 IO_QSPI
  hw/char: integrate RP2040 UART pinmux
  hw/misc: add RP2040 SIO and multicore support
  tests/tcg/arm: test RP2040 SIO and multicore
  hw/timer: add RP2040 timer and alarms
  tests/tcg/arm: test RP2040 timer alarm interrupt
  hw/ssi: add RP2040 XIP flash controller
  tests/tcg/arm: test RP2040 flash and XIP behavior
  hw/dma: add RP2040 DMA controller
  tests/tcg/arm: test RP2040 DMA transfers
  hw/ssi: load RP2040 UF2 flash images
  hw/misc: add RP2040 bus controller
  hw/arm: add shallow RP2040 USB controller
  hw/arm: add RP2040 synthetic boot ROM service tables
  hw/arm: add RP2040 synthetic boot ROM accelerated helpers
  hw/arm: add optional Pico SDK exit handling
  hw/arm: route RP2040 banked interrupts per core
  docs/system/arm: document Raspberry Pi Pico

 MAINTAINERS                                   |   13 +
 configs/devices/arm-softmmu/default.mak       |    1 +
 docs/system/arm/raspi-pico.rst                |  649 +++++
 docs/system/target-arm.rst                    |    1 +
 hw/arm/Kconfig                                |   12 +
 hw/arm/meson.build                            |    2 +
 hw/arm/raspi_pico.c                           |  273 +++
 hw/arm/rp2040.c                               | 2133 +++++++++++++++++
 hw/arm/trace-events                           |    3 +
 hw/char/pl011.c                               |  118 +-
 hw/dma/Kconfig                                |    2 +-
 hw/dma/meson.build                            |    1 +
 hw/dma/rp2040_dma.c                           | 1008 ++++++++
 hw/intc/armv7m_nvic.c                         |   34 +-
 hw/misc/meson.build                           |   19 +
 hw/misc/rp2040_busctrl.c                      |  189 ++
 hw/misc/rp2040_clocks.c                       |  422 ++++
 hw/misc/rp2040_iobank0.c                      |  333 +++
 hw/misc/rp2040_ioqspi.c                       |  292 +++
 hw/misc/rp2040_pads.c                         |  303 +++
 hw/misc/rp2040_pll.c                          |  198 ++
 hw/misc/rp2040_psm.c                          |  179 ++
 hw/misc/rp2040_resets.c                       |  132 +
 hw/misc/rp2040_rosc.c                         |  407 ++++
 hw/misc/rp2040_sio.c                          |  907 +++++++
 hw/misc/rp2040_syscfg.c                       |  220 ++
 hw/misc/rp2040_sysinfo.c                      |  102 +
 hw/misc/rp2040_tbman.c                        |   88 +
 hw/misc/rp2040_timer.c                        |  352 +++
 hw/misc/rp2040_vreg.c                         |  149 ++
 hw/misc/rp2040_watchdog.c                     |  349 +++
 hw/misc/rp2040_xosc.c                         |  217 ++
 hw/ssi/meson.build                            |    1 +
 hw/ssi/rp2040_xip.c                           | 1502 ++++++++++++
 hw/ssi/trace-events                           |   12 +
 include/hw/arm/rp2040.h                       |  127 +
 include/hw/char/pl011.h                       |    8 +
 include/hw/dma/rp2040_dma.h                   |   77 +
 include/hw/misc/rp2040.h                      |   32 +
 include/hw/misc/rp2040_busctrl.h              |   29 +
 include/hw/misc/rp2040_clocks.h               |   79 +
 include/hw/misc/rp2040_iobank0.h              |   45 +
 include/hw/misc/rp2040_ioqspi.h               |   38 +
 include/hw/misc/rp2040_pads.h                 |   42 +
 include/hw/misc/rp2040_pll.h                  |   60 +
 include/hw/misc/rp2040_psm.h                  |   40 +
 include/hw/misc/rp2040_resets.h               |   28 +
 include/hw/misc/rp2040_rosc.h                 |   42 +
 include/hw/misc/rp2040_sio.h                  |   65 +
 include/hw/misc/rp2040_syscfg.h               |   41 +
 include/hw/misc/rp2040_sysinfo.h              |   25 +
 include/hw/misc/rp2040_tbman.h                |   29 +
 include/hw/misc/rp2040_timer.h                |   39 +
 include/hw/misc/rp2040_vreg.h                 |   46 +
 include/hw/misc/rp2040_watchdog.h             |   36 +
 include/hw/misc/rp2040_xosc.h                 |   33 +
 include/hw/ssi/rp2040_xip.h                   |  108 +
 scripts/uf2-to-flash.py                       |  462 ++++
 target/arm/cpu.c                              |   12 +-
 target/arm/machine.c                          |    3 +-
 target/arm/ptw.c                              |   10 +-
 target/arm/tcg/m_helper.c                     |    2 +-
 tests/qtest/meson.build                       |   22 +
 tests/qtest/pl011-test.c                      |  106 +
 tests/qtest/rp2040-busctrl-test.c             |   92 +
 tests/qtest/rp2040-clocks-test.c              |  105 +
 tests/qtest/rp2040-dma-test.c                 |  378 +++
 tests/qtest/rp2040-iobank0-test.c             |  119 +
 tests/qtest/rp2040-ioqspi-test.c              |  103 +
 tests/qtest/rp2040-pads-test.c                |  102 +
 tests/qtest/rp2040-psm-test.c                 |   81 +
 tests/qtest/rp2040-resets-test.c              |   84 +
 tests/qtest/rp2040-rosc-test.c                |  151 ++
 tests/qtest/rp2040-sio-test.c                 |  270 +++
 tests/qtest/rp2040-syscfg-test.c              |   97 +
 tests/qtest/rp2040-sysinfo-test.c             |   37 +
 tests/qtest/rp2040-tbman-test.c               |   29 +
 tests/qtest/rp2040-timer-test.c               |  149 ++
 tests/qtest/rp2040-uart-test.c                |  139 ++
 tests/qtest/rp2040-usb-test.c                 |   80 +
 tests/qtest/rp2040-vreg-test.c                |   79 +
 tests/qtest/rp2040-watchdog-test.c            |  170 ++
 tests/qtest/rp2040-xip-test.c                 |  427 ++++
 tests/tcg/arm/system/meson.build              |  159 ++
 tests/tcg/arm/system/rp2040-bkpt-hardfault.S  |   94 +
 .../tcg/arm/system/rp2040-bkpt-hardfault.ref  |    2 +
 tests/tcg/arm/system/rp2040-boot.S            |   30 +
 tests/tcg/arm/system/rp2040-boot2-w25q080.S   |  178 ++
 tests/tcg/arm/system/rp2040-bootrom-float.S   |  247 ++
 tests/tcg/arm/system/rp2040-bootrom-float.ref |    4 +
 tests/tcg/arm/system/rp2040-bootrom-helpers.S |  235 ++
 .../tcg/arm/system/rp2040-bootrom-helpers.ref |    5 +
 tests/tcg/arm/system/rp2040-check-exit.sh     |   14 +
 tests/tcg/arm/system/rp2040-core0-xip-fault.S |  193 ++
 .../tcg/arm/system/rp2040-core0-xip-fault.ref |    2 +
 tests/tcg/arm/system/rp2040-core1-launch.S    |  216 ++
 tests/tcg/arm/system/rp2040-core1-launch.ref  |    4 +
 tests/tcg/arm/system/rp2040-core1-xip-fault.S |  331 +++
 .../tcg/arm/system/rp2040-core1-xip-fault.ref |    3 +
 tests/tcg/arm/system/rp2040-dma-memory.S      |  198 ++
 tests/tcg/arm/system/rp2040-dma-memory.ref    |    4 +
 tests/tcg/arm/system/rp2040-dma-uart.S        |  267 +++
 tests/tcg/arm/system/rp2040-dma-uart0.ref     |    3 +
 tests/tcg/arm/system/rp2040-dma-uart1.ref     |    3 +
 tests/tcg/arm/system/rp2040-exit.S            |   55 +
 .../arm/system/rp2040-flash-busy-hardfault.S  |  179 ++
 .../system/rp2040-flash-busy-hardfault.ref    |    2 +
 .../arm/system/rp2040-flash-busy-lockout.S    |  434 ++++
 .../arm/system/rp2040-flash-busy-lockout.ref  |    4 +
 tests/tcg/arm/system/rp2040-flash-commands.S  |  405 ++++
 .../tcg/arm/system/rp2040-flash-commands.ref  |    6 +
 tests/tcg/arm/system/rp2040-flash-ioqspi.S    |  212 ++
 tests/tcg/arm/system/rp2040-flash-ioqspi.ref  |    2 +
 tests/tcg/arm/system/rp2040-flash-lockout.S   |  387 +++
 tests/tcg/arm/system/rp2040-flash-lockout.ref |    6 +
 .../system/rp2040-flash-persist-reader.ref    |    1 +
 tests/tcg/arm/system/rp2040-flash-persist.sh  |   34 +
 tests/tcg/arm/system/rp2040-mpu.S             |  361 +++
 tests/tcg/arm/system/rp2040-mpu.ref           |   10 +
 tests/tcg/arm/system/rp2040-psm-proc1.S       |  143 ++
 tests/tcg/arm/system/rp2040-psm-proc1.ref     |    5 +
 tests/tcg/arm/system/rp2040-sio-divider.S     |  169 ++
 tests/tcg/arm/system/rp2040-sio-divider.ref   |    2 +
 tests/tcg/arm/system/rp2040-sio-fifo.S        |  154 ++
 tests/tcg/arm/system/rp2040-sio-fifo.ref      |    2 +
 tests/tcg/arm/system/rp2040-timer.S           |  116 +
 tests/tcg/arm/system/rp2040-timer.ref         |    2 +
 tests/tcg/arm/system/rp2040-uart.S            |   58 +
 tests/tcg/arm/system/rp2040-uart.ref          |    1 +
 tests/tcg/arm/system/rp2040.ld                |   45 +
 tests/tcg/arm/system/test-armv6m-control.S    |   85 +
 tests/tcg/arm/system/test-armv6m-nvic.S       |   70 +
 132 files changed, 20127 insertions(+), 16 deletions(-)
 create mode 100644 docs/system/arm/raspi-pico.rst
 create mode 100644 hw/arm/raspi_pico.c
 create mode 100644 hw/arm/rp2040.c
 create mode 100644 hw/dma/rp2040_dma.c
 create mode 100644 hw/misc/rp2040_busctrl.c
 create mode 100644 hw/misc/rp2040_clocks.c
 create mode 100644 hw/misc/rp2040_iobank0.c
 create mode 100644 hw/misc/rp2040_ioqspi.c
 create mode 100644 hw/misc/rp2040_pads.c
 create mode 100644 hw/misc/rp2040_pll.c
 create mode 100644 hw/misc/rp2040_psm.c
 create mode 100644 hw/misc/rp2040_resets.c
 create mode 100644 hw/misc/rp2040_rosc.c
 create mode 100644 hw/misc/rp2040_sio.c
 create mode 100644 hw/misc/rp2040_syscfg.c
 create mode 100644 hw/misc/rp2040_sysinfo.c
 create mode 100644 hw/misc/rp2040_tbman.c
 create mode 100644 hw/misc/rp2040_timer.c
 create mode 100644 hw/misc/rp2040_vreg.c
 create mode 100644 hw/misc/rp2040_watchdog.c
 create mode 100644 hw/misc/rp2040_xosc.c
 create mode 100644 hw/ssi/rp2040_xip.c
 create mode 100644 include/hw/arm/rp2040.h
 create mode 100644 include/hw/dma/rp2040_dma.h
 create mode 100644 include/hw/misc/rp2040.h
 create mode 100644 include/hw/misc/rp2040_busctrl.h
 create mode 100644 include/hw/misc/rp2040_clocks.h
 create mode 100644 include/hw/misc/rp2040_iobank0.h
 create mode 100644 include/hw/misc/rp2040_ioqspi.h
 create mode 100644 include/hw/misc/rp2040_pads.h
 create mode 100644 include/hw/misc/rp2040_pll.h
 create mode 100644 include/hw/misc/rp2040_psm.h
 create mode 100644 include/hw/misc/rp2040_resets.h
 create mode 100644 include/hw/misc/rp2040_rosc.h
 create mode 100644 include/hw/misc/rp2040_sio.h
 create mode 100644 include/hw/misc/rp2040_syscfg.h
 create mode 100644 include/hw/misc/rp2040_sysinfo.h
 create mode 100644 include/hw/misc/rp2040_tbman.h
 create mode 100644 include/hw/misc/rp2040_timer.h
 create mode 100644 include/hw/misc/rp2040_vreg.h
 create mode 100644 include/hw/misc/rp2040_watchdog.h
 create mode 100644 include/hw/misc/rp2040_xosc.h
 create mode 100644 include/hw/ssi/rp2040_xip.h
 create mode 100755 scripts/uf2-to-flash.py
 create mode 100644 tests/qtest/pl011-test.c
 create mode 100644 tests/qtest/rp2040-busctrl-test.c
 create mode 100644 tests/qtest/rp2040-clocks-test.c
 create mode 100644 tests/qtest/rp2040-dma-test.c
 create mode 100644 tests/qtest/rp2040-iobank0-test.c
 create mode 100644 tests/qtest/rp2040-ioqspi-test.c
 create mode 100644 tests/qtest/rp2040-pads-test.c
 create mode 100644 tests/qtest/rp2040-psm-test.c
 create mode 100644 tests/qtest/rp2040-resets-test.c
 create mode 100644 tests/qtest/rp2040-rosc-test.c
 create mode 100644 tests/qtest/rp2040-sio-test.c
 create mode 100644 tests/qtest/rp2040-syscfg-test.c
 create mode 100644 tests/qtest/rp2040-sysinfo-test.c
 create mode 100644 tests/qtest/rp2040-tbman-test.c
 create mode 100644 tests/qtest/rp2040-timer-test.c
 create mode 100644 tests/qtest/rp2040-uart-test.c
 create mode 100644 tests/qtest/rp2040-usb-test.c
 create mode 100644 tests/qtest/rp2040-vreg-test.c
 create mode 100644 tests/qtest/rp2040-watchdog-test.c
 create mode 100644 tests/qtest/rp2040-xip-test.c
 create mode 100644 tests/tcg/arm/system/rp2040-bkpt-hardfault.S
 create mode 100644 tests/tcg/arm/system/rp2040-bkpt-hardfault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-boot.S
 create mode 100644 tests/tcg/arm/system/rp2040-boot2-w25q080.S
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-float.S
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-float.ref
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-helpers.S
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-helpers.ref
 create mode 100755 tests/tcg/arm/system/rp2040-check-exit.sh
 create mode 100644 tests/tcg/arm/system/rp2040-core0-xip-fault.S
 create mode 100644 tests/tcg/arm/system/rp2040-core0-xip-fault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-core1-launch.S
 create mode 100644 tests/tcg/arm/system/rp2040-core1-launch.ref
 create mode 100644 tests/tcg/arm/system/rp2040-core1-xip-fault.S
 create mode 100644 tests/tcg/arm/system/rp2040-core1-xip-fault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-memory.S
 create mode 100644 tests/tcg/arm/system/rp2040-dma-memory.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart.S
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart0.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart1.ref
 create mode 100644 tests/tcg/arm/system/rp2040-exit.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-hardfault.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-hardfault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-lockout.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-lockout.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-commands.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-commands.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-ioqspi.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-ioqspi.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-lockout.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-lockout.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-persist-reader.ref
 create mode 100755 tests/tcg/arm/system/rp2040-flash-persist.sh
 create mode 100644 tests/tcg/arm/system/rp2040-mpu.S
 create mode 100644 tests/tcg/arm/system/rp2040-mpu.ref
 create mode 100644 tests/tcg/arm/system/rp2040-psm-proc1.S
 create mode 100644 tests/tcg/arm/system/rp2040-psm-proc1.ref
 create mode 100644 tests/tcg/arm/system/rp2040-sio-divider.S
 create mode 100644 tests/tcg/arm/system/rp2040-sio-divider.ref
 create mode 100644 tests/tcg/arm/system/rp2040-sio-fifo.S
 create mode 100644 tests/tcg/arm/system/rp2040-sio-fifo.ref
 create mode 100644 tests/tcg/arm/system/rp2040-timer.S
 create mode 100644 tests/tcg/arm/system/rp2040-timer.ref
 create mode 100644 tests/tcg/arm/system/rp2040-uart.S
 create mode 100644 tests/tcg/arm/system/rp2040-uart.ref
 create mode 100644 tests/tcg/arm/system/rp2040.ld
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S
 create mode 100644 tests/tcg/arm/system/test-armv6m-nvic.S

-- 
2.55.0


