Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16B7C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Msw-0008LE-Um; Thu, 17 Apr 2025 06:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msd-0007gg-TH
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msb-0003T7-HP
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so449828b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887238; x=1745492038; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2ynf1dYmwbYGI8KiYXQBOC7joESopxPzlk7K7/NwSsw=;
 b=hJgxRkIVUoPyncr1oKDfuhJCrbGsWYdhS5iaeh4LLhRnp9SSX1cPovDHPSrtsw0H5R
 ecl0zA3wZE5G1TXTgeIgnQ53gkBtYIqRw5rvNXppO1DP7igh+sFiCxE58v8wgQEW/b1Q
 S2ipnTTqOV5MC0blZ6QewcnHz+5L4/1Udf7PIXe16zrE4Y00o7a5IKS/jfKa9EuRRc+C
 szBEAqvLMoSBBOxAvkXbpo1oqx5DgjzEx5o7ljAan1QwDhFXPooS6Oewq/F04gW/o54+
 HAwHwicEZrG9Kz3u/A1YNnaLvPT7PZ8WCp8dyryro1/zaZe1l87oUQPGq4CF3BYkDhsG
 G/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887238; x=1745492038;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ynf1dYmwbYGI8KiYXQBOC7joESopxPzlk7K7/NwSsw=;
 b=gdmGDIVeX/DZihxTGbkw7skMXQLdy0UfBdsXo4s1doOdPl7te5/1nYuJ16z/3M2s2i
 0yQs8MenropTk6Gduf2o2EcshwMUvszD54j9F1yBb2BsiC0tf9/q/J5xO0JdXZMjZ/J/
 NUCTfJV9h3mFi98eVq9SGq0ZYVbvLhFewDzAKuTHTe4KNxw+4S7mB+edRsFEBZ2HKo+b
 PJTn6LlbTfx2SXvm/+VbszKhGPMx/zitiKoY65cZXTMEockFsubXRppn44PMeA3z8kJd
 FpytcVlrKw6SFgvBH3Trrz7ey5K7YBnQRJ8uxQFFAvQi/ZMGetz7pLiL0ABS67sQjS3U
 LeWQ==
X-Gm-Message-State: AOJu0YzXuijX8xVjAech+n1FCXfylQ6lhLwmP+tsSWiwEUVmqHtULZZ6
 UlKFF9DEB6WsLqPz0NIP9CCE7K71U3cvtpUWwEQ5Vy3moWzFG2Op+X6/7P8L5vIHdsTGw86tb4h
 59ygAiKqPoFdWS89stHMB6XMTROVz1UNX1Guo9Wy/TeulGoBKfmuRnd75anZ9gNhO0uu3kp+TaP
 zuak693bcaHbhIrLjYAPIyJAhxt8rpT5uDiA==
X-Gm-Gg: ASbGncslUZNug2lE/3y7o8LwIBAPipf94B8zBiW54yRSiirHLqmmpT/NTr4HtAd19hl
 2ciCder/y2E0mTML7zVcT9dE4eqfayYbeqW9Py9KSDnY4qS1Ts+YsJ8RIgDOv/c7IWM9dSdnW5D
 vdrl3VJAbuSIV3CVP5XEbDy0o9IkAahkTVHK9BvTuCBNU7xVrsQ/NPYukKTlnBuuAhVtrz2IBxk
 ViIVpcyq8KKlda/k52Shw0+mjlWLe9jhl/5qfC7Qh/YnMdtKY6/OfVWMsm9i7jhKG8BtJ7L3yxj
 EKLnA+uXzQyK3Svb7siY36yxQ9eHWFCjKpRYzOQhF7oZTI/gO/ibDPW/+d3Bfm8=
X-Google-Smtp-Source: AGHT+IHgbOzKff8rpGr7vAShyE/TVFOAk9a78CZeOSMl2RxNdZiEp9IeyuiDmv2prSWkA1bYr5u2WQ==
X-Received: by 2002:a05:6a00:1145:b0:736:4a5b:7f08 with SMTP id
 d2e1a72fcca58-73c267fe1dbmr8043631b3a.22.1744887238063; 
 Thu, 17 Apr 2025 03:53:58 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:57 -0700 (PDT)
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
Subject: [PATCH v2 10/18] target/riscv: Implement WorldGuard CSRs
Date: Thu, 17 Apr 2025 18:52:41 +0800
Message-Id: <20250417105249.18232-11-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x435.google.com
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

