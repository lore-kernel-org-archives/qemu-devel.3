Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC12C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRudX-0002MV-Dr; Thu, 11 Jul 2024 10:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudV-0002LB-I5; Thu, 11 Jul 2024 10:19:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudT-0005R8-Mh; Thu, 11 Jul 2024 10:19:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70b0d0fefe3so759965b3a.2; 
 Thu, 11 Jul 2024 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707540; x=1721312340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d70wc5OTA4tdMq49ZHzVvhT23or2XFkGKYQjwNGkYuY=;
 b=mSIYT27ID4VysjRoiCOXTvqQryX7fvE1hvmq01+dZ16vUn557SFfEiCks1qtQYvYUS
 CS9PEv54uutTn/ZvBY1BymkoAl+lOMDKpM1U/72dSSbtfxRuOrV7/xpr+2ARTw2yjjO8
 ygz6SkgfBjg4bHygDj3YJ2nRcaKTXo/t5ndUAGWLmy+h50K2UrFs7I+BPeWNqt8l3sko
 lnHaBFiDWAfOdsg646JffGSDrzhu4mh1WR0HxVp45m8j94FhZuLtzk8en6FDqrj6SJz7
 +PxDQ9nqqWol435gIGsIZNNL97qN42Tz+IxP6vm8lm0wjem3yBUHIcUrUO771HVhOhdr
 JrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707540; x=1721312340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d70wc5OTA4tdMq49ZHzVvhT23or2XFkGKYQjwNGkYuY=;
 b=TCSjH7c3MRov0zo8bzOQterr2+ThpDnno2gSlVbT7hBg2RE5gM3sETAsS+IVI+EiRW
 Wa0QD6OP/Jq1gaFI+q9O7FXr0uciZgPOosQekt9QP97kKHF+cPbuvCmoEBlHv7VVUn3b
 C5Kkc8zUYE2BnAenKvQkB1/Ncv5bTVciC8qIuILCtsNxWmMdvLaFfvT4lIU/c6T/FJfO
 Jsf1pSvFZpQMP+/UzTb1Rw0s0sEnuZ7+znOmSPf4v4NT5mNZtAuFvMyNatQf2wenoXbi
 EdL5CM4hAQfBQlaPgQoII3DoztY7tCixjWvbgNwlOPoQd4XKNJDTem6ZF0oHwcikr3zP
 1ihQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCOrl9T/e2rY+nVHC3sHf52YZMou/EQ8XR3zrqRduLKNNHB0y8mhgR0HdmVAPM+2K8QNu9ma7SuDIaeU/Y5Y+gWgrt9Y4=
X-Gm-Message-State: AOJu0YzQYZTR6+fdR3y4vRPpDaQ93Oc8BSRcMSWx+IP2f95ij39Nlmqk
 0ZnmTkF3VKt+DqhLKCDMY375M5q3NR9vyZVBNF9BfLyhx8Ee29I5P2MVS0B8
X-Google-Smtp-Source: AGHT+IH/Fxh3R7lrCQGMft7hEwvXdNkgdMuqyBLqIcVQ7ju31kpJy9p033PwDgr2NBYVpjbywFlwtw==
X-Received: by 2002:a05:6a21:99a1:b0:1be:c2f7:275 with SMTP id
 adf61e73a8af0-1c2984c8768mr9373186637.50.1720707539505; 
 Thu, 11 Jul 2024 07:18:59 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:18:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 00/18] ppc/pnv: Better big-core model, lpar-per-core, PC unit
Date: Fri, 12 Jul 2024 00:18:32 +1000
Message-ID: <20240711141851.406677-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

I think I accounted for all feedback from Cedric and Harsh from the
last RFC (except a couple of style suggestions from Harsh).

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

Nicholas Piggin (18):
  target/ppc: Fix msgsnd for POWER8
  ppc/pnv: Add pointer from PnvCPUState to PnvCore
  ppc/pnv: Add a pointer from PnvChip to PnvMachineState
  ppc/pnv: Move timebase state into PnvCore
  target/ppc: Move SPR indirect registers into PnvCore
  ppc/pnv: specialise init for powernv8/9/10 machines
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
  ppc/pnv: Implement POWER10 PC xscom registers for direct controls
  ppc/pnv: Add an LPAR per core machine option

 include/hw/core/cpu.h        |   8 +
 include/hw/ppc/pnv.h         |   7 +
 include/hw/ppc/pnv_chip.h    |   6 +-
 include/hw/ppc/pnv_core.h    |  31 ++++
 target/ppc/cpu.h             |  41 ++---
 hw/ppc/pnv.c                 | 298 ++++++++++++++++++++++++++++-------
 hw/ppc/pnv_chiptod.c         |   7 +-
 hw/ppc/pnv_core.c            | 130 +++++++++++++--
 hw/ppc/spapr_cpu_core.c      |  16 +-
 system/cpus.c                |  10 ++
 target/ppc/cpu_init.c        |  26 +--
 target/ppc/excp_helper.c     |  69 ++++----
 target/ppc/misc_helper.c     | 104 ++++++------
 target/ppc/timebase_helper.c |  82 +++++-----
 14 files changed, 601 insertions(+), 234 deletions(-)

-- 
2.45.1


