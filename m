Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E2C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgVK1-0006og-6S; Sun, 05 Jul 2026 18:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUvx-00025G-4x; Sun, 05 Jul 2026 18:03:29 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUvt-0001fF-SA; Sun, 05 Jul 2026 18:03:28 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4gthMF5fKRzBsM9;
 Mon,  6 Jul 2026 00:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783289001;
 bh=zGdwzc9XXFKPr+yzunYNfOPbdqld3Eksizs5+JWmP9Q=;
 h=From:To:Cc:Subject:Date:From;
 b=uUHupAdVNNBEpuS5+et4aCGeDo7qpWg1wMCV/OB3/8KFtW18m9VGtgxDlzKxFvl4O
 lvHSKok/6QDnVAHc0mmPbRugy9V5eROr3ROXxc6oa10nedvcDMA7Ezg/W3Pm0nfEdq
 xo04g5ky+TH9gPizqbRhpZpqojM8AhvOCSuPSmyM6zjUCG2yGYlVLgyHbqweweCv7X
 etVCV8Py3c4Bv+cN7i30JSAbwwAJcR+diKR/d9AcPJFGJieWY/h1/UsZzN92sDfU5Q
 uJklh2Ru337JTEZq0Z1R+VGlBBojXgkDls130pflRxVjCZyifqfQHT06YnFVzXONqH
 BfPcJPPR+9V/A==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4gthMF4SJdz6sT6;
 Mon,  6 Jul 2026 00:03:21 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH RFC v1 0/9] arm: add Raspberry Pi Pico/RP2040 machine
Date: Mon,  6 Jul 2026 00:03:11 +0200
Message-ID: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
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
X-Mailman-Approved-At: Sun, 05 Jul 2026 18:28:16 -0400
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

The series is a continuation of the RP2040/Pico RFC work posted by
Alex Bennée in 2022:

  https://patchew.org/QEMU/20220110175104.2908956-1-alex.bennee%40linaro.org/

The goal is not to claim a complete RP2040 model.  The goal is to provide
a useful QEMU target for:

  * debugging bare-metal Pico firmware, including through the QEMU gdbstub;
  * running Pico firmware in CI, without a physical board;
  * exercising XIP flash, UART, DMA, dual-core startup and common Pico SDK
    paths in a deterministic way.

The machine supports two boot paths:

  * the default synthetic ROM path, intended as a valid QEMU execution
    environment for firmware tests and CI.  It uses a QEMU-only pseudo-device
    for a few shortcuts where that keeps the model small and fast, notably
    floating-point ROM helpers and flash helper calls;
  * an external RP2040 mask ROM image through -bios.  QEMU does not ship
    this image.  A user-provided pipico.rom can boot through the modeled
    hardware where the accessed devices are implemented.  Nevertheless,
    the USB BOOTSEL mass-storage path is outside the scope of the QEMU
    target presented here for now.

Implemented functionality includes:

  * Raspberry Pi Pico board and RP2040 SoC model;
  * Cortex-M0+ cores, SRAM, XIP flash and an optional persistent raw
    flash-file backend;
  * -kernel loading for ELF, UF2 and raw images;
  * UART0 and UART1 backed by QEMU serial backends;
  * functional RP2040 DMA, including chaining, rings, sniff checksums,
    abort/error status and UART/XIP-visible DREQ paths;
  * functional SIO pieces used by the SDK, including FIFOs, spinlocks,
    interpolators and hardware dividers;
  * clocks, resets, watchdog, timer/alarms, ROSC randomness, SYSINFO,
    SYSCFG, TBMAN, PSM, PLL/XOSC, IO_BANK0, pads and IO_QSPI models;
  * qtests and functional tests for the modeled contracts.

The model is functional rather than cycle accurate.  Known shallow or missing
areas include USB, PIO, ADC, I2C, PWM, SPI peripherals outside the XIP/SSI
path, RTC, SWD/debug fabric, the wireless hardware found on Pico W boards and
full external signal modeling for GPIO pins.

