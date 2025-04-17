Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC828C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Msw-0008Kj-KN; Thu, 17 Apr 2025 06:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msk-0007jl-Au
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msf-0003US-8R
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:08 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso446400b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887244; x=1745492044; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=byOo/KqqWXeR72ANJUzCRKebW2bLJp2ySZr8t52WqcA=;
 b=Wui/iPjQNqkeBTH46WqcPSha8S8S/Kg9Usj/hRPoJi2Itt3NFaWvnfDBKQ1le02IpD
 zQipbObLgYvqyiMrL/YK5AZ/4h4Un2Nv3Df4XbfNe+7x+w3dRaUhNxkXYE7ZVAhjtOzC
 0jlEvZKCmTlC1SxNX0AhDRqxwzSYbh4jdSxQGI8wKJn9ZFE+WCrpr80y5aVbkWqJovs0
 y4CO7FY4+hlBF4Hm4SxcwT+us52ervpx0egLTbTqNbvZ6r2ZC9NJstRUimZLbHNVSI5i
 jpdKlBd+gqbYzoyh9QzDzzHBE+iL526wI2XcjaapVUbbh0J5qzp8ZahT5/It+OTddfvu
 M9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887244; x=1745492044;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byOo/KqqWXeR72ANJUzCRKebW2bLJp2ySZr8t52WqcA=;
 b=eETBNxgqnp0Es1qUzx1Pik+cWdgiTo1tc2ErBGbiP+DsqIVEzk4/83Z4uVCBOq2uds
 UxpEduGIxt/nw2tZR85lq1I5vdaurP1IB50HSt+v9V/yfAxZsR2WCXCgAuypBq9/Ib81
 2i0kl4iDmatpWqJV2xcw8PyrK8sWkWbV9fcuioPB66TZGJcSmUcgPJ9xLhoy/xEhePDy
 yzfji9gD7sWsEIlL1XIx9umzB4qdQrqWDG/4QPQw+aWsEPKKilq/s97ncEj9a2MSp1Sl
 WLX/zobiB0nwS+10yypEidP/rUcbVSEXg/BjZIgO4sgP/NqDe7tJOQhEiks/2TYvaMkp
 Z7og==
X-Gm-Message-State: AOJu0Yx3Wb5khgbXl0FsL1W2YoOZ9mfuohR2etRkjK8cCNm+omMB15SM
 NDJMeSHaWEYllQZG1Wrr1rRQ4ddYLOALcNbYMUhvltqVAJY0S85GjOmmDyoyi8KYhFgxV7GIhAC
 Pc5yVR7cgTKXZW7YpjyLQK4K3pB37+LbzQSWaJ0LdllZpdv//xsaOaGLm7n/ReFb33sbGm2PRdv
 ygAr35tyCUUmUjk/GdIPjc8iaeoas07XZk6g==
X-Gm-Gg: ASbGnct9dbGBoZDcWpjfJJzDwuEWZrB+WFUohevjqeKO9s24ST4kp/2hu1nFcFmwYJC
 MiFw4gcc/4Uhgl4kquUlSCnqRf2vHSQizRRDBwGfZ3SyivWoOX8iw1khlbycefmmMzbfrYlWbvx
 1h/G51Q8iebHEd6d4ZMOwO2PVHl5RXYDxW3liUyycGzAWOC4BUwezAktZV9yNMp7FTZVeFR/2sA
 xb3je3Kl80ar1nwDB8T+f9N0T8IU+uXKEsYBFV3WgWqY58cQ/Jwps8VnGB7yiLlzNS7rmGqWCyW
 dRZrokBMH+lGzfRNIeKn3OmNYCYUqBc6wiFuug2w32t9Nk5PEfLG0wir42igE8KSnzYrwla6PQ=
 =
X-Google-Smtp-Source: AGHT+IEBfmhmq1YHPMJByKurQOo2En1pY4GxzZObr4BYoP3yevnGlsYQpo9lA6t2Ux0hX5nMOmOdjw==
X-Received: by 2002:a05:6a20:e18a:b0:1f5:7ba7:69d3 with SMTP id
 adf61e73a8af0-203b3e92326mr8230124637.15.1744887243452; 
 Thu, 17 Apr 2025 03:54:03 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:54:03 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 11/18] target/riscv: Add WID to MemTxAttrs of CPU memory
 transactions
Date: Thu, 17 Apr 2025 18:52:42 +0800
Message-Id: <20250417105249.18232-12-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42b.google.com
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


