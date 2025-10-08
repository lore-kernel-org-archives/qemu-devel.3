Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF69CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEq-0002PK-Vy; Wed, 08 Oct 2025 18:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDH-0001Ks-54
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCW-0007Oe-Vm
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:46 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so271550b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960792; x=1760565592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7Mihnevvi2zwV4aea8YsxDOm/2e8epQtaNRT/1I7W8=;
 b=fqxbih3WKEFmlEU7oXLFS1LB0hI+7LPDEzroTQRemzBRcP+3vOgB/+M1grVtM9sX9k
 XtIAPcgrcjTDY/OKvfbc1KFpJqiYwjKO1laeYMWU/uiO8sVUP+/SI41FFQAOZzo2E3C3
 o/QqKgVjT1+Zrf0rZDALGFffh3GJbl1hpkzQTFNm9GNzMAfHIdu1r//RUbj2Q7RgONLd
 cONaiN+zqrGNRnut5wXBb2e/ZX47ogDSlVx9sUnBIWQfcFbVQJVDcUBZhrre/VqK13XN
 KyHL6dUcjmMNc/7PJShScSatrkMOVVdsnTsfhfVaRD0La9cNoNQjKT/tvI/FhPd1/q+m
 MPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960792; x=1760565592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7Mihnevvi2zwV4aea8YsxDOm/2e8epQtaNRT/1I7W8=;
 b=gB9nSx9oeONgZG+6lPFc7Xe3L+Q2evnXxtfFvC58R9nOEWvfKEjsbK+YpERm39fbw4
 wxpSoZ0zeJLZrMZnTRoyiIX7YQDuvHVdixy/T0cjxFIoVJxKdXFGjRskTHi7h5ihZw5x
 7zaNwzPNLsLI+sYvr4z3nKNpvc9VqS9UAIt60qZEI9lhFoHnt9UUhXi53EqhDeXwNoQ9
 4dAuA3oNPIWdUX5jA4q4qY/T/kQSFWvtBY/tLCop0K0uZ8hmBYMfs1penPP6Oj1Cdytr
 Rf+tNIgLo3RsQwfsVgmqEDsrvFKPZX2belsHjPttYVG534ohG2ZO3sjuGH1xt8yXtmWD
 VBqQ==
X-Gm-Message-State: AOJu0YzEb4bauWDNYKOvOKGGf7xR/Wz8N6n3DTRayn+tB1ishryxW20Z
 RRjqRJ/963HH1vqUEC4hTe0irLqkNp5/9wKl7dpl5+vwFi50i38hxVZrI7sxfESY3QRzSW6NoyR
 CfcIXfgU=
X-Gm-Gg: ASbGncsM5hXyDZx2hbFZ6DZFHAYy0Mciz1qVS6vgiO22Br1WvXpliiJuOB4gLqDSjU6
 dZvxoIIrG0WWXbTl2O9okxtkFxe3eFb+WOfM72zOBfgRvsLDCgW6YW3SaZfFJzzIaTO3jgyDX7h
 Mkj1GF1l2xL1iHaBXOK7UB1deLBXBjRX4CN5C3HqMCIC176zkELam6bmHrfkGA0+C0k8znZ/kI1
 uLdu0rPZnS2valsxyD+TrmcCc5B9+2rYlcKg36v9gh/u03pLA8XXIx3x2zAFZ3eyXblZ0Qv9E41
 hbEl/aw7ZfUNyTdyLVTiZAdJkaacJJq/s5Ky+Z43VQQIqRai659Nq+BDzdOaz81PoqAuop1ujmO
 vmlq6bwzpFLYhzJfAzocQjkaI6XwrJHbsd7FfSFqOIUfSqSIo+X90BTzE
X-Google-Smtp-Source: AGHT+IERGU4TKTt/9qkmaCpyW8+IubaqX/vkWFUmaTk6yHXMmkRYkjFsLQwBiz4ccUD1/KoJW9KEiw==
X-Received: by 2002:a05:6a00:3e08:b0:781:1f28:eadd with SMTP id
 d2e1a72fcca58-7938763716amr4832906b3a.20.1759960791851; 
 Wed, 08 Oct 2025 14:59:51 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 57/73] target/arm: Add gcs record for BLR with PAuth
Date: Wed,  8 Oct 2025 14:55:57 -0700
Message-ID: <20251008215613.300150-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fcfa4223f5..9c3de0cf71 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1842,21 +1842,21 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
 
 static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
-
     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
     gen_a64_set_pc(s, dst);
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
@@ -1892,20 +1892,21 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
 
 static bool trans_BLRA(DisasContext *s, arg_bra *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
     dst = auth_branch_target(s, cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
     gen_a64_set_pc(s, dst);
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
-- 
2.43.0


