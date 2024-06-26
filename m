Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90710C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWA-0007iL-OX; Wed, 26 Jun 2024 19:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcW8-0007hJ-8T
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcW6-0005VD-8Y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:36 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1faad409ca7so155105ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446252; x=1720051052;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4YjAQAZatoK5hzSHjG2ua+nUCbPXv9SsnYImB9DeAGg=;
 b=FxDzs+laaJ76x5NCPABe1KZMH6/3pWVSX8QDJdeh3a5Tq5Nutg52+BLfiXzBgoDmP1
 eEVKwHqcJGEzMvvBQ+AnubgXVcXSyRvfWRSx8UPKT4s4bZfzQpJHPXbTeQFVfit9Hjrd
 s1JmMqEFQrLRuB3waQ+XtAwWGXU6pUVc6lbSLFAiaS9UBV6GvbX3YKFD5+k2r/TDPEDt
 dZIQqo3hq/P90ygCoOVIduLU1RnksH5smJOKtE/pxgMqldiw2DrFpf9RON+HUyJ4+F//
 tIXuWcVhjhSDU02qTDg7/vLTJmm432Tz5XT9UeDClsjdMaiqjVX57LrtdoiyDo+4z38N
 0d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446252; x=1720051052;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YjAQAZatoK5hzSHjG2ua+nUCbPXv9SsnYImB9DeAGg=;
 b=cy8Twzpa8w6rB2K2hOIOPU8Mhs9vzo41WnwURz2HkBNgg1vEZfMa3XSrZ9kAh9Lu8a
 id/Q+x0w1DQeXbv2j/GRFPinwqOEcxjNZBYPh7YhuHx8/VI/hw1+k2QGO1E25qt4Gyee
 gCa8XT0syqceYasICEeVRUXf0YE5lpbEZ+UkXGKwnIdnrddGDt5SaAY0d8Y7nbpYC2Jf
 +lvRrg8oVAYt2k004yQDjgV4tN+HbeI9OPMJRtdRLJ6gNVHjI456iN+2SJVF8L55pR8U
 LHkFIQMA+XYB0lgOrMyUEnp0I1hXqxO6IpiAZC/KZPWezQuR6aMFbk9liN1osz56zq0M
 vq4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdbESJIiZTVlKMax9zcFKbVbF9UkD3fvu1fQe/fi7+VMA1mDdVH6vl0hSxGNgMu2dDLvD/vED2UjQxJu4qcEWZIMNF370=
X-Gm-Message-State: AOJu0Yxj3YYtpGWP/imWXVoNQOgmy21llnJIX1gLNcCCG+DB1XM7Nkl3
 wm/LT5ORKw5WG330QLNEkJDmqjyyCCddN3iVfQWdKPe3ijkHNLtYpXIMA5mE4Ss=
X-Google-Smtp-Source: AGHT+IHMANqiDLkbypi15KiX8LPaMwS0oQfP02Kg/bcsOPFzZECvOT+KZ/eI6Adi7bo2JKioJGvJQA==
X-Received: by 2002:a17:902:ce92:b0:1f9:f521:6457 with SMTP id
 d9443c01a7336-1faac2e6072mr3613625ad.34.1719446252026; 
 Wed, 26 Jun 2024 16:57:32 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:31 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v7 00/11] Add RISC-V ISA extension smcntrpmf support
Date: Wed, 26 Jun 2024 16:57:20 -0700
Message-Id: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCqfGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMz3eLc5LySooLctPgyc13jJCNz0xTDlERDQ3MloJaCotS0zAqwcdG
 xtbUAoqthLF4AAAA=
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x630.google.com
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
Atish Patra (5):
      target/riscv: Fix the predicate functions for mhpmeventhX CSRs
      target/riscv: Implement privilege mode filtering for cycle/instret
      target/riscv: Save counter values during countinhibit update
      target/riscv: Enforce WARL behavior for scounteren/hcounteren
      target/riscv: Do not setup pmu timer if OF is disabled

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
 target/riscv/cpu_bits.h   |  34 +++++
 target/riscv/cpu_cfg.h    |   1 +
 target/riscv/cpu_helper.c |  66 +++++----
 target/riscv/csr.c        | 358 +++++++++++++++++++++++++++++++++++-----------
 target/riscv/machine.c    |   5 +-
 target/riscv/op_helper.c  |  17 +--
 target/riscv/pmu.c        | 181 ++++++++++++++++++++---
 target/riscv/pmu.h        |   4 +
 10 files changed, 543 insertions(+), 145 deletions(-)
---
base-commit: 842a3d79a0e37cd3d685c4728308fac0d9bfd0bb
change-id: 20240626-smcntrpmf_v7-3b275d1da117
--
Regards,
Atish patra


