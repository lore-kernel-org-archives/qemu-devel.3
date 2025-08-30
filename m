Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20204CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOEI-0007yg-Sb; Sat, 30 Aug 2025 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERL-0007Rc-1O
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERI-00050Y-EC
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24a1274cfb1so1044035ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532866; x=1757137666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4O/Df2srkFicGVgbJE0q2IGU0RhnxZd3TgyrSwbJEQ=;
 b=BkLT+vqY0tgK+aQTy7oPXBpq7hlbBGCEPLIoz1VZCgaQbxUNGWGP3q98D4p+4C4xCI
 pw26pl/yRw0Yr8XJnoFTpWjPcYim22oQisogd9fhOtZ+SV3OqB24XNDuZSKylp3jVUaO
 /p/Hw31xyNK2A5UJuU6pd2b3QrEB2GATtM7jlwv8Pm+ybPrBFSnbLw3cbClV8W9EaZKK
 jsXd9Q+ybmVQPAPVU3qU4io8UPMs074MJbEP6vKVVQ97tEo+FD1JGWWKCmsaiN9YY/yf
 +KoNkz/535pMugaWDHq8nobFiUboGk7Q8sk2RXXxUNxA0xm7eSYNrbWOUWX1gQrJit3m
 C5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532866; x=1757137666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4O/Df2srkFicGVgbJE0q2IGU0RhnxZd3TgyrSwbJEQ=;
 b=P++qNTYhGMd+4fFEzS6ZNYql2789Biv8Dgv0OR+GDZlVBaW6r9/DPogMuueKbULpku
 +KTsy3hdeaDbUj9Fo52MF1+yu0IoRuMr7TPVQPXXant6/PbnXrKc1I0iImlrNYYluY8E
 AobqRXPVCPtUVeYe8R2sTTL78sN/hW8H3KHSuUJ3eRkLwt9n/j39z7aVwxNFC8phF5D4
 XePlLewihFBDJHsgKJMl+zVwKVodtKkGXEeoTyze0lS0EXy0yvJ89aWBajVJlN2I6d3K
 jErHKO5RaKB7xQ9RRXuNPfbnQrSKyoZhh3NtiBPdip4niiR/5lQU7zxM3jftnv+5btj4
 rcHg==
X-Gm-Message-State: AOJu0YxuvKIIqiXqE4QlNi3aRNy0UprN7Dyelcs52tVrXL/QENE9ZoQ9
 AEfXMAV1qSTgpEBUw6pLl9cDA1XuAFCXrtahF63YmLwQq1w9l39cphlO2Ajo3ddC2zKjMF8C4yo
 CEtF2anY=
X-Gm-Gg: ASbGnctGLhTZZ7jeFD+M4gMD4lY7NtPSxdKA4MoXdPT8p3oLWqt0PpKpHB8YDnFvTgH
 PrHsd0UrEAOk/DrmIVFCwULQBe73f9TwS4+fEbp5Hji0ONPc8ZAHvWlAvzKRZM7qh/fSV0Bpi3v
 4lYsUY4P64LEnjrojddy20EpjkDocrjGYMznu/Rclc6phazD39gf0CEV/WXxHDrVx69wBCjUbVX
 YTxODPyxAYAeXUZ3ivRlg+u6ln4SM4gvehbWC3S3ifMiqaUCahIXayVj1XZZqlDqLPYsPaE0gUb
 gNOjqt8qNaEA/mxhi0USZcDTyrME7rXbtodVi7rr6rLDkOwAv7I4oKYi1c43sMG3dffANO91zwk
 9p03IYnyTIfxp1/KYRxiCfTbCjTPFb+8clESN78//qyEPCfUJ4B2WvpIyI9QkqCNYW6BxNzvQPw
 ==
X-Google-Smtp-Source: AGHT+IFJZpoTfVL6XI+7vU2svDG0Jxszv7OKocelo7eoWUskVZk8lUoI8G8OGPJYcoNBfRsWHF5Wgw==
X-Received: by 2002:a17:903:2347:b0:24a:8e36:420a with SMTP id
 d9443c01a7336-24a8e364377mr5600575ad.40.1756532866418; 
 Fri, 29 Aug 2025 22:47:46 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 68/84] target/arm: Add gcs record for BLR with PAuth
Date: Sat, 30 Aug 2025 15:41:12 +1000
Message-ID: <20250830054128.448363-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8230ac0fab..20e18687d5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1842,20 +1842,20 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
 
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
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     gen_a64_set_pc(s, dst);
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
@@ -1892,19 +1892,20 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
 
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
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     gen_a64_set_pc(s, dst);
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
-- 
2.43.0


