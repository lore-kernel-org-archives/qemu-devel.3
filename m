Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F211C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbX-00029T-Jn; Thu, 23 May 2024 19:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaz-00083l-Ha; Thu, 23 May 2024 19:11:37 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHax-0006PE-Dt; Thu, 23 May 2024 19:11:37 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b5254f9c32so2663141eaf.0; 
 Thu, 23 May 2024 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505893; x=1717110693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUIv6gOUQGMH2IYnVoR6s2tHYavWJsXfOY+eWwUBs6A=;
 b=ZjDuldC2Q9HypDeol0QD92Ovlqkknqb38v/QiYh2sput5CVhBMBs08j2NLaJQ98zmi
 72/XqKn6p+rQCYSSAyTuc5V5p4hh7gipC7OB762YdevO5IbMaLQfCOij33FbiVn5yE7B
 IHI4H3OUu/v/2Nzhx4gSts2vJUpx17dqwsSEbiV+7u7qO+J12qpf2flObmtkaaNk22l8
 GfvIff1cHzruHNjoNZVe6G7zCKiHDUrNvmyB7jCrsFUr+/0+EIgQXd+0p0UmZQA0kR0C
 mqf8FxXeAC3KVOqlEDdCrtYZzxzEkhU2TynL5rT6GT4pVTCzXagf6RPBMh/5eC1LtTfV
 m3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505893; x=1717110693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUIv6gOUQGMH2IYnVoR6s2tHYavWJsXfOY+eWwUBs6A=;
 b=Q+LB/6WJCvNTSJXtjnVpB8rObQL0yGQyegUNQxEutNNlNUn+f8rRvuSBt0p39lIko1
 0u/1NtEK3vjBl7iHJRVRCCg4OzuJn/HL/OFlgUMe4fhmYxlfeUpZ1dmwK0Z3kABJXDVE
 CzEBzEo6q2yURw6FSloDDDINCEoc0gBh7FeyJqn5QDbIEFOs8hFtav5prXszEhUGlF0f
 MC06owTqujG1L8ZQ74g5gt5h1GrLLFw/+zKWkww6Js1JUcP03D/M4I7MQyoAVQKhtFLQ
 d6yEGJA+e7fn6b0pENdQ0WX5rhcA/YkDZqfuPzk+dbEDcFDs0L+qoVhamYd8uqDEsT8I
 SRWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3DOxDAkSSejgrnIPbYK4o3d6zcyd7rpXoAQcBiIEjJu0ZZO66yroFhowK3BqbmSq+omrlZmx/HcsuuUcGJde4ffrH
X-Gm-Message-State: AOJu0YyYyye/6J0s0YiUx7/J5MdGLnmOjL1sjPM8RyBc9QgWOWhOrk+p
 B+ufYfH5ZWyfmPso9AoOqbYYSmuPwDRcK4oXnRjE+GVk6v/39/yT6fUXDQ==
X-Google-Smtp-Source: AGHT+IHqPLTeFCd2/EXj3sO3S/gqnVIsVSbzr5jRBv5DvB4NtUawQ7iISJFJncNgWSXKNkwpI7thAQ==
X-Received: by 2002:a05:6358:341d:b0:18d:b8bf:dff with SMTP id
 e5c5f4694b2df-197e48162a8mr103895155d.0.1716505892421; 
 Thu, 23 May 2024 16:11:32 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 70/72] target/ppc: Add a function to check for page protection
 bit
Date: Fri, 24 May 2024 09:07:43 +1000
Message-ID: <20240523230747.45703-71-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Checking if a page protection bit is set for a given access type is a
common operation. Add a function to avoid repeating the same check at
multiple places. As this relies on access type and page protection bit
values having certain relation also add an assert to ensure that this
assumption holds.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c    |  5 +++++
 target/ppc/internal.h    | 23 +++++------------------
 target/ppc/mmu-hash32.c  |  6 +++---
 target/ppc/mmu-hash64.c  |  2 +-
 target/ppc/mmu-radix64.c |  2 +-
 target/ppc/mmu_common.c  | 26 +++++++++++++-------------
 6 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b1ea301e22..01e358a4a5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7521,6 +7521,11 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &ppc_sysemu_ops;
     INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics = ppc_get_irq_stats;
+
+    /* check_prot_access_type relies on MMU access and PAGE bits relations */
+    qemu_build_assert(MMU_DATA_LOAD == 0 && MMU_DATA_STORE == 1 &&
+                      MMU_INST_FETCH == 2 && PAGE_READ == 1 &&
+                      PAGE_WRITE == 2 && PAGE_EXEC == 4);
 #endif
 
     cc->gdb_num_core_regs = 71;
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 4a90dd2584..20fb2ec593 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -234,27 +234,14 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
 void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
 const gchar *ppc_gdb_arch_name(CPUState *cs);
 
