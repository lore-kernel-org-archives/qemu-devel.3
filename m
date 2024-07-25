Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E824DC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8I1-0001mA-Ph; Thu, 25 Jul 2024 19:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Hz-0001ev-SD; Thu, 25 Jul 2024 19:54:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Hx-0000X7-IW; Thu, 25 Jul 2024 19:54:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7a18ba4143bso367833a12.2; 
 Thu, 25 Jul 2024 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951663; x=1722556463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vuTASRrnNMFHwIdLbtElTK9PwZQwiC9049mukLPYNt0=;
 b=fjnXgJauWjIjDXjxvGqiBhqfD5pjiBELLdvZ2E6451H/7Mn2GbPXMtxTgF56d98elN
 xj9XIz61BVn85XvIicaEtSro6sR3ub5e8fqTZ+yVDy4rber9P/QqvgEV3PUamEAOcEIZ
 GUZZZ0EXxoKfgmpuG7W8dBmn5FKDqSZHrlrfCwfOlNKFhxDLTwrNQR5rCHIZVJDeq0e9
 nB1LIxw33EIp6MCAKXLcKJZcmts45zHNQRdGNeV/wMZEqphLJOEsFg4cGWzGx0Ave7Q/
 Be0ZQ+dW2bJtkEHgDDBD9hUjpfYFfuZHw/51eC9OGuE/Ug8XQYwtDfDm8MiLVxRxAbSW
 PxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951663; x=1722556463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vuTASRrnNMFHwIdLbtElTK9PwZQwiC9049mukLPYNt0=;
 b=VWNThFF0JZ5/zk8Q2QXRDEoIMlGKi5XCHW7GzHqVxTaHBY1dgKzqq7vKFXT3X6tWJI
 4DF1B0eWeag/Q2Y+CQeOSg6yverpQQTU3qH35AtLj0Od+ZRMAI8Uq3N4+0rOTC+pZfra
 08tq8mXBRWFyhvfpj4M9e9A6wOkJmKrxH46sBv45LTgDFcppt8I5ED7zu3eXZLkR5Nna
 3o9Ws7VSBm3gSAhLHDWr3a/TRrVP3NwczfwhsOqgShM0LTP/tWC2qXE/B50IceA6R2DQ
 fCA9SYmWJHDMhL51dLPBjoQOfys0w5ZXNaHujxby1Lz3U2zAnRIJGemrRLw4iEQidgsV
 3/Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC6OoOboMkJK3Dow2UyP2O2i0dawnQI9JJ+Cz7bpCe93g5HaVeiq9Mx2ZH/ow52P9FF3H6xIuY63jGlqgt+MrkYls1
X-Gm-Message-State: AOJu0YwWcalJMTH42YnWu+8k+Ye2YECUqhyu9WUX8GtwKpqLUNmwIMRf
 i+iqam1Zc/OhmS1thJ/05ztzlLeJQ5LyxLTZuD0ViWN+YUlHH2XsYjWcww==
X-Google-Smtp-Source: AGHT+IEKByv5kxY468rmsaiMmAolAp5QfkoW3DMscqdWrlq1LJaiiSKcqt3FOAAcBeYLMno5detNWw==
X-Received: by 2002:a17:90a:bc8a:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2cf2e9dc2efmr3680593a91.15.1721951663085; 
 Thu, 25 Jul 2024 16:54:23 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 00/96] ppc-for-9.1-2 queue
Date: Fri, 26 Jul 2024 09:52:33 +1000
Message-ID: <20240725235410.451624-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

Apologies this is so late after soft-freeze, apologies. I was waiting
on "accel/kvm: Extract common KVM vCPU {creation,parking} code" to be
merged upsream then ran into last minute CI problems. This PR is very
contained to ppc code so I hope it will not inconvenience anybody.

Thanks,
Nick

The following changes since commit 029e13a8a56a2931e7c24c0db52ae7256b932cb0:

  Merge tag 'bsd-user-for-9.1-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-07-25 09:53:57 +1000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.1-2-20240726-1

