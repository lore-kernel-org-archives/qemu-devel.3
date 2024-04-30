Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428C6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfO-0002ip-Te; Tue, 30 Apr 2024 12:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf3-0002OY-3f
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005bh-I4
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:56 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso26015251fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495724; x=1715100524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1cnPV+Wq42Hf32q5B4foOnOLF+38Zr3z4Nw9DS8dGRk=;
 b=GSYxeLrntY7tcEj/36weLkm8CKgUm580NSfslBX4hhnuOzYUPfnTgHnKShpdEGmDJX
 sCFPQRvQcvYL4d9kr6RiuM5aXuJ+m08Cr1wEkYvUfWwgXVne28tC+zQ8XTQNdl5nL96z
 8B3v568Zdn9Io64j9x/KlVCWJf4fro9XiYZmF1VvPNOc9lxLPN+HHSVu5Ntovh2N2qv8
 fSlNbN4ijdOPLkVpR/aFmXYsujGbZA94b3O5dcvtuG3Y6bfbwMmaka5uEdIq/Z7EWaw0
 NoUIQOYRfX+8/Fhii4cMLtL0RW/WYOXiv9BKKDKSQL3qFrxqg1XlWeRA7kAZ2S8SDezn
 nxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495724; x=1715100524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cnPV+Wq42Hf32q5B4foOnOLF+38Zr3z4Nw9DS8dGRk=;
 b=TmPIHKXFRwJ3Q/qs6vOodKPmR+U0d72mtaY0itILvegvIlwnwZ5YrU9DSWeq7/N31a
 edFvTvjVB2lctnumQQvm+3aE96tADgEAm6EcR7tS2PdqF9j0z76Y5tbmLVPaPPwn1SiK
 s78B63pKX/59D6odm1AtdLAj2CXII8yYcyhRCLjTdpDHHtRsdmyevJQzMHErMq/E1ryn
 3Fgd5Mz960uTrRbsEyXjbZBo3MU352lb61NTP2FAg/74dzxvMcdPaihtNLns2vTVIWjl
 m0lQvv6ZLj38zxpqwVaV0I9WW1sIfKndNOfJ+0aourOQMbqSoklaV8UAXZjSJ1YgvFo9
 /skw==
X-Gm-Message-State: AOJu0YwqtJiv03y+54Tazm/cW9J3EyOAhy7inJlEg0U4Jl2x5zTDo6eC
 LW4rCh/vvSUtUHsdrlXA27Hw9N1HrYzKOEoJJrcZki05YLdst+ZEh0ZZF/H84qo0g6DtmtIzQrP
 w
X-Google-Smtp-Source: AGHT+IHm1vSADwSGMYX1/NvtuOHOV74m9v0ricGHE7KzBmEq03UKgvRD26ui4RfhrCJxLmS6tjr0rQ==
X-Received: by 2002:a05:651c:1079:b0:2e0:1414:5eb3 with SMTP id
 y25-20020a05651c107900b002e014145eb3mr115387ljm.38.1714495724268; 
 Tue, 30 Apr 2024 09:48:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target-arm queue
Date: Tue, 30 Apr 2024 17:48:21 +0100
Message-Id: <20240430164842.4074734-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Here's another arm pullreq; nothing too exciting in here I think.

thanks
-- PMM

The following changes since commit 5fee33d97a7f2e95716417bd164f2f5264acd976:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2024-04-29 14:34:25 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240430

