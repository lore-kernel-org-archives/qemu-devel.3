Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472DBC02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYJ-0006Xo-Ko; Sat, 01 Feb 2025 11:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYH-0006TW-1k
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYF-0001Ce-Hb
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso20619935e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428058; x=1739032858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QOw8scFPjKUk+oXyJ2xWsNA86wdi8W/z0T/XnJFQXpg=;
 b=whg65OAteAuo7b9/0EJT2T0VVCtvjmNUhrv1KaMeDaOPSCMEyIFBhFp+F6eGsRHDgT
 nqE+nuuLJQ8mCTo64CzkGMDBWkuACeoEK4qYkQ2jclKlgrmgb3olqq0+NJy8oTr+huQU
 6uJrmjmoxam2PkKcYV9crYFSgVB71WsFUpUPxNDGqWttM5MXSQ2cv+Jn4RvaJ/+NlUdk
 oWQMNHBM66zGD/JcckkyUq3FUX1v2LMlzK2ygxdt0pdHAYUVWYKS0SjfWvAwZTJweaVi
 HZcQqTWo5b/Dsieh/sohivZwTG/L513A2PGKqfAv6WdzKMWw/VXW2ABum3IhXe+5lzFT
 hDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428058; x=1739032858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOw8scFPjKUk+oXyJ2xWsNA86wdi8W/z0T/XnJFQXpg=;
 b=WAZ+I+a7mzTHeaVF+FvZ1+uzfHNOYQ/wc3gtCAP5twAFss3C1sQ7CbrawSk3KF80zL
 kmoAoouMh/nLRnLHWYSnlsc+kMF19HcXBBFCSKewKHAHoHlMLl6pDutXD2XPkUxj/bxp
 YJVgPfN8QGKJpaR17Yw1n1TIcAEsDhhx5wT5YAVBQkk7JE/D6X9R8C6VvDSHJ77SEAY0
 B4PHqh/luXAqmu2zHcR7Qkm8Xs9PzvpQzBDmCCFCTsIwAj58nqksKXX2M3Rmec9XZ3DH
 KlSUivrIrf+RMb8lFt8VxHWiTki5W6fseb8mAPQvqBvhUERFE5/nunUW0UxTkJsPQrNA
 fFmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjkIFSF6DvxbdXYdjkazP2/1V6NEoDx2TSZ31Ho12uvff9ysReU02pxBtqD3YsFVhl8iIJTZ/zgNs8@nongnu.org
X-Gm-Message-State: AOJu0YwLp0RXId73t+Ekkc1+gAfx4b77cpAPN2Iwz8HLw3446PgcDYb3
 W/6Yr5n0keIvueNvuBcKBjBpvoMljURPEXEV1KkiiL3lPxJ2M4troXC6g/1mUh0=
X-Gm-Gg: ASbGnctGElQ5i4Mv9YtUYVdNgQttA9fPyoKyCs3iOV15EuqTkAyIubGPuhJvPoz17Lh
 2vas923V3Ez6+v+pFs1eQMXi8JXhIvyCVc1holQTTUqbreYxLGIPfnfa4Bm9x8NcmB4r5yVvZ4P
 15UeQyAt7pYUVTQ820ZApE58m+xHj3r56eo63p3nDUtRh8KzhXEPDiVXRupr7g05Z6QH48huRl8
 vEHZdKiVAmWy9T0t4f49UwYMunvW5fGb+0sZh/3nB/DzmLBQvcnPyx+lY2d1zY8Ec6SoPajMwnB
 EYVHNWzMoMkOARyhuINW
X-Google-Smtp-Source: AGHT+IF4rA4fh3ORgo5vDOd1C/RXMTrCI7F8vWBIT0pZ241qigZshJkL+6+XnAudyjgRLqgWMXIRrw==
X-Received: by 2002:adf:f5cd:0:b0:386:32cb:4aa with SMTP id
 ffacd0b85a97d-38c520bd981mr11323347f8f.45.1738428058072; 
 Sat, 01 Feb 2025 08:40:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 32/69] target/arm: Implement FPCR.AH handling for scalar
 FABS and FABD
Date: Sat,  1 Feb 2025 16:39:35 +0000
Message-Id: <20250201164012.1660228-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

FPCR.AH == 1 mandates that taking the absolute value of a NaN should
not change its sign bit.  This means we can no longer use
gen_vfp_abs*() everywhere but must instead generate slightly more
complex code when FPCR.AH is set.

Implement these semantics for scalar FABS and FABD.  This change also
affects all other instructions whose psuedocode calls FPAbs(); we
will extend the change to those instructions in following commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aee2e1307e4..862f7333982 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -880,6 +880,43 @@ static void gen_vfp_ah_negd(TCGv_i64 d, TCGv_i64 s)
                         s, chs_s);
 }
 
+/*
+ * These functions implement
+ *  d = floatN_is_any_nan(s) ? s : floatN_abs(s)
+ * which for float32 is
+ *  d = (s & ~(1 << 31)) > 0x7f800000UL) ? s : (s & ~(1 << 31))
+ * and similarly for the other float sizes.
+ */
+static void gen_vfp_ah_absh(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32();
+
+    gen_vfp_absh(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7c00),
+                        s, abs_s);
+}
+
+static void gen_vfp_ah_abss(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32();
+
+    gen_vfp_abss(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7f800000UL),
+                        s, abs_s);
+}
+
+static void gen_vfp_ah_absd(TCGv_i64 d, TCGv_i64 s)
+{
+    TCGv_i64 abs_s = tcg_temp_new_i64();
+
+    gen_vfp_absd(abs_s, s);
+    tcg_gen_movcond_i64(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i64(0x7ff0000000000000ULL),
+                        s, abs_s);
+}
+
 static void gen_vfp_maybe_ah_negh(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
 {
     if (dc->fpcr_ah) {
@@ -5403,12 +5440,35 @@ static void gen_fabd_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
     gen_vfp_absd(d, d);
 }
 
+static void gen_fabd_ah_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subh(d, n, m, s);
+    gen_vfp_ah_absh(d, d);
+}
+
+static void gen_fabd_ah_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subs(d, n, m, s);
+    gen_vfp_ah_abss(d, d);
+}
+
+static void gen_fabd_ah_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subd(d, n, m, s);
+    gen_vfp_ah_absd(d, d);
+}
+
 static const FPScalar f_scalar_fabd = {
     gen_fabd_h,
     gen_fabd_s,
     gen_fabd_d,
 };
-TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd, a->rn)
+static const FPScalar f_scalar_ah_fabd = {
+    gen_fabd_ah_h,
+    gen_fabd_ah_s,
+    gen_fabd_ah_d,
+};
+TRANS(FABD_s, do_fp3_scalar_2fn, a, &f_scalar_fabd, &f_scalar_ah_fabd, a->rn)
 
 static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f16,
@@ -8654,7 +8714,12 @@ static const FPScalar1Int f_scalar_fabs = {
     gen_vfp_abss,
     gen_vfp_absd,
 };
-TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs, true)
+static const FPScalar1Int f_scalar_ah_fabs = {
+    gen_vfp_ah_absh,
+    gen_vfp_ah_abss,
+    gen_vfp_ah_absd,
+};
+TRANS(FABS_s, do_fp1_scalar_int_2fn, a, &f_scalar_fabs, &f_scalar_ah_fabs)
 
 static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negh,
-- 
2.34.1


