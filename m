Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B39C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m2U-0004Mi-8i; Tue, 15 Apr 2025 15:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzN-0000Py-Ul
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyC-0000w4-Uk
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:33 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301c4850194so4654455a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745359; x=1745350159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XmYdUafFyZvEF7JFW5NVYuOFBeFT5T7M8XOIqHX1Gmc=;
 b=I1ddGVRMKESjGlU7nrBl4azNOCsye03WFXMR22ufi4Z2vEkRzq9lj6xZSoQUWmvPYI
 etBlyqDAPBfILHIWtyvb/IEJtIjKNWP/dz0KDcEpSWPEapzkFnUtPrTIaTrPH8GoHhCY
 trufl1O+VuvkLTkdvmKEtGxT4IZfidMjSm7r5k3HTQsNUNLQdkPJMOyZTTJGtR+IWxd5
 VLHAW0387ffgXNWcypWk83svNT7IhBHRoj9jYvyiyQhnUO55GjPrOS+jWlLKZJaYJUYk
 rkg600uvXaU7YxuakTgDkMki+fXMhvqmeFfrNiy1fLOQSioUO30VnVrJ/buwhl3GP+H6
 WYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745359; x=1745350159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmYdUafFyZvEF7JFW5NVYuOFBeFT5T7M8XOIqHX1Gmc=;
 b=Uh8lC8FkGmSazzQ0xeiEKu0CSlzeIEI0jUl9MwX/Xx35k0PAWxmZ1IoYAaQAsUdP37
 ZKe4fcaIBA2FdWwebJmEx1bXTo9eLv6k22AkYPynJyaN5bpx5G8YXhBLkVVoiQESziyn
 J8TjzNs51gy8ENXvNuH2/44BfooHVkwq+GTI76MiwSYFOgcJVHTQw7nJRzxhvwlK6Jdy
 BkCRQXDnmoZDlovSKhM3XeFef1yZZbP8kj3/O01V3qxg+EAE91TlqiQMLEEyNJOtkl5o
 bRDCIHJJborjeHKhrpFEODoi9MXwvP+VCu3Mu91CXPLy8oWwvyNY3BqIEOH25DyxSmZY
 AcBw==
X-Gm-Message-State: AOJu0YwotHLHfpXmjAytjUKzEpGjRMzKc1YlrTkYRkj/DXhfRbHIZpWI
 d+ZHYbzSiIvNTyCMYiU0kXvY7sAIceKWPETUa8osQ0hsaf16UXV1I+MCkBzMX2DiqdYACxkF/JU
 7
X-Gm-Gg: ASbGnctvzV1zMG4sfAfgZismpLpf3AKrXQmW3PdpTVVJbvpsu+FCOPLe6tiScb9eOy3
 i1qa44dFn9F104EE2+tKcBU+PtsZQeW4uhnLDsTrDRm9VrIud1pgDX6vlSlVjbgov/EAmMe4nU/
 OP6HyxBCy0+Htj3avyMDmQlf57taYl80qCy/EDjvlSXquoL/tlFKvENyW+CcqRIJEx4G3zfq6II
 Ht0w3t/lzZ7ntHJTCfSCG31jPnFCkng9L1ufyc7CU7QaRQjDRD/fUCrDbAebquDgt8eJgiv9QJk
 VLKTFITOPNCSKRSyFQToQ2jDAv6NGMC0QbZQlU3S+iarp2CwsRgC3+BMglijGFhHoPnVInokqGA
 vnjORTaUEMw==
X-Google-Smtp-Source: AGHT+IGaP0yafMHyAjV67xVo+MZUOcl0G1n50QVR1+jBKTHKJ8yccdBIJuzgdgMHVMFjnlo1Lb9EUQ==
X-Received: by 2002:a17:90b:3c11:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-3085ef39339mr535550a91.21.1744745359015; 
 Tue, 15 Apr 2025 12:29:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 073/163] tcg/mips: Support negsetcond
Date: Tue, 15 Apr 2025 12:23:44 -0700
Message-ID: <20250415192515.232910-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h |  4 ++--
 tcg/mips/tcg-target.c.inc | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 05701fd228..c77d4296cf 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -41,7 +41,7 @@ extern bool use_mips32r2_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -51,7 +51,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6a97264c7c..759f152711 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -959,6 +959,25 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     tcg_out_setcond_end(s, ret, tmpflags);
 }
 
+static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                               TCGReg arg1, TCGReg arg2)
+{
+    int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2);
+    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
+
+    /* If intermediate result is zero/non-zero: test != 0. */
+    if (tmpflags & SETCOND_NEZ) {
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
+        tmp = ret;
+    }
+    /* Produce the 0/-1 result. */
+    if (tmpflags & SETCOND_INV) {
+        tcg_out_opc_imm(s, OPC_ADDIU, ret, tmp, -1);
+    } else {
+        tcg_out_opc_reg(s, OPC_SUBU, ret, TCG_REG_ZERO, tmp);
+    }
+}
+
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
@@ -2270,6 +2289,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_setcond_i64:
         tcg_out_setcond(s, args[3], a0, a1, a2);
         break;
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        tcg_out_negsetcond(s, args[3], a0, a1, a2);
+        break;
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
@@ -2364,6 +2387,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, rz, rz);
 
     case INDEX_op_deposit_i32:
-- 
2.43.0


