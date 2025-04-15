Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13AAC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bRF-0003SQ-Bc; Tue, 15 Apr 2025 04:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQo-0001dJ-B7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQT-00022W-PP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224191d92e4so50379155ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704824; x=1745309624; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=byOo/KqqWXeR72ANJUzCRKebW2bLJp2ySZr8t52WqcA=;
 b=PezG+Q5z+ZJDIykrAzAVlQ0v7qYFBpKpACr/yHrq33MDgu0s8HFPj771YwShVL6s0Z
 ONcY2F38Tdh4dPjlii1IaKEOH+/vZUP/E6rsW2YDRDnTViYSAOJ0K8PR26spgK3HuZDQ
 vkxMHn9SsOYcEgDR1m+15Cyflq7uaF0qi7qblgNOA+nrwnZCU/vJGg8uBfhKcRGjdPwX
 pn7j8T6j0h1kOr/z0hG2H0ifLH9PzpjvP+2skqaEWncVXShJYW/Zy5t2k+L9H+LCqrDi
 cUrO0FbATbVqGSBVUa6srjiCyQviOJW4lMPK150Ind4dZQPPWs/5UFIghOq5/ZKGlKUJ
 Ikmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704824; x=1745309624;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byOo/KqqWXeR72ANJUzCRKebW2bLJp2ySZr8t52WqcA=;
 b=LHNQeOqASAFJK6kR8cP8HXeYOGTYcD+LjJjVix5NAwYzUlEnPp/iLkVFe1e2rOJu/C
 ZZs39ee+d0uueT5LE7kZWAYrbuLpK6umF+lfUsFrlZnorpB6OMTOGALMoUHO54rUfzWW
 Y8VrxEr7imA0RAFEaKx9eNibJCl2AY6OISs/rmq90Tb4VKxWoTdxMniSmQrTAdiiNFeV
 kW7+dTTStVDuQxxvtpNMTlaHOVrvQBcyyO5Flw5b5/kefIW/ODZNU8VZNKCHlqVV6ZSN
 MrJrTdSfyT2tUSmL2tykUjcxP/yGkDED3UThrWkHNAUXV74m4fwhZj+uCmx6IaYSLgjc
 yDRA==
X-Gm-Message-State: AOJu0Yw8K06C56W71fP3hxPtJmdQBJ8ykYYOv6ZxPD4sWdWFmL2QjWMM
 o6hk0AnfuqayHg4Ol8AKZLTpW5y4UT/KpiEc+UbufEf5HeNW+JxZwbBV9Vt/73UswVUXVG2DYSR
 OWrP9k5727GWQXPINEDzbuiKUEeIzY3gPAJUr/qm3gtvKtASusvavHl98l6XbNVNkDThCe3u/zy
 NsVwCX07msEyfEUmBjriOLsm6yeqv1vXVYaUil
X-Gm-Gg: ASbGncvhXhiIdexeKAgqcw+bibpwtt0sUceW4zqw8VJDvfUhusdv3Dmu24tqWGaGWcj
 yOWos2VFBSBskZVgxQ0g6IqhTWige3Ns+EkVRhZGN5MEANF9upABQ4mA0ATsbPsANlUlzVhber9
 mbBDrz7unEFt4uyvh6UsE+teq74u+Py1GC8yQQXWlkEYoFdCfaniSrlSZN2pf8edvk1qi03fZjb
 ywo431icM6UKAscFhpcdRntIZmbKmWSjxDok3q3AwMpZdFQ2XE8G2Mx/oT/AE/Yry6rcBlHrSZv
 y9Gf1ANffo2tLBeelzJut0WKHQiICQfXbqg4s5AlWS62AdUzb9if6pHk1Nx1Nuqgd0XDAycfHA=
 =
X-Google-Smtp-Source: AGHT+IGyx8GvBTfmVgXY2piG+6l11HV9bx2iR0uLFsFb3SZqWdv2RIXzDpAZu8eh+htZungiwJ98jw==
X-Received: by 2002:a17:903:3c6d:b0:224:a74:28c2 with SMTP id
 d9443c01a7336-22bea4c3e94mr246673185ad.29.1744704823797; 
 Tue, 15 Apr 2025 01:13:43 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:43 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 10/17] target/riscv: Add WID to MemTxAttrs of CPU memory
 transactions
Date: Tue, 15 Apr 2025 16:12:24 +0800
Message-Id: <20250415081231.21186-11-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When a RISC-V HART has WG extension, their memory transactions will
contain WID. Support MemTxAttrs in RISC-V target and add WID inside if
a HART has WG extension.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 51 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1dbeac0509..1aba6dd853 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3035,7 +3035,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
+    .get_phys_page_attrs_debug = riscv_cpu_get_phys_page_attrs_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .legacy_vmsd = &vmstate_riscv_cpu,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7bffe62f70..1fdeee7708 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -584,6 +584,7 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
 bool cpu_get_bcfien(CPURISCVState *env);
 bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
+hwaddr riscv_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr, MemTxAttrs *attrs);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2c3a0d903b..944a5b7ee1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -232,6 +232,34 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 }
 
 #ifndef CONFIG_USER_ONLY
+static uint32_t riscv_cpu_wg_get_wid(CPURISCVState *env, int mode)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    bool virt = env->virt_enabled;
+
+    if (mode == PRV_M) {
+        return cpu->cfg.mwid;
+    } else if (mode == PRV_S) {
+        if (!virt || !env->mwiddeleg) {
+            /* HS-mode, S-mode w/o RVH, or VS-mode but mwiddeleg = 0 */
+            return env->mlwid;
+        } else {
+            /* VS-mode */
+            return env->slwid;
+        }
+    } else if (mode == PRV_U) {
+        if (!riscv_has_ext(env, RVS) || !env->mwiddeleg) {
+            /* M/U mode CPU or mwiddeleg = 0 */
+            return env->mlwid;
+        } else {
+            return env->slwid;
+        }
+    }
+
+    return cpu->cfg.mwid;
+}
+
 void riscv_cpu_set_wg_mwid(CPURISCVState *env, uint32_t mwid)
 {
     CPUState *cs = env_cpu(env);
@@ -1768,13 +1796,22 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr riscv_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr, MemTxAttrs *attrs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
     int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
+    int mode = mmuidx_priv(mmu_idx);
+    uint32_t wid;
+
+    if (riscv_cpu_cfg(env)->ext_smwg && env->wid_to_mem_attrs) {
+        wid = riscv_cpu_wg_get_wid(env, mode);
+        env->wid_to_mem_attrs(attrs, wid);
+    } else {
+        *attrs = MEMTXATTRS_UNSPECIFIED;
+    }
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, env->virt_enabled, true, false)) {
@@ -1886,12 +1923,20 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
     hwaddr tlb_size = TARGET_PAGE_SIZE;
+    uint32_t wid;
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
 
     env->guest_phys_fault_addr = 0;
 
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
+    if (riscv_cpu_cfg(env)->ext_smwg && env->wid_to_mem_attrs) {
+        mode = mmuidx_priv(mmu_idx);
+        wid = riscv_cpu_wg_get_wid(env, mode);
+        env->wid_to_mem_attrs(&attrs, wid);
+    }
+
     pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
@@ -1984,8 +2029,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
-                     prot, access_type, mmu_idx, tlb_size);
+        tlb_set_page_with_attrs(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
+                                attrs, prot, access_type, mmu_idx, tlb_size);
         return true;
     } else if (probe) {
         return false;
-- 
2.17.1