-/**
- * prot_for_access_type:
- * @access_type: Access type
- *
- * Return the protection bit required for the given access type.
- */
-static inline int prot_for_access_type(MMUAccessType access_type)
+#ifndef CONFIG_USER_ONLY
+
+/* Check if permission bit required for the access_type is set in prot */
+static inline int check_prot_access_type(int prot, MMUAccessType access_type)
 {
-    switch (access_type) {
-    case MMU_INST_FETCH:
-        return PAGE_EXEC;
-    case MMU_DATA_LOAD:
-        return PAGE_READ;
-    case MMU_DATA_STORE:
-        return PAGE_WRITE;
-    }
-    g_assert_not_reached();
+    return prot & (1 << access_type);
 }
 
-#ifndef CONFIG_USER_ONLY
-
 /* PowerPC MMU emulation */
 
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 3abaf16e78..1e8f1df0f0 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -252,7 +252,7 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     }
 
     *prot = key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
-    if (*prot & prot_for_access_type(access_type)) {
+    if (check_prot_access_type(*prot, access_type)) {
         *raddr = eaddr;
         return true;
     }
@@ -403,7 +403,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     if (env->nb_BATs != 0) {
         raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, mmu_idx);
         if (raddr != -1) {
-            if (prot_for_access_type(access_type) & ~*protp) {
+            if (!check_prot_access_type(*protp, access_type)) {
                 if (guest_visible) {
                     if (access_type == MMU_INST_FETCH) {
                         cs->exception_index = POWERPC_EXCP_ISI;
@@ -471,7 +471,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     prot = ppc_hash32_pte_prot(mmu_idx, sr, pte);
 
-    if (prot_for_access_type(access_type) & ~prot) {
+    if (!check_prot_access_type(prot, access_type)) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
         if (guest_visible) {
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index accbf0b2d8..cbc8efa0c3 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1089,7 +1089,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     amr_prot = ppc_hash64_amr_prot(cpu, pte);
     prot = exec_prot & pp_prot & amr_prot;
 
-    need_prot = prot_for_access_type(access_type);
+    need_prot = check_prot_access_type(PAGE_RWX, access_type);
     if (need_prot & ~prot) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index c1e4f00335..5a02e4963b 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -209,7 +209,7 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
     }
 
     /* Check if requested access type is allowed */
-    if (prot_for_access_type(access_type) & ~*prot) {
+    if (!check_prot_access_type(*prot, access_type)) {
         /* Page Protected for that Access */
         *fault_cause |= access_type == MMU_INST_FETCH ? SRR1_NOEXEC_GUARD :
                                                         DSISR_PROTFAULT;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 78bdbd506c..5414a14aad 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -114,11 +114,6 @@ static int pp_check(int key, int pp, int nx)
     return access;
 }
 
-static int check_prot(int prot, MMUAccessType access_type)
-{
-    return prot & prot_for_access_type(access_type) ? 0 : -2;
-}
-
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code)
 {
@@ -165,13 +160,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
             ctx->prot = access;
-            ret = check_prot(ctx->prot, access_type);
-            if (ret == 0) {
+            if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
+                ret = 0;
             } else {
                 /* Access right violation */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+                ret = -2;
             }
         }
     }
@@ -354,12 +350,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
                     (virtual & 0x0001F000);
                 /* Compute access rights */
                 ctx->prot = prot;
-                ret = check_prot(ctx->prot, access_type);
-                if (ret == 0) {
+                if (check_prot_access_type(ctx->prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
                                   " prot=%c%c\n", i, ctx->raddr,
                                   ctx->prot & PAGE_READ ? 'R' : '-',
                                   ctx->prot & PAGE_WRITE ? 'W' : '-');
+                    ret = 0;
+                } else {
+                    ret = -2;
                 }
                 break;
             }
@@ -576,9 +574,11 @@ static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
 check_perms:
             /* Check from TLB entry */
             *prot = tlb->prot;
-            ret = check_prot(*prot, access_type);
-            if (ret == -2) {
+            if (check_prot_access_type(*prot, access_type)) {
+                ret = 0;
+            } else {
                 env->spr[SPR_40x_ESR] = 0;
+                ret = -2;
             }
             break;
         }
@@ -636,7 +636,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     } else {
         *prot = (tlb->prot >> 4) & 0xF;
     }
-    if (*prot & prot_for_access_type(access_type)) {
+    if (check_prot_access_type(*prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
@@ -838,7 +838,7 @@ found_tlb:
             *prot |= PAGE_EXEC;
         }
     }
-    if (*prot & prot_for_access_type(access_type)) {
+    if (check_prot_access_type(*prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
-- 
2.43.0


