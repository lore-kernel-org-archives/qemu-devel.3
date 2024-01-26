Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B033C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHA-0002Df-4k; Fri, 26 Jan 2024 09:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH8-0002BC-FO
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH6-0007rI-CT
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33929364bdaso414978f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279623; x=1706884423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BiBlBIvpDD1Y0teocb3BdvPikx3aYsdw5wpsTL5vxyM=;
 b=bKbFWFgECtQzNwzAl8WGnM3vlhmPlxvqdMDTzQCS7eg00sNBWDN8GmNga0BVohx1J5
 je3t54Va1HJmZmVIsZw7k1Ph3Q5CW0pvDgwwaEapKo2PIp+CsN11fDf9wYPShJDlxqY3
 EUzAjJp8quzyYWHY8HQMZGSelkzVEpnH+BUUf23/anZ4+7fq1NnGdG2RPGdDx2XWQiiS
 Y4MKA9ZhcboGxXpnqot3rkmwWM7EFDwjH3zaMEyLiFPkavC2QDRe8g8Kk0hUP9pF8dme
 dxTV2P8vE12iJoY4mT5mLWYmaTg8QV0yLKGqAG90DjGcsiCsUh6/I10mF7Cin90h7zvb
 2VcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279623; x=1706884423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BiBlBIvpDD1Y0teocb3BdvPikx3aYsdw5wpsTL5vxyM=;
 b=sfJnCEeNtpR9kN868g8VXEE+6FvKaaDMoK0S/gBZDDkRT/SQpAWtX6vteMejFAoi+y
 nhVQ9ggSbOHB1Fuqx4IMLOUjYIxx4MuVwH5E5c9tqeIb1rCxOvqsUphJazBn9dr68Bod
 KTkTLgOOszY8Uw4hzFTtUNSF+hTEQYgNb/ZxPuYgaq4/XTEur8Mm2ONcgy7WK4UG81Uc
 Uqaee1AgqX8r4M5a+xC+xVuSUsjP/TzCHe05/2aAIiw38EFIxA8hiXW3cBlVs8H4bKHT
 N7DPeUho9D1MXlq0Bu9bpbD21DhcjVsDpwjKl4TPoVwuNEYH/atrr8mY/A0E2Nr9ykvZ
 2NnQ==
X-Gm-Message-State: AOJu0Yx+LAWDZ9cmiXs3/gvh8P8brWxrc9ASLKYaVcKoNv1X5e4uYe5u
 3e9f2O0xfUu/AOs/mboWjrjeyJZFfASGX3OpE5LI1OEFsB5vw/wuTx6PftWfGOIhAIMMAzUfMUm
 8
X-Google-Smtp-Source: AGHT+IHyeMoCd7mkAA20btRiQHTcvweRO+zMtZDmhcoqzJ0HwKrhhA7XN1BdmX8Xl4X1qzXmWwBSSg==
X-Received: by 2002:adf:fd84:0:b0:337:bf42:b1f8 with SMTP id
 d4-20020adffd84000000b00337bf42b1f8mr1113172wrr.137.1706279622579; 
 Fri, 26 Jan 2024 06:33:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Fri, 26 Jan 2024 14:33:05 +0000
Message-Id: <20240126143341.2101237-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:

  Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240126

