Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D80C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHa1-0004eC-MS; Thu, 23 May 2024 19:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZP-000228-UL; Thu, 23 May 2024 19:10:01 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZN-0005rd-RS; Thu, 23 May 2024 19:09:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f5053dc057so4049416b3a.2; 
 Thu, 23 May 2024 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505795; x=1717110595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Gn8mYqupsKQ/pBe/wMJEus3gEH8ANhWgPrzZvjVBR0=;
 b=ZGdOsT7XPHJ8Pb8WNNbOVQT9a/GgTptR9xXI8NvU9u6641gUR6Bn+Orf4QZUVn1FUW
 W1yDrm1nIjgW+opy10CkIQbyvhFWKl1R2X1pNVM3N9Zfvqc88mofeoGyZBzuBTG+EUN7
 mwcTIMeaOis/6854BDzDnv08kx8OofgA9P4f8U53GjJK3Wq9qYTq7kZhxSGWfonfBIph
 2Zwkm6fFeuE7SD3QnPnFOsCP6lX9VqI1dYdp1wy/hywJUj1mifKZTk/OQNGqryKN7jF/
 7fVcD+8xwqOSsTYRX++EMaf/Sw8Y/GxF9GpWRYIhesXrUk90IBBjR9fvcgkKge5I9YsC
 swNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505795; x=1717110595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Gn8mYqupsKQ/pBe/wMJEus3gEH8ANhWgPrzZvjVBR0=;
 b=Gr+TAk/wRxdST/tG1rko7Q5GBje7MKeBm2n4bhE1IrTeVjvvFvk+tjHMDlindDr+Df
 a303UkInIMlnhVsWt1nnpWykDm55lyOi8KUOFgQwT7QJsqbpB5nRKSLq566ZVjyk6O5D
 HowGIHavRM3anVsauqvgTglHvcF6ZN3ew0Mevp0yvhNID1famqOV1/Hz3VW97y1zsRTf
 e2oD3Wfk3qPCT1Vr3H+wz4d2ZND0dZFZpIn9Ii5vGZAk848nCvt1WYLcJqEwOMP6Xq/L
 D+3MTILZOmFVRvDRlwwt7DghFSkzJeaDpOxfYmhT4+yq77sGuwZJikz34xlTwLSVorfq
 a7bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwe65ZOFYNCBmMzpXsu5O1Ei4HAIsmmPY4NPgd90r4oXKbEzqIjRK/km+xMbHEJdI8bwbI6WFqY7PCfsPfT6nJTXlX
X-Gm-Message-State: AOJu0YwXqNTTRwLlSey0jzX5SVzc/CSuf4X5BUQljEG3ikXS4LEKDf8D
 XngLkBaSJWq1sOJBqmx2fmBEJ7ac6Hq4oylKlVRnSuyetPBjpvZfQUtH/w==
X-Google-Smtp-Source: AGHT+IGu9oxH4+enlS6onB28Spk/BvQVJ6jU6D0FH1fUDSASxo/09I3sJtw9ICU0k2iVVMiq8Ocp4A==
X-Received: by 2002:a05:6a20:9718:b0:1af:ccd9:4b1d with SMTP id
 adf61e73a8af0-1b212d1beb4mr825163637.22.1716505795430; 
 Thu, 23 May 2024 16:09:55 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 38/72] target/ppc: add SMT support to msgsnd broadcast
Date: Fri, 24 May 2024 09:07:11 +1000
Message-ID: <20240523230747.45703-39-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                              |  6 +-
 target/ppc/excp_helper.c                      | 57 +++++++++++++------
 target/ppc/helper.h                           |  2 +-
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
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f48eb2eac8..0cd542675f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2969,7 +2969,7 @@ void helper_msgsnd(target_ulong rb)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *cenv = &cpu->env;
 
-        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
+        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
             ppc_set_irq(cpu, irq, 1);
         }
     }
@@ -2988,6 +2988,16 @@ static bool dbell_type_server(target_ulong rb)
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
@@ -2997,32 +3007,43 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
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


