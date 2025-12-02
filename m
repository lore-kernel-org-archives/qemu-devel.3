Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B89D1266B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQWTQ-0005bc-1B; Tue, 02 Dec 2025 14:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQWTO-0005Zo-SL
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:55:42 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQWTN-0008TK-7u
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:55:42 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3669ca3dso2631893f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 11:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764705339; x=1765310139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxc/QIJQZ6T/2cx2wh2nq/a8IHvHh76nxiM/CVeu2Hs=;
 b=otaNL9S4CmV/CXyYZqG9E1e+3QpiAUyJ2ppf1INfeTG5nRdavm62gj0ckiF9LbAGfE
 ydZB6NWpuRm4YqUIUsQNioBhQOm1LK+23Tz6g9hof3INSBD714hthLss5P4CaCD8h6nU
 Eygi7/piqNaNxpX4aUTLKNcy+4VIR1SjZSaghW9R23q5CpA1FJTB2YjnKqCXqRJwA8EQ
 7PpWhZr8yrpAmEsbv+sbYC7j/ldfsNMnRaP7NJr+7ov5Fo/6OltuyH+ex4Bb2cCo6qyg
 ijx0XW7xgCnGDtZo+4IgCr1HP+Uet9rHgUqglOOnIA4Ccol/ymWv3ZF5i06v94+p+vl2
 cVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705339; x=1765310139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hxc/QIJQZ6T/2cx2wh2nq/a8IHvHh76nxiM/CVeu2Hs=;
 b=U1STYpkus2QEPhgWxxL6DFSMXJOsOxb6VdF70krNmBTII3PMyQh3H0AEtkWjtD6pa/
 lWgPD8HmbwboYe+arUYb3SMcj20cSbUmVp6OQkzM3ZtXZCIiQSuPWRT7XYhimwupiCWR
 XczFc7aN0/P3wXCPytGUyRnOk0BzIF19WQljahC2vWaY6XGYwD4fWN8pG2FK+xokO9tr
 xpJtATm6590c6qSyXHr8/blmdDXnxlfFKmwlJelYgwkAmdrABbOfwG3g1Lb16KHwZEKS
 oDgPCYbaApkjp/en3YP9dGblg1wI9J0YxMxscL2WMQ3JKAlKOYr484n5O3xKL1TJ+F3n
 /Wjg==
X-Gm-Message-State: AOJu0YwU6p23hC3H3Z2TdhU4lb+5aZ55Esbwq3sUf3o5vjKvTcjJM/aB
 4HmfNGdkPxgGK3avygbQd96wxOZbtielSEHSUSE7uj4Z66Fn79B+RTcocgnIMkFogigqiLFa8ZX
 Ep1w+BtY=
X-Gm-Gg: ASbGnctWnfqM/yHP4ym2djdZdgxmwRVcDIwLIHOnNSQzDIDdrYdG3PeaHjR76KBWGll
 vS5/FiOdEiSZducC/AbcH8tUeSWUXbX/G5XtECYouFselW588aEuYk4KwImPY6Xro5tKKHvW+jJ
 KA6nggRaRtsm6ZBeR8GkOztitdVjc+C2LKwQ+4Z6l6XJslGuz1kDmQP+NTcXNHb9wXPvq/tzUV/
 Fex8oeb+b8uJcr5XI5iqKhaG9qhkNBBHciisLIVClHiUdveXM6qQijcZiUfwmqnb4Oukg/npfQ3
 Vqi8Tr5BpDDJ3nTJoYOIxoxRC0SuacUSaNXpA9yrKsPBaTLxg4hWKXe2NDd9Z2em7cMPRxHmHS+
 q1EPa67uxO/8fBLulb34IMgfnEVkmuGX7StI+S6WxP2QbnHIWCuK6P1zjWMEiZLSCACfApvv1oK
 b4IkUX1d3J921aJFj+kWkpcrF4Q4a4iYOGw3L9/aqTPVM1BfaoqZCyhRZR3Cxd
X-Google-Smtp-Source: AGHT+IHH81EOL1Fm9xPA6JuVCekNzZwRcLsVl4deBvrzIvygwEgrTEf02vtUNDWWDlfisxTBmCS30Q==
X-Received: by 2002:a5d:5d84:0:b0:429:8b01:c08d with SMTP id
 ffacd0b85a97d-42f72235366mr398460f8f.41.1764705339029; 
 Tue, 02 Dec 2025 11:55:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca40945sm35613569f8f.30.2025.12.02.11.55.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 11:55:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1.5/2] tcg: Move maybe_{extend, free}_addr64() functions around
Date: Tue,  2 Dec 2025 20:55:37 +0100
Message-ID: <20251202195537.35508-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202011228.503007-1-richard.henderson@linaro.org>
References: <20251202011228.503007-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In order to make the next commit slightly easier to review,
move maybe_extend_addr64() and maybe_free_addr64() around.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251202011228.503007-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op-ldst.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 67c15fd4d0d..50bb6853f6c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -135,6 +135,16 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
+{
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
+        return a64;
+    }
+    return temp_tcgv_i64(addr);
+}
+
 /* Only required for loads, where value might overlap addr. */
 static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
 {
@@ -153,6 +163,13 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
     return NULL;
 }
 
+static void maybe_free_addr64(TCGv_i64 a64)
+{
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        tcg_temp_free_i64(a64);
+    }
+}
+
 #ifdef CONFIG_PLUGIN
 static void
 plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
@@ -508,23 +525,6 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     ret[1] = mop_2;
 }
 
-static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
-{
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
-        return a64;
-    }
-    return temp_tcgv_i64(addr);
-}
-
-static void maybe_free_addr64(TCGv_i64 a64)
-{
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        tcg_temp_free_i64(a64);
-    }
-}
-
 static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                                      TCGArg idx, MemOp memop)
 {
-- 
2.51.0


