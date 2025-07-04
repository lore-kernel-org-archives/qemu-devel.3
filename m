Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA360C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhI8-0004rA-Sr; Fri, 04 Jul 2025 10:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhHy-0004gF-Sw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:19 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhHw-00056z-Ai
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:18 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ebb468cbb4so1018600fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638874; x=1752243674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JN0F73jklyl2Z2rmuvnXiowB/gq3HZ81rtn3dElBr0M=;
 b=JqIPNpeuwKvSnKMxnkp9pcIahFyQRebnx5JgCKcg3Fg8iKshkPrKd7xEp0L1NrJrSo
 plHVfcyO9ZtHKDeOUS9ZLzkGmBXnaET+2R7At1VWPPc4uNr4sHRJZ5rMQVfzkF1sozK1
 6ywfMtHG8s5WND3tb1CfMxYIhl2RkXpDjeDM4A+NIZ4DxNivUQhsnHua6My7yCTgCwnC
 //FYIW2Yr7I3NDFm7rj01RYNMu5bMmfbwqgL8GARpuXDozDJkD/wSQwoqhntmdqfZEEw
 W4duNhFWPAebIrlLLxBl/PWi/jYhbCnPV0uQPy30a4UHYhNol6sHNoQ1heyzkOZNkULo
 +v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638874; x=1752243674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JN0F73jklyl2Z2rmuvnXiowB/gq3HZ81rtn3dElBr0M=;
 b=U7o+TU2m9Ia2pe/26SwSm+o6xbCA+H2LmSaFjTEdb+peV/4MXzedQj2A7LQxv6uMxR
 AJxq5VC6FHOUqHAL99FNKb6BzuGpPQvSqMf3fMMJtl30eHkPTkGq/jFOYlj01JkfpCAG
 Ucl9rewtmmohvqOW4k87aXMJOEvQelG/SsedcM5XFla1pUr8mF1tFbVmDSfBSQZKEIEJ
 VNjrIGpEXEqF9LZXau0a8BfWrFdKrbF0Oy6VkTtuC6x4lQ7HGvHEq8FNLUdm34BQUM+m
 xXq69eLYpO49PFAW+9tiePfxdtJF4xkJVeDHBL+J5e6RHjIjF1WF9DDrPQ8xaLlOuUyx
 utCg==
X-Gm-Message-State: AOJu0YxjMBPTbD8uHRxUf5kJOHlcCa33S9wTju3lnnM30fxaY9YXFV2j
 inW0N9U4LTARt2Gd80a/B9SN7K90+bLIt2GxJ16dc53mvfLeyXNxErSqQ588vln1morU0EO+NKr
 jKVUqXUE=
X-Gm-Gg: ASbGncvPEolLvevR5lTuLZjoQ4SqpXXUsFlBwIrgj8pppHNhJD8b4keiiQW3PL6NKtL
 VLSa9tKnANOEOdVuJFg9v7fTFS9a/cIthdqo7Kmk8ZP+4sdv9CXCEqvu4Ykenh/u3tl077o5OTN
 SeGX3teBHNVePlwZ7BH8DGwDsdueeGsRtqCp4EA6UiQ4lemAtGyDnNfU8fjKMrTB+TET6iGlhqu
 nIXpEF+PUXOBJ213r7iKqZw6ZtTCE4WxdqMakoTs6veZndC7T/HX+xqxfgoBHQPthi5W4lwZsBc
 aI/8gnfAjfhS3+tl7aJNpTGHzrg1t1fdOSYvpOOV/jS3NUxXThIdxBv9eMSOhzZBB4Y3mWbMhAN
 bn6K9s6PzLIom3YIsr+pqCOMgSuAjlcmKm8EevDle8yEWPl9n
X-Google-Smtp-Source: AGHT+IFpcSIGlSFsL8jSAqvkcC35bJ7FN+5XqJcD+2ULx2QoI6ciwUIL4QD6Io4NtzycWMm6Y1rV4A==
X-Received: by 2002:a05:6870:972b:b0:2ea:765f:da78 with SMTP id
 586e51a60fabf-2f796c79919mr1638688fac.21.1751638874334; 
 Fri, 04 Jul 2025 07:21:14 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 000/108] target/arm: Implement FEAT_SME2p1
Date: Fri,  4 Jul 2025 08:19:23 -0600
Message-ID: <20250704142112.1018902-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Changes for v4:
  - Combined with "target/arm: SME1/SVE2 fixes".
  - Updated for IDREG changes.
  - Introduced vectors_overlap() in sme_helper.c,
    for use with the multi-vector operations.
  - Various H() macro adjustments per review.
  - Dropped the premature optimization in PMOV.
  - Reorg WHILE patches to not break whilegt in the middle.
  - Replace DecodeCounter.stride with lg2_stride, and thus
    multiply/divide with shifts.

