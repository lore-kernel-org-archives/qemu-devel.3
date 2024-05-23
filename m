Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAA7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZj-00031Y-2G; Thu, 23 May 2024 19:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZI-0001Sq-6G; Thu, 23 May 2024 19:09:52 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZE-0005qZ-RL; Thu, 23 May 2024 19:09:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8ea3e9543so276428b3a.2; 
 Thu, 23 May 2024 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505787; x=1717110587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hShkd4GOKg4gDHb6mULyft69a2vSUmlUUWF0ua7ia3s=;
 b=g++bAI1vafndb1M4VIN0ZoZ6zkKbyz5luAqNSQ+3XFmboqyqXEEl5t1Bp3hIsM6Af+
 3rC1Luc7XNwlRLhN2eulpDniOsA7nlt989a+iD+n4f59lwX3c8jlSDG4aJQSNrR3ly7E
 TagrJH+qIpzYUnclwi4oYNKjD5JraYxB2JwZL2FqNVMSTx6kB44oWOmXFrdXFUAZrzpF
 FWxzhwe60st+rFUnjznMPGSqdgFJxim72TfkStoh9E7g7VOmjosq+SXyoGI7HxAvbSsd
 sq2fFR4F/3VAbbUxKz4rDLmnZoDIjArjN3eAvYrgWEjeol5QSZkm52nJStZ6bPTCGEBd
 GZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505787; x=1717110587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hShkd4GOKg4gDHb6mULyft69a2vSUmlUUWF0ua7ia3s=;
 b=eFUaSW9NDTpdWldel8UVVnXX1JjCyQlGMdeetL71pUK6UZDpxd1bIfzMUa5exj/qCI
 FLRs/NBYwen+yiwgPlcRfI0ncUk2zscdDpHtizRxXtcD0IjdC+PxdIuGtafq1vXVCq4x
 +JmitnoPgjAaidE6Pu9KdmOkneRKCYrS1aPqhVyvIviamn1s+srM1C5269XLmZZRCqNq
 +fuQjxhCQmJ7MLZSfim4Qvd9g+ZVkR1SMPA9sOhPDNL0vJO1b4mN+JtpUrTGbps3/Iwe
 3dNMNTP9ptsnBUUAH92du2kC7cHBcf6nObA5UDerScqP8xUilFhcBulVLkbvkmlQv9hH
 eOIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF+fzzSAVJF7KLhmMb1ID4u01Bl7pSqusr8cMC87a9feY9p3FL65fm069SkVB1ayTo8pkfOLrv7g6AEEEAi8Lec23j
X-Gm-Message-State: AOJu0YxK4Ggh/9DyhQqyOrHrY5AyKI6J9n3MAFixXjwhX5CqYtDl5y+m
 DMLBmVvMwVxBAh15vZteMeXYsvbbVp4/L3cQsYLoILDA1jR1Dmxu5bylCA==
X-Google-Smtp-Source: AGHT+IHLr7ePqSyIVo8UXCTRdzEHo/AkBb0BNBgD40Jp8H2MQpDApHuv3b0ITxOx9Tn55FHLup5BZA==
X-Received: by 2002:a05:6300:6302:b0:1af:ac31:9b99 with SMTP id
 adf61e73a8af0-1b212ce2018mr944738637.1.1716505786812; 
 Thu, 23 May 2024 16:09:46 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 35/72] target/ppc: Add SMT support to PTCR SPR
Date: Fri, 24 May 2024 09:07:08 +1000
Message-ID: <20240523230747.45703-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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
index 7b525020ef..64131bf15c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -909,6 +909,10 @@ void spr_write_hior(DisasContext *ctx, int sprn, int gprn)
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


