Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D2C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkV-00078Z-Dh; Mon, 27 May 2024 17:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkT-00077B-Iv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkR-0003b4-Ps
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so104892b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844754; x=1717449554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDglsqAcp0SxDGAaJ0T9OIIUXwIF6C0mIgo/Mt5cf+M=;
 b=YLc0A6zKzWchE2US3Gd3Q8QUaWV0zROyW0KOLtibKZIqwigdIHrow7kR3f8CRqfrkT
 z5+3Nj5LGPnfWx44fhH4WwaklaLgKjca2xGvsOFDzhECG7UCUbIKWblniNdilafzQvPC
 6DOAE/24+izawhlZJBA6HWabqtRuKF2YY5BklyyBT1NSLSrE7pOMUxdoaVd4/X32fyGU
 miQrXyRkT8h4pPeQYsSVeVLr7KQo5f9Urnwb4XKYxam7i2Mv40RpFnEKuewF+lz4g/Ch
 1CDcGFjAZtFZI3xHX7sVa7ZXd4ppJheAiEK2731keSVehAC5kiLh4NS0OWY/wJXyx/iu
 SXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844754; x=1717449554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDglsqAcp0SxDGAaJ0T9OIIUXwIF6C0mIgo/Mt5cf+M=;
 b=ONKjo6RIHa6gXN0nWzdV1UQUtdA/R0yhpBp6hpB1YOD7qJOteHvC7ZoSVqlYU31fi5
 FwjYL3Xc0ADDdJR0CPlZQCuwrC5wdsLh2kiw/9+LoIthQqAMb9yU4MS8jJGLNmxXjs36
 KBfQuMxBXP/xZrZWxOiNZlr98bcU3arFmNkCRlpDFOVgj/AB3EksILqvsQ17Eqxg4H1N
 KdMxAXxbtoMeqjWxnxTSoda2n2Z81m9JhnKzaAlzgpOzx8fYyUOIXi8dCqhOhdvkzk3T
 7IX1AARbJWmm1SCOcJlkJu64BHvJxja5ftGqCDzQWJl9lejWRUWM1OVMUyvsoW7tRnHa
 tojg==
X-Gm-Message-State: AOJu0YzGugpfhw+/wXFo0Qm8aK9MgR3y06yyAd2QI+rBTIBSCOSdeAex
 EjDFnlQSr/hVrlnapFuFbAu54nMIo9ADCjoZah48R6R8Sgk/HZQwyywfrK4XwFOHfrRl/DXvdxY
 w
X-Google-Smtp-Source: AGHT+IErg+qIUH1la6jMJCMYQHJ7X+su+ekX8gGF505KON0K6xXTVrgeGfVYi+PkrOivsukXJL+70Q==
X-Received: by 2002:a05:6a20:258e:b0:1ad:89e:21b5 with SMTP id
 adf61e73a8af0-1b212d5bf99mr12122336637.15.1716844754056; 
 Mon, 27 May 2024 14:19:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 00/18] tcg/loongarch64: Support v64 and v256
Date: Mon, 27 May 2024 14:18:54 -0700
Message-Id: <20240527211912.14060-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some guests only have, or additionally have, 64-bit vectors.
For example arm, mips, sparc.  So it's best to enable this
whenever we can.  As with tcg/i386, use 64-bit loads and stores
but 128-bit vector registers.

If LASX is available (all current loongarch64 cpus?), we have
256-bit vectors as well.  Useful for guests that support such
things, e.g. aarch64, i386, and loongarch64 itself.


r~


Richard Henderson (18):
  tcg/loongarch64: Import LASX, FP insns
  tcg/loongarch64: Use fp load/store for I32 and I64 into vector regs
  tcg/loongarch64: Handle i32 and i64 moves between gr and fr
  tcg/loongarch64: Support TCG_TYPE_V64
  util/loongarch64: Detect LASX vector support
  tcg/loongarch64: Simplify tcg_out_dup_vec
  tcg/loongarch64: Support LASX in tcg_out_dup_vec
  tcg/loongarch64: Support LASX in tcg_out_dupm_vec
  tcg/loongarch64: Use tcg_out_dup_vec in tcg_out_dupi_vec
  tcg/loongarch64: Support LASX in tcg_out_dupi_vec
  tcg/loongarch64: Simplify tcg_out_addsub_vec
  tcg/loongarch64: Support LASX in tcg_out_addsub_vec
  tcg/loongarch64: Split out vdvjvk in tcg_out_vec_op
  tcg/loongarch64: Support LASX in tcg_out_{mov,ld,st}
  tcg/loongarch64: Remove temp_vec from tcg_out_vec_op
  tcg/loongarch64: Split out vdvjukN in tcg_out_vec_op
  tcg/loongarch64: Support LASX in tcg_out_vec_op
  tcg/loongarch64: Enable v256 with LASX

 host/include/loongarch64/host/cpuinfo.h |    1 +
 tcg/loongarch64/tcg-target.h            |    4 +-
 util/cpuinfo-loongarch.c                |    1 +
 tcg/loongarch64/tcg-insn-defs.c.inc     | 6181 ++++++++---------------
 tcg/loongarch64/tcg-target.c.inc        |  575 ++-
 5 files changed, 2461 insertions(+), 4301 deletions(-)

-- 
2.34.1


