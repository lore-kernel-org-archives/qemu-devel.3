Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352CAC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsk-0002N1-TT; Sat, 18 Jan 2025 20:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsh-00029M-GX
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:39 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsf-0003EV-Mi
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:39 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so4380304a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249216; x=1737854016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7JlPx7ehQjMtsapu7OSc3TgFYoGt3fWe7/SxgEC/fk=;
 b=nFUPS6DCrxbSDONC2ccQ7MYjtdqWUCUbo7w9uTZVpWr61+lrRcHY0+8pSfsMf5BAzZ
 jCLeiozkdxEQMluM4NefDEBiW/cttN/p5PK4pnVjYTft41+p6J+2IXHKNP8RvPBdJNLE
 mqgwke633m3gCMgRcxP863I7QgPWKWxrdOz+hkuD5pklzQd8AS15fzMqUDi3aN9pRJI5
 6wKRhfTlRoKPo1xEH1q7mzYEHAHp6l3ErxOb+8wIGsGy0GvsiZ5ITrri2Ncua15nt0Of
 n35iX3uhL1JvTg2HwgUfR3SyR6kGBUoco4MkBfYkbHeTGK0O7CAQXr/nCaSZiIiYV4Od
 43cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249216; x=1737854016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7JlPx7ehQjMtsapu7OSc3TgFYoGt3fWe7/SxgEC/fk=;
 b=f/CyXBsvAiddcR6TZSdIqCZkCPILIMbdsSkiQ/sSSs0ZgPKf6gCweFrcr9ODIIRsd5
 8kKUgBlfs2cKrKPtoSULn17uCEztbpQSZyRgjlb+KBPMmjp6orjgXNHQxa5KqC4t57rN
 r4SmAQsXVxt8AFQHMwtR+3XBk+B3wZCS1wj7EhTK+SZUZFxWZuZQdmjr8S/tz9q/O4sC
 m/P65DO3s8kx50yPIQ24YEK1grzv9/xrDIqNsAV1zARVXreYbJjA0B5678debcWZlIQ5
 vsEBJ0tDRJjiI3acnm8ILTT91zdE3xkom7ehITcOoElPyOIURRLZlqGWeuUAKIypJwFw
 4rLQ==
X-Gm-Message-State: AOJu0YzHCcfELcg/a1HtS6+8nuzlBOlygtz2VXAjF9MM00AYdw4WtGmt
 o46JzKwAP368xRXzPOX5aMrnswTKIDoBk+amCOlU1dpQwzVXw+viR18fKlmj
X-Gm-Gg: ASbGnctuvmAzyZKxlDckfdAWZ8dBw4ViEPDGMSa4hwjJqxWWNjSdoUGitRq65f3Tr7+
 1zvqOgNPP8wf3d0AzjCkIm3zfETDhaWJ6YFLcBCFNRJrmcUGjXba9iAL2i6HiC62EFCY+q4J+Ht
 xbU3iUOkCUO5fi24U/vIPTUREVitzr2xc2pDdKt5GM1ukb9DD6vbswAi3iNIn/8tAzBz3DKofNn
 zI+y9/l0gsok1cFwVp3UbZ2iJYOE5ss/POWCe1T7k7v9XhVdepD4er6q9upHQdxVruLJZHTERPl
 dnvSCzGLYoZNDTLPwDyfz+DRaXI04UvBqVpMJ89TV/39WCRyidHVdCmAHrr0jtBS0O1tXcP0FA=
 =
X-Google-Smtp-Source: AGHT+IEJqgvMc7wU/ClJj/UdmeTsjn4tMV0BCUkEpHZ+JwFQBgRhvOgKHaLc3n40m+fd/9J1sxXdCA==
X-Received: by 2002:a17:90b:2748:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f782c73b7fmr12338777a91.10.1737249215894; 
 Sat, 18 Jan 2025 17:13:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/50] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Sun, 19 Jan 2025 11:11:52 +1000
Message-ID: <20250119011225.11452-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Message-ID: <20250106102346.1100149-6-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 26350b2826..698b74f7a8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -589,8 +589,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (get_address_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
 
     return addr;
@@ -603,8 +605,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
 
     return addr;
@@ -1234,8 +1238,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->addr_xl = 0;
-    ctx->addr_signed = false;
+    if (get_xl(ctx) == MXL_RV32) {
+        ctx->addr_xl = 32;
+        ctx->addr_signed = false;
+    } else {
+        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
+        ctx->addr_xl = 64 - riscv_pm_get_pmlen(pm_pmm);
+        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
+    }
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cf5dd7f2e1..0eea124b66 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -107,6 +107,22 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        return addr;
+    }
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
2.48.1


