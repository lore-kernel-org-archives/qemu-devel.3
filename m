Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025D2C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwq9-0006An-AV; Wed, 02 Jul 2025 08:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjj-0004c8-Ny
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:54 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjZ-0002C3-AI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:50 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so2848446fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459916; x=1752064716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjp82vp6ijQJbUmrwBtHmhT7qLVtBn5OECQncgwB3SQ=;
 b=xblMqzfbMWFGzyF/LZS3gmyRTT//Jo2hmOAj3ukYzTPcNSqrURZd1F9xG8cDl53M/f
 1CvFww9QeE3YqPh85WMffbybClZy/cC3Zyw9wb3FOYcfnpJ1AI3ZupT3uRoeDCjQLIXD
 1pxXj2aeELUC64TrdHtRLOTmjdlKiT97xwGqCCX2LhpYprUvej6KKq60s8ZH1K8zOkGb
 IA0BFPA+Zqe+8gzAVXNWFjVvVMqu5CTki9994Eu2B2mTp+DWrTtPiOX8UPo+INe02eMH
 pmIFVPH8pHQ07b7tJehUElVe/ROspL5bg4UAnpqxLbnRg3SWeo6O4IGVJR3peFV3jizi
 r5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459916; x=1752064716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjp82vp6ijQJbUmrwBtHmhT7qLVtBn5OECQncgwB3SQ=;
 b=BCT2Yc2GX9ydFdYci1VqQUeRCvTBnm6smLt2jxeyKsPv+HVLddMn5OAoNdgVHHtSuC
 LZK466LdGP558Bb/KNoswHmOvj+l+dE5yl7XrbS6yjTe1nzh18jy4GZtz8Kii7xA+pyg
 FoXBF6+JYTese2fuV1F4G/Lb1e+DXM07Fl0Yj5sv6Vg2slh56Dc2AS3MfoK0K+/TgGgi
 Cy9OmJnH+/VPfsuDfPiUwfhs+Y7QOz8CSlOICLpN+DXjjkVwAzgue8LjsBepiM3Rneqd
 +13c83N45PF/9VDGH5SWJjRlpSqQvFch9LcDMkYPa5abZ0MYNJGvct58zE4psJquhwNP
 564A==
X-Gm-Message-State: AOJu0YxSf7Q8/mJBsOwVS7qdYXDlIcgyvV2zF8JF3w0W8dFRyIAnIuOK
 tN6YfGmbICT/DNfWpAf9AczrtZl42DJFFa8ZLd5nb7fG5XObspqNO3Xxx3JuUkK/QTXOFGmI0Ea
 DYmGLlsg=
X-Gm-Gg: ASbGncuLwwxNElmNqDOoqTCOWYKDEp/y7cpIck7/X9B3pVVPv3quUgrR9rcEREBXQBp
 ESbH6h/vCuhm/y0M5ImhUUXLCdpRnGMrrF1fBAWaEIUIfSqoqqxYjy3LCYzBx3eYiW6e7HKvCGH
 1mISlypV6Uznyu2St6oCTY0tb7wh7GMtFzaCCBmNaj4K+ZHyj9sLtMFqn71P2tVIPI4xv/ym6RH
 6fCZvKCz7thtrfUKchV64N4QttJnBNNgUAVSmsqXCGQ6m16NvTbuw+IkfkCMP9ktyB6mcxBvBJ3
 mwXhKxpP1LFxKCGr2P2nOMp/RJRIPgRY1p3qUh+ZdFKadSXcwvytlSiKuNBfWGqZTDXsZg==
X-Google-Smtp-Source: AGHT+IE/j1INRVUpnvsbMjXQJtSvw73Sz8BPjHPqc+UcBZBwwzMZh4nLLG+NnnxgajsOLHvcIouEDA==
X-Received: by 2002:a05:6870:ec87:b0:2c2:b85b:71ff with SMTP id
 586e51a60fabf-2f5a631ad1emr2063891fac.8.1751459916276; 
 Wed, 02 Jul 2025 05:38:36 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 65/97] target/arm: Split trans_WHILE to lt and gt
Date: Wed,  2 Jul 2025 06:33:38 -0600
Message-ID: <20250702123410.761208-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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


