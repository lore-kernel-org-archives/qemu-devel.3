Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C7606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWpfHbnx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5Gy-00077h-Fy; Thu, 19 Nov 2026 11:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5GA-0006vs-2i
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:21 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5G8-00025t-6c
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:17 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso18910175ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795106714; x=1795711514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jgpccN1w99HlO6vMNqB/j4EpMoZBvMpZ4Fxwcy0wrgs=;
 b=YWpfHbnxokyNsE18B+MND/MsPTmYkjLuxisZg05ueLrLv2NzePPNfgVrf3oDxQ6SBg
 Nzw7V+3i/2vi17h7bc4k2QJkWAUrDg9btq4GGYpe6mVtGYYaZm7KXBH2IkMGkPAeqfq/
 tSVlcdF1zXIdID5WAI6I6qA0vatzWgkBSDYL4bTvKUQO38OPCqrqvC9KZEuAOFCD7ccN
 LTSOTWmNJ0aLwoRD6cKIzhGBQramFolqtKjrpQEnGBCxs5fsHByMPEO1ZsZ5k+Z+aJih
 T7iDhis7p2JFqIe0G6QBoN4tR/f8tphoudOcWl/9XtmFHZ18OJXE4xOM+h7I+qDuOYzr
 7ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106714; x=1795711514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jgpccN1w99HlO6vMNqB/j4EpMoZBvMpZ4Fxwcy0wrgs=;
 b=JiezsOqxVrGMjXm089IQqHBXuqqg2U8oFzMa8Jqz714VX9kk0oguO7eqfRhuQFzfmN
 nFNCFfOov7DiNI3JwbpkJ/yChXSy9Q3HIi1LDvEi7ndPi2qRPhH638uW28u4q4KsCkxi
 fx9ZijfljaiP0k+g2BCJyOwyqNO7RkJf2lvYVTQqzoG1S0CWUMcGvk/1Au0ke3Vuuzug
 7Tq3uUkKuXzpgZONEZlLuxCoGbAMum2NtyJgwxsZNQVRnPOZwlBNScNdY27I2erm6NC3
 EX10NUfUKRC6YL5yv0GNSZ1QN6oJgK1DCzmCIe1aWL4SMZfTXpvVB+tbBmQmvJFpeo0A
 jGmA==
X-Gm-Message-State: APuU4Z8i5o0jgrbYBS+si6pWPt9jR/BZMjBcnHBPn32W9qpFtreiLMG6
 eUzvsVkGTRqeLfl+JGZ7g98HzLnxDJEOqZZoHydsM+sf/graS1S0OMrAoD8t+A==
X-Gm-Gg: AZFdTZcPKTXcFTxiNghYpZHVQmMnMJ1DK7UwFXS2O6wVjkElUaUzug7KuFqTfvHZzfA
 VWqdfc6W7UhSDU8OrFP5B7gycykVzSjvh+fb/XkBvEzDD0XmUalm/QC9NegphKICnZeIZJGSm15
 kxi01C1jrHuO57BfGDQszTPSZ4jsgyWqkUA52WmI4e/Lo1WFO25T/p0s0rGjADLeM7bejKSX5Ob
 zBpBi0J97aQE9khvey5nl9c8F//Vo9YBr2px3lX+S2u4V04XTbVxXo906rJ8PnkI4hV08D6TfD3
 Szq0AYSgCwm1jkpdE9nmcvcIldW+LIL2nlkNpRlUOIiRAG091qwHIAeIvVm227IN6ewDBL6LN4n
 EG9gc1V+lqSEKC1w3CWscu8nhYTO9w4IFoXoPAS6zb0ai+/M5c3jEoOti+8gUtpuQX4ii/e994Y
 uJoedibBMEQ9kU5IuwIzmNS+G9VyqaxnNSjKu/Jb1DtCgu53HdXteyJQ4Oc2ypL7ExN9fUDwAKO
 j/L996PzEnrfYcLuIzJd1vSxcqxT5GmV8E3NlATMbRz++c8+f6vDwq+VMxjKFAkN2Qvbpy8fu+Y
 IQTpA5ed6Fs4Z2zLY0c1VKkfxghBaEoD/rE60h4o/IpcigBQXUD+rw==
X-Received: by 2002:a17:903:4586:b0:2ef:e547:e0cd with SMTP id
 d9443c01a7336-2f03f1707d4mr4729285ad.31.1795106714293; 
 Thu, 19 Nov 2026 08:45:14 -0800 (PST)
Received: from fedora ([61.74.238.173]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f10e67csm2381365ad.53.2026.11.19.08.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:45:13 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 2/3] target/riscv: Rebuild cached TB flags at state changes
Date: Fri, 20 Nov 2026 01:44:37 +0900
Message-ID: <20261119164438.193579-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119164438.193579-1-suunj1331@gmail.com>
References: <20261119164438.193579-1-suunj1331@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=suunj1331@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add tb_flags_cached, ext_tb_flags_cached and vlmax_cached to
CPURISCVState and riscv_rebuild_tb_flags() to fill them. Call it
where the inputs of riscv_compute_tb_flags() change: CSR writes,
riscv_cpu_set_mode() (trap entry, xRET and debug mode exit), vsetvl
and vtype invalidation, itrigger updates, reset and migration
post-load.

