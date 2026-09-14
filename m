Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DEFC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FnX-00037O-Ak; Mon, 14 Sep 2026 19:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnS-000360-Fp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:11 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnQ-0007ES-F8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:10 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso18873285ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427347; x=1790032147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vz5IhXQY4HXbtjm/BrrnYBJwNr5j83FMlfFsJ2A7Oto=;
 b=bCI16sldMEVcJJLTuwHU7F8pQLztsW8iBX7gL6dfiBcLIEV7EtCT/4jIDpqRBKy/8j
 LR3qFzHpLtQTZ6o5hZkRbrd6GB2cFYcDKaLigQrSR5yOpOBAHt5gQTxtZmOqZxR/u5NE
 HSKH+lBMXj7yB8Xefxap5lxBjyeFXaddB7228+00DgTC4A4BqiobL5S4R19qb5bHvJu2
 w65Pyqn7JHsX9HhCf4i40savvHq02xpCNfhmqVN5s0Q1pK64GKsxRUhct6UUPOBJJELQ
 8Tf23GpwpY7WrK/ATRg1EnOY/WMOwtNoW9RmwVpk29Wl7uYQ+mplbL3FjLpyxYu8JesX
 GULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427347; x=1790032147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vz5IhXQY4HXbtjm/BrrnYBJwNr5j83FMlfFsJ2A7Oto=;
 b=yh8WBUUgbEMrzNAw+vJhTK+BFOklYLUzc0CRu7a53SR2osINfEKtj49DhW6ovphnyx
 6xelVKXefoI6ZYCAn2Go4NPSypp7cu6NdpHgg6vlYPaX+XCEumie+iciQ97Mio5D84ze
 lLc8q04FkNbEpIPqCuC88Hdt16qQapocT4yM1Y2M0KUMAaF6DasvmY6mkGw7xW2p15LJ
 zemJrL6qu/ijtBai0DcbDRl+Ot7gmpCbHKKNkSXARYZV99Ts/ljWUGsW/hyiKEP7pcoH
 AsZnvgqEmPXwnA7nY+HAaSDYaxxi9tM4pdV2PuesksxRzd8kmFJGS4qPoeJXy295U43t
 TnVg==
X-Gm-Message-State: AFuF++mjpxblyyA81rYXghLUtiIWbTwHOakChMdfcwcwGWOaes5pvGKg
 D81+WIT1w3Ng8ZwzC8xu3N4qDnvk2tQ7j+eREWbEQTwNas4ut6fQ3ZWVKIGK4OAvwj2UKMih2Tu
 dIOjIQ18=
X-Gm-Gg: AYBFou0ZNS3ueM2HhbLPJzuNs7SFC3Zv2NKNwfOq/iRYtxHZ2Cd8Lw9kn/L4F1UAv8D
 VVl1Vm73ZIZi4frQ5zKNyJSr0pbUCzOnanE1KJNNiDy/TXw5QC3vlDrZ+JeRTcnfFth3Jqcndnh
 qOkWEgoYAaGPTANwo5SA0+9FMGPvOfx0W8QQpASTzk/VYBkXRI3UDy49P79y9ALKS39h83PUqGS
 as831U1Z+zlwpX/k4oN74lPHE5tqRlk6XSmZvgWFB3SlOfxuC6JyZ/gNx+Sk3h0FH5Rm58bSABW
 4GfwKQ6KoZm1bm9GATQ3ll3TN0IHAwwOVW0gZIz8JVhW2oG8+dgBoe90gS60En68HQRcEaWBtEY
 680ImsCPkRv4bxgBEcWyDTz3XesYclNXrSMpwIE4h8/09VlqYWgpGK88X8ej/neIw4e7nXeZDIO
 w67QaH8hP3Qwqp3J+hS8RncaBbCZRZiXJo7OSiP8FM9wDSrNX8wmEB9BGsMtmuxh2g4ck2zGRWB
 NihJEs=
X-Received: by 2002:a17:902:d4c5:b0:2d8:d4d3:3fc0 with SMTP id
 d9443c01a7336-2dd6c7d8c87mr96008145ad.20.1789427346672; 
 Mon, 14 Sep 2026 16:09:06 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 3/6] target/mips/tcg: Split out gen_mxu_logic
Date: Mon, 14 Sep 2026 13:08:55 -1000
Message-ID: <20260914230901.1781309-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230901.1781309-1-richard.henderson@linaro.org>
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Split out a helper for common expansion of a 3-operand insns.
Drop all the special cases for 0 and let the optimizer handle them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 122 +++++++-------------------------
 1 file changed, 24 insertions(+), 98 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f30883f976f..3f8acfcdb8f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1685,14 +1685,11 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
  *               S32NOR    S32AND    S32OR    S32XOR
  */
 
-/*
- *  S32NOR XRa, XRb, XRc
- *    Update XRa with the result of logical bitwise 'nor' operation
- *    applied to the content of XRb and XRc.
- */
-static void gen_mxu_S32NOR(DisasContext *ctx)
+static void gen_mxu_logic(DisasContext *ctx,
+                          void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     uint32_t pad, XRc, XRb, XRa;
+    TCGv_i32 t0, t1;
 
     pad = extract32(ctx->opcode, 21, 5);
     XRc = extract32(ctx->opcode, 14, 4);
@@ -1701,24 +1698,25 @@ static void gen_mxu_S32NOR(DisasContext *ctx)
 
     if (unlikely(pad != 0)) {
         /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 1s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0xFFFFFFFF);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the negation of XRc */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRa zero register -> just set destination to the negation of XRb */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to the negation of XRb */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_nor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+        return;
     }
+
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+    gen(t0, t0, t1);
+    gen_store_mxu_gpr(t0, XRa);
+}
+
+/*
+ *  S32NOR XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'nor' operation
+ *    applied to the content of XRb and XRc.
+ */
+static void gen_mxu_S32NOR(DisasContext *ctx)
+{
+    gen_mxu_logic(ctx, tcg_gen_nor_i32);
 }
 
 /*
@@ -1728,27 +1726,7 @@ static void gen_mxu_S32NOR(DisasContext *ctx)
  */
 static void gen_mxu_S32AND(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) || (XRc == 0))) {
-        /* one of operands zero register -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_and_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_and_i32);
 }
 
 /*
@@ -1758,33 +1736,7 @@ static void gen_mxu_S32AND(DisasContext *ctx)
  */
 static void gen_mxu_S32OR(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the content of XRc */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRc zero register -> just set destination to the content of XRb */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_or_i32);
 }
 
 /*
@@ -1794,33 +1746,7 @@ static void gen_mxu_S32OR(DisasContext *ctx)
  */
 static void gen_mxu_S32XOR(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the content of XRc */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRc zero register -> just set destination to the content of XRb */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else {
-        /* the most general case */
-        tcg_gen_xor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_xor_i32);
 }
 
 /*
-- 
2.53.0


