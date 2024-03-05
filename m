Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258F7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEF-000112-OZ; Tue, 05 Mar 2024 08:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDq-0000vB-Nw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDk-0005x2-S9
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d18931a94so3336384f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646759; x=1710251559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QOjLeOAAcgGIM32VXbE9CqkwcOez577c3TaR1Ypc5KY=;
 b=jOGkidvSdDTUMzVqjb+ndVsHSdXc0CeW06o8eTfRx0Hjx4+qgUh6TCho15p995PtmY
 M8eHQ4lsYgM5M3Pj8ciSToHGp3cfuhkReoY3UB9Pc8vJna/Gtvsvytzq/CDejS8zQXZD
 c4NJHG3VZRl8lEzadyEwq08YYZ30WENHButdOU0X1D6VSyObLUeucnqxnT+nzntLYMwo
 Kr+wgJLBEqqzi1vAUQqfv65Hcz7Jw46ZOSWi7gj1/MZdK2XDEHnr/xWfdvuzij+Elc0B
 PU7bs5NCJdHhHUBpo4ZT5NvrVkPGoUSSozJzAvjJSUeyaVePhzQm587mYuxO/q7tDi24
 TDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646759; x=1710251559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOjLeOAAcgGIM32VXbE9CqkwcOez577c3TaR1Ypc5KY=;
 b=iGJCbBQ0OldTSfx+UaMqkocLTkU+w9fCAdPjWBs8WtIvS6XZIB0IpoBGQPTseb7mlT
 RHDmUf8Vk83vIDwnCUL/ITI8qio9bwrcRVLEvT7z8XzlNRXc1xgVOxspRsALs4oMoIB6
 bSWqF2B+dlyVXWzgg6H9oORvgdOPsiIVX6x2SjqU6VWmrbd4cI1bI3E1wBpDjzXIUSGN
 4RBGt5Jdo44JdT3kWfZZ1EId9Ye5nRZkbD2Dgi5jtPJx9KgIlZyVWOA4xXVY4Hg8cHtv
 EkFsc5ipQMHdjpjMc7vjW0FnK7fs6b0FRbbv70ikts5UGNnyysrp759ihOgJTXWQXMpw
 LCYQ==
X-Gm-Message-State: AOJu0Ywqtwjin8GqWj+jn/bavAo2E93gb0/OeFOo4BisY/H4kc2g9N3Z
 WfasEIhEpskp/17EwweZiFeGe7qa0H+iNgfDWX74a1c7y0psHQaqRwvYcztPjWsRyqPjp53KTEz
 p
X-Google-Smtp-Source: AGHT+IHPTuUoF/TSOma8nAeTBQ0PCLxOLLMvjcbrTKtiaa0S3Jv8vJhUZLxo8eepn8AeQLVFfbzMTg==
X-Received: by 2002:adf:ed0c:0:b0:33d:fec5:2fac with SMTP id
 a12-20020adfed0c000000b0033dfec52facmr8500570wro.9.1709646758851; 
 Tue, 05 Mar 2024 05:52:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Tue,  5 Mar 2024 13:52:17 +0000
Message-Id: <20240305135237.3111642-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 4eac9dfbd72d346505642fb45ac3141c7eb2c516:

  Merge tag 'pull-tcg-20240301' of https://gitlab.com/rth7680/qemu into staging (2024-03-05 09:45:22 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240305

for you to fetch changes up to 7558300c53057126514ee0fd5cf629c65ccc20e1:

  qemu-options.hx: Don't claim "-serial" has limit of 4 serial ports (2024-03-05 13:22:56 +0000)

----------------------------------------------------------------
target-arm queue:
 * raspi: Implement Broadcom Serial Controller (BSC) for BCM2835 boards
 * hw/char/pl011: Add support for loopback
 * STM32L4x5: Implement RCC clock control device
 * target/arm: Do memory type alignment checks
 * atomic.h: Reword confusing comment for qatomic_cmpxchg
 * qemu-options.hx: Don't claim "-serial" has limit of 4 serial ports

