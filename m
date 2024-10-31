Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA0DE68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MkQ-0005Bq-Gd; Thu, 31 Oct 2024 00:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MkB-00056H-CS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:25:12 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mjx-0006yA-DH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:25:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539e3f35268so591510e87.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348695; x=1730953495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4Vhs6Ob6u6BHe3e6MEeVviB+HaVRV3K5gMILLbeGY4=;
 b=aHMZSoXUY2y+RGNG9SfLCCjft2ForjvG6TuJN9iGxUfD6dOsSX2W4UJy6owV9kX6Kr
 +Y6wdDDLteGLvRXJw5Y22Nv1xIwIWEV8UuQRt8fLt0FyyRHtZMTU0aNqxcVi68fMh3MH
 nAmiqEuICiGxTrrKevKAJZutSEdiywUYPaWuPmf3VRdheiT+Udb3O0oJfDAunxPjJunW
 rmG7RjJ2hD+I86K1vueOknMYb0fX8AseyTfsxm6cTjVnXJmV3FfE0nXiQTpKEcJnF2OK
 dOv5Gb4kp6+5k+pzrDwqJyDu/NZODSbHE3aC2Ru1VCFvYNarP8NRLjtftZucmubCShYt
 EVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348695; x=1730953495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4Vhs6Ob6u6BHe3e6MEeVviB+HaVRV3K5gMILLbeGY4=;
 b=mCHCqddQtFQexV2lKAJxVj2XSZPo7jlhTmf9LMUV2vJ3405z+DrcgN7yVc1TqPg+fm
 E3z2GPNfAhVkeINqej/2lMxZmnnBxGjyeAuHANELersPnsbkY9JeICDBsi89uRPIoZCo
 2PhZI7yHeFS1X52HaasdV2E4LS9XcjifDz7xvR1kn0lkyORjRS7u6f6BCMHNCMO3oA0z
 WIeRJW3HSrSPLMDvw6uGFTk8bKWFMaf7n0KlSJn5I+EU8BG8g0Q8cFdS6/q+mMdEgjNA
 0FVfb6SOXLWCikmm8DvWhIaDQKVKKDrWKQy/qlP71EVFQiIl34apYjlLXfENCebaX3rK
 d+iA==
X-Gm-Message-State: AOJu0YytSu2x6p/WOCQ2kvJqTsvJcP7kOz3IFr6sKjCo5Jm7ac9MzBdk
 RUN513dwhYAFDy02Q453LLQihSTh8wpf97FHoOwwCkkohXg55cuWdPJz2a4qVa6pxG1vZX9kwl2
 0
X-Google-Smtp-Source: AGHT+IE2x63m8v5jQk2GA2kAkrO9k1bQidwjczB+gWmlMI8iq0cInKo+bel7+aEPCKCt6UFt6vFuEA==
X-Received: by 2002:ac2:4643:0:b0:53c:7526:e18a with SMTP id
 2adb3069b0e04-53cc60cf708mr136535e87.30.1730348694962; 
 Wed, 30 Oct 2024 21:24:54 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bdccb15sm75479e87.238.2024.10.30.21.24.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:24:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/14] target/mips: Introduce disas_mt_available()
Date: Thu, 31 Oct 2024 01:21:29 -0300
Message-ID: <20241031042130.98450-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Similarly to commit 17c2c320f3c ("Introduce ase_mt_available helper"),
introduce the disas_mt_available() one which takes a DisasContext
argument to determine whether Multi-Threading is available by
checking the MT bit of the CP0_Config3 register.

Remove the then unused ASE_MT definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241024195447.44600-1-philmd@linaro.org>
---
 target/mips/mips-defs.h     |   1 -
 target/mips/tcg/translate.h |   5 ++
 target/mips/tcg/translate.c | 136 ++++++++++++++++++------------------
 target/mips/cpu-defs.c.inc  |   4 +-
 4 files changed, 75 insertions(+), 71 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 6b5cd0d8f53..9d4d292586c 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -30,7 +30,6 @@
 #define ASE_DSP           0x0000000008000000ULL
 #define ASE_DSP_R2        0x0000000010000000ULL
 #define ASE_DSP_R3        0x0000000020000000ULL
