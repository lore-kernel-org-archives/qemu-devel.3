Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160C3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mqO-000255-IP; Sun, 05 May 2024 21:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpf-0007hE-DN
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:55 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpY-0003Mr-Up
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:55 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-23d16b9bca7so651362fac.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957666; x=1715562466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6klc6IkoJ7yIvXMWyMfy0cu8G2GrfjYUKzGDkQ2bDI=;
 b=Xs+qI6c5JfNSmxnzw4VGTdawuVoV8VwYf7leHwHlm/Ptu9IBMBYpYQyLWTxmuIJqVN
 RUuNTwnJnG41iDAB+OEOTwfMwmL9o5L7g0fpfGve4Cbl2or536wLW/44wCYKU+ssv1a1
 JJJgnKk4zXiGdfWnAM4u/agJ1daVckZdI6FfTujbeyMV82BVt4l2tOW9OUM7Vvt/JGq5
 4uEI6m/BPw4wvMcbCpyHD4P6kzBu37X6Jia+XnlOJBYUZkOdlD3uEFQEoL3iLF3E9CNx
 6E8srleJT5PH1uN62ikZyYe6MExcNjAS+FoSc+/A6yuxO+QXhNWArlhzP+Y4rEa1hj7y
 ZzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957666; x=1715562466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6klc6IkoJ7yIvXMWyMfy0cu8G2GrfjYUKzGDkQ2bDI=;
 b=ryUXY6Ih4bBb/FKFvTf3jDzx9WDMu26xdb5KkVc5wUe4OYw3C1oUS6WYmzsYXuQC5m
 SfEDFqGfVJGPLY6ff4shAG6ILTtnJ/GI2RtuLWPpzAe2Q529ZW2fuRE5zTTQ/ONvNCdI
 KfjQF+mI8Ixh4tYdnwoTtfPhNZKJvs4d5QA4Cim/UCy9A1tbSjT6kdTesrDuH0r8y5Ta
 IJgVqRTDZ+OGlO2jWZraUIYDEa2Q2B+hq9pPXKOWrRypipdL4WGsN0dqfDymK0DTXRm3
 nYwlzQKhiqmObq5bzvmCcwxLuW2Tfgd1Z6Em2SYTkWtKzXpJPNFBU74GRugWQpdOnNMY
 NCEQ==
X-Gm-Message-State: AOJu0YwlS2pA5UvLX16N+kQg+z4vVazmlgJR2FW3lXN8AwxfXXF/DckL
 XlmlCmU/GZCrEDEnbopX+HgeTkH/aLA09Xcq/I2KlWkm5CWFE+11du74DheOLuD6WmPXwDcvU8l
 0
X-Google-Smtp-Source: AGHT+IFNjmkblyvVSN7OaWQrRzUpllYXTe5PgSzYlOaJ+568cQOluQdFjNyp7exqcWdlM4OfrsGXMw==
X-Received: by 2002:a05:6870:818f:b0:23b:e418:d967 with SMTP id
 k15-20020a056870818f00b0023be418d967mr10928296oae.12.1714957666383; 
 Sun, 05 May 2024 18:07:46 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm6577287pfb.193.2024.05.05.18.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:07:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 49/57] target/arm: Convert SHSUB, UHSUB to decodetree
Date: Sun,  5 May 2024 18:03:55 -0700
Message-Id: <20240506010403.6204-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0881f00ecf..80c4c650c9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -914,6 +914,8 @@ CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
+UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0e28a5abbd..83e2c363e7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5457,6 +5457,8 @@ TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
 TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
+TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
+TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10917,7 +10919,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         /* fall through */
     case 0x2: /* SRHADD, URHADD */
-    case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
@@ -10943,6 +10944,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
+    case 0x04: /* SHSUB, UHSUB */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
     case 0x07: /* CMGE, CMHS */
@@ -10961,13 +10963,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x04: /* SHSUB, UHSUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhsub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shsub, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


