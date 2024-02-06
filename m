Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E031AC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmU-0006uH-4F; Mon, 05 Feb 2024 22:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmS-0006sp-Vw
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:53 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmQ-0003JU-4n
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:52 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-595d24ad466so3189833eaf.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188746; x=1707793546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yC+4P563DsZNTw7wqbYKpYbLga9F+4Wqkz2IWu6n9xI=;
 b=gFQYlEUPshr90p4OKmJo83C8pc60irNBVtFRAtgWlzFuk7FgfBk+ugu/Vqq+wg0NI4
 acCs/W0vaaYi4iNE3RgfZQeLnR+uRbjdJPwKCa2YKQuRHP55XdN7IXcB0HAgDMHBFmH0
 xIsYDMeJTPn59yduJ5gGk/8gWnUsgyTqcs0L4M4vATrVeGeY/m3qm2xmC+/JTzzntTJS
 ea+ASGQi3sNFakiyZtJlDEg+S8N5QuAQ+fvqMOa4851+z1aCxRsW4qIVzKzVPMBXYaNX
 hEGXtr4bEahUj9tYsSKFtFkZ+ySEySAYnpzYRKAAeNImJLfXbunfYFDvuFapFElKztzT
 xcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188746; x=1707793546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yC+4P563DsZNTw7wqbYKpYbLga9F+4Wqkz2IWu6n9xI=;
 b=j8zSJXfqysLuhjtxz/AEoLyyA5AHXkVH8481efKxFOGMdodofnSMT3IeFDEay9zR/7
 hxf/Gu68wPSvZ3/ymZI6pXepbZMvNSTOY40X6WLVAn7S+irVCw+TBO/nnHOQHrSWo73E
 rpk1hU3WPDn0uxd5BAUi3KF0Mqy61e77myb2RtvoRaE3kf++NBK+zAlfN1SbNAulBPsq
 g4q9csinvTo9s2SB6rvowukHNOS/dt15WRaPU0Z7ldAOOmv8n4QpqXKAACBbUnWb4vMj
 rquiL3X0HgwxeLos8p1eD+TA0qzHrrvkRHHA+iPHArPPqNH/o5rpaJO5DVg5VLrnPCYX
 D0jw==
X-Gm-Message-State: AOJu0YxHqPjfdIQr0+MQ/FiDDlT0664xwhLCyDGmRGQwIDkOHRD6TyQu
 IL2art3A1v0WMl+fj9PEwPu6mwSNyjxod8Y85jrP2c7wiRfTVmk9PR0X7LZbxDYjHI0QSgbOMNG
 OfVA=
X-Google-Smtp-Source: AGHT+IF0OIAGKz9o8ja8qRyGGavDa+A2cpB2SbuxjzlVWVdXbXNGwiotkzBnv6rHsg9VgdYSG6LA6Q==
X-Received: by 2002:a05:6358:6f9e:b0:178:7542:1a58 with SMTP id
 s30-20020a0563586f9e00b0017875421a58mr820386rwn.7.1707188746651; 
 Mon, 05 Feb 2024 19:05:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVupFAc3S9Ph9dOV598Sicdx/GHQn2Bi7SByxZ5wmF7/RWpd2Lrz5Q4r51TGWO8oq9ckccmN7vEhI/WzVKgFQDHK2KpvG4FKLZc
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 5/6] target/arm: Handle mte in do_ldrq, do_ldro
Date: Tue,  6 Feb 2024 13:05:26 +1000
Message-Id: <20240206030527.169147-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
References: <20240206030527.169147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

These functions "use the standard load helpers", but
fail to clean_data_tbi or populate mtedesc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8868aae5ac..fb3bcb47f6 100644
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


