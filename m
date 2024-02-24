Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448C1C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 07:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdmY4-0003Ot-Ao; Sat, 24 Feb 2024 02:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdmY1-0003OT-2M; Sat, 24 Feb 2024 02:34:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdmXz-0006R1-1b; Sat, 24 Feb 2024 02:34:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso16144595ad.2; 
 Fri, 23 Feb 2024 23:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708760048; x=1709364848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ffpylHd6r/rxXdJ/r1FmZMfZLpCLJv1GCpUd4V4nzgU=;
 b=CVVyDa0wWZUYcVmFCitPDCIo3mdpFTzUWmHDeDiXe3rh2VIAIkyWTwA6gWvHo4wjNr
 3P3l4fNiCqPN1VgDU6IaHqH2Qf0XBhB+sfQErTCsoxiKM8NlAcFrGd6RWKlfX9xWn0oN
 mfDdCa3UtsTkEMJwyqWzvbgRdju8XxFgrn+g0hPQkp7RXXC/qHVJRNGYtR+rZ0kUZRi5
 PDUynbDBQ4U6UgNyKCg6pneZRD13ue1dpkOf1aybN8CKiPpVLyahYngdnxGLsysfD5Kq
 GiM2IVPP39GLSy3BuO+p0RGA9pLZ+RA1zoGonSWQcY7b6rONubYbslko8fkZ/DuSv6v8
 ce5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708760048; x=1709364848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ffpylHd6r/rxXdJ/r1FmZMfZLpCLJv1GCpUd4V4nzgU=;
 b=K5VXHuaspRTXOrQRNzvFUWjE2+Rzh/Ws8VtoOahSq+/3Nf8Tze2bQhOlfZTr9ZSDhp
 YpeJXE8DbTAwROaN9uQ6BVDGyPzqqjTZ2tYErajEXvZ5KP84lddj31HHAP0LehW4dy2h
 1UnNumlTJybLdkSJK3NkClYSurW8V/nborsNF4xbxSAMYKY3hxK81Ne0aMosbQN662Nw
 w9xijsnhpwY63mBZU0XGOLS599948ZRulPyGfC27VhCPWK/xrtPh4HbTEOME842xkswK
 57v5k+nMXOOWIWOnIdEzGIlBEyIwlUMjmpoKy3H6+RJD2fq9QDAAY+O/bozd3vmakfjd
 zpEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXipG8XWvjL+bWyOntykvo0nyAyEBrOeGAJObMKpOZ0KOIxxtoFvN0HOQRM2ASnYqEyq5QkxJJ+Qbxq+RGaUzRdJyfuGCM=
X-Gm-Message-State: AOJu0YyqW4A+YYtV7geuxp+e2mYkmanvhRNtbjz0r2EgzVEhTHT7BEMA
 qIv+YAKeq0a7V5ijLNlquAD4dpVaQGdsww3oTcNcON4sIg4/anD4VQfgaxlJ
X-Google-Smtp-Source: AGHT+IHmTigLJZclLpoR0tlAWzsCtTAO7oDI1za5y/ZKj7ckBE8ttUT0GXxlpuw+Jld9CIqApwxIdQ==
X-Received: by 2002:a17:902:e74e:b0:1dc:211f:96d0 with SMTP id
 p14-20020a170902e74e00b001dc211f96d0mr2662238plf.3.1708760048284; 
 Fri, 23 Feb 2024 23:34:08 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 la4-20020a170902fa0400b001d901c2087esm496594plb.302.2024.02.23.23.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 23:34:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH] spapr: avoid overhead of finding vhyp class in critical
 operations
Date: Sat, 24 Feb 2024 17:33:59 +1000
Message-ID: <20240224073359.1025835-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PPC_VIRTUAL_HYPERVISOR_GET_CLASS is used in critical operations like
interrupts and TLB misses and is quite costly. Running the
kvm-unit-tests sieve program with radix MMU enabled thrashes the TCG
TLB and spends a lot of time in TLB and page table walking code. The
test takes 67 seconds to complete with a lot of time being spent in
code related to finding the vhyp class:

   12.01%  [.] g_str_hash
    8.94%  [.] g_hash_table_lookup
    8.06%  [.] object_class_dynamic_cast
    6.21%  [.] address_space_ldq
    4.94%  [.] __strcmp_avx2
    4.28%  [.] tlb_set_page_full
    4.08%  [.] address_space_translate_internal
    3.17%  [.] object_class_dynamic_cast_assert
    2.84%  [.] ppc_radix64_xlate

Keep a pointer to the class and avoid this lookup. This reduces the
execution time to 40 seconds.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This feels a bit ugly, but the performance problem of looking up the
class in fast paths can't be ignored. Is there a "nicer" way to get the
same result?

Thanks,
Nick

 target/ppc/cpu.h           |  3 ++-
 target/ppc/mmu-book3s-v3.h |  4 +---
 hw/ppc/pegasos2.c          |  1 +
 target/ppc/cpu_init.c      |  9 +++------
 target/ppc/excp_helper.c   | 16 ++++------------
 target/ppc/kvm.c           |  4 +---
 target/ppc/mmu-hash64.c    | 16 ++++------------
 target/ppc/mmu-radix64.c   |  4 +---
 8 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ec14574d14..eb85d9aa71 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1437,6 +1437,7 @@ struct ArchCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
