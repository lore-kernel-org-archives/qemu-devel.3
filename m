Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B81C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFR-0004Vw-Gh; Fri, 04 Jul 2025 12:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF8-0002a7-Ej
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF6-0006qn-Lk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453066fad06so7827195e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646386; x=1752251186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqlZAnmBIz+XGT4xT8k9tvPtNPsv+Nb4Y93x1wUOMgw=;
 b=ENLX9GJ++w7cVDebm5LOz+anael4peV1aZdS27vbKd+tKAf2GwxkRUFTCs5eiQSLWr
 kz2g77jiQRZPLmCUHao6Rmnnir9BFGr+VswNzGY6CfYpzoFbGk3sSoJ3tak5HuRBY6hQ
 iuzVPUy8ryAFH87OcPxNviaJCZgpvuMmp6IwOkB0sc42PFNQZmhsEKHOwbW0Nru0wveW
 G62d1y2HLM6x3pBi/XpDYflZjFEutApyhp+Py18rLJwn8zzVruxOp1TMfymy9P3+Bwwb
 QZuOp3JVPFecOSrEYYvr7mORu/6cH2m3Yljy4lZX8HcA4bDfMbGsB21wER6LLLu0Hvwf
 rifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646386; x=1752251186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqlZAnmBIz+XGT4xT8k9tvPtNPsv+Nb4Y93x1wUOMgw=;
 b=Dos3cOq1MDcEw1iX6nlTBXj5fs2h5g6ikVZZ0UKrdXQdPwcqK3wSarPRBqP6b0TcW3
 Og/MJwvi5/0Uprx9plabkN/iBv1jQONst5/1uuzy+qrUGQ1YJDcZ684xlYoAeEYAFCux
 8544VbEL93SgAcEjl1wr02Rl1JtTmzkatVjxjBUVO1QtWD4p4m+xYFyEzDulltAIn0DK
 FmfvTy7QmT9wxZXrDzZ+J2F/57+axmZkoFr1Ho1kUIV+5h7VXr545o3df0puCYk1OPwv
 I4101IBsIuwYKyR2TEEqiAwmmOlXBZ2CaqkdTdtweZUF8PTAw5YWCwNQOExtbkRULGJh
 KPHg==
X-Gm-Message-State: AOJu0YzvRJQRTL5P8G0ULU6EhyW2pmaqyHKEWD9FUeQa0HF7sJnO+XEx
 qB3Dapw9Thqp8TjU1kG88selcQNY0FHf6Ka9mHwCslbQxnpI8Pnm5y7z7lDE7Fljzjd2ApMKref
 8ds37
X-Gm-Gg: ASbGncsQU5YYJ7wxA44o5nAK9Swrvf8Q+DlrHGEVEc+KgfOdbsUiTok5mlLs8DQV69s
 3pFGfYLkM1yOCHIunQek/x4wxQwCNyKT0ZITdLPrmXe0QAmJF33f0tZk0rUMaJU8gnxCe8Qqrcd
 YVWkYoje6L+HP4tJcGqCzx1PLSJtVb7nQs4Wa6QM86tAw0LTB1gd4ZjnFdcFvNztK8DXPE0hp2L
 ol7Rhgwaz3bIuJAeFIMesCFuSSGjsN5C46PAVKvEG+q+UGJiWYdGR9p1QCTzE1s7wt5Md/SOAf6
 M4qj2kNyuDZvLJRU6cdfKdAwEH8r1DUbFK6DBg+2p1ZO+c6Nu0IJB3BlLaXDs16xTm13
X-Google-Smtp-Source: AGHT+IE5pQzB5tTjjppJiTPYYzEsMmzgfbczxp7QH34/KxpsRmeDKWPdxlGplYvBXVqlfI/0k7yo3w==
X-Received: by 2002:a05:600c:348d:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-454b3094853mr36137445e9.10.1751646385979; 
 Fri, 04 Jul 2025 09:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 087/119] target/arm: Move scale by esz into helper_sve_while*
Date: Fri,  4 Jul 2025 17:24:27 +0100
Message-ID: <20250704162501.249138-88-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Change the API to pass element count rather than bit count.
This will be helpful later for predicate as counter.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-76-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c    |  2 ++
 target/arm/tcg/translate-sve.c | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5e11e86e5e0..b8f3fbb816c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4133,6 +4133,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     uint64_t esz_mask = pred_esz_masks[esz];
     ARMPredicateReg *d = vd;
 
+    count <<= esz;
     memset(d, 0, sizeof(*d));
     do_whilel(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, false);
@@ -4165,6 +4166,7 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     uint64_t esz_mask = pred_esz_masks[esz];
     ARMPredicateReg *d = vd;
 
+    count <<= esz;
     memset(d, 0, sizeof(*d));
     do_whileg(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, true);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 210a029ab84..f74f2bb1b38 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3198,9 +3198,6 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, t0);
 
-    /* Scale elements to bits.  */
-    tcg_gen_shli_i32(t2, t2, a->esz);
-
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
 
@@ -3234,7 +3231,7 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     op0 = read_cpu_reg(s, a->rn, 1);
     op1 = read_cpu_reg(s, a->rm, 1);
 
-    tmax = tcg_constant_i64(vsz);
+    tmax = tcg_constant_i64(vsz >> a->esz);
     diff = tcg_temp_new_i64();
 
     if (a->rw) {
@@ -3244,15 +3241,15 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
         tcg_gen_sub_i64(diff, op0, op1);
         tcg_gen_sub_i64(t1, op1, op0);
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
+        /* Divide, rounding down, by ESIZE.  */
+        tcg_gen_shri_i64(diff, diff, a->esz);
         /* If op1 == op0, diff == 0, and the condition is always true. */
         tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
     } else {
         /* WHILEWR */
         tcg_gen_sub_i64(diff, op1, op0);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
+        /* Divide, rounding down, by ESIZE.  */
+        tcg_gen_shri_i64(diff, diff, a->esz);
         /* If op0 >= op1, diff <= 0, the condition is always true. */
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
     }
-- 
2.43.0


