Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B114EC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z1-00053w-AJ; Sat, 21 Jun 2025 19:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yx-00051c-EX
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yv-0004RQ-Mv
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso2296056b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549844; x=1751154644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fuA0ciCWKNdG1BUB3drnqJmCT7zYMzgjdkDnlRwo890=;
 b=CoSZwTz2xwKtj/GN3MhaFr1V3tPLNuI7aALko7+Fhsl8n4j17yoIlKjlL+kdcwjPlz
 w60nmU3CYX2OSwQIqXEDAd22J0lQ9JE0wbJkxQLGtm2YgydJE3TRZfjFjb86WpctBKjf
 /luLq3i5Iq8M2k+mKgjcTcMpcvhSy1B34PhbIrIHPyCtg8TOQ1TWY5QTKMZ9t7le4X4m
 BFxS8+fEyuL1D5wipw6lcfAdWsCJaALyu2ckwe5/hWbniZPXXvjr5m6qUDiNG9uZIz51
 GPPpnrNzqugjsKrXfER9NQK5Mu/1YmqyoaXqEiCx3DYywhti99jr2mUHnJHigUbmGLAw
 21Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549844; x=1751154644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuA0ciCWKNdG1BUB3drnqJmCT7zYMzgjdkDnlRwo890=;
 b=TF8wMvcGnt8Oq60hFD95W9rMYAyIDJGdaktc95UK+u4uQdUNNXaRcg00xIvZozPL5T
 SIOtVwuMUOOUzIaS2izLKzIhqZCt8+CCN0/TOUW0+nhP5MJ7FCuHGvveSds+C8P70deo
 oE10zEeDvqRbM1lP+0bGpLFI57hXpY6tVvD4ef2u6R4JEVbcgnWf0iIO4yPsZ4SarzPd
 oNSB9ojqoE+szL2AwzrPVCiS051Vp8e8bVAkFhqz/CJRPhKeDLGRour8Qp/EsGARbaOe
 gDittO8Z2pE4l7SRD216xOzrcMbSkxeYlbQvF1l5MYnn50kN/vFqJilrsw/uIrWeCMGW
 Dzlw==
X-Gm-Message-State: AOJu0Yyf37bK9XMvPzxNyuNWnCuSmU4Oie+Mbn24H3RMahMo2wK8AiJv
 nC5LsAAK/ChJQvPsKBDIjoCzx39nPoGJ1ufeP090M3akyGaKRe6Q8u476XgYsKhKObxT1UCRwsi
 GE0N3
X-Gm-Gg: ASbGncskS8fMewzZ9asXaya/03YN03TShe4GSb97ytHbM7mjzzETqR3LUeOvnTmhB8h
 PdngAoCrQ0pp9t5L+5YXZuPlfsduTUAlXh0hev3M7/3pMVC/aE9RJu3aVTwzQf7lG5AmT/n/Yun
 mXajsXoj310bTcm+Pqm6gN/ktxKHsbS0c/ErvylQ6w0oRYbBN+NYbb1qxwPkRrOHLEC1LmSXfcv
 DVg91qNjy/r9VO9YMAa5LHU81z0iztd7QYBGGZV1RE+h1uaG+7iyX12autftovr4865lLx412C4
 wuDzuE4LkbuOWv1SIeumQZ6W/F0/Fj0BSLjbqvIL6blUgeSuGxTGa/meyhpFjZE4dbstI4ghz1/
 UUm5aVxcelsPiy+XFjFnj
X-Google-Smtp-Source: AGHT+IErmF4lb5ho15QWIFUFANQMhgGGhp2eAdFc7t92BQebv+H5mYWkPhPZw3xJyYPKKdJKQkyLnA==
X-Received: by 2002:a05:6a00:139c:b0:748:f41d:69d2 with SMTP id
 d2e1a72fcca58-7490d4e369fmr12052549b3a.4.1750549844361; 
 Sat, 21 Jun 2025 16:50:44 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 008/101] tcg: Split out tcg_gen_gvec_{add,sub}_var
Date: Sat, 21 Jun 2025 16:49:04 -0700
Message-ID: <20250621235037.74091-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |  9 +++++++++
 tcg/tcg-op-gvec.c                | 32 ++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index cabbe957c8..fbe5a68a7e 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -266,6 +266,15 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5e58b1cc75..d5fbd4e885 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1994,8 +1994,10 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static const TCGOpcode vecop_list_add[] = { INDEX_op_add_vec, 0 };
 
-void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fni8 = tcg_gen_vec_add8_i64,
@@ -2022,7 +2024,15 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3_var(dbase, dofs, abase, aofs, bbase, bofs,
+                       oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_add_var(vece, tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                         oprsz, maxsz);
 }
 
 void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2175,8 +2185,10 @@ void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fni8 = tcg_gen_vec_sub8_i64,
@@ -2203,7 +2215,15 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3_var(dbase, dofs, abase, aofs, bbase, bofs,
+                       oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_sub_var(vece, tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                         oprsz, maxsz);
 }
 
 static const TCGOpcode vecop_list_mul[] = { INDEX_op_mul_vec, 0 };
-- 
2.43.0


