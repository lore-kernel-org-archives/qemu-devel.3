Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DD6C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8R-00082o-J4; Sat, 15 Aug 2026 16:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8P-00081q-3T
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:41 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8N-00088o-8v
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:40 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so2257486a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826257; x=1787431057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZuciOKOCYHWBKlhHcQ1E1TSyVvA4vJCKA85h2XVJ3IY=;
 b=XGNuk6bYwSDP363ciVd8zdNZ61AVzo82MltR1HtdajajpcZPnopvHAoeKqh5XLMtkt
 OaZ3jOHVoQ6qQZSJgWMvuQ0Sfq5Jd4AiBT2NB/BmEAGS2eGzgEWZE9o5k9GFN3bhsbuu
 PPKYFHXu5MPOy/Hg+a5VL0PGe/Cfscni9rdxc+ICYRwiVQ7EvZEz6yeFdnEHinvRb2ob
 o8I11SYjoRIevernjUPtVKmYr1CIF0zTi6gvXnhdDbruu4QVUFU2FXfNqpnA+tOh1vh5
 8PXOxDTDajYYs28SKun1R9IrWtXT5DcRnOoaZ4lQk1E2fWDxOtld1DmUmUUSDi41ERXX
 JsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826257; x=1787431057;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZuciOKOCYHWBKlhHcQ1E1TSyVvA4vJCKA85h2XVJ3IY=;
 b=ZH+QorvA7wTy3mU5/gMRCLW24Gd5rnMP0XPG25RhBHQXOMtbnPd+ju2oWoRdNdXxfG
 nWfHPFAywF8wl09cI02NfI/tRNFbUJiM1C3NCwMFGBDLArTXw+KOsB0xkhkVzEhHYQDR
 x7G/yVfbKZUa8zO4zsCGn1daj26dTnOW0iRAO4M2kmx5wfukmUcFcQq/0Xm5ndXZdW8z
 75RTJYPbYEI0r5MftKdEzUFIdE0aZTmQP2OJcISV+ytgNQVFkadVDu78GqhQfHz/as+V
 EwUP60KExb9mPRN+r89tsURUy9LgvPj2W4RaS/buxiTiFs9FmbXA6MZtY5y+MOsG6Cq5
 vkRg==
X-Gm-Message-State: AOJu0YyhOPI5uPeAWPPSJh63ub9gfGJYvQdz2dcBUo+Ky0HyTvlImT8U
 8MiLvhDOdkBP7RUmMLe072vlg3AElSoL2Jlac97Wx0ac6z2Uf06mLFbO4FagYLynqvQMxgrYR0W
 0TGI+
X-Gm-Gg: AR+sD11cKFO4qlB29CJ1TwBw40aCT2xX1QKqfKePjLISv5vvIvvGejpdg3RRzYEiUtD
 u5g2nCRK2oaMQCs3vpcR3iUSVjqjoeBGfqH5l/3I7k0djbfXT9NBMCaZCXYYanYf/aTLeNLAxe1
 9NJDlrBM25g9pv219oEkT5MYGkZd3cGDRDcqnns6HX0UPPCGT1ZPbJ9bAT76ThoqWC5qB5cxdHZ
 ytD5P3XzXz3Err9wSWOyj8faFDE/hegHbK9M6tpV8AixVhsT+Zj3gjJr1fwA8gztsBj503oRsNS
 cEi3vTYxV1pbPNGQC7L5m9jRs4PpgqEJz3o7AJ1j9cY8U4kvqNwnIZFA4uyHbqyVdyjCrA35yjH
 En/Qxbq2k71dOK3AdHkLv/LpGlLUojJtIH8HzKi0UAFYrwAjici7NBDC6elpWCWPYRCGb0RDH7Z
 49V5pqBEDIDTZhxqnfqrPNKkKcl5vHskMbnl/u2FkiJKHCj25W+uvWTHBYKdeFQocSsy9DUdPEf
 ZuIRqDual3u8YylpVp5U2uSqiKJBxvq
X-Received: by 2002:a17:90b:3b8c:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-3933bd0c331mr15103998a91.19.1786826257323; 
 Sat, 15 Aug 2026 13:37:37 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 00/18] accel/tcg: Change tlb_fill/probe_access to (addr,
 first, last) tuple
Date: Sat, 15 Aug 2026 13:37:12 -0700
Message-ID: <20260815203730.1468365-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The driver for this RFC is
https://lore.kernel.org/qemu-devel/ce3a48b5-9847-4cc4-a02f-86db497c91ae@linaro.org/

Based-on: 20260815194549.1377505-1-richard.henderson@linaro.org
("[PATCH 00/23] target/riscv: Reorg vector load/store")

But also merged to master, so for avoidance of doubt:
https://gitlab.com/rth7680/qemu/-/commits/tcg-probe

