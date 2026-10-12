Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D41ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJMa-0007zK-55; Mon, 12 Oct 2026 12:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMN-0007yi-1T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:58:48 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMK-0006BN-M9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:58:46 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw11xMCz80nX;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824321;
 bh=1Bo0ps4CqwtgLRYhCjF/w8rRAvaXGLn7VYfzfFfik0s=;
 h=From:To:Cc:Subject:Date:From;
 b=yoRx6cw4MKZJ8McPjnN00hBT6LpUIakmIsKz5Mb2Tb29qHnMHuBMqcWQa7O86lM6g
 rL3yZpKNJHydNq4kmmqa5SqVUk3w1wxYsUgsu8lu7B9RJXi8ZihPgnA2NTJusIGFGI
 xfTW/XDb1KqfvbtU4rP5IqG9A5/qstbPLAJfUrgZ6hDN47GwxJQRSPSTIU/vdHglVc
 ZlFQYD7ojFnAtXLpe82HaHTUbOwXaYZna61uc16LFhiVFlR8m/uATojrJQQBzBggnQ
 t/te3CINBea0iftgCY8BnYudRqEth0JKd5AMPMJmEHqMGw3TdLyPg4PV+RSlFQfwc0
 jSdtTMKGdXvIw==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw117SVz83nY;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [RFC PATCH 0/9] hw/arm: add Raspberry Pi Pico machine foundation
Date: Mon, 12 Oct 2026 18:58:30 +0200
Message-ID: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
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

This series introduces the minimal SoC and machine foundation for supporting
the Raspberry Pi Pico (RP2040) and its Arm Cortex-M0+ core. It reuses the work
originally presented in RFC by Alex Bennee in 2022 [1], but has been fully
adapted to current QEMU APIs and split into focused, reviewable pieces.

The Armv6-M MPU series [2] and the follow-up privilege extension patch [3] are
now upstream. As requested by Peter Maydell, the cortex-m0plus CPU type,
previously submitted as a standalone patch [4], is now the first patch of this
series, together with the machine that uses it. Its initialization has been
made fully autonomous, with no call to cortex_m0_initfn(), as requested in that
review.

The remaining patches build a minimal but functional RP2040 SoC and Raspberry
Pi Pico machine, sufficient to run minimal firmware (ELF loaded via -kernel)
and execute the initial boot sequence, though it does not yet emulate the
RP2040 mask ROM. They include:

cortex-m0plus CPU type - explicit architectural initialization.
Common RP2040 peripheral definitions - shared constants and helper for APB
atomic alias windows.
RP2040 SoC and Raspberry Pi Pico machine - basic skeleton with UART, flash,
RAM, and minimal interconnect.
TCG smoke tests (patch 4): basic boot test (ELF load, reset vector, UART
output). MPU validation tests (patch 5): TCG-level checks for Cortex-M0+
MPU regions. Supporting peripherals (patches 6-9): SYSINFO, SYSCFG, VREG, and
TBMAN (testbench manager).

At the end of this series, the machine can:

Boot from QEMU's -kernel with an ELF firmware;
Execute code in RAM or via a simple ROM-mapped XIP window (before full XIP/SSI
and pinmux models are added);
Output via UART0 (PL011, directly connected, before pin multiplexing is
implemented);
Validate the Cortex-M0+ MPU via TCG tests.
What remains outside this series (and will be submitted separately) is:

Clocking (clksrc, xosc, pll),
GPIO controller and SIO (including interrupt handling),
XIP controller and flash interface,
DMA engine,
ROM service stubs (e.g., rom_pio_clock, rom_flash_exit_xip).
These components are necessary to extend this minimal boot foundation into a
more complete and functionally accurate RP2040 model.

Patch statistics

 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/Kconfig                          |  12 +
 hw/arm/meson.build                      |   2 +
 hw/arm/raspi_pico.c                     |  83 +++++++
 hw/arm/rp2040.c                         | 330 +++++++++++++++++++++++++++
 hw/misc/meson.build                     |   4 +
 hw/misc/rp2040_syscfg.c                 | 220 ++++++++++++++++++
 hw/misc/rp2040_sysinfo.c                | 102 +++++++++
 hw/misc/rp2040_tbman.c                  |  88 ++++++++
 hw/misc/rp2040_vreg.c                   | 149 +++++++++++++
 include/hw/arm/rp2040.h                 |  62 ++++++
 include/hw/misc/rp2040.h                |  32 +++
 include/hw/misc/rp2040_syscfg.h         |  41 ++++
 include/hw/misc/rp2040_sysinfo.h        |  25 +++
 include/hw/misc/rp2040_tbman.h          |  29 +++
 include/hw/misc/rp2040_vreg.h           |  46 ++++
 target/arm/tcg/cpu-v7m.c                |  33 +++
 tests/qtest/meson.build                 |   5 +
 tests/qtest/rp2040-syscfg-test.c        |  97 ++++++++
 tests/qtest/rp2040-sysinfo-test.c       |  37 ++++
 tests/qtest/rp2040-tbman-test.c         |  29 +++
 tests/qtest/rp2040-vreg-test.c          |  79 +++++++
 tests/tcg/arm/system/meson.build        |  19 ++
 tests/tcg/arm/system/rp2040-boot.S      |  30 +++
 tests/tcg/arm/system/rp2040-minimal.ld  |  40 ++++
 tests/tcg/arm/system/rp2040-mpu.S       | 356 ++++++++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-mpu.ref     |  10 +
 tests/tcg/arm/system/rp2040-uart.S      |  53 +++++
 tests/tcg/arm/system/rp2040-uart.ref    |   1 +
 29 files changed, 2015 insertions(+)
[1] https://lore.kernel.org/qemu-devel/20220110175104.2908956-1-alex.bennee@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20260914192323.29250-1-gilles.grimaud@univ-lille.fr/
[3] https://lore.kernel.org/qemu-devel/20260920220722.73501-1-gilles.grimaud@univ-lille.fr/
[4] https://lore.kernel.org/qemu-devel/20260930094603.35969-1-gilles.grimaud@univ-lille.fr/


