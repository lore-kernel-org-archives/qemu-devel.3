Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079B9D29FBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rFR-0005yN-S3; Wed, 06 Nov 2024 20:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFG-0005kO-Qy
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:35 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFD-0003B2-W8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so235405f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942610; x=1731547410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NCcHJoi8uwPYYIKuKRo8/qY4WRUa7npw8othDKETY4=;
 b=Onc+iqJre0hasKnan5X0/iXPcmP9F/RWQ38cBIbNNlS+qzY7myqfIznB+u/wbFfLBE
 szsyX9m/6olWeGrelhPD7RIASn4Jlo2yUXy+Ee0o50lcE6pt1ij6bZN/42jYHTXvwApd
 sh4B32HVYIJbrJmd5dlTVgRuqIftB4p6zBpS827xq2VRkNz8TaFVvQjMt2I8c5nAwsau
 Whzzm/1Or19XT3W9/uvEAc9UFOAojOheCiSs/OKPRsrflD/+lwHjLgSVaNjPmLC3iZ7g
 JVjKjtTa1pdRrks69qMWKu3SjIgM+DkZQ4T43paCMipHqVoJTVSGb+Nj8poHFKkFxfOV
 smPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942610; x=1731547410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NCcHJoi8uwPYYIKuKRo8/qY4WRUa7npw8othDKETY4=;
 b=eFfPBAdUmbndPmM7Bxkm8If8m+pG0B4ytFzbr05YIyYDm8vyi8/fjHjdshEOU2otO+
 yFPvp3PXLZ7ruPmck30KpFwBL3hwP6v/myg0budwujmoGG58zDyrFrVkCr03j7gUswUm
 CRnMYFfMCySKO+RqQrAII8Qq/yMIorb6h4oUkAKi+jRo6tPWtRNfwJ2QPisvyqlLs/8+
 SIk4ofhZvPo7LPKX7mxwpheHakqZ31T8xVtWBr8GslEQSAFsMt5X943iEAz7K9njF8Qa
 rIozEL1QhoJw4t6hK/uOjh/5oVkb8Z7js3sfXIuQCsTYwPcEM56pD68847XuwBV+QpZf
 wKnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQX2zQcKqZiLB6umVS8O+e1/pDkLomiEi/cxl1VFyhp+ISf0F4D1XcMzdv1CUp+HGpa16tRkNbIk3q@nongnu.org
X-Gm-Message-State: AOJu0YyfEtPPypaVIoPGuxtcuEOZQATiMOjo7lhYcHh9nsx+My55LbPQ
 P36w9fvuXJd5WQgcA/Cdt36CJ58OMiGUNUWml6s8IvEReYAb9F1ISnHOMM3G8d0aU+2SJvdqV9R
 N
X-Google-Smtp-Source: AGHT+IEvMktK+kKOZQMHqN9CCohRHUtBBCr0gtWEZlxMyC58YxfrC9OFRnDaaczYcvM947l6bnulSw==
X-Received: by 2002:a5d:6da2:0:b0:37d:4330:c87a with SMTP id
 ffacd0b85a97d-381ec724f22mr807047f8f.4.1730942610121; 
 Wed, 06 Nov 2024 17:23:30 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97ce1bsm242407f8f.36.2024.11.06.17.23.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 10/16] target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
Date: Thu,  7 Nov 2024 01:22:16 +0000
Message-ID: <20241107012223.94337-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
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

Extract the implicit MO_TE definition in order to replace
it by runtime variable in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/microblaze); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/microblaze/translate.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4beaf69e76..4c25b1e438 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -779,13 +779,13 @@ static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true);
 }
 
 static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
@@ -797,26 +797,26 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true);
 }
 
 static bool trans_lwea(DisasContext *dc, arg_typea *arg)
@@ -828,14 +828,14 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
@@ -845,7 +845,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TEUL);
+    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TE | MO_UL);
     tcg_gen_mov_tl(cpu_res_addr, addr);
 
     if (arg->rd) {
@@ -929,13 +929,13 @@ static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true);
 }
 
 static bool trans_shea(DisasContext *dc, arg_typea *arg)
@@ -947,26 +947,26 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true);
 }
 
 static bool trans_swea(DisasContext *dc, arg_typea *arg)
@@ -978,14 +978,14 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
@@ -1014,7 +1014,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
                                reg_for_write(dc, arg->rd),
-                               dc->mem_index, MO_TEUL);
+                               dc->mem_index, MO_TE | MO_UL);
 
     tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
 
-- 
2.45.2


