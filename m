Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7ECC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqkP-0005JZ-KN; Wed, 05 Feb 2025 20:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33xCkZwgKCtQMK70EJI76EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjg-0005BE-0X
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:24 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33xCkZwgKCtQMK70EJI76EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjc-0006sX-UO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:19 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-216387ddda8so9159915ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805471; x=1739410271; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6H53Z1uXZaAXgTmZF6LwgzkOoyjl/bBsioLhlrHPsI8=;
 b=Zk8/u6yrSIAxdgb5wkML6uE9CxY4+wpxppCdOInhzLYps0uNv5fOrhPSYSdbAt0aay
 0wQwqlhpg3DO+gxSwyNVK3yDBpIzJAUIj1BmRicr+NyABvwFuCXgrle6qI6DqoHqgxiQ
 JfN8PHEAuubk4HBnmyHt01+qWHuyu5QiGhPd0smA7srt4Bjt8ytrSTBJEjfFfaKils1Z
 EeUzbSJ0JA7yrnd3HcLPHi1wUsTQdG80+1fZKLWwkCNbx+Rt78d0VcZ6eB5qRKrXMoEg
 1mc2YlzxANS8QhER3EQl9HL+bD3uqNLU6imHK6cHEO3A4KsyQrd45X19bHUUIKtPZT9B
 NaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805471; x=1739410271;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6H53Z1uXZaAXgTmZF6LwgzkOoyjl/bBsioLhlrHPsI8=;
 b=ey6XpcuV9vzk9cGnCU5Q7fzIRNlJ+qMctd5aNNEXcBV02dn9BjmZNX8iO4V6CL6uK+
 0WlotoB7MXfvk/H2L9nhcpaHWzrsDIMNwYP5WvUk3qDHYxTVNQCOI4BlTsSxFpdx2m75
 P8CurVvfI0AzTGvWrN3CWcmfbtCpGH6fksqITbjZOJAiZ4YWZOx3NvPoUAUnlme5VJ01
 8E/GKTVCrX/j2Mv1e1q+JKd4mpSBvqUI+If6z8YW7hFa7FlkvULw/1+4fidS3FnZpw9r
 fEhSZROY5mxOWw+iZgHyLhRq3wvcSLZXWzW5A8nCm8bcdY4MyJDCoRcFv7Fnod42vjPr
 4WEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtevrPL9kIMn3y28K4ZIQ9mflnrrwYIQbUi6hzGNCwyN99AqyKcYq+nDbRxdRllINOfUBhDTq1iCIH@nongnu.org
X-Gm-Message-State: AOJu0YyqPeHej+k4NyHnEhiJOJDZTUpVOO0kznwOy7O8sRlfh26Bunv9
 2w8+wh8kCf2BytkxLgIfp30zW7vVukp3B2067Mp2i/thtzqwjcCg6t+xOIizpwB2u12vHpAi33W
 WIVE7+gszcw==
X-Google-Smtp-Source: AGHT+IFgz5O7pvMmY3aobc4ChfaSoFiUz8475eba6lMlUDa74mxh06XUJVOGV5kv3jRhVwkcRICt1lQ24YiZwg==
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:2f8:4024:b59a])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f786:b0:216:2abc:194f with SMTP id
 d9443c01a7336-21f17edec5cmr93802495ad.40.1738805471300; 
 Wed, 05 Feb 2025 17:31:11 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:48 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-1-wuhaotsh@google.com>
Subject: [PATCH v3 00/17] hw/arm: Add NPCM8XX Support
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=33xCkZwgKCtQMK70EJI76EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 240 ++++--
 hw/misc/npcm_gcr.c                            | 485 +++++++++++
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
 29 files changed, 2434 insertions(+), 370 deletions(-)
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
2.48.1.362.g079036d154-goog


