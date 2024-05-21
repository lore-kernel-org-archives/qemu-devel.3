Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C06C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELY-0007un-6N; Mon, 20 May 2024 21:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELV-0007tF-Js; Mon, 20 May 2024 21:31:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELU-0005Lv-12; Mon, 20 May 2024 21:31:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so63336475ad.3; 
 Mon, 20 May 2024 18:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255073; x=1716859873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UogJLS5LbK3AS3jvsFfTXAjp3CkBWXTUBHu2pm6GqSs=;
 b=RiYRx4hGqqBL04kRrG+biySKnb33eaPqyrM5nMxIeVV9AH/gljiv9HWU/Myt+MowZ2
 kAy04uRQJxjDvImgMrJzmZ2w3yaWtbE68ihRDbF8mapuepivM4tEtlPBuDAe+NBi+vUA
 Jyk8t7F307W1GCkQrrfsND9q3m8llKlgbg6xA2QXKNxjFSiNhGUsyFNLNM/6LOToKYTw
 tZPtZU2MJ++Ib95onGAkwas9hBnOTToAmTtMgcgyn6zuUGOIVWcSC5A88wOghzOfYTmy
 G6sDSSU2IKkR4wEJK+cCa8yyUvNzzXOnoAbmF9ggS5dQ9rDt/lUi8VJxVXsLbntUtMi8
 cUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255073; x=1716859873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UogJLS5LbK3AS3jvsFfTXAjp3CkBWXTUBHu2pm6GqSs=;
 b=cfkOEMCrylW5fH15PXFUL1yBwtC2cQ7IrmAeTGIRtawOQFA7Iltl5DHsEjLnlY/BCL
 2LmtXEsJYzR05nd6nNEaa/FKG4aAk6k4hVs7X1k9Txzryr13xClnY9rP3GJ4JLTvH7MH
 L04tQ7XPTnEl1Abaq573kSEljFXAaq77eD0BMB942SryRqYkgtv5yGyN3jxG0uFUg193
 Hsv3sBZ0lUadT1Wx2PGesRMnGi1tux8XJQ75UAjMRn6PDsMCNWe2lRc9v0WyHrf+a2A/
 nuCD8ollbw03k/Z4MqT19DT4QSauvilc2gaYIW+Zkavc5RGPL58aI80CtwV1COvxpsyG
 ywbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPMHRo89mTpYi903narJXIYPl5cJx5/lj3rmrWDyFDcngnDhQoAUIwR8pzlESzUBuSTRJiiJYCt12STJSFUuZUymeXITM=
X-Gm-Message-State: AOJu0YxII5JH3CHJGo+nnLX/f3khX/rpE7iMWrcbF0Fx1tRodvzVo6Q4
 TVMIr2SQ+gl1SIEP9W7X53DLDn/JzU3Cdq/8iPgcxiY/wI0+oKIJTeU0Ug==
X-Google-Smtp-Source: AGHT+IGtvLHxUi5PyR4zdLbum+I2X6bRb4sgxoE1vgY+KPuTf+GDFeRz+tiEvrELGfp1hiLmOtl/Ow==
X-Received: by 2002:a17:90b:4c09:b0:2bd:9255:4738 with SMTP id
 98e67ed59e1d1-2bd925558d6mr765591a91.5.1716255073239; 
 Mon, 20 May 2024 18:31:13 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:31:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 09/12] target/ppc: Add SMT support to PTCR SPR
Date: Tue, 21 May 2024 11:30:25 +1000
Message-ID: <20240521013029.30082-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

PTCR is a per-core register.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 16 ++++++++++++++--
 target/ppc/translate.c   |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 6f419c9346..a67930d031 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -173,6 +173,7 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 void helper_store_ptcr(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_PTCR] != val) {
+        CPUState *cs = env_cpu(env);
         PowerPCCPU *cpu = env_archcpu(env);
         target_ulong ptcr_mask = PTCR_PATB | PTCR_PATS;
         target_ulong patbsize = val & PTCR_PATS;
@@ -194,8 +195,19 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
             return;
         }
 
-        env->spr[SPR_PTCR] = val;
-        tlb_flush(env_cpu(env));
+        if (cs->nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+            env->spr[SPR_PTCR] = val;
+            tlb_flush(cs);
+        } else {
+            CPUState *ccs;
+
+            THREAD_SIBLING_FOREACH(cs, ccs) {
+                PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+                CPUPPCState *cenv = &ccpu->env;
+                cenv->spr[SPR_PTCR] = val;
+                tlb_flush(ccs);
+            }
+        }
     }
 }
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c688551434..76f829ad12 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -971,6 +971,10 @@ void spr_write_hior(DisasContext *ctx, int sprn, int gprn)
 }
 void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
     gen_helper_store_ptcr(tcg_env, cpu_gpr[gprn]);
 }
 
-- 
2.43.0


