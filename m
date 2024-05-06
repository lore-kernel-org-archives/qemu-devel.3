Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5F5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mm2-0007XK-IY; Sun, 05 May 2024 21:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm1-0007XB-9r
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:09 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mlz-0002PA-8R
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2b432be5e80so919826a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957445; x=1715562245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xGhq9LzTfkszi3eC9eGpwYSHg3GUJVHkvKWRYudIa4w=;
 b=LItZTQV0vdNqFFXK+X3xzRokJFcGyzfqVfeGnCHtd5I9OjkOZRZSjTWgnLQ2zw4Hwz
 mHLHomdNeW/kOt7jMpGfcB1Jx4+2elhLTZryoY8PyMgRCK/I2NX/Kxaxuuw0Oi/T1XWX
 11pJAqlpZ4z8+ayNF9wbFVb9lXqPgzWVCi6qu73RJzab7NaH+8QU4fxNDk6IqeEvUPX6
 OYhp56Hyx2AE5PUUvNQqph6RoBl4yW3UyDA8NgLMpdhoymGs4rw/BkyMc0e8LtDg9WO/
 m0ilEYcn+zmrWmvm79Gmeq1bhw0s4/9LSodKONLPMPSz+FN7rDr0iTTP1FPw98aLUSfT
 P1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957445; x=1715562245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xGhq9LzTfkszi3eC9eGpwYSHg3GUJVHkvKWRYudIa4w=;
 b=faVGF/13bBaBAD791vTKDGRiI0etAkVOVgo+vuEwAQ+a6j/fANoq5vn7gNTLe/Ep7G
 FBNOEGXgtSlk1rSkqB4sSd2TBDVV7uBSRzJlGylJIYb861lBiSwOKi8j1bEsUyJKwB8R
 k7YHOs0CiJAzy2rvgG9KuiALFHOSO+yJgtM+C7Bhgj7bmwU10rnyxg6Yjhj4uYbyyQ9E
 CPrrMixi//r8Qy9zIpKKx56Sq34FinoQJgLM2owlpHRa6Q5tGFc7jMm/tZzQtvKi3QpN
 uhYbKQkGYpDxNZR/ON+46INZHRkh3o9TUMSFldUJreNgxXtR6VpYPqL2dekEq0BGZC5J
 KyqQ==
X-Gm-Message-State: AOJu0YxCKuA/rG+TDdxQrVFQ8eDpg9pj52gdgu5bGlKYy4GmPeairQii
 aU3E4ghNWiby/NVRQlgj9Xk+2HdJGEH0NacVV00upmVLfRdrEt9glpED9cPq7aqMyMKcOq/L3Mv
 9
X-Google-Smtp-Source: AGHT+IHptYwh1W4EZKPXWPNC89Pl6PqwcLFGqnffSiqjgO3RIB0AubhONlTwUXvUMShf205f0hm+cA==
X-Received: by 2002:a17:90a:f597:b0:2b3:79ad:856d with SMTP id
 ct23-20020a17090af59700b002b379ad856dmr7764929pjb.48.1714957445381; 
 Sun, 05 May 2024 18:04:05 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/57] target/arm: Convert a64 advsimd to decodetree (part 1)
Date: Sun,  5 May 2024 18:03:06 -0700
Message-Id: <20240506010403.6204-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Based-on: 20240424170908.759043-1-richard.henderson@linaro.org
("[PATCH 0/5] tcg: Misc improvements")

In the process, convert more code to gvec as well -- I will need
the gvec code for implementing SME2.  I guess this is about 1/3
of the job done, but there's no reason to wait until the patch
set is completely unwieldy.


r~


