Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56330FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9K-0006IA-5O; Wed, 29 Apr 2026 20:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9E-0006GA-1R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:20:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9C-00063i-1l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:20:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f4a53ae20so246366b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508452; x=1778113252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HiBQZDfO5X+GthTlORXYDenHLoMiR1K5GwSwqWbpPbs=;
 b=cjLOJsBpBfEJwbazkRJie4zlutmaAy8Qu7FkTTo1aKdv/xY8Z9RR50JZ6catdjrtkf
 mZ5AFzxCYi5jjFEqvRgJWR6MlY0T8oBSTkA5fkTyVk9ZIBaQXfErbO0M4/15RX11l9+E
 NnUXJC9Xz3LyAlgY1ir4MjALHH/BrowdCdeYfucLyI7BXZdS05zPjx4efWHi3K0yH+Bg
 Uw61QkL3i3fKp05+/vBhoczWgipxvPoibiCMsqjWqckGLi8+xzON/STIaRYpcZOqU9jL
 u2DUbzYvlKl1K/lxE1eQKA1YjMKP9lhrEsz4x4QrytRddAWEYgl4IcvTDKf/TUG4X4gr
 tlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508452; x=1778113252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiBQZDfO5X+GthTlORXYDenHLoMiR1K5GwSwqWbpPbs=;
 b=cP//ylPI9Erkvo4zcVX1h6n5T+xD+kWhvutjLCuttukR5e8pnnCu/tdM4+JBMDbFzv
 xaA8AalKsDM8BmbPBt/uJSUtE0mh1HkrW15dY4Un6MGJSAo6+xFYJFlhRlx9CnKjYSsx
 T2qcP9MZmncGfZwMhYCU7zvx7uFUDs2U1Goxst3W1kZ5K8mOihj3bQQBVg2IGtDirzmR
 txrNAFKH5mB7n21SGaPw/8UWa3rG6V66Lw4oCm/nFanZYbP1zh6v3K6g5XFIxfR1gEyr
 oHfnn/7xnYcSTC8wDZ35sP9RnEbJxWXrYWNzuP6wnoYvWkN3wywCzHGoJ+IR2dYi5ThM
 mYng==
X-Gm-Message-State: AOJu0YzsDRN7emb7d7Pg4CCsXUzlv4/W6MQRKMtDj09JGV9aBV9zYKFO
 7cXqBHB769kDYysLi5uNq9C5eerXlz7V/spMEBIgeYPII0za9wKaD4OlcXLZ+/PYX4yyfvDuCi4
 n+kFNvfw=
X-Gm-Gg: AeBDiet1eAmAR5i4TToSsf8ZPjtOaUQtG9fQfoaB29QHI6bVGTYRJWibhzCx/I9hvFc
 UUWzTanYnqjYXPDaAHyDN+6zUIRiE0jFeQi/FoJpjrEpxSx3vzKOWhrUP2VqKTWK8Qay/kIg2io
 m4ctAA4pjWHI4yDvvHqaP2lKQGB5SejwhdEZu2u7721miDW161GQwNsN3j9JwXl1GTfvs4s4BMI
 /Qqv8Fw3X6mdfGO0sPsoNmwU36ViG79qZHSI9iqBmaDAJBakpo0O1elJjEUtl3rtuNvI2p5YO9z
 c5mFzS4u0wFtCKKbbTiRMJJ/KpAC0KEf0QDDZYn1mJQgj2dKHEOv70zf79QF7oFA6FaIpHklvGN
 PWdV0PPyCtoPCSSiwXC434+tUHFIfaIsqvwM8BpNNkVQESRx/iBAEEYjfo3d+jHFX2PB4rl55wU
 xC2kckY4JbG0k8nLKXnrgBYkNGYbS8QN6AVSZtzmg7+d+wXo505hM=
X-Received: by 2002:a05:6a00:a586:b0:82f:4628:4198 with SMTP id
 d2e1a72fcca58-834fdbd3e88mr853964b3a.31.1777508452322; 
 Wed, 29 Apr 2026 17:20:52 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:20:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 alex.bennee@linaro.org
Subject: [PATCH v3 00/47] target/arm: Implement FEAT_FP8
Date: Thu, 30 Apr 2026 10:19:59 +1000
Message-ID: <20260430002046.59739-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Based-on: 20260430000524.56046-1-richard.henderson@linaro.org
("[PATCH v2 00/40] fpu: Export some internals for targets")

v2: https://lore.kernel.org/qemu-devel/20260424043014.46305-1-richard.henderson@linaro.org/

Changes for v3:
  - Rebase on softfloat-parts.h, which allows us to drop some
    local changes to fpu/.
  - Enable ID_AA64FPFR0.F8{E5M2,E4M3}.
  - Implement FEAT_SME_LUTv2.
  - Implement FEAT_FP8FMA, FEAT_SSVE_FP8FMA.

I still haven't addressed the required firmware update for

  tests/functional/aarch64/test_rme_virt.py
  tests/functional/aarch64/test_rme_sbsaref.py


r~


Cc: pierrick.bouvier@oss.qualcomm.com
Cc: alex.bennee@linaro.org


