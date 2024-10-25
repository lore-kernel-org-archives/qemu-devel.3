Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30226D0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3p-00040t-Tj; Fri, 25 Oct 2024 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3l-0003wo-Pj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3i-0007lE-89
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso14573155e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865576; x=1730470376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FpcQQjq66hc60h15t5XebYBsiuHjNC9wWkvbtWI3lC4=;
 b=Bt4+d1RniQy9YgpP3WXQGCvc+eQJOoxdns7iAdki09E63yR25ZgSlwsvLL8T5A+gYc
 YH2Z4vIwRKnaHGpEeKGnEby6RVKDjb5im55N58zbUwi0YN64nmK7P2ouv3mBqYQqtcWh
 bOa/jpXZ/qufE9BmzvEayhR8ttTsXC3qsqhweIoXI+nQRe/rOl84AiNBzr/Pg948WJv/
 kpVdDsaduIBYBsC1U2pkNQTPrPyuAQWqYtwYJSf4vHQ8SsyZljIHeC2BsOIan8dkGAW3
 5BNlH4H2rD8oTBDtTflzsTR+wVqQYI2cl6kwQANrNexyw3udn+SGy4j7ULKNfoC6Wjmv
 vm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865576; x=1730470376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FpcQQjq66hc60h15t5XebYBsiuHjNC9wWkvbtWI3lC4=;
 b=cAUc3qxDaC7KQGvMKLmojqitTYIzqgOJx0eAKD3ELKPM086mvkxFBGLcgD/2416NEN
 Gern69Fe9Z8boDBKs3dT+2OaOSo9FmMXtNic2gTXFoibBfH8BzSaB5omWJvtWQ+xanrA
 JV9Mv44C0nt2gPWlpxT5Sy9k8A0Tvl1PMdc/nXwDESv3fcwolO7ECKpKN9V44RtUrgZX
 iTyzNbq2Xq/+lTSSv6SFvpue9PIVgWnManbs71dIaqMtKKdRvjgo5WQZnf2msJ6eWnfF
 p0+RZQmMweCFU3FVdimqXuTYkCvy4Hdgkefqo60hBVe0epF2cYNNoLUMCEgc8azjzuIu
 gJDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzycRSxY2gCRjZfEUOa8p+ftEWTpr2cS4G0Vv3O8kficV6FHJwEXOIzYR2O9LexBPRvKhKPnSJAC2s@nongnu.org
X-Gm-Message-State: AOJu0YzN17fXkf6NFKZgY/bbd2PE9EWHz32DCI2qyhH97lMUiHHQifoV
 4cC9tK9xT3Hl+sivR9/J/EnMGoT8FoP/9IdyZJXU/4i7YtTNj0U1oovFltXdfM0=
X-Google-Smtp-Source: AGHT+IH7LJ/mqCUO19u/3mAYHeI4tLr5gb2ZtoYG2LWPCYbt06cffRXNGH3Nlz2ob5gZraHXDu5Eig==
X-Received: by 2002:a05:600c:35c3:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-4318b5a42edmr44666555e9.6.1729865576232; 
 Fri, 25 Oct 2024 07:12:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:12:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 00/21] softfloat: Set 2-NaN propagation rule in float_status,
 not at compile time
Date: Fri, 25 Oct 2024 15:12:33 +0100
Message-Id: <20241025141254.2141506-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

IEEE 758 does not define a fixed rule for which NaN to pick as the
result if both operands of a 2-operand operation are NaNs.  As a
result different architectures have ended up with different rules for
propagating NaNs.

QEMU currently hardcodes the NaN propagation logic into the binary,
because pickNaN() has an ifdef ladder for different targets.  We want
to make the propagation rule instead be selectable at runtime,
because:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting the guest
   select a NaN propagation rule at runtime
 * x86 specifies different propagation rules for x87 FPU ops and for
   SSE ops, and specifying the rule in the float_status would let us
   emulate this, instead of wrongly using the x87 rules everywhere
 * xtensa allows selection of NaN propagation rule at runtime;
   currently we implement this with the use_first_nan flag which
   is only used by xtensa; providing a general facility will let us
   remove this limited-purpose handling
                                                           
This series switches pickNaN away from the ifdef ladder. Instead
targets must always set a 2-NaN propagation rule via the new
set_float_2nan_prop_rule(), unless they are using default_nan_mode.
Patch 1 implements this in core softfloat (with a transitional
fallback to "use the old ifdef ladder logic" if the target doesn't
specify the propagation rule). Then subsequent patches convert
all the targets to set the rule explicitly. The final patch then
removes the remnants of the transitional logic.