Validation so far includes QEMU qtests, functional tests, synthetic ROM boots,
selected boots with an external pipico.rom, UF2 and ELF loading, persistent
flash-file reboots, dual-core SDK startup, DMA/UART transfers, XIP stream and
SSI DMA reads, and a set of Pico SDK example smoke tests.  The integration
branch used to prepare this RFC is available at:

  https://github.com/2xs/qemu-rp2040-pico

A small companion tutorial repository is available here:

  https://github.com/2xs/qemu-raspi-pico-tutorial

Two design questions are especially open for RFC feedback.

First, external microcontroller signals.  For debugging and CI it would be
useful to connect GPIOs, and later I2C/SPI-like external signal paths, to host
processes or files.  QMP is convenient for synthetic control but feels heavy
for high-rate signals or for connecting two QEMU processes together.  Chardevs
are closer to existing serial practice, but the right granularity and format
are unclear: one chardev per pin, per GPIO port, or per peripheral protocol?
Should timestamps be part of the stream, or should a first version simply use
raw untimestamped signal values?  My current strawman would be one raw chardev
per externally connected signal, without timestamps, but I would appreciate
guidance before growing that interface.

Second, display and serial defaults for microcontroller boards.  Today this
machine keeps the usual QEMU behaviour: the UART can appear on the graphical
serial console unless the user chooses -nographic, -serial stdio, or another
serial backend.  For a Pico-class board, a graphical display that only carries
the serial console is not very meaningful.  An implicit nographic-style default,
or a small graphical board surface showing things such as the on-board LED and
BOOTSEL button, might be more natural for this class of hardware.  I have not
changed the default because I suspect this is not mainstream QEMU practice, but
feedback on the preferred direction would be helpful.

