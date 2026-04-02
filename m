Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD87D39430
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Iuj-0001uk-9N; Thu, 02 Apr 2026 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w8Iua-0001tW-DG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:20:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w8IuW-0003RX-8O
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:20:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d029f346eso918738f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775139637; x=1775744437; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=50JkMzrqmzsDndU7M5ZJWnAC/pZeRhcoTK8kZ/S+Lhc=;
 b=K/6NfQ9z+eZGv1Kdwozzeo0YWYZoz2/Z1hOzzV+RnYhCvxxcGhJtToC3MLJ71KzbhK
 ThMGBcCOP9bDiVhi0y+dwZPODIoLhYFxiZ7pnU++s/klm9NS4q3dZrhSD0P+FBV37Sh6
 u0vQHjGYehPzJpWkmaN/lDf3sEg+DKAl0T59HEOR1WAqVcJNEt2JcXA/IX51xkRvyoXy
 +95aXmUZAnOrsFhN6qokMI5mt42XmSZM8cnmMsj81nshQcCPkbfoDs4LJCD2IxDilc6X
 kFSVPjGXGG5ZUGaZz02AhyUnKUZkWPXxX/og/DHJaQWtwiw0pCAGPvFKFWC0RisqdEJD
 6+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775139637; x=1775744437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=50JkMzrqmzsDndU7M5ZJWnAC/pZeRhcoTK8kZ/S+Lhc=;
 b=WGkuvhzXUpEQiQONjf2ybH8UQWw+gDWXPqXnfqt5FJ3luTPv5EBpUS/8BYQhL86ZSv
 +4rfsho0bnKWU8jBr6uDRXcN7YMh5PYTeDnDp9ODPhtDUPgBhgIbbolyVnPQhY7A8H2V
 t9V5mH6sYvCTb8Vl93UU0zdQ2pMCC3h/eKosNfrByx8fJy3fzJYOeN6WLfQSu09a5U3V
 0wCRmBN8S00yfMSTFdK8I/jpu7gxIV9REfQoJRZwQWJo02OkF6epDv6IvtRiH0ms5HCg
 E5LdBVeIg7UDC0pFR15iQF7sPrTWzQAxm+ZAoRnEkBg4ICdCREr9OFfdsA5fAZUwfnwd
 HK5g==
X-Gm-Message-State: AOJu0YyPYiXybl9TAmWcahGwOl/XLDjhP+8Rc+G9Z6mEflHhv3IF7AXl
 RnbPuJ/6afCoWl7wp/w5CiGzmU3YKMRfpCjMG043qyuxSLyg9ppXiv2iNR/hQ2gRc/A=
X-Gm-Gg: AeBDieswDBdfS6xWfdx+t5pwQsp3GCSEp32LkcWX59MGtUSsNblliDcCNZUjcDJggc9
 +TxQp8FP3yGH/9m8CuZlcSl9PsUvYDLfgjCMHW3fs/TK7VgzU1nQxpYAw1gQ9HjdVBQETMYbY+d
 g+WqTGvgmff4p+0dDcIejRLJa8XmHRx97pHh/BrpNEHBVtwkTLNc0Z2KBRqRaHYNXS/NWCrDT05
 CnSrkYq5KwGOuthtQtmzHquaxvdndULwD2sPBCeJYB8ZljC7gQANG7Dj21sl99QoaRwSDHvCQVt
 4HzqoCCwOLRXR3NIRFvMIk7APsnE23XupRf1YyZKyzgSWBQ6o3b88D5x7kQd6AYgaO6dcIo05rB
 1qiRY7pyRkqpFjKgERlaoDmCrnLmBYigBzn9LcC+VWJj0u5HPRlG7j1FFLN7jxrN/aiFq+HTGr2
 RXA1gOzvdPSyeZZ+e8u3mXNRpPhw==
X-Received: by 2002:a05:6000:2586:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-43d1f1f5c3bmr6749403f8f.22.1775139635788; 
 Thu, 02 Apr 2026 07:20:35 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6bea:159e:9f17:ebb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm7902384f8f.31.2026.04.02.07.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 07:20:35 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 02 Apr 2026 15:20:29 +0100
