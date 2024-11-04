Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A619D11196
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7koQ-00072f-Oh; Sun, 03 Nov 2024 19:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koN-00072S-Pf; Sun, 03 Nov 2024 19:19:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koL-0002Bt-PK; Sun, 03 Nov 2024 19:19:15 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so3058370b3a.1; 
 Sun, 03 Nov 2024 16:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679551; x=1731284351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qrE/c8xhT6lKSjmJJOXAEnLxrD0AiQc5AINnzucVh9k=;
 b=Ypk+zZY3wFW1fSbD4CJLUzVHVnPQ27HN7Y54dmuPOcFUhQrMQZPK4UBJ+3kglxX8KG
 5uta9wAQOq9SDVx1DgaMeg8TBVyibuW/u44RwQn8temnoU5l9eesIt3VUvRpo1zBhJJV
 raNVhmr8WJo5AuKxgglWRNu8/prAMjUJ0sQQGuU7/lwvi/zM24kHKXBYo5SzTzrudfOb
 hRyK13QkZU7alhrrKdrjRb+tp36aH/lVVrMMNfl9/cR3k6SUXATbg4ED/3lOin9VWcV1
 fKNtLEZVw74EF5AvywVwwLe+w3gwEcgDj5aGNACJxZCVsvtIJf9EeBNO/xDetOrVen9O
 Z0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679551; x=1731284351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qrE/c8xhT6lKSjmJJOXAEnLxrD0AiQc5AINnzucVh9k=;
 b=DTf8A9a0aTSb/0oN4N9bhTEt2LbOKL+jDjo9ORuFlFHrck00d05ORFFkPeoLHl4own
 FyiUqFRAIP0NR6pcAE848OkD9Z8xyAtJXIqgnrU4pwDfuXd8ieJ91thFS7GVZlJyrKPG
 h42qSKBU7y6LPmmL83NFirmK0h0KrGX1BZBRbED87LHZsiCPyPiHxg6462LYCrKvLBKI
 efySv3pW/9kThDLPk8+S53vZ6lgrx4Ca19l7RDbuzSbrhnMp4Shyamqo7s+qoTSRTVUH
 IlnPOOXRZO6M3xa7DnnRsx/iO0ttYkrfqkOCIy7QTQVvxpT0MzduM2laa8/sAy7/yjWw
 wheQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4TnPRuLpBlyS4YaZwnnY2+0J+cqV/6cBcRhvUATt/ent6yje17tE3aZU+zzZhAVD+AOG7+UlqNw==@nongnu.org
X-Gm-Message-State: AOJu0YybEzSCnd2MsBZSBCccdYmImiZs2ZNpoYpBDW21ITPnZ6GTc78G
 JZ7piAwI/jSe2QhhCoRkTdoZLjK1HAa32qdl50VW0Fgo7In1Vl2m98RlDQ==
X-Google-Smtp-Source: AGHT+IFW4ZkxUJl49otuIXPO+t9G82rEuekiw6RWr2nl7ng9v4AbCtxOKXePzTXJ4gD83zn/ootNcg==
X-Received: by 2002:a05:6a21:a247:b0:1d8:f679:ee03 with SMTP id
 adf61e73a8af0-1d9a8409fe3mr41924406637.27.1730679551295; 
 Sun, 03 Nov 2024 16:19:11 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 00/67] ppc-for-9.2-1 queue
Date: Mon,  4 Nov 2024 10:17:49 +1000
Message-ID: <20241104001900.682660-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:

  Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.2-1-20241104

for you to fetch changes up to bd4be4d9bd20a252e677239a18b6409ecee98f56:

  MAINTAINERS: Remove myself as reviewer (2024-11-04 10:09:36 +1000)

----------------------------------------------------------------
* Various bug fixes
* Big cleanup of deprecated machines
* Power11 support for spapr
* XIVE improvements
* Goodbye Cedric and David as ppc reviewers, thank you both o7

----------------------------------------------------------------
Aditya Gupta (5):
      target/ppc: Introduce 'PowerPCCPUClass::spapr_logical_pvr'
      target/ppc: Fix regression due to Power10 and Power11 having same PCR
      target/ppc: Add Power11 DD2.0 processor
      ppc/pseries: Add Power11 cpu type
      hw/ppc: Implement -dtb support for PowerNV