Patches lacking review:
  009-target-arm-Fix-bfdotadd_ebf-vs-nan-selection.patch
  041-target-arm-Implemement-SME2-SDOT-UDOT-USDOT-SUDOT.patch
  059-target-arm-Implement-SME2-SQCVT-UQCVT-SQCVTU.patch
  061-target-arm-Implement-SME2-SUNPK-UUNPK.patch
  064-target-arm-Implement-SME2-SQRSHR-UQRSHR-SQRSHRN.patch
  070-target-arm-Introduce-pred_count_test.patch
  072-target-arm-Expand-do_zero-inline.patch (new)
  074-target-arm-Split-out-do_whileg-from-helper_sve_wh.patch
  090-target-arm-Implement-PMOV-for-SME2p1-SVE2p1.patch
  108-tests-tcg-aarch64-Add-sme2-matmul-test-case.patch


r~


Peter Maydell (4):
  target/arm: Rename FMOPA_h to FMOPA_w_h
  target/arm: Rename BFMOPA to BFMOPA_w
  target/arm: Implement FMOPA (non-widening) for fp16
  target/arm: Implement SME2 BFMOPA (non-widening)

Richard Henderson (104):
  target/arm: Fix SME vs AdvSIMD exception priority
  target/arm: Fix sve_access_check for SME
  target/arm: Fix 128-bit element ZIP, UZP, TRN
  target/arm: Replace @rda_rn_rm_e0 in sve.decode
  target/arm: Fix FMMLA (64-bit element) for 128-bit VL
  target/arm: Disable FEAT_F64MM if maximum SVE vector size too small
  target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
  target/arm: Fix f16_dotadd vs nan selection
  target/arm: Fix bfdotadd_ebf vs nan selection
  target/arm: Remove CPUARMState.vfp.scratch
  target/arm: Introduce FPST_ZA, FPST_ZA_F16
  target/arm: Use FPST_ZA for sme_fmopa_[hsd]
  target/arm: Rename zarray to za_state.za
  target/arm: Add isar feature tests for SME2p1, SVE2p1
  target/arm: Add ZT0
  target/arm: Add zt0_excp_el to DisasContext
  target/arm: Implement SME2 ZERO ZT0
  target/arm: Add alignment argument to gen_sve_{ldr,str}
  target/arm: Implement SME2 LDR/STR ZT0
  target/arm: Implement SME2 MOVT
  target/arm: Split get_tile_rowcol argument tile_index
  target/arm: Rename MOVA for translate
  target/arm: Split out get_zarray
  target/arm: Introduce ARMCPU.sme_max_vq
  target/arm: Implement SME2 MOVA to/from tile, multiple registers
  target/arm: Implement SME2 MOVA to/from array, multiple registers
  target/arm: Implement SME2 BMOPA
  target/arm: Implement SME2 SMOPS, UMOPS (2-way)
  target/arm: Introduce gen_gvec_sve2_sqdmulh
  target/arm: Implement SME2 Multiple and Single SVE Destructive
  target/arm: Implement SME2 Multiple Vectors SVE Destructive
  target/arm: Implement SME2 ADD/SUB (array results, multiple and single
    vector)
  target/arm: Implement SME2 ADD/SUB (array results, multiple vectors)
  target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
  target/arm: Add helper_gvec{_ah}_bfmlsl{_nx}
  target/arm: Implement SME2 FMLAL, BFMLAL
  target/arm: Implement SME2 FDOT
  target/arm: Implement SME2 BFDOT
  target/arm: Implement SME2 FVDOT, BFVDOT
  target/arm: Rename helper_gvec_*dot_[bh] to *_4[bh]
  target/arm: Implemement SME2 SDOT, UDOT, USDOT, SUDOT
  target/arm: Rename SVE SDOT and UDOT patterns
  target/arm: Tighten USDOT (vectors) decode
  target/arm: Implement SDOT, UDOT (2-way) for SME2/SVE2p1
  target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT, USVDOT
  target/arm: Implement SME2 SMLAL, SMLSL, UMLAL, UMLSL
  target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
  target/arm: Implement SME2 FMLA, FMLS
  target/arm: Implement SME2 BFMLA, BFMLS
  target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
  target/arm: Implement SME2 ADD/SUB (array accumulator)
  target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN
  target/arm: Implement SME2 FCVT (widening), FCVTL
  target/arm: Implement SME2 FCVTZS, FCVTZU
  target/arm: Implement SME2 SCVTF, UCVTF
  target/arm: Implement SME2 FRINTN, FRINTP, FRINTM, FRINTA
  target/arm: Introduce do_[us]sat_[bhs] macros
  target/arm: Use do_[us]sat_[bhs] in sve_helper.c
  target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
  target/arm: Implement SQCVTN, UQCVTN, SQCVTUN for SME2/SVE2p1
  target/arm: Implement SME2 SUNPK, UUNPK
  target/arm: Implement SME2 ZIP, UZP (four registers)
  target/arm: Move do_urshr, do_srshr to vec_internal.h
  target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
  target/arm: Implement SME2 ZIP, UZP (two registers)
  target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
  target/arm: Enable SCLAMP, UCLAMP for SVE2p1
  target/arm: Implement FCLAMP for SME2, SVE2p1
  target/arm: Implement SME2p1 Multiple Zero
  target/arm: Introduce pred_count_test
  target/arm: Fold predtest_ones into helper_sve_brkns
  target/arm: Expand do_zero inline
  target/arm: Split out do_whilel from helper_sve_whilel
  target/arm: Split out do_whileg from helper_sve_whileg
  target/arm: Move scale by esz into helper_sve_while*
  target/arm: Split trans_WHILE to lt and gt
  target/arm: Enable PSEL for SVE2p1
  target/arm: Implement SVE2p1 WHILE (predicate pair)
  target/arm: Implement SVE2p1 WHILE (predicate as counter)
  target/arm: Implement SVE2p1 PTRUE (predicate as counter)
  target/arm: Implement {ADD,SMIN,SMAX,UMIN,UMAX}QV for SVE2p1
  target/arm: Implement SVE2p1 PEXT
  target/arm: Implement SME2 SEL
  target/arm: Implement ANDQV, ORQV, EORQV for SVE2p1
  target/arm: Implement FADDQV, F{MIN,MAX}{NM}QV for SVE2p1
  target/arm: Implement BFMLSLB{L,T} for SME2/SVE2p1
  target/arm: Implement CNTP (predicate as counter) for SME2/SVE2p1
  target/arm: Implement DUPQ for SME2p1/SVE2p1
  target/arm: Implement EXTQ for SME2p1/SVE2p1
  target/arm: Implement PMOV for SME2p1/SVE2p1
  target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
  target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
  target/arm: Implement SME2 counted predicate register load/store
  target/arm: Split the ST_zpri and ST_zprr patterns
  target/arm: Implement {LD1,ST1}{W,D} (128-bit element) for SVE2p1
  target/arm: Move ld1qq and st1qq primitives to sve_ldst_internal.h
  target/arm: Implement {LD,ST}[234]Q for SME2p1/SVE2p1
  target/arm: Implement LD1Q, ST1Q for SVE2p1
  target/arm: Implement MOVAZ for SME2p1
  target/arm: Implement LUTI2, LUTI4 for SME2/SME2p1
  target/arm: Support FPCR.AH in SME FMOPS, BFMOPS
  target/arm: Enable FEAT_SME2p1 on -cpu max
  linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1
  tests/tcg/aarch64: Add sme2-matmul test case

 target/arm/cpu-features.h          |   63 ++
 target/arm/cpu.h                   |   70 +-
 target/arm/syndrome.h              |    1 +
 target/arm/tcg/helper-sme.h        |  215 +++-
 target/arm/tcg/helper-sve.h        |  212 ++++
 target/arm/tcg/helper.h            |   91 +-
 target/arm/tcg/sve_ldst_internal.h |   89 ++
 target/arm/tcg/translate-a64.h     |   10 +-
 target/arm/tcg/translate.h         |    9 +
 target/arm/tcg/vec_internal.h      |  148 +++
 linux-user/aarch64/signal.c        |    4 +-
 linux-user/elfload.c               |    8 +
 target/arm/cpu.c                   |   11 +-
 target/arm/cpu64.c                 |    8 +
 target/arm/helper.c                |    8 +-
 target/arm/machine.c               |   22 +-
 target/arm/tcg/cpu64.c             |   10 +-
 target/arm/tcg/gengvec64.c         |   11 +
 target/arm/tcg/helper-a64.c        |    2 +
 target/arm/tcg/hflags.c            |   34 +-
 target/arm/tcg/mve_helper.c        |   21 -
 target/arm/tcg/neon_helper.c       |   30 +
 target/arm/tcg/sme_helper.c        | 1674 +++++++++++++++++++++++++---
 target/arm/tcg/sve_helper.c        | 1201 ++++++++++++++++----
 target/arm/tcg/translate-a64.c     |   45 +-
 target/arm/tcg/translate-neon.c    |   18 +-
 target/arm/tcg/translate-sme.c     | 1480 +++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c     | 1019 ++++++++++++++---
 target/arm/tcg/vec_helper.c        |  384 ++++++-
 target/arm/tcg/vfp_helper.c        |   12 +-
 tests/tcg/aarch64/sme2-matmul-0.c  |  236 ++++
 docs/system/arm/emulation.rst      |    6 +
 target/arm/tcg/sme.decode          |  937 +++++++++++++++-
 target/arm/tcg/sve.decode          |  327 +++++-
 tests/tcg/aarch64/Makefile.target  |   11 +-
 tests/tcg/aarch64/sme2-matmul-1.S  |  321 ++++++
 36 files changed, 8041 insertions(+), 707 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme2-matmul-0.c
 create mode 100644 tests/tcg/aarch64/sme2-matmul-1.S

-- 
2.43.0