Subject: [PATCH 2/2] tcg/aarch64/tcg-target.c.inc: Manual replace of I3310,
 I3313
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-aarch64-tcg-instruction-format-rename2-v1-2-0998a08a515c@linaro.org>
References: <20260402-aarch64-tcg-instruction-format-rename2-v1-0-0998a08a515c@linaro.org>
In-Reply-To: <20260402-aarch64-tcg-instruction-format-rename2-v1-0-0998a08a515c@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These are not formats in themselves, but extra constants to OR in with
the existing ldst_imm format.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 64 ++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 23d96a7960..cc9c2a5158 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -458,8 +458,9 @@ typedef enum {
     Ildst_imm_LDRVQ  = 0x3c000000 | 3 << 22 | 0 << 30,
     Ildst_imm_STRVQ  = 0x3c000000 | 2 << 22 | 0 << 30,
 
-    Ildst_imm_TO_I3310 = 0x00200800,
-    Ildst_imm_TO_I3313 = 0x01000000,
+    /* Additions to the ldst_imm format */
+    ldst_imm_to_reg  = 0x00200800,
+    ldst_imm_to_uimm = 0x01000000,
 
     /* Load/store register pair instructions.  */
     Ildstpair_LDP    = 0x28400000,
@@ -880,13 +881,13 @@ static void tcg_out_insn_qrr_e(TCGContext *s, AArch64Insn insn, bool q,
               | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3310(TCGContext *s, AArch64Insn insn,
-                              TCGReg rd, TCGReg base, TCGType ext,
-                              TCGReg regoff)
+static void tcg_out_insn_ldst_reg(TCGContext *s, AArch64Insn insn,
+                                  TCGReg rd, TCGReg base, TCGType ext,
+                                  TCGReg regoff)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | Ildst_imm_TO_I3310 | regoff << 16 |
-              0x4000 | ext << 13 | base << 5 | (rd & 0x1f));
+    tcg_out32(s, insn | ldst_imm_to_reg | regoff << 16 | 0x4000 | ext << 13 |
+              base << 5 | (rd & 0x1f));
 }
 
 static void tcg_out_insn_ldst_imm(TCGContext *s, AArch64Insn insn,
@@ -895,11 +896,11 @@ static void tcg_out_insn_ldst_imm(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | (offset & 0x1ff) << 12 | rn << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3313(TCGContext *s, AArch64Insn insn,
-                              TCGReg rd, TCGReg rn, uintptr_t scaled_uimm)
+static void tcg_out_insn_ldst_uimm(TCGContext *s, AArch64Insn insn,
+                                   TCGReg rd, TCGReg rn, uintptr_t scaled_uimm)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | Ildst_imm_TO_I3313 | scaled_uimm << 10
+    tcg_out32(s, insn | ldst_imm_to_uimm | scaled_uimm << 10
               | rn << 5 | (rd & 0x1f));
 }
 
@@ -1203,9 +1204,6 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
     g_assert_not_reached();
 }
 
-/* Define something more legible for general use.  */
-#define tcg_out_ldst_r  tcg_out_insn_3310
-
 static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
                          TCGReg rn, intptr_t offset, int lgsize)
 {
@@ -1214,7 +1212,7 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
     if (offset >= 0 && !(offset & ((1 << lgsize) - 1))) {
         uintptr_t scaled_uimm = offset >> lgsize;
         if (scaled_uimm <= 0xfff) {
-            tcg_out_insn_3313(s, insn, rd, rn, scaled_uimm);
+            tcg_out_insn_ldst_uimm(s, insn, rd, rn, scaled_uimm);
             return;
         }
     }
@@ -1227,7 +1225,7 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
 
     /* Worst-case scenario, move offset to temp register, use reg offset.  */
     tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, offset);
-    tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
+    tcg_out_insn_ldst_reg(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1764,28 +1762,32 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp memop, TCGType ext,
 {
     switch (memop & MO_SSIZE) {
     case MO_UB:
-        tcg_out_ldst_r(s, Ildst_imm_LDRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRB, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_SB:
-        tcg_out_ldst_r(s, ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
-                       data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
+                              data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UW:
-        tcg_out_ldst_r(s, Ildst_imm_LDRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRH, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     case MO_SW:
-        tcg_out_ldst_r(s, (ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW),
-                       data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW,
+                              data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UL:
-        tcg_out_ldst_r(s, Ildst_imm_LDRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRW, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     case MO_SL:
-        tcg_out_ldst_r(s, Ildst_imm_LDRSWX, data_r, h.base, h.index_ext,
-                       h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRSWX, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     case MO_UQ:
-        tcg_out_ldst_r(s, Ildst_imm_LDRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRX, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     default:
         g_assert_not_reached();
@@ -1797,16 +1799,20 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
 {
     switch (memop & MO_SIZE) {
     case MO_8:
-        tcg_out_ldst_r(s, Ildst_imm_STRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRB, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_16:
-        tcg_out_ldst_r(s, Ildst_imm_STRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRH, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_32:
-        tcg_out_ldst_r(s, Ildst_imm_STRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRW, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_64:
-        tcg_out_ldst_r(s, Ildst_imm_STRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRX, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     default:
         g_assert_not_reached();

-- 
2.43.0


