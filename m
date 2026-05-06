Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD1CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvR-0002zr-62; Wed, 06 May 2026 10:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvK-0002hi-RL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:30 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvG-000259-PD
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso3167283f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076493; x=1778681293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2919rqkJppeOa8VQ6Pm1erdNf5b7nkiclQFbNM3i1/U=;
 b=XSluwTLv7s9zoyoR45aS/YFTMIJsQADZm7ZI4TRDne/NZYzc/UPdRQiq7g45hgkNy7
 7RyfPAwEyH14onBtqzwc2bMCCmQdypNwHv2cXk+32FfFwxp6ICVit+YVfzB2RZg4kN61
 Jcjg5Hb0OMuS0j2YFpNCTxlQSrPwcInBh+Pl5c9Bz3cHHVBOvMRKlDQJHDz9OWNOBavR
 i/H5IURZPBXJHCNrUATkKe7q/6GcYvrlJE8BFdDp38cic83G2l0g4K3y4pdlqbR0VFff
 sKkhb3xcyVtmCV9ZUtktVoEh/XTrlFBOcR6pPTj1A/aVo00FUG8UQZdJDNbF6qJAd+9B
 jAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076493; x=1778681293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2919rqkJppeOa8VQ6Pm1erdNf5b7nkiclQFbNM3i1/U=;
 b=JPZwkAYgI5EZRPVJt6lkyAkguK2iUUbbKvtyw/yy5H3XE3sks0+RjETvm/ZCuPd/ZX
 XqBJ3lIrc1AI5KkJPKCULjJfosfy/pDgqvt8x9gILU2GDozp1DoSbo8OX1VxUdQNzC7b
 6hm00Ql4pX1+Klrmq0fE2RFDeExO1H/IaqfmWSTBiKtneg4ipEC+ycU49KVpuLS2S4iK
 B10/jQYnkF5P0ESmAbY0ukkuc9Ep8/P32MUq/lQ+9P9/aJZKOI6BtIU4JYYW3t3YEAPm
 NLTqSgIvO+60PxrS/D/6lgI1ict7+Z2uUfahVax8vZPSeE+b9T/oTi1vHbcCtzpfoPVI
 GVWw==
X-Gm-Message-State: AOJu0YxVyxhqdZ3AoKIQ7M7qexbVcTtvzIOceVVuD6LgeB6duntQZpNA
 JlI5FmSAzkTRWh/QiJfO/9MyBjQ5tq9CS6S3j9j01DYgg61yDW0Qxk/8NBzwAfjMvH6uDMe045y
 4CSpfi0Y=
X-Gm-Gg: AeBDiesZt0SgzK20yJi7w9UlmHq9R3zPsixgUz6sYMl4TsAgOX1DF/0U+1uHq+Pj42H
 RlTnVRVXvCoL0YO93pXM7TBlqZ1FKopSwGA0qK+0gmcAhB2g8d3ZDwDdU2e7NDCWhmyZ3+p8Gql
 Us6v9C7sKcTvZPXBnq+jQgNiOkVc4Kr9bKaHje0/m2AdG0yBm2SfwV4F1JIBUGlNKmtaXreyJUP
 ikOt9TOpkfSL0o6ebs6BuUIdqauUMCbQsYAXUI4lC57L6JWJ9DnmbzAk0wJJQMvnwG0goWR0Eqp
 TyB23ihtMlxecH5411qP69y7GESJCxhPdNALOPeb4vzGMObIWLvo9T/u5aItwshulcoPiv1aFvD
 Lae1z3t3bIEJvVDnDZwSk4sxFjBbvdlMd9Sa2w8d52wsbiB+TEfkEk3XOvVrj1vkgJDeRQcJYXp
 J0+q2yKXcmndEL6fmPmOBqIJbLDKxKLlwztuhyB1ErERVGLYg46W+USTB3PpFF4OQG7RZ8ElMpl
 LAMkqbSBec=
X-Received: by 2002:a05:600c:41cc:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-48e51e0bc24mr31963625e9.6.1778076492741; 
 Wed, 06 May 2026 07:08:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530d8691sm41794565e9.2.2026.05.06.07.08.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 097/110] target/mips: Reduce CPUState scope when used with
 CPU_FOREACH()