-#define ASE_MT            0x0000000040000000ULL
 #define ASE_SMARTMIPS     0x0000000080000000ULL
 #define ASE_MICROMIPS     0x0000000100000000ULL
 /*
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 23a489c0f38..1bf153d1838 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -231,6 +231,11 @@ bool decode_ext_octeon(DisasContext *ctx, uint32_t insn);
 #endif
 bool decode_ext_vr54xx(DisasContext *ctx, uint32_t insn);
 
+static inline bool disas_mt_available(DisasContext *ctx)
+{
+    return ctx->CP0_Config3 & (1 << CP0C3_MT);
+}
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9a3ae10a919..de7045874dd 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5112,17 +5112,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpcontrol(arg, tcg_env);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf0(arg, tcg_env);
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf1(arg, tcg_env);
             register_name = "MVPConf1";
             break;
@@ -5143,37 +5143,37 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEControl));
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf0));
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf1));
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_YQMask));
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEOpt));
             register_name = "VPEOpt";
             break;
@@ -5200,37 +5200,37 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcstatus(arg, tcg_env);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcbind(arg, tcg_env);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcrestart(arg, tcg_env);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tchalt(arg, tcg_env);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tccontext(arg, tcg_env);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcschedule(arg, tcg_env);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcschefback(arg, tcg_env);
             register_name = "TCScheFBack";
             break;
@@ -5869,17 +5869,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_mvpcontrol(tcg_env, arg);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf1";
             break;
@@ -5899,39 +5899,39 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpecontrol(tcg_env, arg);
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf0(tcg_env, arg);
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf1(tcg_env, arg);
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_yqmask(tcg_env, arg);
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeopt(tcg_env, arg);
             register_name = "VPEOpt";
             break;
@@ -5946,37 +5946,37 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcstatus(tcg_env, arg);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcbind(tcg_env, arg);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcrestart(tcg_env, arg);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tchalt(tcg_env, arg);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tccontext(tcg_env, arg);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschedule(tcg_env, arg);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschefback(tcg_env, arg);
             register_name = "TCScheFBack";
             break;
@@ -6619,17 +6619,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpcontrol(arg, tcg_env);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf0(arg, tcg_env);
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf1(arg, tcg_env);
             register_name = "MVPConf1";
             break;
@@ -6650,40 +6650,40 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEControl));
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf0));
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf1));
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_ld_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_YQMask));
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_ld_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_ld_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEOpt));
             register_name = "VPEOpt";
             break;
@@ -6699,37 +6699,37 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcstatus(arg, tcg_env);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcbind(arg, tcg_env);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tcrestart(arg, tcg_env);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tchalt(arg, tcg_env);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tccontext(arg, tcg_env);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tcschedule(arg, tcg_env);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tcschefback(arg, tcg_env);
             register_name = "TCScheFBack";
             break;
@@ -7336,17 +7336,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_mvpcontrol(tcg_env, arg);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf1";
             break;
@@ -7366,39 +7366,39 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpecontrol(tcg_env, arg);
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf0(tcg_env, arg);
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf1(tcg_env, arg);
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_yqmask(tcg_env, arg);
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeopt(tcg_env, arg);
             register_name = "VPEOpt";
             break;
@@ -7413,37 +7413,37 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcstatus(tcg_env, arg);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcbind(tcg_env, arg);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcrestart(tcg_env, arg);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tchalt(tcg_env, arg);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tccontext(tcg_env, arg);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschedule(tcg_env, arg);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschefback(tcg_env, arg);
             register_name = "TCScheFBack";
             break;
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 09bd62d430a..922fc39138d 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -314,7 +314,7 @@ const mips_def_t mips_defs[] =
                     (0x3fe << CP0SRSC4_SRS14) | (0x3fe << CP0SRSC4_SRS13),
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_MT,
+        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
@@ -543,7 +543,7 @@ const mips_def_t mips_defs[] =
         .SEGBITS = 32,
         .PABITS = 32,
         .insn_flags = CPU_MIPS32R6 | ISA_NANOMIPS32 |
-                      ASE_DSP | ASE_DSP_R2 | ASE_DSP_R3 | ASE_MT,
+                      ASE_DSP | ASE_DSP_R2 | ASE_DSP_R3,
         .mmu_type = MMU_TYPE_R4000,
     },
 #if defined(TARGET_MIPS64)
-- 
2.45.2


