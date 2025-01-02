Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748CAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPb7-0006wL-Vr; Thu, 02 Jan 2025 13:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb2-0006vj-7H
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:00 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPaz-00056t-GF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:06:59 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21631789fcdso118432865ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841216; x=1736446016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=272K03IG9fFwpfNqUsDhlxebfJi0GyPACpBEPh/+9UU=;
 b=Sam0QAzeYGyRnOu6yrCLp4FnlCQHHSNgak3OT3ECDe5AbqlmqziVm/eNnzURomX2hj
 H5kx+vz0QD7Pp8wMv9Ow7ManyhlJYOYhm83HKuUgu5lw16lHXs00GrGE4/96Tigakaen
 vv18+2ykJxm9nsq+fgI6WjpQCURL1BtvKc+99P+SarjvaSmzjNnc/hcXT/q+u8tk28at
 lD5V4W5E9jNT8RbeCdtBoERZxC3QSrERO5Pae49a5L6qCB2SRg3Lkjhr4FOMDk/hHIKu
 mqQSf/YruIlW6jlI++P3GfUJoiySaX5YuwVxjXDQc24BfoqIyo4uPCY7gvc/ti8auzfN
 LotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841216; x=1736446016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=272K03IG9fFwpfNqUsDhlxebfJi0GyPACpBEPh/+9UU=;
 b=MSgYD2vlm6LQaRNB7ct0+aWmfopGsPohoNDpRl5C9CeGwXwtX1etuCrz0O9v9YllrY
 saNMbQbUSPOvTLGGU5yqxIFQc2zyFdSEESDW83t9tc5nmOqokkmcn+df9h7spKhUftua
 5+9Hw6dtXvXIbP34C5plBNyL8YpvvPYBSvTrJRM8gcSA8lM/kyPZ0SQPljHqIcsIS8sh
 12pS3uC2L+sdBEF759NE+4cul1uY4thZtPrm9cYkrmjfMFU8P+xsLtWZoTu9q5rCqSLd
 70qC4GUa+HxoUMIZz6liW2ArkJ/muDTV9melKwjp77WcLQxWfSiwHyY73a6cS2zGyjRz
 swzg==
X-Gm-Message-State: AOJu0YwZJrqoN1F++zULmL47OOXoZbGvZfxlwiPFCxhjBz53+pG8NLAv
 Bkz/itnuSAuocTG/5tcAyBKS4yPveU5xQjgA2g63QO9ghvEaHQ1KtaA+94fRAh8bnFg88N52zui
 K
X-Gm-Gg: ASbGncs6m/Yk+47UguCedCK+P89vlkh7BArMnEM2NCyH96x5Ynr06BS1HYZN6B/njth
 GzHennwLkPNI/jnmVy7a+aS0EzwgC1nc09HNjx/ljEqxg39Bs8YLU03RLPUm9Fbzl5FEBerlN/p
 7oHPy26QNHbOLvwa7ycTFZu0cJ0Dzt3nu2kRu++KKZCet5Kbk1LOE32U4D4Jr5F+BQ618vMD/bH
 pk6gyBWByKw5obT8my2RQ72GsE9eZVyRsh3G5DTpKfYBsvdz2VPwOxwnUn/+w==
X-Google-Smtp-Source: AGHT+IEi0MsigXC2EQx8CdUVsU9bAa6dK2BbJFcOjzYhmcmzQ4kfQIzn4I5fxS+KHq35zd6yz3VTtw==
X-Received: by 2002:a05:6a20:6a0d:b0:1e1:a920:225d with SMTP id
 adf61e73a8af0-1e5e1fa207dmr72040084637.19.1735841215642; 
 Thu, 02 Jan 2025 10:06:55 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.06.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:06:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/73] tcg: Merge *_i32 and *_i64 opcodes
Date: Thu,  2 Jan 2025 10:05:40 -0800
Message-ID: <20250102180654.1420056-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Currently we have individual opcodes for each integer type.
This makes things difficult in tcg/optimize.c when we want
to transform the opcode stream.

Add a TCGType field to TCGOp and use that instead.  Merge all of
the opcodes that are common to both TCG_TYPE_I32 and TCG_TYPE_I64.
We could eventually merge some of the vector opcodes too, but since
those have an additional element size operand, that is a larger job.

This also moves quite a lot of the tcg backend implementation out
of the publicly exposed headers.  After this patchset is complete,
we will not rebuild target translators for most changes to the tcg
backend.


r~


