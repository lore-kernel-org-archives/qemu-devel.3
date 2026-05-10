Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72503CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwc-0004zU-JJ; Sun, 10 May 2026 16:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwa-0004wm-L6
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:08 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwZ-0003x3-7K
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:08 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso2171615fac.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445605; x=1779050405; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMtQ6otfSvVpuO6rahx7fwVTGsLSe4NmUYhcy52IxfI=;
 b=PJEdeEBk5euDTmK6hLlTPgnh25CAs8egQnJPYsO/C0639pd08sWt0RqkieEAQtJhtR
 YM45MzFX70LciF7w9skHzO/S4wproIHfJyNsapZ45DYVujVGzsrbEM6EyzP4VZ6Zwgcm
 kHGKbNjePBgiADiefGBMn5/WOOboj/Fv/t5ZlH17NCoZkHhAt+NUSH43ZLlDYCbDY59/
 7xqmvpZbXRqOL6P4g/tqJGmJ2WupiqgTR2V+5dJqRU/kBFmUrxz0jpOFi88X8ZGNnipK
 qrieqSsQobj559PAcw1+yTiPFODCAmD4tbS+eimXAQ/ekENnz7iMYv4z5jJDfHFYEPd0
 EFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445605; x=1779050405;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DMtQ6otfSvVpuO6rahx7fwVTGsLSe4NmUYhcy52IxfI=;
 b=W2ldCDaCiGp/So2nzNHcrNbSLVwW+dx2aCmWPwpI/R6qitwN0dc8FKDHIzC/SXF5u5
 roME+X4nA/0JWtFiUjCWVaESu9lIPPpQfRFaIloL5OiUDi3w7mGpa+YcNVGGJ7B8ysGU
 ylEVY5UYRaCTWI3GNKiIQRE5Pi0P6vXRxInDjo/i3JD+P6E2GlTcVGedK1XnMp6zQ8vk
 mf/AnO9JhAtpYYt7tW980jf0/SMdvykf5xcBNbuwztmTRvhvvxEJkYsNo2sOOB/PDwW9
 HXbLNQE+EBIBWGQmGi00s7hWP3YS2RDJocNuEMlshubKcA6GXTXOoHF3lyg64tyxUHP5
 HdWA==
X-Gm-Message-State: AOJu0YzcJD/8ell15ybwlFj2z3z21v0uhE3iw3dW9YcFykFtOIByadE1
 QPYpCzhUxl0m+ngs+TSUIZPtLAu2XyYfl7NUZB/2MhHUAdY0lRp3JieU
X-Gm-Gg: Acq92OFeftRIJjH1pvbF9pVoqpZdzIpN/XiW4afxpYoLLmTG3tkDxucOYbNwbupqI+l
 Ftr2WczL8pJIYcNyELPWEr/1px6FAOAoAtN+J2G4s3ia9z2YEBQTjYrNaqpFNjzUPcSFIaqgUeg
 R+lkBxwjOOuiXK0CR3O/1g18PqKNxJck98Vzk/aZsK4j0G71CNRRJMdRklqgRnrmK5tEEwECEGS
 33wRXmUQGbCpYrfWMeUYV0L8Frisidt28MTo8HBGkMSAsTtkgvAqRrnN0qtLAaV1/tpvlvgDC7C
 p0dDK98ESV1agA2DJLrHwZ96vz8U0iR8yJZ15OIrqLEC4qyDmLYBx8jwx5ZdfDfMBVqrUK7sO4O
 5kR73uaYr7nExk9xQ/421SFDffLVPQ44439u8/KXTVTE9Ao/5a5bHcGgETRKxG1+6C9xl17As2s
 zcfAqsHkomqgzlENZpyt6esjuet57lbQYpLU9O90Fv5JYh/ePtGyv9uKTBe308pqgH6Mbn19gkh
 FAY1XoLThVlpzWIA7BVE9y6i4fxr4Anbny6X7xIoYT7jb8dhq2RFA==
X-Received: by 2002:a05:6808:178d:b0:479:d57b:838a with SMTP id
 5614622812f47-48042487e9bmr12809834b6e.35.1778445605396; 
 Sun, 10 May 2026 13:40:05 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:34 -0600
Subject: [PATCH v5 04/32] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-4-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


