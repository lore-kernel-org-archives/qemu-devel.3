Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4132DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbR-0004cy-Vr; Mon, 22 Sep 2025 14:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbQ-0004cm-SC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:32 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbN-000438-LW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77f35113821so1180043b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566967; x=1759171767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C3/w25Ux+btAa+BKxO6U3xdoWuoAladWrNjwoLEMvEo=;
 b=W4lsEazorJpyq/LSeMdtDr5NWBMvCHwcyPaDkOmzTr9+R3CSuJzdmxDRQgWX8FY43X
 8S/BRiOZRMwxr1O0NtyvZpZyix/Q9K9O+gzj1mvVQ3AUH142FDsPo2Lmd/FL7phd9Otk
 c3xZrQYhnfT1Dq6jVWYZS/sZMqQRhMAOGbHUrtCqjBrQJfxclS0L9kyey7Jt8gpDk3oM
 N5JMtvPtVP5luplhF5mV2mgDdvTFUh7uuUO2A1zJjQMvhWE8KgX4BDDgzgvTNC30utWc
 s5H05BacvgTVvh+qX17lXrVReNxsOc3lDVseecS8uj4EI4R8jq3SM1DNp7iaL0EdSqG3
 g+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566967; x=1759171767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C3/w25Ux+btAa+BKxO6U3xdoWuoAladWrNjwoLEMvEo=;
 b=aKvTfT8RMULzDmE7jo87UbZwJXezd1ixZP73/3h20jkUh8/0GTZxgIQiPy/xXrbwsc
 3APbDavBt/GZ5i/7QbB7CjeSgWV2fXqU/6EiVtXtlCVMdX5nhA6x2fZvLzM4La++3N49
 bS738V8vQ1O4XHkIxqgwL5U7uLXVJj1IhJbYSXr/OHvnQPhM6sXSnfQ9t2afykQhfUEu
 +OiM3zK/hMGGutKcwGCSiCA92yd36385sEoQUc2R8FjwXoeQgJ9GDADe769/bgmzTCw8
 UeelI9/zsgRGp+ii2h8AX7V+TVnfHZke3DEkT012ACtm3kq9ndD9uNDrmGF4upNTyyqb
 nmFw==
X-Gm-Message-State: AOJu0YwfDnlepdc03Qhowdg9btpn89Li57Zy2lCAGMv9gSu1zXNJfNwW
 kTyzSHDKRSKzZMq1wTXq8W4j1cO+6rX8GJ5HIhIyvE1KrLzYilDqvy4bg66jpA4gZkLK2z9r/UL
 a/mOB
X-Gm-Gg: ASbGncsVP6Q4Y2KLRgq0AiNvKYoop0lKPEfLJVQXESQQfvQeL/ctzoFTzstW0YrCbXW
 d8svT9i5/CPFUf9rN3l9PJ861O7oWFVMHjjrCq6hzNyh/N+c/tVyKVnDmcAL8y8Di8rpUI9gd2I
 V/zsOmQQeFIjx5y5CPXCeiX+imYfJ7MOMDwBj/PCvF83L1Lhxvd10dY5UomMba8uMWZ2pYM8jdy
 VwYScDZz/Zes+IIvUOOTtX+Tn9gVQxnMjp3txYu0GNfFw+bQAF+uQcIYemimcsc6pg14D0Xs/8s
 v4l3JTTHnrPwR3suSOo1afLRmEfS/gY7Tmbt7Rx1xAuNVLyBbcsKDXsygVQtdssJ/NXygyYJtkR
 9dfjedv7h32Z+71fzIBAoX/5ajRmm
X-Google-Smtp-Source: AGHT+IGQSSWNP04IL1c0GRtppjXrQdMbgsiaGkSVyGMZdpfnKJ44XggPJSir5h2sZKliNoP1ggMWFg==
X-Received: by 2002:a05:6a21:329f:b0:2b7:e136:1f06 with SMTP id
 adf61e73a8af0-2cfd4836a24mr144827637.7.1758566966693; 
 Mon, 22 Sep 2025 11:49:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 00/76] target/arm: Implement FEAT_GCS
Date: Mon, 22 Sep 2025 11:48:08 -0700
Message-ID: <20250922184924.2754205-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Based-on: 20250916142238.664316-1-richard.henderson@linaro.org
("[PATCH v2 00/36] target/arm: Reorg VHE redirection")

