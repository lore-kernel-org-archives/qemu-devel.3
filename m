Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C1C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TG-0004Zi-2z; Tue, 12 Mar 2024 12:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5T3-0004WO-Kf; Tue, 12 Mar 2024 12:59:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5T1-0007uI-Lw; Tue, 12 Mar 2024 12:59:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e649a2548cso4017740b3a.3; 
 Tue, 12 Mar 2024 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262745; x=1710867545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vB/tXVL4GK4kgvODQSwg7p24l5SVJznS/b4/tkZTlvg=;
 b=Adf12ePbQ09tLR57qnDQIYgBAAj+ebLMb1FxjDt3jwXIPFVW/cZ3TI1g8vbcbbDRiZ
 ka170oWve+5iFG+TarzYfT2LhVJL2V1Rhk4aDoYHATAEdw/6cLWgSBzCEr6n9oY5pDt4
 IweheLuzos59qPdzqFbZ/Huk6bK33LW//RmvPDV1NPz5qJ+hB5qThF+RWoS6KnuRUT3r
 02qMn+/jYJDFGXvJSwmr7bc9XsKP7Gbr9L80bwIQmZVP9a5hBhLdib2wwkMkzhvJC0rz
 fQ2xSMABSdENYU5tE5j+tQe6DRyFUtzQ7D1vJTLpbGOdmiog2dkw4+fyYn4SwIMLr2L2
 O5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262745; x=1710867545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vB/tXVL4GK4kgvODQSwg7p24l5SVJznS/b4/tkZTlvg=;
 b=Nv+CzxlrowcEsbAYDNQSKQvBI+0eXInGaFFjq/2hsnehOOjs9A40EreAbacjQbXsTH
 /6txIdiZflTJij9YckrAWLEBJDM12iH3bhlTuw9TW+ktjJwMZKkNyGkQJsTCS1Os+aIm
 s9LC6ReK4/bGWZB7IaJWklkVT4qb4sB8CcYZnJYcxMtLmWBI4yqTbrDixjE7PbEKXf6x
 TPaJRUZZLrTG+B2WuGlKRebTPp53ruMDfjFKhzwr97rfd36SYHBkBzyVJmZ7iKlBUU31
 pA1x/FSDRj659bb9eli0ehR5ATpIHeoaXNZX3misrlV+gMLNoJtgW/pTsCI0Leb3j1HJ
 684g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIyWjFDsqllmkfOUz5fY5cyt1ARNSEcQ2tGF6KiUagV+CqTI8MeAWwqoLWcUwJzQaSsauDyAGhAQyh0OkTLqG2h0e+
X-Gm-Message-State: AOJu0YwjFtz6huhw8sDWxNPJaMS8KWiG7MdXAE1xUMomwH++7G5vCLkW
 FzSsYFOLL5dOczTtZ4jq9/cVly5Mm8stCeCD9x08LfI5U1OQJR8PW+gMDDVeONw=
X-Google-Smtp-Source: AGHT+IE4TfgGYa3uXa7dlDTsogiB3zGs2t1hjj3KJjmRoLpTMjQxjxSAJnb2u8aEI1eM0h8Ky5ShYQ==
X-Received: by 2002:a05:6a20:9c8e:b0:1a3:1b95:7cf with SMTP id
 mj14-20020a056a209c8e00b001a31b9507cfmr992569pzb.56.1710262744505; 
 Tue, 12 Mar 2024 09:59:04 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 00/38] ppc-for-9.0-2 queue
Date: Wed, 13 Mar 2024 02:58:11 +1000
Message-ID: <20240312165851.2240242-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 35ac6831d98e18e2c78c85c93e3a6ca1f1ae3e58:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-03-12 13:42:57 +0000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-2-20240313

for you to fetch changes up to e1617b845104032f0aaad9b91dcda56c7c437998:

  spapr: nested: Introduce cap-nested-papr for Nested PAPR API (2024-03-13 02:47:04 +1000)

----------------------------------------------------------------
* PAPR nested hypervisor host implementation for spapr TCG
* excp_helper.c code cleanups and improvements
* Move more ops to decodetree
* Deprecate pseries-2.12 machines and P9 and P10 DD1.0 CPUs
* Document running Linux on AmigaNG
* Update dt feature advertising POWER CPUs.
* Add P10 PMU SPRs
* Improve pnv topology calculation for SMT8 CPUs.
* Various bug fixes.