Richard Henderson (47):
  target/arm: Implement ID_AA64ISAR3
  target/arm: Implement FEAT_FAMINMAX for AdvSIMD
  target/arm: Implement FEAT_FAMINMAX for SME
  target/arm: Implement FEAT_FAMINMAX for SVE
  target/arm: Enable FEAT_FAMINMAX for -cpu max
  target/arm: Update SCR bits for Arm ARM M.a.a
  target/arm: Update HCRX bits for Arm ARM M.a.a
  target/arm: Introduce FPMR
  target/arm: Update SCTLR bits for FEAT_FPMR
  target/arm: Enable EnFPM bits for FEAT_FPMR
  target/arm: Clear FPMR on ResetSVEState
  target/arm: Add FPMR_EL to TBFLAGS
  target/arm: Trap direct acceses to FPMR
  target/arm: Enable FEAT_FPMR for -cpu max
  target/arm: Implement ID_AA64FPFR0
  target/arm: Add isar_feature_aa64_f8cvt
  target/arm: Implement FSCALE for AdvSIMD
  target/arm: Implement FSCALE for SME
  target/arm: Split vector-type.h from cpu.h
  target/arm: Move vectors_overlap to vec_internal.h
  target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL, BF2CVTL2 for AdvSIMD
  target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, BF2CVTLT for SVE
  target/arm: Rename SME BFCVT patterns to BFCVT_hs
  target/arm: Implement BF1CVT, BF1CVTL, BF2CVT, BF2CVTL for SME
  target/arm: Implement F1CVTL, F1CVTL2, F2CVTL, F2CVTL2 for AdvSIMD
  target/arm: Implement F1CVT, F1CVTLT, F2CVT, F2CVTLT for SVE
  target/arm: Implement F1CVT, F1CVTL, F2CVT, F2CVTL for SME
  target/arm: Implement BFCVTN for SVE
  target/arm: Implement FCVTN (16- to 8-bit fp) for AdvSIMD
  target/arm: Implement FCVTN, FCVTN2 (32- to 8-bit fp) for AdvSIMD
  target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
  target/arm: Implement FCVTNB, FCVTNT for SVE
  target/arm: Implement FCVT (FP16 to FP8) for SME
  target/arm: Implement FCVT, FCVTN (FP32 to FP8) for SME
  target/arm: Implement LUTI2, LUTI4 for AdvSIMD
  target/arm: Implement LUTI2, LUTI4 for SVE
  target/arm: Enable FEAT_LUT for -cpu max
  target/arm: Enable FEAT_FP8 for -cpu max
  target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
  target/arm: Implement MOVT (vector to table)
  target/arm: Implement LUTI4 (four registers, 8-bit)
  target/arm: Enable FEAT_SME_LUTv2 for -cpu max
  target/arm: Implement FMLALB, FMLALT for AdvSIMD
  target/arm: Implement FMLALB, FMLALT (FP8 to FP16) for SVE
  target/arm: Implement FMLALL{BB,BT,TB,TT} for AdvSIMD
  target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
  target/arm: Enable FEAT_FP8FMA, FEAT_SSVE_FP8FMA for -cpu max

 target/arm/cpregs.h              |    5 +
 target/arm/cpu-features.h        |   97 +++
 target/arm/cpu.h                 |   52 +-
 target/arm/helper-fp8.h          |   14 +
 target/arm/internals.h           |   13 +-
 target/arm/tcg/helper-a64-defs.h |   11 +
 target/arm/tcg/helper-defs.h     |    6 +
 target/arm/tcg/helper-fp8-defs.h |   31 +
 target/arm/tcg/helper-sme-defs.h |    2 +-
 target/arm/tcg/helper-sve-defs.h |   14 +
 target/arm/tcg/translate-a64.h   |    1 +
 target/arm/tcg/translate.h       |   10 +
 target/arm/tcg/vec_internal.h    |   19 +
 target/arm/vector-type.h         |   44 ++
 target/arm/helper.c              |   43 +-
 target/arm/machine.c             |   20 +
 target/arm/tcg/cpu64.c           |   18 +
 target/arm/tcg/fp8_helper.c      | 1036 ++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c          |   41 ++
 target/arm/tcg/sme_helper.c      |    8 +-
 target/arm/tcg/sve_helper.c      |    8 +
 target/arm/tcg/translate-a64.c   |  152 +++++
 target/arm/tcg/translate-sme.c   |  109 +++-
 target/arm/tcg/translate-sve.c   |  147 +++++
 target/arm/tcg/vec_helper.c      |   66 ++
 target/arm/tcg/vec_helper64.c    |   51 ++
 docs/system/arm/emulation.rst    |    7 +
 target/arm/cpu-sysregs.h.inc     |    2 +
 target/arm/tcg/a64.decode        |   38 ++
 target/arm/tcg/meson.build       |    1 +
 target/arm/tcg/sme.decode        |   36 +-
 target/arm/tcg/sve.decode        |   41 +-
 32 files changed, 2084 insertions(+), 59 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/vector-type.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0


