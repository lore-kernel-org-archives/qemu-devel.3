Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E578CC61DDE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiB-00081a-Lg; Sat, 29 Aug 2026 19:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiA-00080e-7j; Sat, 29 Aug 2026 19:43:46 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Si6-0006BS-T5; Sat, 29 Aug 2026 19:43:45 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzZ3M2szBqXX;
 Sun, 30 Aug 2026 01:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047018;
 bh=a5Xw4YudvCUeVst5P5xw1vGUa1vjBCGFjtEeOtUkYiU=;
 h=From:To:Cc:Subject:Date:From;
 b=szGy91vxi3huTf5s5KPpa9KBZh4BAav4te6oTMNAyQkqEtLqx9zdlQ+bZ0A0ItfAF
 1P5dwm+TcjNeoU2WqGuLjN7KQtk0C3GoizWhnvacd3GYB09BYd0kTxsaHjuCNxpijI
 IWbObsQ50/NOd15Kpcpx/cOz1xAy0zIwwVr4aFi4Jt8V8ab2CWgy/OmDo+sEBKYDzL
 YLD6/hj3hEY52O4QDHEdDs9V+qkuaY9boaZ2EQBHtZyF/ohNUpEwlinuG8QoH5g3Se
 7rpR9CZU53UMpxVvQigWu/EKVUBKl/BuohOQS4k66EZJkJ9sXQtAMEF6afv5Q+v4r+
 KUkiLrC9dXF2A==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzZ1Wj5z7v19;
 Sun, 30 Aug 2026 01:43:38 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH RFC v2 00/30] arm: add Raspberry Pi Pico/RP2040 machine
Date: Sun, 30 Aug 2026 01:42:34 +0200
Message-ID: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

This RFC adds a Raspberry Pi Pico / RP2040 machine to QEMU.

The work continues the RP2040/Pico RFC posted by Alex Bennee in 2022:

  https://patchew.org/QEMU/20220110175104.2908956-1-alex.bennee%40linaro.org/

The target is intended primarily for debugging bare-metal Pico firmware and
for running firmware tests in CI without physical hardware.  It provides a
functional, test-oriented model rather than a cycle-accurate RP2040 model.

The machine supports two boot paths.  The default synthetic ROM implements
the RP2040 boot protocol and selected ROM service tables, with optional
QEMU-accelerated helpers for firmware testing.  Alternatively, users may
supply an RP2040 mask ROM image with -bios to exercise the modeled hardware
path.  QEMU does not ship that image, and USB BOOTSEL mass storage is not
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

Changes since RFC v1
====================

Following the QEMU community feedback on RFC v1, I rebuilt the complete
history on current QEMU upstream instead of incrementally revising the
development branch.  The nine broad patches in v1 are now thirty linear,
targeted patches, each focused on one device, prerequisite or testable
behavior.  There are no merge commits in the series.

In particular:

  * peripheral qtests are introduced with the device they validate;
  * guest tests are compiled from in-tree assembly sources by check-tcg;
  * generated machine-code blobs and the Python functional test were removed;
  * multicore, timer, flash/XIP, DMA and boot ROM behavior gained dedicated
    check-tcg coverage;
  * Cortex-M0+ MPU support and generic PL011 DMA outputs are split into
    explicit prerequisite patches;
  * the generic unimplemented-device diagnostic change is excluded and will
    be considered separately;
  * the proposed generic BKPT/gdbstub behavior change is not part of this
    series.  Optional Pico SDK exit handling is local to the Pico machine.

Because the history was completely reconstructed, the range-diff against v1
is very large and mostly reflects the new patch boundaries rather than useful
line-by-line changes.  It is therefore not included with this submission.

Validation
==========

The series was configured and built with:

  ../configure --target-list=arm-softmmu --cross-cc-arm=arm-none-eabi-gcc
  ninja qemu-system-arm

The complete ARM qtest suite reported 61 passes, no failures and one unrelated
skip.  This includes all 18 RP2040 qtests.  All 23 RP2040 check-tcg run targets
also pass; the flash persistence target additionally executes its dedicated
reader image on a second QEMU run.

Known limitations
=================

PIO, ADC, I2C, PWM, the general-purpose SPI controllers, RTC, SWD/debug
fabric, wireless Pico W hardware and external GPIO signal transport are not
implemented.  USB is intentionally shallow and does not implement BOOTSEL
mass storage.  Timing and multicore synchronization are functional rather
than cycle accurate.  These limits are described in the machine manual.

The integration branch and the immutable tag matching this submission are
available at:

  https://github.com/2xs/qemu-rp2040-pico
  https://github.com/2xs/qemu-rp2040-pico/tree/rp2040-pico-rfc-v2

A companion tutorial using Pico SDK examples is available at:

  https://github.com/2xs/qemu-raspi-pico-tutorial

Feedback on the device boundaries, the synthetic ROM approach and suitable
QEMU interfaces for future external GPIO/peripheral signal transport would
be especially welcome.

