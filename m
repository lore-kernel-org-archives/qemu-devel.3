Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0525C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg092-0007Gk-W7; Thu, 06 Feb 2025 06:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08z-00079W-PH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:05 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08x-0000rs-O4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38daf09d37fso535497f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841642; x=1739446442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8KqGQ9zIkCuNT2EkzNy15iA5VEmYGDpqhCWVedzzZA=;
 b=cSeyUQQ7PSR+wMo7Br3l+eX49mosiN0SA2nnaoAv1QWBcjXI89+ACUDe0a4QuF9fzZ
 HhB3uYmOtdh6baG7A2rl4EJ8CF1/BPG6qsk7ehZ7axF1kQ7Itv4CWlwgovL2pCiZwb8p
 gU9jvCjLrjjc+NHmItd01fxJRyO2/eFYk7B+zc/2MOJ8qSZzsnh18O+2WT5wZaBG8Vp5
 tePOEQxpyZGSbaKQ1mO/pYNcNx2+6r44YoGGLQnQs4JytLaERnJeqYplLkDrZv+9GUi1
 +yhRnDn0nRhhAqhmM3ae0/oRSvlePTklYBfhiNiEn2dE2/oltr8mdkCiO1p1hy463Flu
 qdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841642; x=1739446442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8KqGQ9zIkCuNT2EkzNy15iA5VEmYGDpqhCWVedzzZA=;
 b=cX/M448POVdA8C79YPqJ4OibMnaC8zdkAuPv2q8hbWbFgkCtS7xqWr+Ic/CtUvSSEQ
 nrqjybpM9ITnC3rUcQ6iWrPdgixcx1yrulcaEhH2ukyv5EcZ+SAXBstxD0Lxag9DjUFB
 0YmCmyE2d4p6CedF+dy6xGM9kbEIYlC1D0CbR6qMOeMmWuiSq9PlSABxyK6gkL4mMIzC
 ADSnSBJaelR4HM+LkYMkbK+ErulBuEnvDOI0v7XIAXUZmpQ7w9ANF5s8q62N3CfNjUor
 Xr5GcAxa+XOZZWP8DfNZ+Pjr5nw9mesvSgfq7/A+68H77yPAPa3hVUoBSa8r8bs18lGC
 JWhA==
X-Gm-Message-State: AOJu0Yx/evPEUVs3+OGmOzCb5EprYrfJrjXTjZVUPgh5V8eDEJX/bngX
 tKq8w+qKV3JdwpoMIyDu/7psyFRdHjRHUqdkEnJzsvLcuY/Fvh6N+6+vnLUB86dviz1bSWrXyeo
 mENo=
X-Gm-Gg: ASbGncueVRcrMBbGYy+eiFxLULazjWKt5BZnuiQ1dD5Ju08o6UXD9UldRauEEcMAZnX
 rjPGqFS8rzkS3rV59Z/M/uZvvcPMT4Ir5YfDDQgJINFPoIDXWT7is2YGZNeFTojelMlrU2qRaS9
 rfELK8tm5OdlI0t+Zq/XHnsfeUANqa+xjFRss8qkc6gLtPZKu4xoS7Nd/1RoqFV+ytGa3XbLpKx
 dXOsTlMI/Ue9wttmpPBQBF/y1cI1pyfh9Vl5ntz263+QxFaE71h6EtquMB2l4XRSGF3VEb481wP
 plac0HOQxlmLq9e1MF8CV8ZpG/7gCaR0cYsmKd/YqAZJmzjb/Cif6xht+NCs8qL+JA==
X-Google-Smtp-Source: AGHT+IGt5KqoLM+xjICuDRWOrreel1COuBODY9pPEck2w+poe39108yGz+/q7uovzw7BlrHd3hnmQw==
X-Received: by 2002:a05:6000:1846:b0:38d:b6a9:2cd2 with SMTP id
 ffacd0b85a97d-38db6a9338amr4908499f8f.46.1738841641669; 
 Thu, 06 Feb 2025 03:34:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fb31sm1496293f8f.65.2025.02.06.03.34.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 08/16] target/microblaze: Set MO_TE once in do_load() /
 do_store()
Date: Thu,  6 Feb 2025 12:33:13 +0100
Message-ID: <20250206113321.94906-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

All callers of do_load() / do_store() set MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 86efabb83b5..0d51b2c468c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -713,6 +713,8 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
+
     /*
      * When doing reverse accesses we need to do two things.
      *
@@ -780,13 +782,13 @@ static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
 static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
@@ -798,26 +800,26 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, false);
+    return do_load(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
 static bool trans_lwea(DisasContext *dc, arg_typea *arg)
@@ -829,14 +831,14 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, false);
+    return do_load(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
@@ -863,6 +865,8 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
+
     /*
      * When doing reverse accesses we need to do two things.
      *
@@ -930,13 +934,13 @@ static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
 static bool trans_shea(DisasContext *dc, arg_typea *arg)
@@ -948,26 +952,26 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, false);
+    return do_store(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
 static bool trans_swea(DisasContext *dc, arg_typea *arg)
@@ -979,14 +983,14 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, false);
+    return do_store(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
-- 
2.47.1