I have included a couple of minor fixes for sparc, xtensa, m68k.
This is intended as a no-behaviour-change patchset, so although there
are a few places where I have noticed that the current behaviour
is not correct I have left these as TODO comments. A summary of
those TODOs and other oddities I have noticed but not tried to
tackle is:

 * hppa really ought to implement a CPU reset method
 * alpha also doesn't implement CPU reset
 * ppc sets tininess_before_rounding on fp_status but not on
   vec_status, so its behaviour there will vary between
   guest instructions; unclear to me if this is intended
 * x86 should set the float_2nan_prop_ab rule on env->sse_status
   (and maybe env->mmx_status, though 3DNow! insns don't handle
   NaNs in a documented way anyway)
 * alpha never had a case in the ifdef ladder so it uses the
   x87 propagation rule. It ought to use float_2nan_prop_ba.
 * openrisc didn't have an ifdef and also uses the x87 rule;
   this is probably wrong but I couldn't find anything documenting
   what it actually does
 * rx didn't have an ifdef and also uses the x87 rule;
   again, probably wrong

The next stage after this patchset, obviously, is to do the
same thing with pickNaNMulAdd(). That is a little trickier
because currently we ask it to do two things:
 * handle the "infinity * zero + NaN" corner case
 * pick a NaN when more than one operand is a NaN
My intention is to separate these out so that targets specify
both separately. This gives more orthogonality (e.g. Arm,
MIPS with !snan_bit_is_one and loongarch64 all have the same
"prefer SNaN over QNaN, prefer C over A over B" NaN selection
logic but they have different ideas about the infzero case).

(Once pickNaNMulAdd() is converted we will be able to remove
the current xtensa-specific use_first_nan flag.)

thanks
-- PMM

Peter Maydell (21):
  softfloat: Allow 2-operand NaN propagation rule to be set at runtime
  tests/fp: Explicitly set 2-NaN propagation rule
  target/arm: Explicitly set 2-NaN propagation rule
  target/mips: Explicitly set 2-NaN propagation rule
  target/loongarch: Explicitly set 2-NaN propagation rule
  target/hppa: Explicitly set 2-NaN propagation rule
  target/s390x: Explicitly set 2-NaN propagation rule
  target/ppc: Explicitly set 2-NaN propagation rule
  target/m68k: Explicitly set 2-NaN propagation rule
  target/m68k: Initialize float_status fields in gdb set/get functions
  target/sparc: Move cpu_put_fsr(env, 0) call to reset
  target/sparc: Explicitly set 2-NaN propagation rule
  target/xtensa: Factor out calls to set_use_first_nan()
  target/xtensa: Explicitly set 2-NaN propagation rule
  target/i386: Set 2-NaN propagation rule explicitly
  target/alpha: Explicitly set 2-NaN propagation rule
  target/microblaze: Move setting of float rounding mode to reset
  target/microblaze: Explicitly set 2-NaN propagation rule
  target/openrisc: Explicitly set 2-NaN propagation rule
  target/rx: Explicitly set 2-NaN propagation rule
  softfloat: Remove fallback rule from pickNaN()

 include/fpu/softfloat-helpers.h   |  11 +++
 include/fpu/softfloat-types.h     |  38 ++++++++
 target/i386/cpu.h                 |   3 +
 target/mips/fpu_helper.h          |  22 +++++
 target/xtensa/cpu.h               |   6 ++
 linux-user/arm/nwfpe/fpa11.c      |  18 ++++
 target/alpha/cpu.c                |  11 +++
 target/arm/cpu.c                  |  25 +++--
 target/hppa/fpu_helper.c          |   6 ++
 target/i386/cpu.c                 |   4 +
 target/i386/tcg/fpu_helper.c      |  40 ++++++++
 target/loongarch/tcg/fpu_helper.c |   1 +
 target/m68k/cpu.c                 |  16 +++
 target/m68k/fpu_helper.c          |   1 +
 target/m68k/helper.c              |   4 +-
 target/microblaze/cpu.c           |  10 +-
 target/mips/cpu.c                 |   2 +-
 target/mips/msa.c                 |  17 ++++
 target/openrisc/cpu.c             |   6 ++
 target/ppc/cpu_init.c             |   8 ++
 target/rx/cpu.c                   |   7 ++
 target/s390x/cpu.c                |   1 +
 target/sparc/cpu.c                |  10 +-
 target/sparc/fop_helper.c         |  10 +-
 target/xtensa/cpu.c               |   2 +-
 target/xtensa/fpu_helper.c        |  35 ++++---
 tests/fp/fp-bench.c               |   2 +
 tests/fp/fp-test-log2.c           |   1 +
 tests/fp/fp-test.c                |   2 +
 fpu/softfloat-specialize.c.inc    | 156 +++++++++++-------------------
 30 files changed, 346 insertions(+), 129 deletions(-)

-- 
2.34.1