+    PPCVirtualHypervisorClass *vhyp_class;
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
@@ -1535,7 +1536,7 @@ DECLARE_OBJ_CHECKERS(PPCVirtualHypervisor, PPCVirtualHypervisorClass,
 
 static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
 {
-    return PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp)->cpu_in_nested(cpu);
+    return cpu->vhyp_class->cpu_in_nested(cpu);
 }
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 674377a19e..f3f7993958 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -108,9 +108,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
     uint64_t base;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        return vhc->hpt_mask(cpu->vhyp);
+        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
     }
     if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
         ppc_v3_pate_t pate;
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 04d6decb2b..c22e8b336d 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -400,6 +400,7 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
     machine->fdt = fdt;
 
     pm->cpu->vhyp = PPC_VIRTUAL_HYPERVISOR(machine);
+    pm->cpu->vhyp_class = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(pm->cpu->vhyp);
 }
 
 enum pegasos2_rtas_tokens {
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9bccddb350..63d0094024 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6631,6 +6631,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     CPUPPCState *env = &cpu->env;
 
     cpu->vhyp = vhyp;
+    cpu->vhyp_class = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(vhyp);
 
     /*
      * With a virtual hypervisor mode we never allow the CPU to go
@@ -7224,9 +7225,7 @@ static void ppc_cpu_exec_enter(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->cpu_exec_enter(cpu->vhyp, cpu);
+        cpu->vhyp_class->cpu_exec_enter(cpu->vhyp, cpu);
     }
 }
 
@@ -7235,9 +7234,7 @@ static void ppc_cpu_exec_exit(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->cpu_exec_exit(cpu->vhyp, cpu);
+        cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
     }
 }
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 98952de267..445350488c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -840,9 +840,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
          * HV mode, we need to keep hypercall support.
          */
         if (lev == 1 && cpu->vhyp) {
-            PPCVirtualHypervisorClass *vhc =
-                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-            vhc->hypercall(cpu->vhyp, cpu);
+            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
@@ -1012,9 +1010,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
          * HV mode, we need to keep hypercall support.
          */
         if (lev == 1 && cpu->vhyp) {
-            PPCVirtualHypervisorClass *vhc =
-                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-            vhc->hypercall(cpu->vhyp, cpu);
+            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
@@ -1534,9 +1530,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
         /* "PAPR mode" built-in hypercall emulation */
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
-            PPCVirtualHypervisorClass *vhc =
-                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-            vhc->hypercall(cpu->vhyp, cpu);
+            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
@@ -1677,10 +1671,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     }
 
     if ((new_msr & MSR_HVB) && books_vhyp_handles_hv_excp(cpu)) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED call */
-        vhc->deliver_hv_excp(cpu, excp);
+        cpu->vhyp_class->deliver_hv_excp(cpu, excp);
 
         powerpc_reset_excp_state(cpu);
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 26fa9d0575..5b5b96ab6b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -862,9 +862,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
     sregs.pvr = env->spr[SPR_PVR];
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        sregs.u.s.sdr1 = vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
+        sregs.u.s.sdr1 = cpu->vhyp_class->encode_hpt_for_kvm_pr(cpu->vhyp);
     } else {
         sregs.u.s.sdr1 = env->spr[SPR_SDR1];
     }
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d645c0bb94..196b4b2a48 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -516,9 +516,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
     const ppc_hash_pte64_t *hptes;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        return vhc->map_hptes(cpu->vhyp, ptex, n);
+        return cpu->vhyp_class->map_hptes(cpu->vhyp, ptex, n);
     }
     base = ppc_hash64_hpt_base(cpu);
 
@@ -538,9 +536,7 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                             hwaddr ptex, int n)
 {
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
+        cpu->vhyp_class->unmap_hptes(cpu->vhyp, hptes, ptex, n);
         return;
     }
 
@@ -820,9 +816,7 @@ static void ppc_hash64_set_r(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
     hwaddr base, offset = ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_R;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
+        cpu->vhyp_class->hpte_set_r(cpu->vhyp, ptex, pte1);
         return;
     }
     base = ppc_hash64_hpt_base(cpu);
@@ -837,9 +831,7 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
     hwaddr base, offset = ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_C;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
+        cpu->vhyp_class->hpte_set_c(cpu->vhyp, ptex, pte1);
         return;
     }
     base = ppc_hash64_hpt_base(cpu);
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5823e039e6..496ba87a95 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -677,9 +677,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
 
     /* Get Partition Table */
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc;
-        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        if (!vhc->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
+        if (!cpu->vhyp_class->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
             if (guest_visible) {
                 ppc_radix64_raise_hsi(cpu, access_type, eaddr, eaddr,
                                       DSISR_R_BADCONFIG);
-- 
2.42.0


