Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE0B108E1FF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CFq-0000J0-E0; Thu, 19 Mar 2026 08:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w3CFo-0000I2-D5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:13:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w3CFj-00065V-8H
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:13:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so9687315e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773922404; x=1774527204; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hrTNnlv+Qesh+/MOn/n9/9dKMB5JdqsCHfK1xvrwPWU=;
 b=ZTocrx5rEJCVZeie377pCtkX7o81wMxVubK3k4eTBugJVHm7z1pJMiHxofwTKGW+Jj
 glLTxVno/XrsPJXp1/7LXt3decWiglyJXhzPx2tef2/B3uIt9jZJlOwN87Osvoa+Mlvy
 81GQFs1joBTxcNW8KUiuWD61RdP6OzUJHY9qzxpCONHT+Vabu1rclWh3EDWJkox/I70j
 qdceSWQHckT+HXfqEuMsoZJcQmXxh9tOpIYKHAclZnwTRuGiG6Ea9q4wZYtP7rMfXQug
 VHgHPgUpWEcbsUN+qpR0c3EwfyIM96jorjjb7tGtFKef+sZz/r1fvvSpyqCgvL9J2xfO
 G9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922404; x=1774527204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hrTNnlv+Qesh+/MOn/n9/9dKMB5JdqsCHfK1xvrwPWU=;
 b=nugNlsgumkwlA4iLHNtWNt3xWXUGbfrkSNmYr5zKeEylFqcVRJDp4m9fsCmuhqG0Fm
 7tNC5ODdpyCmrg2eGJWnqPYUuc/8XSnXaFV9hM+RGr/7rK3bJotP7d1wLECcBpPIaZtB
 b5sO9+9eMh4zJxmt/d6i1sQDjUg9mJX17/fHbDpMGiZJp02aUFrUmIBPAd1qZnm9if2u
 mlMot9bQisfhnCgXMho2eQS6FSBfPvaBMX5wQISw18h03AjindlU/lqxRQE3ofGDyvML
 2+va7a6ton3z7JpWlWFFs7JiWXLCiCpIDZauc1cwAKD2RVmGjttQ5ybKAu8XhT+tep3z
 SYSQ==
X-Gm-Message-State: AOJu0YzhkAP7FPXy1ejRp4iImDVgCIgls5s0RYHiOGlL6ygt8qg2It1x
 7QvPlr4MXSRYAjIb+0ITm3GElfrUzUp4IFC1XacsIcg8xTO4K5SgWR3pdb/TqVkucE970WCBFCc
 4ioUo
X-Gm-Gg: ATEYQzw9CK7AtclpTV6ql8u837TQrrRErAvZXDRsbe1kpMTkbHU83py7PytT5VAdY+F
 0tjRnHIVUPv7BntFMdp1JyN7u3kr7oiVhiqlPxaYuvvxtUPzIfQIZTREhzDfchTVGtpr230mjyv
 9Bgv/a+QiovuArYVukr3BBSN1hKtIXWplCUr4c5d4pyWnUBlMtPcP0HS4tNmn7/IcPFL1grtRm2
 iNZw76yXtW+G7rRX0bcNbUM28BESojelhjPL3G8+lRiKDvjh/qI9ovjtjYgcBe+U6mPrDvzJybA
 2XuKdUZuF6FNBQObLKwMeqIkhNsEyL355HAo8BwbmkQpLTSVvahaHpDp+hZpOkC93DJbHoWdtZQ
 CKH1hayIMO7Rq6p3QSVaG/6hV4444Xz3qcIDw53dieXgznNZ/PHxlPkJxaFJWrYfmiEmKI440mG
 VM67eylcpc0NBblMP5miY9KQnRv1E=
X-Received: by 2002:a05:600d:b:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-486fcc70e4bmr15156415e9.13.1773922403512; 
 Thu, 19 Mar 2026 05:13:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5dd6:71c1:29c2:4a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fd9575ffsm2456215e9.7.2026.03.19.05.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:13:23 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 19 Mar 2026 12:12:42 +0000
Subject: [PATCH RFC 2/2] tcg/aarch64/tcg-target.c.inc: Manual replace of
 I3310, I3313
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-aarch64-tcg-instruction-format-rename-v1-2-8a13bf98f8ff@linaro.org>
References: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
In-Reply-To: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x330.google.com
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
 tcg/aarch64/tcg-target.c.inc | 64 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index e9f86176d2..1f59d40a77 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -458,8 +458,9 @@ typedef enum {
     Ildst_imm_LDRVQ  = 0x3c000000 | 3 << 22 | 0 << 30,
     Ildst_imm_STRVQ  = 0x3c000000 | 2 << 22 | 0 << 30,
 
-    Ildst_imm_TO_I3310 = 0x00200800,
-    Ildst_imm_TO_I3313 = 0x01000000,
+    /* Additions to the ldst_imm format */
+    ldst_imm_to_sign_extend = 0x00200800,
+    ldst_imm_to_uimm        = 0x01000000,
 
     /* Load/store register pair instructions.  */
     Ildstpair_LDP    = 0x28400000,
@@ -880,12 +881,12 @@ static void tcg_out_insn_qrr_e(TCGContext *s, AArch64Insn insn, bool q,
               | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3310(TCGContext *s, AArch64Insn insn,
-                              TCGReg rd, TCGReg base, TCGType ext,
-                              TCGReg regoff)
+static void tcg_out_insn_ldst_sign_extend(TCGContext *s, AArch64Insn insn,
+                                          TCGReg rd, TCGReg base, TCGType ext,
+                                          TCGReg regoff)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | Ildst_imm_TO_I3310 | regoff << 16 |
+    tcg_out32(s, insn | ldst_imm_to_sign_extend | regoff << 16 |
               0x4000 | ext << 13 | base << 5 | (rd & 0x1f));
 }
 
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
+    tcg_out_insn_ldst_sign_extend(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1764,28 +1762,34 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp memop, TCGType ext,
 {
     switch (memop & MO_SSIZE) {
     case MO_UB:
-        tcg_out_ldst_r(s, Ildst_imm_LDRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_LDRB, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_SB:
-        tcg_out_ldst_r(s, ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
-                       data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s,
+                                      ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
+                                      data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UW:
-        tcg_out_ldst_r(s, Ildst_imm_LDRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_LDRH, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_SW:
-        tcg_out_ldst_r(s, (ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW),
-                       data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s,
+                                      ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW,
+                                      data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UL:
-        tcg_out_ldst_r(s, Ildst_imm_LDRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_LDRW, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_SL:
-        tcg_out_ldst_r(s, Ildst_imm_LDRSWX, data_r, h.base, h.index_ext,
-                       h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_LDRSWX, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_UQ:
-        tcg_out_ldst_r(s, Ildst_imm_LDRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_LDRX, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     default:
         g_assert_not_reached();
@@ -1797,16 +1801,20 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
 {
     switch (memop & MO_SIZE) {
     case MO_8:
-        tcg_out_ldst_r(s, Ildst_imm_STRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_STRB, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_16:
-        tcg_out_ldst_r(s, Ildst_imm_STRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_STRH, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_32:
-        tcg_out_ldst_r(s, Ildst_imm_STRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_STRW, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     case MO_64:
-        tcg_out_ldst_r(s, Ildst_imm_STRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_sign_extend(s, Ildst_imm_STRX, data_r, h.base,
+                                      h.index_ext, h.index);
         break;
     default:
         g_assert_not_reached();

-- 
2.43.0


