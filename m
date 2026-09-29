Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5464FCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUef-0006x3-Ly; Tue, 29 Sep 2026 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeZ-0006w1-P9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeX-00087P-Hd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-488885c3844so434849f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676096; x=1791280896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o52pPMvL0P5jXna2vDHMoo4a3EDppPJn1Fs/mpMq5Ao=;
 b=tMU8BQD+o4jEGk8kzTTclfOrxh2m34XWJ99ebe52a5kb9hOCndxEaRqdzV+KgC9+9x
 mPcFd46sggrvYFv4vH5oPD4yMxCbN11X647D0sXMFNtvG4BRfP3M2+gS+a0gTCB3LEhQ
 Yr4Dfqirwr8aATUCNUPm7fNUIsi9/Rn+R9ceuHTV0NUKx8I1iEfWzCeXJco1plEfZxGq
 fIzZ3qvg0eFmix45aNvHb9h+TMT4ym1D/fWzjyycz9OcPHQSdljqzxbOW9kC3RfsFmBv
 CicsMOnajMrs/fe2FUaBZvVoKHzHbnXSqlkhEADuNWKjYDrDMoByIO0L2o2yUF2KzC7Z
 6nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676096; x=1791280896;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o52pPMvL0P5jXna2vDHMoo4a3EDppPJn1Fs/mpMq5Ao=;
 b=eJDewI9sRevXWuHAX+fH2rNOtapJwGpZwc6C6tc53szIedBTVmshRaiN0V0+3iFxU9
 mRyCV7YkD3JqlavJeyEXteta5oKX8TynSL6+1C3lh8UrJvNsmHjXe0NAQhgn7uDx30Ep
 DHUROHIs5e40QI+vU0LakbajqQ7nxQerIn991q0vbOTxzk7RUsxitXRFU+7FQxO3AfEh
 f1ug2YFECpUptqSWonoz8ed8EAhJE91X9FBc36a4GDtUZEWAm+NhXwU6kIfBUDeO4AtS
 MrHWrr5Z7auq1QoXOHNU0YVD+RWTSEyc0/PzK4mOlMyQDYmNALupHQupvupdfkNJUosX
 e25w==
X-Gm-Message-State: AFq9FYK3WA2f4oLmsrI1hSk+GSpKrFKX5uCeDDUH+ZNLBgscqbFtp8QL
 O8pKFEKuiT82zTP2N67rviMm6Ry83CU6Rny+MmaUaWh6ZRsQ7O+sJSXuX7cehZaCQt1Cvj9jbaQ
 72CLq
X-Gm-Gg: AYBFou1Y7xCEd+CkJoiYNa+G7LNlnbtHfyjViuVX11+JOJ7uKtrhLU8jE4PcxV0RlA/
 QkWVY8xQh2zNLJ/57qS+yeEx5eRjT/7c0ILz1warkjpId2CJ4bZSCXbyThHp9NWgkUv3z9vMS21
 YbOofypkNr7giYrSt+hLVTd+sr/6DtKv1BfpU+tgPL0WCG1Ui1O32py/g5cuPTXNl+ib7xBUYSP
 cwyL0eC+PFsrOEG6zYCPA4sg7SaJL0UpdX1vQx0Y3Okc8JUgbMUfdlQSWBx8p1aj+irXHdk0zXI
 KT82RYRKnLxvOhjOlUSdDzF7w70clI81oT3NPkpdiZvmk7EBGL68hGBJleSbbyE1d8ktkIKaHhO
 5PKCrTvj8g+AqXBzjpwH7txQDMNIXXID9u/rKj3S1kNEH39XHBZoALgGNcxoH1dLQKs0HgUQeBT
 wFTeqlnlLRYgPv4VAJO+HXElVmkd/DD0rYfr4+K8hbJlSm7yNylAqzVLme3RthJ5MFpu/HhyJM2
 GrY0emiCgpsvA3uDdQv136Lxp8ObawG/1j+C6yz1aJmsOs8SPmkWS/geLB1ZgIDnUTazh9O2ZVl
 eJA=