for you to fetch changes up to d741ecffd2ca260ce7875a4596f17736b5ccb7c3:

  target/ppc: Remove includes from mmu-book3s-v3.h (2024-07-26 09:51:34 +1000)

----------------------------------------------------------------

* Fixes for pseries migration bugs.
* Graceful handling of vCPU hotplug failure in KVM.
* Many improvements to powernv machine model.
* Move more instructions to decodetree.
* Most of the remaining large MMU cleanup.

----------------------------------------------------------------
Aditya Gupta (1):
      ppc/pnv: Update Power10's cfam id to use Power10 DD2

Akihiko Odaki (2):
      spapr: Free stdout path
      ppc/vof: Fix unaligned FDT property access

BALATON Zoltan (32):
      target/ppc: Reorganise and rename ppc_hash32_pp_prot()
      target/ppc/mmu_common.c: Remove local name for a constant
      target/ppc/mmu_common.c: Remove single use local variable
      target/ppc/mmu_common.c: Remove single use local variable
      target/ppc/mmu_common.c: Remove another single use local variable
      target/ppc/mmu_common.c: Remove yet another single use local variable
      target/ppc/mmu_common.c: Return directly in ppc6xx_tlb_pte_check()
      target/ppc/mmu_common.c: Simplify ppc6xx_tlb_pte_check()
      target/ppc/mmu_common.c: Remove unused field from mmu_ctx_t
      target/ppc/mmu_common.c: Remove hash field from mmu_ctx_t
      target/ppc/mmu_common.c: Remove pte_update_flags()
      target/ppc/mmu_common.c: Remove nx field from mmu_ctx_t
      target/ppc/mmu_common.c: Convert local variable to bool
      target/ppc/mmu_common.c: Remove single use local variable
      target/ppc/mmu_common.c: Simplify a switch statement
      target/ppc/mmu_common.c: Inline and remove ppc6xx_tlb_pte_check()
      target/ppc/mmu_common.c: Remove ptem field from mmu_ctx_t
      target/ppc: Add function to get protection key for hash32 MMU
      target/ppc/mmu-hash32.c: Inline and remove ppc_hash32_pte_prot()
      target/ppc/mmu_common.c: Init variable in function that relies on it
      target/ppc/mmu_common.c: Remove key field from mmu_ctx_t
      target/ppc/mmu_common.c: Stop using ctx in ppc6xx_tlb_check()
      target/ppc/mmu_common.c: Rename function parameter
      target/ppc/mmu_common.c: Use defines instead of numeric constants
      target/ppc: Remove bat_size_prot()
      target/ppc/mmu_common.c: Stop using ctx in get_bat_6xx_tlb()
      target/ppc/mmu_common.c: Remove mmu_ctx_t
      target/ppc/mmu-hash32.c: Inline and remove ppc_hash32_pte_raddr()
      target/ppc/mmu-hash32.c: Move get_pteg_offset32() to the header
      target/ppc: Unexport some functions from mmu-book3s-v3.h
      target/ppc/mmu-radix64: Remove externally unused parts from header
      target/ppc: Remove includes from mmu-book3s-v3.h

Chalapathi V (6):
      ppc/pnv: Remove ppc target dependency from pnv_xscom.h
      hw/ssi: Add SPI model
      hw/ssi: Extend SPI model
      hw/block: Add Microchip's 25CSM04 to m25p80
      hw/ppc: SPI controller wiring to P10 chip
      tests/qtest: Add pnv-spi-seeprom qtest

