Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A745C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauQ-0005ia-JY; Sun, 18 Jan 2026 17:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau3-0004Xh-Nu
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau1-0000x7-F1
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so22475895ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773944; x=1769378744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUs/qizOln6k9oFq1nxTBHzlXvp7JuDaMx2406hQaG0=;
 b=lsU9WIb5sc44V97+Nf/b0BZlP/2VKa33FL4nUvVi7iLQfdEPACOBzOXbfPyzprRJyj
 miGDUX6O23J5r6nS4CYhOiVRJa9Xwdo6/7U7K5UT7DG5gk1iOcpJe9CN1NwAyavuZ0LR
 8Xqe87teoOYfcVgMkJrP1ANYkxQ53ljxDvrRGWAgibi2gxpbrhGR3bx4ofZ5i4UV/1S0
 JgFhyNfsXsDothshaC1tAFo7YBriivu+qy4rqzmyV6UppWQVpe2X8w0X41eZLGG0FyXh
 MwPX5I7aiS8z3DKCDK5TeSS39eCh3WptS72KyHWh7wEemRWtbqZaWmO7fkBH7PbeiFV3
 96aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773944; x=1769378744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pUs/qizOln6k9oFq1nxTBHzlXvp7JuDaMx2406hQaG0=;
 b=r4W0SudGCf+XARwIAn6uHyWcHUxe7gRrSRBa6+uTQh9YoxwYMtoOh1EaFExIrfuKf3
 l5nlWLL5vBSvYFXOCgaFBeaCtLqrGGkaw+Jxt8VbBKO5etR3+7yZJ2hH2rqZPXCuqIPw
 WjdUzUHMbL4Z0yyB5bwbvRUgOjquUnWVCoPjYylLiRPE5npJPz9644r040BzjbxjDsUw
 bHdsk5ir0mIW8czOyViIia90gQm6PF99bcz+SnE8rq8iF7vSl82bZ7ssGoIQ8hzQ5DWy
 4WB8t8jyEj603Zhogf6hTKzf5n8mMeBaVDaVc7Yuil41bgI1nqzCXB9EngB1frdpHEQd
 CwRA==
X-Gm-Message-State: AOJu0YyJJ3fWi+v5PjtCmgXcjo/jb2wmaoH4WLXzMcfuHaZgotbdw636
 l+iKdfXtNYKEE9tciMHVMC2NvrKth8x3Tgw1ZKWXXdw7Whc4xZ12WA2uHGEYtZlqDN2F7iER+BR
 /Xov6gY23gA==
X-Gm-Gg: AY/fxX7Scv6yg6fJld+4tuPOxXrQo510R8LjdpThXpX8ckteZMlChYzffqk8bF3OdMW
 aVnZMWHRU7K9ZxIlSrcd3KLjANVLjyHh4gUBTgKZpW+KUqN96SUbASMv9f/Rmr2ZKw+H1xe20Mj
 RLlE9pVMN3uUsLmc2VSVRydYGlCjhZhkliiUFEjhWtUa3m7kuyjnmfdzxzmr/I7Nj7VBcmIsg9m
 zU1iOd33HXmDbXS9c6DhxuER8hPFncQZd315g0Siyfu7AJIQOJhC/0rI9WVnfTbuPxi0oYOtKYk
 fNQFMZ5GSQEFfneuarEk5gvaJnoaw3UAcqJZnolQwCmr28fPkTqw+uOB0ZozXrqciP8iloT+kBm
 Hmk8EKmbPTk8eZXTLzsBmK3RVNS+TA8yPDiVoUvkOjRnda+q3/CWRowglgCJsYInMAedmoMN7Zn
 5q4Gl4g6GThoLYPTnM+A==
X-Received: by 2002:a17:902:d2c9:b0:2a0:8be7:e3d0 with SMTP id
 d9443c01a7336-2a718859fe1mr82746925ad.10.1768773943647; 
 Sun, 18 Jan 2026 14:05:43 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 35/54] target/i386/tcg: Drop TCG_TARGET_REG_BITS test
Date: Mon, 19 Jan 2026 09:03:55 +1100
Message-ID: <20260118220414.8177-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 41bf047b8d..639a1eb638 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2094,34 +2094,15 @@ static void gen_IMUL3(DisasContext *s, X86DecodedInsn *decode)
 
     case MO_32:
 #ifdef TARGET_X86_64
-        if (TCG_TARGET_REG_BITS == 64) {
-            /*
-             * This produces fewer TCG ops, and better code if flags are needed,
-             * but it requires a 64-bit multiply even if they are not.  Use it
-             * only if the target has 64-bits registers.
-             *
-             * s->T0 is already sign-extended.
-             */
-            tcg_gen_ext32s_tl(s->T1, s->T1);
-            tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-            /* Compare the full result to the extension of the truncated result.  */
-            tcg_gen_ext32s_tl(s->T1, s->T0);
-            cc_src_rhs = s->T0;
-        } else {
-            /* Variant that only needs a 32-bit widening multiply.  */
-            TCGv_i32 hi = tcg_temp_new_i32();
-            TCGv_i32 lo = tcg_temp_new_i32();
-            tcg_gen_trunc_tl_i32(lo, s->T0);
-            tcg_gen_trunc_tl_i32(hi, s->T1);
-            tcg_gen_muls2_i32(lo, hi, lo, hi);
-            tcg_gen_extu_i32_tl(s->T0, lo);
-
-            cc_src_rhs = tcg_temp_new();
-            tcg_gen_extu_i32_tl(cc_src_rhs, hi);
-            /* Compare the high part to the sign bit of the truncated result */
-            tcg_gen_sari_i32(lo, lo, 31);
-            tcg_gen_extu_i32_tl(s->T1, lo);
-        }
+        /*
+         * This produces fewer TCG ops, and better code if flags are needed.
+         * s->T0 is already sign-extended.
+         */
+        tcg_gen_ext32s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext32s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
         break;
 
     case MO_64:
-- 
2.43.0


