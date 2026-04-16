Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25BDF8D779
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSyN-0000WI-6I; Thu, 16 Apr 2026 16:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSxx-0008U6-BJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSxp-0008HL-Es
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso84383575e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369923; x=1776974723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2/j0lOvBO3DmQSFFQJaOFAPLEgLpTImUbZ3zpQz9DI=;
 b=SUSsVD69TzYeAJk3CMcqUB57yjNjo1BYKLQYm21oLiV9gPN0ExkAsnqj5kfOxYEiWP
 MK7BvwBO36eHHlzF/Tuf4Zr/Kxjw0lJ5zz1rM8Pk9oyIPLqD4+eHT+84FX0BEXMFjXkE
 REeQO4vmZQre/0dzQk3gxDuIkGKXkvpxDUFEeITPfueOorl35/zFskTD/JDzZ3Co8iXq
 k9QodA+8mF6aIGOR/6YQybsekZeC935EFuB18vvg8Il7L1K2cGmyWliDCyj8y0VpobvE
 HyHFh5cCHtViHK9vchUOvvTfNHCoBtFOFhSm/ET5DRColMOqtrTKGDq1K6+X4veypWTi
 TcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369923; x=1776974723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r2/j0lOvBO3DmQSFFQJaOFAPLEgLpTImUbZ3zpQz9DI=;
 b=W8NCyLjB4mVePG7KOFPTK8AURdwE2cdoyE4D2aP6nJFRcZYjBUZjxzhoXYcNLDng4+
 Zx2c7uMg0lOCG7B6MAHiph9cmBJdOjTWfAWhcE/RDv8AezO1sF1Cdtr1i1l3db+Ad8kj
 Z9wF4bNKh+Wjh8CIuPBJTAV37J4YuwgmCd790Li4rC3E9DXx2iL7hcCpHlGkOyru6GjV
 IF8OoVgGEUyYAhVZuN7DGmnoOw9lqRJ7HA3lvl3T2mZzNy2pZX3ustqdotLbp+SXS4Gh
 6DQW1wjjEpmUXYbqqNOeWBohH49mMpqW/HvnM7K9q2YxSnPPU6jmPfkcUDoUHRJkRFhN
 YbNA==
X-Gm-Message-State: AOJu0YywtWkUgFkZNfE68HjrKwPW0pghz8NzkXFIFHi9hjNCCrfJDymP
 aBc/rvXiPpjJ8Cw8aPq3JX5xHsVGL2bzjw/KLFxONQLLYTx6b7lBWuWKnGH46G8Q7i2uQ318xU4
 SoYRyHZA=
X-Gm-Gg: AeBDies9Arpc84KfZmI/0DlMyoSjMHLZKkB/c+oT/1EQBrvQekOG0C+kHyr4kwSpEzA
 1VNiuBnf1P8u9W4WMpoILRTrzd2j94Op6smec57RH2o1mJOz6efvh47u+r9WELse70LrDTDVpDM
 5W24K3nSLmc9GWcTzCR9EtM8I9GzNDu+it/RMxRzwkhiofK2znfTE/vX7PnrlzjkMEygVEJkD3a
 ngg5f2tUi6SgOYrYOB2gcdLokAWoJ4/WlaqKnNeXVgicvM5Rm7lGT2zsxkWcwPPFXqE+y7VZs1o
 dtlUEF93CHXQ6m2nrxDGAnMFcz98KYh+VgUgoJxpkTZhsnbmoGTvumFwXKbmc6k6IaAzaTEESum
 tuCqRF8KSWCoP16qNCNC4hZUxkLYBCnWkPJqGwxno9zrYnBmEumtUKWVQpzERmDeMaRZX9A+qGK
 xmPBfw0dobd0eBkwl8g5A65M/i0MlgSOjA7FmoyRhg1hoqXvgVxtg96sJiobBII8gayiK7gFQjv
 PCCi7mjBng=
X-Received: by 2002:a05:600d:8449:b0:488:869c:edaa with SMTP id
 5b1f17b1804b1-488fb74e103mr506125e9.7.1776369923076; 
 Thu, 16 Apr 2026 13:05:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f582368dsm93064155e9.11.2026.04.16.13.05.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 13:05:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v5 1/2] target/mips: Pass MemOpIdx argument to Linked
 Load/Store helpers
Date: Thu, 16 Apr 2026 22:05:12 +0200
Message-ID: <20260416200513.27100-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416200513.27100-1-philmd@linaro.org>
References: <20260416200513.27100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

In preparation of using the MemOp content in the next commit
(thus stopping ignoring it), pass it as MemOpIdx.

The helper prototype declaration always took a TCGv_i32 as
last argument, correct that.

Rename the ignored 'mem_idx' argument on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/helper.h          | 4 ++--
 target/mips/tcg/ldst_helper.c | 5 ++++-
 target/mips/tcg/translate.c   | 7 ++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e70a3942fac..10c6470514d 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -10,9 +10,9 @@ DEF_HELPER_4(swl, void, env, tl, tl, int)
 DEF_HELPER_4(swr, void, env, tl, tl, int)
 
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_3(ll, tl, env, tl, int)
+DEF_HELPER_3(ll, tl, env, tl, i32)
 #ifdef TARGET_MIPS64
-DEF_HELPER_3(lld, tl, env, tl, int)
+DEF_HELPER_3(lld, tl, env, tl, i32)
 #endif
 #endif
 
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 10319bf03a6..b725c6d0333 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -30,8 +30,11 @@
 #ifndef CONFIG_USER_ONLY
 
 #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
+target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
+                           uint32_t memop_idx)                                \
 {                                                                             \
+    MemOpIdx oi = memop_idx; \
+    unsigned mem_idx = get_mmuidx(oi); \
     if (arg & almask) {                                                       \
         if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
             env->CP0_BadVAddr = arg;                                          \
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6d4b6412d70..839bfe18bab 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1922,7 +1922,7 @@ FOP_CONDNS(s, FMT_S, 32, gen_store_fpr32(ctx, fp0, fd))
 /* load/store instructions. */
 #ifdef CONFIG_USER_ONLY
 #define OP_LD_ATOMIC(insn, memop)                                          \
-static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
+static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx_ignored,  \
                                 DisasContext *ctx)                         \
 {                                                                          \
     TCGv t0 = tcg_temp_new();                                              \
@@ -1932,11 +1932,12 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     tcg_gen_st_tl(ret, tcg_env, offsetof(CPUMIPSState, llval));            \
 }
 #else
-#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
+#define OP_LD_ATOMIC(insn, memop)                                          \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
+    MemOpIdx oi = make_memop_idx(memop, mem_idx);                          \
+    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
 OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);
-- 
2.53.0


