Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A5DC7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83k-0007Qh-2G; Sat, 21 Jun 2025 19:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82Y-0002sB-GQ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82W-0005DQ-8a
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so1131431b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550067; x=1751154867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ReJE6sc+sqJ4JcFa4T3heXIPt1Xzh2kVBdFGutG0RU0=;
 b=i6P3FV2V3DrgqjD1YmilYqPjMirWYr0790p7+VspUdkNSyNcb7uaVctsfYYJaowuCj
 7XRQJKFOASDz0XugLOO9xH6NAFiwOdtL5LS8TXLvlAuJma8t1/G5Fxmnyxs0S/TF5VRq
 sv25+RI8TIjciaGienzFqgB+gDc4OefzkXDgdSScD83jMkMtNjt9FlncNEhvz0UBURgJ
 UNKxyj1d14NO/hVDbB+MK/CsttzDm0C3n3/BEo6jly4NH2qaYenyHDXr7lhaRV8HnviG
 32VisYNgXj+zqVLPClrrvRaY8Bhkk1BEjebRMITL7ovcLB+O6pr1p2C3PVmKnmVEiVi+
 /KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550067; x=1751154867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReJE6sc+sqJ4JcFa4T3heXIPt1Xzh2kVBdFGutG0RU0=;
 b=iX8q1YZlCB9ZjDJfSrAZAEaPiO17O8NU3jHjCdzFHVgKa7ZG+gOlDfCge1jJvVEx3J
 kU8Adhrwv3tX7DyeqDKT0jti7nkbL31ekCF4/LYXPLjUM517kbpPMv5Y8avqJThBEYF1
 gClOzauY2kFdL82BSkz2S/vhOH1fd1qxBp/BYbpGSZ0fiZjEStSVPv3pTvNatyArl5aU
 re3jUMhI34iKISHzI0ZIw7VeK7EkoQO3egNXzjpkavSX0c4vtAxTxKkASr2DNz1hc2N6
 AhDnyBMCDdLb07RoeroyvYMsoWkhXHfRQfkufmaVAUfaGQF62LEzpCCVJvfIETnBG5ho
 GkNA==
X-Gm-Message-State: AOJu0YzrR2wzSmB2oboa+JnS3xe6tHzICPstZUqqHXWMPnFcgQ5ZCRKZ
 oNRfo+cZTQoYb8hikMpmCgcAWC1WfZsHAj8yUkX1s1/NUzw8UiiVU5YwlMXdxj+ZGKabDl+PR7G
 pAU41pu8=
X-Gm-Gg: ASbGncsadhV87TCkYfUMGoX9hsBjso2/Zp90C3ySsHQJlqN94tsiArCQfqLwCQAMT1k
 4tp+Yw6pwV1On7zf5QIN87tuWGiBfi4rlA8g/yz/Whb5F1yaGKV05ZHo1opbRnIMms00SLj1g/A
 IAW6bx86Uo9cUN7LVNVMCEAfIVUa77GiidfCTn0m6hhuL9FAFq2W9XVa0TN5HIYSAeYt8BhHVRl
 eaHtBYAcbFy3lR22Xk9mzufS4azRxhJnVS3EGGk/e0DpPLi/M450UzQkKMJ7P9Ogf6OcwEEPXmQ
 bJu/mzkESif9U17OR+nydaxm9mHbtlcU5ZXYNCtvdYgS92Ddw5VukKe8tLenUxi0t1WCw8nmIrr
 qXoTTHlc/yLcbhI+0l3pM
X-Google-Smtp-Source: AGHT+IEt1JGUi2ArtkCwlj3+Z6KIRU7l/oNurw/JQk+YPb+BB2f3ea+Vg9Qjmg/v7ogn+fjnTFVr4Q==
X-Received: by 2002:a05:6a20:938a:b0:215:e1cc:6360 with SMTP id
 adf61e73a8af0-22026e926d0mr11100981637.11.1750550066734; 
 Sat, 21 Jun 2025 16:54:26 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 075/101] target/arm: Split trans_WHILE to lt and gt
Date: Sat, 21 Jun 2025 16:50:11 -0700
Message-ID: <20250621235037.74091-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Use TRANS_FEAT to select the correct predicate.
Pass the helper and a boolean to do_WHILE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 23 +++++++++--------------
 target/arm/tcg/sve.decode      |  4 +++-
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5e747b1424..9a6fa8ee8a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3091,7 +3091,8 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
     return true;
 }
 
-static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
+typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
+static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3101,14 +3102,8 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     TCGCond cond;
     uint64_t maxval;
     /* Note that GE/HS has a->eq == 0 and GT/HI has a->eq == 1. */
-    bool eq = a->eq == a->lt;
+    bool eq = a->eq == lt;
 
-    /* The greater-than conditions are all SVE2. */
-    if (a->lt
-        ? !dc_isar_feature(aa64_sve, s)
-        : !dc_isar_feature(aa64_sve2, s)) {
-        return false;
-    }
     if (!sve_access_check(s)) {
         return true;
     }
@@ -3132,7 +3127,7 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
-    if (a->lt) {
+    if (lt) {
         tcg_gen_sub_i64(t0, op1, op0);
         if (a->u) {
             maxval = a->sf ? UINT64_MAX : UINT32_MAX;
@@ -3187,15 +3182,15 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(ptr, tcg_env, pred_full_reg_offset(s, a->rd));
 
-    if (a->lt) {
-        gen_helper_sve_whilel(t2, ptr, t2, tcg_constant_i32(desc));
-    } else {
-        gen_helper_sve_whileg(t2, ptr, t2, tcg_constant_i32(desc));
-    }
+    fn(t2, ptr, t2, tcg_constant_i32(desc));
+
     do_pred_flags(t2);
     return true;
 }
 
+TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, gen_helper_sve_whilel)
+TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, gen_helper_sve_whileg)
+
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
     TCGv_i64 op0, op1, diff, t1, tmax;
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b0c7b58271..525c11f5d4 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -789,7 +789,9 @@ SINCDECP_z      00100101 .. 1010 d:1 u:1 10000 00 .... .....    @incdec2_pred
 CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 
 # SVE integer compare scalar count and limit
-WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
+&while          esz rd rn rm sf u eq
+WHILE_lt        00100101 esz:2 1 rm:5 000 sf:1 u:1 1 rn:5 eq:1 rd:4  &while
+WHILE_gt        00100101 esz:2 1 rm:5 000 sf:1 u:1 0 rn:5 eq:1 rd:4  &while
 
 # SVE2 pointer conflict compare
 WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
-- 
2.43.0


