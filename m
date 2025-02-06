Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCB4C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6Z-0005ZA-Bq; Thu, 06 Feb 2025 17:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tzOlZwgKCvYusfYmrqfemmejc.amkocks-bctcjlmlels.mpe@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6W-0005X5-CK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:12 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tzOlZwgKCvYusfYmrqfemmejc.amkocks-bctcjlmlels.mpe@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6U-0001OS-9c
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:12 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21f078fc592so38631095ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879928; x=1739484728; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1kvd4DOi2VmxFqpp8w4ni6ug/P5xJWrEFTSvZ/wVIA4=;
 b=SoPWdAiLEVoGLUmptk6BRrC2QsV5JPYZGF/lVAPJcdshNZBsao6P/aI2EpFJi8DMMk
 FrzARhcR+8oVdUaeI6cckQY0Os1xkMch1XIFra0xoY9bfzRJmcb4VjNGY09f3tbq64WO
 b3G/HHEc9YZBt4ZAbmwJKm6afh09HrfuaTq+tCJ5nYGGRkOjbRCtb74BQE76gdbgsIGu
 0MjXGEMQg9XLd9oW2dsUs+yzWNulmrQ6PovHNcBXo59pmm4CMeXaARXKbpBFgnOGmtxj
 OPp9hpIVd75WWIujEcGRQz2aaBKoRhitCmfS5ZuJhmJQU/wmta+yjqMtDjuFeh1xRCPA
 YyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879928; x=1739484728;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1kvd4DOi2VmxFqpp8w4ni6ug/P5xJWrEFTSvZ/wVIA4=;
 b=lwOozhZtkUDfSqvLY/OF9UOZFiViatRJQ4ReLawR3LQDHGq9paT97WYWMNK8UgLz0N
 CGg7qqzYtTEeRZDfxK4JwbgbFLEUAeF4dTZgb5dw5Dh2kVK3qt/W/4YrHQqD5PZ8qArD
 LfUkbv9RvEb6VpVPSNSP5xojUouZ/7gT3eClG/Pd8KnSap8nuQNRdQlBflGbR+5skT//
 blHwoh4ee7rCknh8Z9e4PSySq9XitnpkeWSY5NiXYpVy7BNfdYCWan0SoyyLveAsdbws
 AU1I4hUMtd+zu98T+M28IegmURjBC1G47VQLNvUL9mDfWup+Vw+wy7U4aHLEZaZCj3zX
 ydqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5n24vxXsBVRPvZQqwRhtJh+IAgdLDEl0m0WMbHHawmcgdC7aFQuFxbi/m0pWmUswnJ3kVE3jqwXZn@nongnu.org
X-Gm-Message-State: AOJu0YwuCwwqTlTutmJHov6nYKbi0b3njuWsUlRq9fzrRs997qihILKM
 uYCZMRBz8CJ0nRmThOqAo7oR8tKHWpwJy/HS+nJqM01/dwuiB3hhx95p2KPK15uq0oZGROUnqGz
 WzV+e/uMNdw==
X-Google-Smtp-Source: AGHT+IGT04/alOrZbHbVvyPQBIz5r4zdrWrtAe6DYKpegr73zmrjc9bef+NZ2Eg6teIhXucAV5Kl/PR8ELx1cw==
X-Received: from pgrx7.prod.google.com ([2002:a65:4547:0:b0:7fd:3c4b:d9d0])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9f4a:b0:1ed:e7f0:3136 with SMTP id
 adf61e73a8af0-1ee03a8db7cmr1698342637.20.1738879927803; 
 Thu, 06 Feb 2025 14:12:07 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:46 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-1-wuhaotsh@google.com>
Subject: [PATCH v4 00/17] hw/arm: Add NPCM8XX Support
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3tzOlZwgKCvYusfYmrqfemmejc.amkocks-bctcjlmlels.mpe@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Changes since v3:

1. Removed REGS_END constants according to code review.
2. Added a few asserts according to code review.
3. A few minor style changes.

Changes since v2:

1. Update doc to include npcm845-evb description
2. Add g_assert for register size in CLK and GCR enter_reset function
3. Fix various 8xx SoC and board file issues.

Changes since v1:

1. Updated vbootrom and pc-bios
2. Split out CLK/GCR patches into refactoring and adding new features
3. Fixed a few misc items from the patches.

---

