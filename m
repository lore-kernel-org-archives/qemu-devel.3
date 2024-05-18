Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F449C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQs-0006bY-RT; Sat, 18 May 2024 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQp-0006X6-H3; Sat, 18 May 2024 05:32:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQg-0005vW-Oq; Sat, 18 May 2024 05:32:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ecddf96313so6221335ad.2; 
 Sat, 18 May 2024 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024754; x=1716629554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C05xE7UClbFjpcfnp/5y2S2aVeK97g5iKYmeDJkYN6Q=;
 b=glkkTkk/JHi1D7ITUNfiGvTeUYTwB5nOEu3NU35td3QxsBE7eY9d2leWKdRvjyhEYj
 ksD2Lu+ifOSvp4Bw1Kt6rqzx+8IbkAyyWcbkd/Or2JuyMt7uBr2dBimK3lKl8uYNxbD9
 O0JkD8cAaXohKIxzUPUcQvDqL+41JtFjc2mgmTBMZMTrN3nMHO9E5XLkKhON22hp7p0E
 H5aMcOISVK/ZOqQxJ7rRpe95Y2tXIJYRGjlIpse+IZQU3WlpE/Obkby6o2jOfz73yTDL
 Ihenr8Bw0gYBXsr64z37L2BCLD71cziBYgQ1yoNFhpmBI6tZl8T7dx3p1S6mndDVcNs0
 kJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024754; x=1716629554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C05xE7UClbFjpcfnp/5y2S2aVeK97g5iKYmeDJkYN6Q=;
 b=EC0sct3915GFCLc0k2gqVWhq3BD0e4m74leI+0ZnM3fR/EKHPMepVmraORQdXEmp8F
 wTz2IGsy8lc/+NQaJcpN7kz4IHqpVKIAB3mwwiaaetMPQ6OU0MN/IawJrKl2xvZOSJU5
 vFgqPOzunAl5gyDkvGBWCoYqDvTC70RQ8EQC6w6BbX21aR88L2Fck0BMeFtk+WsscDfC
 B8PqaxASMdpC2/1P0sv53ovjjxx1IWROaDImVaP1N048Qw3paTp1oM6o+YnFxxhwuOCx
 QdNHd5bNulzDHAdKQbCCMi90cvJ2uAvHYhEMbMipfVC7y0MMG8QxXLmY/5xtlzhQa4pQ
 Zuww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5x5UsxwEZoMT9Mh2VqsoCWFrxjc0/0RupQd3OiYJ7oCB6G9F2gP9nmMtr0dLVShMlLK+89TNlrnEp0wQu0J9oeIwJ6TI=
X-Gm-Message-State: AOJu0YwQeiNnD7bQFcNuHZMtpxsscvMh2XNEOCc14/r6zyfXvV/8ZiH7
 X9ZUxJbzJHj4hhqx2ddiyUXVmwC8ffXClAY/BgPVO+1A2SMSP78MKCYqdg==
X-Google-Smtp-Source: AGHT+IFcgKIqMUKc5FdDCOqCaKhZQ12l/eMPtTOJiGGfk0t7d9hwfRSJpq3Fii69oKZEmWppU/nBmQ==
X-Received: by 2002:a05:6a21:2d05:b0:1b0:278e:34bc with SMTP id
 adf61e73a8af0-1b0278e36e4mr8833723637.62.1716024754374; 
 Sat, 18 May 2024 02:32:34 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 08/14] target/ppc: Add PPR32 SPR
Date: Sat, 18 May 2024 19:31:50 +1000
Message-ID: <20240518093157.407144-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 2f7fab22ba..9a51e54c1c 100644
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
index e186da5ef1..dd45251d7a 100644
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
@@ -6265,6 +6274,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6432,6 +6442,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6626,6 +6637,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR64_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ee7f3ee5a2..c4b4f7ea62 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1416,6 +1416,22 @@ void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn)
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


