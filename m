Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9488D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdicB-0007Ts-2N; Thu, 08 Jan 2026 00:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdic9-0007IV-A4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:17 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdic7-0005Sa-MG
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:17 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo2048784b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850274; x=1768455074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ij3Ceib4U8wNBcIbPBAFj13cL0r+CB0iw6bbk1bE3xI=;
 b=W9wJgitbALQfkbHkEPKazzcb63oy65RcMfZFF4otnrod1IbNFP5Jegu9IBzfne67QF
 D1B3IOtjUyWyBqUo1WvyaHoGBYGTBx/6Sbp036oNpLy8hyte3FAOIGPKbx+RY85ADQI3
 aWtA6C8ppCnPRQV9iQ+eZYEttEoQYtOQ94X0fRoi1HqKMme5/DIoNR42n2N1Aup2VSjP
 HS/h17iZX5EVtIqb/4df43kGS+hZEPF02GlpiqkxYaOWA9HFfkZFqBwGmDtKFFyt83CG
 7s3DvE1W2RoMfu2euwoo3d4lXGo28BTx6EBvB+mUG06Vw8OtKg3hTfLd8hACY7JweWr/
 jpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850274; x=1768455074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ij3Ceib4U8wNBcIbPBAFj13cL0r+CB0iw6bbk1bE3xI=;
 b=LM1lKIpsUIwGlclCKQxCWhnjsAhTPVZBfwGyC94b0zF3qwcCW6t1t+kbLtFAM3X98F
 7iKWyAUeZY+RA3uBQhFqDXzU58QMe0Y/UPWnKzQI4EnJBUTVnqRAB3zlPn8fTP6F/mvV
 XUfW6VS9XbPofs4dlfn2EiaC/A9jhfaOuNkTGqho1kM/4E12TguZxLzxPiW0FINMRsCB
 Zl/Jjg3/Rao1b8X3AhC7cZ/7rDQiEhQbxqAtao7XojnlqUU7X+rgaastGMW5gQlUQ8af
 2Ggrd0cf+Q8LomG8Z2oTvJBJf0dI7DJAlDJ4i7QWYnakCsxUlSE74Lbj8AqGmck9dGpG
 Luow==
X-Gm-Message-State: AOJu0YzOcg1ZxI6Cnr9Gra2WyOmZmHix57oTowY4eEfvLfTDeD464EKZ
 r3i3oZbrRuQ3/t7IjcU+g1XUTvjcRZ5FWSeaLMfvhLmHCRECKqxBALjwhizACq1wILq42lK2puP
 o1+QdBDk=
X-Gm-Gg: AY/fxX7tQfyG1OwEUzMNDFix2/apBWE9QY4r3HTuFR9jzAmTDTK/aXTiGON2M0eK4UP
 EnJ2dqnrXDSFT1fg1qNDPYjdXd0vqyRxV0SY1/mrfe9z6myeH4cDjF3+R/K1gb+Qje1u3IZt3tW
 KAEg6cVmPbe31WQCKx2uKrnd1DiemqwjX+XnhXYBQ2q3AdtNSQ3SCokb7ORQPnR1mOI1L5o5CLE
 WC2/NORF5Zr9JYl+TzYHV1x3oG14Plt8bkFNUtI7z/Kd5K7NXgssa3rc2LVzI/Dd6tErkCCrxum
 6o+cFx3FoCsVc4jumfkOe+VK0e8p2ZWjmduuPaIA9ggEvNvRSnVqksiS1ZLwqGlBJPkCRe4m6c+
 j8FrmJPqxglrLVwPywenBtiAhIlXglVfhOag1LLcc96xX2ibLSXgYZOwpFiA7Zm0+Rx8X2xrOKD
 y1fdbruV4gEBlzJgsd5bsIQ6sb0ATP
X-Google-Smtp-Source: AGHT+IG9jY9Pf4p48VaFEXQLZoLl+M9SLPZQ4jOxjtsa3piqsiu0ufW9ExL+fNzbXaAp4WoJsTm5gg==
X-Received: by 2002:a05:6a20:939f:b0:366:14ac:8c76 with SMTP id
 adf61e73a8af0-3898f9e2dcfmr4687313637.76.1767850274152; 
 Wed, 07 Jan 2026 21:31:14 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/50] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
Date: Thu,  8 Jan 2026 16:29:54 +1100
Message-ID: <20260108053018.626690-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 tcg/tcg-op-gvec.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2cfc7e9409..bc323e2500 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -586,12 +586,11 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         }
     }
 
-    /* Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and no variable dup.
+    /*
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 with 64-bit variable dup.
      */
-    type = choose_vector_type(NULL, vece, oprsz,
-                              (TCG_TARGET_REG_BITS == 64 && in_32 == NULL
-                               && (in_64 == NULL || vece == MO_64)));
+    type = choose_vector_type(NULL, vece, oprsz, vece == MO_64 && in_64);
     if (type != 0) {
         TCGv_vec t_vec = tcg_temp_new_vec(type);
 
@@ -612,11 +611,11 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         t_32 = NULL;
 
         if (in_32) {
-            /* We are given a 32-bit variable input.  For a 64-bit host,
-               use a 64-bit operation unless the 32-bit operation would
-               be simple enough.  */
-            if (TCG_TARGET_REG_BITS == 64
-                && (vece != MO_32 || !check_size_impl(oprsz, 4))) {
+            /*
+             * We are given a 32-bit variable input.  Use a 64-bit operation
+             * unless the 32-bit operation would be simple enough.
+             */
+            if (vece != MO_32 || !check_size_impl(oprsz, 4)) {
                 t_64 = tcg_temp_ebb_new_i64();
                 tcg_gen_extu_i32_i64(t_64, in_32);
                 tcg_gen_dup_i64(vece, t_64, t_64);
@@ -629,14 +628,16 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
             t_64 = tcg_temp_ebb_new_i64();
             tcg_gen_dup_i64(vece, t_64, in_64);
         } else {
-            /* We are given a constant input.  */
-            /* For 64-bit hosts, use 64-bit constants for "simple" constants
-               or when we'd need too many 32-bit stores, or when a 64-bit
-               constant is really required.  */
+            /*
+             * We are given a constant input.
+             * Use 64-bit constants for "simple" constants or when we'd
+             * need too many 32-bit stores, or when a 64-bit constant
+             * is really required.
+             */
             if (vece == MO_64
-                || (TCG_TARGET_REG_BITS == 64
-                    && (in_c == 0 || in_c == -1
-                        || !check_size_impl(oprsz, 4)))) {
+                || in_c == 0
+                || in_c == -1
+                || !check_size_impl(oprsz, 4)) {
                 t_64 = tcg_constant_i64(in_c);
             } else {
                 t_32 = tcg_constant_i32(in_c);
@@ -3872,12 +3873,11 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 for a 64-bit comparison.
      */
     hold_list = tcg_swap_vecop_list(cmp_list);
-    type = choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    type = choose_vector_type(cmp_list, vece, oprsz, vece == MO_64);
     switch (type) {
     case TCG_TYPE_V256:
         /* Recall that ARM SVE allows vector sizes that are not a
@@ -3992,11 +3992,10 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 for a 64-bit comparison.
      */
-    type = choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    type = choose_vector_type(cmp_list, vece, oprsz, vece == MO_64);
     if (type != 0) {
         const TCGOpcode *hold_list = tcg_swap_vecop_list(cmp_list);
         TCGv_vec t_vec = tcg_temp_new_vec(type);
-- 
2.43.0


