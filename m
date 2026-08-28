Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD981C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jj-0000yp-3s; Fri, 28 Aug 2026 18:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jh-0000yC-FS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:57 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jf-0004Ln-PN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:57 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2406914a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957094; x=1788561894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UjsF6O9PSmRI1N2dTiPjzravc5biEaOJFy5Mo1UxfUw=;
 b=betGVT1rIAUVhSITi2rE10dnEsukJdaK7FgoLhm1ZR/+Lta5BTAkJnC/o/A8aaOQy0
 TTrtKYzC4eoyF/VUqObAhG/f3pJW585dET5xXyVJougTXkRZ/XglHVVLfDilS6wWS2Tm
 3clYYOPHSxXCTq6I0+UuZZxa9vF4kAq4H0r5Fi+dIDMRmf29lyGCt3VFmZdFh1y/Mkm/
 4i0UKi18Mod7JGEK4W9F04XpzzIf5B/88Ktd9rcBouQUdy6YwrLdYm5EVWoDAPfj/dq7
 3K8FzGazeDdOOzOKAba1q51KFTUoWys5w+8vmR47CO0ERa8Fo6JtJ61RuAU6Y6HNlipt
 zUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957094; x=1788561894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UjsF6O9PSmRI1N2dTiPjzravc5biEaOJFy5Mo1UxfUw=;
 b=pS6TBra/NamXQfv6CL88o5TNI9agAReuekvHYpsvzmRLgi/rh2FzpwYpDFJwdkuaTL
 uR+UQMFMCcDCTIfcjwhK6D2GVCksKpt1phHuFmKnR/TniDzc2+IkqlBsiYWOPZKw+mI9
 lKf8/vqNrzsXxJHoSxu1RPrvOgh0S3ZpYRvPeLGpfkT7WoUS9fL52BUBxZjEWy7OToxJ
 J1a3v14VlfhsT6kscw3ZQj/U3kDqvWfRRKsmZysHtVY1JSUbNjCkmJw1uuVJdVC9OXm+
 /2+6ioK59IoO+nozjrzZ8TkHTbAWhWLgV4gZSuk9XqS/SleKuJ8ZBTutv1M7JTCf+Tqr
 jFaA==
X-Gm-Message-State: AFuF++lIs/Jl7xPvk3SNNfYxS3C0Or5joAnzBXn3NhIoDIZrl4NXaOn3
 WCOVhYybVaiAEBj6gB1ZTFhlrqkc5B/7oLNyWDpPRu7uJKSZ9uyzDNS8iT+wVd0zNZPlDkN1uzS
 1pBfa
X-Gm-Gg: AYBFou3yJ986Zt0eDx5RumFBEc3JriiEXDDWu+sPuInviDxo9mhro5dL/crZR2B5J+6
 hQXGCFwhrPaMOYBdHNYuh/tDLo1NsH1Sl6drS6ZOJZkBvYQ9NkhWXMGYTXJHE5NnbFTy/tlLnv2
 z3++WajxSm5Ccy+7j2aZNi94EoCQP7yM2f5sUduOCwYdKjGrYfMdfJdmDHfbjhZijMjWfs3/BnX
 jhym14UXwaH87wiaoy1eNkfMOacaaN/J00QI5nHMWgtdMYZ9ym/xkVe/EiJM8vJAWQopMe1RA9T
 rYghbnaIgTLoswE7/U9+n3tZAz7fVPNVs4tBZ/DcckScaCZ1+RNOScvxEGvqQcXtDpw7kxAjW1q
 DxSbg7kBeN6Yj3SIso2Ojqtl9FbHJhK3zQUcsXFaPvQfDON1rQSm8adFzbHzQfblajtVSg3rWuE
 aMTMr+ZrK4QoLmfof63As/DsjPw9P6qI3SC6xJz9DX9VuI0NnfFRO0JG3k45Emx9AKefZWlozOk
 YUtDPWOwbU9D2dYzErKDL/PVdskR2w=
X-Received: by 2002:a17:90b:6cd:b0:398:9bd4:d14 with SMTP id
 98e67ed59e1d1-3989bd40db9mr4472692a91.19.1787957093615; 
 Fri, 28 Aug 2026 15:44:53 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 00/16] tcg: Introduce INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:35 -0700
Message-ID: <20260828224451.1564072-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Add a complex addressing mode primitive, and some trivial use cases.

This came up in conversation with Matt Turner re his inline jump cache
expansion.  In particular,

-    tcg_gen_shli_i64(h, h, 4);
-    tcg_gen_add_i64(ent, jc, ent);
+    tcg_gen_lea_i64(ent, jc, h, 4, 0);

With the use case in target/i386/tcg, we get nearly full coverage of
all the possible use cases.  The only thing I didn't immediately see
is shifts > 3, which could be visible with loongarch64 guests.

There are plenty of other places in target/ that could use this, but
the shift/add/imm extraction/generation are inconveniently separated.
E.g. m68k address generation, arm add-shifted, etc.

It may not even be worth converting those, but instead adding some
trivial peepholing along the lines of Matt's user-only guest displacement.


r~


Richard Henderson (16):
  tcg: Sort all_outop[] by INDEX name
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

 include/tcg/tcg-op-common.h                   |  4 +
 include/tcg/tcg-op.h                          |  2 +
 include/tcg/tcg-opc.h                         |  1 +
 tcg/aarch64/tcg-target-has.h                  |  4 +
 tcg/loongarch64/tcg-target-has.h              |  3 +
 tcg/ppc64/tcg-target-has.h                    |  3 +
 tcg/riscv64/tcg-target-has.h                  | 11 +++
 tcg/s390x/tcg-target-has.h                    |  4 +
 tcg/sparc64/tcg-target-has.h                  |  3 +
 tcg/tci/tcg-target-has.h                      |  3 +
 tcg/x86_64/tcg-target-con-set.h               |  1 +
 tcg/x86_64/tcg-target-has.h                   |  3 +
 tcg/x86_64/tcg-target.h                       |  3 +
 target/alpha/translate.c                      | 20 ++---
 target/i386/tcg/translate.c                   | 27 +++---
 target/s390x/tcg/translate.c                  |  4 +-
 tcg/optimize.c                                | 65 ++++++++++++++
 tcg/tcg-op.c                                  | 90 +++++++++++++++++++
 tcg/tcg.c                                     | 61 ++++++++-----
 docs/devel/tcg-ops.rst                        |  4 +
 .../tcg/insn_trans/trans_arith.c.inc          |  4 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc   |  5 +-
 tcg/aarch64/tcg-target.c.inc                  | 11 +++
 tcg/loongarch64/tcg-insn-defs.c.inc           | 30 ++++++-
 tcg/loongarch64/tcg-target.c.inc              | 15 ++++
 tcg/ppc64/tcg-target.c.inc                    |  3 +
 tcg/riscv64/tcg-target.c.inc                  | 17 ++++
 tcg/s390x/tcg-target.c.inc                    | 14 +++
 tcg/sparc64/tcg-target.c.inc                  |  3 +
 tcg/tci/tcg-target.c.inc                      |  4 +
 tcg/x86_64/tcg-target.c.inc                   | 79 +++++++++-------
 31 files changed, 413 insertions(+), 88 deletions(-)

-- 
2.53.0


