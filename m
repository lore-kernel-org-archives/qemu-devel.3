Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2ADC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UI-0004XT-H5; Tue, 28 May 2024 16:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3To-0003Du-1D
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:32 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TY-0003mG-BB
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-66afccbee0cso975656a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928275; x=1717533075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/fUH1nIEIiTlUGW6+zEiklWZ5Bx+BHRznTKcskzTrk=;
 b=ObY7DMnRlo3HsGap7fgRKzPvSt6qY7/Ju0UCi5Uiw9NUlre/uC3S1AWlPnKNK1bHvz
 M89/vtoIZaAXsrgMbfxjgSp9xFB5ZaNW0F7aC+bsF6jPPetjL56O574+4AxwguAYsPB7
 YiL3uCzqqwQvwXKPcDiKV9xcbjb9XviAaVJ1mTXhLJyBDVlSXBiM0d7Ws0lIIvU83MZe
 WuCqX84uJ5QJAhWXFp2gdKwplmt1StScPRYstbSx0G+8tBJ8x07aOx1IRBPHcfpMQMBQ
 afnH0J8y7dfMIrj1hpH6t4ds2J0kR+buPSQhdw8oniWu0QDBKCQl/cr5Fnz8WtIaVz6y
 f6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928275; x=1717533075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/fUH1nIEIiTlUGW6+zEiklWZ5Bx+BHRznTKcskzTrk=;
 b=J9WBhkAeQDVZ6aO6yLT5qCeIrVgTuf1ZZlwXzk2d6gSxhtPvUdtB5fTNz553vIc7Km
 VB2WoRN4BgA6yaZ7p7w4xv0PYczdtDEite9V7y3x4bG13dgK+DWrBSWSrqCOUKWg7zET
 BI1ZxwMElRJOG/zsFKtrM8TP83Vy+nuc7NdC1baPnn/yMHVH1Zl9SGKPwhdzFPYUUPH3
 WR7WC5J1612VrPZMEJ/nvCG2PFWM2Nx990zhyv45Ndj0yeMniw8JEJrSfI6Vpbk+b2qZ
 t4QyZqbqx/MnUO0vQeyft8ho/vVZMzWV860iG6KNfNGP07Pye6bu/EVFhOP0fLrBIXSV
 o8Tw==
X-Gm-Message-State: AOJu0YxZu/Ioy5rf3UCUGHQ1/nOQiunhPHfYz3SYPSzDzx7jF6TS4bbq
 FUSYIs2pmGoSlFWVfyqbwQ990pQG4UEHO62YqsTSCYBKy83HwUlvAvnTjMjWIIeldUbKYV0HD3b
 J
X-Google-Smtp-Source: AGHT+IFLx46q6Jkx0UwZt/nhupmKTVVww0NPzZ2yBIZaz3H2liBXrTvcN12EslnEYH3zIZJCIUf2Mw==
X-Received: by 2002:a05:6a20:2d0c:b0:1af:d04e:d06 with SMTP id
 adf61e73a8af0-1b212d3aba1mr15836671637.32.1716928275010; 
 Tue, 28 May 2024 13:31:15 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 33/33] target/arm: Convert FCSEL to decodetree
Date: Tue, 28 May 2024 13:30:44 -0700
Message-Id: <20240528203044.612851-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |   4 ++
 target/arm/tcg/translate-a64.c | 108 ++++++++++++++-------------------
 2 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6f6cd805b7..5dadbc74d7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1000,6 +1000,10 @@ SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
 SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
 SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
 
+# Floating-point conditional select
+
+FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
+
 # Floating-point data-processing (3 source)
 
 @rrrr_hsd       .... .... .. . rm:5  . ra:5  rn:5  rd:5     &rrrr_e esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 78a2e6d692..f1dea5834c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5866,6 +5866,50 @@ static bool trans_ADDP_s(DisasContext *s, arg_rr_e *a)
     return true;
 }
 
+/*
+ * Floating-point conditional select
+ */
+
+static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
+{
+    TCGv_i64 t_true, t_false;
+    DisasCompare64 c;
+
+    switch (a->esz) {
+    case MO_32:
+    case MO_64:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        return false;
+    }
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    /* Zero extend sreg & hreg inputs to 64 bits now.  */
+    t_true = tcg_temp_new_i64();
+    t_false = tcg_temp_new_i64();
+    read_vec_element(s, t_true, a->rn, 0, a->esz);
+    read_vec_element(s, t_false, a->rm, 0, a->esz);
+
+    a64_test_cc(&c, a->cond);
+    tcg_gen_movcond_i64(c.cond, t_true, c.value, tcg_constant_i64(0),
+                        t_true, t_false);
+
+    /*
+     * Note that sregs & hregs write back zeros to the high bits,
+     * and we've already done the zero-extension.
+     */
+    write_fp_dreg(s, a->rd, t_true);
+    return true;
+}
+
 /*
  * Floating-point data-processing (3 source)
  */
@@ -7332,68 +7376,6 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating point conditional select
- *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5 4    0
- * +---+---+---+-----------+------+---+------+------+-----+------+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 1 1 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+------+-----+------+------+
- */
-static void disas_fp_csel(DisasContext *s, uint32_t insn)
-{
-    unsigned int mos, type, rm, cond, rn, rd;
-    TCGv_i64 t_true, t_false;
-    DisasCompare64 c;
-    MemOp sz;
-
-    mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2);
-    rm = extract32(insn, 16, 5);
-    cond = extract32(insn, 12, 4);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-    if (mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        sz = MO_32;
-        break;
-    case 1:
-        sz = MO_64;
-        break;
-    case 3:
-        sz = MO_16;
-        if (dc_isar_feature(aa64_fp16, s)) {
-            break;
-        }
-        /* fallthru */
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    /* Zero extend sreg & hreg inputs to 64 bits now.  */
-    t_true = tcg_temp_new_i64();
-    t_false = tcg_temp_new_i64();
-    read_vec_element(s, t_true, rn, 0, sz);
-    read_vec_element(s, t_false, rm, 0, sz);
-
-    a64_test_cc(&c, cond);
-    tcg_gen_movcond_i64(c.cond, t_true, c.value, tcg_constant_i64(0),
-                        t_true, t_false);
-
-    /* Note that sregs & hregs write back zeros to the high bits,
-       and we've already done the zero-extension.  */
-    write_fp_dreg(s, rd, t_true);
-}
-
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8207,7 +8189,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
             break;
         case 3:
             /* Floating point conditional select */
-            disas_fp_csel(s, insn);
+            unallocated_encoding(s); /* in decodetree */
             break;
         case 0:
             switch (ctz32(extract32(insn, 12, 4))) {
-- 
2.34.1


