Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46FAC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEzP-0003LI-Iu; Fri, 12 Jul 2024 08:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzN-0003Ce-9G; Fri, 12 Jul 2024 08:03:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzL-0005Iu-6s; Fri, 12 Jul 2024 08:03:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so334134b3a.3; 
 Fri, 12 Jul 2024 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785777; x=1721390577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WB7MLAdG0ItGWTgR3PSauNpTsxPnaD06YYrEKfLw9v4=;
 b=RaD4bJJFx/N63H5OV3VmB64y4ZO5IA0IwrZYEF5FN5SuoF3bJX6tTY9jV6C+Spg8t0
 75ijmrpRryi6peRxn9VrdGuC5h4Ijm3t/r0DU5dff7i4qgeV6eGwTMGn2Gp0H/0kp53o
 P0miGIyIl+mAV0aOPwLZsx9Tz29+qqQ72WquRVsv/OPF9fGlPuYFMAabASSDmstU30bS
 ZIqTXeiL80vHmOwZFQxCGfC0zN05JWabvrJmu4/+MRlrTcUvodakNb6mC4YaMQ7gFO2w
 4GR9dw/9aXS+u9tjXsu8wNKYbvXSOwNrGYKlmrWvE/uPyD4ROXmK9j8LY4OkmiJ+gUCy
 UtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785777; x=1721390577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WB7MLAdG0ItGWTgR3PSauNpTsxPnaD06YYrEKfLw9v4=;
 b=HCL87y/HKLEWhZE8Tw0WxPCO/aVqZbAyZGTjaVKEDwjdWZ5LNAuW9b+vdB3fBZ5PED
 Y6eCxJxZP9D1MKlbHZCYTOwstJk8lIhbwrtCUpXHru4NQAruMCqlg83hewxaMRVfAvqe
 p6GcG3wU+fTnOKHYwss7AP1EG9ezHA+7P+imVonRfBdOtqBRqR+MDcbyb3VCQY0HqdlK
 IAlEb4QaswmPEmN5yH0QHHoEsleul5vZ65UC6EGPR4tryLHQfcLiMQ0clUTGMSTpixvc
 jhfkt7aecQd3mOp2GM0mCfYfy8wxJkQ0G2tcjO1V1qs68gY2xvGjo6XYoW5bXLrkQpNM
 cAEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOtW4mDVMwEJnu2YsqlCb8wWVoEc42Xg8BHgW5SyRlGrSbzcjqmo+LIChcg/Os4O8xVKiqn0Dcrbq1v1ycZnmesUMAk2Q=
X-Gm-Message-State: AOJu0YyjHBv9qOScFvI05h/LnG3+1K82KRUmYm9C934byvpS8QB7tskP
 XtwEmK/iyGqaq26lN83hKG3mAknMn35PKWSa6Ug64r85PUXUxCPzGHNFTA==
X-Google-Smtp-Source: AGHT+IGFdxg1bNuJGlwhS+4wbHc+D4/ihdJahGzGmmuBcgS4a9ch1b/ejGwNutK3nWH9YH1bHfJ0GA==
X-Received: by 2002:a05:6a20:734b:b0:1c0:f675:ed08 with SMTP id
 adf61e73a8af0-1c29820b27bmr14047019637.6.1720785776569; 
 Fri, 12 Jul 2024 05:02:56 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:02:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 00/19] ppc/pnv: Better big-core model, lpar-per-core,
 PC unit
Date: Fri, 12 Jul 2024 22:02:27 +1000
Message-ID: <20240712120247.477133-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Primary motivation for this series is to improve big-core support.

This also fixes POWER8 SMT running Linux with the msgsnd fix and
setting lpar-per-core mode (which is always true on POWER8).

Since v1:
- Remove chip->pnv_machine pointer addition.
- Split cpu_pause() function into its own patch.
- Remove the _CORE_ID macro.
- Add has_lpar_per_thread machine class attribute to
  initialize the lpar mode to per-core on POWER8 machines
  instead of testing presence of machine state property.

Since rfc:
- Fixed POWER8 SMT so it doesn't have to be disabled.
- Fixed inadvertent spapr SMT bug.
- Renamed PnvCPUState.core pointer to pnv_core. (Harsh)
- Moved where it is initialised (clg)
- Avoided most qdev_get_machine() calls by adding a PnvMachineState
  pointer from PnvChip, new patch 3 (clg).
- Rename TB state to use camel case (Harsh and clg)
- Add comment to explain SPRC/SPRD is only accessed with powernv.
- Use mc->desc for error messages and avoid splitting machine init
  handlers (Harsh).
- Add max_smt_threads class attribute to avoid duplicating checks (clg)
- Rename processor_id() class method to get_pir_tir (Harsh and clg)
- Add a comment for get_pir_tir() (clg)
- Allow get_pir_tir() to be passed NULL pointers to avoid dummy
  pir/tir variables (Harsh)
- Move the PPC_CPU_HAS_CORE_SIBLINGS macros to inline functions (clg)
- Invert them (test for single-thread rather than for siblings)
  because the callers read a little better that way (Harsh).
- Propagate lpar and big-core options down to chip and core
  levels rather than having to test machine (clg)
- Significantly split the big-core patch (clg).
- Rework big-core device-tree handling to simplify it (clg).
- Make new has_smt_siblings property bool (Harsh)
- Make the big-core timebase tod quirk a machine class property
  rather than machine state (Harsh).

Thanks,
Nick

Nicholas Piggin (19):
  target/ppc: Fix msgsnd for POWER8
  ppc/pnv: Add pointer from PnvCPUState to PnvCore
  ppc/pnv: Move timebase state into PnvCore
  target/ppc: Move SPR indirect registers into PnvCore
  ppc/pnv: use class attribute to limit SMT threads for different
    machines
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
  system/cpus: Add cpu_pause() function
  ppc/pnv: Add a CPU nmi and resume function
  ppc/pnv: Implement POWER10 PC xscom registers for direct controls
  ppc/pnv: Add an LPAR per core machine option

 include/hw/core/cpu.h        |   8 +
 include/hw/ppc/pnv.h         |   8 +
 include/hw/ppc/pnv_chip.h    |   6 +-
 include/hw/ppc/pnv_core.h    |  31 ++++
 target/ppc/cpu.h             |  45 ++----
 hw/ppc/pnv.c                 | 305 ++++++++++++++++++++++++++++-------
 hw/ppc/pnv_chiptod.c         |   7 +-
 hw/ppc/pnv_core.c            | 125 ++++++++++++--
 hw/ppc/spapr_cpu_core.c      |  16 +-
 system/cpus.c                |  30 ++--
 target/ppc/cpu_init.c        |  26 +--
 target/ppc/excp_helper.c     |  69 ++++----
 target/ppc/misc_helper.c     | 104 ++++++------
 target/ppc/timebase_helper.c |  82 +++++-----
 14 files changed, 612 insertions(+), 250 deletions(-)

-- 
2.45.1


