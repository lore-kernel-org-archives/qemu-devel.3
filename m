Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DD4C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3i8-0000Fb-3F; Tue, 11 Feb 2025 22:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hi-00009k-LA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hf-0001aJ-Qj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:26 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f62cc4088so76351435ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 19:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739331982; x=1739936782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gOgvNftMIIoKV3YyDJMbr2pcd4FkgGtrzluRHQDbxpc=;
 b=UTOMfCEmDaTUMOLQCi3ZSIRnBEyA5x8o0LVl6Fjp0dWhQln21NlaZUjFgOI8DwhrHa
 RsptDxM3wH96kt8kJGHK0lRyjjatsINb4hv6FLgfqjqlGtlvgpHXfBuF4fupXkFT2l7w
 HI32yCB5wefBV9G2+fvUmvcCIcC95y5Wkr95oFAVPqnV0tk8eFCXKb7zexB5BlMT9dp/
 rB2NA34GhAjhG+Ppfn+IkQfXwcGVitLrMB0cJ5e7mORMjFHxnoOeA5mp1AG4vSnfGnnr
 A2w6Hn14DDcJ+fzGmz22RimQ+WbvIqEz1VMadIgVmwhLYkU0l51tsfOqWU0iUeOPWkAP
 YBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739331982; x=1739936782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOgvNftMIIoKV3YyDJMbr2pcd4FkgGtrzluRHQDbxpc=;
 b=MG4fYfKz+t0kjxzo4h6FR66cH65aS6b7bqJR8JaU6iyf0YCMVK5DKMPe3eUerINYRs
 UCuPXtteeYYHxBV/F2JSn+cFpy2sYHL85uKpt0/c1fS9rvvPzEF+yErutfq5mUNHeoJ0
 11X3IWiON750igF52sg7Epz0s6y68jqYztbBxUAtQLL3dPwPn6axdYKllPAvWdl3/7ue
 9etzsdB5hf5YgYc5K8RLuc5qT5ijXsxZjnQedOdmHFriJYD2ab3b6I5FXK4fxRrTzv/S
 pPWICZYV41ubqSnKQFW+zRDWllk3OyCho1KXTtU0vSC7f93kQDv02KASz8Q+n/27j6h5
 aTJw==
X-Gm-Message-State: AOJu0YxKiZSnO2XkgXdXe7TFEEY5vSA424b34+HclgY5XOPBSY7bq7vJ
 tDW8YHJM74pJf26tY7V7JX7Y8cR3+sMyXWQtYpKYRHpBPO82d4fEHo/eCOMH6/lKXL+VBWkkQsV
 H
X-Gm-Gg: ASbGncvtFy9E+PuTaN+kHgxuwuGFxgvHR/vR9XFUlTBvHc35obLkqfDU7jbKvG5AwhF
 wF2pKzYSvoTqEQMembi1N0z+xSsdrJdSHcvS/EElJGEX4VNVjfoq1IQXiVcIHQGqhmJlpwR+SNg
 9+stedFqftPFAY5kUf2qNKSeOqgZkaOZ/mBKAnUctzr/v15wEVB5d77kIZ9QzSU3jy7d8j0UHF6
 2Hu76M2pDtrKmfBFFBCrR+ca553adUqChzNGVj7zH41cQ4zMML9Fi5rJe9KB9/3KtD9EKlXjj8/
 3MvbxPuGSN8WgAIkhkFABUlJ/Z3XpP3eylplswhEAiOodiQ=
X-Google-Smtp-Source: AGHT+IEIumUG1b9wOx+h7K+srdfggEZdfnN3OThPYwRcrgd9uO/eZoOkql/O2jo2A/rchOju/SbEmg==
X-Received: by 2002:a05:6a21:6b17:b0:1ed:a80e:932 with SMTP id
 adf61e73a8af0-1ee5c83de1bmr4135966637.34.1739331982416; 
 Tue, 11 Feb 2025 19:46:22 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730992eba96sm3482569b3a.126.2025.02.11.19.46.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 19:46:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] tcg/mips: Use 'z' constraint
Date: Tue, 11 Feb 2025 19:46:15 -0800
Message-ID: <20250212034617.1079324-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212034617.1079324-1-richard.henderson@linaro.org>
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Replace target-specific 'Z' with generic 'z'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-con-set.h | 26 ++++++++++-----------
 tcg/mips/tcg-target-con-str.h |  1 -
 tcg/mips/tcg-target.c.inc     | 44 ++++++++++++++---------------------
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 864034f468..06ab04cc4d 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -10,24 +10,24 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
-C_O0_I3(rZ, r, r)
-C_O0_I3(rZ, rZ, r)
-C_O0_I4(rZ, rZ, rZ, rZ)
-C_O0_I4(rZ, rZ, r, r)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
+C_O0_I3(rz, r, r)
+C_O0_I3(rz, rz, r)
+C_O0_I4(rz, rz, rz, rz)
+C_O0_I4(rz, rz, r, r)
 C_O1_I1(r, r)
