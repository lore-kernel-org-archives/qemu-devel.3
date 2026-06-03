Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01CCCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcHv-0006Wk-Or; Tue, 02 Jun 2026 23:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHu-0006VR-2f
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHq-0003Xz-S5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8423f626a65so1313802b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457337; x=1781062137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JOfj6lugaNnueZARjijIuArqjGyDWToOHa/a/cZAEH8=;
 b=zpM9NEGheQv37tHJ3/HqwvSjEXisQ0699ToLfk6dcjiYcOgnl4QvvRgask8WYrRugQ
 CDW5a3ipjQ9NQ9cgrkske/t9bAtplM0j/5ZcizIk+bnFG36d+9MS0lua0ieZ8xYvKp/w
 GbuIxsglor5xWjX3e8qkPn0UnwgId4UPRoXWAecxdt9+Tn5KodWQ0AsVKPTpFZ54JIv5
 spNJEFt/lA4cXrFIAi+Zn8kQzBocc5qTZa4SO1i2M0zU1rLEbZ4YCSZymt4Qtvswn/Rt
 NZ8+JdyZgHRnRcFQMEHh1p5OilobnzUz2/uwEhxaqNZosQuykTF6sy9nJsdnBSwXSMGb
 xS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457337; x=1781062137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOfj6lugaNnueZARjijIuArqjGyDWToOHa/a/cZAEH8=;
 b=hbsLz9ppSeFE8mmTAdbGoH9DTQaePdBOTsCYhsJs9SAkFRK1JGGvCZ+PyVBZUQKpg6
 2YoZSywSuADoXf5VlclPs81RgzZP8//0r9sA0YCAZOFpX33iZiamlZwDUcKCIu++v6Al
 qnRhAFKqvvUuRKvr/QNeu/L1vwNzqV8fr/5kQ0h0tJWkhlZKccxsvIyDgz+5Be505LbZ
 nR3sZz0UJ/JcYoG5F4Q0/CxcfzIdFiHs7/FdlSodsxNhH7Hi0A9ieaoNYk4eqq1FmuT+
 wdi1SZEp6HZ4xZV0XybqXTJ4ULQQvKrH/sV13cJyRhzA33znJct4ux1x4tPtX/oX5gr4
 TNbg==
X-Gm-Message-State: AOJu0YyhNPnGBajNhYN9SVHvKA2du6FGkRHbjHMGJ4Cly9iQ/T9pGiOi
 tiW+yhwKf+ZXWixyzNM/PlTobNVbXMwVmKeeZpF0/GePe+od69vYIdW3P6cpiNdDnqRHY8quXb2
 oFNjJJM4=
X-Gm-Gg: Acq92OHzvSW/nuShDC5g87FJFcfkpI3buj1KORFMKO+zVfQPaqdQFPIyu5xYNlAoDQ0
 Dk60rSpvgqqgr1bSM0+9Wk54Wzz5I5UySf6FU1E9V1HXEhlevrtTNUKD2tZ4GPNo+i/qE40+AES
 t9zk1S/KB0xvGlZWuAizIqcjV0Fy4BNzjUOjrX17U7CrvoJit/GJzmlRvSbJa/Ki56wMnpz+6hX
 GLxipW1PZ1dz545UNXzeF2EK0i/ehga2uJlsHPEvBQOmmcghsmfuznjxmA/erwk/rSK9w9Ivg4o
 E+cfvXjt4lk5kK670szTDlXwT+q3pBLrgMbAufcRtmW/2zclqDLXXgspqr75a6Gl5gzVVQh3pQa
 eD6DL7DTeiOcMyCyVx7uLBl6iIvtZxdTuihyKGhxaWmB6FmtfldXvoHG/AtwNUZzIkDbcmSkAO+
 accctQeC/JjnARSE6ey2/+C1UjWMo54H3EXUeD7O0=
X-Received: by 2002:a05:6a00:3c8f:b0:842:48ae:1d70 with SMTP id
 d2e1a72fcca58-84285010cc2mr1436920b3a.47.1780457336583; 
 Tue, 02 Jun 2026 20:28:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 00/45] target/arm: Implement FEAT_FP8
Date: Tue,  2 Jun 2026 20:28:09 -0700
Message-ID: <20260603032855.106930-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes for v9:
  - Include 3 arm patches from the fp internals patch set.
  - Generalize TRANS_FEAT_STREAMING_SME2 to TRANS_FEAT_STREAMING_IF,
    pulled from an in-progress FEAT_SVE2p2 tree.

Changes for v8:
  - 23 patches upstream
  - Rebase adjustments
  - Rewrite arm_init_fp_status per feedback

r~


Richard Henderson (45):
  target/arm: Use FloatParts64 in bfdotadd_ebf
  target/arm: Drop oddstatus from is_ebf and bfdotadd_ebf
  target/arm: Use FloatParts64 in f16_dotadd
  target/arm: Generalize TRANS_FEAT_STREAMING_SME2
  target/arm: Introduce arm_init_fp_status
  target/arm: Set e4m3_nan_is_snan
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
  target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
  target/arm: Implement FDOT (FP8 to FP32) for SVE
  target/arm: Enable FEAT_FP8DOT4, FEAT_SSVE_FP8DOT4 for -cpu max
  target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
  target/arm: Implement FDOT (FP8 to FP16) for SVE
  target/arm: Enable FEAT_FP8DOT2, FEAT_SSVE_FP8DOT2 for -cpu max
  target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
  target/arm: Implement FMMLA (FP8 to FP32) for SVE
  target/arm: Enable FEAT_F8F32MM for -cpu max
  target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
  target/arm: Implement FMMLA (FP8 to FP16) for SVE
  target/arm: Enable FEAT_F8F16MM for -cpu max

 target/arm/cpu-features.h        |  83 +++
 target/arm/helper-fp8.h          |  14 +
 target/arm/tcg/helper-defs.h     |   6 +
 target/arm/tcg/helper-fp8-defs.h |  40 ++
 target/arm/tcg/helper-sme-defs.h |   2 +-
 target/arm/tcg/translate-a64.h   |   1 +
 target/arm/tcg/translate.h       |   7 +-
 target/arm/tcg/vec_internal.h    |  12 +-
 linux-user/aarch64/elfload.c     |  13 +
 target/arm/cpu.c                 |  20 +-
 target/arm/tcg/cpu64.c           |  16 +
 target/arm/tcg/fp8_helper.c      | 858 +++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c      | 104 ++--
 target/arm/tcg/translate-a64.c   | 160 ++++++
 target/arm/tcg/translate-sme.c   |  71 ++-
 target/arm/tcg/translate-sve.c   | 245 ++++++++-
 target/arm/tcg/vec_helper.c      | 193 ++++---
 docs/system/arm/emulation.rst    |  11 +
 target/arm/tcg/a64.decode        |  39 ++
 target/arm/tcg/meson.build       |   1 +
 target/arm/tcg/sme.decode        |  25 +-
 target/arm/tcg/sve.decode        |  48 +-
 22 files changed, 1814 insertions(+), 155 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0


