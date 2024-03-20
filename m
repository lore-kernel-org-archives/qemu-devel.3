Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A819EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzat-0003IT-Jy; Wed, 20 Mar 2024 13:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzar-0003H5-8k; Wed, 20 Mar 2024 13:19:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzao-0006dk-QT; Wed, 20 Mar 2024 13:19:12 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so2071153a12.1; 
 Wed, 20 Mar 2024 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710955148; x=1711559948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nPBlyXh9PstQrdc2QN20ZOIAAOUlM+tDmlK8yXosHE=;
 b=S1/35plK6g1InP4LUNxAmwWcYciutqS2SHTWfS/gDz80RLG301QEruuCVUr052tp94
 jSJOCjj8ddM7dkuu9q8mdnOLdN8uZ4eE+ie1D4VkOZ2Oh18IVPUcDZVOHzwfDjb81cR9
 Dtu+w6X6p230koD2lUCrtvRGZm2C441EEFAREq2cXghuOnwoZi8Vj8v+eEa7y7iVKOXj
 cm0O7MNUyYX1HpaUUQ/D4SzLybEQ6T5k35nvyDcxPz6XG7j67As67yzNsPnk2qMeUEqZ
 ScURyBH1RTx3QpkiOqbN/PsKw8nxeG7GMcgJ0E1UfWdfmdT+adjjax4vwXDAaaHSbnip
 claQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710955148; x=1711559948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nPBlyXh9PstQrdc2QN20ZOIAAOUlM+tDmlK8yXosHE=;
 b=hAgHunJtBPCg8PsAeF+hDk0V9foli+zVBSApsQj3364PyNm0qmhYe4qQ4mys1A8xt9
 704GaxNz0n2CuB2gKXevkGWmi6VNIREGLUzyY/0rM8MwAuQ97t6L7+ZgU5TGK6NUtJmB
 Kdhz6XHUznAvfydB3kqCezjw+tu5H7Gg0prqSAOZcpVH5WTABHhTBEB96dO6LxRcKLzs
 ujGMZPDfd1SEoVnpLT8+pFL++U7wuAv3zmvmfN9DCxBi9iRuOFrgnL5+Qr8tfSGd+jvO
 /tB6jeqhWiO5w4yuPRbN59SS/MTGEMcah+oqiHRwErw1Auot2jcrpD6gT2APnjlgmJoc
 ruRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYV8Y0HtIJgpUYzFSKThpkHexoJNst6W2Xx2ckY8Kb4TC7hyL37LrXxSL5qerD45GKh1rySguTpSnPEEQJrTVKONVDu+aX0Ul7UzewW2d11PDnwf+3ab5nETlKfA==
X-Gm-Message-State: AOJu0Yw+X7a8XpO04IoZUIhgI2YixG4gh9o03a3BQyCH3GBowdjs2KhJ
 /NY0sYyhieLIeEnWZ0ZD0CynK8PmFNRtPGrwwafRn1jVu9DNOzQv
X-Google-Smtp-Source: AGHT+IGLzZL6Aas8em91WPvq67iXB5/pT6DqhnD//NMI7o4VQI9cAyqTi1VdoFk/a7OqLFFjeu0b6w==
X-Received: by 2002:a17:906:b094:b0:a46:8227:2d0c with SMTP id
 x20-20020a170906b09400b00a4682272d0cmr252650ejy.1.1710955148280; 
 Wed, 20 Mar 2024 10:19:08 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a4576dd5a8csm7481639ejb.201.2024.03.20.10.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 10:19:07 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 5/6] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Wed, 20 Mar 2024 20:18:49 +0300
Message-Id: <20240320171850.1197824-6-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320171850.1197824-1-me@deliversmonkey.space>
References: <20240320171850.1197824-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <space.monkey.delivers@gmail.com>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 13 +++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a85a2abf2e..99c5c6a530 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -581,8 +581,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (get_address_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
     }
 
     return addr;
@@ -595,8 +597,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
     }
     return addr;
 }
@@ -1183,8 +1187,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->addr_width = 0;
-    ctx->addr_signed = false;
+    if (get_xl(ctx) == MXL_RV32) {
+        ctx->addr_width = 32;
+        ctx->addr_signed = false;
+    } else {
+        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
+        ctx->addr_width = 64 - riscv_pm_get_pmlen(pm_pmm);
+        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
+    }
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4934b43722..c77fbd8929 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -104,6 +104,19 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
+    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+    int pmlen = riscv_pm_get_pmlen(pmm);
+    bool signext = riscv_cpu_virt_mem_enabled(env);
+    addr = addr << pmlen;
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
     return addr;
 }
 
-- 
2.34.1


