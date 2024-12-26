Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3780AE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjEG-0002Lo-6S; Thu, 26 Dec 2024 03:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lBNtZwgKCrEnlYRfkjYXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--wuhaotsh.bounces.google.com>)
 id 1tQjE1-00029b-8O
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:11 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lBNtZwgKCrEnlYRfkjYXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--wuhaotsh.bounces.google.com>)
 id 1tQjDz-00017Q-8k
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:08 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-218cf85639eso117697105ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201685; x=1735806485; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HkuN/UWfMQxrsiq+7BUvUTgQy7bXjUqggWUuwUyy5bI=;
 b=0JpSR8cMOvyFhx94sCNfbQo8/sg1W48fisJyE6XYGs2G29jGhtrq9o09AulQ2INwBw
 HtTbYcbIDV4sbYG7kEr0wDqFVctDGaSAZfHRybPAYVrFdv/DAaDfyzMCAPAVyZl10g0Z
 nLwJpjk3i4E9hEgLm8uZVC45s+96O94vmRLdB1xrrkoGpW+aU1F3l12zoNYZF5wNkZ0O
 vRvNykzgoDsm1+7DlgLYA7F1zG6JIzXCt5iRCP4M6tITrBKNkBm20AmLS5XEOEDJUU8M
 h7XEL5Hg70b6LgyvZjNlq6cPjwGe7aCdD86vrz+BQO5YCYRSBpPk8NSLFuTybrNw5Nu/
 4m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201685; x=1735806485;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HkuN/UWfMQxrsiq+7BUvUTgQy7bXjUqggWUuwUyy5bI=;
 b=o1GtCSXmrC4w5SQt0JB9szCqgS3SF8djqG601GXfW/jGixN/auG2jjrwHQz/NgYgTX
 Q+m5a12iMVOlmjjzykV5ywTt+3AqbY/d8dbPrqWEy7ylG/xvejRKeIPVZz31jk2noF10
 t52LDmneUEp/DRo5jzQJHHc0IWh3dfELff/ENHLzBkZWqEER6byFm4Pnm3WuAx0F0W4k
 +hOM5kI/uqpOKyvepyMRSCqkWurEdD90U7l5Vkm9OkMtxxUihll1tDm0FX821r+5SJ+O
 i+ntYrUzRLHWu75smm/VVU4Tecm+Chf9J3015diEMXyb6N3iN/MxrQT+eIOm/tSgLlU/
 BoLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHj1cM+r2/6H/EiI2c4h3hBIzEkQEoLMmVrpYrzlpIHsoCCMkrFMuOsgyWD6p/whNwGb1pxeWSusJB@nongnu.org
X-Gm-Message-State: AOJu0YzDBXd11xCcrdOLYp5n+k4hT1SthrFCz6n/KmXnzMu3rSXdMmEl
 YI/v6h7AV8RmzHhihFj9F3WrFIFoguQChhDBeA4CMIKZYQUiEIqcL0ZJ0LHGHlbP0zGdOuC9xzJ
 q6YzoOH9FXA==
X-Google-Smtp-Source: AGHT+IGsMqO9dMQy2rMUHnx6AAfebBF0YCqWJy/MR7TXZO1GZpwVqcCW5a3FNSezG1TGhXg/L4a1trYP7sEHdg==
X-Received: from pfbcw22.prod.google.com
 ([2002:a05:6a00:4516:b0:725:d9ab:3f2e])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6f06:b0:1e1:9ba5:80d8 with SMTP id
 adf61e73a8af0-1e5e080df22mr31863944637.33.1735201684768; 
 Thu, 26 Dec 2024 00:28:04 -0800 (PST)
Date: Thu, 26 Dec 2024 08:27:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082800.2887689-1-wuhaotsh@google.com>
Subject: [PATCH v2 00/17] hw/arm: Add NPCM8XX Support
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3lBNtZwgKCrEnlYRfkjYXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
  docs/system/arm: Add Description for NPCM8XX SoC
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

 MAINTAINERS                                   |   1 +
 configs/devices/aarch64-softmmu/default.mak   |   1 +
 docs/system/arm/nuvoton.rst                   |  20 +-
 hw/arm/Kconfig                                |  11 +
 hw/arm/meson.build                            |   1 +
 hw/arm/npcm7xx.c                              |   6 +
 hw/arm/npcm8xx.c                              | 810 ++++++++++++++++++
 hw/arm/npcm8xx_boards.c                       | 256 ++++++
 hw/misc/meson.build                           |   4 +-
 hw/misc/npcm7xx_gcr.c                         | 264 ------
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 238 +++--
 hw/misc/npcm_gcr.c                            | 483 +++++++++++
 hw/misc/trace-events                          |  12 +-
 hw/net/meson.build                            |   1 +
 hw/net/npcm_pcs.c                             | 410 +++++++++
 hw/net/trace-events                           |   4 +-
 hw/ssi/npcm7xx_fiu.c                          |  11 +-
 include/hw/arm/npcm7xx.h                      |   8 +-
 include/hw/arm/npcm8xx.h                      | 127 +++
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
 29 files changed, 2432 insertions(+), 368 deletions(-)
 create mode 100644 hw/arm/npcm8xx.c
 create mode 100644 hw/arm/npcm8xx_boards.c
 delete mode 100644 hw/misc/npcm7xx_gcr.c
 rename hw/misc/{npcm7xx_clk.c => npcm_clk.c} (81%)
 create mode 100644 hw/misc/npcm_gcr.c
 create mode 100644 hw/net/npcm_pcs.c
 create mode 100644 include/hw/arm/npcm8xx.h
 rename include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} (83%)
 rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (76%)
 create mode 100644 include/hw/net/npcm_pcs.h
 create mode 100644 pc-bios/npcm8xx_bootrom.bin

-- 
2.47.1.613.gc27f4b7a9f-goog


