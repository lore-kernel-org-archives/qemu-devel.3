Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576F3C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Hz-0003dJ-Ic; Tue, 12 Mar 2024 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Ha-0003Xc-Lq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:12 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HQ-0007kw-ON
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29bf998872fso1478053a91.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254339; x=1710859139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cbxM+ZYIVDOiIr29L7EmXNz1akvOYPBrfp8Zc64o4J8=;
 b=dO15TNi4nnD1mBGQ4DFuKHxFjX/FqPlp/UoKZxNvviGoiOrpZJonfHQZA+05HVMei1
 9V8SL0NczT2A52mvslN7xuUplbjVLUyYa38o221nk/GqEtfjHm8ZeVWEJBJKBP6W0eHx
 KHoyLr+fWP8sitC5ICeaCdm2XAee5L/r0Kzf1aMAdJQacLmG9TESprPt2+W/Lo+bgfav
 uQxpZ1re8sXmQ5Gvfz2sDIL8P4x7QnUYPn7Wq+vJS/F1VsZCsdDqa2LOsW0D8vbn4UMA
 wtGYNG63Ji2o2ZES0kgG7KaF/Ud/uEj9LBKbMo1eScalWGijtCeZSIPhzQoS3UREZFbq
 iK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254339; x=1710859139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbxM+ZYIVDOiIr29L7EmXNz1akvOYPBrfp8Zc64o4J8=;
 b=UEgJCd4Wq1dPQcjlvH0W18Mnt9wmeOi3kvPw2qK86eZ/hG0Ky6nhFr6AnVnopcx6UR
 9N0FC55WmrP/s8KWam8ZfN+Q4/sV7Z6jIaqc5J5AXJa/diubmVHwHgtwe/paMPLE74P7
 qTDeTRPzBXpZAdlr1mwbBYaWGVO15YrPlbqJJwnoHDBowl64Dh3fAXCZGVi2pKcML6rX
 sHsYZeg1ABpOxyTQe6YHuyZpTJkDzkWiQIOMCjJWW9AlO14VLnZAY1jfeasdosAR4ieK
 zn18Zuu7DxuGEkbrE/K3BCTq5LLkcaZ2bDJDTe3EgSIJRx/3D9Ov9ED9c8k10J8AupUa
 +XQA==
X-Gm-Message-State: AOJu0Ywc/FMKZOCrhBPnySSWIdGgRYxdPl2u3LFFAVnzPz9wTOIiIU7n
 hZSwK95PBd+KXY+P8MRA3gr8+AmFt5ZZIIBegD3DBA4fyKfiQayOYW6R7XlOYhxuIqNem/t2KOC
 u
X-Google-Smtp-Source: AGHT+IFZHOzx9j2OBhipPnHXuNJY6DfPc/XZuUthJn3NEM2vKuIutqtavLjHKUcs1nQKYDpbNt3eJg==
X-Received: by 2002:a17:90a:c406:b0:29b:b3fa:b7ac with SMTP id
 i6-20020a17090ac40600b0029bb3fab7acmr6922906pjt.10.1710254338788; 
 Tue, 12 Mar 2024 07:38:58 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/15] tcg/riscv: Do not accept immediate operands for sub
Date: Tue, 12 Mar 2024 04:38:35 -1000
Message-Id: <20240312143839.136408-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The transformations to neg and add immediate are now done
generically and need not be handled by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  2 +-
 tcg/riscv/tcg-target-con-str.h |  1 -
 tcg/riscv/tcg-target.c.inc     | 24 ++++--------------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 0f72281a08..13a383aeb1 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -13,9 +13,9 @@ C_O0_I1(r)
 C_O0_I2(rZ, r)
 C_O0_I2(rZ, rZ)
 C_O1_I1(r, r)
+C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 6f1cfb976c..a8d57c0e37 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -15,6 +15,5 @@ REGS('r', ALL_GENERAL_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('I', TCG_CT_CONST_S12)
-CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2b889486e4..6b28f2f85d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -136,8 +136,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define TCG_CT_CONST_ZERO  0x100
 #define TCG_CT_CONST_S12   0x200
-#define TCG_CT_CONST_N12   0x400
-#define TCG_CT_CONST_M12   0x800
+#define TCG_CT_CONST_M12   0x400
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 
@@ -160,13 +159,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
         return 1;
     }
-    /*
-     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
-     * Used for subtraction, where a constant must be handled by ADDI.
-     */
-    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
-        return 1;
-    }
     /*
      * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
      * Used by addsub2 and movcond, which may need the negative value,
@@ -1559,18 +1551,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_sub_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUBW, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_SUBW, a0, a1, a2);
         break;
     case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
         break;
 
     case INDEX_op_and_i32:
@@ -1945,7 +1929,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
-- 
2.34.1


