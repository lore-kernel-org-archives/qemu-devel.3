Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4F7EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmB-0003m3-4a; Wed, 11 Sep 2024 22:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm4-0003L1-LT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm2-0004DV-Su
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20570b42f24so5562625ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108893; x=1726713693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnCv64h+Jeh9/RoiV0zaMJCTxvJV9tTWODBEEi7v64Q=;
 b=gK4/3lpBqAVlbidXDn6a7Jsc7MDNHfcV4fTTsTCZRaUbBUqVZ+3QSX4PoEdk4dVYqY
 86jRQiNTzko2bMypTPXA/1bBShATdWgVUQOSr8PabiVx2cLnhF4NPUwpMDRO3vW10l9I
 GslLBdWu3/5RLAT3j+m44m080qRfkgpomLaKCgqlpDc4Mzog9HeqrhR5eZF02oNfQ2GY
 213naRGuOojDN8ddlSqALi2NZXnOL1XgfWfoIc2tk0VYeD83FCyckLUXurBifZ1/Ohr5
 9l8+E/lH08n5jas0tcE+0nOACVqzEqQhvfmPKyY2YYlSfyXLCigSvQBUgaGHxgM6gg5/
 tq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108893; x=1726713693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnCv64h+Jeh9/RoiV0zaMJCTxvJV9tTWODBEEi7v64Q=;
 b=rVEfU8QIGbl8PbrzJfgLrJAfO9yPE6FU+cRyaUeFzkugU/aWIvmSgiRsRwnpyeSDeg
 LsfjKVS3Ni45uJq+aPSMNi3uAsH2VNKr8GaR+FjJx+qYIZynt1g4jjol58PRhLkYua7t
 +MAKqmDw7nBWDjlCAGMZKvCrV8VgKOKp7sZWjqenpED8H6NUQjsHDqWavMTNy3eHZP0N
 KxGWkp2BdEoSTnw0d3MTNMyEWatbkcH+sapA1fa4LKOvHpA+fbj35XEMHzDAp8Ao8LBP
 QrZd+Jx8d9HoUWuilE/nlRyzJmNhN+wdKwz5/CNP2PulYoBnicRFLMCG5w95iFbf5RDc
 Nkrg==
X-Gm-Message-State: AOJu0YyG6/LP7l/X0E6IQZ2k5/OQPll4G0PJFoNpQ3fVLFiDH9DWfCdj
 l1JrTTj2R0z5esjUtqZ4LZHKdRKlFxpLp3ON5xJW2LeIfLX6ByS6h9LBsVPD0VcL2UcbHAYJyLN
 J
X-Google-Smtp-Source: AGHT+IE2E7sOe0l0wA0HxiCo0k9iZ3vm092Pz57XY/UQNuj1YxK0fXwE2+qx4KN9R+geBqnHHbIXLA==
X-Received: by 2002:a17:902:ce81:b0:205:7b04:ddf2 with SMTP id
 d9443c01a7336-2076e37ac7cmr20081255ad.29.1726108893503; 
 Wed, 11 Sep 2024 19:41:33 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 19/29] target/arm: Convert SSHLL, USHLL to decodetree
Date: Wed, 11 Sep 2024 19:41:04 -0700
Message-ID: <20240912024114.1097832-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 81 ++++++++++++++++------------------
 target/arm/tcg/a64.decode      |  8 ++++
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 740620074a..e00d7fbf48 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6983,6 +6983,42 @@ TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
 TRANS(SHL_v, do_vec_shift_imm, a, tcg_gen_gvec_shli)
 TRANS(SLI_v, do_vec_shift_imm, a, gen_gvec_sli);
 
+static bool do_vec_shift_imm_wide(DisasContext *s, arg_qrri_e *a, bool is_u)
+{
+    TCGv_i64 tcg_rn, tcg_rd;
+    int esz = a->esz;
+    int esize;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * For the LL variants the store is larger than the load,
+     * so if rd == rn we would overwrite parts of our input.
+     * So load everything right now and use shifts in the main loop.
+     */
+    tcg_rd = tcg_temp_new_i64();
+    tcg_rn = tcg_temp_new_i64();
+    read_vec_element(s, tcg_rn, a->rn, a->q, MO_64);
+
+    esize = 8 << esz;
+    for (int i = 0, elements = 8 >> esz; i < elements; i++) {
+        if (is_u) {
+            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        } else {
+            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        }
+        tcg_gen_shli_i64(tcg_rd, tcg_rd, a->imm);
+        write_vec_element(s, tcg_rd, a->rd, i, esz + 1);
+    }
+    clear_vec_high(s, true, a->rd);
+    return true;
+}
+
+TRANS(SSHLL_v, do_vec_shift_imm_wide, a, false)
+TRANS(USHLL_v, do_vec_shift_imm_wide, a, true)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10447,47 +10483,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* USHLL/SHLL - Vector shift left with widening */
-static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = immhb - (8 << size);
-    int dsize = 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    TCGv_i64 tcg_rn = tcg_temp_new_i64();
-    TCGv_i64 tcg_rd = tcg_temp_new_i64();
-    int i;
-
-    if (size >= 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    /* For the LL variants the store is larger than the load,
-     * so if rd == rn we would overwrite parts of our input.
-     * So load everything right now and use shifts in the main loop.
-     */
-    read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
-
-    for (i = 0; i < elements; i++) {
-        if (is_u) {
-            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
-        } else {
-            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
-        }
-        tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
-        write_vec_element(s, tcg_rd, rd, i, size + 1);
-    }
-    clear_vec_high(s, true, rd);
-}
-
 /* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
 static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10577,9 +10572,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_vec_simd_sqshrn(s, false, is_q, is_u, is_u, immh, immb,
                                opcode, rn, rd);
         break;
-    case 0x14: /* SSHLL / USHLL */
-        handle_vec_simd_wshli(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x1c: /* SCVTF / UCVTF */
         handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
                                      opcode, rn, rd);
@@ -10604,6 +10596,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
     case 0x08: /* SRI */
     case 0x0a: /* SHL / SLI */
+    case 0x14: /* SSHLL / USHLL */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 77b860a3f2..bf67f8a357 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1269,3 +1269,11 @@ SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_b
 SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_h
 SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_s
 SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_d
+
+SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_b
+SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_h
+SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_s
+
+USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_b
+USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_h
+USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_s
-- 
2.43.0