Richard Henderson (57):
  target/arm: Split out gengvec.c
  target/arm: Split out gengvec64.c
  target/arm: Convert Cryptographic AES to decodetree
  target/arm: Convert Cryptographic 3-register SHA to decodetree
  target/arm: Convert Cryptographic 2-register SHA to decodetree
  target/arm: Convert Cryptographic 3-register SHA512 to decodetree
  target/arm: Convert Cryptographic 2-register SHA512 to decodetree
  target/arm: Convert Cryptographic 4-register to decodetree
  target/arm: Convert Cryptographic 3-register, imm2 to decodetree
  target/arm: Convert XAR to decodetree
  target/arm: Convert Advanced SIMD copy to decodetree
  target/arm: Convert FMULX to decodetree
  target/arm: Convert FADD, FSUB, FDIV, FMUL to decodetree
  target/arm: Convert FMAX, FMIN, FMAXNM, FMINNM to decodetree
  target/arm: Expand vfp neg and abs inline
  target/arm: Convert FNMUL to decodetree
  target/arm: Convert FMLA, FMLS to decodetree
  target/arm: Convert FCMEQ, FCMGE, FCMGT, FACGE, FACGT to decodetree
  target/arm: Convert FABD to decodetree
  target/arm: Convert FRECPS, FRSQRTS to decodetree
  target/arm: Convert FADDP to decodetree
  target/arm: Convert FMAXP, FMINP, FMAXNMP, FMINNMP to decodetree
  target/arm: Use gvec for neon faddp, fmaxp, fminp
  target/arm: Convert ADDP to decodetree
  target/arm: Use gvec for neon padd
  target/arm: Convert SMAXP, SMINP, UMAXP, UMINP to decodetree
  target/arm: Use gvec for neon pmax, pmin
  target/arm: Convert FMLAL, FMLSL to decodetree
  target/arm: Convert disas_simd_3same_logic to decodetree
  target/arm: Improve vector UQADD, UQSUB, SQADD, SQSUB
  target/arm: Convert SUQADD and USQADD to gvec
  target/arm: Inline scalar SUQADD and USQADD
  target/arm: Inline scalar SQADD, UQADD, SQSUB, UQSUB
  target/arm: Convert SQADD, SQSUB, UQADD, UQSUB to decodetree
  target/arm: Convert SUQADD, USQADD to decodetree
  target/arm: Convert SSHL, USHL to decodetree
  target/arm: Convert SRSHL and URSHL (register) to gvec
  target/arm: Convert SRSHL, URSHL to decodetree
  target/arm: Convert SQSHL and UQSHL (register) to gvec
  target/arm: Convert SQSHL, UQSHL to decodetree
  target/arm: Convert SQRSHL and UQRSHL (register) to gvec
  target/arm: Convert SQRSHL, UQRSHL to decodetree
  target/arm: Convert ADD, SUB (vector) to decodetree
  target/arm: Convert CMGT, CMHI, CMGE, CMHS, CMTST, CMEQ to decodetree
  target/arm: Use TCG_COND_TSTNE in gen_cmtst_{i32,i64}
  target/arm: Convert SHADD, UHADD to gvec
  target/arm: Convert SHADD, UHADD to decodetree
  target/arm: Convert SHSUB, UHSUB to gvec
  target/arm: Convert SHSUB, UHSUB to decodetree
  target/arm: Convert SRHADD, URHADD to gvec
  target/arm: Convert SRHADD, URHADD to decodetree
  target/arm: Convert SMAX, SMIN, UMAX, UMIN to decodetree
  target/arm: Convert SABA, SABD, UABA, UABD to decodetree
  target/arm: Convert MUL, PMUL to decodetree
  target/arm: Convert MLA, MLS to decodetree
  target/arm: Tidy SQDMULH, SQRDMULH (vector)
  target/arm: Convert SQDMULH, SQRDMULH to decodetree

 target/arm/helper.h             |  164 +-
 target/arm/tcg/helper-a64.h     |   12 +
 target/arm/tcg/translate-a64.h  |   18 +
 target/arm/tcg/translate.h      |   95 +
 target/arm/tcg/a64.decode       |  416 +++-
 target/arm/tcg/neon-dp.decode   |   37 +-
 target/arm/tcg/gengvec.c        | 2308 +++++++++++++++++
 target/arm/tcg/gengvec64.c      |  367 +++
 target/arm/tcg/neon_helper.c    |  511 +---
 target/arm/tcg/translate-a64.c  | 4080 ++++++++++---------------------
 target/arm/tcg/translate-neon.c |  254 +-
 target/arm/tcg/translate-sve.c  |  145 +-
 target/arm/tcg/translate-vfp.c  |   54 +-
 target/arm/tcg/translate.c      | 1588 ------------
 target/arm/tcg/vec_helper.c     |  349 ++-
 target/arm/vfp_helper.c         |   30 -
 target/arm/tcg/meson.build      |    2 +
 17 files changed, 5121 insertions(+), 5309 deletions(-)
 create mode 100644 target/arm/tcg/gengvec.c
 create mode 100644 target/arm/tcg/gengvec64.c

-- 
2.34.1


