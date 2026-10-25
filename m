Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB5606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oQGMHCkB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsfn-0004sM-L6; Sun, 25 Oct 2026 03:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsdZ-0000HF-2j
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsdU-0004dL-SC
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so5535105e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913223; x=1793518023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IbhfDbW4GH36Dcw/uUVE/VnOQMALWO7IgBzY4/MUvKg=;
 b=oQGMHCkBbSecch2NtndZC88wvM8so6rQkJgSJTZNw4iOQ19KSmHnbZLXzaBw//avbR
 4goZyCjHBIbHUNY5mpD7ew3Q7k6bMoaHSgd8mph7Nj9QjcUaiv4QiYHbF1k0WGOCUS55
 FA6XDgdQKrX1q9uPlmZYOFkETh0ZO5XgWtcPyGe2bribybO32pYe3jlddigmTkzsp4tt
 FaFF+e9oWGmDfzycNn03pNAHu76rblnVegJ3RPj54H9+37lSyv5WF6+Vh9/Y6wGZEOdq
 bt2l12nH7GMiLe1tMUq2JTPME7DgVixeGY1HlZJ1NfjuC2nEZ6NLhTLCRdYLk/hp/5RB
 MIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913223; x=1793518023;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IbhfDbW4GH36Dcw/uUVE/VnOQMALWO7IgBzY4/MUvKg=;
 b=stLlQDykWsUv6jvrHjd8c61+SfssBXDp7D4bFALUv1uBef35xzr3jjXtWHHvfO5UQm
 aBplkmnyGvUB3aTFGlWGyN6q01pENKBLh812jBVLnIDymX3XHJA/PFgUr5QHEEYI4zKq
 3q4YJAz5JgxuVi9j4nidUWeQgYhDk2VEDbgLhuR55daako+7GwJXxAK0WwZ1n2Pvt+/G
 X+Qch5A9wMwDLNra54fild5MMyKoPYqoWCjPgyOlRTfHZJfymPKbvppCZpFq8m6J+Z6s
 Wg6SQnBlfmu/FbPzELr95SCf9m1j2cNCZP5Z3B4ba9BSiFmayLFQMHbtkHjvTKrUk1QN
 0yTg==
X-Gm-Message-State: AFq9FYKYGm9Eq1ocAMnPjTBcJCvNebsYXCuT3lrrw68Hj8jCTUNTg/Xi
 Betr04k8NbftxDIZ2RSjyZuF5Kduh1kmVgagcjWTvNzdK003fBPE0x6T0phBGAiJiTmwH2FmJAo
 q2RHozOw=
X-Gm-Gg: AYBFou3SPN6LXM0EoaOmCEut6G9Z7DHCamLVgsgw78Fk/f/vaROXADzC1HaEZMgZZpU
 G0jcH3ow4ukgWntEVhyIEZ2uyna1hEG9nHAYxHLchs+5XxchZltgQhI3I8Y4dANg3gM0VLyJumD
 SwRncp3T2uxljQo9JYe01xOh9pihVhAtmIXfYdbM8VWIHaHglU4yRSfvq7K9aq/2RYeY/B1ZUhl
 3u7ii0DKeBLLjp6YBBLwAlx7glGgRjtl5aMOr1JgEWZCuAG6SLJxDWA9bYomWZdRo7//12cWESj
 Ecw1IQmISEskD5jIabbxaCprjFg1mbn91/1N4YBm5DL8kcDzyKFAJZ4w0agH/m8x666UrF/WObm
 WtChMkBpVbTt5u5bf5v0HQaOlxK9+wBo+XvFpi9KMCGq9jIUkdaG2SlWl9IW6+qFTWHPdcQF8YQ
 cpo8JDwKrWn9faNmvGhQY5ymwTtKlgexYqh/gyd+rDkmYAvZOYO+jARjlznKWodO7511FozCf4/
 u5l1KuMoH3qM96RQvg4qAZt0FUP1o2QySoLqj16fV8ZePP1kzez04lfWQ4=
