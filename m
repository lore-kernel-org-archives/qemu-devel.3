Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9F3C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthB-0001R9-Ss; Thu, 11 Jul 2024 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00016P-M8
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRtgp-00062h-14
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso6451005e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703905; x=1721308705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mAaJI9+YIrHZHiEn9RZkFf7aj+sIYU/1nFOU2CD0DEc=;
 b=bgK4jvUCPHe3kLFyaCBMTR+F49FjR+sGtYFXzSXT1zLHKeXbveHZuNjnikBi38mPeo
 xa3JPem5eFdFUwAGQf6kDLCU70nXhjNm+m5ieJTl3d8OhxT85UDXrUQFh45pRpJClvTx
 BnxF5lVK24L09sBq11s0m0KCVdnTE3zZNlGLr8oCv1qRxBCFymJGvzmNVbX8PBrgUfol
 vjeniGFdNT64TGW1LuG7+AbXyk5Sa7Hk/DhAnu11bc1J2u9ZMP27RfNueTkS/spTdaJR
 LlDPpzEDzGLb+EyIJgn83O+MsoixukFQaayuw7BYZRyIlgvYV4J/YmsSAUDyqzcT+7f1
 /gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703905; x=1721308705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mAaJI9+YIrHZHiEn9RZkFf7aj+sIYU/1nFOU2CD0DEc=;
 b=VwBDs/Yfc/Sugy4qUUZoVa9Ar5sgwhe+4yU2Z1/FnsN6NZ0gIaTLq1XqN2Jg+wbNK9
 MM5jli3hrC8kJC7q2ofg3CYI6rcY9o0SG0YlM25jQtX0lMAjd2uh/1uhdwWPS/bkJAlV
 3UqxcWquVNigrlurvAspGitQ4GqvSNXvLhUyLZ2/mon0V/i8LPKJurqFe2CrhIYxoXqs
 iR/GYzOnzF7K9yq9C+cTASUZaVqn4T4Z2xGeS6JErcUSxUyl3LnjsySpB87nIk+YAr3b
 OPwipN/QHZp/SrdVbS2+O8qD5wv7dcT7WIGIMmNh4QrWAhF05xPMawcGZ8Gj1Bf3XElh
 z1qg==
X-Gm-Message-State: AOJu0Yz57oB+OzvCJU1nZht5+zYhFwOhpVhDaSLAJTa84xnsVFikRut0
 XjjP9QHdTO2E4mnBgvXFr5hiirwUFZZ8Art0tNbZ8RtBdHb10Vbx2apcaZ3/jMrECyEC7b5S04x
 e39Y=
X-Google-Smtp-Source: AGHT+IE2i0FsE4i6wOtdMtYifkQr62iCwCfnC93QA9j2e3Jue6EdpxKMV6u98o0iYcxz9klTnU6kkg==
X-Received: by 2002:a05:600c:4655:b0:426:58ca:9ef4 with SMTP id
 5b1f17b1804b1-426708f102amr54123265e9.40.1720703904705; 
 Thu, 11 Jul 2024 06:18:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] target-arm queue
Date: Thu, 11 Jul 2024 14:17:58 +0100
Message-Id: <20240711131822.3909903-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:

  Merge tag 'pull-aspeed-20240709' of https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240711

for you to fetch changes up to 7f49089158a4db644fcbadfa90cd3d30a4868735:

  target/arm: Convert PMULL to decodetree (2024-07-11 11:41:34 +0100)

----------------------------------------------------------------
target-arm queue:
 * Refactor FPCR/FPSR handling in preparation for FEAT_AFP
 * More decodetree conversions
 * target/arm: Use cpu_env in cpu_untagged_addr
 * target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt()
 * hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()
 * hw/misc/bcm2835_thermal: Fix access size handling in bcm2835_thermal_ops
 * accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
 * STM32L4x5: Handle USART interrupts correctly

