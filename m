Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E33C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a89-0001I4-Cz; Sat, 12 Sep 2026 22:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7l-0008Ue-L0
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7h-00014q-Js
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-869ac301739so1772887b3a.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267154; x=1789871954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PfWbCQHog8E2UxB+RqyjqW5zkkakdFPPRBjp2Hu8Z58=;
 b=qE/pa0cYKoBbuPMK77eK4Y25lI9KiBUXnhKaveqW76UArZU/IGuMD4y3uTxpzPbpuj
 8f1wLHVR6gXfxVX1KSyEwsFBTS3hmBTxYbJYWuLWUB6JwlJ+avz/HG5KtwuuMWlmrvfO
 u3bhEi/8bLoBgUa/UMvrH47xY0nQWoWHH4w1nqegIcejOFtchI2vdDVVd2A3fQ96fgQu
 2sBrQV/XYHo9F72rpDQt30sfrw7vlGGS37WWp1lVezRcwDMHhjvOSr7qZup0/CdTaq0T
 wAxiAu5o/kkxzgX/I12wNAB9LQAysztc/q/xCcCS7Oi/zoR0KXvn447Jughg/cCYF6l+
 42Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267154; x=1789871954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PfWbCQHog8E2UxB+RqyjqW5zkkakdFPPRBjp2Hu8Z58=;
 b=mWXo2+nvuBz4DD1czATljZxCNMGNBJPXWbV0dpCGo01sMlU2LEkGszgZJvgim1bbNN
 J0KUSVLXT1pg2YYgmIOPtDGXE/d2ZVLfTvRAVpjhcauQ5yLXw2yr/umqZZ+wFIBFP9+3
 AlYoty1jRyHhnJhMlhUdK+dA3tnbfaUF3VT8XDl9nkTMATP4Z9KELOkXD9FeXGNIH6Fi
 Rc3AdDtywUl9ged7S9DMPRwL3cebO3UW9jc364WKZy01k4bvsWmyhpgggV64jI3OyK1o
 gjKZNgGfJ5CrnDkmCMmoD5zx9YcetJcbEpAXEmP7liXVlT0MfKE68xs8cMdM1gvWjKiG
 GHgw==
X-Gm-Message-State: AFuF++mv2U/q/Wfq0hdPNyD7+WL144CjtzvKZMQ3LA3bkp2nVgA18Ieu
 9LdgvvCV+QlrqrishQ60jr8Y7nylBpp96KsNX8ueoXH67XISt1Vtd9KIturxjEC/QgnQSs8SZUB
 MAj4o6A0=
X-Gm-Gg: AYBFou0ZbyEceiKAILqHRnx8AhB6ilGbxIShMGguue9oDRI8zOv5r5yMrpOFkAB8fZ2
 gV6binOuzEZJ28FeuCtKWmsFpmipwf1RvbhX5LM+fzBRs3oNTvzEtQUl7T6BZ/5rvgWugwN2vRB
 Id/tObPHKDH8HmpGfkNYxc7VmAGCEno7RS9aWd98IsWOxIDWZP4jwXK6bFbHjNJjshz47PE5AEJ
 cEnY3xaeNk9TVDEmX9TkH/JqLaoaB4OUfcuJfhQAyX5msk+/kmtERk3kx8OA2IPROhBJ+TKfOZG
 x888gB4ZReHGqJMPfGQ9RRXjTfDYNpJ7pq0cnec3GlGCizZnz855GO7ZTSvWgV638zcp+XHmnyw
 ZkgT96uNmZxqgbLZe51QgjAUE5CSkd+tSCFEnKGsCNRIo1ZhNu1TrA5+EzPlq2wJG3MQMasd13s
 FQ/IuWOf50EHMMn7883M/dy6Q2/a+RHUjUjwfMLVR4rf6zlH5y7WHnKSMnyO0Hpoc9YgR6RBCod
 XZvbGg=
X-Received: by 2002:a05:6a21:3293:b0:3d0:c5c0:d9b3 with SMTP id
 adf61e73a8af0-3daed3438b8mr20578198637.18.1789267154491; 
 Sat, 12 Sep 2026 19:39:14 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/86] tcg: Generic expansion of tcg_gen_divu_*
Date: Sat, 12 Sep 2026 16:37:41 -1000
Message-ID: <20260913023837.741866-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 tcg/tcg-op.c                 | 43 +++++++++++++-----------------------
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c1f9b3fd37c..c2cff4419aa 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 67261d12741..e67f11176d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
+DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9f5ccecdde0..8e7f92d5251 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -475,6 +475,21 @@ static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+
+        gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1, zero, src2);
+        tcg_temp_free_internal(tmp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -695,20 +710,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1589,20 +1590,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