Amit Machhiwal (2):
      spapr: nested: Add support for DPDES SPR in GSB for TCG L0
      spapr: nested: Add Power11 capability support for Nested PAPR guests in TCG L0

BALATON Zoltan (2):
      hw/ppc: Consolidate e500 initial mapping creation functions
      hw/ppc: Consolidate ppc440 initial mapping creation functions

Chalapathi V (1):
      hw/ssi/pnv_spi: Fixes Coverity CID 1558831

Clément Chigot (1):
      hw/ppc: fix decrementer with BookE timers

Cédric Le Goater (2):
      MAINTAINERS: Remove myself from the PowerNV machines
      MAINTAINERS: Remove myself from XIVE

David Gibson (1):
      MAINTAINERS: Remove myself as reviewer

Frederic Barrat (5):
      pnv/xive2: Define OGEN field in the TIMA
      ppc/xive2: Support TIMA "Pull OS Context to Odd Thread Reporting Line"
      ppc/xive2: Dump more NVP state with 'info pic'
      ppc/xive2: Dump the VP-group and crowd tables with 'info pic'
      tests/qtest: Add XIVE tests for the powernv10 machine

Glenn Miles (7):
      pnv/xive2: Support for "OS LGS Push" TIMA operation
      ppc/xive2: Allow 1-byte write of Target field in TIMA
      ppc/xive2: Support "Pull Thread Context to Register" operation
      ppc/xive2: Support "Pull Thread Context to Odd Thread Reporting Line"
      pnv/xive: Add special handling for pool targets
      pnv/xive: Update PIPR when updating CPPR
      pnv/xive2: TIMA support for 8-byte OS context push for PHYP

Harsh Prateek Bora (23):
      ppc/spapr: remove deprecated machine pseries-2.1
      ppc/spapr: remove deprecated machine pseries-2.2
      ppc/spapr: remove deprecated machine pseries-2.3
      ppc/spapr: remove deprecated machine pseries-2.4
      ppc/spapr: remove deprecated machine pseries-2.5
      ppc/spapr: remove deprecated machine pseries-2.6
      ppc/spapr: remove deprecated machine pseries-2.7
      ppc/spapr: remove deprecated machine pseries-2.8
      ppc/spapr: remove deprecated machine pseries-2.9
      ppc/spapr: remove deprecated machine pseries-2.10
      ppc/spapr: remove deprecated machine pseries-2.11
      ppc/spapr: remove deprecated machine pseries-2.12-sxxm
      ppc/spapr: remove deprecated machine pseries-2.12
      target/ppc: Reduce code duplication across Power9/10 init code
      target/ppc: use locally stored msr and avoid indirect access
      target/ppc: optimize hreg_compute_pmu_hflags_value
      target/ppc: optimize hreg_compute_pmu_hflags_value
      target/ppc: optimize p9 exception handling routines
      target/ppc: optimize p8 exception handling routines
      target/ppc: optimize p7 exception handling routines
      target/ppc: simplify var usage in ppc_next_unmasked_interrupt
      target/ppc: combine multiple ail checks into one
      target/ppc: reduce duplicate code between init_proc_POWER{9, 10}

Ilya Leoshkevich (3):
      target/ppc: Set ctx->opcode for decode_insn32()
      target/ppc: Make divd[u] handler method decodetree compatible
      tests/tcg: Replace -mpower8-vector with -mcpu=power8

Michael Kowal (3):
      pnv/xive: TIMA patch sets pre-req alignment and formatting changes
      ppc/xive2: Change context/ring specific functions to be generic
      pnv/xive2: TIMA CI ops using alternative offsets or byte lengths

Nicholas Piggin (9):
      ppc/pnv: Fix LPC serirq routing calculation
      ppc/pnv: Fix LPC POWER8 register sanity check
      target/ppc: Fix mtDPDES targeting SMT siblings
      target/ppc: PMIs are level triggered
      target/ppc: Fix doorbell delivery to threads in powersave
      target/ppc: Fix HFSCR facility checks
      target/ppc: Fix VRMA to not check virtual page class key protection
      ppc/pnv: ADU fix possible buffer overrun with invalid size
      ppc/xive: Fix ESB length overflow on 32-bit hosts

