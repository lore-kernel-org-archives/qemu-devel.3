Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FCEC25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELN-0007m4-Pd; Mon, 20 May 2024 21:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELJ-0007jg-G7; Mon, 20 May 2024 21:31:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELH-0005Kf-RS; Mon, 20 May 2024 21:31:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eeabda8590so87921545ad.0; 
 Mon, 20 May 2024 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255061; x=1716859861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xELS6oYgKZZUA8AMO1krYjCwP0RoNjeqV7WiJZCCiK8=;
 b=RlRBzjBQ44bZN03jO8PdFTr8jUYAfs8/2jroz7az9gcmdNNo4Nb7MmjTIjcVB99aUK
 E2jCHFKZonGyUp5vUQdDPqaT50J7/AjhVXgs4d11you0p1thFJGrpbMLOo+6hl/zoYIC
 jy/J6jbC3lejO5oqHcheGSw4wKLFaq1yYg4RmfoSmfNIGSmBXokEsdUeO7wO2R6dlnOe
 fv/wt0/L3S+ScKPefL1LHBctWfIQMLz40ePVDVBzAkhb+Sz3rzLw76ORZcLYTJYQNPfo
 lOSM/AMcZGYwjSqAcEI9XgGmhH8kXXJ+SKGTm5Whd1B1Wbj2tAoxxogRxybBjz/4FqRa
 mB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255061; x=1716859861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xELS6oYgKZZUA8AMO1krYjCwP0RoNjeqV7WiJZCCiK8=;
 b=ZmAi8nkkWBecpaxm3qfCA2zV+TaKFA9fNZXEATbtiXRDMFOZP4aGvh3ml7D9vyWogn
 wj5gv870bOeHOrWPXFHKKlHe2dkeg296G034MR+YNnaDutNdH7jYLKUcFcEOWXP/jRDG
 uCJt+ujXQoinrCxzlBCizSmbfhjtCKYbV1Dh/VfJpAG/Lnkz/yYv3YaQ8OEh3MtwJoVX
 eOBGp9X+4RZyT0p0xeNFUnMl7Tgpeas6dIxYSYjk9hZeXITqORxv7Cfl6xg6ChwhGMkR
 /GJJNdhNO4Vnft6UVMIoYRJ5aA+Kcw8eenwdloB6Ttw8Hsu4bo4Y9gtBIqgAaV7G47A9
 xJMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhKWEogRz5T27yEgGU06s1Z/2LlR5ZvFD/2BtufUn1DdAkwK8yysPic3taIOiGGg8aczJP7Bc6JRiGI7dBTmBuEPDy19s=
X-Gm-Message-State: AOJu0YxxuUeTptRVKiU/4Wy2R/I6phhT6ATKCn6TzGZ1/pdjS6qgNGH0
 +mcMYbEggmJY/Zgga4D144L17le87dPAxp4G8QUNCDOxwniRE+mBQrH74Q==
X-Google-Smtp-Source: AGHT+IG908KthP33QWrdcsoeqRSjsXhA5tcUx2Jl5Q6MW61VWboIkEJjvBLo/AxYLMvFhLM3Px30rw==
X-Received: by 2002:a17:90a:eb07:b0:2b4:3659:b3f5 with SMTP id
 98e67ed59e1d1-2b6ccd886efmr21839507a91.47.1716255061450; 
 Mon, 20 May 2024 18:31:01 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:31:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 06/12] target/ppc: Add PPR32 SPR
Date: Tue, 21 May 2024 11:30:22 +1000
Message-ID: <20240521013029.30082-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

PPR32 provides access to the upper half of PPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |  1 +
 target/ppc/spr_common.h |  2 ++
 target/ppc/cpu_init.c   | 12 ++++++++++++
 target/ppc/translate.c  | 16 ++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2532408be0..141cbefb4c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2120,6 +2120,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_POWER_MMCRS       (0x37E)
 #define SPR_WORT              (0x37F)
 #define SPR_PPR               (0x380)
+#define SPR_PPR32             (0x382)
 #define SPR_750_GQR0          (0x390)
 #define SPR_440_DNV0          (0x390)
 #define SPR_750_GQR1          (0x391)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index eb2561f593..9e40b3b608 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -203,6 +203,8 @@ void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
+void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
 #endif
 
 void register_low_BATs(CPUPPCState *env);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 892fb6ce02..7684a59d75 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5623,6 +5623,14 @@ static void register_HEIR64_spr(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_power7_common_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_PPR32, "PPR32",
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 0x00000000);
+}
+
 static void register_power8_tce_address_control_sprs(CPUPPCState *env)
 {
     spr_register_kvm(env, SPR_TAR, "TAR",
@@ -6118,6 +6126,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power7_book4_sprs(env);
 
     /* env variables */
@@ -6264,6 +6273,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6431,6 +6441,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6625,6 +6636,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR64_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ca4f4c9371..137370b649 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1414,6 +1414,22 @@ void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn)
     gen_load_spr(t0, sprn + 16);
     tcg_gen_ext32u_tl(cpu_gpr[gprn], t0);
 }
+
+/* The PPR32 SPR accesses the upper 32-bits of PPR */
+void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_load_spr(cpu_gpr[gprn], SPR_PPR);
+    tcg_gen_shri_tl(cpu_gpr[gprn], cpu_gpr[gprn], 32);
+}
+
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_shli_tl(t0, cpu_gpr[gprn], 32);
+    gen_store_spr(SPR_PPR, t0);
+    spr_store_dump_spr(SPR_PPR);
+}
 #endif
 
 #define GEN_HANDLER(name, opc1, opc2, opc3, inval, type)                      \
-- 
2.43.0