The WG v0.4 specification adds 3 CSRs to configure S/U/HS/VS-mode WIDs
of CPUs in the higher privileged modes.

The Smwg extension at least requires a RISC-V HART to have M/U-mode, and
the Sswg/Smwgd extension at least requires a RISC-V HART to have
M/S/U-mode.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c |   4 ++
 target/riscv/cpu.h |   5 +++
 target/riscv/csr.c | 107 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a182e8c61f..1dbeac0509 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1141,6 +1141,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smwg && env->wg_reset) {
+        env->wg_reset(env);
+    }
+
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6dfc260a07..7bffe62f70 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -501,6 +501,11 @@ struct CPUArchState {
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
 
+    /* RISC-V WorldGuard */
+    target_ulong mlwid;
+    target_ulong slwid;
+    target_ulong mwiddeleg;
+
     /* machine specific WorldGuard callback */
     void (*wg_reset)(CPURISCVState *env);
     void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7948188356..614df37d00 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5388,6 +5388,109 @@ static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
     return RISCV_EXCP_NONE;
 }
 
+/* RISC-V Worldguard */
+static RISCVException worldguard_umode(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smwg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return umode(env, csrno);
+}
+
+static RISCVException worldguard_sumode(CPURISCVState *env, int csrno)
+{
+    RISCVException ret;
+
+    if (!riscv_cpu_cfg(env)->ext_sswg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    ret = smode(env, csrno);
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    return umode(env, csrno);
+}
+
+static RISCVException rmw_mlwid(CPURISCVState *env, int csrno,
+                                target_ulong *ret_val,
+                                target_ulong new_val, target_ulong wr_mask)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    target_ulong new_mlwid = (env->mlwid & ~wr_mask) | (new_val & wr_mask);
+
+    if (ret_val) {
+        *ret_val = env->mlwid;
+    }
+
+    g_assert(cpu->cfg.mwidlist);
+    if (!(BIT(new_mlwid) & cpu->cfg.mwidlist)) {
+        /* Set WID to lowest legal value if writing illegal value (WARL) */
+        new_mlwid = find_first_bit((unsigned long *)&cpu->cfg.mwidlist, 32);
+    }
+
+    if (env->mlwid != new_mlwid) {
+        env->mlwid = new_mlwid;
+        tlb_flush(cs);
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_slwid(CPURISCVState *env, int csrno,
+                                target_ulong *ret_val,
+                                target_ulong new_val, target_ulong wr_mask)
+{
+    target_ulong new_slwid = (env->slwid & ~wr_mask) | (new_val & wr_mask);
+
+    if (!env->mwiddeleg) {
+        /*
+         * When mwiddeleg CSR is zero, access to slwid raises an illegal
+         * instruction exception.
+         */
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (ret_val) {
+        *ret_val = env->slwid;
+    }
+
+    if (!(BIT(new_slwid) & env->mwiddeleg)) {
+        /* Set WID to lowest legal value if writing illegal value (WARL) */
+        new_slwid = find_first_bit(
+            (unsigned long *)&env->mwiddeleg, TARGET_LONG_BITS);
+    }
+
+    if (env->slwid != new_slwid) {
+        env->slwid = new_slwid;
+        tlb_flush(env_cpu(env));
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_mwiddeleg(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+
+    if (ret_val) {
+        *ret_val = env->mwiddeleg;
+    }
+
+    env->mwiddeleg = (env->mwiddeleg & ~wr_mask) | (new_val & wr_mask);
+
+    /* Core wgMarker can only have WID value in mwidlist. */
+    env->mwiddeleg &= cpu->cfg.mwidlist;
+
+    return RISCV_EXCP_NONE;
+}
 #endif
 
 /* Crypto Extension */
@@ -6465,5 +6568,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
                              .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* RISC-V WorldGuard */
+    [CSR_MLWID]     = { "mlwid",     worldguard_umode,  NULL, NULL, rmw_mlwid },
+    [CSR_SLWID]     = { "slwid",     worldguard_sumode, NULL, NULL, rmw_slwid },
+    [CSR_MWIDDELEG] = { "mwiddeleg", worldguard_sumode, NULL, NULL, rmw_mwiddeleg },
 #endif /* !CONFIG_USER_ONLY */
 };
-- 
2.17.1


