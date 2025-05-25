Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474BCC5B541
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoW-0002B9-Pf; Sun, 25 May 2025 12:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDoC-0001wY-RJ
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDoA-00038u-Pm
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-44b1ff82597so13672935e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188961; x=1748793761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgSJN1ppHGjsT9JgPnrurYdg7bW60fCBF3+cvS+Ghsc=;
 b=WMChrVLSW4nt2P3nbe4XCzea7fGcrYP6Ohgfi3jrYaPO7e9df5haGS/l9qvhCJnUKg
 MALy4KXK4eTtPv26sMzAFnth7N1aOt0EyNBl8LPEZNdmdsAi5nudoQm2FdyUlfXwWv0L
 TXiasUj75E0AuRnZKEjRoF8qxFNb0dpgFVMFLifKPJnpfHkL4sBGUh6cZEnZ0mAsj57w
 7JFnVRLDcjOH6fCmc24uQZUh13/ENzWqjRHPQiHHue0PCtRamrHhIddSMKP11RJpoJxm
 RV1GEMNCK2FLx5KAZNTJXBmMp8eOuzs1Tm5G3zL9cX6jKWJu153fLWd5633E9WzrSwEw
 V3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188961; x=1748793761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgSJN1ppHGjsT9JgPnrurYdg7bW60fCBF3+cvS+Ghsc=;
 b=JMf8x37jnsdsSGPy/OSKG2Zl0Aps1dkkJRdy0jNs+Zo/6AZgVxOo34VzMq/4EzOW5A
 3O/+//Qmv2xodfrc/LtR3tqxPn8NKbSh79d1JvFANFXYqIAlaYBBfgFsm3R7j/ucziT0
 4BhPYb5OZCoS77h0SIV2RlM6BgGQ7zuSTBXZDZWS6RLTpaS1gyJvaCV7ExbGjSfJjjgv
 Ml/HNlVbwazMryi0G3dDRa4g0V9NVPtnitXcQ5VizJ3Hs2ju6k8xNJINKLAM6Ea/txEf
 yX4GgiNo8sJtadFMLjtRfS2PfQfLrJQaXPlnlV07qzUNnzr7uKBuLBGDYAg+mDzU5E2r
 zl2Q==
X-Gm-Message-State: AOJu0Yy9pI8jig8ntPjmFczPfZ468xzmsE91OiIPSoOE+Mze434Vj3oj
 UDclbftgA6rUqrL79bRHsJCpU26PGq7qbLH+9B2C2liBXPAMMCsJjykzJqfGP6yPosKdfz9ADLK
 40DWO/OY=
X-Gm-Gg: ASbGncu/MjuvLmjdfEq9vYsvD84ltmFfRxs24L8POMCeMsK/eqswJ3EDiLNk6MIh+jt
 CDUV23IiSbi3MbXY6GMEA9lsEdDfjsXT9HlxA4NbgsTUslsKwZMDeuO/4RTijDHpkP91j27DI/F
 OLFVuEu5xXt7MKtH8LfO8/bHk4mlbFiUnYjq9TXTnr1fThMKRBKjHk6aC0P9l9/7YQ8N5m4umAd
 GAyAvNDbh/BVhiQRqZJXfIjgSwWcc+xGoFyi+5Hqefc/SvyBqO8U6f++4ARmxRz2828D1anUCiP
 3V+l5hodTUH8WwVAu+lj6tk8wGVigvrwzAgvkAOeo/rlQHIcgrqFl4oydY+ZH7KSwNY=
X-Google-Smtp-Source: AGHT+IEdaGaZ/8xXQYowS5TQjfRMVy1N4wewhAl196DVyIU9rGR9VA7nBMVwR8+KLMSb4gpOh2X5HA==
X-Received: by 2002:a05:600c:8518:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-44c91cd5123mr59883715e9.14.1748188961024; 
 Sun, 25 May 2025 09:02:41 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 10/10] target/microblaze: Simplify compute_ldst_addr_type{a, b}
Date: Sun, 25 May 2025 17:02:20 +0100
Message-ID: <20250525160220.222154-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Require TCGv_i32 and TCGv be identical, so drop
the extensions.  Return constants when possible
instead of a mov into a temporary.  Return register
inputs unchanged when possible.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 047d97e2c5..5098a1db4d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -606,19 +606,18 @@ DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
 static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
-    TCGv ret = tcg_temp_new();
+    TCGv ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && rb) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_add_i32(tmp, cpu_R[ra], cpu_R[rb]);
-        tcg_gen_extu_i32_tl(ret, tmp);
+        ret = tcg_temp_new_i32();
+        tcg_gen_add_i32(ret, cpu_R[ra], cpu_R[rb]);
     } else if (ra) {
-        tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
+        ret = cpu_R[ra];
     } else if (rb) {
-        tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+        ret = cpu_R[rb];
     } else {
-        tcg_gen_movi_tl(ret, 0);
+        ret = tcg_constant_i32(0);
     }
 
     if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
@@ -629,15 +628,16 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 
 static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
-    TCGv ret = tcg_temp_new();
+    TCGv ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
-    if (ra) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_addi_i32(tmp, cpu_R[ra], imm);
-        tcg_gen_extu_i32_tl(ret, tmp);
+    if (ra && imm) {
+        ret = tcg_temp_new_i32();
+        tcg_gen_addi_i32(ret, cpu_R[ra], imm);
+    } else if (ra) {
+        ret = cpu_R[ra];
     } else {
-        tcg_gen_movi_tl(ret, (uint32_t)imm);
+        ret = tcg_constant_i32(imm);
     }
 
     if (ra == 1 && dc->cfg->stackprot) {
-- 
2.43.0


