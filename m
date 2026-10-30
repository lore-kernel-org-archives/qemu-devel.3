Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sayjgdpD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTJ-0002s5-26; Fri, 30 Oct 2026 09:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0002YY-Hh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:06 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSd-0005Ud-Ad
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:02 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4a75171af39so160846fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366157; x=1793970957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VoVzZ7hrtYaEIldQXHm6/YUYxp8q39SG10tNubAOMSU=;
 b=sayjgdpDnJ0VW00wvttBJp5r9AK9P7inyoujXJEyX8ZSVpDG7sH424S7S+7g6AcXBL
 YFzfdHqh5rJLSTgq2nkDseeRdZ8QLtxuDiR4J3JGjqd/z8KvYwQIYH0VBAtrjcO5sBM6
 QWsFuye9HWyEUghJ5XvODpSKzJCA04WxTyomrmb9yTUSbo6Y8706zfk3cA3GmbwGenMh
 DBoiPIyTVd8KmvelECy8EdEhKP4S1iDlOjRt9OKeJPdPsx5nSM7BYcUB9R/K874JB9Pf
 HMSEN11ekzrZ0cpYzUeNlVk8Hb5iJf4OaYze1GKmkE/rFvqldWHsPfZihLuWulvo79X6
 H5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366157; x=1793970957;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VoVzZ7hrtYaEIldQXHm6/YUYxp8q39SG10tNubAOMSU=;
 b=bWjCebqyo42r8pxhvmUZgmx5lhyT4qvv5QTKxJlYHdRq81RJtD5E/H3iRW/IOhhSub
 /exVq4pGUe9lkkm8pjXEuEDtLjYcqqreNFCJ8xa7/nJTasjSD+ViF3hTPDhb8gdNK9bh
 ABMoGoH58raI4DKU88aFvYQXqX5NBbwuXMjs5vB6256YrZBLmfWzpvM+YRGk1bL2BswU
 nz9vhX5dMKpKOc0swoVuRcY0LMLSn3bMzUHJUobCwbOeRslKDS1JW4E6DfOwF1pNdYtU
 SqIEulhDhMaoZR+1YvREYVUAYKBG71OUs9pyB8K0Pqjbd21/Q3NZTeCATkTD947pR5yw
 NuBQ==
X-Gm-Message-State: AFq9FYJF5GQXnhUnxmB3zYkBDCO2g+cRwOycJyFv9Fm6x2YtMQVgPf4k
 vu47EoResyZpvimX33OlXNZAp1hbWiUYzdimsn3XwHoeu2jBdcek0rF3kDotFpbukyVXHLip/cs
 Z+uNh
X-Gm-Gg: AYBFou2VFjq8p0uVImCmRl+YPDrt/0E2JDkl3P0Ij/THpmAD1jPaHLhzDkTX5So+lhC
 Fyr3j/DQPRJfOFHwSq8O1WIdCpw31ehanUk195S+kwyY2b95yP8d2lkUIAYlT93s9FpcxsAsSHF
 tPi54FA0ZwGIbKzcIY1HEqyKre6XEKmSMJ4lbSOqDq1eeU23vbdPKr7mPcuOzt/QHUJcd+0zlLL
 geXjYN318136ysBKGbA78ODb+EGTgpJWjMEV6vl1WxOtYbtkMXIqtzsxDf3FVyEMYYILIqCHulU
 tGES+zEjmOgMxWM4MqhFFzEC13043JnqgfnLUWx1iLjm4UJbGbtLRom+rsYdqwjVAlId/oaFFBp
 jPcrMeVt0nAw7FzVVWO3ADZwg69XmV9TNn1C2Waq0jSnZujS/uKYQH7SQanSq3RILU/Hu0PNaV/
 TTVf77+EOVRZJT7pRA0+5pZnwk8ba/on3Rv097ZLBA5LDeE3iZzZ8nutcNS4s9tj8fvg9ttEgr7
 ajiSFcCc5Hi+dmi1dvcX7ieNb3qSox/14MjI5eYAc6ueoj/9cP1xguLmqISIupGmYIymqUd6XGP
 oHyi28lZeAcdSX3Xdvh7+7CouESjc/PRfYjWN1wxmWm78WBrP24=
X-Received: by 2002:a05:6870:bacd:b0:49e:6fbc:cd5b with SMTP id
 586e51a60fabf-4a9077a2827mr1468477fac.55.1793366156106; 
 Fri, 30 Oct 2026 06:15:56 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:15:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] tcg patch queue 20261030
