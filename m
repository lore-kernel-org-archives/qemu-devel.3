Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787AEC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp5l-00030B-3E; Wed, 19 Feb 2025 13:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_ya2ZwgKCmoecPIWbaPOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5b-0002wR-5C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:35 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_ya2ZwgKCmoecPIWbaPOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5Y-0004gC-1K
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:30 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fc0bc05afdso386273a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990784; x=1740595584; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YRjQoDBiw6x1CeKFLUk8y/8E5FWr/phQtEIRRCz8Jjc=;
 b=Zes3eIb10iKKuiZ+TtH5O96d+PG20CBSF3tWp/M3HMgSxah4s5N39VHyvEdUVb9+MV
 LThU3UNiC9XukfFkMZ7IY3MAbbEBPB3i2I/B0eUauvAQ1UU9BdrZrug4wvWz0nM69zXy
 tqa+g5D8qvEB+STLU22PBI6/CnIceHwyL7eCanV3QDQIav+AUtiPvYGBEboPhlWzoDCp
 eQThkcFBEldqpbiGqIVZUmnNz6BEdUb9xQrTV3LG9ZL8H6KTHkaGOHQw3FTcqWps9sqd
 y8pTUpLepohAJ16izHCblfPnlovdGAoovxpStUWVFQmGG5cLYzqIgyN25LBX/QBYBZUm
 DkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990784; x=1740595584;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRjQoDBiw6x1CeKFLUk8y/8E5FWr/phQtEIRRCz8Jjc=;
 b=iQ6d0YjeNp3N6Mc9KuNheGu3AdY9GGOSmXit8G9NYpkzstLHYJa4zDwn9qPNOPauBt
 C05sTnqCvPOAW6TCA24TqsQDw7uOqr01Ddygh0de76w/OfpafYv59OThVTm938EqU6HO
 9opM/hoLKXKJA5pfzuA6pjJYyQ5U2b85NQiaHEGmJOI29XCCu6JivnX2FjvDbdDyOHyn
 75AfeP6FF2ydRgNzSHLiaZ1EQqBRqOWpTcmLOtN7Dhl7/rJTGpZEL4tL+mtfyche7CoQ
 qvDC5g6P9RduRmhYGiCTWAt6L8mITPagIqCIEG+9mN1d1yY3/J3sEuNNMG4N+KZHgQCi
 OIEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9xhhR+619tFNWiKHfvXsY9eedPwtsz3znPL2PqhMmzI0GdXbIxsFW/u0P+F28zNjhhJxLjwvq58pv@nongnu.org
X-Gm-Message-State: AOJu0Yxyq3zTzigWkER2PE6wXFpq4SwWHiVdeKelEhK5FLharNc9cpL0
 D6jj994EACpi151GFBdylpWD8cNJMZUGitT7iageJ3qwhsWivH9yT6vV3y+fsPZM8xFu1vs94LY
 cBWjS470ttA==
X-Google-Smtp-Source: AGHT+IFXPBoIcPC7UnSVqcojLE/ljzick9VL921d/WGYTikIS/K4P0KWVqAuBEzxcSh5WZArKnqNjahEPiOZww==
X-Received: from pjbnd5.prod.google.com ([2002:a17:90b:4cc5:b0:2e9:38ea:ca0f])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2789:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-2fc4116bc28mr32224508a91.33.1739990783747; 
 Wed, 19 Feb 2025 10:46:23 -0800 (PST)
Date: Wed, 19 Feb 2025 10:45:51 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-1-wuhaotsh@google.com>
Subject: [PATCH v5 00/17] hw/arm: Add NPCM8XX Support
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3_ya2ZwgKCmoecPIWbaPOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

Changes since v4:

1. Bump vmstate versions on NPCM CLK and GCR modules.
2. Remove "hw/boards.h" include in npcm8xx.h and add it in npcm8xx*.c
3. Use cpu_to_le32 instead of tswap32 in npcm8xx.c

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
 hw/arm/npcm8xx.c                              | 805 ++++++++++++++++++
 hw/arm/npcm8xx_boards.c                       | 254 ++++++
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
 29 files changed, 2434 insertions(+), 369 deletions(-)
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
2.48.1.601.g30ceb7b040-goog


