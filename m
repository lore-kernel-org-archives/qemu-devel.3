Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEBDC25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELj-0007zi-Lj; Mon, 20 May 2024 21:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELh-0007yS-Vj; Mon, 20 May 2024 21:31:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELf-0005ON-UN; Mon, 20 May 2024 21:31:29 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f0537e39b3so90452225ad.3; 
 Mon, 20 May 2024 18:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255086; x=1716859886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkT0FWB24KQBqdJ8LIoXwTuEUugVA4P7cz61QMqZCII=;
 b=grROf15uNbyQ+pUpfpx90evdswIkOBMy1Ldbsxgno4s3uL/T/IOkXrkpEpuP7KJLdh
 wlhNiQmcWYw86y8o62pqSVPiyDqo1dqJ8Mbi4cI2cQlab3xfwschxy3orMZ6dLyFRnA7
 HnOD13alEoNB/SrmDIjPKDv9TtvzvIif+APjKZLqbtr3RoNaeOdXAEcmIevmwSqXHkSa
 3+Cd9RMR3o9tA/G3uNvOCDlbTAUIQEh+C/LMBSSnzKMUxteDDmfo/AB8WSJAzT69cYmp
 UuWBT6gc9O7b970id7WeJtWWqPCXW0sDzoFFzvaZkBKnvO23mi8FhMMaFdSAVIds4Y8X
 OFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255086; x=1716859886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkT0FWB24KQBqdJ8LIoXwTuEUugVA4P7cz61QMqZCII=;
 b=FE/v54g2vcIpPhySyIKRrgD+vbG1xCngs9kZ2T42flEnT1tWFM0sQIVd+kyQpYPC3n
 kUWiU1LUo4l7wyGcbj2YN44CQoI7xdinECdHxgFCA+tweoaBbrt0DeBbVl+zWKmQwhJ0
 AMB+vcMomzI8UiGyQy2JpbusEuz0ZrF+zHiAekrMTW9ZryqBU53kWOHPDR/FLQDweTIw
 zQzjvnzBs7Syj/cJOPXSvdb+1/bKNFuAQFyptiBUKGpoc/dJui2adT7mrBdQlPgy3SGs
 XS8YHigFcCLgS8n+1sjjQ1CwBJJ0qLbNH/BC4cgNkhsHS7wnDXs3jqqC10zKyCact9zv
 EQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYvT1j/8nm/xeBVo/DjyxMuCYaNNPyQoOAeiWaiAdLkDwHyB/gkMrseUkfXBEzX1Cu5fo3mrprktHEFBXewRZ+zX4a0n0=
X-Gm-Message-State: AOJu0YyzmdDaFRkoNpNryJdkeK7nhFreBK+sUkWooyX4BSau+kky6rKD
 2n63sm1cwHS+hkRtGsZ3/ZQlyJ34lUqIRz95x5nKZubl92kqxTDvuefR0g==
X-Google-Smtp-Source: AGHT+IF5QKp04E5MXYkw7XZOLh61QQ03MEhxOpI15f+MRhI9g7q32x5wrUaSrl+Ti/lII9XeH5sz/A==
X-Received: by 2002:a17:90a:5502:b0:2ac:40c8:1ed3 with SMTP id
 98e67ed59e1d1-2b6cc342957mr28346504a91.5.1716255086033; 
 Mon, 20 May 2024 18:31:26 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:31:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 12/12] target/ppc: add SMT support to msgsnd broadcast
Date: Tue, 21 May 2024 11:30:28 +1000
Message-ID: <20240521013029.30082-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

msgsnd has a broadcast mode that sends hypervisor doorbells to all
threads belonging to the same core as the target. A "subcore" mode
sends to all or one thread depending on 1LPAR mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                              |  6 +-
 target/ppc/helper.h                           |  2 +-
 target/ppc/excp_helper.c                      | 57 +++++++++++++------
 .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e4c342b17d..e201b7f6c2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1163,7 +1163,11 @@ FIELD(FPSCR, FI, FPSCR_FI, 1)
 
 #define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
 
