Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1899C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I3-0003ew-Ez; Tue, 12 Mar 2024 10:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Ha-0003Xe-M6
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HN-0007km-Ka
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:09 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so11456a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254336; x=1710859136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/4kUSHiFCpPL9qQ3UOiS3LaHR+iaHi7L4Tr6+QKuD7g=;
 b=h3+muNBKfIxVTR9m70iLQsI6lEoOnuEryRaETdIhtI3bmsLXxUrOMGhXU86G23SmPf
 BG5D2gMBi1GXlNWnqMoVGLcEQhWUe5OXEkDqaHGT/eo9dwMpsqDSrIFlqQQYxeneBlyL
 LfGeP6a/q0mNRcqGWf3/S0myn+o7dnHmXXdOdwDuMG79ohJAdQ2F41ccoPE+wvVJ4mow
 HPDvfexaSV2JYyF0wLOmOtjfKUfmXLDHr+6/DYDNL7o0n6FA67rHR26TOQYSpJPd+IFp
 tRbJ3/RbF9hfwxUKZ7nv8yWJq7tl04eeuLBKoU6sC14ThwkWnB7Ciu4ljwAfq0HGRQWP
 DfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254336; x=1710859136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4kUSHiFCpPL9qQ3UOiS3LaHR+iaHi7L4Tr6+QKuD7g=;
 b=X0nWmaC7N3MyHWKxPjgq5RMOQMg4PJ4XwH6SfW+Pns0DrkkKnDgCOqzUy6NTBvMl9N
 paxktRfQrxSiHn3km46rLR+oAu2CKJ7BTpQWxEq05YrZPkeCwbbdYuGy1fc2GyoAjswH
 MQxJgbszhEcF3ZOSxaUlapnZ21cLBlUcxgLEI5Dr0HHE+EBOrhzRxIVHmFak/S/ifTYM
 c+JKDQgpp/SESPl+9YVL0H2X1uNiSx9r3eJA1V23zSQfZcEwCh10yR8djz4Q9Fwzc9Ba
 FwIoo8WdxzjBJuTSdocS2GcxiJiV87DyefwB2kEV0PWe0HrDcmLF8z8N1xN4PyHPjRge
 t49Q==
X-Gm-Message-State: AOJu0YxrObG+EixgrIVSYgrvoSGqaSF79U0sCsolZsjaCUOx7GktH61u
 NMFTBU+Ezh0BnhvhLmTgxYYqwCBW9TpkJ5gg2y0kQwogZKkT8oiZvZHECyPajK9QspNhqIoQr15
 K
X-Google-Smtp-Source: AGHT+IFcUBgePyeB82JACZt34VbG7Z2/dTgZLbqYHsgB/D9soIHNfDgoHrkj/4bbvEhSBycdzD74mA==
X-Received: by 2002:a17:90a:2ce6:b0:29b:c432:c1bb with SMTP id
 n93-20020a17090a2ce600b0029bc432c1bbmr12061537pjd.24.1710254335929; 
 Tue, 12 Mar 2024 07:38:55 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/15] tcg/s390x: Do not accept immediate operand for andc, orc
Date: Tue, 12 Mar 2024 04:38:33 -1000
Message-Id: <20240312143839.136408-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 tcg/s390x/tcg-target.c.inc | 56 ++++++--------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ad587325fc..b9a3e6e56a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2216,31 +2216,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_andc_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_andi(s, TCG_TYPE_I32, a0, (uint32_t)~a2);
-	} else {
-            tcg_out_insn(s, RRFa, NCRK, a0, a1, a2);
-	}
+        tcg_out_insn(s, RRFa, NCRK, args[0], args[1], args[2]);
         break;
     case INDEX_op_orc_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, (uint32_t)~a2);
-        } else {
-            tcg_out_insn(s, RRFa, OCRK, a0, a1, a2);
-        }
+        tcg_out_insn(s, RRFa, OCRK, args[0], args[1], args[2]);
         break;
     case INDEX_op_eqv_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_insn(s, RIL, XILF, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NXRK, a0, a1, a2);
-        }
+        tcg_out_insn(s, RRFa, NXRK, args[0], args[1], args[2]);
         break;
     case INDEX_op_nand_i32:
         tcg_out_insn(s, RRFa, NNRK, args[0], args[1], args[2]);
@@ -2517,31 +2499,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_andc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_andi(s, TCG_TYPE_I64, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NCGRK, a0, a1, a2);
-        }
+        tcg_out_insn(s, RRFa, NCGRK, args[0], args[1], args[2]);
         break;
     case INDEX_op_orc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, OCGRK, a0, a1, a2);
-        }
+        tcg_out_insn(s, RRFa, OCGRK, args[0], args[1], args[2]);
         break;
     case INDEX_op_eqv_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_xori(s, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NXGRK, a0, a1, a2);
-        }
+        tcg_out_insn(s, RRFa, NXGRK, args[0], args[1], args[2]);
         break;
     case INDEX_op_nand_i64:
         tcg_out_insn(s, RRFa, NNGRK, args[0], args[1], args[2]);
@@ -3244,15 +3208,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, rK);
 
     case INDEX_op_andc_i32:
-    case INDEX_op_orc_i32:
-    case INDEX_op_eqv_i32:
-        return C_O1_I2(r, r, ri);
     case INDEX_op_andc_i64:
-        return C_O1_I2(r, r, rKR);
+    case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
+    case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
-        return C_O1_I2(r, r, rNK);
-
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
-- 
2.34.1


