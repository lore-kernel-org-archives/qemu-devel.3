Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3400BC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffF-0001ur-Ue; Thu, 15 Feb 2024 12:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeE-0007vA-9L
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeB-0003ug-QE
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so614875f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018542; x=1708623342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TassmDQS2xUU17ReJTizyCAFvJvV6adrKf1jGt4S91Q=;
 b=aP1bQvU76DgjpXkuwASmRMv9AmvgmcFi5jV5g9wj8G09ZtoMZG8zYTgbR9M4zzNjuR
 KsgnjkE+/YJ4uZMLxJkgg6bErgZrGy0rPBvxDm4nzYGsFfuY3DM6gcdtWOvO9/7kBtOi
 pDcEjSkVLiawz7cTzxnYrhNio6ezNMWT9RvB7ruaBl+D9RThzRwq/NiI6MkVhQbWOi49
 9oOOnCUCk5BVc2Nq3YrqR8WAnIa8WSOaHm7rUbpDeadAfIBZBi3DJOpGNn4jqr6byHDb
 QND2fN/Rg1zrbieu4Dg5kWq7qC0yk4Rj88eZcZ9lxcZUSSb1fpeWt4CgJgILVHFCGwex
 yI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018542; x=1708623342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TassmDQS2xUU17ReJTizyCAFvJvV6adrKf1jGt4S91Q=;
 b=VHVNYK9tUYCsl3E71ZRt/lE65nisO+rGWG2MI/SK1fjtKgX2zqslVOpdDd7H7f1n7t
 nLE8V2L4b2qzL0uX2phs6aKEQt0U81Bk90xk82EMRESD3B8lM8tRYifoU+ZieOC7lb6Y
 4ipPWYD9xisxwSFWVm7FxwGUqlrK2vZBWWZTFnwxqfKXTQ53/oD23LUsKR2ke0rYVK5X
 2xHWpyO3rhNnveptILe4SxiVT8ZDOFuc+xo4jXrVId+r2orKZ+lEjBphITSDeX9NIn33
 rwV2fuNayNw052CA2OVcn6sAXugKWCkNMzzaxfv1PuLVX7H0ofh8x5uj//0zc8n29UAX
 Axwg==
X-Gm-Message-State: AOJu0YxK/8OZ9HuscH8OLVJAqqS5MuXPadiM7dAu5k9Y3L9vVX20iBtJ
 tpmlmwT1JVcbKd+9zHXetFVr/izWpS1t6X+btJbkcEeXkZpDMXd8lWfvCMtJ29E/CA5AnsVIImb
 6
X-Google-Smtp-Source: AGHT+IH2KdKYe4pEt2pLBe1KuN8io0GpojRcb65weaTjKoN+0lWeVyxbaLhl5xa/wL3tr6ZFK2wHXA==
X-Received: by 2002:adf:fd43:0:b0:33c:efad:c6a2 with SMTP id
 h3-20020adffd43000000b0033cefadc6a2mr1870678wrs.61.1708018542363; 
 Thu, 15 Feb 2024 09:35:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/35] target/arm: Handle mte in do_ldrq, do_ldro
Date: Thu, 15 Feb 2024 17:35:09 +0000
Message-Id: <20240215173538.2430599-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These functions "use the standard load helpers", but
fail to clean_data_tbi or populate mtedesc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 508f7b6bbdc..ada05aa5302 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4861,8 +4861,13 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
     int poff;
+    uint32_t desc;
 
     /* Load the first quadword using the normal predicated load helpers.  */
+    if (!s->mte_active[0]) {
+        addr = clean_data_tbi(s, addr);
+    }
+
     poff = pred_full_reg_offset(s, pg);
     if (vsz > 16) {
         /*
@@ -4886,7 +4891,8 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
 
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(simd_desc(16, 16, zt)));
+    desc = make_svemte_desc(s, 16, 1, dtype_msz(dtype), false, zt);
+    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc));
 
     /* Replicate that first quadword.  */
     if (vsz > 16) {
@@ -4929,6 +4935,7 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     unsigned vsz_r32;
     TCGv_ptr t_pg;
     int poff, doff;
+    uint32_t desc;
 
     if (vsz < 32) {
         /*
@@ -4941,6 +4948,9 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     }
 
     /* Load the first octaword using the normal predicated load helpers.  */
+    if (!s->mte_active[0]) {
+        addr = clean_data_tbi(s, addr);
+    }
 
     poff = pred_full_reg_offset(s, pg);
     if (vsz > 32) {
@@ -4965,7 +4975,8 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
 
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(simd_desc(32, 32, zt)));
+    desc = make_svemte_desc(s, 32, 1, dtype_msz(dtype), false, zt);
+    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc));
 
     /*
      * Replicate that first octaword.
-- 
2.34.1


