Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE53AC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWR-0006KK-VT; Fri, 02 Feb 2024 00:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWO-00061g-Hn
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:29 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWM-00031X-Pz
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:28 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d94323d547so14573665ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853325; x=1707458125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAHI25rPn7Uj+PwV0eCufYpY6JQ7XRihAqNNYP+dM2A=;
 b=YFy5hoJH8JzCgM6N1NJUTfjHWKPr6FirBd411Y8Ksf2ys1xID4RB7vf2a18mWxxyq1
 rHdpOb6vH/4vozcCGIUznY+PydPPKrHZgr0K+EZuKFQKLMYbZqWLCq0oCDjpIqNIHj/C
 83ROgX0Ehj6WgcNbksbf/+kDo8RwktvK+L5VAUNIXFzcPrx39wQGRlRCqHBvuzvuAsND
 VcczUpFNr4HY1mKMeYgAz07k9T1ymFaixzYDDI74z9W89zVgXzTBFFmMUDeF9SxYluFF
 c9OhLK+vkrcfZozA2Cjwbuqbn2e03opVpLYzRGNS2GK6/JvV6Zcqp9BqL78s2tIOWHkT
 C3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853325; x=1707458125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAHI25rPn7Uj+PwV0eCufYpY6JQ7XRihAqNNYP+dM2A=;
 b=vvxsxxia10yLPu21tv9pwTviMF/VJANJuibyLMUK9dwrhnvp4U41JNlx7dra4q3hQf
 MBK1ag/+U2pOwSzmAbXQdNp9eKxjSBIaWu1N5/2ZhuDcXNn5yrvmT88uU+Y+Qlw1kJe0
 DzON22dsS3sMd3H6YO3fb3ZkKvuOFDn/ZbrQFnDb34EWNcJhZoHJXZH7yKVWM5azC0Ct
 hEl4C0lDBvzke+ADqq151CuAfzN2Q6Gi3wyMgEhjSfBiNp8KgTVBbbAhPMzuIVMYbVrL
 3F6ZGD9dYI0/SAEwjGvTYlU4anZhBEV4gR5l4g6iFa+wSrcgjRwKVYx4mZWpy1m7Cqx/
 FB+Q==
X-Gm-Message-State: AOJu0YycILwFwAq41IHgM5yaGvqVI2XGEWsB0xCnEz0j81qNbgrBZNk3
 W3mEASGJ1bhKKdcudjkAxWKuFB/3Xksx0IfORNODTmzfvzgHP45hJdpn4LEwv3Eiid2fN/gG55r
 NOBs=
X-Google-Smtp-Source: AGHT+IEI/y1eovlZ8uBUJ5VPOtuBrLM9ewEwB9jXtNkx+4a/M7WrCng4Tj57s3eB6Gxc7cIvrTljDg==
X-Received: by 2002:a17:902:e5c6:b0:1d5:ad95:f30f with SMTP id
 u6-20020a170902e5c600b001d5ad95f30fmr1540163plf.1.1706853325196; 
 Thu, 01 Feb 2024 21:55:25 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 47/57] target/sparc: Use i128 for FdTOq, FxTOq
Date: Fri,  2 Feb 2024 15:50:26 +1000
Message-Id: <20240202055036.684176-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-13-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 5e93342583..20f67f89b0 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -94,14 +94,14 @@ DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_RWG, f32, env, s64)
 DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_RWG, f64, env, s64)
-DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
+DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, i128, env, s64)
 #endif
 DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
 DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, i128, env, f32)
 DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
-DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
+DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, i128, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
 DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
 DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index c7dc835d28..9a0110e201 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -163,9 +163,9 @@ float64 helper_fxtod(CPUSPARCState *env, int64_t src)
     return int64_to_float64(src, &env->fp_status);
 }
 
-void helper_fxtoq(CPUSPARCState *env, int64_t src)
+Int128 helper_fxtoq(CPUSPARCState *env, int64_t src)
 {
-    QT0 = int64_to_float128(src, &env->fp_status);
+    return f128_ret(int64_to_float128(src, &env->fp_status));
 }
 #endif
 
@@ -195,9 +195,9 @@ float64 helper_fqtod(CPUSPARCState *env, Int128 src)
     return float128_to_float64(f128_in(src), &env->fp_status);
 }
 
-void helper_fdtoq(CPUSPARCState *env, float64 src)
+Int128 helper_fdtoq(CPUSPARCState *env, float64 src)
 {
-    QT0 = float64_to_float128(src, &env->fp_status);
+    return f128_ret(float64_to_float128(src, &env->fp_status));
 }
 
 /* Float to integer conversion.  */
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6522a9b0c8..d478a2fcd0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4750,9 +4750,10 @@ TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
 static bool do_env_qd(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_env, TCGv_i64))
+                      void (*func)(TCGv_i128, TCGv_env, TCGv_i64))
 {
     TCGv_i64 src;
+    TCGv_i128 dst;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -4763,9 +4764,9 @@ static bool do_env_qd(DisasContext *dc, arg_r_r *a,
 
     gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_D(dc, a->rs);
-    func(tcg_env, src);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    dst = tcg_temp_new_i128();
+    func(dst, tcg_env, src);
+    gen_store_fpr_Q(dc, a->rd, dst);
     return advance_pc(dc);
 }
 
-- 
2.34.1


