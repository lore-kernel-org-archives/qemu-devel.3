Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AFCC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aEe-0001lm-7a; Sat, 12 Sep 2026 22:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aES-00017C-15
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:18 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEQ-0002oS-59
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:15 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469e25187so752385b3a.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267572; x=1789872372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AiLQFq77MDzK2ddq1OVPSh1cWwHnrnhb6cxgtfCkJIY=;
 b=C3UIWruAC7OWGsNdJFZuCkA+723lJJ7IHTvGC739JOmetWGz3TdWLr3o8Hr5cZkljK
 9bN0F3uVacETkgzhn1OStF7PepbMQlpISD9JyE17dsh4/9e3W8aPlOuLI3yiAxS+6cNQ
 1CVmvrRKsV2L/LpxszhVD0KXZm573g3vZHyCLvoe2hU0jTG8QnhLBVz2mvBqKwZ02ZoN
 4B2MseVTPFItzT6Thd2wiy6JEOOCsqca9GFl4IojPGPMVLvXbHWcCdGKbRZLbm8UGTEh
 7BMiDU+6EKCVRTGcsvJ2eVw0jlRwWeUvezPdeWhcXWY56ebr1nnq/LjelvkzSerMlu9b
 YEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267572; x=1789872372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AiLQFq77MDzK2ddq1OVPSh1cWwHnrnhb6cxgtfCkJIY=;
 b=B5X76Cplxvn9135s0866puhp3HL9ypG2JtUL0heNxzR02JlR6GleBwH/NrBSlNHZBu
 mzzLa7eomo4ShFWeKFXtGvrewVA4Dvl2i9PcnVJAss2kVFmiQjMr1dGX/XVn499oF71M
 8NUIXlWnV5CRib7Rpgeur06jDe4oilwb1gsszpc1fGQPy4A2TGazvT9i0h6v6dJ+olR1
 g3CD2Pr3Aoafj0PjzESyoKEMrtGSd0PlaroTjX/Yn5orF6MQoLjyzyn522IwHJrqMRpe
 X4QnZDo4+Vu9Mf9tVAyP3DAf0Hh82goh7N8TrreVNqUZb6OVr4ZBKc3+8HSmWXP2YfWm
 v1nQ==
X-Gm-Message-State: AFuF++mCF1b+xQ8uGnhSvOckpepVVPL6sEr7VcyLmkTpERCTekc8nHrO
 XGLAS34+H9hoP3tsZ7j8n4Tit7r1uFBL8ZJ67ZbYSJdl4Nw+mDht/UgjVAOSTZ2jxoc4lcVPxnR
 JbnhgzM0=
X-Gm-Gg: AYBFou2PHvYn6MGGNWuEWb4Cd2djXq6Ufhea0kosUv4HuI/sDMgnZIRxXuT0m1h75wb
 N+34UQ+3jwanr2WOg+RhrgGRvBYkMnBywS5069F4XlCwET8o8+/gdaXtRnFyXCe+DYM/kz097tn
 uBToavMDAM+JSUFRGhoBSpDuWUiQOnBz87uo/JQcDv4RkZnuE/O2Sv7AtscYAjddikppGOglS7U
 7hGBrF5KvJ5XEbTbcNwSsLaaMCEQh4coOiJjA6pT3Eb1W3IDbuYJsTg19xzMkUlUdO9eVA3m/hN
 Mx+KepELC8UIooRoHJjycPrvUvVlRK4S0EBbKgvF/wV9POQsBsoEqQd7n9+vbWAmGvHMNg9SuHQ
 3jaHl28CeKPIF+ero/OvXnoBc/1ap++fffY0XZBnbF9nIy84KRf9x6Dqc0kS47XxlEYDB2pJkLN
 cSR23KadvJFjiWKJXgRglaPIAULfoB10s+Pd+Cji/mmBgh6gHClo/jPz+oNCpc4nxIA6dUmYj1G
 e3Qn7LuBoMFcowRODc=
X-Received: by 2002:a05:6a21:b82:b0:3d0:cc29:ff63 with SMTP id
 adf61e73a8af0-3daed342f1cmr20219289637.12.1789267572434; 
 Sat, 12 Sep 2026 19:46:12 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm17811679eec.31.2026.09.12.19.46.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:46:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 85/86] tcg: Generic expansion of tcg_gen_revbit8_*
Date: Sat, 12 Sep 2026 16:38:36 -1000
Message-ID: <20260913023837.741866-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 51 +++++++++++++-----------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c36ad34b0d2..1829fd3a0d6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,7 +135,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -161,7 +160,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 28cfa68db3e..13aa8e15e42 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -48,6 +48,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF2(revbit8, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1882c0b5f3c..e5b3ca1bfe0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -179,11 +179,6 @@ static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
     return tcg_gen_op1(opc, type, a1);
 }
 
-static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
-{
-    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
-}
-
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
@@ -1175,6 +1170,24 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_revbit8(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    static const TCGOpcode revw[2] = { INDEX_op_revbit32, INDEX_op_revbit64 };
+    static const TCGOpcode bswapw[2] = { INDEX_op_bswap32, INDEX_op_bswap64 };
+
+    if (tcg_op_supported(INDEX_op_revbit8, type, 0)) {
+        gen_op_tt(INDEX_op_revbit8, type, dst, src);
+    } else if (tcg_op_supported(revw[type], type, 0) &&
+               tcg_op_supported(bswapw[type], type, 0)) {
+        gen_op_tt(revw[type], type, dst, src);
+        gen_op_tti(bswapw[type], type, dst, dst, 0);
+    } else {
+        gen_bitswap(type, dst, src, 0x5555555555555555ull);
+        gen_bitswap(type, dst, dst, 0x3333333333333333ull);
+        gen_bitswap(type, dst, dst, 0x0f0f0f0f0f0f0f0full);
+    }
+}
+
 static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
@@ -1510,20 +1523,6 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit32, ret, arg);
-        tcg_gen_bswap32_i32(ret, ret);
-    } else {
-        gen_bitswap_i32(ret, arg, 0x55555555u);
-        gen_bitswap_i32(ret, ret, 0x33333333u);
-        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
-    }
-}
-
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
@@ -1744,20 +1743,6 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
     }
 }
 
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
-        tcg_gen_bswap64_i64(ret, ret);
-    } else {
-        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
-    }
-}
-
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-- 
2.53.0