Chinmay Rath (12):
      target/ppc: Move VMX integer add/sub saturate insns to decodetree.
      target/ppc: Improve VMX integer add/sub saturate instructions.
      target/ppc: Move ISA300 flag check out of do_helper_XX3.
      target/ppc: Move VSX arithmetic and max/min insns to decodetree.
      target/ppc: Move VSX logical instructions to decodetree.
      target/ppc: Moving VSX scalar storage access insns to decodetree.
      target/ppc: Move VSX vector with length storage access insns to decodetree.
      target/ppc: Move VSX vector storage access insns to decodetree.
      target/ppc: Move VSX fp compare insns to decodetree.
      target/ppc: Move get/set_avr64 functions to vmx-impl.c.inc.
      target/ppc: Update VMX storage access insns to use tcg_gen_qemu_ld/st_i128.
      target/ppc : Update VSX storage access insns to use tcg_gen_qemu _ld/st_i128.

Frederic Barrat (9):
      pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
      pnv/xive2: Add NVG and NVC to cache watch facility
      pnv/xive2: Configure Virtualization Structure Tables through the PC
      pnv/xive2: Enable VST NVG and NVC index compression
      pnv/xive2: Set Translation Table for the NVC port space
      pnv/xive2: Fail VST entry address computation if table has no VSD
      pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
      pnv/xive2: Refine TIMA 'info pic' output
      pnv/xive2: Dump more END state with 'info pic'

Glenn Miles (1):
      ppc/pnv: Fix loss of LPC SERIRQ interrupts

Harsh Prateek Bora (3):
      accel/kvm: Introduce kvm_create_and_park_vcpu() helper
      cpu-common.c: export cpu_get_free_index to be reused later
      target/ppc: handle vcpu hotplug failure gracefully

Michael Kowal (1):
      pnv/xive2: Structure/define alignment changes

Nicholas Piggin (24):
      tests/tcg: Skip failing ppc64 multi-threaded tests
      spapr: Migrate ail-mode-3 spapr cap
      ppc/pnv: Implement POWER9 LPC PSI serirq outputs and auto-clear function
      ppc/pnv: Begin a more complete ADU LPC model for POWER9/10
      ppc/pnv: Implement ADU access to LPC space
      target/ppc: Fix msgsnd for POWER8
      ppc/pnv: Add pointer from PnvCPUState to PnvCore
      ppc/pnv: Move timebase state into PnvCore
      target/ppc: Move SPR indirect registers into PnvCore
      ppc/pnv: use class attribute to limit SMT threads for different machines
      ppc/pnv: Extend chip_pir class method to TIR as well
      ppc: Add a core_index to CPUPPCState for SMT vCPUs
      target/ppc: Add helpers to check for SMT sibling threads
      ppc: Add has_smt_siblings property to CPUPPCState
      ppc/pnv: Add a big-core mode that joins two regular cores
      ppc/pnv: Add allow for big-core differences in DT generation
      ppc/pnv: Implement big-core PVR for Power9/10
      ppc/pnv: Implement Power9 CPU core thread state indirect register
      ppc/pnv: Add POWER10 ChipTOD quirk for big-core
      ppc/pnv: Add big-core machine property
      ppc/pnv: Add a CPU nmi and resume function
      ppc/pnv: Implement POWER10 PC xscom registers for direct controls
      ppc/pnv: Add an LPAR per core machine option
      pnv/xive: Support cache flush and queue sync inject with notifications

Omar Sandoval (1):
      target/ppc/arch_dump: set prstatus pid to cpuid

