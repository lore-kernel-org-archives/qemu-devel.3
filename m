Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC534C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPx-0001Dn-6H; Tue, 25 Jun 2024 01:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPs-00018S-9o
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:28 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPo-0001YW-Sb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso4202573a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292103; x=1719896903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzQJhTxrVxQho+f1ZoeLagRwDrSdhan3/uqwSCOzuLg=;
 b=eMx5p1FkdfUK0ooxcJOnLXNTA5frU/R+LdQFgsvOeL2UioTdqyzbr8Kf2zbWNF1E2c
 gF96khzZFqKkxrlpOE1kNHLPdtJnnr7FpF8auwzqaZJGr6GyotxWWTf05LZG/eyuhwik
 GL35OfBB8zZ8k6RuPWP4392Yrr0J3ttyYdWHwD0if9dnOLIZCLF8qF3ArTgHW7Nspry4
 JtcsT/we8iUU1DMbVziX5daqyNej1/tr7nwHvHMOlkzQ0yHpBxGUA6pkNOw8agGC8K41
 XHkNkIXoir193FBXzQxBXk5Iq4X2Wx3vLd57GtW9Q9gHBGZBH2/fF5ZLREwACux8aAu/
 lckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292103; x=1719896903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzQJhTxrVxQho+f1ZoeLagRwDrSdhan3/uqwSCOzuLg=;
 b=lL94y+057jgkBNpLZJnJi2UnqaT4LMueqQBR3Zt37FK7sYpZU6Y2C/dJActmZBc2QN
 hFTXZEInJ14QiJ6zxFUUSrYMoNAqTgQCBgerrle2GtlFlFTznCTgT8dv+q76TECK2v3e
 NRVeVmxkt0U84owuVs0i7NqjUvBVFy/AxF8/y4XKC6RtW6YNZP78T4N5SU/L4EUKc6Y6
 8iy2P/sDJ6uEXIhZQgfiHo9olc0iZkTr6ahC+enuV8HGde/Niq9Cw7URjvVw3x/r+aVy
 wH8ovfiimWo5QzK5SPcqz/+YQkIUfj504UiqYDTMYYr7OvQ5z2yuAetnsQDSThILcBq7
 mR+w==
X-Gm-Message-State: AOJu0YxHbShGsGN3uZHuvxXrwn00+YSGxKi5NEHcJDZIwhqGD492kGF9
 VduzkqtZP3gUcFQmvxlCo8knNMRadJwT1tHPPToqdxr+3sN19QlZ5f4nP2I+TZfrPqRnNQlqi26
 j
X-Google-Smtp-Source: AGHT+IEb33Ce73fVkKGJpnHSJlzsgTzaKMNSsRuPUvKxdXUISxScG9PAUDcAaboOpg1QhzTUsvXlvQ==
X-Received: by 2002:a05:6a20:b289:b0:1bd:1048:164a with SMTP id
 adf61e73a8af0-1bd104819f3mr3460126637.26.1719292103390; 
 Mon, 24 Jun 2024 22:08:23 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/13] target/arm: Convert FCADD to decodetree
Date: Mon, 24 Jun 2024 22:08:08 -0700
Message-Id: <20240625050810.1475643-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 33 ++++++++++-----------------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b2c7e36969..f330919851 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -957,6 +957,9 @@ SMMLA           0100 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
 UMMLA           0110 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
 USMMLA          0100 1110 100 ..... 10101 1 ..... ..... @rrr_q1e0
 
+FCADD_90        0.10 1110 ..0 ..... 11100 1 ..... ..... @qrrr_e
+FCADD_270       0.10 1110 ..0 ..... 11110 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 57cdde008e..a1b338263f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5623,6 +5623,14 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const f_vector_fcadd[3] = {
+    gen_helper_gvec_fcaddh,
+    gen_helper_gvec_fcadds,
+    gen_helper_gvec_fcaddd,
+};
+TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0, f_vector_fcadd)
+TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1, f_vector_fcadd)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10957,8 +10965,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0x19: /* FCMLA, #90 */
     case 0x1a: /* FCMLA, #180 */
     case 0x1b: /* FCMLA, #270 */
-    case 0x1c: /* FCADD, #90 */
-    case 0x1e: /* FCADD, #270 */
         if (size == 0
             || (size == 1 && !dc_isar_feature(aa64_fp16, s))
             || (size == 3 && !is_q)) {
@@ -10976,7 +10982,9 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
     case 0x14: /* UMMLA */
+    case 0x1c: /* FCADD, #90 */
     case 0x1d: /* BFMMLA */
+    case 0x1e: /* FCADD, #270 */
     case 0x1f: /* BFDOT / BFMLAL */
         unallocated_encoding(s);
         return;
@@ -11013,27 +11021,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0xc: /* FCADD, #90 */
-    case 0xe: /* FCADD, #270 */
-        rot = extract32(opcode, 1, 1);
-        switch (size) {
-        case 1:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
-                              gen_helper_gvec_fcaddh);
-            break;
-        case 2:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
-                              gen_helper_gvec_fcadds);
-            break;
-        case 3:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
-                              gen_helper_gvec_fcaddd);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return;
-
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


