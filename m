Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E5606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ihoNUaC3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX7y-00034A-1k; Wed, 21 Oct 2026 10:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7o-00033U-VW
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7n-0001Te-49
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so6195405e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592221; x=1793197021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iUZHcxy55gg9RAeAAqvYHIhwnfGvs0kti4lU9RVkyW0=;
 b=ihoNUaC3z1ElMFUpa/SgQl9SLN6JxXu2fTv9puNCw69u5H0G+IbtPrcXzit0UFd0TJ
 b1HXCuaiRk4GcMbNT2M2wVB0FSIAWoJNGIS1qxZJnWtCogWagyTP6CtaU5V9UmvAaWZA
 D88wradvs3toZtOxLCikL5rjB63v0R2w69VaVPEcJHs98895rFWVZ60qZUmn3Jvnrfqo
 SE9UUZe1BSW/NJuny3MbMIy86PMx7r4iQsnknX7h0ZJzVz+2s6blfwZIotL2Kqwsxxpc
 MUT8cJXFPaFS0JoqySB11LkSXkiLNyOUaHmaSSn+dwPqfp5NzMvw6mT4jr5PbRZU4evw
 YxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592221; x=1793197021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iUZHcxy55gg9RAeAAqvYHIhwnfGvs0kti4lU9RVkyW0=;
 b=TgKt6X13Kcb1PoIaV6I5Lo80PiNeKovVrkI5BR9S7+2avOTDgcYFO7bS2mJsicWPwK
 GYN3buy5QxlI0nq0zZTR7l1hXhhfKTBcK2j4STj3ihJkiYwcQehZR/fLEWQd2P98fv+d
 EEkeBT+CU533OaGBZpg/pfXTv+gOjtU9XNmR/qsWnn90X/2raDU/oZ/+zLT7wSniSv4R
 r9kOjPq5oqoglUh6TIW/FLz03TnLJoAj4xZSCCchATRdv+bAEHQSWjRFVlGNOQIlMpc2
 JdP7yYVTgetF2qfG0bvlR3DndeEmZ9uYUaxp9H57pJfCqCTGqRgx6NapvYYnh2sKSWaO
 hhvQ==
X-Gm-Message-State: AFq9FYKbENOqkDj2/+CvLoELM3SeCUAQzWvckazJ6NVYgGRu4cPgZhiE
 k0WRRXmE49hEpH7uwHnoEJX6nz1TS0jZI2fl5cuWGgoWTEVfJv89cmHik71OC/BgnlYTXH1iyKr
 33tO2hE8=
X-Gm-Gg: AYBFou3hWeU7XngoQjPidCAriiQBnGb7IyLVM3bU31W77gYrmdf3k/lHexPQlO7+//3
 R8WPmxNLfdLH8OH9RDMKAPLIj2zzztB3M8VDa1YYsdnEF2cUO7jZUG3tf+mjrm5LidZElCttXjo
 +7XDlVZmCOgwS6FCTn3JIuD+AB/FCO3hmX8XcqQ/wG3wb/fBrqnN5c4Qas7xYDcG7Kb+CVTd0ML
 K2oFhQAWlnskH8XedvOV8ywXwfJ2awMNK6tbnlOBgTdzBuiS9xhZiKjOJ8e4/b7w97jURTcMk9D
 wDHcJf1QmC7aP35b0FUuWW7AHtXjVVTYpNEM4StORXoITU6pssolw+m1yQ/VxNH9ZcCXzt2Cm4M
 F0i3I4TZEpcQR6/xf2FDnERvRUp2kXYteHIJpaYMETdSsBxzwjV/q9oQZp2UZa9SP59z/3LPo20
 FcHV65uEq/eKqtdx0hZ51rkY5DTsOQk5svgsRNKXak9WxhWNYKChEXz8/XdPYPIHx23apdTJx/K
 tddMPI+WLsK1KzMrFS2s7LIUKp7BBX0FSwFsN6Dl31KJgQbI2nCohABb1lQlnpdEW2WYgNeFla5
 JNU6DZdmZ2xnfISusl8Ae0SHAKuqp0tnToo7WN/tj6IzSP0u
X-Received: by 2002:a05:600c:1d9a:b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4a1fdd57a9amr45696125e9.29.1792592221385; 
 Wed, 21 Oct 2026 07:17:01 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 003/100] tcg: Annontate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
Date: Wed, 21 Oct 2026 16:15:15 +0200
Message-ID: <20261021141652.363109-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-mem.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index ea35a02fb4..29e7c02f25 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -28,50 +28,50 @@ typedef TCGv_i64 TCGv_va;
 #error
 #endif
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 #define DEF_ATOMIC2(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v,       \
-                               TCGArg i, MemOp m)                       \
+    QEMU_ARG_NONNULL static inline void                                 \
+    N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v, TCGArg i, MemOp m)       \
     { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
 
 #define DEF_ATOMIC3(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o,       \
-                               TCGv_##S n, TCGArg i, MemOp m)           \
+    QEMU_ARG_NONNULL static inline void                                 \
+    N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o, TCGv_##S n, TCGArg i, MemOp m) \
     { N##_##S##_chk(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
 
 DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
-- 
2.53.0