----------------------------------------------------------------
Arnaud Minier (8):
      hw/misc/stm32l4x5_rcc: Implement STM32L4x5_RCC skeleton
      hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object
      hw/misc/stm32l4x5_rcc: Add an internal PLL Clock object
      hw/misc/stm32l4x5_rcc: Initialize PLLs and clock multiplexers
      hw/misc/stm32l4x5_rcc: Handle Register Updates
      hw/misc/stm32l4x5_rcc: Add write protections to CR register
      hw/arm/stm32l4x5_soc.c: Use the RCC Sysclk
      tests/qtest/stm32l4x5_rcc-test.c: Add tests for the STM32L4x5_RCC

Peter Maydell (1):
      atomic.h: Reword confusing comment for qatomic_cmpxchg

Rayhan Faizel (3):
      hw/i2c: Implement Broadcom Serial Controller (BSC)
      hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
      tests/qtest: Add testcase for BCM2835 BSC

Richard Henderson (6):
      target/arm: Support 32-byte alignment in pow2_align
      exec/memattrs: Remove target_tlb_bit*
      accel/tcg: Add tlb_fill_flags to CPUTLBEntryFull
      accel/tcg: Add TLB_CHECK_ALIGNED
      target/arm: Do memory type alignment check when translation disabled
      target/arm: Do memory type alignment check when translation enabled

Steven Shen (1):
      qemu-options.hx: Don't claim "-serial" has limit of 4 serial ports

Tong Ho (1):
      hw/char/pl011: Add support for loopback

 MAINTAINERS                               |    5 +-
 docs/system/arm/b-l475e-iot01a.rst        |    2 +-
 docs/system/arm/raspi.rst                 |    1 +
 include/exec/cpu-all.h                    |    4 +-
 include/exec/memattrs.h                   |   12 -
 include/hw/arm/bcm2835_peripherals.h      |    4 +-
 include/hw/arm/stm32l4x5_soc.h            |    5 +-
 include/hw/core/cpu.h                     |    3 +
 include/hw/i2c/bcm2835_i2c.h              |   80 ++
 include/hw/misc/stm32l4x5_rcc.h           |  239 +++++
 include/hw/misc/stm32l4x5_rcc_internals.h | 1042 +++++++++++++++++++++
 include/qemu/atomic.h                     |    2 +-
 accel/tcg/cputlb.c                        |   35 +-
 hw/arm/b-l475e-iot01a.c                   |   10 +-
 hw/arm/bcm2835_peripherals.c              |   45 +-
 hw/arm/stm32l4x5_soc.c                    |   45 +-
 hw/char/pl011.c                           |  110 ++-
 hw/i2c/bcm2835_i2c.c                      |  282 ++++++
 hw/misc/stm32l4x5_rcc.c                   | 1457 +++++++++++++++++++++++++++++
 target/arm/ptw.c                          |   39 +
 target/arm/tcg/hflags.c                   |   34 +-
 target/arm/tcg/translate.c                |    8 +-
 target/sparc/mmu_helper.c                 |    2 +-
 tests/qtest/bcm2835-i2c-test.c            |  115 +++
 tests/qtest/stm32l4x5_rcc-test.c          |  189 ++++
 hw/arm/Kconfig                            |    2 +
 hw/i2c/Kconfig                            |    4 +
 hw/i2c/meson.build                        |    1 +
 hw/misc/Kconfig                           |    3 +
 hw/misc/meson.build                       |    1 +
 hw/misc/trace-events                      |   14 +
 qemu-options.hx                           |    2 +-
 tests/qtest/meson.build                   |    5 +-
 33 files changed, 3718 insertions(+), 84 deletions(-)
 create mode 100644 include/hw/i2c/bcm2835_i2c.h
 create mode 100644 include/hw/misc/stm32l4x5_rcc.h
 create mode 100644 include/hw/misc/stm32l4x5_rcc_internals.h
 create mode 100644 hw/i2c/bcm2835_i2c.c
 create mode 100644 hw/misc/stm32l4x5_rcc.c
 create mode 100644 tests/qtest/bcm2835-i2c-test.c
 create mode 100644 tests/qtest/stm32l4x5_rcc-test.c

