Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8043CC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhG-0005U5-Fn; Sat, 11 May 2024 06:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhC-0005RQ-HC; Sat, 11 May 2024 06:11:14 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jh9-0002A4-7t; Sat, 11 May 2024 06:11:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59a17fcc6bso667140666b.1; 
 Sat, 11 May 2024 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422269; x=1716027069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juU2xycHeW7Q1yXn6YtlScNAZLbvDxdXRmaW9Wgj+5A=;
 b=RiAl3H38EuIbBJu57cTS0357wKkAUPwvkDKXBhIdq/ujo7Ag2Pl8fEii4LMh12jKPD
 hHviz2GC35T2ZXR5eiqT539V1jQnycSSutjhaPoSShgXMfTasNBV0Lki3oNI78tTO/lM
 X5gcCGnYWj5aWj8kFK7QKq+ky2s6S+6XkJujx/IbDOlnHmXtRWgJCELDh21d+Io5eSvh
 A/pfCSnxIT/F0sdgDen+cW9U8JAzVmDN+t0G5O8MzE4s/GD03ZriCLV+yeqfY9s7FwiG
 mReM7JW+YTXBlNa3BeHSJ5L/sLSrC5D7nOMTDuoSv/SwWr+AHHu5cB+rGfVBIAUzoH46
 OWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422269; x=1716027069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juU2xycHeW7Q1yXn6YtlScNAZLbvDxdXRmaW9Wgj+5A=;
 b=OH8I/kayA1kU5cbAxqu4Qemw6E9l51CO/MSJCuUuZaUcwcakqEYv0Y8NM+C42TSYB3
 j+kxAwchSEXzh9J8Mg2O/oABDGM7bKb3tiUv5dS7OUuBvHLqr4APuejYNja0OUePXJSw
 sXKTntEKhya4IUTjIhx0ZOXQMXnYJrigSwuQ6ZxLLghdvWzTX9UwMnpWtR5xG9M6YTcq
 8JSozgbfMnsDIE/a//yOLsRe/PXLcMPS18FF/tk4+woqdQ9q4wnsWm7roKSnxHvWf8bt
 Sh0iCaHQ65Oou/W/aDcuwKSNbqezSKUnJ5AhGAWfLyHq11dPFQ0LyEy65ByI3UMvkpgK
 nZcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8Dc/WPZzsGtuVH0aPSjbWgX3XWL8N6V10fkx74YEJKRR3xEbnV4J3THMgKv0Y73mIfgSxbGIT/elQLpK9HQRH8laKfmV9I4OjHm+9Sd220krsk7GxCv55LjRdQ==
X-Gm-Message-State: AOJu0YwBBCIr9LTUprpNx3y9yAbPyNoKM6+1XOoc4wdithKQb9kc27uL
 Vo/qdAWeUmwR9XcyitQwPlCmq9a85IM3fG61ZBUpj7UxmCuuWIBe
X-Google-Smtp-Source: AGHT+IE6MV9YOgyHM5TzSaHKzR7gyYIm941wvWykOVlhUg18VNUWSWgO9MGiY0heZiGkk4CGiobYaQ==
X-Received: by 2002:a17:907:3208:b0:a59:c367:560c with SMTP id
 a640c23a62f3a-a5a2d665e1emr359203566b.60.1715422269020; 
 Sat, 11 May 2024 03:11:09 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:08 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 4/6] target/riscv: Add pointer masking tb flags
Date: Sat, 11 May 2024 13:10:51 +0300
Message-Id: <20240511101053.1875596-5-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
References: <20240511101053.1875596-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 3 +++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/translate.c  | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9cac723b19..bbf3a0f64e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -564,6 +564,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
 FIELD(TB_FLAGS, PRIV, 22, 2)
 FIELD(TB_FLAGS, AXL, 24, 2)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 26, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e4a127ca84..3f2473bd73 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -68,6 +68,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
@@ -138,6 +139,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e5b339b1fa..3f578d6dd8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -103,6 +103,9 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
+    /* actual address width */
+    uint8_t addr_width;
+    bool addr_signed;
     /* Ztso */
     bool ztso;
     /* Use icount trigger for native debug */
@@ -1185,6 +1188,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
+    ctx->addr_width = 0;
+    ctx->addr_signed = false;
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
-- 
2.34.1


