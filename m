Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED832CF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQet-0007XK-Aa; Thu, 03 Oct 2024 14:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeQ-0007G4-Mh
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:17 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeM-00053b-3V
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e09d9f2021so1001104a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980442; x=1728585242;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgQKcewfbnTfEcrsbPUbZIBiPMivs9PSGeqvWwo32SM=;
 b=grp4V19WymqY61YV1+XZ50OEeT7SojtsbUhWBQjQLdULWBVY6BagoGs/lCw3OVVbVR
 p38meADHgxTB9P5mMcslM0Oj6gYqjQo+0gdx3ALkQDcN0bM/xyNvXtG89fcWsVmFNtxd
 uw3QXHOa63jRCtG5saU9I+SrmYd0C8NiQEulE7IbFicdQaKAipc4G6UZSSoo6CfOWF/3
 iNaxqzNNj30faeKsSgszjm8XleKttHJp2fAxzb2mxEdkPwLRqGJQpYNUw9rrr9nd5dHk
 Itwg3PfRB22xWg14eUVT7pIbkSU+GEralRK2I4ueOII81j8GfZFHTtz+GuuG9xi0ehtU
 c14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980442; x=1728585242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgQKcewfbnTfEcrsbPUbZIBiPMivs9PSGeqvWwo32SM=;
 b=YdNFAEJgsQQIBrUDpm9ljIaBVoG/C1ydU9I8R3gn5S9nAQMk0NVs1XS0GsT52UzbfA
 X+W/kmyYmhaYYQmZxvbGUD80TWE11YDSnzGjcUiOua1Lfk41eLuEsshqaP3kJnhzEkTR
 PVwZzPaR/VsmMxRnFrharIFApEUKdSkAj61ut7oWdOZlWz0fWaaB1QSG4f1rPIednN1K
 Ual4ff3OM/yfzBAvONXssHoEoJDINWBMyYRCh0IZ3/rlmdGEsCaNTbU/r/E5XO1ate9B
 2Ok95ltHSunHSAPpBtIn0kdPXbsVk1aYZwiPbOE8SjNO9Pr00/NTl6oYsO3lZ5otZT3a
 dkcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv/rwTiWFHofpLs7yGlhTOhSpjU8bbuUKENYDXJShGqYclHrt+UJ7DqoCTOeJKQTOLmuzivgwJ9E2o@nongnu.org
X-Gm-Message-State: AOJu0YxperB9EEWb6y/wvJQ23+ghsyb3zvw3oRyf46LyyMvel8LfVvB7
 1j8M42hzajc7UAxNWApQ2KaR9FPWK7uWrA7d/sIzZeXk01z/RiGBLZ3FxLz6Hfo=
X-Google-Smtp-Source: AGHT+IGgs1CWrZiwuDAQs1406FUfoh57yI0la2Nqpu2qI7HYs1orBGR6GjVApT1uq7gABVoMQMyD2g==
X-Received: by 2002:a17:90b:513:b0:2de:e798:48bc with SMTP id
 98e67ed59e1d1-2e1e636771bmr17796a91.33.1727980442123; 
 Thu, 03 Oct 2024 11:34:02 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:34:01 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 12/21] target/riscv: tb flag for shadow stack instructions
Date: Thu,  3 Oct 2024 11:33:33 -0700
Message-ID: <20241003183342.679249-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Shadow stack instructions can be decoded as zimop / zcmop or shadow stack
instructions depending on whether shadow stack are enabled at current
privilege. This requires a TB flag so that correct TB generation and correct
TB lookup happens. `DisasContext` gets a field indicating whether bcfi is
enabled or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 4 ++++
 target/riscv/translate.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 997b579526..d39650636c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -628,6 +628,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 934bbff579..93d199748e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -171,6 +171,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
     }
 
+    if (cpu_get_bcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b5c0511b4b..afa2ed4e3a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     /* zicfilp extension. fcfi_enabled, lp expected or not */
     bool fcfi_enabled;
     bool fcfi_lp_expected;
+    /* zicfiss extension, if shadow stack was enabled during TB gen */
+    bool bcfi_enabled;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1241,6 +1243,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
-- 
2.45.0


