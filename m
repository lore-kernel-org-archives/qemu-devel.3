Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0CDC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlo-0008CK-Ji; Sun, 26 May 2024 15:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJln-0008Bt-ND
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJll-0007db-VE
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f48b825d8cso3467565ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752580; x=1717357380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fljjc+vgV8n9jaU2H17cE0qlx4ZtzSc/592LQHPcA70=;
 b=S1bNyqfqGeg9NlnJTHPOq4n9WRZX84kdeEiYcFJ0MemjlMxk6JV/vCugv2XiHjdAPx
 AqRYBkK1+mdEGjY0cYWxDMZt/XieaZidyGnTmZL8uNqioljgwYKVquQNSDwsLcNTAikz
 22P4HfQW7Qj7RQ9w2+/r7ve0VMsgT3IgkM7oxidtlTv0llu7mhr3Dfvb8C+oZg/FmJLI
 MqhOBqKgE3DSesFcdRdRpouCiowCczGniuSrUW/n4ZzWhFD4BRb9T772HUdd5Qnl1pIp
 /dF3g0RP0+RG1soVxV1Z4kEy/pvMxUw0MDRa9y7cM8I8R4gGEXNzDKcHo1DG+eU//yUt
 8Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752580; x=1717357380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fljjc+vgV8n9jaU2H17cE0qlx4ZtzSc/592LQHPcA70=;
 b=hY5h9S23+3l2E0luFZDt0/7Pb+DuBOH++DRom8rqV/tI55GsDQJbv2L35J32h9+YtZ
 6QJla/NhZ/Zd+hpfrjCRAEQxTMEFb8AvH7YLfFUs6Rn+TkTBXa65mrwhqEtVJjv3B0lA
 E6W44AmO6JPEO9i/zwn+z4NPu6oTP2AojH4BsFiZALnxfGhK5RUk6N79qzG2Nr8bCCWK
 uOg06Su0kztktbH53RzCMzqTx8koLiIfVEzNJuJFJr9ECZ+vLARkGzEpEr454W4ha27z
 ehifJ9Et96IN38uYybLQkkqzBtO9OMLpljuD/nft4SRCqruoDfLfRkoPWxDqbTIAKodf
 +fSQ==
X-Gm-Message-State: AOJu0YwcAjCzv1lTgrQg34wB4z6axTpVU4eWuhF4OoGsJmf1e8lt6JII
 IEiBiADAMYpzIBi/Kcap8E8YVcbazS1nzFoYT9kceuuuFsNI3C+gRa9cilrSlJN3vT6bHDbTgzE
 0
X-Google-Smtp-Source: AGHT+IEWd9dYp8/ZrRJTdG9KpyZQG3cP9ywbsIYY8U9KHeYkRz2LId/I19luPJdtSMrTQFgP2pNIxw==
X-Received: by 2002:a17:903:189:b0:1f4:6970:b70 with SMTP id
 d9443c01a7336-1f469701579mr64319505ad.32.1716752580523; 
 Sun, 26 May 2024 12:43:00 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/37] target/sparc: Remove gen_dest_fpr_D
Date: Sun, 26 May 2024 12:42:23 -0700
Message-Id: <20240526194254.459395-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace with tcg_temp_new_i64.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f3c52c7c48..750a3e6554 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -241,11 +241,6 @@ static void gen_store_fpr_D(DisasContext *dc, unsigned int dst, TCGv_i64 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
-{
-    return cpu_fpr[dst / 2];
-}
-
 static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
 {
     TCGv_i128 ret = tcg_temp_new_i128();
@@ -2020,7 +2015,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
-    TCGv_i64 dst = gen_dest_fpr_D(dc, rd);
+    TCGv_i64 dst = tcg_temp_new_i64();
     tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, tcg_constant_tl(cmp->c2),
                         gen_load_fpr_D(dc, rs),
                         gen_load_fpr_D(dc, rd));
@@ -4345,7 +4340,7 @@ static bool do_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4367,7 +4362,7 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4407,7 +4402,7 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_F(dc, a->rs);
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4498,7 +4493,7 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     }
 
     src = gen_load_fpr_Q(dc, a->rs);
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
@@ -4613,7 +4608,7 @@ static bool do_dff(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     func(dst, src1, src2);
@@ -4637,7 +4632,7 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, src1, src2);
@@ -4656,7 +4651,7 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, src1, src2);
@@ -4721,7 +4716,7 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, tcg_env, src1, src2);
@@ -4746,7 +4741,7 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
         return raise_unimpfpop(dc);
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     gen_helper_fsmuld(dst, tcg_env, src1, src2);
@@ -4763,7 +4758,7 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst  = gen_dest_fpr_D(dc, a->rd);
+    dst  = tcg_temp_new_i64();
     src0 = gen_load_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-- 
2.34.1