Philippe Mathieu-Daudé (3):
      MAINTAINERS: Cover PowerPC SPI model in PowerNV section
      hw/ssi/pnv_spi: Match _xfer_buffer_free() with _xfer_buffer_new()
      hw/ssi/pnv_spi: Return early in transfer()

 MAINTAINERS                        |   7 +-
 docs/about/deprecated.rst          |   8 -
 docs/system/ppc/pseries.rst        |  17 +-
 hw/core/machine.c                  |  27 ---
 hw/intc/pnv_xive2.c                |  44 ++++-
 hw/intc/spapr_xive_kvm.c           |   4 +-
 hw/intc/xics.c                     |  16 --
 hw/intc/xive.c                     | 203 ++++++++++++++-----
 hw/intc/xive2.c                    | 317 +++++++++++++++++++++++++-----
 hw/ppc/e500.c                      |  41 ++--
 hw/ppc/e500.h                      |   2 -
 hw/ppc/pnv.c                       |  51 +++--
 hw/ppc/pnv_adu.c                   |  12 ++
 hw/ppc/pnv_lpc.c                   |  14 +-
 hw/ppc/ppc.c                       |   4 +-
 hw/ppc/ppc440_bamboo.c             |  28 +--
 hw/ppc/ppc_booke.c                 |  10 +
 hw/ppc/ppce500_spin.c              |  30 +--
 hw/ppc/sam460ex.c                  |  45 +----
 hw/ppc/spapr.c                     | 387 +------------------------------------
 hw/ppc/spapr_cpu_core.c            |  13 +-
 hw/ppc/spapr_nested.c              |  13 +-
 hw/ppc/spapr_pci.c                 |  92 +--------
 hw/ppc/virtex_ml507.c              |  28 +--
 hw/ssi/pnv_spi.c                   |  12 +-
 include/hw/boards.h                |   9 -
 include/hw/pci-host/spapr.h        |   5 -
 include/hw/ppc/ppc.h               |   7 +
 include/hw/ppc/spapr.h             |   3 -
 include/hw/ppc/spapr_cpu_core.h    |   1 -
 include/hw/ppc/spapr_nested.h      |   8 +-
 include/hw/ppc/xive.h              |   4 +-
 include/hw/ppc/xive2.h             |  18 ++
 include/hw/ppc/xive2_regs.h        |  25 ++-
 include/hw/ppc/xive_regs.h         |  45 +++--
 migration/savevm.c                 |  19 --
 target/ppc/compat.c                |  11 ++
 target/ppc/cpu-models.c            |   3 +
 target/ppc/cpu-models.h            |   3 +
 target/ppc/cpu.h                   |  18 +-
 target/ppc/cpu_init.c              | 252 +++++++++---------------
 target/ppc/cpu_init.h              |  91 +++++++++
 target/ppc/excp_helper.c           | 255 ++++++++++++------------
 target/ppc/helper_regs.c           |  19 +-
 target/ppc/machine.c               |  72 +------
 target/ppc/misc_helper.c           |   2 +-
 target/ppc/mmu-hash64.c            |   9 +-
 target/ppc/translate.c             |   5 +-
 tests/qtest/meson.build            |   2 +
 tests/qtest/pnv-xive2-common.c     | 190 ++++++++++++++++++
 tests/qtest/pnv-xive2-common.h     | 111 +++++++++++
 tests/qtest/pnv-xive2-flush-sync.c | 205 ++++++++++++++++++++
 tests/qtest/pnv-xive2-test.c       | 344 +++++++++++++++++++++++++++++++++
 tests/tcg/ppc64/Makefile.target    |  10 +-
 54 files changed, 1946 insertions(+), 1225 deletions(-)
 create mode 100644 target/ppc/cpu_init.h
 create mode 100644 tests/qtest/pnv-xive2-common.c
 create mode 100644 tests/qtest/pnv-xive2-common.h
 create mode 100644 tests/qtest/pnv-xive2-flush-sync.c
 create mode 100644 tests/qtest/pnv-xive2-test.c

