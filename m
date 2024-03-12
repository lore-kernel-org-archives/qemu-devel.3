Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA668C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I1-0003eb-4O; Tue, 12 Mar 2024 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Ha-0003Xb-Ll
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:12 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HL-0007kK-Rq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29c14800a7fso1409131a91.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254334; x=1710859134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jbNLo5y1YUnPREukd4mIwrgqxX0R9HS5MZo8QZlenPA=;
 b=EyMHQIROka49yu0z6FCyh9iWfivz0aJvFOVJDT897Nz0Lbi9nrPUVdViaS3Rguq5OK
 lr2uN9ZosPpleiFxtScNGRMhYYFJPhEV0ZF5orR4dKBtAIaGx57DJyj4euOjxJxwlG+W
 kSJ3yZblpu4Oawpu94qys8jDbyWyyh9r5EPoR9vB7PnTDALITphS+sHwhX7w1PIPsUGu
 /DcN711UtfpN4Xu5azWh/XcTM4+d0BdtFjhyJDuU+LNPdX48NXAEtkxL8fKhuhgqxyaQ
 MTA3ZeO4lVuz3KvxslfUdiOqP9NPBG/Eti7OMxyUm3WL7nwit1lue5UvaIpKXwIgKZfA
 4EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254334; x=1710859134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbNLo5y1YUnPREukd4mIwrgqxX0R9HS5MZo8QZlenPA=;
 b=hprl1sdYgVCCawH5cXFLbj+TYjVxoRgVuwAGnNqFq/eeIfBITwb3sYcP4K0iOOc+VK
 ApW/XaIszmK35O9dZneChp/UYjw4Ue+gdwZMfl+K7CKqxMENEdBQ3GFHBhvU5/TJj6B2
 Dmtn5f1UlAxMIDID9UFCjpG995C+oGqz4whV1vAKnIdzHNCxT3DqbGIyqUZsEaz15Wtf
 91IChrgr3T0AYsKc7sCTFjEChEKtq67fZJq7/2/ANJDEMkzxRZbkXoa0QUAbP2Llb8gz
 GtgbH3ArUfSvm6BbzxVI2yPoPv/IHSWNx86HEwECKOek+FRdCM3F05YKM2kLnWeLMnVk
 nddA==
X-Gm-Message-State: AOJu0YwiMKjU0PwRfk6ll6T0gMG0+xeXHynF1Zddt3LYKIp2SXg4P9Du
 RxLLvmdNMum2tIbvOUWlqGrJJlmSZHDv5wq3HWzdiqvg8kprRP4L4S0iVTZuN+BwPveQLVbMNIe
 g
X-Google-Smtp-Source: AGHT+IFdW2IFo8FNHQrGTtqM5B79OCqEmlLHO6DKMOtd/2wO+pPwVS+eJPlos5TCFwM/HwU/8+aiOA==
X-Received: by 2002:a17:90b:4c87:b0:29b:3cae:c50d with SMTP id
 my7-20020a17090b4c8700b0029b3caec50dmr2221819pjb.0.1710254334606; 
 Tue, 12 Mar 2024 07:38:54 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] tcg/loongarch64: Do not accept immediate operand for
 andc, orc
Date: Tue, 12 Mar 2024 04:38:32 -1000
Message-Id: <20240312143839.136408-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 tcg/loongarch64/tcg-target-con-set.h |  2 +-
 tcg/loongarch64/tcg-target-con-str.h |  1 -
 tcg/loongarch64/tcg-target.c.inc     | 31 ++++++----------------------
 3 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index cae6c2aad6..272f33c1e4 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -22,7 +22,7 @@ C_O0_I3(r, r, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
-C_O1_I2(r, r, rC)
+C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 2ba9c135ac..e7d2686db3 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -24,7 +24,6 @@ CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U12)
 CONST('Z', TCG_CT_CONST_ZERO)
-CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
 CONST('A', TCG_CT_CONST_VADD)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 69c5b8ac4f..e343d33dba 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -169,10 +169,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12   0x200
 #define TCG_CT_CONST_S32   0x400
 #define TCG_CT_CONST_U12   0x800
-#define TCG_CT_CONST_C12   0x1000
-#define TCG_CT_CONST_WSZ   0x2000
-#define TCG_CT_CONST_VCMP  0x4000
-#define TCG_CT_CONST_VADD  0x8000
+#define TCG_CT_CONST_WSZ   0x1000
+#define TCG_CT_CONST_VCMP  0x2000
+#define TCG_CT_CONST_VADD  0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -201,9 +200,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_U12) && val >= 0 && val <= 0xfff) {
         return true;
     }
-    if ((ct & TCG_CT_CONST_C12) && ~val >= 0 && ~val <= 0xfff) {
-        return true;
-    }
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
@@ -1236,22 +1232,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
-        if (c2) {
-            /* guaranteed to fit due to constraint */
-            tcg_out_opc_andi(s, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_andn(s, a0, a1, a2);
-        }
+        tcg_out_opc_andn(s, a0, a1, a2);
         break;
 
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
-        if (c2) {
-            /* guaranteed to fit due to constraint */
-            tcg_out_opc_ori(s, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_orn(s, a0, a1, a2);
-        }
+        tcg_out_opc_orn(s, a0, a1, a2);
         break;
 
     case INDEX_op_and_i32:
@@ -2120,12 +2106,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
-        /*
-         * LoongArch insns for these ops don't have reg-imm forms, but we
-         * can express using andi/ori if ~constant satisfies
-         * TCG_CT_CONST_U12.
-         */
-        return C_O1_I2(r, r, rC);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
-- 
2.34.1