-C_O1_I2(r, 0, rZ)
+C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, r, rWZ)
-C_O1_I2(r, rZ, rN)
-C_O1_I2(r, rZ, rZ)
-C_O1_I4(r, rZ, rZ, rZ, 0)
-C_O1_I4(r, rZ, rZ, rZ, rZ)
+C_O1_I2(r, r, rzW)
+C_O1_I2(r, rz, rN)
+C_O1_I2(r, rz, rz)
+C_O1_I4(r, rz, rz, rz, 0)
+C_O1_I4(r, rz, rz, rz, rz)
 C_O2_I1(r, r, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rZ, rZ, rN, rN)
+C_O2_I4(r, r, rz, rz, rN, rN)
diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips/tcg-target-con-str.h
index 413c280a7a..dfe2b156df 100644
--- a/tcg/mips/tcg-target-con-str.h
+++ b/tcg/mips/tcg-target-con-str.h
@@ -19,4 +19,3 @@ CONST('J', TCG_CT_CONST_S16)
 CONST('K', TCG_CT_CONST_P2M1)
 CONST('N', TCG_CT_CONST_N16)
 CONST('W', TCG_CT_CONST_WSZ)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6fe7a77813..dffb59cde4 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -184,12 +184,11 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     g_assert_not_reached();
 }
 
-#define TCG_CT_CONST_ZERO 0x100
-#define TCG_CT_CONST_U16  0x200    /* Unsigned 16-bit: 0 - 0xffff.  */
-#define TCG_CT_CONST_S16  0x400    /* Signed 16-bit: -32768 - 32767 */
-#define TCG_CT_CONST_P2M1 0x800    /* Power of 2 minus 1.  */
-#define TCG_CT_CONST_N16  0x1000   /* "Negatable" 16-bit: -32767 - 32767 */
-#define TCG_CT_CONST_WSZ  0x2000   /* word size */
+#define TCG_CT_CONST_U16  0x100    /* Unsigned 16-bit: 0 - 0xffff.  */
+#define TCG_CT_CONST_S16  0x200    /* Signed 16-bit: -32768 - 32767 */
+#define TCG_CT_CONST_P2M1 0x400    /* Power of 2 minus 1.  */
+#define TCG_CT_CONST_N16  0x800    /* "Negatable" 16-bit: -32767 - 32767 */
+#define TCG_CT_CONST_WSZ  0x1000   /* word size */
 
 #define ALL_GENERAL_REGS  0xffffffffu
 
@@ -204,8 +203,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
 {
     if (ct & TCG_CT_CONST) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
     } else if ((ct & TCG_CT_CONST_U16) && val == (uint16_t)val) {
         return 1;
     } else if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
@@ -1663,11 +1660,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a0, a1, a2;
     int c2;
 
-    /*
-     * Note that many operands use the constraint set "rZ".
-     * We make use of the fact that 0 is the ZERO register,
-     * and hence such cases need not check for const_args.
-     */
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
@@ -2178,14 +2170,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
         return C_O1_I2(r, r, rJ);
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
+        return C_O1_I2(r, rz, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
@@ -2204,7 +2196,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_remu_i64:
     case INDEX_op_nor_i64:
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
     case INDEX_op_muls2_i32:
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i64:
@@ -2231,35 +2223,35 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, r, ri);
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-        return C_O1_I2(r, r, rWZ);
+        return C_O1_I2(r, r, rzW);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rZ);
+        return C_O1_I2(r, 0, rz);
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return (use_mips32r6_instructions
-                ? C_O1_I4(r, rZ, rZ, rZ, rZ)
-                : C_O1_I4(r, rZ, rZ, rZ, 0));
+                ? C_O1_I4(r, rz, rz, rz, rz)
+                : C_O1_I4(r, rz, rz, rz, 0));
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rZ, rZ, rN, rN);
+        return C_O2_I4(r, r, rz, rz, rN, rN);
     case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, rZ, rZ, rZ, rZ);
+        return C_O1_I4(r, rz, rz, rz, rz);
     case INDEX_op_brcond2_i32:
-        return C_O0_I4(rZ, rZ, rZ, rZ);
+        return C_O0_I4(rz, rz, rz, rz);
 
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
     case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
     case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rZ, r) : C_O0_I3(rZ, rZ, r);
+        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rz, r) : C_O0_I3(rz, rz, r);
 
     default:
         return C_NotImplemented;
-- 
2.43.0


