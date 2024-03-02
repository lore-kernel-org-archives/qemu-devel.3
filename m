Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1DCC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHkB-00034g-Ax; Sat, 02 Mar 2024 00:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk9-00033o-SD
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:05 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk3-0007bf-93
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:05 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29ab78237d2so2132613a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356618; x=1709961418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85lzAWcXk3QovGlqwazzvFtIeZJWjQqJBGsI6YskhyE=;
 b=wMhxFyTZMAONiGd2xSvgPOPRORtFXAyieyfceNrIuGAWxN9sJhO114oE97nV6Z8sle
 cnGEyMIdvDSb2QjGOHDGzae42rK3i56KIDdKg2nh7C1od5VhK0uv+19EjH4QfbdOH1dF
 7vfni8IoRwutXFCXOKNsJFen20eT1y+Gxu7wNYvK92v+Y2Vyi9SZ6RuUaZ8x1NGAyWAO
 5CuX4z39C2IXT6rI/wOg+495LTCsbpaQHvB3Ye+BPKpEhJBhI7yXsjIBUqOJdsaORG8w
 rGT6B1I1FSZpfGA30bqGoIgE6B5RV43A69FrJMPopkf8/O6dIVScUB4hmTGPsZUtx04f
 f5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356618; x=1709961418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85lzAWcXk3QovGlqwazzvFtIeZJWjQqJBGsI6YskhyE=;
 b=sE7LXZ4yWVKoXl0w/5YAHlPS/Wz36L7quDLxzrB7t2Tg5+Hn/dVRA5pXzTLh48cMyK
 Qd5u4akwuCkwXXxRwGUMrewhTDvrXxnZGbSnVVo80Agn9+CS6lIpIaPtV8HJnws+niLO
 63fZr7Pcos1OqgDgFPXr6GS6K53AnRJWTBJyNZtqov8iJvTtmm8PMeyddK0DDTvKYTxi
 0A79Mvp68W347t5wHNsCqzBEcrdejN5kZmQmRWqkUohN8uXJa21BTgTiQNEl80xJxQuB
 VJY6WlwkD8J21mdHCh2vewvesv2sm/rIzR0P1tNQ3N7VIiusOFzLFMDmDgxAVlnPxcwB
 l8hA==
X-Gm-Message-State: AOJu0Ywag442uz7MJA34wG04f42X9+rr9wK9WSIvHceWgc2IENZQZNBl
 M6T9r2zEMvu0SACwCzJiq20E4Of5K4HSi37WUIp8GRiZXoIAVoHcizuIUUWz3pEd9QqsvBUhnkR
 X
X-Google-Smtp-Source: AGHT+IExFU+PPTJydpQVrYHm+9q/XcPUaKYGjTZkd791CG7gLbw6TGl1k12cIi1bVPpWFHNwqEWfcg==
X-Received: by 2002:a17:90a:b793:b0:29a:7380:53a with SMTP id
 m19-20020a17090ab79300b0029a7380053amr4117030pjr.34.1709356617982; 
 Fri, 01 Mar 2024 21:16:57 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 34/41] target/sparc: Implement FALIGNDATAi
Date: Fri,  1 Mar 2024 19:15:54 -1000
Message-Id: <20240302051601.53649-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 target/sparc/translate.c  | 33 ++++++++++++++++++++++++++++++---
 target/sparc/insns.decode |  1 +
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 77b53cbf3b..8e67d9023d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -818,7 +818,8 @@ static void gen_op_fpsubs32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
     tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
 }
 
-static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+static void gen_op_faligndata_i(TCGv_i64 dst, TCGv_i64 s1,
+                                TCGv_i64 s2, TCGv gsr)
 {
 #ifdef TARGET_SPARC64
     TCGv t1, t2, shift;
@@ -827,7 +828,7 @@ static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
     t2 = tcg_temp_new();
     shift = tcg_temp_new();
 
-    tcg_gen_andi_tl(shift, cpu_gsr, 7);
+    tcg_gen_andi_tl(shift, gsr, 7);
     tcg_gen_shli_tl(shift, shift, 3);
     tcg_gen_shl_tl(t1, s1, shift);
 
@@ -845,6 +846,11 @@ static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
 #endif
 }
 
+static void gen_op_faligndata_g(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+{
+    gen_op_faligndata_i(dst, s1, s2, cpu_gsr);
+}
+
 static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 {
 #ifdef TARGET_SPARC64
@@ -5060,7 +5066,7 @@ TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
 TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
-TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata_g)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
 TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
@@ -5221,6 +5227,27 @@ TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
 TRANS(FPMADDX, IMA, do_dddd, a, gen_op_fpmaddx)
 TRANS(FPMADDXHI, IMA, do_dddd, a, gen_op_fpmaddxhi)
 
+static bool trans_FALIGNDATAi(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst, src1, src2;
+    TCGv src3;
+
+    if (!avail_VIS4(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst  = tcg_temp_new_i64();
+    src1 = gen_load_fpr_D(dc, a->rd);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    src3 = gen_load_gpr(dc, a->rs1);
+    gen_op_faligndata_i(dst, src1, src2, src3);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 56a82123a9..7833437f6c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -446,6 +446,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
     FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_d2
+    FALIGNDATAi 10 ..... 110110 ..... 0 0100 1001 .....    @d_r_d
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @d_d1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
-- 
2.34.1


