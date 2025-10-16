Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F15CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MxI-0003lK-CO; Thu, 16 Oct 2025 08:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwz-0003Zw-Hg
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwp-0008Ul-CI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso5145475e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617143; x=1761221943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=syTPR0/Kz5lkOalM4REifuIGfeKNGtxsVgoRSrbPq1M=;
 b=RpzceeoH0EThpKzaynwqUaRdgLY0KxST9AKZgfuzD41ouRsnQsr+n5B/EkgD/DpX65
 iYwfC255j005imtv3e/mCMzdPQt15+tkZ3uKwQTiUixF9+oeKUC2gYGsBxOyAgnNtWGR
 F1H+1q5IfCLmXzGd3TV6FHsSHgZQxEuEHyfH9V/s+OwNHdfg7T2/i37c1Ee/kXKAlGNA
 l6GAPITXaDu8HuU1H+woujHBj/8pQwCycvx99E5nnzmLqDeqODFsGaivbJEAY3CqBT5E
 SfnlSKpTZrvGOZH95Fs8zDmw8bXL/PG2mYaqSQ0wHtZeMMlpdC/QvW7Pqje2vWqGqA3O
 jstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617143; x=1761221943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syTPR0/Kz5lkOalM4REifuIGfeKNGtxsVgoRSrbPq1M=;
 b=ArP7qwmCUkRZRUgzFWX2eOxwZELeRwl3oD3AD25tQ6C8BDVz8DzSExhqUkFDx6ZCCS
 R8x6rTKj47GblHyrUHAFsLrWtkGgYiz0Z/v2Qu1ZYEgu0GzlJHrIIYwB7iv6z8m83ca+
 IcUFwWfjSJ1NyGQuB0ZpzAEYAcAO2sdsFZUYjky5dCf+QncaONFS057jnQrJy2e1n/CC
 /n6aQFsLPLn1Gqwn02wBb4x4D92mxfb55Xz0a358FdKp3m+wSzRqbUbM5oD2Sz+H0Iwk
 4u1fHynGeZbNY/qjs8VpK8HtrqGkyNkpJdzrNxWAvJ64QepBlq5Ttx4TPHW9rrRiL9CX
 s8vA==
X-Gm-Message-State: AOJu0YwmD2f/l2y6nmANUZc5Bz3C2O7gOV2pgj49I6CRN67IITZQ3uxD
 fCeaxnZMcXJe9lsijLjs0vSp1RKv6fx5R0HwR0r7nHBWVJnWr9kVM0UA03GVJ3q93TNTfNab0nx
 LzDNRFBo=
X-Gm-Gg: ASbGncv07d7wdynmVQ+csxqxClelzg9hMPEeeCqjSg3GYceBwz9cBT1e18wDRyBOWdT
 4EjrOULroMRI9+57Fp0g9ixMJZkucmjChWpPLg3nUWNX2gRq6Lvi2qA6viRJwC5bjonz0yUoS93
 5FNVA4nrD+b/LdL5CUNqQQUBE7doGAgypH11cYmtNvcDB7Qk3ussRNQl6mBI7Ady9l2O+oTdJ9c
 rXPXUATNf2nOBYW+TmSZjPR7yVV/QccUsjuTSn3CEu29pnVqMgvJINVi+TM/nFhNZJyyRf11ek5
 z7QQnPWW9zxsXf4JaZewVGnc7s3/lZwNJcnylB4PrCtXKXz0PDmhShQsuiFbP3PxpMSPiuznwvs
 xhTRwYOqjcHJBAXWP53AkerJ9hUpQK6oSKrU8y2RvTAUtVaORw+qOchr6Cl8C/Q73Fb6FJtlxIn
 +c37DumB2a1sHv+p2v7jFu1wt4Tr09QspwftjYEEW419p+WZdZphQZik50ifwvMHzB
X-Google-Smtp-Source: AGHT+IGZ4y4raD+0+oMTgF7rJZFQyhwbBH8e1rmhVTX/zslnyXlARAw0GfDa+RcNqTehk46JCqD1rg==
X-Received: by 2002:a05:600c:4f08:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-46fa9b1062dmr215114455e9.28.1760617143079; 
 Thu, 16 Oct 2025 05:19:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426d0d9050bsm32541857f8f.13.2025.10.16.05.19.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/75] target/rx: Propagate DisasContext to push() / pop()
Date: Thu, 16 Oct 2025 14:15:01 +0200
Message-ID: <20251016121532.14042-46-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009151607.26278-5-philmd@linaro.org>
---
 target/rx/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index b314d94b018..912daaf9fb6 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -414,13 +414,13 @@ static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
     }
 }
 
-static void push(TCGv val)
+static void push(DisasContext *ctx, TCGv val)
 {
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
     rx_gen_st(MO_32, val, cpu_sp);
 }
 
-static void pop(TCGv ret)
+static void pop(DisasContext *ctx, TCGv ret)
 {
     rx_gen_ld(MO_32, ret, cpu_sp);
     tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
@@ -619,7 +619,7 @@ static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
 {
     TCGv val;
     val = tcg_temp_new();
-    pop(val);
+    pop(ctx, val);
     move_to_cr(ctx, val, a->cr);
     return true;
 }
@@ -634,7 +634,7 @@ static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
     }
     r = a->rd;
     while (r <= a->rd2 && r < 16) {
-        pop(cpu_regs[r++]);
+        pop(ctx, cpu_regs[r++]);
     }
     return true;
 }
@@ -670,7 +670,7 @@ static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
     TCGv val;
     val = tcg_temp_new();
     move_from_cr(ctx, val, a->cr, ctx->pc);
-    push(val);
+    push(ctx, val);
     return true;
 }
 
@@ -685,7 +685,7 @@ static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
     }
     r = a->rs2;
     while (r >= a->rs && r >= 0) {
-        push(cpu_regs[r--]);
+        push(ctx, cpu_regs[r--]);
     }
     return true;
 }
@@ -772,7 +772,7 @@ static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 static bool trans_RTSD_i(DisasContext *ctx, arg_RTSD_i *a)
 {
     tcg_gen_addi_i32(cpu_sp, cpu_sp, a->imm  << 2);
-    pop(cpu_pc);
+    pop(ctx, cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -792,9 +792,9 @@ static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
     tcg_gen_addi_i32(cpu_sp, cpu_sp, adj << 2);
     dst = a->rd;
     while (dst <= a->rd2 && dst < 16) {
-        pop(cpu_regs[dst++]);
+        pop(ctx, cpu_regs[dst++]);
     }
-    pop(cpu_pc);
+    pop(ctx, cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -1585,7 +1585,7 @@ static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
 static inline void rx_save_pc(DisasContext *ctx)
 {
     TCGv pc = tcg_constant_i32(ctx->base.pc_next);
-    push(pc);
+    push(ctx, pc);
 }
 
 /* jmp rs */
@@ -1626,7 +1626,7 @@ static bool trans_BSR_l(DisasContext *ctx, arg_BSR_l *a)
 /* rts */
 static bool trans_RTS(DisasContext *ctx, arg_RTS *a)
 {
-    pop(cpu_pc);
+    pop(ctx, cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -2154,8 +2154,8 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
     TCGv psw;
     if (is_privileged(ctx, 1)) {
         psw = tcg_temp_new();
-        pop(cpu_pc);
-        pop(psw);
+        pop(ctx, cpu_pc);
+        pop(ctx, psw);
         gen_helper_set_psw_rte(tcg_env, psw);
         ctx->base.is_jmp = DISAS_EXIT;
     }
-- 
2.51.0