X-Received: by 2002:a05:6000:1789:b0:488:8111:6f50 with SMTP id
 ffacd0b85a97d-48af1b851cemr3561638f8f.20.1790676095625; 
 Tue, 29 Sep 2026 03:01:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] target-arm queue
Date: Tue, 29 Sep 2026 11:00:55 +0100
Message-ID: <20260929100133.2598676-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Hi; here's a target-arm queue: FEAT_UINJ is the biggest thing here,
otherwise largely bugfixes of various kinds.

thanks
-- PMM

The following changes since commit 81ce3a87737aa50716c42db8886082d12783e0a1:

  Merge tag 'hw-misc-20260927' of https://github.com/philmd/qemu into staging (2026-09-27 02:02:29 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260929

for you to fetch changes up to 998b6db69e3ec58fd52ddc7a06ece6cf286f3c77:

  target/arm: Fix WFxT timeouts when the offset puts the count ahead (2026-09-29 10:58:40 +0100)

----------------------------------------------------------------
target-arm queue:
 * whpx: arm64: check for physical address width after WHPX availability
 * hw/char/stm32l4x5_usart.c: Support 16-bit writes
 * hw/arm: Add GPIO to Allwinner A10 model
 * hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
 * hw/char/exynos4210_uart: fix fifo overflow
 * arm: handle CCSIDR_EL1 as a demuxed register
 * target/arm: model Cortex-M0+ privilege extension
 * target/arm: Fix migration of Aarch32 Secure banked registers
 * target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions
 * target/arm: Enable FEAT_UINJ for -cpu max-v9
 * target/arm: Fix timer tick and WFxT timeouts when the offset puts the count ahead

----------------------------------------------------------------
Cornelia Huck (3):
      arm: handle demuxed ID registers
      arm: handle CCSIDR_EL1 as a demuxed register
      arm/kvm: get demuxed ID registers from kvm

Fuad Tabba (2):
      target/arm: Fix next timer tick when the offset puts the count ahead
      target/arm: Fix WFxT timeouts when the offset puts the count ahead

Gilles Grimaud (1):
      target/arm: model Cortex-M0+ privilege extension

Jacob Whitaker Abrams (1):
      hw/char/stm32l4x5_usart.c: Support 16-bit writes

Jean-Francois Bortolotti (1):
      target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions

Matthew R. Ochs (1):
      hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive

Mohamed Mediouni (1):
      whpx: arm64: check for physical address width after WHPX availability

Peter Maydell (8):
      target/arm: Keep the S/NS bit in migration data
      target/arm: Don't assume secure-banked registers are migrated by 64-bit regs
      target/arm: Drop uses of reset_ignore for banked AArch32 registers
      target/arm: Don't use arm_cp_reset_ignore when fieldoffset is 0
      target/arm: Move ESR_EL1 definition to vmsa_pmsa_cp_reginfo
      target/arm: Don't set ARM_FEATURE_VAPA for v7 PMSA
      target/arm: Don't register 64-bit TTBR0, TTBR1 for PMSA
      target/arm: Add a debug check that all sysregs are migrated

Richard Henderson (14):
      target/arm: Parenthesize tbflags arguments in TBFLAG macros
      target/arm: Reorg rebuild_hflags_common*
      target/arm: Split out rebuild_hflags_common_aprofile
      target/arm: Sort BE_DATA toward the top of rebuild_hflags_a64
      target/arm: Move ID_AA64PFR2 feature tests together
      target/arm: Add isar_feature_aa64_uinj
      target/arm: Drop U from most PSTATE bits
      target/arm: Clear PSTATE.UINJ when taking exceptions
      target/arm: Widen cpsr_{read, write}_for_spsr_elx to uint64_t
      target/arm: Read and write PSTATE.UINJ
      target/arm: Add PSTATE.UINJ to tbflags
      target/arm: Split out check_il
      target/arm: Honor PSTATE.UINJ during translation
      target/arm: Enable FEAT_UINJ for -cpu max-v9

