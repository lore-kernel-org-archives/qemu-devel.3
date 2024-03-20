Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58746CD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzar-0003HM-HW; Wed, 20 Mar 2024 13:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzap-0003FY-WB; Wed, 20 Mar 2024 13:19:12 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzao-0006de-1I; Wed, 20 Mar 2024 13:19:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so2071101a12.1; 
 Wed, 20 Mar 2024 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710955146; x=1711559946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nInynHLgmsZQVaTOvTBwe6136gOIvfQkQAoCQ5NVmY=;
 b=BG0/8j/hhv8V8gwm7NlQpukafTehg3Zig8apJ5IBTINjrsA3F6CCG7bCZdi/76rcBi
 IaRPzZSoVIAcbU0jJwFtB2wx3h+GxtKZA5SjcZNr+sfSqFu+XucnjLN9VXe881OBnMIh
 OUfSmN3WLTA+Fe/wJ5dFBNV/ZtXkMI8RIXhs+IgfZQ50LxdEA/RdmUdDEtOQ3bHJX8pN
 6m3+W87H/44GdQRT3b+JhkrzaW7dx9o/J7e3i7QmzFBZKr8FGaP5qSYp8BO8X+DT7mQc
 CIQWxVo7xOSC/ZaAWEG+ZQPsG8YUElwUkxxbhIit6pa57LT7UPpm4JdZ4sRCUp80zo7e
 sNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710955146; x=1711559946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nInynHLgmsZQVaTOvTBwe6136gOIvfQkQAoCQ5NVmY=;
 b=IfVsxU/kmSiNxC11zARe5QflCRY7D3rYK5GDQKsAxmNZtf5B37BEZ2d5/CyU7AFvib
 GnW6zsH5iFnj+WFuTVrM8oPtrQ3GfGKTgTwWkBMSX/nkNBdQwn9Jq6qNxhEWfW/Uvd6W
 lZuxsGFj+hR/SiBHkk9SQGn/kJ/8rnhsXiRQXUZxzWbw2O/ICUkgikJU1VrHlRObO/kX
 /ptPS8eaDlkxFcT9mWp7Ad+qv0y3lPKVZCFJx8Zt5I4fAnwrJx3UvhR2jsRsfdloVita
 53k192oaB3vvleWJPqk9M4O5WDvNYz4t177XheOGaX1dLsAK4r8NmZwA3IpzNgBIBKk9
 iEJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI4gVzLd1N6ObMRLPj/Jd4O2/lT5aJDSpZHcqJ3rKHm0vQSsgwyzHRMlz0gENUP+NELzC2RDcSy7SAxz1wV4RVToHzqkGU4YzXdHAzcMAtqzTmT/d8wlVXkX4/cQ==
X-Gm-Message-State: AOJu0YyvNpWk7Kx108pqBIcT7BXdoBd/MruBfhzg7S1G0ew6WWj2FLKg
 /YT5Httcymxfuo1y4Rag3lf5z0xkixn3tn78jSPGj3EjmJrkRaLv
X-Google-Smtp-Source: AGHT+IHWMWAfuKmdfMPW23LTSjcrmEa6G9tM8KEYgBb2xWOCHCiiKZtThYVkiCsJ9cYABGLkl29ajQ==
X-Received: by 2002:a17:906:b2cf:b0:a46:ba8f:bcdc with SMTP id
 cf15-20020a170906b2cf00b00a46ba8fbcdcmr259895ejb.8.1710955146597; 
 Wed, 20 Mar 2024 10:19:06 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a4576dd5a8csm7481639ejb.201.2024.03.20.10.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 10:19:05 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 4/6] target/riscv: Add pointer masking tb flags
Date: Wed, 20 Mar 2024 20:18:48 +0300
Message-Id: <20240320171850.1197824-5-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320171850.1197824-1-me@deliversmonkey.space>
References: <20240320171850.1197824-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x534.google.com
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
 target/riscv/cpu.h        | 3 +++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/translate.c  | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0112b568a0..404f6ec50d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -566,6 +566,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
 FIELD(TB_FLAGS, PRIV, 22, 2)
 FIELD(TB_FLAGS, AXL, 24, 2)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 26, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a563451c48..4dea564fd8 100644
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
index 3382eb0a5f..a85a2abf2e 100644
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
@@ -1180,6 +1183,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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