----------------------------------------------------------------
Inès Varhol (3):
      hw/misc: In STM32L4x5 EXTI, consolidate 2 constants
      hw/misc: In STM32L4x5 EXTI, handle direct interrupts
      hw/arm: In STM32L4x5 SOC, connect USART devices to EXTI

Peter Maydell (12):
      target/arm: Correct comments about M-profile FPSCR
      target/arm: Make vfp_get_fpscr() call vfp_get_{fpcr, fpsr}
      target/arm: Make vfp_set_fpscr() call vfp_set_{fpcr, fpsr}
      target/arm: Support migration when FPSR/FPCR won't fit in the FPSCR
      target/arm: Implement store_cpu_field_low32() macro
      target/arm: Store FPSR and FPCR in separate CPU state fields
      target/arm: Rename FPCR_ QC, NZCV macros to FPSR_
      target/arm: Rename FPSR_MASK and FPCR_MASK and define them symbolically
      target/arm: Allow FPCR bits that aren't in FPSCR
      target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt()
      target: Set TCGCPUOps::cpu_exec_halt to target's has_work implementation
      accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory

Richard Henderson (7):
      target/arm: Use cpu_env in cpu_untagged_addr
      target/arm: Convert SMULL, UMULL, SMLAL, UMLAL, SMLSL, UMLSL to decodetree
      target/arm: Convert SADDL, SSUBL, SABDL, SABAL, and unsigned to decodetree
      target/arm: Convert SQDMULL, SQDMLAL, SQDMLSL to decodetree
      target/arm: Convert SADDW, SSUBW, UADDW, USUBW to decodetree
      target/arm: Convert ADDHN, SUBHN, RADDHN, RSUBHN to decodetree
      target/arm: Convert PMULL to decodetree

Zheyu Ma (2):
      hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()
      hw/misc/bcm2835_thermal: Fix access size handling in bcm2835_thermal_ops

 include/hw/core/tcg-cpu-ops.h     |    9 +-
 include/hw/misc/stm32l4x5_exti.h  |    4 +-
 target/arm/cpu.h                  |  113 ++--
 target/arm/internals.h            |    3 +
 target/arm/tcg/translate-a32.h    |    7 +
 target/arm/tcg/translate.h        |    3 +-
 target/riscv/internals.h          |    3 +
 target/arm/tcg/a64.decode         |   77 +++
 accel/tcg/cpu-exec.c              |   11 +-
 hw/arm/stm32l4x5_soc.c            |   24 +-
 hw/char/pl011.c                   |   13 +-
 hw/misc/bcm2835_thermal.c         |    2 +
 hw/misc/stm32l4x5_exti.c          |   13 +-
 target/alpha/cpu.c                |    1 +
 target/arm/cpu.c                  |    2 +-
 target/arm/machine.c              |  135 ++++-
 target/arm/tcg/cpu-v7m.c          |    1 +
 target/arm/tcg/mve_helper.c       |   12 +-
 target/arm/tcg/translate-a64.c    | 1155 ++++++++++++-------------------------
 target/arm/tcg/translate-m-nocp.c |   22 +-
 target/arm/tcg/translate-vfp.c    |    4 +-
 target/arm/vfp_helper.c           |  187 +++---
 target/avr/cpu.c                  |    1 +
 target/cris/cpu.c                 |    2 +
 target/hppa/cpu.c                 |    1 +
 target/loongarch/cpu.c            |    1 +
 target/m68k/cpu.c                 |    1 +
 target/microblaze/cpu.c           |    1 +
 target/mips/cpu.c                 |    1 +
 target/openrisc/cpu.c             |    1 +
 target/ppc/cpu_init.c             |    2 +
 target/riscv/cpu.c                |    2 +-
 target/riscv/tcg/tcg-cpu.c        |    2 +
 target/rx/cpu.c                   |    1 +
 target/s390x/cpu.c                |    1 +
 target/sh4/cpu.c                  |    1 +
 target/sparc/cpu.c                |    1 +
 target/tricore/cpu.c              |    1 +
 target/xtensa/cpu.c               |    1 +
 39 files changed, 893 insertions(+), 929 deletions(-)