NPCM8XX BMCs are the successors of the NPCM7XX BMCs. They feature
quad-core ARM Cortex A35 that supports both 32 bits and 64 bits
operations. This patch set aims to support basic functionalities
of the NPCM7XX BMCs. The patch set includes:

1. We derive most devices from the 7XX models and
made some modifications.
2. We have constructed a minimum vBootROM similar to the 7XX one at
https://github.com/google/vbootrom/tree/master/npcm8xx
and included it in the patch set.
3.  We added a new NPCM8XX SOC and an evaluation
board machine npcm845-evb.

The OpenBMC for NPCM845 evaluation board can be found at:
https://github.com/Nuvoton-Israel/openbmc/tree/npcm-v2.10/meta-evb/meta-evb-nuvoton/meta-evb-npcm845

The patch set can boot the evaluation board image built from the source
above to login prompt.

Hao Wu (17):
  roms: Update vbootrom to 1287b6e
  pc-bios: Add NPCM8XX vBootrom
  hw/ssi: Make flash size a property in NPCM7XX FIU
  hw/misc: Rename npcm7xx_gcr to npcm_gcr
  hw/misc: Move NPCM7XX GCR to NPCM GCR
  hw/misc: Add nr_regs and cold_reset_values to NPCM GCR
  hw/misc: Add support for NPCM8XX GCR
  hw/misc: Store DRAM size in NPCM8XX GCR Module
  hw/misc: Support 8-bytes memop in NPCM GCR module
  hw/misc: Rename npcm7xx_clk to npcm_clk
  hw/misc: Move NPCM7XX CLK to NPCM CLK
  hw/misc: Add nr_regs and cold_reset_values to NPCM CLK
  hw/misc: Support NPCM8XX CLK Module Registers
  hw/net: Add NPCM8XX PCS Module
  hw/arm: Add NPCM8XX SoC
  hw/arm: Add NPCM845 Evaluation board
  docs/system/arm: Add Description for NPCM8XX SoC

 MAINTAINERS                                   |   1 +
 configs/devices/aarch64-softmmu/default.mak   |   1 +
 docs/system/arm/nuvoton.rst                   |  27 +-
 hw/arm/Kconfig                                |  13 +
 hw/arm/meson.build                            |   1 +
 hw/arm/npcm7xx.c                              |   6 +
 hw/arm/npcm8xx.c                              | 804 ++++++++++++++++++
 hw/arm/npcm8xx_boards.c                       | 253 ++++++
 hw/misc/meson.build                           |   4 +-
 hw/misc/npcm7xx_gcr.c                         | 264 ------
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 235 +++--
 hw/misc/npcm_gcr.c                            | 482 +++++++++++
 hw/misc/trace-events                          |  12 +-
 hw/net/meson.build                            |   1 +
 hw/net/npcm_pcs.c                             | 410 +++++++++
 hw/net/trace-events                           |   4 +-
 hw/ssi/npcm7xx_fiu.c                          |  16 +-
 include/hw/arm/npcm7xx.h                      |   8 +-
 include/hw/arm/npcm8xx.h                      | 128 +++
 include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} |  43 +-
 include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} |  29 +-
 include/hw/net/npcm_pcs.h                     |  42 +
 include/hw/ssi/npcm7xx_fiu.h                  |   1 +
 pc-bios/README                                |   8 +-
 pc-bios/meson.build                           |   1 +
 pc-bios/npcm7xx_bootrom.bin                   | Bin 768 -> 768 bytes
 pc-bios/npcm8xx_bootrom.bin                   | Bin 0 -> 608 bytes
 roms/Makefile                                 |   6 +
 roms/vbootrom                                 |   2 +-
 29 files changed, 2433 insertions(+), 369 deletions(-)
 create mode 100644 hw/arm/npcm8xx.c
 create mode 100644 hw/arm/npcm8xx_boards.c
 delete mode 100644 hw/misc/npcm7xx_gcr.c
 rename hw/misc/{npcm7xx_clk.c => npcm_clk.c} (82%)
 create mode 100644 hw/misc/npcm_gcr.c
 create mode 100644 hw/net/npcm_pcs.c
 create mode 100644 include/hw/arm/npcm8xx.h
 rename include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} (83%)
 rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (76%)
 create mode 100644 include/hw/net/npcm_pcs.h
 create mode 100644 pc-bios/npcm8xx_bootrom.bin

-- 
2.48.1.502.g6dc24dfdaf-goog


