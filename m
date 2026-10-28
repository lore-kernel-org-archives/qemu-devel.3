Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5E606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pv8V9knv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6a5-0006PF-5q; Wed, 28 Oct 2026 12:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a3-0006Oa-JC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:51 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a1-0007Um-L6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:51 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-8490a7d6696so699412a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205168; x=1793809968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RF2SJln8Zj7EGwqoqwvHvZoZiCZaaOXwNHuWxEa4YFQ=;
 b=Pv8V9knv/dOpIn8Xo2j/Vy6D6xMpM+rzkWIjJShPpfHwCiuGg8sSacmzgbZhxXOh7o
 MombOGHHbN6vgXxo85c4T0ekl6gKpkLNdvewHCJmMNT5yBaACwVWOqNnp0YKSUEuVrK3
 dRz7nS4dmyEKw1AiCm3SlKYXQG8haIaJbM0gX8S6gRNCp9GwHH+2111CgHREsFledVaP
 L0f3XoOtOmxlfU0g5EBl/ZYzW63bII3XXeGIdE+nDMFDS9N0v8SCeVSk7NPWSD7lpUqc
 dLneaFLFfo0dnrRrt5EOuxLwjnl27GGKpEVs2b+mAwFrZipoJzs4pHPMzAexGhzVWnPe
 7RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205168; x=1793809968;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RF2SJln8Zj7EGwqoqwvHvZoZiCZaaOXwNHuWxEa4YFQ=;
 b=tKczY6KI2hZ+URTCHALyrSALognLfvqa0n2bgqTBOiVwbrC5E0I4CGW3GMNrSCgpy7
 JvhwP0KMCCjwxse44V+mg7vIVcawsLOm3VP2mBnMLOhrBaaUAuQCYw+do6K8gk7jp38N
 6Q9dfUhSMNYXMwrF3XxfoJEDSZB/pZom0AsULvh5EseDbVFqoSNSJOXdxaitjGY3TTxg
 AvX/y26reWCVLMs2RhGQzw2pc1AuT88r4KQp35sznkfO5h9azuetH6sJSN/Zg3jKXzCW
 QUZkbFWHBEPzG0fVocIFs5p7H/RLWnAF0iMTxfAwlCcM8pdzve0WV0Go+T3UcvC970l+
 h6yQ==
X-Gm-Message-State: AFq9FYKP8GJ+cf4/dM788bMOvwAQJDHEv1u4MWiExLDM1wlCa2GcLblJ
 AeNoYCeUdSILsFpSYfR4lHI4lm5Pig8Dt3u+3pei2+SaZIGoOajVhxVxhEk/TJ9R8RO9W7h9ac2
 VXNBe
X-Gm-Gg: AYBFou0qNMScB74l9QEDIaJfnmgqMdSgvxRpprYiMf+pJuWF3Q7Jy0CbZwEKnPcYdUn
 iu3/j1LXVDMDXWCIImgDSc//7/sE2ICBIhZTC1fvja8DbV43+0Eb9egIwC1jCCNIcDSdXKINlsY
 QgUe8/cASdlDRvwbhcg/WrReWEHh2F8QrAT9t7RQONH9nE8qbX/FpELUId6UFUgOlt0nkUnOGBB
 J3Dd7ahP05g34WP3fXttwyfYo9iy8Y5OxZtAuVqX7cG9OjWD2BZzWONEYxfkZsLawLdnpsx9j01
 POZbfwuFPHUvlHXgXMd9YaQgfY3Ck/6DuwBE4haCATv2DYJkOyDpBqwXRVCJmVyefyjUKf9GTOU
 ArXK7v2WiTrAnn8VfoFFpvg9NPxaCIQgOL87yTH3ZJonJbMG7I0SxqUACXuIWOL2H7quF4RcRuW
 Z18+DeBjwGrYJPTexlAeMv3ZwPepTezlM0/Z8Jjvpvg1C8C0RUyDpgBfO8lf83eqr1c3J+sON/D
 aJ4QDCaFJHwXCy0SX+VR9Oz/aBkMpFNNpf07lu8ZM+UiycqobU1GrvbU/3QOMjPFGMFnjweLpaD
 qMUc3aaJw/MiBtvgj4OFkGz76EbT0bvGLQ==
X-Received: by 2002:a05:6830:4120:b0:826:1ccc:8bb9 with SMTP id
 46e09a7af769-85ab7040645mr2571730a34.6.1793205167529; 
 Wed, 28 Oct 2026 09:32:47 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16] tcg: Introduce INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:29 -0500
Message-ID: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Changes in v3:
  - Rebased to master, which now has the prereq series.


r~


Philippe Mathieu-Daudé (1):
  target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V opcodes

Richard Henderson (15):
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

 docs/devel/tcg-ops.rst                        |  4 +
 include/tcg/tcg-op.h                          |  2 +
 include/tcg/tcg-opc.h                         |  1 +
 tcg/aarch64/tcg-target-has.h                  |  3 +
 tcg/loongarch64/tcg-target-has.h              |  3 +
 tcg/ppc64/tcg-target-has.h                    |  3 +
 tcg/riscv64/tcg-target-has.h                  | 11 +++
 tcg/s390x/tcg-target-has.h                    |  4 +
 tcg/sparc64/tcg-target-has.h                  |  3 +
 tcg/tci/tcg-target-has.h                      |  3 +
 tcg/x86_64/tcg-target-con-set.h               |  1 +
 tcg/x86_64/tcg-target-has.h                   |  3 +
 tcg/x86_64/tcg-target.h                       |  3 +
 include/tcg/tcg-op-def.h.inc                  |  1 +
 target/alpha/translate.c                      | 20 ++---
 target/i386/tcg/translate.c                   | 27 ++++---
 target/mips/tcg/mxu_translate.c               |  3 +-
 target/mips/tcg/translate_addr_const.c        |  6 +-
 target/s390x/tcg/translate.c                  |  4 +-
 tcg/optimize.c                                | 66 +++++++++++++++-
 tcg/tcg-op.c                                  | 43 ++++++++++
 tcg/tcg.c                                     | 22 ++++++
 .../tcg/insn_trans/trans_arith.c.inc          |  4 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc   |  5 +-
 tcg/aarch64/tcg-target.c.inc                  | 11 +++
 tcg/loongarch64/tcg-insn-defs.c.inc           | 30 ++++++-
 tcg/loongarch64/tcg-target.c.inc              | 15 ++++
 tcg/ppc64/tcg-target.c.inc                    |  3 +
 tcg/riscv64/tcg-target.c.inc                  | 17 ++++
 tcg/s390x/tcg-target.c.inc                    | 14 ++++
 tcg/sparc64/tcg-target.c.inc                  |  3 +
 tcg/tci/tcg-target.c.inc                      |  4 +
 tcg/x86_64/tcg-target.c.inc                   | 79 +++++++++++--------
 33 files changed, 346 insertions(+), 75 deletions(-)

-- 
2.53.0


