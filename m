Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150E4F428E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6j6-0005gS-FO; Wed, 15 Apr 2026 16:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6j4-0005cq-Nb
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:20:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6j3-0001kX-3D
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:20:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d7a5e77b1so2277523f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284439; x=1776889239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/fJbCFAPRAVo1uJrZAiFTkDKhoSheG/KaRtMAVYIKE=;
 b=tZU5TrsRIfC/Hlb+eCAIU7UwBt3V7UJqIXUoReRtCVxxotGKNdyXxxEQXh8JD7CVtS
 vCeZpFHpJ8npRqS/VP/a7YUqu2o/lpaLIZSlSg6/9Ylk+kuuspxJhX7DMz/UPSyUTmNB
 GwMR1Du7zQfLv6ovaE8Gqm9+wHFm+8hrtffvpjVOXCXbu+Dm6GgZt4kB0BQ7gx2X59wA
 8XwQGUuTo8YrDE7w38E+rud0Jm75kVYhJNho5byBc7c3jisoA6gdemgWcWmK+cA7jsMu
 LLy5ff1W93lX9iTs5f5+wA0vgBuKlklcmIs/wUSHj8ys/H9v5mB3VPcvdnZdGWUWIuYw
 107A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284439; x=1776889239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V/fJbCFAPRAVo1uJrZAiFTkDKhoSheG/KaRtMAVYIKE=;
 b=o/eO/s/IdK+wUh8qgl8o2axvz6C+MgD6xmqTWYQCQohbv6DFWpkLX8FWNTKvCfeXj2
 Knanb4+z8BmVgfHNV4umiC5WjQ1eg5FplcmyS73vOwVfbu6QVEVa6mmrf+dvrD4FP6rg
 ysCQe35QZlcTrnP37y0B53lL8lLuVSC1BMNT5ym0gdldxA6ZT0gWOf7OxCY3TVmrgs05
 3f/vYp/2IM4/BDYFlzXMnDZ7kveCqjsekkonFW9P5E+ZLtO0ZObgKNFrtXlsVj8/XM7R
 mNUpIiFrMVhm+4KyPy2fJTdSLXLHMHdbusYxFT+KJqIMw9vWgETyfQ85qo6lqOvB4Ur9
 p6ng==
X-Gm-Message-State: AOJu0YxpUaczN3dI3vIKmarxQTwx5gKDWH/a5WZxzsOL3ZDqMAqFcNwi
 f3CPoEvmwxpk/VSVK8T65JsKSowmSesprodKWX0+9KYhRKT7iiHL6s/chbavX1BLQH81dlyrSZK
 tiQ+D1b4=
X-Gm-Gg: AeBDietOANEqoqnReN+jcSMqx6GJBiyRF2C7qjpxRrcv/Y+wJ/NXflxPj6zKetI92Jq
 XgW3nsVDRLoX1Mi4kYdUMaFEfn6mRvdWFiAE9dFCvN90zgKhQlclhqz+FYFk8/IIwv/YuXN2qt2
 01xsC91gLDyblNprjveZ3gKCz3uWr26AMUY+CpDylRK84VTQALLC6TS9+nCUemSZKHWRK8S6RFF
 v0hpGulmOV8lIrRZcdJmMIcpkLEIpKlB4NX05oUU7SZu7pE0k7T7/FdOf8xwHXAANKhOTLAzudA
 1Z4hVPAe0Wc4HvO5aR/94QFcRyw9eL8ZlJznwv4QCLZUCQv4ZVwHSdEmbhVau1pUClDqUeMfO5R
 w0j/haCSuRnu0reJi94JG4+FxmfbAGt8gV7H5PcAGX/4ZN20u8iiP/p0huhlRJjXBK1gFfXuK2+
 QWbowrTal0uTumEDq5rTFbDylN80PzI+2PzZiCaIvd9Hy//yBvkgxUCcN65JtfknJh/v6jR3iK
X-Received: by 2002:a05:6000:2812:b0:439:ccd7:cdcc with SMTP id
 ffacd0b85a97d-43eb10e5a7bmr720188f8f.18.1776284439048; 
 Wed, 15 Apr 2026 13:20:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead35662csm7070366f8f.14.2026.04.15.13.20.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:20:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 1/6] target/mips: Expand TRANS_DF_iv() macro for MSA
 Load/Store
Date: Wed, 15 Apr 2026 22:20:21 +0200
Message-ID: <20260415202027.83008-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202027.83008-1-philmd@linaro.org>
References: <20260415202027.83008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

In order to ease the conversion of MSA Load/Store runtime
helpers to translated code, expand the TRANS_DF_iv() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_translate.c | 59 ++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 82b149922fa..2e1a769e032 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -164,7 +164,6 @@ static inline bool check_msa_enabled(DisasContext *ctx)
     return true;
 }
 
-typedef void gen_helper_piv(TCGv_ptr, TCGv_i32, TCGv);
 typedef void gen_helper_pii(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void gen_helper_piii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
@@ -175,9 +174,6 @@ typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     }; \
     TRANS(NAME, trans_func, NAME##_tab[a->df])
 
-#define TRANS_DF_iv(NAME, trans_func, gen_func) \
-    TRANS_DF_x(iv, NAME, trans_func, gen_func)
-
 #define TRANS_DF_ii(NAME, trans_func, gen_func) \
     TRANS_DF_x(ii, NAME, trans_func, gen_func)
 
@@ -758,25 +754,64 @@ TRANS(FTINT_U,  trans_msa_2rf, gen_helper_msa_ftint_u_df);
 TRANS(FFINT_S,  trans_msa_2rf, gen_helper_msa_ffint_s_df);
 TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
-static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
-                           gen_helper_piv *gen_msa_ldst)
+static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
-    TCGv taddr;
+    TCGv_i32 wd;
+    TCGv_va addr;
 
     if (!check_msa_enabled(ctx)) {
         return true;
     }
 
-    taddr = tcg_temp_new();
+    addr = tcgv_va_temp_new();
+    gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
 
-    gen_base_offset_addr(ctx, taddr, a->ws, a->sa << a->df);
-    gen_msa_ldst(tcg_env, tcg_constant_i32(a->wd), taddr);
+    wd = tcg_constant_i32(a->wd);
+
+    if (is_load) {
+        switch (a->df) {
+        case 0:
+            gen_helper_msa_ld_b(tcg_env, wd, addr);
+            return true;
+        case 1:
+            gen_helper_msa_ld_h(tcg_env, wd, addr);
+            return true;
+        case 2:
+            gen_helper_msa_ld_w(tcg_env, wd, addr);
+            return true;
+        case 3:
+            gen_helper_msa_ld_d(tcg_env, wd, addr);
+            return true;
+        }
+    } else {
+        switch (a->df) {
+        case 0:
+            gen_helper_msa_st_b(tcg_env, wd, addr);
+            return true;
+        case 1:
+            gen_helper_msa_st_h(tcg_env, wd, addr);
+            return true;
+        case 2:
+            gen_helper_msa_st_w(tcg_env, wd, addr);
+            return true;
+        case 3:
+            gen_helper_msa_st_d(tcg_env, wd, addr);
+            return true;
+        }
+    }
 
     return true;
 }
 
-TRANS_DF_iv(LD, trans_msa_ldst, gen_helper_msa_ld);
-TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
+static bool trans_LD(DisasContext *ctx, arg_msa_i *a)
+{
+    return trans_msa_ldst(ctx, a, true);
+}
+
+static bool trans_ST(DisasContext *ctx, arg_msa_i *a)
+{
+    return trans_msa_ldst(ctx, a, false);
+}
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-- 
2.53.0