X-Received: by 2002:a05:600c:4f55:b0:4a2:a9:ed5a with SMTP id
 5b1f17b1804b1-4a35ac9a6d5mr68687395e9.8.1792913222943; 
 Sun, 25 Oct 2026 00:27:02 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:27:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 100/100] tcg: Annontate functions in tcg-op-common.h with
 QEMU_*_NONNULL
Date: Sun, 25 Oct 2026 08:19:15 +0100
Message-ID: <20261025071915.1123867-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 104 +++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 633be35a93..f80a895685 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -12,23 +12,38 @@
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
+QEMU_RET_NONNULL
 TCGv_i32 tcg_constant_i32(int32_t val);
+QEMU_RET_NONNULL
 TCGv_i64 tcg_constant_i64(int64_t val);
+QEMU_RET_NONNULL
 TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
+QEMU_RET_NONNULL
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
+QEMU_RET_NONNULL
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
+QEMU_RET_NONNULL
 TCGv_i128 tcg_zero_i128(void);
 
+QEMU_RET_NONNULL
 TCGv_i32 tcg_temp_new_i32(void);
+QEMU_RET_NONNULL
 TCGv_i64 tcg_temp_new_i64(void);
+QEMU_RET_NONNULL
 TCGv_ptr tcg_temp_new_ptr(void);
+QEMU_RET_NONNULL
 TCGv_i128 tcg_temp_new_i128(void);
+QEMU_RET_NONNULL
 TCGv_vec tcg_temp_new_vec(TCGType type);
+QEMU_RET_NONNULL
 TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
 
+QEMU_RET_NONNULL
 TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL
 TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL
 TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
 
 /* Generic ops.  */
@@ -41,8 +56,8 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
     tcg_set_insn_start_param(op, 2, a2);
 }
 
-void gen_set_label(TCGLabel *l);
-void tcg_gen_br(TCGLabel *l);
+QEMU_ARG_NONNULL void gen_set_label(TCGLabel *l);
+QEMU_ARG_NONNULL void tcg_gen_br(TCGLabel *l);
 void tcg_gen_mb(TCGBar);
 
 /**
@@ -86,6 +101,7 @@ void tcg_gen_goto_tb(unsigned idx);
 void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
+QEMU_ARG_NONNULL
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /*
@@ -135,120 +151,204 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
+QEMU_ARG_NONNULL
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
+QEMU_ARG_NONNULL
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
+QEMU_ARG_NONNULL
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
+QEMU_ARG_NONNULL
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
+QEMU_ARG_NONNULL
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+QEMU_ARG_NONNULL
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+QEMU_ARG_NONNULL
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
+QEMU_ARG_NONNULL
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
+QEMU_ARG_NONNULL
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
+QEMU_ARG_NONNULL
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high);
+QEMU_ARG_NONNULL
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi);
 
+QEMU_ARG_NONNULL
 void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
+QEMU_ARG_NONNULL
 void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
 /* 128 bit ops */
 
+QEMU_ARG_NONNULL
 void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
+QEMU_ARG_NONNULL
 void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
+QEMU_ARG_NONNULL
 void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
+QEMU_ARG_NONNULL
 void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                      TCGv_i128, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                         TCGv_i128, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                   TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_and_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_or_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                       TCGArg, MemOp, TCGType);
 
 /* Vector ops */
 
+QEMU_ARG_NONNULL
 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
+QEMU_ARG_NONNULL
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
+QEMU_ARG_NONNULL
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
+QEMU_ARG_NONNULL
 void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
+QEMU_ARG_NONNULL
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
+QEMU_ARG_NONNULL
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL
 void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL
 void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
+QEMU_ARG_NONNULL
 void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL
 void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL
 void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
+QEMU_ARG_NONNULL
 void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL
 void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL
 void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL
 void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 
+QEMU_ARG_NONNULL
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL
 void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL
 void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL
 void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 
+QEMU_ARG_NONNULL
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
+QEMU_ARG_NONNULL
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
                         TCGv_vec b, TCGv_vec c);
+QEMU_ARG_NONNULL
 void tcg_gen_cmpsel_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                         TCGv_vec a, TCGv_vec b, TCGv_vec c, TCGv_vec d);
 
+QEMU_ARG_NONNULL
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+QEMU_ARG_NONNULL
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+QEMU_ARG_NONNULL
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
-- 
2.53.0


