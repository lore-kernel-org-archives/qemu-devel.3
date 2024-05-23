Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF22C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAIFe-00076I-Iy; Thu, 23 May 2024 19:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAIFc-000750-NH; Thu, 23 May 2024 19:53:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAIFa-0006qj-6P; Thu, 23 May 2024 19:53:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8f30712d3so139176b3a.0; 
 Thu, 23 May 2024 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716508412; x=1717113212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XrnaQWmir4yhOC9pBffiRPBuUeJh5XN/NbbTAYCCvls=;
 b=S4y9LgdkogJJwduMRspzaG5LZBKEEiEwvYSDIOc9k8BxnPHGqV7MLLFs8fw7dzZqxd
 yqwtclmOre39+sG/ij6bTuMO/TLGVEmwFjwh2CE3P92rYdhVOG2feoe6JYxahEJRAIxk
 lTGI8XpcokKIsztPzaI927kfTA+kbSzv3FBOod9vxxVVsdG7fSaXjJCyMEpHRbPnLDF/
 RWxQFqZJji4OVp4KXuRwopJm+sxwauO2D1Ach52LA+goP1RLhEU8e9djECJFjnP9Wr6w
 PfwGPIXMQuRPMCKj6Xu59HsQ28gzJhvh5Tb63s+J4IhDIL1qurKZXRZ032iBaij+9a8u
 6HJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716508412; x=1717113212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrnaQWmir4yhOC9pBffiRPBuUeJh5XN/NbbTAYCCvls=;
 b=DhgSUYTKv95YX1C7ia9af/I1gGJ0hkoJC+5CMYy7rL3ShCXLTb0hV4jzBEepNcCpzX
 A52Tg9kPyPJobXfzFGCZH1GNxoLa2toCbwozPxsVtB645alt3ZPeVhTkSo4KgJoRqmO0
 ZG5CX9R5W16tC2U2WjiE7h+ii14VBtuVtkX/rdSa0BJaKrBPBDtWSl8F5PcmXEgLdpn9
 I8AWIOC1vnKM+yoomXqVIHMe4uO8RiYWUFmcYfZLQv195rQ47fjzTSyweC1W7PoLKsSI
 iwiPUxgwMVBoMysEDo0Kqde1CyK+w72mZztLwL6rsBJI4YS/iLKGer2oA58/mxa3N0mG
 QePg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI0p04UfQ75BhzKgqOz+iTaI2p4UOZK2vhNw8jcP2GQ5uXbxqGdM/9BMUcHBh5qEL7uYV+3TaoVCRRN7L6BSWbDOWj
X-Gm-Message-State: AOJu0Yw26A+J77NCfDwoNScY+j2fWs4ASRT8ZaYdLohmIdr3jVI8IRvv
 eBoRIA5qcZS8tthAxqAzNIiOJadbppEbnZxqhLuMSqrJwflejE4vY1AjNg==
X-Google-Smtp-Source: AGHT+IEZgMd1I04bPMknDmhIhYqFiym1jhiyiGt0H9knYeN96tklikVlh6l25WQ9cqv/jE5x6DA2uQ==
X-Received: by 2002:a05:6a21:3998:b0:1af:86e4:bc99 with SMTP id
 adf61e73a8af0-1b212cecbfemr1136771637.10.1716508411799; 
 Thu, 23 May 2024 16:53:31 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3e5d5sm161358b3a.22.2024.05.23.16.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:53:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 00/72] ppc-for-9.1-1 queue
Date: Fri, 24 May 2024 09:53:18 +1000
Message-ID: <20240523235319.56568-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

This replaces the previous PR for tags/pull-ppc-for-9.1-1-20240524 note
this tag is tags/pull-ppc-for-9.1-1-20240524-1 (added -1 suffix). The
changelog and code are unchanged. Subject for BHRB patches are fixed
and trimmed for some MMU cleanup patches. So I won't re-send individual
patches to lists.

Thanks,
Nick

The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:

  Merge tag 'pull-tcg-20240523' of https://gitlab.com/rth7680/qemu into staging (2024-05-23 09:47:40 -0700)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.1-1-20240524-1