for you to fetch changes up to a0c325c4b05cf7815739d6a84e567b95c8c5be7e:

  tests/qtest : Add testcase for DM163 (2024-04-30 16:05:08 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/core/clock: allow clock_propagate on child clocks
 * hvf: arm: Remove unused PL1_WRITE_MASK define
 * target/arm: Restrict translation disabled alignment check to VMSA
 * docs/system/arm/emulation.rst: Add missing implemented features
 * target/arm: Enable FEAT_CSV2_3, FEAT_ETS2, FEAT_Spec_FPACC for 'max'
 * tests/avocado: update sunxi kernel from armbian to 6.6.16
 * target/arm: Make new CPUs default to 1GHz generic timer
 * hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
 * hw/char/stm32l4x5_usart: Fix memory corruption by adding correct class_size
 * hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
 * hw/arm: Add DM163 display to B-L475E-IOT01A board

----------------------------------------------------------------
Alexandra Diupina (1):
      hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields

Inès Varhol (5):
      hw/display : Add device DM163
      hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5 SoC
      hw/arm : Create Bl475eMachineState
      hw/arm : Connect DM163 to B-L475E-IOT01A
      tests/qtest : Add testcase for DM163

Peter Maydell (10):
      docs/system/arm/emulation.rst: Add missing implemented features
      target/arm: Enable FEAT_CSV2_3 for -cpu max
      target/arm: Enable FEAT_ETS2 for -cpu max
      target/arm: Implement ID_AA64MMFR3_EL1
      target/arm: Enable FEAT_Spec_FPACC for -cpu max
      tests/avocado: update sunxi kernel from armbian to 6.6.16
      target/arm: Refactor default generic timer frequency handling
      hw/arm/sbsa-ref: Force CPU generic timer to 62.5MHz
      hw/watchdog/sbsa_gwdt: Make watchdog timer frequency a QOM property
      target/arm: Default to 1GHz cntfrq for 'max' and new CPUs

Philippe Mathieu-Daudé (1):
      hw/arm/npcm7xx: Store derivative OTP fuse key in little endian

Raphael Poggi (1):
      hw/core/clock: allow clock_propagate on child clocks

Richard Henderson (1):
      target/arm: Restrict translation disabled alignment check to VMSA

Thomas Huth (1):
      hw/char/stm32l4x5_usart: Fix memory corruption by adding correct class_size

Zenghui Yu (1):
      hvf: arm: Remove PL1_WRITE_MASK

 docs/system/arm/b-l475e-iot01a.rst  |   3 +-
 docs/system/arm/emulation.rst       |  42 ++++-
 include/hw/display/dm163.h          |  59 ++++++
 include/hw/watchdog/sbsa_gwdt.h     |   3 +-
 target/arm/cpu.h                    |  28 +++
 target/arm/internals.h              |  15 +-
 hw/arm/b-l475e-iot01a.c             | 105 +++++++++--
 hw/arm/npcm7xx.c                    |   3 +-
 hw/arm/sbsa-ref.c                   |  16 ++
 hw/arm/stm32l4x5_soc.c              |   6 +-
 hw/char/stm32l4x5_usart.c           |   1 +
 hw/core/clock.c                     |   1 -
 hw/core/machine.c                   |   4 +-
 hw/display/dm163.c                  | 349 ++++++++++++++++++++++++++++++++++++
 hw/dma/xlnx_dpdma.c                 |  20 +--
 hw/watchdog/sbsa_gwdt.c             |  15 +-
 target/arm/cpu.c                    |  42 +++--
 target/arm/cpu64.c                  |   2 +
 target/arm/helper.c                 |  22 +--
 target/arm/hvf/hvf.c                |   3 +-
 target/arm/kvm.c                    |   2 +
 target/arm/tcg/cpu32.c              |   6 +-
 target/arm/tcg/cpu64.c              |  28 ++-
 target/arm/tcg/hflags.c             |  12 +-
 tests/qtest/dm163-test.c            | 194 ++++++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   |  13 +-
 tests/qtest/stm32l4x5_syscfg-test.c |  17 +-
 hw/arm/Kconfig                      |   1 +
 hw/display/Kconfig                  |   3 +
 hw/display/meson.build              |   1 +
 hw/display/trace-events             |  14 ++
 tests/avocado/boot_linux_console.py |  70 ++++----
 tests/avocado/replay_kernel.py      |   8 +-
 tests/qtest/meson.build             |   2 +
 34 files changed, 987 insertions(+), 123 deletions(-)
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 hw/display/dm163.c
 create mode 100644 tests/qtest/dm163-test.c

