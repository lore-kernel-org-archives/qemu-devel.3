Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C267CC48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXY3H-0003JF-Es; Tue, 06 Feb 2024 21:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY3G-0003IS-EU
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:42 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY3D-0000ha-RK
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:42 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so139428b3a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274358; x=1707879158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE5lr6JW9Hb5FNHnTu7wAvaaKUMTGQjD484Q9RZmfv8=;
 b=I8QxszfuWmxyGn0hZWzeGy85VONnNye4JIqdywAaElbsgR2Idyr8gYcLHVxs/R32+W
 n95TTBG7dw07XDvk0QqASut/HpE9l2+agw8i6RTMES65oxEbF5vTOwFzr9U/78sqSlf9
 elVQkqr3ZEcSQFNUcBocNF4FW8jE9zQ4EGiqFtI4gL00hLntFYextaldrukXd/EucxyK
 wnW8itDVI7IX+SkWaFpS/gwMnf+YSIu2CUK1h7nKa6rag9/8qeQbyNvdeB7w7jk8ET51
 IXQye4f58BJ73wu72dJkluqtt9K2Mlry9cRUbCfKULHj3SI3rf0Dq9XTbGhMyn7t6JAt
 u3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274358; x=1707879158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE5lr6JW9Hb5FNHnTu7wAvaaKUMTGQjD484Q9RZmfv8=;
 b=EG5mqtSpa7GGPIudEiSPaVRWOJ1u4DpO3suSYbm6dN0RTl1e+Dzw4/rmJcTsyS73aA
 DUIEv5YVfLZHpyZa/JXbjmpktUPzG7EOt14skfRoBLeqNi+JGaH6K3NO+q2P4f0h4JC5
 EJ1mzEKnKcXQ3tfZhlO4e91ndlpJ1Tk3mhmbyqxkj0hgwJ4twMShRvximmQ1VqT6bA+Z
 vABYsgIPijue81hGmACkovVIXdiyqr7dU7ik9nPLzpKkgDcfuJ9l03y2nsgkQHirmRli
 L1+WB72gpbnm6sFXJ8lBKqKFtBa4RACqJsPYKAtwqGOq360ag33F3jpI3i77oo0X69/F
 1N8A==
X-Gm-Message-State: AOJu0Yx7u6IVe5KpT3mGYB9BYXz18je0Eh4R581yT8N1mTugP9+igjYs
 n7XqVyVzhZcq2/tahOir46py8FGJvWykZUKw6cg3sxTQ8ZRLFqGRQJ22rfbl3JI/uwcNgnb7lKm
 vZX0=
X-Google-Smtp-Source: AGHT+IFCXYj8nwBT2ww/xlVOkZhFqNRzZZNbFtQxvUsb86YTTRM51XXapOzecMBEXzjPLjRPqcztgQ==
X-Received: by 2002:a05:6a21:6d98:b0:19a:4418:1e86 with SMTP id
 wl24-20020a056a216d9800b0019a44181e86mr4262411pzb.58.1707274358277; 
 Tue, 06 Feb 2024 18:52:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxqpYzYGjo+qKTG+7sZrr7d1XLfgwzefc4tUX9Y+WpenNlHz3T25lp7BrCdXss/0h71Zg3lF/phF+vbpB+WR1JQF+QkG8AKeRkfgi3UBZT/DrqOezu+fKuQvQgLiP4IcnG6WIpmZPbGJOnGPYGZWcvikkTmA9xjpFksFI=
Received: from stoup.. (60-242-98-186.static.tpgi.com.au. [60.242.98.186])
 by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d8ef97de4asm255435plb.38.2024.02.06.18.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:52:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 5/6] target/arm: Handle mte in do_ldrq, do_ldro
Date: Wed,  7 Feb 2024 12:52:09 +1000
Message-Id: <20240207025210.8837-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
References: <20240207025210.8837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 508f7b6bbd..ada05aa530 100644
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


