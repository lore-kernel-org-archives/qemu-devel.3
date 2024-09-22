Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FECF9C6D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHf-0001dK-B4; Sun, 22 Sep 2024 08:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHE-0000uw-A8
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:27 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHA-0002MU-LY
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:18 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9018103214so486881966b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006475; x=1727611275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJqgUpVqE8mzIAzakADKSQmb3mmZO+Sr3Tev2BkN3Qc=;
 b=KPdtXXYoj+nbBGYZB3BUzFx3MmlnviCKp8rbKNjVeDbwgk/v+bwQ6q3TIfhQxYX0py
 w0OomtjMVtx4oGwWJQ2uXMy10GRuv1k3HQO/ytb15i2jTNegY4Y46UOgUWK8YbcKE1gk
 xFQgvlHLPnPTONsaiCEDsfIOQMGrMGra/Dw5njbX9VnTXeKgs/OY3/9GiB5f45mMVaga
 0ooCQxfCd5DbgohE5nPUPMqvAtucM/b4STv3szahL8MPSPEvlg+WltamvH8fjJvVNb72
 Ud/5JP/1fIzho4ho0tL6wrjHep3+7vP1kEKd9ulmXOvvd9a9ytncd7XAqjXnmBATFBGi
 NELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006475; x=1727611275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJqgUpVqE8mzIAzakADKSQmb3mmZO+Sr3Tev2BkN3Qc=;
 b=HlKNcMxtZMc23Xc/5BtFx7WHdDO6jlAqQhFveOgCQyH7Xiv7CpKyq7iFkYk9N/qZ5A
 /3tpcj5WY/uSMvUY6aONU/xWZzJoAiL7M3b5hzLrFOwojWJxMhc0JnbLA3RpZ2a1HrV3
 R2A4lFIva663v40ZI54FIOM1WqElAj+61N4aKQinlI/hMJkvu20PrfmlmstQPMud2O1x
 58mbQez9yfofSpVdPmyxg9V+thy2j6wJgtQ5WRwLWpVfTHNTwy0dOqXld+Z47xSvroDC
 ZJfyti6PA08JlBKQZmKlDU3TtgkJu/v5X8m6/mIVMUUUKHJHgFdj4vUiR1025cCWoJKO
 oCzA==
X-Gm-Message-State: AOJu0Yxw9+hhph3wKwlH77PRoMIKJIhVFZS7rAdQHERTeGXii5yp4RGR
 loTuqtOaqj+KIlWNXGxHvLN4jN32jp8tVwv29Gubsk9i/4o0rQTerfrADhkhyuWJB3XG6CbCChi
 Rmd8=
X-Google-Smtp-Source: AGHT+IHubmoyrZjVUEr1r3XZxZhrwPg1migFE1dr1umHMNV+/gPsqDJnXuI4rQwdecma4LFwcOzqhQ==
X-Received: by 2002:a17:907:a4b:b0:a86:aee7:9736 with SMTP id
 a640c23a62f3a-a90d59257d4mr898993066b.46.1727006474801; 
 Sun, 22 Sep 2024 05:01:14 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Elisha Hollander <just4now666666@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/31] tcg: Propagate new TCGOp to add_as_label_use
Date: Sun, 22 Sep 2024 14:00:43 +0200
Message-ID: <20240922120112.5067-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

The use of tcg_last_op does not interact well with
TCGContext.emit_before_op, resulting in the label
being linked to something other than the branch op.

In this case it is easier to simply collect the emitted
branch op and pass it directly to add_as_label_use.

Reported-by: Elisha Hollander <just4now666666@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 63 ++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 28c41b37a4..4a7e705367 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -117,9 +117,9 @@ static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
     tcg_gen_op1(opc, tcgv_i64_arg(a1));
 }
 
-static void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 {
-    tcg_gen_op1(opc, a1);
+    return tcg_gen_op1(opc, a1);
 }
 
 static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
@@ -196,16 +196,16 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGArg a3, TCGArg a4)
+static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                     TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                  TCGArg a3, TCGArg a4)
+static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                     TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
 static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
@@ -270,12 +270,12 @@ static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
-static void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGv_i32 a3, TCGv_i32 a4,
-                                  TCGArg a5, TCGArg a6)
+static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                     TCGv_i32 a3, TCGv_i32 a4,
+                                     TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
+    return tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                       tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
 /* Generic ops.  */
@@ -286,18 +286,17 @@ void gen_set_label(TCGLabel *l)
     tcg_gen_op1(INDEX_op_set_label, label_arg(l));
 }
 
-static void add_last_as_label_use(TCGLabel *l)
+static void add_as_label_use(TCGLabel *l, TCGOp *op)
 {
     TCGLabelUse *u = tcg_malloc(sizeof(TCGLabelUse));
 
-    u->op = tcg_last_op();
+    u->op = op;
     QSIMPLEQ_INSERT_TAIL(&l->branches, u, next);
 }
 
 void tcg_gen_br(TCGLabel *l)
 {
-    tcg_gen_op1(INDEX_op_br, label_arg(l));
-    add_last_as_label_use(l);
+    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, label_arg(l)));
 }
 
 void tcg_gen_mb(TCGBar mb_type)
@@ -514,8 +513,9 @@ void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_op4ii_i32(INDEX_op_brcond_i32, arg1, arg2, cond, label_arg(l));
-        add_last_as_label_use(l);
+        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond_i32,
+                                      arg1, arg2, cond, label_arg(l));
+        add_as_label_use(l, op);
     }
 }
 
@@ -1934,15 +1934,16 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op;
         if (TCG_TARGET_REG_BITS == 32) {
-            tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
-                              TCGV_HIGH(arg1), TCGV_LOW(arg2),
-                              TCGV_HIGH(arg2), cond, label_arg(l));
+            op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
+                                   TCGV_HIGH(arg1), TCGV_LOW(arg2),
+                                   TCGV_HIGH(arg2), cond, label_arg(l));
         } else {
-            tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
-                              label_arg(l));
+            op = tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
+                                   label_arg(l));
         }
-        add_last_as_label_use(l);
+        add_as_label_use(l, op);
     }
 }
 
@@ -1953,12 +1954,12 @@ void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
     } else if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
-                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                          tcg_constant_i32(arg2),
-                          tcg_constant_i32(arg2 >> 32),
-                          cond, label_arg(l));
-        add_last_as_label_use(l);
+        TCGOp *op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
+                                      TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                                      tcg_constant_i32(arg2),
+                                      tcg_constant_i32(arg2 >> 32),
+                                      cond, label_arg(l));
+        add_as_label_use(l, op);
     }
 }
 
-- 
2.43.0


