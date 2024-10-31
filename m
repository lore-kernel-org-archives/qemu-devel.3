Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8178AE68957
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mjc-0003m6-Ll; Thu, 31 Oct 2024 00:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MjY-0003eg-Sp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:24:33 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MjW-0006wW-Sz
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:24:32 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539e4b7409fso527433e87.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348668; x=1730953468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x7E4EwIDP0iHX0TCLMI+ENpIXFIMAkBEanU5IejIg4=;
 b=VOP4QxQ6MVfiE8+byr5XN67oenb/0IIMpNgO5RP8owfbZSomfPavpKjgCttgqbLSyI
 n/j+3pEQVEqLoK3G0sXEsnZ3Lxk/PP0k2gHqW9gS6lvJtx6vTyLjHt4Oedg1xG6Mupdu
 qCHBz+TTc3J6QeNu+kL71gOIuxnls+1d1RS5HA5683fyk31PugFRyx/FnStMXBP5CRRn
 Bx7InzqVY8ihVvyQXTBuiAUCIh7PKj6c3zsSdHbf+o7krycdVXa3T52cEMmbuqh6zaBz
 1X5k7Re+1wSgQwEUkZYY1oqQ3xbeNqMLnhr3t4YvV9umyEtyZ0kcA9oZW9tAulFouc38
 eZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348668; x=1730953468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2x7E4EwIDP0iHX0TCLMI+ENpIXFIMAkBEanU5IejIg4=;
 b=jgSqFRxSYSo5uqsexZ0zLw/vb1UOzUrkqvMkX7HUM9l3oGz6a3/QWGfFHlWZdcwP3f
 CKT8U9U0IVFG4ZRnhHUAHffkbMj3aV+Vps6+0IBrBjbz4g0KLszup/jHyxjocv2crPzt
 fFWNmykuuK2GXcPJmkt6PagtvDkh9kYU0cKqvNhVmw/A5qFiskblsPSRbdfxPHO7ee39
 BhL4pXWs+sA+7QAXOn/RvQrB/Rh6Z3a1Q9TNnK7iv3MRVP1c+If6iRO0ys47CRaN4lmT
 7I14MCTrorXN6fwp5aJXAG9varoSoypz0yEIz9syixydcx4INdPR2qijUZr6K7LJqflT
 LkDA==
X-Gm-Message-State: AOJu0YyB7sPEUcOLOZNytWOt4ewMGkUYe3IpfrG3xLxqhz8EdPgnj3e3
 zQ0EfWI5onh1oAEW2eHuVbjJ4LXD7/N7TL+Q1eQP0J7IpMQP3MWPMIH4EQCOmX/n3T+WCeR/hvg
 j
X-Google-Smtp-Source: AGHT+IFwqMEzgGK+PkIxMTrLp3BUzie2pu/Kn61PF3EQ4H4Ac+h2LLhN+TpGmkoi2YxSKvlHLFAWRw==
X-Received: by 2002:a05:6512:6c4:b0:539:fde9:4bca with SMTP id
 2adb3069b0e04-53c7bc5b1fcmr210911e87.29.1730348668422; 
 Wed, 30 Oct 2024 21:24:28 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc9c070sm78302e87.84.2024.10.30.21.24.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:24:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/14] target/mips: Remove unreachable 32-bit code on 64-bit
 Loongson Ext
Date: Thu, 31 Oct 2024 01:21:27 -0300
Message-ID: <20241031042130.98450-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Loongson fixed-point multiplies and divisions opcodes are
specific to 64-bit cores (Loongson-2 and Loongson-3 families).
Simplify by removing the 32-bit checks.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241026175349.84523-10-philmd@linaro.org>
---
 target/mips/tcg/loong_translate.c | 41 ++-----------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index c02e60bb15b..a005c279a3e 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -31,13 +31,6 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -61,8 +54,7 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     tcg_gen_br(l3);
     gen_set_label(l1);
 
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
-                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     tcg_gen_mov_tl(cpu_gpr[rd], t0);
 
@@ -93,13 +85,6 @@ static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -147,13 +132,6 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -173,8 +151,7 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
         tcg_gen_ext32u_tl(t1, t1);
     }
     tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
-                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rd], 0);
@@ -205,13 +182,6 @@ static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -257,13 +227,6 @@ static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
 {
     TCGv t0, t1;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
-- 
2.45.2