Convert probe_access_full, probe_access_flags, and the backend tlb_fill
hooks, but not (yet) probe_access itself.  I'm less certain about that,
since its uses are (1) less complicated and (2) there's also a path,
which I can't prove isn't used but neither can I find, which avoids
both watchpoints and notdirty pages.

I've tweaked the riscv pmp check to use the new parameters.
The similar Armv8-M code is a bit more complicated to push through,
and I need to study it a bit more.

Thoughts?


r~


Richard Henderson (18):
  target/arm: Imply probe from allocation_tag_mem_probe
  target/arm: Simplify invalid page test in allocation_tag_mem_internal
  target/arm: Return struct from allocation_tag_mem_internal
  target/arm: Generalize probe argument to allocation_tag_mem_internal
  target/arm: Probe second page earlier in allocation_tag_mem_internal
  accel/tcg: Drop fault_size from user-only probe_access_internal
  accel/tcg: Replace size with first/last in probe_access_full
  accel/tcg: Replace size with first/last in probe_access_flags
  accel/tcg: Allow phost to be NULL in probe_access_flags
  accel/tcg: Replace size with first/last in probe_access_internal
  accel/tcg: Replace size with first/last in tlb_fill_align
  accel/tcg: Replace size with first/last in TCGCPUOps.tlb_fill*
  target/riscv: Move PMP_AMATCH_OFF check in pmp_hart_has_privs
  target/riscv: Return bool from pmp_is_in_range
  target/riscv: Use boolean logic in pmp_hart_has_privs
  target/riscv: Recognize watchpoints with first/last
  target/riscv: Pass first/last to get_physical_address_pmp
  target/riscv: Pass first/last to pmp_hart_has_privs

 include/accel/tcg/cpu-ops.h          |  16 +-
 include/accel/tcg/probe.h            |  27 ++-
 target/alpha/cpu.h                   |   2 +-
 target/arm/internals.h               |   5 +-
 target/arm/tcg/mte_helper.h          |  18 +-
 target/avr/cpu.h                     |   2 +-
 target/hppa/cpu.h                    |   5 +-
 target/i386/tcg/helper-tcg.h         |   2 +-
 target/loongarch/tcg/tcg_loongarch.h |   2 +-
 target/m68k/cpu.h                    |   2 +-
 target/microblaze/cpu.h              |   2 +-
 target/mips/tcg/tcg-internal.h       |   2 +-
 target/or1k/cpu.h                    |   2 +-
 target/ppc/internal.h                |   2 +-
 target/riscv/cpu.h                   |   2 +-
 target/riscv/tcg/pmp.h               |   5 +-
 target/s390x/s390x-internal.h        |   2 +-
 target/sh4/cpu.h                     |   2 +-
 target/sparc/cpu.h                   |   2 +-
 target/tricore/cpu.h                 |   2 +-
 target/xtensa/cpu.h                  |   2 +-
 accel/tcg/cputlb.c                   |  91 +++++----
 accel/tcg/user-exec.c                |  20 +-
 semihosting/uaccess.c                |  10 +-
 target/alpha/helper.c                |   2 +-
 target/arm/gdbstub64.c               |  10 +-
 target/arm/tcg/helper-a64.c          |   5 +-
 target/arm/tcg/mte_helper.c          | 273 +++++++++++++++++----------
 target/arm/tcg/sve_helper.c          |  10 +-
 target/arm/tcg/tlb_helper.c          |   5 +-
 target/avr/helper.c                  |   2 +-
 target/hexagon/cpu.c                 |   8 +-
 target/hppa/mem_helper.c             |   6 +-
 target/i386/tcg/system/excp_helper.c |   2 +-
 target/loongarch/tcg/tlb_helper.c    |   3 +-
 target/m68k/helper.c                 |   3 +-
 target/microblaze/helper.c           |   2 +-
 target/mips/tcg/ldst_helper.c        |   4 +-
 target/mips/tcg/system/tlb_helper.c  |   2 +-
 target/or1k/mmu.c                    |   2 +-
 target/ppc/mmu_helper.c              |   2 +-
 target/riscv/tcg/cpu_helper.c        |  53 +++---
 target/riscv/tcg/op_helper.c         |   5 +-
 target/riscv/tcg/pmp.c               |  66 +++----
 target/riscv/tcg/vector_helper.c     |  21 ++-
 target/rx/cpu.c                      |   2 +-
 target/s390x/tcg/excp_helper.c       |   2 +-
 target/s390x/tcg/mem_helper.c        |   4 +-
 target/sh4/helper.c                  |   2 +-
 target/sparc/mmu_helper.c            |   4 +-
 target/tricore/helper.c              |   2 +-
 target/xtensa/helper.c               |   2 +-
 52 files changed, 412 insertions(+), 319 deletions(-)

-- 
2.43.0