Date: Wed,  6 May 2026 15:55:09 +0200
Message-ID: <20260506135524.20617-98-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When possible, reduce CPUState variable scope.
Prefer cpu_env(cpu) over &cpu->env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-8-philmd@linaro.org>
---
 target/mips/internal.h              | 11 ++++++-----
 target/mips/tcg/system/cp0_helper.c | 28 ++++++++++++++++------------
 target/mips/tcg/system/tlb_helper.c |  7 +++----
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 95b8b7bb9c9..2fd5ffa304a 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -280,7 +280,7 @@ static inline int mips_vpe_active(CPUMIPSState *env)
 
 static inline int mips_vp_active(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
+    CPUState *cs = first_cpu;
 
     /* Check if the VP disabled other VPs (which means the VP is enabled) */
     if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
@@ -288,10 +288,11 @@ static inline int mips_vp_active(CPUMIPSState *env)
     }
 
     /* Check if the virtual processor is disabled due to a DVP */
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
-        if ((&other_cpu->env != env) &&
-            ((other_cpu->env.CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
+    CPU_FOREACH(cs) {
+        CPUMIPSState *other_env = cpu_env(cs);
+
+        if ((other_env != env) &&
+            ((other_env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
             return 0;
         }
     }
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 123d5c217c1..8b83ba16399 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -1566,13 +1566,14 @@ target_ulong helper_emt(void)
 
 target_ulong helper_dvpe(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
     MIPSCPU *cpu = env_archcpu(env);
     target_ulong prev = cpu->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
-        CPU_FOREACH(other_cs) {
-            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+        CPUState *cs = first_cpu;
+
+        CPU_FOREACH(cs) {
+            MIPSCPU *other_cpu = MIPS_CPU(cs);
             /* Turn off all VPEs except the one executing the dvpe.  */
             if (&other_cpu->env != env) {
                 other_cpu->mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
@@ -1585,13 +1586,14 @@ target_ulong helper_dvpe(CPUMIPSState *env)
 
 target_ulong helper_evpe(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
     MIPSCPU *cpu = env_archcpu(env);
     target_ulong prev = cpu->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
-        CPU_FOREACH(other_cs) {
-            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+        CPUState *cs = first_cpu;
+
+        CPU_FOREACH(cs) {
+            MIPSCPU *other_cpu = MIPS_CPU(cs);
 
             if (&other_cpu->env != env
                 /* If the VPE is WFI, don't disturb its sleep.  */
@@ -1608,12 +1610,13 @@ target_ulong helper_evpe(CPUMIPSState *env)
 /* R6 Multi-threading */
 target_ulong helper_dvp(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
     target_ulong prev = env->CP0_VPControl;
 
     if (!((env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
-        CPU_FOREACH(other_cs) {
-            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+        CPUState *cpu = first_cpu;
+
+        CPU_FOREACH(cpu) {
+            MIPSCPU *other_cpu = MIPS_CPU(cpu);
             /* Turn off all VPs except the one executing the dvp. */
             if (&other_cpu->env != env) {
                 mips_vpe_sleep(other_cpu);
@@ -1626,12 +1629,13 @@ target_ulong helper_dvp(CPUMIPSState *env)
 
 target_ulong helper_evp(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
     target_ulong prev = env->CP0_VPControl;
 
     if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
-        CPU_FOREACH(other_cs) {
-            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+        CPUState *cpu = first_cpu;
+
+        CPU_FOREACH(cpu) {
+            MIPSCPU *other_cpu = MIPS_CPU(cpu);
             if ((&other_cpu->env != env) && !mips_vp_is_wfi(other_cpu)) {
                 /*
                  * If the VP is WFI, don't disturb its sleep.
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index b989c7e5bd5..45cbeb40a2d 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -346,15 +346,14 @@ void helper_ginvt(CPUMIPSState *env, target_ulong arg, uint32_t type)
     uint32_t invMsgVPN2 = arg & (TARGET_PAGE_MASK << 1);
     uint8_t invMsgR = 0;
     uint32_t invMsgMMid = env->CP0_MemoryMapID;
-    CPUState *other_cs = first_cpu;
+    CPUState *cpu = first_cpu;
 
 #ifdef TARGET_MIPS64
     invMsgR = extract64(arg, 62, 2);
 #endif
 
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
-        global_invalidate_tlb(&other_cpu->env, invMsgVPN2, invMsgR, invMsgMMid,
+    CPU_FOREACH(cpu) {
+        global_invalidate_tlb(cpu_env(cpu), invMsgVPN2, invMsgR, invMsgMMid,
                               invAll, invVAMMid, invMMid, invVA);
     }
 }
-- 
2.53.0


