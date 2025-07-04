Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85043C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWE-0006c5-0g; Fri, 04 Jul 2025 10:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMB-0004kh-G6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:45 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM6-0008CG-V6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:39 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6138aedd718so618965eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639133; x=1752243933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7M+33dd7YK/uBSmGNZCHalStsXI4uV+LuCtvO5Pet7E=;
 b=DRLddnaXf6O6pGQzYnx44GuO24vTu/HEopdw4VoHpvSWNhbOsKyT5VlWn4JvqQkSuG
 IECKROxasdSQG0uCKYR5mGeK2QRmpv47t343yleSkYFyfbGPTLl0GGwog3fJZKM+09jX
 6jx7oq2Zd+He07zHq8/+8QQVwRObFJJ65Dr1h/uzYqwvidk5/v2q2nGXBHe/ZyiiLb1O
 EsM1g1nbBprP3Uc+FKV2KoKcopoirmNdNAlRmELP8VxZ/VUey7VPwKElbUfQtyF4AGQJ
 D0EsO2oD3l72DNnblsnsnUqWEgvGbspmasUjhUvZ9R1C05DE+T4Lz5DI2UH5SoiFtDRF
 gI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639133; x=1752243933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7M+33dd7YK/uBSmGNZCHalStsXI4uV+LuCtvO5Pet7E=;
 b=enTZjAGtDKmSaypx+475OwRtDO4RhGNbLBe0swI9jaL6Ir0WUGV5mbkGpeqdKG2+5P
 beqSBYBqUpRDzBn7G+bTbtcHfkWiMfCqtMQ/hMNDXbz/9/osiE1xSu7bFIl7x78CuStu
 otjzu0EmoaGctxNuTk/DKwVMzKy1ljSA+Hy4/Lx4MFpJtOxg3mAKPrWG13cvVoqMd6bh
 C1V5Q/QlQ9j7T7ZOuAWoN2vxcjDj0NGW7qxYTIuXgrsE8mgr5MEbbRXqIacuxxnAZcDo
 UJuASvbdD96gBXDNO8W9NWP1RDLFdKH3bzFpPiY6DZ1sdjHwKOrpgGuVIAayTXLJTqDR
 TlfQ==
X-Gm-Message-State: AOJu0Yw3gGAHP7FEJIznx85zbL9ucRdUCPpRpr9YpgQcCkuXQRbXnKjD
 mqrzWnC9tdrHO8fIe2z4tynAHb/nfQqhc2uV6f4yPx2wFEZP5MpDq1Yh04LaCtbYVjIZ5aOr7A5
 UV3D5haA=
X-Gm-Gg: ASbGncu0B2Xj9kbDufkZnoLbcBMYqa1wP0DE+pQl4y4NM8Vni6qo1QmgoGCXZaBCezf
 Js7Ba0RGf8UG8e3OudlBI0k1aSsYo+j2qKa+zaOdcTgbQ5mgxy9fR2RxVJGe6wXpcT4s58dmoZr
 0/82GYd7a3VDIxqgBEAJowFKdzcoBfLw37DjzwjginyIvf4hlWtgBlLH9JhxhQftDOnE9Aanfv6
 sL3eC0vZ+0mSrulHjO3zVcYzLlKT5xwx4JmkNR0kdiicILpNGZh0FheMNA1niNaLxV12BWoXaDa
 dibe8MIzIVXe1wlt3Q1naI4A7XKrokzp9iV2Ycmn7ZQW/7bqXK33kmYUW/uqs//tm8KHKpduGkx
 fouOnWbRfzz3NwGQQAOTLp1lk0HfN+amOOI0uJHpy1KbwidSm
X-Google-Smtp-Source: AGHT+IGD6/BHqUwgmWL/ACbDchIYaMvz7/tPrSg3hlgX60DStktE+4C9s3SHs8/DYNXdL+BHlOhQRA==
X-Received: by 2002:a05:6820:4105:b0:611:758f:1fa4 with SMTP id
 006d021491bc7-6138e86217amr2380048eaf.0.1751639133498; 
 Fri, 04 Jul 2025 07:25:33 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 076/108] target/arm: Split trans_WHILE to lt and gt
Date: Fri,  4 Jul 2025 08:20:39 -0600
Message-ID: <20250704142112.1018902-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Use TRANS_FEAT to select the correct predicate.
Pass the helper and a boolean to do_WHILE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 23 +++++++++--------------
 target/arm/tcg/sve.decode      |  4 +++-
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f74f2bb1b3..62d3e2efd6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3108,7 +3108,8 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
     return true;
 }
 
-static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
+typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
+static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3118,14 +3119,8 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
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
@@ -3149,7 +3144,7 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
-    if (a->lt) {
+    if (lt) {
         tcg_gen_sub_i64(t0, op1, op0);
         if (a->u) {
             maxval = a->sf ? UINT64_MAX : UINT32_MAX;
@@ -3204,15 +3199,15 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
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
index dcfc40ef44..c90d975ebf 100644
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


