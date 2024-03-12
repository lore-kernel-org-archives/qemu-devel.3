Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C3CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Hr-0003Zy-EL; Tue, 12 Mar 2024 10:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HZ-0003XJ-9J
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HI-0007ju-46
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29be9c136a2so1964174a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254330; x=1710859130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aSfVCHCwzSzRVXOz7WshzegXhabuAUGT/As/uR9fcX8=;
 b=S9Fl3hzVee0ld3o4lmT9yAcTxyMWObfHb+EWpcd49Aic4VRuZrOV2wvsgTFN3ShdYb
 8Jwx7AxclNcwR0wHntJlMJ0+GFBV0EK05Vmn3OSCQN76Y7u3TQZs+Pfe6jOVZvHARBT5
 JWNPu0jq2ZzbAYsuxSePSf+QdwhOth4uZVPD9zSU08slh/jlu0XaIVAKhC37IQa0v7fD
 FG3EHPG+t2MCyC4sepehKEhHarZlUIqs6oZhLiT/xhacFm/+uiXy1iKWBeb5b9OIHFTk
 8IuFuaRw2Jk7n1aLeWLLaHqaR19m7Nv77fpOZvF0tZBxUZ6iaI+OsZvv57w5iktqwkyV
 6vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254330; x=1710859130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSfVCHCwzSzRVXOz7WshzegXhabuAUGT/As/uR9fcX8=;
 b=OKrliT36GV31EWWTHX1nQDe9FwUcfl1zCr5S42CBeB+7OKnuoHR9Lt69ybvQKqmBXV
 odhCBx3GayG65tjTTtPEI7AMZJzLYmDfLyhkxLrl5CCki16ESPRTJyJFOC+NkCXX+vbL
 Xs6sPbPq8KEyKbMtc4eLuJw9q1tXj2RE+Ur/trfRCpgv3y979LgnCLqc6TgGHe8OUpks
 ATcwOma05R8EUiiquodZdU4DakXiCT5sQ0661iPymeqvY8GLLaSzon6UXAJ2S5p04b7X
 U7te4NLceH+qfy3VPxkw06HRcxHA+4fDgjkaBHzTmNWi3vc7RgbaPpLckd9HscrvBESs
 8G/g==
X-Gm-Message-State: AOJu0YyO1ZcwenFvtah0MimgB1gsdkwpImJfLOHkV7Jq4jEH9LQN0v+M
 s0rAaNzTKEm6S2lZA8AKHXxRlOX8mJeTYaarOeEomtNk2kkMWJVoESEleB2B0bDRLwthjU1UQfh
 s
X-Google-Smtp-Source: AGHT+IHzYTJFgwTi9pNPUBNV/c2jjSUMP/9bUdAw0FSNZpCtEyg6lIS46LVM43bzZafTUFLN5wXF2A==
X-Received: by 2002:a17:90b:3ec3:b0:29a:e0bc:4a9b with SMTP id
 rm3-20020a17090b3ec300b0029ae0bc4a9bmr7969926pjb.16.1710254330634; 
 Tue, 12 Mar 2024 07:38:50 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/15] tcg/aarch64: Do not accept immediate operand for andc,
 orc, eqv
Date: Tue, 12 Mar 2024 04:38:29 -1000
Message-Id: <20240312143839.136408-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The transformations with inverted immediate are now done
generically and need not be handled by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 50 +++++++++++-------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dec8ecc1b6..68a381e4af 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2216,17 +2216,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_andc_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_andc_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, ~a2);
-        } else {
-            tcg_out_insn(s, 3510, BIC, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_or_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -2238,17 +2227,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_orc_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_orc_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, ~a2);
-        } else {
-            tcg_out_insn(s, 3510, ORN, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -2260,15 +2238,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+        tcg_out_insn(s, 3510, BIC, ext, a0, a1, a2);
+        break;
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+        tcg_out_insn(s, 3510, ORN, ext, a0, a1, a2);
+        break;
     case INDEX_op_eqv_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
     case INDEX_op_eqv_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_EORI, ext, a0, a1, ~a2);
-        } else {
-            tcg_out_insn(s, 3510, EON, ext, a0, a1, a2);
-        }
+        tcg_out_insn(s, 3510, EON, ext, a0, a1, a2);
         break;
 
     case INDEX_op_not_i64:
@@ -2995,6 +2975,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
@@ -3015,12 +3001,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rL);
 
     case INDEX_op_shl_i32:
-- 
2.34.1


