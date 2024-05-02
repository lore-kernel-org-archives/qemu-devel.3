Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEC8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ziv-0001Pl-KH; Thu, 02 May 2024 12:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zic-0000wn-Mx
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ZiZ-0005vk-5O
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:38 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6eff2be3b33so7579414b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668934; x=1715273734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMR2OW95a+er7mlGlAcae8r7qmSgirTok885mixb5OA=;
 b=EuuUqSuqrendao7At5lK3nRKslyXYEr8L0RpDlDQ0XNKV+yRzX50/Bdpp/mKs8bMN1
 jY/kTEDB1XEzSNDWPCcOmPWvTRwritC8YWmV7ezSkob5Lci6ehBIA59WgMd89ycksSBI
 5fcgnyGS9HqBKWwaLphCRGNXOmwgAqm9EeJQXgYlxrvZHMlGoE+Zq+mnGsMT4zGl6VSE
 FVefRgmXeH7KcitYRFdzUhdiNGkqX3NxOgrkyOZ9BF0DCJb/pQDO7cjVDDveWDL1hMRN
 nyu0TjNctGnHFtGp1jh4ppE6Dz2mplvg2MWsh1hDy+6EJG+/2sOwYP1fyXBkTMTYkO31
 1xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668934; x=1715273734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMR2OW95a+er7mlGlAcae8r7qmSgirTok885mixb5OA=;
 b=OijBysMf3xtbFKAX3TG4hfRqoxQ21Oii+16T/22FWkoAkEGfb2RbVidMzkju5Lyu2x
 1AQG80geTd/1Gul3pOyxWEZF31BUlwTyGUbrRrohMjvExmCjPQYZlAwxAr+jwwj17ErU
 Y7zHYXkyAi+v8wk2sTdgFPUzUObF8Mo6DKKnNJJowIsltol7Si0VjiRr6DlcKZBIoZHg
 8sB8tAOvj6JE+UBgzmRth6RWdv5AD300odTpFPPzqm35Nz1fuZHEAso1Rvo+6QfRKUbU
 w6Ga7M7Ah/ZKVX3TOzbm7asNAa4t3T/3K/qdnW6P2Nau88QqfP28Bc3xfT2hWxuZ1F4Z
 c5gQ==
X-Gm-Message-State: AOJu0YzAsj5ncYN10g6HEMld8Ut4Sciz4whHlros+2ahHntnfHjqcwx/
 o2bExwY/KO/P6Rc0Kjq0v8cs41laXrmI+xEtpbyIiMRbRggZ3quoxAAttw4X4dpGdWNx7mOiTyy
 Q
X-Google-Smtp-Source: AGHT+IFHnoZNelTANmowOnEy9NYJ+1c2G95KVEBK7efCvT7izyx2NL+m8qtjbcqdPEqo0jpXehGBdQ==
X-Received: by 2002:a05:6a21:3991:b0:1ad:7e82:c091 with SMTP id
 ad17-20020a056a21399100b001ad7e82c091mr278128pzc.10.1714668933914; 
 Thu, 02 May 2024 09:55:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 5/7] target/sparc: Fix FMULD8*X16
Date: Thu,  2 May 2024 09:55:26 -0700
Message-Id: <20240502165528.244004-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Not only do these instructions have f32 inputs, they also do not
perform rounding.  Since these are relatively simple, implement
them properly inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 --
 target/sparc/translate.c  | 48 +++++++++++++++++++++++++++++++++++----
 target/sparc/vis_helper.c | 46 -------------------------------------
 3 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 9cde2b69a5..fcb9c617b7 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -99,8 +99,6 @@ DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a8ada6934a..8a2894bb9f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -74,8 +74,6 @@
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
@@ -730,6 +728,48 @@ static void gen_op_fmul8x16au(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
     gen_helper_fmul8x16a(dst, src1, src2);
 }
 
+static void gen_op_fmuld8ulx16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    tcg_gen_ext8u_i32(t0, src1);
+    tcg_gen_ext16s_i32(t1, src2);
+    tcg_gen_mul_i32(t0, t0, t1);
+
+    tcg_gen_extract_i32(t1, src1, 16, 8);
+    tcg_gen_sextract_i32(t2, src2, 16, 16);
+    tcg_gen_mul_i32(t1, t1, t2);
+
+    tcg_gen_concat_i32_i64(dst, t0, t1);
+}
+
+static void gen_op_fmuld8sux16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    /*
+     * The insn description talks about extracting the upper 8 bits
+     * of the signed 16-bit input rs1, performing the multiply, then
+     * shifting left by 8 bits.  Instead, zap the lower 8 bits of
+     * the rs1 input, which avoids the need for two shifts.
+     */
+    tcg_gen_ext16s_i32(t0, src1);
+    tcg_gen_andi_i32(t0, t0, ~0xff);
+    tcg_gen_ext16s_i32(t1, src2);
+    tcg_gen_mul_i32(t0, t0, t1);
+
+    tcg_gen_sextract_i32(t1, src1, 16, 16);
+    tcg_gen_andi_i32(t1, t1, ~0xff);
+    tcg_gen_sextract_i32(t2, src2, 16, 16);
+    tcg_gen_mul_i32(t1, t1, t2);
+
+    tcg_gen_concat_i32_i64(dst, t0, t1);
+}
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4614,6 +4654,8 @@ static bool do_dff(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
+TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
+TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4654,8 +4696,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
-TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
 TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index ff2f43c23f..61c61c7fea 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -194,52 +194,6 @@ uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmuld8sux16(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 8);       \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_L64(r) = tmp;
-
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
-    PMUL(0);
-#undef PMUL
-
-    return d.ll;
-}
-
-uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_L64(r) = tmp;
-
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
-    PMUL(0);
-#undef PMUL
-
-    return d.ll;
-}
-
 uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
-- 
2.34.1