Strahinja Jankovic (3):
      hw/gpio: Allwinner A10 GPIO emulation
      hw/arm: Add GPIO to Allwinner A10 model
      tests/qtest: Allwinner GPIO tests

jprx (2):
      hw/char/exynos4210_uart: fix fifo overflow
      tests/qtest: add test for exynos4210 uart fifo overflow bug

 MAINTAINERS                                |   3 +
 docs/system/arm/cubieboard.rst             |   1 +
 docs/system/arm/emulation.rst              |   1 +
 hw/arm/Kconfig                             |   1 +
 hw/arm/allwinner-a10.c                     |   8 +
 hw/arm/tegra241-cmdqv.c                    |  54 +--
 hw/arm/tegra241-cmdqv.h                    |   2 +-
 hw/arm/virt.c                              |  19 +-
 hw/char/exynos4210_uart.c                  | 111 ++----
 hw/char/stm32l4x5_usart.c                  |   7 +-
 hw/gpio/Kconfig                            |   3 +
 hw/gpio/allwinner-gpio.c                   | 441 ++++++++++++++++++++++++
 hw/gpio/meson.build                        |   1 +
 hw/gpio/trace-events                       |   6 +
 hw/intc/armv7m_nvic.c                      |   2 +-
 include/hw/arm/allwinner-a10.h             |   2 +
 include/hw/gpio/allwinner-gpio-regs.h      | 227 ++++++++++++
 include/hw/gpio/allwinner-gpio.h           |  41 +++
 target/arm/cpregs.h                        |  21 +-
 target/arm/cpu-features.h                  |  26 +-
 target/arm/cpu-max.c                       |   6 +-
 target/arm/cpu-sysregs.h                   |   9 +
 target/arm/cpu-sysregs.h.inc               |   1 +
 target/arm/cpu.c                           |  10 +-
 target/arm/cpu.h                           |  97 ++++--
 target/arm/cpu64.c                         |  14 +-
 target/arm/helper.c                        | 237 ++++++++++---
 target/arm/internals.h                     |   7 +-
 target/arm/kvm.c                           |  43 +++
 target/arm/machine.c                       |  80 +++++
 target/arm/ptw.c                           |   2 +-
 target/arm/tcg/cpu32.c                     |  26 +-
 target/arm/tcg/cpu64.c                     |  69 ++--
 target/arm/tcg/helper-a64.c                |   2 +
 target/arm/tcg/hflags.c                    | 118 +++----
 target/arm/tcg/m_helper.c                  |   2 +-
 target/arm/tcg/op_helper.c                 |   6 +-
 target/arm/tcg/translate-a64.c             |   8 +-
 target/arm/tcg/translate.c                 |  33 +-
 target/arm/tcg/translate.h                 |   3 +
 target/arm/whpx/whpx-all.c                 |  16 +-
 tests/qtest/allwinner-gpio-test.c          | 535 +++++++++++++++++++++++++++++
 tests/qtest/exynos4210_uart_fifo-test.c    |  86 +++++
 tests/qtest/meson.build                    |   7 +-
 tests/qtest/stm32l4x5_usart-test.c         |  22 +-
 tests/tcg/aarch64/system/meson.build       |   7 +
 tests/tcg/aarch64/system/vtimer.c          |  28 ++
 tests/tcg/aarch64/system/wfxt.c            | 118 +++++++
 tests/tcg/arm/system/meson.build           |   6 +
 tests/tcg/arm/system/test-armv6m-control.S |  66 ++++
 50 files changed, 2278 insertions(+), 363 deletions(-)
 create mode 100644 hw/gpio/allwinner-gpio.c
 create mode 100644 include/hw/gpio/allwinner-gpio-regs.h
 create mode 100644 include/hw/gpio/allwinner-gpio.h
 create mode 100644 tests/qtest/allwinner-gpio-test.c
 create mode 100644 tests/qtest/exynos4210_uart_fifo-test.c
 create mode 100644 tests/tcg/aarch64/system/wfxt.c
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S

