Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBADC36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sfs-0008BD-Ce; Thu, 03 Apr 2025 18:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfn-0008Ae-EN
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfl-0003j4-Q7
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso10576175e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717868; x=1744322668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GS22WEeeGx00HzARJRM4WG6Tz81Z8nWUDKi4UP1ius4=;
 b=LrrfZcfcjkIuKsKvd4EZHjFjkNAYA4ev8wBhPrXP9DQVHfU+K5p8HxUSO5t5oB6kz7
 ce6HvLRB2poC1xZO+nw9GJnQxWL6Hah0bLb2ReNhuBixMe67q60LJbxAyQauiKFy77uj
 Yif7eHQDRsfOr9Gjg0gbePPCNVhtzItVMihl9XR88C4mgFfLaL1vr+l1VcdKqWGtYIh8
 hLTichvlWBUbAUlzLDW1KL+41gGztYBJ0R2ArA4yzboBugSDtmWVF1HrtxYcSobbcs9B
 LaPkiaRpTHKCcT+C6PlCHFNrXkoInTOHYXOv7fuXZ1S9kIWVeE6Y7UKL3v8oLd/nxyiW
 cIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717868; x=1744322668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GS22WEeeGx00HzARJRM4WG6Tz81Z8nWUDKi4UP1ius4=;
 b=GrW4equUSApQTz+K22abBitlIcJETFt/dfkGVLQ8HflmDTAYHxdc/6j4tqGvZKeQIy
 ZN5atNFWhtQZlB/6mezP6NjPhfpwm+7wRcr/glqabR5bvogrey4TxJE6DJ5REL43lKgc
 zlwLinqkfVCOYUq+BGUkqAkJIAfhy0+yl67utHzwK3cLM5aPJkGkUtf2ZaXtzyCT4bYP
 YdwViPi/Iltl9aKsakbi8bQxUIJtQw7lsE1EZwPrUhrMr99A1StJg2e/8t7UQ1OksVnr
 0sKUhhuA7hldMsRVFs2HvZ+0qUo0xI5/KKLe1HK//40UVDYRDU/XZBxvaayth9aGDi04
 5Dnw==
X-Gm-Message-State: AOJu0YxZDk8b/C/A7/sLUGobc2w7h8mcZ1z1laopZcYX6yx18rQnWtdV
 VOQPIoGAFhGAOMCmTsxm9hikAJaanMmdB8M1pirA9m9JeHex6zC6FXcSXwIVcqTIbOvm20QMnRq
 l
X-Gm-Gg: ASbGncsvQeY7pRjd4krgMDpzMhIAhSPCpcRGksPhjolKJ0g2CnmShL9F9fhf3zvTRsB
 Uy3wJeRCE4YFxZWkmdQJPswP6sd6azQCM4fg9Ej+0PK/9Kgq/s//0gq38HLp0OH8al6REGEEDZJ
 AAJxEITGEOjYaMKPurpvlUsElKJ0Z0htRfR17KG+NCzbo1TohRfRNL+6XQ2HfpwsK9PE/32qU5Z
 kr/AvL8ZlJaaMxplGxSdR2cLftwJYViKCsmv6c0EMQ36SwGXIIiQxEajOQDJ5gizCyQ5bBkGAPE
 7Ulgns34OZiMLGDMIWLaugogq1eFovdZNAgtyuGQCFZ5VbZSTqHmOwefogp8+RVeEGX3uGvGCef
 rk+kHyURwyEE55S0OmfmaFnML
X-Google-Smtp-Source: AGHT+IEzzrz/YD50wq0HOq2LW7blQyejCX5UxSMlhMuLl9GPqJk3A7Fs8QKuPilKXWxBqKYiu3YfOQ==
X-Received: by 2002:a05:6000:290d:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-39cba93333emr690288f8f.39.1743717867892; 
 Thu, 03 Apr 2025 15:04:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea9a88b70sm49229865e9.3.2025.04.03.15.04.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:04:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 01/19] target/riscv: Do not expose rv128 CPU on
 user mode emulation
Date: Fri,  4 Apr 2025 00:04:01 +0200
Message-ID: <20250403220420.78937-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

As Richard mentioned:

  We should allow RV128 in user-mode at all until there's a
  kernel abi for it.

Remove the experimental 'x-rv128' CPU on user emulation
(since it is experimental, no deprecation period is required).

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c         | 10 ++++------
 target/riscv/tcg/tcg-cpu.c |  5 +++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 430b02d2a58..ad534cee51f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -697,7 +697,7 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static void rv128_base_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -708,11 +708,9 @@ static void rv128_base_cpu_init(Object *obj)
 
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
 }
-#endif /* CONFIG_TCG */
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 
 static void rv64i_bare_cpu_init(Object *obj)
 {
@@ -3255,9 +3253,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
-#endif /* CONFIG_TCG */
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 710449d17e8..5d0429b4d00 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1046,7 +1046,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -1055,6 +1054,9 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+#ifndef CONFIG_USER_ONLY
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+
     if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
@@ -1063,7 +1065,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-#ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.47.1


