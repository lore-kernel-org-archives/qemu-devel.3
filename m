Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A92BC52D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRJ-00018Z-MV; Thu, 15 Aug 2024 21:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRG-0000uz-GM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRD-0002Li-LJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7c691c8f8dcso1153198a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770450; x=1724375250;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwwcop53hXtYL8GHkUUj7OHfyXWtcMSv/IjCclE+Sy4=;
 b=vbTBGelaWoezmh+5F+IKz8wouPolj+xG1U2JVRELuNPI0qd3x9TCq6l8KugNdjtj2X
 7WbhmCiP0fx6OyX8u+i7gcDig1rn6U+untw+BEAziZtTPoop40TSdZmsp8iq0PAd1RRW
 NsXcs2okqpwEbYkYUc93IvOkhtVpwUDW6+a8SU7qGJqFZdJ5HkGnM01gICYlbdw3wisX
 aV3pkmEXmBiwYQLjCYvKCmJHA7zvPKg6XvefICzm7ah4WPxfFeCDD2S2fnKBhLoTpQiH
 nqowOXsciiaQU1+zCANX966ARQzflIGZKA1u3KHsSlVGEgapcQiqopQ/ll+tb7IgtVKd
 L41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770450; x=1724375250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zwwcop53hXtYL8GHkUUj7OHfyXWtcMSv/IjCclE+Sy4=;
 b=reNhHC2YxWh7ms1/5kT6ioqPdatv6PSKFnwn8v4IAZqVS6/fjLXcmdogACDPNHedg8
 jNSNP9AvacPCLjz+Maof7hHcGPJ6S9qGoL/8tkFDvdnSMCXi33u9+BOzfv9PEB89Mjot
 JJKaZB5HpkcoTBHZ5tOroK2uof+u5PwADSr+hpwwVHco9mw1m/l+vZug8455k+owzOjh
 wPRTo3o9s7cvBvXSCsme2dB+D4GyB2ieHllArAkAA0j9dqnG+OW/+qcPKDzIC485ALOP
 Au4Ot60bhYvtjMkKBnmtq2MxGxaHGhxvCU4dbhhC/F61VRrYg2L0qopD7Xs5baHAamkO
 rAdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl64syNUVJ7MsNnEqzQhqdhY99yBcVON4TTug7JMLCcXhXkmZuoA8V9+4XJk2dsa0jMDIq9Gl2U/awp8fo14Kgz+QfcD0=
X-Gm-Message-State: AOJu0YxYZxKgRkxkP6xHekD7fJTPqFeYnigJLddfZjVigfA9Eslqrq5L
 XVlID+riHUvIS7gNtG4HzqO8Sao+oh3xqHM8kidSn1MlW7Y/UOhPk+k3W83+d9Y=
X-Google-Smtp-Source: AGHT+IF/m70F5QcrPLcgGbRHhfT3hs05ke40ld+CViHdqKngen+RsBMYnqTnGUh+CC9BjAFfK3uuaA==
X-Received: by 2002:a05:6a21:9207:b0:1c2:5fa8:2dee with SMTP id
 adf61e73a8af0-1c904f88d85mr1964955637.12.1723770450185; 
 Thu, 15 Aug 2024 18:07:30 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 10/16] target/riscv: tb flag for shadow stack instructions
Date: Thu, 15 Aug 2024 18:07:04 -0700
Message-ID: <20240816010711.3055425-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 4 ++++
 target/riscv/translate.c  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5a57099d59..dcc3bc9d93 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -613,6 +613,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 96571177ef..d3115da28d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -170,6 +170,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
index f1522e8b96..4ba42597c4 100644
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
@@ -1241,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->bcfi_enabled = cpu_get_bcfien(env) &&
+                        FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
-- 
2.44.0