for you to fetch changes up to 5e6be95ed1578c7cfac2082b39384d99fd912508:

  hw/arm: add PCIe to Freescale i.MX6 (2024-01-26 12:23:04 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix VNCR fault detection logic
 * Fix A64 scalar SQSHRN and SQRSHRN
 * Fix incorrect aa64_tidcp1 feature check
 * hw/arm/virt.c: Remove newline from error_report() string
 * hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
 * hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
 * hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller
 * hw/arm: Add EHCI/OHCI controllers to Allwinner R40 and Bananapi board
 * hw/arm: Add AHCI/SATA controller to Allwinner R40 and Bananapi board
 * hw/arm: Add watchdog timer to Allwinner H40 and Bananapi board
 * arm: various include header cleanups
 * cleanups to allow some files to be built only once
 * fsl-imx6ul: Add various missing unimplemented devices
 * docs/system/arm/virt.rst: Add note on CPU features off by default
 * hw/char/imx_serial: Implement receive FIFO and ageing timer
 * target/xtensa: fix OOB TLB entry access
 * bswap.h: Fix const_le64() macro
 * hw/arm: add PCIe to Freescale i.MX6

----------------------------------------------------------------
Guenter Roeck (4):
      hw/arm: Add EHCI/OHCI controllers to Allwinner R40 and Bananapi board
      hw/arm: Add AHCI/SATA controller to Allwinner R40 and Bananapi board
      hw/arm: Add watchdog timer to Allwinner H40 and Bananapi board
      fsl-imx6ul: Add various missing unimplemented devices

Gustavo Romero (1):
      docs/system/arm/virt.rst: Add note on CPU features off by default

Max Filippov (1):
      target/xtensa: fix OOB TLB entry access

Nikita Ostrenkov (1):
      hw/arm: add PCIe to Freescale i.MX6

Peter Maydell (6):
      target/arm: Fix VNCR fault detection logic
      hw/arm/virt.c: Remove newline from error_report() string
      hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
      target/arm: Fix A64 scalar SQSHRN and SQRSHRN
      bswap.h: Fix const_le64() macro
      target/arm: Fix incorrect aa64_tidcp1 feature check

Philippe Mathieu-Daudé (20):
      hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
      hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller
      hw/arm/exynos4210: Include missing 'exec/tswap.h' header
      hw/arm/xilinx_zynq: Include missing 'exec/tswap.h' header
      hw/arm/smmuv3: Include missing 'hw/registerfields.h' header
      hw/arm/xlnx-versal: Include missing 'cpu.h' header
      target/arm/cpu-features: Include missing 'hw/registerfields.h' header
      target/arm/cpregs: Include missing 'hw/registerfields.h' header
      target/arm/cpregs: Include missing 'kvm-consts.h' header
      target/arm: Expose arm_cpu_mp_affinity() in 'multiprocessing.h' header
      target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'
      hw/cpu/a9mpcore: Build it only once
      hw/misc/xlnx-versal-crl: Include generic 'cpu-qom.h' instead of 'cpu.h'
      hw/misc/xlnx-versal-crl: Build it only once
      target/arm: Expose M-profile register bank index definitions
      hw/arm/armv7m: Make 'hw/intc/armv7m_nvic.h' a target agnostic header
      target/arm: Move ARM_CPU_IRQ/FIQ definitions to 'cpu-qom.h' header
      target/arm: Move e2h_access() helper around
      target/arm: Move GTimer definitions to new 'gtimer.h' header
      hw/arm: Build various units only once

Rayhan Faizel (1):
      hw/char/imx_serial: Implement receive FIFO and ageing timer

Richard Henderson (2):
      target/arm: Rename arm_cpu_mp_affinity
      target/arm: Create arm_cpu_mp_affinity

 docs/system/arm/bananapi_m2u.rst  |   5 +-
 docs/system/arm/virt.rst          |  13 ++++
 hw/arm/smmuv3-internal.h          |   1 +
 include/hw/arm/allwinner-r40.h    |  15 +++++
 include/hw/arm/fsl-imx6.h         |  44 +++++++------
 include/hw/arm/fsl-imx6ul.h       |   2 +
 include/hw/arm/xlnx-versal.h      |   1 +
 include/hw/char/imx_serial.h      |  20 +++++-
 include/hw/intc/armv7m_nvic.h     |   2 +-
 include/hw/misc/xlnx-versal-crl.h |   2 +-
 include/qemu/bswap.h              |  16 ++---
 target/arm/cpregs.h               |   3 +
 target/arm/cpu-features.h         |   4 +-
 target/arm/cpu-qom.h              |  24 +++++++
 target/arm/cpu.h                  |  34 +---------
 target/arm/gtimer.h               |  21 ++++++
 target/arm/multiprocessing.h      |  16 +++++
 hw/arm/allwinner-a10.c            |  50 ++++++--------
 hw/arm/allwinner-h3.c             |   2 +
 hw/arm/allwinner-r40.c            |  69 +++++++++++++++++++-
 hw/arm/armv7m.c                   |   2 +
 hw/arm/aspeed_ast2400.c           |   1 +
 hw/arm/aspeed_ast2600.c           |   1 +
 hw/arm/bcm2836.c                  |   2 +
 hw/arm/collie.c                   |   1 -
 hw/arm/exynos4210.c               |   2 +
 hw/arm/fsl-imx25.c                |   1 +
 hw/arm/fsl-imx31.c                |   1 +
 hw/arm/fsl-imx6.c                 |  26 ++++++++
 hw/arm/fsl-imx6ul.c               |  31 +++++++++
 hw/arm/fsl-imx7.c                 |   1 +
 hw/arm/gumstix.c                  |   1 -
 hw/arm/highbank.c                 |   1 +
 hw/arm/integratorcp.c             |   2 +-
 hw/arm/mainstone.c                |   1 -
 hw/arm/musicpal.c                 | 133 ++++++++++++++++++--------------------
 hw/arm/npcm7xx.c                  |   3 +-
 hw/arm/nseries.c                  |   4 +-
 hw/arm/omap1.c                    |   1 +
 hw/arm/omap2.c                    |   2 +-
 hw/arm/omap_sx1.c                 |   1 -
 hw/arm/palm.c                     |   1 -
 hw/arm/realview.c                 |   1 +
 hw/arm/sbsa-ref.c                 |   4 +-
 hw/arm/spitz.c                    |   1 -
 hw/arm/strongarm.c                |   2 +-
 hw/arm/versatilepb.c              |   2 +-
 hw/arm/vexpress.c                 |   2 +-
 hw/arm/virt-acpi-build.c          |   4 +-
 hw/arm/virt.c                     |  15 +++--
 hw/arm/xilinx_zynq.c              |   3 +-
 hw/arm/xlnx-versal-virt.c         |   5 +-
 hw/arm/xlnx-versal.c              |   2 +
 hw/arm/xlnx-zynqmp.c              |   2 +
 hw/arm/z2.c                       |   1 -
 hw/char/imx_serial.c              | 102 +++++++++++++++++++++++++----
 hw/cpu/a15mpcore.c                |   1 +
 hw/cpu/a9mpcore.c                 |   2 +-
 hw/misc/xlnx-versal-crl.c         |   5 +-
 target/arm/arm-powerctl.c         |   3 +-
 target/arm/cpu.c                  |  13 +++-
 target/arm/helper.c               |  30 +++++----
 target/arm/hvf/hvf.c              |   6 +-
 target/arm/kvm.c                  |   1 +
 target/arm/machine.c              |   1 +
 target/arm/tcg/psci.c             |   3 +-
 target/arm/tcg/tlb_helper.c       |   2 +-
 target/arm/tcg/translate-a64.c    |   2 +-
 target/xtensa/mmu_helper.c        |  47 ++++++++++----
 hw/arm/Kconfig                    |   6 ++
 hw/arm/meson.build                |  23 +++----
 hw/cpu/meson.build                |   2 +-
 hw/misc/meson.build               |   2 +-
 73 files changed, 597 insertions(+), 261 deletions(-)
 create mode 100644 target/arm/gtimer.h
 create mode 100644 target/arm/multiprocessing.h

