Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A157C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY7-0006FR-C4; Sat, 01 Feb 2025 11:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY4-0006CS-2R
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:48 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY2-00018v-8B
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:47 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so35121065e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428045; x=1739032845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bnhwa00yLr4VQXjWCmJB9nG9V/x9ySKrwjOdXwHQEUE=;
 b=cfrKCUxXZ6xK1BmbSo6IBNkPcWlFVD2yVmKin3s3kp5RgaDT9iqP7D7J69bQgvapah
 5f7lLBFB+epTYgzMqJgFPXC4JdYOfxN5ufAlnzjpPtKMNOAJLPrY8np1oC8H40c7td+p
 Br9DulEvimvDQy3F5zqzClzCnwmQnbCf4IRDZLk45uOSUvkkCYI5+Kav+018Ub3EIvNh
 8Bo7/Yi9tPuk4D0b2fsHyeBYXDOfRUgOivUQJcEvn/LCI5swXMigclOC8IOxzjTkg5B5
 oKrbfns3VBT38CSunNsdZvE1iL57/izW/hQ13c1i6md/QotJJCAkUt6moUgfHA4A0jr4
 +lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428045; x=1739032845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bnhwa00yLr4VQXjWCmJB9nG9V/x9ySKrwjOdXwHQEUE=;
 b=w2DNqIwXk2oAnAjlwjd5NIwgETkU67snOf1CzTzmLaoMijlBZgczszgJ+Kw8Me+esI
 OA6MT2F9JMNIRQzP1cCcbItR/5By26K4cCbjhJlcJL3SPa8i1mS0FBWAIgim/2xrfh2q
 b+p5ogIxyz/COppTtOvkkfQHBwx8kV8xZ8k2WJN+Q09QBFsXjWkvbCCpaXB3NNNySKe9
 81AD+zbUNjUjUMq4H4B/A2nyHE7z0TbOhaHfV3bdff44GAQoi1+N+UpkYfPfnWW9pPsI
 grqVkM2B88mmTa+TSgRd8JR/986kpeNKQvXCe9t0Py5RlqMj3XMRJllVzpyx+ZOTJ1aA
 xVyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbCcXyJw+f14QM5qnPqyvyDzXynq+FRRygXpI3Q0tQ9O5Kx96SbkMY+VdEfRqrubgYRqWH+8vUOOTb@nongnu.org
X-Gm-Message-State: AOJu0Yye1imCqUDG4bBNt3v2hT4YWg0V9rXGHLXK5IE4Yjpk0wNVTkyz
 TxgHmiS2xcpkgaNQU642M0uMffX3o+uJNaKt4BM2bwDgFZVsah6Bsw4iEN/B8snisWYu9ZdZmTj
 B
X-Gm-Gg: ASbGncuZDfQujB3qZx+4Db+XyOrblfrtsQvVW2IckgdGc2TDs2w03tfBN4hEgt42+Un
 Tg7J1e7KwY5IL34Qtf7L19clG5VLYNoQpnMh5rOEEc2/dI+uFD3hx7VP1Gg0Wfw5SZ0ah4PzBsm
 A2kjFJ1x4ztvunN1ETev/IVqrQJCTc7i/JcS3swB5gg2nLCP6+ayhC0Vq/FReCYa43MVIvoGj8g
 LGOmpj4Hdrxii73FnHMHw6mF9+U2TQK370xV60AA7RJbIJnZql301YjnLrCNDehaSaMveVzWfhc
 7AMzEn2TZUgJSVsg6Ze2
X-Google-Smtp-Source: AGHT+IFKlpGdPwYZBzC6HqwcTSD81VE6QrkmljJzJaM/TuZMRureBdoy9ZBs+Lch940gJqCkfmtpPw==
X-Received: by 2002:a05:6000:1acd:b0:385:e37a:2a56 with SMTP id
 ffacd0b85a97d-38c520964d4mr13115636f8f.52.1738428044843; 
 Sat, 01 Feb 2025 08:40:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 21/69] target/arm: Handle FPCR.NEP for scalar FABS and FNEG
Date: Sat,  1 Feb 2025 16:39:24 +0000
Message-Id: <20250201164012.1660228-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Handle FPCR.NEP merging for scalar FABS and FNEG; this requires
an extra parameter to do_fp1_scalar_int(), since FMOV scalar
does not have the merging behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f31ac3b9549..35db806d0b7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8437,21 +8437,30 @@ typedef struct FPScalar1Int {
 } FPScalar1Int;
 
 static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
-                              const FPScalar1Int *f)
+                              const FPScalar1Int *f,
+                              bool merging)
 {
     switch (a->esz) {
     case MO_64:
         if (fp_access_check(s)) {
             TCGv_i64 t = read_fp_dreg(s, a->rn);
             f->gen_d(t, t);
-            write_fp_dreg(s, a->rd, t);
+            if (merging) {
+                write_fp_dreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_dreg(s, a->rd, t);
+            }
         }
         break;
     case MO_32:
         if (fp_access_check(s)) {
             TCGv_i32 t = read_fp_sreg(s, a->rn);
             f->gen_s(t, t);
-            write_fp_sreg(s, a->rd, t);
+            if (merging) {
+                write_fp_sreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_sreg(s, a->rd, t);
+            }
         }
         break;
     case MO_16:
@@ -8461,7 +8470,11 @@ static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
         if (fp_access_check(s)) {
             TCGv_i32 t = read_fp_hreg(s, a->rn);
             f->gen_h(t, t);
-            write_fp_sreg(s, a->rd, t);
+            if (merging) {
+                write_fp_hreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_sreg(s, a->rd, t);
+            }
         }
         break;
     default:
@@ -8475,21 +8488,21 @@ static const FPScalar1Int f_scalar_fmov = {
     tcg_gen_mov_i32,
     tcg_gen_mov_i64,
 };
-TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
+TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov, false)
 
 static const FPScalar1Int f_scalar_fabs = {
     gen_vfp_absh,
     gen_vfp_abss,
     gen_vfp_absd,
 };
-TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
+TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs, true)
 
 static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negh,
     gen_vfp_negs,
     gen_vfp_negd,
 };
-TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
+TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg, true)
 
 typedef struct FPScalar1 {
     void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
-- 
2.34.1


