Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2DDCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95lA-0007gx-I5; Wed, 15 Oct 2025 13:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95l8-0007gb-SZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95l3-0005VV-4f
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so5452595e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551065; x=1761155865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTsaST6lePmYx1qPUDkEPn28HRnlM7KXopVayGlL5c0=;
 b=T0eTVrbsWuLesEnajo3qYgaa0KKQ8X/jR3KfjxbkthTVgTuwcUizDz49JJ+GMMNxac
 y1Bs1OwkWRU457L7MBEdFjxCICD9spuGyc0Z+eDkubOWbu1nNpojZYJL35umU63p2NGL
 ld5sSPP/4NdFuFGPf/etWVoAlowBJE0rUP73Rl2pUT7ymaC1SqMvL0mEHOyLHAz/NAaE
 Ut8dMO0OG+HocVpixoIxV7Cit2fsaF5OmhHRBlrclK7knxoUCN1gVC/HdYDqakdS+rVV
 OtcFGxxY4hXvmNKXI0/EAo7lnRL3zNrNdkJ7qy4lne6t8If1CagMOqa8OkN3LthTrln6
 lfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551065; x=1761155865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTsaST6lePmYx1qPUDkEPn28HRnlM7KXopVayGlL5c0=;
 b=wCYJMK3KWULy/r1I9x35+Eri8Lz5Wbd7Rt1/M/Kn4BKmNtFS3/6fMSMiisfxnk3g7l
 WgpRAODglg1FEwpX7xLNdLUMkM2rKPfrgkADQtxe3xHgyDIYeTik/5GHd1+6lYO9NiOv
 hup3GNy91Z4jC9GvxS1SoXx+OS5OyDTby1dgJiNczUKMHz7bxcvFRydKhQzqskCBQfgv
 RbeXdeWb2FMEhJphk9h2vdQalEkBKwXcnid+EEvm4IlPZyDiwNjHGo99qgMwFhx7boNg
 /u5Fg4PR+rRdh8fkQhpaWcVumCv0h2kFCC32OSyiOJwpfTW9ykellox/q3WDQYMZJ7rm
 EfGg==
X-Gm-Message-State: AOJu0YyRe/1vkgoJGrVaXkyKIvGkzRerX3pX/q8D3KM42AvjQZMEOMcZ
 D0VIbbofjjNe3HPUHAr5kmn0PKY5SyXfMKgS1GO8ATr6uHpi4fQWqF37Jxs5GEt+usGx8uuib9z
 0ukZvCzzu3g==
X-Gm-Gg: ASbGncuxdPN7ih9H6z7EYB1+0uCFg4vJ/r1mItKxnQElGAV+F3qhch2eElGlk7bCcvC
 xfywJw7MF1Bt2KTic1jBcDxtQn0b/bOV6OAkUMjrH9aOQJURFTTQz4epTOB6VR1wNOxvdRg6nxu
 a1JiJ6YHwaLvWDXRKePKcv+0Vugw3EeFcmP/ams7qaesLU6aC9J1/3/Q3sSrUyh9RxVQ7GaYSPk
 FBFscDvmHJj0CadPgtFpEKHPwIz7RFrX+vivRZVzYqYknGWXoNTfcvg0h7K07cGn1b1zFi9zQL3
 sikYLRi76SBm2WZ7XnqR0jcu4/nJ/OQOKnxY7xRFsbd1dPSfZGmgVVi4FCWYE0+FPAbHM48cRkT
 7LiYRpH+14tDpxlArtdEhF5XRdWAx99rJ+c4Y3efdCloqSVRtALwLKGbK12LJGOBbuayil4ygqi
 7rbKkH2iG+BpZd6szHvEs=
X-Google-Smtp-Source: AGHT+IG1ziTPZvC4QhQI996xRwm3UmDe+i3bRjWF6FFzbesbyFHViH435V7K3jV9UyLADaplQEq6cg==
X-Received: by 2002:a05:6000:2509:b0:3ee:11d1:2a1e with SMTP id
 ffacd0b85a97d-426fb6a748bmr796908f8f.10.1760551065038; 
 Wed, 15 Oct 2025 10:57:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e50ef821sm16121119f8f.38.2025.10.15.10.57.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] target/microblaze: Have compute_ldst_addr_type[ab]
 return TCG_i32
Date: Wed, 15 Oct 2025 19:57:15 +0200
Message-ID: <20251015175717.93945-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Both compute_ldst_addr_typea() and compute_ldst_addr_typeb()
bodies use a TCG_i32, so return the same type.

Suggested-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index bc38ff0af92..002f921e00f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -604,7 +604,7 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
 DO_TYPEA(xor, false, tcg_gen_xor_i32)
 DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
-static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
+static TCG_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
     TCG_i32 ret;
 
@@ -626,7 +626,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
     return ret;
 }
 
-static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
+static TCG_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
     TCG_i32 ret;
 
@@ -750,13 +750,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
 static bool trans_lbu(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_lbur(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
 }
 
@@ -776,19 +776,19 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCG_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
@@ -810,19 +810,19 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCG_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
@@ -844,16 +844,16 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCG_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
 
     /* lwx does not throw unaligned access errors, so force alignment */
-    tcg_gen_andi_tl(addr, addr, ~3);
+    tcg_gen_andi_i32(addr, addr, ~3);
 
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
                         mo_endian(dc) | MO_UL);
@@ -910,13 +910,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
 static bool trans_sb(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_sbr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
 }
 
@@ -936,19 +936,19 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCG_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
@@ -970,19 +970,19 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCG_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
@@ -1004,19 +1004,19 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCG_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCG_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     TCGLabel *swx_done = gen_new_label();
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
 
     /* swx does not throw unaligned access errors, so force alignment */
-    tcg_gen_andi_tl(addr, addr, ~3);
+    tcg_gen_andi_i32(addr, addr, ~3);
 
     /*
      * Compare the address vs the one we used during lwx.
-- 
2.51.0