Shivaprasad G Bhat (4):
      linux-header: PPC: KVM: Update one-reg ids for DEXCR, HASHKEYR and HASHPKEYR
      target/ppc/cpu_init: Synchronize DEXCR with KVM for migration
      target/ppc/cpu_init: Synchronize HASHKEYR with KVM for migration
      target/ppc/cpu_init: Synchronize HASHPKEYR with KVM for migration

 accel/kvm/kvm-all.c                 |   12 +
 cpu-common.c                        |    7 +-
 hw/block/m25p80.c                   |    3 +
 hw/intc/pnv_xive2.c                 |  566 +++++++++++++---
 hw/intc/pnv_xive2_regs.h            |  108 +++
 hw/intc/xive.c                      |   12 +-
 hw/intc/xive2.c                     |   33 +-
 hw/ppc/Kconfig                      |    3 +
 hw/ppc/meson.build                  |    1 +
 hw/ppc/pnv.c                        |  389 +++++++++--
 hw/ppc/pnv_adu.c                    |  206 ++++++
 hw/ppc/pnv_chiptod.c                |    7 +-
 hw/ppc/pnv_core.c                   |  127 +++-
 hw/ppc/pnv_lpc.c                    |  162 ++++-
 hw/ppc/pnv_xscom.c                  |    9 -
 hw/ppc/spapr.c                      |    1 +
 hw/ppc/spapr_caps.c                 |    1 +
 hw/ppc/spapr_cpu_core.c             |   16 +-
 hw/ppc/spapr_vhyp_mmu.c             |   21 +-
 hw/ppc/spapr_vof.c                  |    2 +-
 hw/ppc/trace-events                 |    4 +
 hw/ppc/vof.c                        |    2 +-
 hw/ssi/Kconfig                      |    4 +
 hw/ssi/meson.build                  |    1 +
 hw/ssi/pnv_spi.c                    | 1268 +++++++++++++++++++++++++++++++++++
 hw/ssi/trace-events                 |   21 +
 include/exec/cpu-common.h           |    2 +
 include/hw/ppc/pnv.h                |    8 +
 include/hw/ppc/pnv_adu.h            |   32 +
 include/hw/ppc/pnv_chip.h           |   13 +-
 include/hw/ppc/pnv_core.h           |   31 +
 include/hw/ppc/pnv_lpc.h            |   22 +-
 include/hw/ppc/pnv_xscom.h          |   11 +-
 include/hw/ppc/spapr.h              |    1 +
 include/hw/ppc/xive2_regs.h         |    9 +
 include/hw/ssi/pnv_spi.h            |   67 ++
 include/hw/ssi/pnv_spi_regs.h       |  133 ++++
 include/sysemu/kvm.h                |    8 +
 linux-headers/asm-powerpc/kvm.h     |    3 +
 target/ppc/arch_dump.c              |   24 +-
 target/ppc/cpu.h                    |   45 +-
 target/ppc/cpu_init.c               |   38 +-
 target/ppc/excp_helper.c            |   69 +-
 target/ppc/fpu_helper.c             |   60 +-
 target/ppc/helper.h                 |   92 +--
 target/ppc/insn32.decode            |   98 +++
 target/ppc/int_helper.c             |   22 +-
 target/ppc/kvm.c                    |   46 ++
 target/ppc/mem_helper.c             |    8 +-
 target/ppc/misc_helper.c            |  111 +--
 target/ppc/mmu-book3s-v3.c          |    1 -
 target/ppc/mmu-book3s-v3.h          |   43 --
 target/ppc/mmu-hash32.c             |   69 +-
 target/ppc/mmu-hash32.h             |   56 +-
 target/ppc/mmu-hash64.c             |   50 ++
 target/ppc/mmu-hash64.h             |    1 +
 target/ppc/mmu-radix64.c            |   50 ++
 target/ppc/mmu-radix64.h            |   53 +-
 target/ppc/mmu_common.c             |  333 ++++-----
 target/ppc/timebase_helper.c        |   89 +--
 target/ppc/translate.c              |   27 +-
 target/ppc/translate/vmx-impl.c.inc |  290 +++++---
 target/ppc/translate/vmx-ops.c.inc  |   19 +-
 target/ppc/translate/vsx-impl.c.inc |  592 ++++++++--------
 target/ppc/translate/vsx-ops.c.inc  |   82 ---
 tests/qtest/meson.build             |    1 +
 tests/qtest/pnv-spi-seeprom-test.c  |  110 +++
 tests/qtest/pnv-xscom.h             |    2 +-
 tests/tcg/ppc64/Makefile.target     |   12 +
 69 files changed, 4417 insertions(+), 1402 deletions(-)
 create mode 100644 hw/ppc/pnv_adu.c
 create mode 100644 hw/ssi/pnv_spi.c
 create mode 100644 include/hw/ppc/pnv_adu.h
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