-#define DBELL_BRDCAST                  PPC_BIT(37)
+#define DBELL_BRDCAST_MASK             PPC_BITMASK(37, 38)
+#define DBELL_BRDCAST_SHIFT            25
+#define DBELL_BRDCAST_SUBPROC          (0x1 << DBELL_BRDCAST_SHIFT)
+#define DBELL_BRDCAST_CORE             (0x2 << DBELL_BRDCAST_SHIFT)
+
 #define DBELL_LPIDTAG_SHIFT            14
 #define DBELL_LPIDTAG_MASK             (0xfff << DBELL_LPIDTAG_SHIFT)
 #define DBELL_PIRTAG_MASK              0x3fff
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 57bf8354e7..dd92c6a937 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -695,7 +695,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
 
 DEF_HELPER_1(msgsnd, void, tl)
 DEF_HELPER_2(msgclr, void, env, tl)
-DEF_HELPER_1(book3s_msgsnd, void, tl)
+DEF_HELPER_2(book3s_msgsnd, void, env, tl)
 DEF_HELPER_2(book3s_msgclr, void, env, tl)
 #endif
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e786a9044b..0a9e8539a4 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2978,7 +2978,7 @@ void helper_msgsnd(target_ulong rb)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *cenv = &cpu->env;
 
-        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
+        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
             ppc_set_irq(cpu, irq, 1);
         }
     }
@@ -2997,6 +2997,16 @@ static bool dbell_type_server(target_ulong rb)
     return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
 }
 
+static inline bool dbell_bcast_core(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
+}
+
+static inline bool dbell_bcast_subproc(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
@@ -3006,32 +3016,43 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
     ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
 }
 
-static void book3s_msgsnd_common(int pir, int irq)
+void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
 {
-    CPUState *cs;
+    int pir = rb & DBELL_PROCIDTAG_MASK;
+    bool brdcast = false;
+    CPUState *cs, *ccs;
+    PowerPCCPU *cpu;
 
-    bql_lock();
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *cenv = &cpu->env;
+    if (!dbell_type_server(rb)) {
+        return;
+    }
 
-        /* TODO: broadcast message to all threads of the same  processor */
-        if (cenv->spr_cb[SPR_PIR].default_value == pir) {
-            ppc_set_irq(cpu, irq, 1);
-        }
+    cpu = ppc_get_vcpu_by_pir(pir);
+    if (!cpu) {
+        return;
     }
-    bql_unlock();
-}
+    cs = CPU(cpu);
 
-void helper_book3s_msgsnd(target_ulong rb)
-{
-    int pir = rb & DBELL_PROCIDTAG_MASK;
+    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
+                                 (env->flags & POWERPC_FLAG_SMT_1LPAR))) {
+        brdcast = true;
+    }
 
-    if (!dbell_type_server(rb)) {
+    if (cs->nr_threads == 1 || !brdcast) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
         return;
     }
 
-    book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
+    /*
+     * Why is bql needed for walking CPU list? Answer seems to be because ppc
+     * irq handling needs it, but ppc_set_irq takes the lock itself if needed,
+     * so could this be removed?
+     */
+    bql_lock();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
+    }
+    bql_unlock();
 }
 
 #ifdef TARGET_PPC64
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index 0142801985..8abbb89630 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -59,7 +59,7 @@ static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
 
 #if !defined(CONFIG_USER_ONLY)
     if (is_book3s_arch2x(ctx)) {
-        gen_helper_book3s_msgsnd(cpu_gpr[a->rb]);
+        gen_helper_book3s_msgsnd(tcg_env, cpu_gpr[a->rb]);
     } else {
         gen_helper_msgsnd(cpu_gpr[a->rb]);
     }
-- 
2.43.0