riscv_get_tb_cpu_state() does not use the cached values yet.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 target/riscv/cpu.c               |  1 +
 target/riscv/cpu.h               | 19 +++++++++++++++++++
 target/riscv/machine.c           |  1 +
 target/riscv/tcg/cpu_helper.c    |  1 +
 target/riscv/tcg/csr.c           |  8 +++++++-
 target/riscv/tcg/debug.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c       |  7 +++++++
 target/riscv/tcg/vector_helper.c |  2 ++
 8 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..aff6f373d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1122,6 +1122,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         kvm_riscv_reset_vcpu(cpu);
     }
 #endif
+    riscv_rebuild_tb_flags(env);
 }
 
 static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdb..517f6081d8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -262,6 +262,20 @@ struct CPUArchState {
     uint8_t vxsat;
     bool vill;
 
+    /*
+     * TB flags that depend only on state changed by CSR writes, traps,
+     * privilege changes and vsetvl; rebuilt by riscv_rebuild_tb_flags() at
+     * those points.  Bits that translated code changes directly between
+     * two lookups (FS/VS dirtying, elp, vstart, vl) are added on each
+     * lookup.  vlmax_cached is VLMAX for the current vtype when the
+     * VL_EQ_VLMAX fast path is allowed, else UINT32_MAX; vl is compared
+     * against it per lookup because fault-only-first loads shrink vl
+     * without a trap.
+     */
+    uint64_t ext_tb_flags_cached;
+    uint32_t tb_flags_cached;
+    uint32_t vlmax_cached;
+
     uint64_t pc;
     uint64_t load_res;
     uint64_t load_val;
@@ -967,6 +981,11 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
+#ifdef CONFIG_TCG
+void riscv_rebuild_tb_flags(CPURISCVState *env);
+#else
+static inline void riscv_rebuild_tb_flags(CPURISCVState *env) { }
+#endif
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e9588..f0aad72706 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -388,6 +388,7 @@ static int riscv_cpu_post_load(void *opaque, int version_id)
     CPURISCVState *env = &cpu->env;
 
     env->xl = cpu_recompute_xl(env);
+    riscv_rebuild_tb_flags(env);
     return 0;
 }
 
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..70c889aaa5 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -982,6 +982,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
             riscv_cpu_interrupt(env);
         }
     }
+    riscv_rebuild_tb_flags(env);
 }
 
 /*
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..3dbfe2dc80 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5909,7 +5909,11 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
 
     /* execute combined read/write operation if it exists */
     if (csr_ops[csrno].op) {
-        return csr_ops[csrno].op(env, csrno, ret_value, new_value, write_mask);
+        ret = csr_ops[csrno].op(env, csrno, ret_value, new_value, write_mask);
+        if (ret == RISCV_EXCP_NONE && write_mask) {
+            riscv_rebuild_tb_flags(env);
+        }
+        return ret;
     }
 
     /*
@@ -5937,6 +5941,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
                 return ret;
             }
         }
+        riscv_rebuild_tb_flags(env);
     }
 
     /* return old value */
@@ -6015,6 +6020,7 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
                 return ret;
             }
         }
+        riscv_rebuild_tb_flags(env);
     }
 
     /* return old value */
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 988bc815d7..e834f80ce2 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -822,6 +822,7 @@ void HELPER(itrigger_match)(CPURISCVState *env)
             itrigger_set_pending(env, i, 1);
 
             env->itrigger_enabled = riscv_itrigger_enabled(env);
+            riscv_rebuild_tb_flags(env);
             do_trigger_action(env, i);
             itrigger_set_pending(env, i, 0);
         }
@@ -922,6 +923,7 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                           env->last_icount + itrigger_get_count(env, index));
             } else {
                 env->itrigger_enabled = riscv_itrigger_enabled(env);
+                riscv_rebuild_tb_flags(env);
             }
         }
         break;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5c5d8fcb94..a8e744bc26 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -183,6 +183,13 @@ static void riscv_compute_tb_flags(CPURISCVState *env, uint32_t *pflags,
     *pvlmax = vlmax_cached;
 }
 
+void riscv_rebuild_tb_flags(CPURISCVState *env)
+{
+    riscv_compute_tb_flags(env, &env->tb_flags_cached,
+                           &env->ext_tb_flags_cached,
+                           &env->vlmax_cached);
+}
+
 static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 {
     CPURISCVState *env = cpu_env(cs);
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 917a48b510..f1898c52ff 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -56,6 +56,7 @@ static inline void reset_ill_vtype(CPURISCVState *env)
     env->vtype = 0;
     env->vl = 0;
     env->vstart = 0;
+    riscv_rebuild_tb_flags(env);
 }
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
@@ -125,6 +126,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     env->vtype = s2;
     env->vstart = 0;
     env->vill = 0;
+    riscv_rebuild_tb_flags(env);
     return vl;
 }
 
-- 
2.52.0


