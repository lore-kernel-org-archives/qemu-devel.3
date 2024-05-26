Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC9C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxN-0006AX-9I; Sun, 26 May 2024 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxG-00069O-DN; Sun, 26 May 2024 08:26:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxE-0001EN-Jy; Sun, 26 May 2024 08:26:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ab6so5326210b3a.1; 
 Sun, 26 May 2024 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726381; x=1717331181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Y9K86eaza8n69VqaT5kltyaM/ckXT69/cZ7A6NdRZY=;
 b=d4nCR/GhVsXqgZJ4U/PGrTlaslHpDJldGVc9VxY0mMNpmU+wROVpJ5W+chXeTpDGQ7
 EAdZFFB2YgNgZ7WK/3oq15LWDdkZFHqzhnVNL+QwzSkxFem/+xrEBJvLo5s5ThVw077B
 lmiq1YUplQ2QMeiTk42QCj58PR3lYDpRpagDr9McvoOBnbIDD0nlTGYMc0aVa81whUCv
 lLhN53G1ZbeYkEkTJ1ec0+o72WSFwLujR3/LbkfAzgsrJeAPsVAqQwTdFw7qVvJt7YwW
 KGCuElV6gMh6PqYXbzCk5J+i0NbSPBcCJ9EBHG1U6e9kcMiPv4ndez/WyHtprJpJ3i1/
 jTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726381; x=1717331181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Y9K86eaza8n69VqaT5kltyaM/ckXT69/cZ7A6NdRZY=;
 b=KUHkcn27ferVgP7zB7rchtbJ4yXgfx1c8rSP0stoQcmGI8Qz6z/Q9GqHpMaV3ULoAM
 9r6COcD4YH92Zd9JvzrvEuKGxvgI2cfNIGm7pnqqrLG8Z3/tfnC+dl3g0qW0nqPuMgIp
 nZIYIfTEReOBzxEdY12fAQxv+DULQK/j7cVSIAyM/ckM0D4acwXS6nWOSmDXckqPZ+k5
 L2VOqdk2c7C8MkFDD5dIF+t5+nAkGtunAaj7k8AEpjc70y+nKU/0c4MntOfN0tn/CoWl
 oacq4+1IbMCotuwj18iVxoA68TzwG44L0qVLB/hkwYoWNxfmtFTwdummbvKd0HhRmO+C
 lVZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4vbjHvCKgcrfdYfqCrcoWMLhcWm4RZTBajHgUxbvjcg4Pg2j4e3P/AXahtAYNjSx9WnDTFdJ1psIUCyD1CTxZFXh9JGA=
X-Gm-Message-State: AOJu0YxuVfG6qcMvW7JeRTsgYTIShbsDtd9aGyWJMutoqINtwgsCj9kv
 bD8G8hbttnSOlGke3sjku5MKuvtzFtG7bhAclQ3avPiYUl1OHmebPHc46A==
X-Google-Smtp-Source: AGHT+IHXAC1YUnnQyIr30OQxhqXtFHTuCrRW2P7urMvDm2BCCmLUp/43/RGMMNqRaY2pd/bUgzdn5A==
X-Received: by 2002:a05:6a00:368a:b0:6ed:6a76:d54 with SMTP id
 d2e1a72fcca58-6f8f2c57500mr6662278b3a.4.1716726380463; 
 Sun, 26 May 2024 05:26:20 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 00/10] ppc/pnv: Better big-core model, lpar-per-core,
 PC unit
Date: Sun, 26 May 2024 22:26:01 +1000
Message-ID: <20240526122612.473476-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Primary motivation for this series is to improve big-core support.
Other things like SPR indirect, timebase state, PC xscom, are required
for minimal big core support.

I'm still not 100% happy with the big-core topology model after this.
Maybe one day we add pnv big core and pnv small core structures. But
nothing is completely clean because big core mode still has certain
small core restrictions. I think for now we take a bit of mostly
abstracted ugliness in TCG code for the benefit of not spreading
hacks through pervasive (xscom) core addressing.

After this series, power9 and power10 get through skiboot/Linux boot
in SMT8 big-core mode. Not all big core registers are modeled
exactly (some are not shared between small core halves), but that
mostly doesn't matter for OPAL and it can be improved later.

Thanks,
Nick

Nicholas Piggin (10):
  ppc/pnv: Add pointer from PnvCPUState to PnvCore
  ppc/pnv: Move timebase state into PnvCore
  target/ppc: Improve SPR indirect registers
  ppc/pnv: specialise init for powernv8/9/10 machines
  ppc/pnv: Extend chip_pir class method to TIR as well
  ppc: Add a core_index to CPUPPCState for SMT vCPUs
  target/ppc: Add helpers to check for SMT sibling threads
  ppc/pnv: Invert the design for big-core machine modelling
  ppc/pnv: Implement POWER10 PC xscom registers for direct controls
  ppc/pnv: Add an LPAR per core machine option

 include/hw/core/cpu.h        |   8 +
 include/hw/ppc/pnv.h         |   6 +
 include/hw/ppc/pnv_chip.h    |   3 +-
 include/hw/ppc/pnv_core.h    |  31 ++++
 target/ppc/cpu.h             |  37 ++---
 hw/ppc/pnv.c                 | 297 ++++++++++++++++++++++++++++-------
 hw/ppc/pnv_chiptod.c         |   6 +-
 hw/ppc/pnv_core.c            | 129 +++++++++++++--
 hw/ppc/spapr_cpu_core.c      |   7 +
 system/cpus.c                |  10 ++
 target/ppc/cpu_init.c        |  26 +--
 target/ppc/excp_helper.c     |  16 +-
 target/ppc/misc_helper.c     |  98 ++++++------
 target/ppc/timebase_helper.c |  82 +++++-----
 14 files changed, 548 insertions(+), 208 deletions(-)

-- 
2.43.0