----------------------------------------------------------------
BALATON Zoltan (8):
      docs/system/ppc: Document running Linux on AmigaNG machines
      target/ppc: Use env_cpu for cpu_abort in excp_helper
      target/ppc: Readability improvements in exception handlers
      target/ppc: Add gen_exception_err_nip() function
      target/ppc: Clean up ifdefs in excp_helper.c, part 1
      target/ppc: Clean up ifdefs in excp_helper.c, part 2
      target/ppc: Clean up ifdefs in excp_helper.c, part 3
      target/ppc: Remove interrupt handler wrapper functions

Benjamin Gray (1):
      ppc/spapr: Add pa-features for POWER10 machines

Caleb Schlossin (1):
      ppc/pnv: Improve pervasive topology calculation for big-core

Chinmay Rath (1):
      target/ppc: Move add and subf type fixed-point arithmetic instructions to decodetree

Cédric Le Goater (1):
      MAINTAINERS: Remove myself as reviewer from PPC

Harsh Prateek Bora (14):
      spapr: nested: register nested-hv api hcalls only for cap-nested-hv
      spapr: nested: move nested part of spapr_get_pate into spapr_nested.c
      spapr: nested: Introduce SpaprMachineStateNested to store related info.
      spapr: nested: keep nested-hv related code restricted to its API.
      spapr: nested: Document Nested PAPR API
      spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls.
      spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
      spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
      spapr: nested: Extend nested_ppc_state for nested PAPR API
      spapr: nested: Initialize the GSB elements lookup table.
      spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
      spapr: nested: Use correct source for parttbl info for nested PAPR API.
      spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
      spapr: nested: Introduce cap-nested-papr for Nested PAPR API

Madhavan Srinivasan (1):
      target/ppc: Add power10 pmu SPRs

Nicholas Piggin (10):
      target/ppc: Fix GDB SPR regnum indexing
      target/ppc: Prevent supervisor from modifying MSR[ME]
      spapr: set MSR[ME] and MSR[FP] on client entry
      ppc: Drop support for POWER9 and POWER10 DD1 chips
      target/ppc: POWER10 does not have transactional memory
      ppc/spapr|pnv: Remove SAO from pa-features
      ppc/spapr: Remove copy-paste from pa-features
      ppc/spapr: Adjust ibm,pa-features for POWER9
      ppc/pnv: Permit ibm,pa-features set per machine variant
      ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits

Philippe Mathieu-Daudé (1):
      docs: Deprecate the pseries-2.12 machines

 MAINTAINERS                                |    4 +-
 docs/about/deprecated.rst                  |    6 +-
 docs/devel/nested-papr.txt                 |  119 +++
 docs/system/ppc/amigang.rst                |  161 +++
 docs/system/target-ppc.rst                 |    1 +
 hw/ppc/pnv.c                               |  175 +++-
 hw/ppc/pnv_core.c                          |    8 +-
 hw/ppc/ppc.c                               |   10 +
 hw/ppc/spapr.c                             |   98 +-
 hw/ppc/spapr_caps.c                        |   54 +
 hw/ppc/spapr_cpu_core.c                    |    8 +-
 hw/ppc/spapr_hcall.c                       |   24 +-
 hw/ppc/spapr_nested.c                      | 1556 +++++++++++++++++++++++++++-
 include/hw/ppc/pnv_chip.h                  |    2 +-
 include/hw/ppc/pnv_core.h                  |    1 +
 include/hw/ppc/spapr.h                     |   27 +-
 include/hw/ppc/spapr_nested.h              |  427 +++++++-
 target/ppc/cpu-models.c                    |    4 -
 target/ppc/cpu.h                           |   11 +
 target/ppc/cpu_init.c                      |   46 +-
 target/ppc/excp_helper.c                   |  418 +++-----
 target/ppc/gdbstub.c                       |    7 +-
 target/ppc/helper_regs.c                   |    5 +
 target/ppc/insn32.decode                   |   26 +
 target/ppc/kvm.c                           |   11 -
 target/ppc/misc_helper.c                   |    3 -
 target/ppc/translate.c                     |  164 +--
 target/ppc/translate/fixedpoint-impl.c.inc |   70 ++
 28 files changed, 2883 insertions(+), 563 deletions(-)
 create mode 100644 docs/devel/nested-papr.txt
 create mode 100644 docs/system/ppc/amigang.rst

