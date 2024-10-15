Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2423D1D882
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlK-0003dJ-IO; Tue, 15 Oct 2024 11:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkp-0001W6-7y
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:35 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkn-0000s7-Iw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:34 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-288642376bcso2446575fac.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007192; x=1729611992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/M6ZeKd6OjvAtfWG6gTR4wPDGVzgIAmQPnpr57Wj6k=;
 b=OKCYJoBcDSK0ksovcO9hj+f8IGeLK5T3YIULW30rQ9qObfHkMVSnTSF+mPZK1U9oZm
 CRQHaa+OcZUBPw+KVsnfJuoLtmfsPxPd9gOOcA3LBjTS/tmpMqhGFxWHJFS0Z4k00vMP
 rrhEH9Tg63aEG508DAYrG2jA+Jg7/b4cB2aJX3Elpt0okWTGNYVDOFYHFMYtEJTWabT4
 cyTeOB3lrGyQBzwXCX1+GqPw0LTX3WMTR+v/FkjTE+AKjUS1OdjRkTaA3/shJSdFEIXt
 Isd60DMwjVMRLcJcf9N6Rs/lTAKKz+UfkhaTEcg6AU1MWVjmtgyGIqR5zlJhQKoiUUgz
 VpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007192; x=1729611992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/M6ZeKd6OjvAtfWG6gTR4wPDGVzgIAmQPnpr57Wj6k=;
 b=n7fZLtzIbM/zZByAAzvUoCpmCKsW6E+EEfHMofWa9Pn8pJvGMv4iuPo/HaMPlL+Zfj
 xAn4RxxFORB8jyIfogwFe/sETT6rWXHrL24art4hdNB/HjhVRhm60S5AFD/18AVTjXyW
 Dh+E24ooaLUiuv0W9RTTPc7bLo2hB1dxdERLVgvSvLWyvIXsM5B6YIyij/A+Aaxdfxv5
 +5eHZFgwF9XXXWJXtm+5hDa28bcheJkwzOiiqzm6IuWkuoFacVztIHaiPHFdRqG7krUJ
 JEGlP2kHuRLzzeX8TyZH9ZeHfVRDrG8F0J9FhDASsEuH45prJuNJx866p6+EBVD6rzj2
 dQqA==
X-Gm-Message-State: AOJu0Yy8XC0pjzzvsCvIbdVbx5BjKLTmmssdsKQkFykLurPKBnzo0uFi
 xPoft3iir3O/xrOlrvLItXBe92Kb0Lbn01IslSHrxMtQ+EOvfv+6NNKICzS5V97SrHkZm5XsJlt
 I
X-Google-Smtp-Source: AGHT+IEz7m3HFPxuW9kgXku+KQ4th/nTbLtPWGSpqvoJJzPsNUesHc8oLcS4d6+UI2mN3KDXR3c4WQ==
X-Received: by 2002:a05:6870:c111:b0:288:60d6:f183 with SMTP id
 586e51a60fabf-28887478de5mr6900285fac.38.1729007191877; 
 Tue, 15 Oct 2024 08:46:31 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c71a8aesm1509253a12.81.2024.10.15.08.46.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/33] target/ppc: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
Date: Tue, 15 Oct 2024 12:44:24 -0300
Message-ID: <20241015154443.71763-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=philmd@linaro.org; helo=mail-oa1-x33.google.com
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

Directly use tcg_constant_tl() for constant integer,
this save a call to tcg_gen_movi_tl() and a temp register.

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004202621.4321-4-philmd@linaro.org>
---
 target/ppc/translate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 71513ba9646..7689b2ac2e1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1588,16 +1588,13 @@ static opc_handler_t invalid_handler = {
 static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 {
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
     TCGv_i32 t = tcg_temp_new_i32();
 
-    tcg_gen_movi_tl(t0, CRF_EQ);
-    tcg_gen_movi_tl(t1, CRF_LT);
     tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU),
-                       t0, arg0, arg1, t1, t0);
-    tcg_gen_movi_tl(t1, CRF_GT);
+                       t0, arg0, arg1,
+                       tcg_constant_tl(CRF_LT), tcg_constant_tl(CRF_EQ));
     tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU),
-                       t0, arg0, arg1, t1, t0);
+                       t0, arg0, arg1, tcg_constant_tl(CRF_GT), t0);
 
     tcg_gen_trunc_tl_i32(t, t0);
     tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
@@ -2974,8 +2971,8 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
 
     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
-    tcg_gen_movi_tl(u, 1 << (memop_size(memop) * 8 - 1));
-    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t, u);
+    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
+                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
 }
 
 static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
-- 
2.45.2