for you to fetch changes up to e48fb4c590a23d81ee1d2f09ee9bcf5dd5f98e43:

  target/ppc: Remove pp_check() and reuse ppc_hash32_pp_prot() (2024-05-24 09:43:14 +1000)

----------------------------------------------------------------

* Fix an interesting TLB invalidate race
* Implement more instructions with decodetree
* Add the POWER8/9/10 BHRB facility
* Add missing instructions, registers, SMT support
* First round of a big MMU xlate cleanup

----------------------------------------------------------------
BALATON Zoltan (33):
      target/ppc: Remove unused helper_rac()
      target/ppc: Move calculation of a value closer to its usage in booke tlb checks
      target/ppc: Remove unneeded local variable from booke tlb checks
      target/ppc: Simplify checking for real mode in get_physical_address_wtlb()
      target/ppc: Drop cases for unimplemented MPC8xx MMU
      target/ppc: Introduce mmu6xx_get_physical_address()
      target/ppc: Move else branch to avoid large if block in mmu6xx_get_physical_address()
      target/ppc: Move some debug logging in ppc6xx_tlb_check()
      target/ppc: Eliminate ret from mmu6xx_get_physical_address()
      target/ppc: Split out BookE xlate cases before checking real mode
      target/ppc: Split off real mode cases in get_physical_address_wtlb()
      target/ppc: Inline and remove check_physical()
      target/ppc: Fix misindented qemu_log_mask() calls
      target/ppc: Deindent ppc_jumbo_xlate()
      target/ppc: Replace hard coded constants in ppc_jumbo_xlate()
      target/ppc: Don't use mmu_ctx_t for mmu40x_get_physical_address()
      target/ppc: Don't use mmu_ctx_t in mmubooke_get_physical_address()
      target/ppc: Don't use mmu_ctx_t in mmubooke206_get_physical_address()
      target/ppc: Remove BookE from direct store handling
      target/ppc: Split off BookE handling from ppc_jumbo_xlate()
      target/ppc: Simplify ppc_booke_xlate() part 1
      target/ppc: Simplify ppc_booke_xlate() part 2
      target/ppc: Split off real mode handling from get_physical_address_wtlb()
      target/ppc: Split off 40x cases from ppc_jumbo_xlate()
      target/ppc: Transform ppc_jumbo_xlate() into ppc_6xx_xlate()
      target/ppc: Move mmu_ctx_t type to mmu_common.c
      target/ppc: Remove id_tlbs flag from CPU env
      target/ppc: Split off common embedded TLB init
      target/ppc/mmu-hash32.c: Drop a local variable
      target/ppc/mmu-radix64.c: Drop a local variable
      target/ppc: Add a function to check for page protection bit
      target/ppc: Move out BookE and related MMU functions from mmu_common.c
      target/ppc: Remove pp_check() and reuse ppc_hash32_pp_prot()

Chinmay Rath (13):
      target/ppc: Merge various fpu helpers
      target/ppc: Move floating-point arithmetic instructions to decodetree.
      target/ppc: Move mul{li, lw, lwo, hw, hwu} instructions to decodetree.
      target/ppc: Make divw[u] handler method decodetree compatible.
      target/ppc: Move divw[u, e, eu] instructions to decodetree.
      target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
      target/ppc: Move multiply fixed-point insns (64-bit operands) to decodetree.
      target/ppc: Move div/mod fixed-point insns (64 bits operands) to decodetree.
      target/ppc: Move cmp{rb, eqb}, tw[i], td[i], isel instructions to decodetree.
      target/ppc: Move logical fixed-point instructions to decodetree.
      target/ppc: Move VMX storage access instructions to decodetree
      target/ppc: Move VMX integer logical instructions to decodetree.
      target/ppc: Move VMX integer max/min instructions to decodetree.

Dr. David Alan Gilbert (1):
      target/ppc: Remove unused struct 'mmu_ctx_hash32'

Glenn Miles (4):
      target/ppc: Add new hflags to support BHRB
      target/ppc: Add recording of taken branches to BHRB
      target/ppc: Add clrbhrb and mfbhrbe instructions
      target/ppc: Add migration support for BHRB

