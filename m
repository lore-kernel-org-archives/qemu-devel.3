Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBECBC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I0-0003e0-1A; Tue, 12 Mar 2024 10:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Ha-0003Xd-Ll
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:12 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HO-0007ks-Mr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:09 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29c23f53eabso1171793a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254337; x=1710859137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNp6XquX3YweCwEwuUg2y5RKbGsMH7v+obg5kp5OsQE=;
 b=z6NwP0klODqOYD+9cJXe4n0q4qXo7B0oMzjL0LD9tDVdh5lSOLi2LDS9kfmQzy8Zaj
 +t+yZ1HTGD1+6xv6+xfATR0+dAtAfOyY5RJ4IDoz+xlvpfk2B9pex90NMp0loGPF3LO9
 A49l0OFjmRMIa41LHTwKbctycVr/9/KA1yxNMtP2IaaSvbSsCmUWjT+eIjNWVzu1xBX+
 CCFxKq/04XSGWSbr2CgHyxXsruSBKRT12ortJYVSJKN3RI/hzaw+kHji3bEmqSpm6FZI
 3KFbl1JnlNzk9sHMRr+RvqjqWe0MlnAVZ5bmcOsv2VgU+7lLRvvRO56GC8v4i6DtnMKO
 SsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254337; x=1710859137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNp6XquX3YweCwEwuUg2y5RKbGsMH7v+obg5kp5OsQE=;
 b=jFmF3FNX/cmv6FtETW2+n4WU3zWBaCFm9Eu9kAzbKoRLq1EfOt/jEgydg03yhzB6HP
 cDMRR8HyqBSBtpSkopZg5M3xVb8kWdxTcuHvXq9hkGAZlakzeqZBPTU6OdB44q6DyqaH
 /6Cir+x7esqRLOw5pPxNYlL806hmsVsy0F3sL1zBKOU2KPha198ppiQCYWpa85ZJCAox
 2wUe0BcHpu2s2QgYXoiVYvwg9c2rxyxCZVPjyVEGv0hGMw73lBoGmCU41EP+UpqGm22C
 Pg4AUalVAhg2/rEUncChKJLHb61hhosUrazdtLFqeTyRTVN+V0nDZNLGVYRcuV91vJ0+
 aTVg==
X-Gm-Message-State: AOJu0Yx7oFE49lj1SvRo/CNV5j/aiGKzDo8+FSlPjwiYR3/qBeT++qhU
 Qac40zZY9MXK9ILWbotEmFhLNRCiQFLg0SCDhUGMUUgbMFhrzWFUWUdCwN3muuPcVrM9fuZyrTi
 J
X-Google-Smtp-Source: AGHT+IEAq0AVx4e/IzTTjVNTzageDZJzIRszOVVR2UGvJFyRM2vc/4g8awAzTemkZCV4iO63b65oxA==
X-Received: by 2002:a17:90b:8cc:b0:29b:2268:3349 with SMTP id
 ds12-20020a17090b08cc00b0029b22683349mr7779350pjb.18.1710254337386; 
 Tue, 12 Mar 2024 07:38:57 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] tcg/riscv: Do not accept immediate operand for andc, orc,
 eqv
Date: Tue, 12 Mar 2024 04:38:34 -1000
Message-Id: <20240312143839.136408-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 tcg/riscv/tcg-target-con-set.h |  1 -
 tcg/riscv/tcg-target-con-str.h |  1 -
 tcg/riscv/tcg-target.c.inc     | 36 +++++++---------------------------
 3 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index aac5ceee2b..0f72281a08 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -15,7 +15,6 @@ C_O0_I2(rZ, rZ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index d5c419dff1..6f1cfb976c 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -15,7 +15,6 @@ REGS('r', ALL_GENERAL_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('I', TCG_CT_CONST_S12)
-CONST('J', TCG_CT_CONST_J12)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 639363039b..2b889486e4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -138,7 +138,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12   0x200
 #define TCG_CT_CONST_N12   0x400
 #define TCG_CT_CONST_M12   0x800
-#define TCG_CT_CONST_J12  0x1000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 
@@ -176,13 +175,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
         return 1;
     }
-    /*
-     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
-     * Used to map ANDN back to ANDI, etc.
-     */
-    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
-        return 1;
-    }
     return 0;
 }
 
@@ -1610,27 +1602,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
         break;
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ORI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
         break;
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_XORI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
         break;
 
     case INDEX_op_not_i32:
@@ -1963,18 +1943,16 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        return C_O1_I2(r, rZ, rN);
+
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
-        return C_O1_I2(r, r, rJ);
-
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
-
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
-- 
2.34.1