Date: Fri, 30 Oct 2026 08:15:35 -0500
Message-ID: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 61436f5ff1c4e5ee8f60fa1a37962a60f73ea7a4:

  Merge tag 'pbouvier/pr/dockerfiles-20261029' of https://gitlab.com/p-b-o/qemu into staging (2026-10-29 17:09:01 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261030

for you to fetch changes up to 0e68878f962a2117fc5de8a0025f3064bf5cbe9a:

  tcg/s390x: Implement INDEX_op_lea (2026-10-30 07:06:16 -0500)

----------------------------------------------------------------
accel/tcg: Fix false awakening of gdb
accel/tcg: Do not flush and retry in place in tb_gen_code
tcg: Adjust NONNULL annotation on *_diff functions
tcg: Add tcg_gen_lea_{i32,i64,tl}
target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
target/loongarch: Use tcg_gen_lea_tl for ALSL
target/riscv: Use tcg_gen_lea_tl for SH*ADD
target/s390x: Use tcg_gen_lea_i64 in get_address
target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V opcodes

----------------------------------------------------------------
Aleksandr Sergeev (1):
      accel/tcg: Fix false awakening of gdb

Philippe Mathieu-Daudé (1):
      target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V opcodes

Richard Henderson (16):
      tcg: Adjust NONNULL annotation on *_diff functions
      tcg: Add INDEX_op_lea
      tcg: Add tcg_gen_lea_{i32,i64,tl}
      tcg/optimize: Handle INDEX_op_lea
      target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
      target/loongarch: Use tcg_gen_lea_tl for ALSL
      target/riscv: Use tcg_gen_lea_tl for SH*ADD
      target/s390x: Use tcg_gen_lea_i64 in get_address
      target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
      tcg/x86_64: Introduce TCG_REG_NONE
      tcg/x86_64: Implement INDEX_op_lea
      tcg/loongarch64: Import SLADD insns
      tcg/loongarch64: Implement INDEX_op_lea
      tcg/aarch64: Implement INDEX_op_lea
      tcg/riscv64: Implement INDEX_op_lea
      tcg/s390x: Implement INDEX_op_lea

Stian Halseth (1):
      accel/tcg: Do not flush and retry in place in tb_gen_code

 docs/devel/tcg-ops.rst                            |  4 ++
 include/tcg/tcg-op.h                              |  2 +
 include/tcg/tcg-opc.h                             |  1 +
 include/tcg/tcg.h                                 |  5 +-
 tcg/aarch64/tcg-target-has.h                      |  3 +
 tcg/loongarch64/tcg-target-has.h                  |  3 +
 tcg/ppc64/tcg-target-has.h                        |  3 +
 tcg/riscv64/tcg-target-has.h                      | 11 ++++
 tcg/s390x/tcg-target-has.h                        |  4 ++
 tcg/sparc64/tcg-target-has.h                      |  3 +
 tcg/tci/tcg-target-has.h                          |  3 +
 tcg/x86_64/tcg-target-con-set.h                   |  1 +
 tcg/x86_64/tcg-target-has.h                       |  3 +
 tcg/x86_64/tcg-target.h                           |  3 +
 include/tcg/tcg-op-def.h.inc                      |  1 +
 accel/tcg/cpu-exec.c                              | 20 +++---
 accel/tcg/translate-all.c                         | 11 ++--
 target/alpha/translate.c                          | 20 ++----
 target/i386/tcg/translate.c                       | 27 ++++----
 target/mips/tcg/mxu_translate.c                   |  3 +-
 target/mips/tcg/translate_addr_const.c            |  6 +-
 target/s390x/tcg/translate.c                      |  4 +-
 tcg/optimize.c                                    | 66 ++++++++++++++++++-
 tcg/tcg-op.c                                      | 43 ++++++++++++
 tcg/tcg.c                                         | 22 +++++++
 target/loongarch/tcg/insn_trans/trans_arith.c.inc |  4 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc       |  5 +-
 tcg/aarch64/tcg-target.c.inc                      | 11 ++++
 tcg/loongarch64/tcg-insn-defs.c.inc               | 30 ++++++++-
 tcg/loongarch64/tcg-target.c.inc                  | 15 +++++
 tcg/ppc64/tcg-target.c.inc                        |  3 +
 tcg/riscv64/tcg-target.c.inc                      | 17 +++++
 tcg/s390x/tcg-target.c.inc                        | 14 ++++
 tcg/sparc64/tcg-target.c.inc                      |  3 +
 tcg/tci/tcg-target.c.inc                          |  4 ++
 tcg/x86_64/tcg-target.c.inc                       | 79 ++++++++++++++---------
 36 files changed, 363 insertions(+), 94 deletions(-)