gilles grimaud (30):
  target/arm: support Cortex-M0+ MPU
  hw/char/pl011: expose DMA request outputs
  hw/misc: add RP2040 diagnostic helpers
  hw/arm: add RP2040 SoC and Raspberry Pi Pico machine
  tests/tcg/arm: add Raspberry Pi Pico smoke tests
  hw/misc: add RP2040 SYSINFO and SYSCFG
  hw/misc: add RP2040 TBMAN and voltage regulator
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
  docs/system/arm: document Raspberry Pi Pico

 MAINTAINERS                                   |   13 +
 configs/devices/arm-softmmu/default.mak       |    1 +
 docs/system/arm/raspi-pico.rst                |  641 +++++
 docs/system/target-arm.rst                    |    1 +
 hw/arm/Kconfig                                |   32 +
 hw/arm/meson.build                            |    2 +
 hw/arm/raspi_pico.c                           |  283 +++
 hw/arm/rp2040.c                               | 2148 +++++++++++++++++
 hw/arm/trace-events                           |    3 +
 hw/char/pl011.c                               |  115 +-
 hw/dma/Kconfig                                |    5 +-
 hw/dma/meson.build                            |    1 +
 hw/dma/rp2040_dma.c                           | 1032 ++++++++
 hw/intc/armv7m_nvic.c                         |    3 +
 hw/misc/Kconfig                               |   54 +
 hw/misc/meson.build                           |   18 +
 hw/misc/rp2040_busctrl.c                      |  208 ++
 hw/misc/rp2040_clocks.c                       |  480 ++++
 hw/misc/rp2040_iobank0.c                      |  353 +++
 hw/misc/rp2040_ioqspi.c                       |  294 +++
 hw/misc/rp2040_nyi.c                          |   47 +
 hw/misc/rp2040_pads.c                         |  323 +++
 hw/misc/rp2040_pll.c                          |  234 ++
 hw/misc/rp2040_psm.c                          |  198 ++
 hw/misc/rp2040_resets.c                       |  152 ++
 hw/misc/rp2040_rosc.c                         |  430 ++++
 hw/misc/rp2040_sio.c                          |  905 +++++++
 hw/misc/rp2040_syscfg.c                       |  244 ++
 hw/misc/rp2040_sysinfo.c                      |  103 +
 hw/misc/rp2040_tbman.c                        |   92 +
 hw/misc/rp2040_timer.c                        |  372 +++
 hw/misc/rp2040_vreg.c                         |  178 ++
 hw/misc/rp2040_watchdog.c                     |  361 +++
 hw/misc/rp2040_xosc.c                         |  237 ++
 hw/ssi/Kconfig                                |    3 +
 hw/ssi/meson.build                            |    1 +
 hw/ssi/rp2040_xip.c                           | 1457 +++++++++++
 hw/ssi/trace-events                           |   12 +
 include/hw/arm/rp2040.h                       |  127 +
 include/hw/char/pl011.h                       |    8 +
 include/hw/dma/rp2040_dma.h                   |   77 +
 include/hw/misc/rp2040_busctrl.h              |   29 +
 include/hw/misc/rp2040_clocks.h               |   36 +
 include/hw/misc/rp2040_iobank0.h              |   45 +
 include/hw/misc/rp2040_ioqspi.h               |   36 +
 include/hw/misc/rp2040_nyi.h                  |   19 +
 include/hw/misc/rp2040_pads.h                 |   42 +
 include/hw/misc/rp2040_pll.h                  |   37 +
 include/hw/misc/rp2040_psm.h                  |   40 +
 include/hw/misc/rp2040_resets.h               |   28 +
 include/hw/misc/rp2040_rosc.h                 |   42 +
 include/hw/misc/rp2040_sio.h                  |   57 +
 include/hw/misc/rp2040_syscfg.h               |   42 +
 include/hw/misc/rp2040_sysinfo.h              |   25 +
 include/hw/misc/rp2040_tbman.h                |   25 +
 include/hw/misc/rp2040_timer.h                |   39 +
 include/hw/misc/rp2040_vreg.h                 |   28 +
 include/hw/misc/rp2040_watchdog.h             |   35 +
 include/hw/misc/rp2040_xosc.h                 |   33 +
 include/hw/ssi/rp2040_xip.h                   |   92 +
 scripts/uf2-to-flash.py                       |  462 ++++
 target/arm/cpu.c                              |   12 +-
 target/arm/ptw.c                              |    3 +-
 target/arm/tcg/m_helper.c                     |   10 +-
 tests/qtest/meson.build                       |   20 +
 tests/qtest/pl011-test.c                      |   95 +
 tests/qtest/rp2040-busctrl-test.c             |   92 +
 tests/qtest/rp2040-clocks-test.c              |  107 +
 tests/qtest/rp2040-dma-test.c                 |  374 +++
 tests/qtest/rp2040-iobank0-test.c             |  122 +
 tests/qtest/rp2040-ioqspi-test.c              |   81 +
 tests/qtest/rp2040-pads-test.c                |  105 +
 tests/qtest/rp2040-psm-test.c                 |   81 +
 tests/qtest/rp2040-resets-test.c              |   84 +
 tests/qtest/rp2040-rosc-test.c                |  146 ++
 tests/qtest/rp2040-sio-test.c                 |  270 +++
 tests/qtest/rp2040-sysinfo-syscfg-test.c      |  176 ++
 tests/qtest/rp2040-tbman-test.c               |   32 +
 tests/qtest/rp2040-timer-test.c               |  149 ++
 tests/qtest/rp2040-uart-test.c                |  142 ++
 tests/qtest/rp2040-usb-test.c                 |   80 +
 tests/qtest/rp2040-vreg-test.c                |   79 +
 tests/qtest/rp2040-watchdog-test.c            |  148 ++
 tests/qtest/rp2040-xip-test.c                 |  354 +++
 tests/tcg/arm/Makefile.softmmu-target         |  184 ++
 tests/tcg/arm/system/rp2040-bkpt-hardfault.S  |   94 +
 .../tcg/arm/system/rp2040-bkpt-hardfault.ref  |    2 +
 tests/tcg/arm/system/rp2040-boot.S            |   30 +
 tests/tcg/arm/system/rp2040-boot2-w25q080.S   |  178 ++
 tests/tcg/arm/system/rp2040-bootrom-float.S   |  206 ++
 tests/tcg/arm/system/rp2040-bootrom-float.ref |    4 +
 tests/tcg/arm/system/rp2040-bootrom-helpers.S |  235 ++
 .../tcg/arm/system/rp2040-bootrom-helpers.ref |    5 +
 tests/tcg/arm/system/rp2040-core0-xip-fault.S |  193 ++
 .../tcg/arm/system/rp2040-core0-xip-fault.ref |    2 +
 tests/tcg/arm/system/rp2040-core1-launch.S    |  216 ++
 tests/tcg/arm/system/rp2040-core1-launch.ref  |    4 +
 tests/tcg/arm/system/rp2040-core1-xip-fault.S |  331 +++
 .../tcg/arm/system/rp2040-core1-xip-fault.ref |    3 +
 tests/tcg/arm/system/rp2040-dma-memory.S      |  198 ++
 tests/tcg/arm/system/rp2040-dma-memory.ref    |    4 +
 tests/tcg/arm/system/rp2040-dma-uart.S        |  267 ++
 tests/tcg/arm/system/rp2040-dma-uart0.ref     |    3 +
 tests/tcg/arm/system/rp2040-dma-uart1.ref     |    3 +
 tests/tcg/arm/system/rp2040-exit.S            |   55 +
 .../arm/system/rp2040-flash-busy-hardfault.S  |  179 ++
 .../system/rp2040-flash-busy-hardfault.ref    |    2 +
 .../arm/system/rp2040-flash-busy-lockout.S    |  434 ++++
 .../arm/system/rp2040-flash-busy-lockout.ref  |    4 +
 tests/tcg/arm/system/rp2040-flash-commands.S  |  375 +++
 .../tcg/arm/system/rp2040-flash-commands.ref  |    6 +
 tests/tcg/arm/system/rp2040-flash-ioqspi.S    |  212 ++
 tests/tcg/arm/system/rp2040-flash-ioqspi.ref  |    2 +
 tests/tcg/arm/system/rp2040-flash-lockout.S   |  387 +++
 tests/tcg/arm/system/rp2040-flash-lockout.ref |    6 +
 .../arm/system/rp2040-flash-persist-reader.S  |   87 +
 .../system/rp2040-flash-persist-reader.ref    |    1 +
 tests/tcg/arm/system/rp2040-mpu.S             |  188 ++
 tests/tcg/arm/system/rp2040-mpu.ref           |    5 +
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
 130 files changed, 19992 insertions(+), 12 deletions(-)
 create mode 100644 docs/system/arm/raspi-pico.rst
 create mode 100644 hw/arm/raspi_pico.c
 create mode 100644 hw/arm/rp2040.c
 create mode 100644 hw/dma/rp2040_dma.c
 create mode 100644 hw/misc/rp2040_busctrl.c
 create mode 100644 hw/misc/rp2040_clocks.c
 create mode 100644 hw/misc/rp2040_iobank0.c
 create mode 100644 hw/misc/rp2040_ioqspi.c
 create mode 100644 hw/misc/rp2040_nyi.c
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
 create mode 100644 include/hw/misc/rp2040_busctrl.h
 create mode 100644 include/hw/misc/rp2040_clocks.h
 create mode 100644 include/hw/misc/rp2040_iobank0.h
 create mode 100644 include/hw/misc/rp2040_ioqspi.h
 create mode 100644 include/hw/misc/rp2040_nyi.h
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
 create mode 100644 tests/qtest/rp2040-sysinfo-syscfg-test.c
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
 create mode 100644 tests/tcg/arm/system/rp2040-flash-persist-reader.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-persist-reader.ref
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

-- 
2.55.0

