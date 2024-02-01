Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA4AC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXd8-0000VN-ON; Thu, 01 Feb 2024 09:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcw-0000RG-QG; Thu, 01 Feb 2024 09:01:20 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcu-0005Kv-Ep; Thu, 01 Feb 2024 09:01:13 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3604697d63so139462566b.3; 
 Thu, 01 Feb 2024 06:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706796067; x=1707400867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJU8wkM3LnjsF1a1Phn4vBM3i63ubKEWfLeCr7pBLYk=;
 b=SCDVuT5O2N8YgGYKCddFlfBHa0P1O56ViZFXFqxGUWnwSywpdE5f1hhJi991tKS3Q6
 NFiD9TQsVYSVbb1Kte3lKDL7NJYcvGo+nWL313OxbrbnSsG/u1Xf23iHVUg3ZvcQuycp
 Dy3ygX6j8dkaN3EDJHL7tukrwfOGlosWWHeTAXM01k7E7nWlcxwtY1+eaQY08tTzqUMp
 Mtus/SwrUOKSHO+ueTpD++z3V5rLoLkGdB0Qt2ukdaX9uP3h5BoEk7bXE36Crs7t0V+1
 BQD0I/JSR3Al8KgqVJWQbTelfahNrOj+RLx2fpkauOL35TVQ/KTRzvYHOaQzURgbeRwD
 QXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796067; x=1707400867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJU8wkM3LnjsF1a1Phn4vBM3i63ubKEWfLeCr7pBLYk=;
 b=bQIw5KVZBSDCsxIK6IajuD6/snyjHHSlRso6PRK8Ztj6XqS7EYSB8McamSeKkhMIAY
 GeFWMhNSPTmiP5fr2yoduwOzXqip2MM8wNhUQxZSSzf+PmDGoMnVjhENnnm6oMMoQdwb
 VFxSmtO5FSpAwBkZTvhx0oSDOxxORRqGAyzDhFSdTZGYnseA0scdjzsYlZu4D1QgYgv/
 u/yyOCXrCVvd0IwgnfCXE/byQb4qs77g6rE8+k3clA5tXBWX/l0IpLfqURiAbo6s76HP
 11JLTzla0j3VjBO9VItKi/sBAMpqlBNbTKS8dLO9IJKrk0AkhEtnnmxTpWnp7A5XYdDd
 WvSw==
X-Gm-Message-State: AOJu0Yw6rFfjFGHWxqGCsqMqWLi021VCd9wHSIOmD+7mZYN2ll79lzOh
 ZojvEoTC61ek6YTl+WzA6tMVBYUhujUADM29Iaga2bgy8JKFnuwm
X-Google-Smtp-Source: AGHT+IEeaL6h3WrO9zqQomE8D61qet1mWRQeey6NvUzo9PUd7fas1wFXPCQ6mbrsIOBJPt5QLHj7zQ==
X-Received: by 2002:a17:906:c316:b0:a36:5787:b693 with SMTP id
 s22-20020a170906c31600b00a365787b693mr3177106ejz.53.1706796067406; 
 Thu, 01 Feb 2024 06:01:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXB7id5R7niAtaxLMVW1X0ELRVL9QwfDeqKlOv11pskWI0yTAOpslwMEUvuRsIUJQOfL8PvbcY/YktWcv7pSwI0AiemuHO0zFfypq1/BPqpVSCtIdow693p/SvX1/tnuJBimFbSDk1PJFXPL94vFWucf90FjQvGZ0yGe/eA2SRGSSL6Fkw2Ao80qOmT5ODHlMdWi/doiIpb0FTVu7dfm0/dNNjWwdQBS5Y1j/VlPPHDLPYmubv5ALZVGaQyFnefpa6wbC+1QiT1gN+FHUVVZplXnhaVUtNSnxDaOw38lbnM1BtsSoV0SoTL9gznStlePdYLW19sLz42DfyzQVzALhpgRsc/IfhVdh9yY9TQwcVaoLmBF5QXFWkAP8I=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a36a7f0f087sm902728ejc.222.2024.02.01.06.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 06:01:06 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 4/6] target/riscv: Add pointer masking tb flags
Date: Thu,  1 Feb 2024 14:00:45 +0000
Message-Id: <20240201140047.3456114-5-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140047.3456114-1-me@deliversmonkey.space>
References: <20240201140047.3456114-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x634.google.com
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
index 96b554a00e..e9eb8df1be 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -565,6 +565,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
 FIELD(TB_FLAGS, PRIV, 22, 2)
 FIELD(TB_FLAGS, AXL, 24, 2)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 26, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bef7917668..29622b649c 100644
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
index 9785ccb03d..e40a31f8db 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -103,6 +103,9 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
+    /* actual address width */
+    uint8_t addr_width;
+    bool addr_signed;
     /* Use icount trigger for native debug */
     bool itrigger;
     /* FRM is known to contain a valid value. */
@@ -1177,6 +1180,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
+    ctx->addr_width = 0;
+    ctx->addr_signed = false;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
-- 
2.34.1