Richard Henderson (73):
  tcg: Add TCGOp.type
  tcg: Add TCGHelperInfo.out_type
  tcg: Add TCGType argument to tcg_emit_op, tcg_op_insert_*
  tcg: Add TCGType argument to tcg_gen_op*
  tcg: Remove TCGOP_VECL
  tcg: Move call abi parameters from tcg-target.h to tcg-target.c.inc
  tcg: Add TCGType argument to tcg_op_supported
  target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
  target/arm: Use tcg_op_supported
  target/tricore: Use tcg_op_supported
  tcg: Add tcg_op_deposit_valid
  target/i386: Remove TCG_TARGET_extract_tl_valid
  target/i386: Use tcg_op_deposit_valid
  target/i386: Use tcg_op_supported
  tcg: Remove TCG_TARGET_NEED_LDST_LABELS and
    TCG_TARGET_NEED_POOL_LABELS
  tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
  tcg/tci: Move TCI specific opcodes to tcg-target-opc.h.inc
  tcg: Move fallback tcg_can_emit_vec_op out of line
  tcg: Split out tcg-target-has.h and tcg-has.h
  tcg: Split out tcg-target-mo.h
  tcg: Merge TCG_TARGET_HAS_{div,rem,div2}
  tcg: Merge TCG_TARGET_HAS_{andc,orc,nand,nor,eqv,not}
  tcg/mips: Expand bswap unconditionally
  tcg: Merge TCG_TARGET_HAS_bswap*
  tcg: Merge TCG_TARGET_HAS_rot_{i32,i64}
  tcg: Merge TCG_TARGET_HAS_{clz,ctz,ctpop}
  tcg: Merge TCG_TARGET_HAS_{muls2,mulu2,mulsh,muluh}
  tcg: Merge TCG_TARGET_HAS_{add2,sub2}
  tcg: Merge TCG_TARGET_HAS_negsetcond_{i32,i64}
  tcg/i386: Handle all 8-bit extensions for i686
  tcg/i386: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
  tcg/aarch64: Expand extract with offset 0 with andi
  tcg/arm: Add full [US]XT[BH] into {s}extract
  tcg/loongarch64: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/mips: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/ppc: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/riscv64: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
  tcg/s390x: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/sparc64: Use SRA, SRL for {s}extract_i64
  tcg/tci: Provide TCG_TARGET_{s}extract_valid
  tcg/tci: Remove assertions for deposit and extract
  tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
  tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
  tcg: Merge TCG_TARGET_HAS_extract2_{i32,i64}
  tcg: Make INDEX_op_extrh_i64_i32 mandatory
  tcg: Remove INDEX_op_ext{8,16,32}{us}
  tcg: Reorg process_op_defs
  tcg: Remove args_ct from TCGOpDef
  tcg: Constify tcg_op_defs
  tcg: Use tcg_op_supported in process_op_defs
  tcg: Use C_NotImplemented in tcg_target_op_def
  tcg: Pass TCGOp to tcg_target_op_def
  tcg: Merge INDEX_op_{ld,st}*_{i32_i64}
  tcg: Remove INDEX_op_qemu_st8_*_i32
  tcg: Add TCGType argument to tcg_out_op
  tcg/optimize: Remove OptContext.type
  tcg: Remove TCG_OPF_64BIT
  tcg: Change have_vec to has_type in tcg_op_supported
  tcg: Merge INDEX_op_mov_{i32,i64}
  tcg: Merge integer logical operations
  tcg: Merge integer add, sub, neg operations
  tcg: Merge integer add2, sub2 operations
  tcg: Merge integer mul, div operations
  tcg: Merge brcond, setcond, negsetcond, movcond operations
  tcg: Merge extract, sextract operations
  tcg: Merge integer shift operations
  tcg: Merge deposit operations
  tcg: Merge extract2 operations
  tcg: Merge host integer load/store operations
  tcg: Merge bswap operations
  tcg: Merge clz, ctz, ctpop operations

 accel/tcg/internal-target.h                   |    1 +
 include/tcg/helper-info.h                     |    3 +-
 include/tcg/tcg-op.h                          |    8 +-
 include/tcg/tcg-opc.h                         |  334 ++---
 include/tcg/tcg.h                             |  144 +-
 tcg/aarch64/tcg-target-has.h                  |   76 +
 tcg/aarch64/tcg-target-mo.h                   |   12 +
 tcg/aarch64/tcg-target.h                      |  126 --
 tcg/arm/tcg-target-has.h                      |   91 ++
 tcg/arm/tcg-target-mo.h                       |   13 +
 tcg/arm/tcg-target.h                          |   86 --
 tcg/i386/tcg-target-con-str.h                 |    2 +-
 tcg/i386/tcg-target-has.h                     |  124 ++
 tcg/i386/tcg-target-mo.h                      |   19 +
 tcg/i386/tcg-target.h                         |  162 --
 tcg/loongarch64/tcg-target-has.h              |   72 +
 tcg/loongarch64/tcg-target-mo.h               |   12 +
 tcg/loongarch64/tcg-target.h                  |  115 --
 tcg/mips/tcg-target-has.h                     |   88 ++
 tcg/mips/tcg-target-mo.h                      |   13 +
 tcg/mips/tcg-target.h                         |  130 --
 tcg/ppc/tcg-target-has.h                      |   86 ++
 tcg/ppc/tcg-target-mo.h                       |   12 +
 tcg/ppc/tcg-target.h                          |  126 --
 tcg/riscv/tcg-target-con-set.h                |    2 +-
 tcg/riscv/tcg-target-con-str.h                |    1 -
 tcg/riscv/tcg-target-has.h                    |   83 ++
 tcg/riscv/tcg-target-mo.h                     |   12 +
 tcg/riscv/tcg-target.h                        |  116 --
 tcg/s390x/tcg-target-has.h                    |   96 ++
 tcg/s390x/tcg-target-mo.h                     |   12 +
 tcg/s390x/tcg-target.h                        |  126 --
 tcg/sparc64/tcg-target-has.h                  |   51 +
 tcg/sparc64/tcg-target-mo.h                   |   12 +
 tcg/sparc64/tcg-target.h                      |   91 --
 tcg/tcg-has.h                                 |   51 +
 tcg/tcg-internal.h                            |   13 +-
 tcg/tci/tcg-target-has.h                      |   42 +
 tcg/tci/tcg-target-mo.h                       |   17 +
 tcg/tci/tcg-target.h                          |   94 --
 target/arm/tcg/translate-a64.c                |   10 +-
 target/arm/tcg/translate-sve.c                |   22 +-
 target/arm/tcg/translate.c                    |    2 +-
 target/sh4/translate.c                        |   26 +-
 target/tricore/translate.c                    |    4 +-
 tcg/optimize.c                                |  813 ++++------
 tcg/tcg-common.c                              |    4 +-
 tcg/tcg-op-gvec.c                             |    1 +
 tcg/tcg-op-ldst.c                             |   43 +-
 tcg/tcg-op-vec.c                              |   49 +-
 tcg/tcg-op.c                                  | 1310 +++++++----------
 tcg/tcg.c                                     | 1099 +++++++-------
 tcg/tci.c                                     |  551 +++----
 docs/devel/tcg-ops.rst                        |   28 +-
 target/i386/tcg/emit.c.inc                    |   20 +-
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |    4 +-
 tcg/aarch64/tcg-target.c.inc                  |  436 ++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |    6 +-
 tcg/arm/tcg-target.c.inc                      |  278 ++--
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   22 +-
 tcg/i386/tcg-target.c.inc                     |  502 +++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |    0
 tcg/loongarch64/tcg-target.c.inc              |  601 ++++----
 tcg/mips/tcg-target-opc.h.inc                 |    1 +
 tcg/mips/tcg-target.c.inc                     |  641 ++++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   12 +-
 tcg/ppc/tcg-target.c.inc                      |  699 ++++-----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |    0
 tcg/riscv/tcg-target.c.inc                    |  624 ++++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |    6 +-
 tcg/s390x/tcg-target.c.inc                    | 1044 ++++++-------
 tcg/sparc64/tcg-target-opc.h.inc              |    1 +
 tcg/sparc64/tcg-target.c.inc                  |  422 +++---
 tcg/tcg-ldst.c.inc                            |   65 -
 tcg/tcg-pool.c.inc                            |  162 --
 tcg/tci/tcg-target-opc.h.inc                  |   15 +
 tcg/tci/tcg-target.c.inc                      |  511 +++----
 77 files changed, 5541 insertions(+), 7167 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h
 create mode 100644 tcg/aarch64/tcg-target-mo.h
 create mode 100644 tcg/arm/tcg-target-has.h
 create mode 100644 tcg/arm/tcg-target-mo.h
 create mode 100644 tcg/i386/tcg-target-has.h
 create mode 100644 tcg/i386/tcg-target-mo.h
 create mode 100644 tcg/loongarch64/tcg-target-has.h
 create mode 100644 tcg/loongarch64/tcg-target-mo.h
 create mode 100644 tcg/mips/tcg-target-has.h
 create mode 100644 tcg/mips/tcg-target-mo.h
 create mode 100644 tcg/ppc/tcg-target-has.h
 create mode 100644 tcg/ppc/tcg-target-mo.h
 create mode 100644 tcg/riscv/tcg-target-has.h
 create mode 100644 tcg/riscv/tcg-target-mo.h
 create mode 100644 tcg/s390x/tcg-target-has.h
 create mode 100644 tcg/s390x/tcg-target-mo.h
 create mode 100644 tcg/sparc64/tcg-target-has.h
 create mode 100644 tcg/sparc64/tcg-target-mo.h
 create mode 100644 tcg/tcg-has.h
 create mode 100644 tcg/tci/tcg-target-has.h
 create mode 100644 tcg/tci/tcg-target-mo.h
 rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (82%)
 rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (75%)
 rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (72%)
 rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/mips/tcg-target-opc.h.inc
 rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (83%)
 rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (75%)
 create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
 delete mode 100644 tcg/tcg-ldst.c.inc
 delete mode 100644 tcg/tcg-pool.c.inc
 create mode 100644 tcg/tci/tcg-target-opc.h.inc

-- 
2.43.0


