Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3A8C25B79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQr-0006ZK-5r; Sat, 18 May 2024 05:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQp-0006Wc-5k; Sat, 18 May 2024 05:32:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQn-0005zE-OI; Sat, 18 May 2024 05:32:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ee7963db64so32144535ad.1; 
 Sat, 18 May 2024 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024764; x=1716629564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJb9bvfRee44JjdofCdO48Q2mvLlZY5PLzHGKaPIRNI=;
 b=AYhyjCbXUNNoNSfqi/pacVLfvCefbLkqehGHw0fSVeVy6oDE4Gf2gBQI9SnwC6kQD3
 5KNsXbtTSptqpXWShXfT7X8NF/TNnlzH+PZHl5Cz/vWLsBWmxF9/a2NZddp9lo8KJu0I
 ndOoN6lTsbod0OgHJr8gZMLIqKm/rRq9pVwEVDjd+01poJCgK0PFtyLyWFYcigUKP/zA
 5msdS5XddwCbKOsJbke8z1rRI9NBgVRtfiaFCieKkmMSnphmVDGXEXRQfE8ZaVSxvG2T
 Ca19DnLr5/GfCbq5E52Az2zLpltFCRRvPwrN8zZu9NnH21lA10KSEMbIV6Porlb09TrW
 9gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024764; x=1716629564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJb9bvfRee44JjdofCdO48Q2mvLlZY5PLzHGKaPIRNI=;
 b=fkdtq9bzZJP9D8FFF/9R/W1y1HGAiqUK2z25Qc5b/dUMOJhhuCMWOCfE/unMyZIFF/
 K70OhSdA68dWcebZJABKhoWPn7CZIHGWTQy+KBg+DYtipz6Uf7n+Qrz2hrliULYrMzK/
 LpURZP8uQym5aZvazppE+T8OZib0Qi+4JuHyFnjQwyCVybGPeNhvZRqiqvc3HE2BuXX2
 DUN8dovxJwg/nfehXEeZ86eHh5rj/er+xbIJZSY37lzzdhwgkS/1nEIPiXicQy/9YVt5
 5rJWwQmg3/Kt2nWkjMgkPDOoqDECAizrqptzS5mfHIAdktsm33sW7+qEG59IXAos8IBp
 wKWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFdIACgS2dbcfk5bDWs6v5AObsrbjpLwVxdaJqczr3d1/CTiVqR6c31Ap5uG5IwDBCfnCHi6SBB2XAPmvdclAOI4v1R24=
X-Gm-Message-State: AOJu0YweJI1MdyvggDM/dkqvPbIpcxtvTq9epJR7mG6jns+Qjx6B9ld9
 KAiPw+btwvbIwd1HrNcTLoiBnJ7SlaQ5nexxt0MtTX0uT9TyiCTZoqYojA==
X-Google-Smtp-Source: AGHT+IHdHyC0QWcreqsO+e+AQYz3C3PzTbXk4ysfvY1pK6H/LiE7nEv7ANHVcCEIqVvmMr8U21oXfw==
X-Received: by 2002:a17:90b:3a8c:b0:2b3:2a3b:dd0f with SMTP id
 98e67ed59e1d1-2b6cc14b8b5mr24598312a91.8.1716024763996; 
 Sat, 18 May 2024 02:32:43 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 11/14] target/ppc: Add SMT support to PTCR SPR
Date: Sat, 18 May 2024 19:31:53 +1000
Message-ID: <20240518093157.407144-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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
index ccd90a5feb..60a7afb086 100644
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