Changes from v4:
  - Master now includes FEAT_ATS1A.
  - Rebase on VHE reorg
    - Trivial adjustments to S1PIE and GCS regs for REG12 redirect.
    - Simplifies EXLOCK access test.
  - Migration fixes based on review.

Note that tests/functional/aarch64/test_rme_* will fail.
The TF-A images need updating again for at least FEAT_S1PIE
(EL1 accessing PIRE0_EL1 trapping to EL3 is the fatal fault).

I'm toying with updating the QEMU build to match the FVP build,
so that all features are runtime enabled.


r~


Richard Henderson (76):
  target/arm: Add isar feature test for FEAT_S1PIE, FEAT_S2PIE
  target/arm: Enable TCR2_ELx.PIE
  target/arm: Implement PIR_ELx, PIRE0_ELx, S2PIR_EL2 registers
  target/arm: Force HPD for stage2 translations
  target/arm: Cache NV1 early in get_phys_addr_lpae
  target/arm: Populate PIE in aa64_va_parameters
  target/arm: Implement get_S1prot_indirect
  target/arm: Implement get_S2prot_indirect
  target/arm: Expand CPUARMState.exception.syndrome to 64 bits
  target/arm: Expand syndrome parameter to raise_exception*
  target/arm: Implement dirtybit check for PIE
  target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu max
  include/hw/core/cpu: Introduce MMUIdxMap
  include/hw/core/cpu: Introduce cpu_tlb_fast
  include/hw/core/cpu: Invert the indexing into CPUTLBDescFast
  target/hppa: Adjust mmu indexes to begin with 0
  include/exec/memopidx: Adjust for 32 mmu indexes
  include/hw/core/cpu: Widen MMUIdxMap
  target/arm: Split out mmuidx.h from cpu.h
  target/arm: Convert arm_mmu_idx_to_el from switch to table
  target/arm: Remove unused env argument from regime_el
  target/arm: Convert regime_el from switch to table
  target/arm: Convert regime_has_2_ranges from switch to table
  target/arm: Remove unused env argument from regime_is_pan
  target/arm: Convert regime_is_pan from switch to table
  target/arm: Remove unused env argument from regime_is_user
  target/arm: Convert regime_is_user from switch to table
  target/arm: Convert arm_mmu_idx_is_stage1_of_2 from switch to table
  target/arm: Convert regime_is_stage2 to table
  target/arm: Introduce mmu indexes for GCS
  target/arm: Introduce regime_to_gcs
  target/arm: Support page protections for GCS mmu indexes
  target/arm: Implement gcs bit for data abort
  target/arm: Add GCS cpregs
  target/arm: Add GCS enable and trap levels to DisasContext
  target/arm: Implement FEAT_CHK
  target/arm: Make helper_exception_return system-only
  target/arm: Export cpsr_{read_for,write_from}_spsr_elx
  target/arm: Expand pstate to 64 bits
  target/arm: Add syndrome data for EC_GCS
  target/arm: Add arm_hcr_el2_nvx_eff
  target/arm: Use arm_hcr_el2_nvx_eff in access_nv1
  target/arm: Split out access_nv1_with_nvx
  target/arm: Implement EXLOCKException for ELR_ELx and SPSR_ELx
  target/arm: Split {full,core}_a64_user_mem_index
  target/arm: Introduce delay_exception{_el}
  target/arm: Emit HSTR trap exception out of line
  target/arm: Emit v7m LTPSIZE exception out of line
  target/arm: Implement GCSSTR, GCSSTTR
  target/arm: Implement GCSB
  target/arm: Implement GCSPUSHM
  target/arm: Implement GCSPOPM
  target/arm: Implement GCSPUSHX
  target/arm: Implement GCSPOPX
  target/arm: Implement GCSPOPCX
  target/arm: Implement GCSSS1
  target/arm: Implement GCSSS2
  target/arm: Add gcs record for BL
  target/arm: Add gcs record for BLR
  target/arm: Add gcs record for BLR with PAuth
  target/arm: Load gcs record for RET
  target/arm: Load gcs record for RET with PAuth
  target/arm: Copy EXLOCKEn to EXLOCK on exception to the same EL
  target/arm: Implement EXLOCK check during exception return
  target/arm: Enable FEAT_GCS with -cpu max
  linux-user/aarch64: Implement prctls for GCS
  linux-user/aarch64: Allocate new gcs stack on clone
  linux-user/aarch64: Release gcs stack on thread exit
  linux-user/aarch64: Implement map_shadow_stack syscall
  target/arm: Enable GCSPR_EL0 for read in user-mode
  linux-user/aarch64: Inject SIGSEGV for GCS faults
  linux-user/aarch64: Generate GCS signal records
  linux-user/aarch64: Enable GCS in HWCAP
  tests/tcg/aarch64: Add gcsstr
  tests/tcg/aarch64: Add gcspushm
  tests/tcg/aarch64: Add gcsss

 include/exec/cputlb.h              |  32 +--
 include/exec/memopidx.h            |   9 +-
 include/hw/core/cpu.h              |  25 +-
 linux-user/aarch64/gcs-internal.h  |  38 +++
 linux-user/aarch64/target_prctl.h  |  96 +++++++
 linux-user/aarch64/target_signal.h |   1 +
 linux-user/qemu.h                  |   5 +
 target/arm/cpregs.h                |  22 ++
 target/arm/cpu-features.h          |  15 +
 target/arm/cpu.h                   | 243 ++--------------
 target/arm/internals.h             | 148 ++--------
 target/arm/mmuidx-internal.h       | 113 ++++++++
 target/arm/mmuidx.h                | 241 ++++++++++++++++
 target/arm/syndrome.h              |  35 +++
 target/arm/tcg/helper-a64.h        |   5 +-
 target/arm/tcg/translate.h         |  46 ++-
 target/hppa/cpu.h                  |  28 +-
 tests/tcg/aarch64/gcs.h            |  80 ++++++
 accel/tcg/cputlb.c                 |  49 ++--
 linux-user/aarch64/cpu_loop.c      |   5 +
 linux-user/aarch64/elfload.c       |   1 +
 linux-user/aarch64/signal.c        | 138 ++++++++-
 linux-user/syscall.c               | 114 ++++++++
 target/arm/cpregs-gcs.c            | 156 ++++++++++
 target/arm/cpu.c                   |  17 +-
 target/arm/gdbstub64.c             |   2 +
 target/arm/helper.c                | 283 +++++++++++++++----
 target/arm/machine.c               | 113 +++++++-
 target/arm/mmuidx.c                |  66 +++++
 target/arm/ptw.c                   | 373 ++++++++++++++++++------
 target/arm/tcg-stubs.c             |   2 +-
 target/arm/tcg/cpu64.c             |   3 +
 target/arm/tcg/helper-a64.c        |  35 +--
 target/arm/tcg/hflags.c            |  38 +++
 target/arm/tcg/mte_helper.c        |   2 +-
 target/arm/tcg/op_helper.c         |  11 +-
 target/arm/tcg/tlb-insns.c         |  47 +++-
 target/arm/tcg/tlb_helper.c        |  18 +-
 target/arm/tcg/translate-a64.c     | 438 ++++++++++++++++++++++++++---
 target/arm/tcg/translate.c         |  78 +++--
 tcg/tcg.c                          |   3 +-
 tests/tcg/aarch64/gcspushm.c       |  71 +++++
 tests/tcg/aarch64/gcsss.c          |  74 +++++
 tests/tcg/aarch64/gcsstr.c         |  48 ++++
 docs/system/arm/emulation.rst      |   4 +
 target/arm/meson.build             |   9 +-
 target/arm/tcg/a64.decode          |   5 +
 tcg/aarch64/tcg-target.c.inc       |   2 +-
 tcg/arm/tcg-target.c.inc           |   2 +-
 tests/tcg/aarch64/Makefile.target  |   5 +
 50 files changed, 2734 insertions(+), 660 deletions(-)
 create mode 100644 linux-user/aarch64/gcs-internal.h
 create mode 100644 target/arm/mmuidx-internal.h
 create mode 100644 target/arm/mmuidx.h
 create mode 100644 tests/tcg/aarch64/gcs.h
 create mode 100644 target/arm/cpregs-gcs.c
 create mode 100644 target/arm/mmuidx.c
 create mode 100644 tests/tcg/aarch64/gcspushm.c
 create mode 100644 tests/tcg/aarch64/gcsss.c
 create mode 100644 tests/tcg/aarch64/gcsstr.c

-- 
2.43.0


