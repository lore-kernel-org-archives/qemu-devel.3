Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B53CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OD-00008S-8T; Thu, 07 May 2026 19:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OB-00007d-Ju
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:19 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8O9-0000yO-G5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:19 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-47cbd444fd0so863984b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197456; x=1778802256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GFqY0zRt34eX9S7a/lXWXkkOa23/FWSFelAt+6WDK/g=;
 b=lqN6O4PxYwd27yuyPozyJM2D2btdh5t4Lhzn/x8dc+nKh8qmh/LuY8l4UhaJ27QZ5q
 QUKCyALz6EaBI/8VAos7G9e9BeYmTIcdpHX4UuaZNJEU9vWQxcdkTGOJuoaDtjq9YXEm
 3ZB11vrfFzEbmkyVvAgY9LKhptf3/UJUCuqQZnXx3c0HToaWfDmBKLy0bzWwTG0cRIXh
 PPVzjj6J+3JREksdoeYIxRu1kVflQwunKh47HH7t9yAhnwQflmic5rsvmdUgTKQbEuZG
 ZVcGzq5mqK7uy+sfb+xerVhXWx0MQhtEjUrp4jODs+0NPkOeZz0Yfql3pN7JtYA2+q9s
 QgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197456; x=1778802256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFqY0zRt34eX9S7a/lXWXkkOa23/FWSFelAt+6WDK/g=;
 b=ZdbmOziMf0LZ4D8MumjDhSlUOiAtzfAOcf/Qbu4dVcdLqYh3W7AhkRzw8Oy9fnzcRE
 UP0YWt4hlhNBCJsGbMzxZJxztWBBP14psRP5ZfQoorh3S4U73DWsuE6N5Vgfm0ttAxyf
 ZItzH1FKHVwTYASaeI74bESmc4hwmECmWzGoAMvFIpUc6CofC4L0Rg8tcxqvwjlqxnlE
 DRpYrccHmVLXibM7ZvPfIe8IGTYrzTXD2TDt1+1I3PWLvElHga/KEqBNHxOUPRArZhpw
 6ThFYJrdWINxjN/dw9Z3I88EY0OiEHd9zkC3q+xw36C4CAPcA+f5W+ux49ckcHCzIQ6Z
 3jAQ==
X-Gm-Message-State: AOJu0YzOYJIjNBSWLlNDXb/lHFr9hu2Fd3YXVH+28Crx/3D5iKrDMSxW
 eGBOxaJuHagOxW7kZQCAEFX6fxJj8QAubF6Nt8y7uQtt5FHR+Rgdj+75/x74pEsle2QNcFfVvxl
 D1qe2
X-Gm-Gg: AeBDievPka7ih3Rndnjrwuv1+jY8nHyG8fCPi9RVMV8QZKyCGjDX+y2q5XbokR806R0
 6y9Bd3gfa2xWn8t1BcA+7ok27qcnBLHwZSu5WwuZqiAaElIpzjcxHuCVSUpwR8b5kU3t6EGG80g
 mizoGtz/6D1QVx1y1Zqk16jF3tMOwVei+41rnXUX3s4ZGr1FOrIJ56xVBmA9yWRskN+VMLpq6Zl
 Q1L8/RPUkAhZVWsRfl+fNKOE/AhyJJSKjrg7dn89zK+5pE2Ocw9sHyUgra8TfkRlpDU3AXmKEju
 Ykj2MKCOFHR/6rS4ToC96tFs0J7eht335ypHx/CM/O7Fbl41yJqSV4B9q+EO5JHA/AbZeF3D22r
 BW4pJyJPGVxfvPwlKgx4LNzHooCwUeotpnUg9aFcZV1GyE5A29rCYU/nzL5u/ll5Zg8FG/Rx20C
 AEkxGOg3s/ki/pNlT3rPPt+cONZvQ2HkDnGJ4VamYqiW1VIw==
X-Received: by 2002:a05:6808:1822:b0:463:faa3:8dda with SMTP id
 5614622812f47-480421f80d0mr6238706b6e.13.1778197455519; 
 Thu, 07 May 2026 16:44:15 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 00/60] target/arm: Implement FEAT_FP8
Date: Thu,  7 May 2026 18:43:13 -0500
Message-ID: <20260507234413.643512-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Based-on: 20260507160959.449170-1-richard.henderson@linaro.org
("[PATCH v3 00/11] fpu: Export some internals for targets")

Changes for v4:
  - TF-A firmware update for FEAT_FPMR
  - Rewrite decode/encode of FP8 data types
  - Rewrite FEAT_FP8FMA helpers
  - Enable FEAT_FP8DOT{4,2}
  - Enable FEAT_FP8F{32,16}MM

This completes the set of 8-bit floating point features.


r~


Pierrick Bouvier (1):
  tests/functional/aarch64/rme: update images to support FEAT_FP8

Richard Henderson (59):
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

 target/arm/cpregs.h                          |   5 +
 target/arm/cpu-features.h                    | 137 +++
 target/arm/cpu.h                             |  52 +-
 target/arm/helper-fp8.h                      |  14 +
 target/arm/internals.h                       |  13 +-
 target/arm/tcg/helper-a64-defs.h             |  11 +
 target/arm/tcg/helper-defs.h                 |   6 +
 target/arm/tcg/helper-fp8-defs.h             |  40 +
 target/arm/tcg/helper-sme-defs.h             |   2 +-
 target/arm/tcg/helper-sve-defs.h             |  14 +
 target/arm/tcg/translate-a64.h               |   1 +
 target/arm/tcg/translate.h                   |  10 +
 target/arm/tcg/vec_internal.h                |  19 +
 target/arm/vector-type.h                     |  44 +
 target/arm/helper.c                          |  43 +-
 target/arm/machine.c                         |  20 +
 target/arm/tcg/cpu64.c                       |  24 +
 target/arm/tcg/fp8_helper.c                  | 867 +++++++++++++++++++
 target/arm/tcg/hflags.c                      |  41 +
 target/arm/tcg/sme_helper.c                  |   8 +-
 target/arm/tcg/sve_helper.c                  |   8 +
 target/arm/tcg/translate-a64.c               | 186 ++++
 target/arm/tcg/translate-sme.c               | 109 ++-
 target/arm/tcg/translate-sve.c               | 235 +++++
 target/arm/tcg/vec_helper.c                  |  66 ++
 target/arm/tcg/vec_helper64.c                |  51 ++
 docs/system/arm/emulation.rst                |  13 +
 target/arm/cpu-sysregs.h.inc                 |   2 +
 target/arm/tcg/a64.decode                    |  47 +
 target/arm/tcg/meson.build                   |   1 +
 target/arm/tcg/sme.decode                    |  36 +-
 target/arm/tcg/sve.decode                    |  50 +-
 tests/functional/aarch64/test_rme_sbsaref.py |   7 +-
 tests/functional/aarch64/test_rme_virt.py    |   7 +-
 34 files changed, 2124 insertions(+), 65 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/vector-type.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0