Gilles Grimaud (9):
  hw/misc: add RP2040 peripheral models
  hw/ssi: add RP2040 XIP flash model
  hw/dma: add RP2040 DMA controller
  hw/char/pl011: expose DMA request notifications
  hw/arm: add Raspberry Pi Pico RP2040 machine
  scripts: add UF2 to RP2040 flash image converter
  tests/qtest: add RP2040 peripheral tests
  tests/functional: add Raspberry Pi Pico tests
  docs/system/arm: document Raspberry Pi Pico machine

 MAINTAINERS                              |   20 +
 configs/devices/arm-softmmu/default.mak  |    1 +
 docs/system/arm/raspi-pico.rst           |  616 +++++++
 docs/system/target-arm.rst               |    1 +
 hw/arm/Kconfig                           |   32 +
 hw/arm/meson.build                       |    2 +
 hw/arm/raspi_pico.c                      |  265 +++
 hw/arm/rp2040.c                          | 2052 ++++++++++++++++++++++
 hw/arm/trace-events                      |    3 +
 hw/char/pl011.c                          |  116 +-
 hw/dma/Kconfig                           |    3 +
 hw/dma/meson.build                       |    1 +
 hw/dma/rp2040_dma.c                      | 1032 +++++++++++
 hw/misc/Kconfig                          |   54 +
 hw/misc/meson.build                      |   18 +
 hw/misc/rp2040_busctrl.c                 |  208 +++
 hw/misc/rp2040_clocks.c                  |  480 +++++
 hw/misc/rp2040_iobank0.c                 |  353 ++++
 hw/misc/rp2040_ioqspi.c                  |  294 ++++
 hw/misc/rp2040_nyi.c                     |   47 +
 hw/misc/rp2040_pads.c                    |  323 ++++
 hw/misc/rp2040_pll.c                     |  234 +++
 hw/misc/rp2040_psm.c                     |  198 +++
 hw/misc/rp2040_resets.c                  |  152 ++
 hw/misc/rp2040_rosc.c                    |  430 +++++
 hw/misc/rp2040_sio.c                     |  905 ++++++++++
 hw/misc/rp2040_syscfg.c                  |  246 +++
 hw/misc/rp2040_sysinfo.c                 |  111 ++
 hw/misc/rp2040_tbman.c                   |   94 +
 hw/misc/rp2040_timer.c                   |  372 ++++
 hw/misc/rp2040_vreg.c                    |  179 ++
 hw/misc/rp2040_watchdog.c                |  361 ++++
 hw/misc/rp2040_xosc.c                    |  237 +++
 hw/misc/unimp.c                          |   13 +-
 hw/ssi/Kconfig                           |    3 +
 hw/ssi/meson.build                       |    1 +
 hw/ssi/rp2040_xip.c                      | 1465 +++++++++++++++
 hw/ssi/trace-events                      |   12 +
 include/hw/arm/rp2040.h                  |  122 ++
 include/hw/char/pl011.h                  |    8 +
 include/hw/dma/rp2040_dma.h              |   77 +
 include/hw/misc/rp2040_busctrl.h         |   29 +
 include/hw/misc/rp2040_clocks.h          |   36 +
 include/hw/misc/rp2040_iobank0.h         |   45 +
 include/hw/misc/rp2040_ioqspi.h          |   36 +
 include/hw/misc/rp2040_nyi.h             |   19 +
 include/hw/misc/rp2040_pads.h            |   42 +
 include/hw/misc/rp2040_pll.h             |   37 +
 include/hw/misc/rp2040_psm.h             |   40 +
 include/hw/misc/rp2040_resets.h          |   28 +
 include/hw/misc/rp2040_rosc.h            |   42 +
 include/hw/misc/rp2040_sio.h             |   57 +
 include/hw/misc/rp2040_syscfg.h          |   42 +
 include/hw/misc/rp2040_sysinfo.h         |   25 +
 include/hw/misc/rp2040_tbman.h           |   25 +
 include/hw/misc/rp2040_timer.h           |   39 +
 include/hw/misc/rp2040_vreg.h            |   28 +
 include/hw/misc/rp2040_watchdog.h        |   35 +
 include/hw/misc/rp2040_xosc.h            |   33 +
 include/hw/misc/unimp.h                  |    2 +
 include/hw/ssi/rp2040_xip.h              |   94 +
 scripts/uf2-to-flash.py                  |  462 +++++
 tests/functional/arm/meson.build         |    2 +
 tests/functional/arm/test_raspi_pico.py  | 1289 ++++++++++++++
 tests/qtest/meson.build                  |   12 +
 tests/qtest/rp2040-busctrl-test.c        |   92 +
 tests/qtest/rp2040-clocks-test.c         |  107 ++
 tests/qtest/rp2040-dma-test.c            |  374 ++++
 tests/qtest/rp2040-ioqspi-test.c         |   81 +
 tests/qtest/rp2040-resets-test.c         |   84 +
 tests/qtest/rp2040-rosc-test.c           |  146 ++
 tests/qtest/rp2040-sio-test.c            |  234 +++
 tests/qtest/rp2040-sysinfo-syscfg-test.c |  177 ++
 tests/qtest/rp2040-tbman-test.c          |   32 +
 tests/qtest/rp2040-vreg-test.c           |   79 +
 tests/qtest/rp2040-watchdog-test.c       |  148 ++
 tests/qtest/rp2040-xip-test.c            |  212 +++
 77 files changed, 15396 insertions(+), 10 deletions(-)
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
 create mode 100644 tests/functional/arm/test_raspi_pico.py
 create mode 100644 tests/qtest/rp2040-busctrl-test.c
 create mode 100644 tests/qtest/rp2040-clocks-test.c
 create mode 100644 tests/qtest/rp2040-dma-test.c
 create mode 100644 tests/qtest/rp2040-ioqspi-test.c
 create mode 100644 tests/qtest/rp2040-resets-test.c
 create mode 100644 tests/qtest/rp2040-rosc-test.c
 create mode 100644 tests/qtest/rp2040-sio-test.c
 create mode 100644 tests/qtest/rp2040-sysinfo-syscfg-test.c
 create mode 100644 tests/qtest/rp2040-tbman-test.c
 create mode 100644 tests/qtest/rp2040-vreg-test.c
 create mode 100644 tests/qtest/rp2040-watchdog-test.c
 create mode 100644 tests/qtest/rp2040-xip-test.c

-- 
2.53.0