Nicholas Piggin (21):
      spapr: avoid overhead of finding vhyp class in critical operations
      ppc/spapr: Add ibm,pi-features
      target/ppc: Fix broadcast tlbie synchronisation
      tcg/cputlb: Remove non-synced variants of global TLB flushes
      tcg/cputlb: remove other-cpu capability from TLB flushing
      target/ppc: Move sync instructions to decodetree
      target/ppc: Fix embedded memory barriers
      target/ppc: Add ISA v3.1 variants of sync instruction
      target/ppc: larx/stcx generation need only apply DEF_MEMOP() once
      target/ppc: Remove redundant MEMOP_GET_SIZE macro
      target/ppc: Make checkstop actually stop the system
      target/ppc: improve checkstop logging
      target/ppc: Implement attn instruction on BookS 64-bit processors
      target/ppc: BookE DECAR SPR is 32-bit
      target/ppc: Add PPR32 SPR
      target/ppc: add helper to write per-LPAR SPRs
      target/ppc: Add SMT support to simple SPRs
      target/ppc: Add SMT support to PTCR SPR
      target/ppc: Implement LDBAR, TTR SPRs
      target/ppc: Implement SPRC/SPRD SPRs
      target/ppc: add SMT support to msgsnd broadcast

 accel/tcg/cputlb.c                             |  145 +--
 docs/devel/multi-thread-tcg.rst                |   13 +-
 hw/ppc/pegasos2.c                              |    3 +-
 hw/ppc/spapr.c                                 |   28 +
 include/exec/exec-all.h                        |   97 +-
 target/ppc/cpu.h                               |   64 +-
 target/ppc/cpu_init.c                          |  235 +++--
 target/ppc/excp_helper.c                       |  134 ++-
 target/ppc/fpu_helper.c                        |  235 ++---
 target/ppc/helper.h                            |   98 +-
 target/ppc/helper_regs.c                       |   40 +-
 target/ppc/insn32.decode                       |  204 ++++
 target/ppc/int_helper.c                        |   24 +-
 target/ppc/internal.h                          |   40 +-
 target/ppc/kvm.c                               |    4 +-
 target/ppc/machine.c                           |   23 +-
 target/ppc/mem_helper.c                        |   12 +-
 target/ppc/meson.build                         |    1 +
 target/ppc/misc_helper.c                       |  132 ++-
 target/ppc/mmu-book3s-v3.h                     |    4 +-
 target/ppc/mmu-booke.c                         |  531 +++++++++++
 target/ppc/mmu-booke.h                         |   17 +
 target/ppc/mmu-hash32.c                        |   60 +-
 target/ppc/mmu-hash32.h                        |   45 +
 target/ppc/mmu-hash64.c                        |   18 +-
 target/ppc/mmu-radix64.c                       |    9 +-
 target/ppc/mmu_common.c                        | 1197 ++++++------------------
 target/ppc/mmu_helper.c                        |   39 +-
 target/ppc/power8-pmu-regs.c.inc               |    5 +
 target/ppc/power8-pmu.c                        |   48 +-
 target/ppc/power8-pmu.h                        |   11 +-
 target/ppc/spr_common.h                        |    8 +
 target/ppc/translate.c                         | 1151 ++++-------------------
 target/ppc/translate/bhrb-impl.c.inc           |   43 +
 target/ppc/translate/branch-impl.c.inc         |    2 +-
 target/ppc/translate/fixedpoint-impl.c.inc     |  727 ++++++++++++++
 target/ppc/translate/fp-impl.c.inc             |  285 +++---
 target/ppc/translate/fp-ops.c.inc              |   31 -
 target/ppc/translate/misc-impl.c.inc           |  157 ++++
 target/ppc/translate/processor-ctrl-impl.c.inc |    2 +-
 target/ppc/translate/storage-ctrl-impl.c.inc   |    7 +
 target/ppc/translate/vmx-impl.c.inc            |  280 +++---
 target/ppc/translate/vmx-ops.c.inc             |   50 -
 43 files changed, 3267 insertions(+), 2992 deletions(-)
 create mode 100644 target/ppc/mmu-booke.c
 create mode 100644 target/ppc/mmu-booke.h
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc
 create mode 100644 target/ppc/translate/misc-impl.c.inc

