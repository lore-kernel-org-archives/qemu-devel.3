Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KA-0008Us-8W; Thu, 11 Jul 2024 18:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2K8-0008QY-Jm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2K4-0001Xx-Ns
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:36 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb70169c23so12917535ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737089; x=1721341889;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b2LBHzUB+M4+Ob4GdEpbzyxHA1M8Stm/hPiEIghkEBA=;
 b=q2+FkHn03+OTl7tzAL8mAWRx98J7cKDFZLXe+MGn4P8r+662RMRliRtwkdAGKRHwxk
 +G6d/7aExls0SIsqdtwpmdmVvPFDqpoVk8YYf/lYdR9ENy2m/pIC2I8BkhK/npRpSsY2
 J4pRrSynxQIBfam1DKWfRZV0WYr9QktKxfugxFibzqbqBz9NzB1bJkoxpARjtkm92mYm
 3t/1yDK67W6ZhjFUuGdLYvCKO1kPdMkQcde9eUFELLrILZopdxaV3vo3vGxX0/885O6o
 ohYiSECtT8v9T0jUzsuYk2aD7zp560WYQVoxxxa063eh3GDg1rLNPiDTqy7HrkB/9NRZ
 G4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737089; x=1721341889;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2LBHzUB+M4+Ob4GdEpbzyxHA1M8Stm/hPiEIghkEBA=;
 b=Mg6lHJ0mBdkWpvE7rdhZ+sQ3/ITgAmAr8p8TvhXnJph73HEJh3RM2bHvBd8XXqVT5N
 AxQRI3tZ3uvgUjIb9XP8XdUi+0TeuY6iCN7RUKkoBDyEecSTMwJuUGKfiCnisn4wNjSO
 t0uTiKUCB2DbhgpGocJGF9UZl1Mv1Y6wmoILDWGw7fYfbQVxlN4jmv0wamDujbCaFAE/
 Xk5FBy/3o3NtNXK4HuPc7qu1iofr8hN+zFDcZWpv6HInk/G4etyndqOXZPh9LMKBpFDZ
 94n7svah6tySwmjQyfZqa0otphDTey/JWmvOYH1Kb0eJHyP8crRBeIJavcx0J9qtGEvP
 z7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzZuDOI22dGTp2R3s3Fff4MN2V18nH4Mx+NTFE6n1R/YHucRFCgw+UNqqwPTicDTdWy77cUk2cxWgb+LHyesNS9wZHLjQ=
X-Gm-Message-State: AOJu0YzdAsKscgOCEv/10Yxm2fmSVRsFsEzpzE1nmha5Mb7KF6LcCGMw
 Y+ufFIVtp4DbTfwoQnWiR36SiSH33GrZxWB40mPjw0ptH2SATnms5IWMPhGDcfA=
X-Google-Smtp-Source: AGHT+IGgj3RjEydsJIb1phlyWzQvaVR2EMEaYSPahOwWaq5jEyTzoMF+x39WG/iPaGHF7F4wspiG8Q==
X-Received: by 2002:a17:903:2349:b0:1f6:89b1:a419 with SMTP id
 d9443c01a7336-1fbb6d03db7mr77070105ad.17.1720737089428; 
 Thu, 11 Jul 2024 15:31:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:29 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 00/13] Add RISC-V ISA extension smcntrpmf support
Date: Thu, 11 Jul 2024 15:31:03 -0700
Message-Id: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACddkGYC/3WMywrCMBBFf6XM2kgStdGu/A8pkqedRZOSKUEp+
 Xdj98LdnAvnbEA+oycYug2yL0iYYoProQM76fjyDF1jkFyeeS97RrONa17m8CyKnYxUFyecFkJ
 BU5bsA7733GNsPCGtKX/2elG/90+ojTNjeBBcBxX07Z6xJMJojzbNMNZav7lH+HKrAAAA
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series adds the support for RISC-V ISA extension smcntrpmf (cycle and
privilege mode filtering) [1]. It is based on Kevin's earlier work but improves
it by actually implement privilege mode filtering by tracking the privilege
mode switches. This enables the privilege mode filtering for mhpmcounters as
well. However, Smcntrpmf/Sscofpmf must be enabled to leverage this.

The series is also available at [2] as well.

Changes in v8:
- Moved the config option to a separate patch at the end of the series.  
- Fixed a comments recieved in v7 around setting INH bit based on available priv modes.
- Updated the RB/AB tags.
- Link to v7: https://lore.kernel.org/r/20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com

Changes from v6->v7:
1. Fixed a compilation issue.

Changes from v5->v6:
1. Rebased on top of alister/riscv-to-apply.next (c50aabe132) and icount fix
   patch[4] which may cause conflicts.
2. Fixed a bug in pmf logic related to VS<->HS transition and same mode
   recording.
3. Merged assorted fixes PR as the changes are intertwined. [2]
4. Fix counter inhibit CSR behavior. This change now start counters from both
   mhpmcounter and mcountinhibit writes. Previously cycle/inst timer was
   only started on mhpmcounterx write.
5. Optimized the PMU timer setup code.

Changes from v4->v5:
1. Rebased on top of master(158a054c4d1a).
2. Fixed a bug for VS<->HS transition.

Changes from v3->v4:
1. Fixed the ordering of the ISA extension names in isa_edata_arr.
2. Added RB tags.

Changes from v2->v3:
1. Fixed the rebasing error in PATCH2.
2. Added RB tags.
3. Addressed other review comments.

Changes from v1->v2:
1. Implemented actual mode filtering for both icount and host ticks mode.
1. Addressed comments in v1.
2. Added Kevin's personal email address.

[1] https://github.com/riscv/riscv-smcntrpmf
[2] https://github.com/atishp04/qemu/tree/b4/smcntrpmf_v7
[3] https://lore.kernel.org/all/20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com/
[4] https://lore.kernel.org/qemu-riscv/20240618112649.76683-1-cleger@rivosinc.com/

Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (7):
      target/riscv: Fix the predicate functions for mhpmeventhX CSRs
      target/riscv: Only set INH fields if priv mode is available
      target/riscv: Implement privilege mode filtering for cycle/instret
      target/riscv: Save counter values during countinhibit update
      target/riscv: Enforce WARL behavior for scounteren/hcounteren
      target/riscv: Do not setup pmu timer if OF is disabled
      target/riscv: Expose the Smcntrpmf config

Kaiwen Xue (3):
      target/riscv: Add cycle & instret privilege mode filtering properties
      target/riscv: Add cycle & instret privilege mode filtering definitions
      target/riscv: Add cycle & instret privilege mode filtering support

Rajnesh Kanwal (3):
      target/riscv: Combine set_mode and set_virt functions.
      target/riscv: Start counters from both mhpmcounter and mcountinhibit
      target/riscv: More accurately model priv mode filtering.

 target/riscv/cpu.c        |   2 +
 target/riscv/cpu.h        |  20 ++-
 target/riscv/cpu_bits.h   |  41 +++++
 target/riscv/cpu_cfg.h    |   1 +
 target/riscv/cpu_helper.c |  66 +++----
 target/riscv/csr.c        | 437 +++++++++++++++++++++++++++++++++++++---------
 target/riscv/machine.c    |   5 +-
 target/riscv/op_helper.c  |  17 +-
 target/riscv/pmu.c        | 181 +++++++++++++++++--
 target/riscv/pmu.h        |   4 +
 10 files changed, 624 insertions(+), 150 deletions(-)
---
base-commit: 842a3d79a0e37cd3d685c4728308fac0d9bfd0bb
change-id: 20240626-smcntrpmf_v7-3b275d1da117
--
Regards,
Atish patra


