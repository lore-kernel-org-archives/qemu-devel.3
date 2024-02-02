Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBC3C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqZf-0001Q6-HI; Fri, 02 Feb 2024 05:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZd-0001Od-Bm; Fri, 02 Feb 2024 05:15:05 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZb-00045Z-N5; Fri, 02 Feb 2024 05:15:05 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5113a841810so111606e87.0; 
 Fri, 02 Feb 2024 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706868901; x=1707473701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxIvZiWXY9IKLbJ7U7yyTRtTaqakCCJzBMTW0m/QIuA=;
 b=lmtbHE5aEFJw08sdiXNOs46r+MCcD5R+I28bvhTBMwCWO7awmOi5TGFXgWFqCpcfWt
 YLADHUVtbFk+x1WbNYduyoe8knJxhzne5/uvrF8vbB+GkIhgLwLidfGPYVSZ+8/dTYWR
 xAwP5zHgZ2wHUKqVsmnb2L8HaD40zwn95q1enLMHvygmr6hzUP7Bx6ArA6QB/oTJiSYY
 NZccFh6wKIRVkDz4/wCITGx9pY2hl975z93YeG2M5G/3sP105SLynGNwQjIVKdyXPdpl
 YaGhmJGU3kJVndMMygUglSz3NNh2edFt/9ylYehRXVpvQgu2Itz1sBGhYVf/6mYJtOZT
 rZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868901; x=1707473701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxIvZiWXY9IKLbJ7U7yyTRtTaqakCCJzBMTW0m/QIuA=;
 b=r5wSo4/hQYndVNsLfP3zVigEMUy47McATo++thsYOv2vDDxvO+JB5GuVtSoIJTlJCb
 RICmzWeyLv9NIFdMUYhnfCJTxkx7Cgq+3kMT97dJAmvEu9CVkYP3d5qjr7Uebgxy8n50
 lsCsWGyfiu0HMJ2mlfWE6SoXwvhbAAivHnqbrprKTbcQL4ZBuac30WqRO09k795Whuv8
 5NO18uy6HwahJlE1ZsFnZzdis0YcDGZbHqp95rwQ4Miqze/2U+Q4OfnuTskksnz+acdp
 dQTEMhbfCOswPOUHtcaeU2eMY/DzeKF8cyKrvl+u25wKvonfMvrRk55rhqiJVI9XMziU
 n38g==
X-Gm-Message-State: AOJu0YwDFa5fdM5iMsXAHjbwyttFwCrOgpVnROtYAsnrMnHQ+IP4wYWF
 WOsNbj0eyDm3cCxSdzC3poS4VIPjz60A11cVHaXA1C3RUim/ZPsJ
X-Google-Smtp-Source: AGHT+IFL7B0UBicSzEGTBJUwAxjvVI6mqfrv6XH+8PaVw/MysJRdIa39ZK9rvcbCmXAiWumkdSLAnA==
X-Received: by 2002:ac2:4343:0:b0:511:3a8a:9fde with SMTP id
 o3-20020ac24343000000b005113a8a9fdemr171475lfl.0.1706868901513; 
 Fri, 02 Feb 2024 02:15:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW6IaaSpInblOuXXFZJVCL1d6gKk8oV3q3H9NRWnNjGVk2dV+SxKqc+W9bmCM9X/b/IdQcfe1/JSQUD+oCkVTazrc11UZ4zZqrLgOw4CW/YICZhWabFt4EZe5oALFaiFS4Cs2igEigvr9kmL1cW+BllQEPM+KE6PBi8l1UdfV2T/jnjYK5yaAbDs+xujJPSYtEmJloU60hoVmbbGPAll5SL5lGPq8iDy2MCkZeC42hBss0weDaigEQ/bq+kr7aLgoqY+T4nYSa8hT/pjsIgfZgsLsdZWJHMwWFxa1YJFuV2NbUE64iVUbmvDw4EZMd+YHnH4Xmg5XZ5ugbWDYJZULSpgSH0/rfVCsSsCweaLvQx7QlF2HoxVq8ZpP4=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a36fe6fe976sm579722ejc.190.2024.02.02.02.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:15:00 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 5/6] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Fri,  2 Feb 2024 10:14:38 +0000
Message-Id: <20240202101439.3714106-6-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101439.3714106-1-me@deliversmonkey.space>
References: <20240202101439.3714106-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.693, TVD_PH_BODY_META_ALL=2.546,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 13 +++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6bc338bd1f..89f10744a2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -579,8 +579,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
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
@@ -593,8 +595,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
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
@@ -1180,8 +1184,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f6be88dcf0..9d1d627d64 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -105,6 +105,19 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
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


