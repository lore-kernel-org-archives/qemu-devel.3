Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29EFC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ8v-0003Ob-J1; Wed, 12 Jun 2024 04:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8n-00035B-6F
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8k-0006TC-NS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so40419335ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180128; x=1718784928; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h0z/gLbV7H1AqreyjOU1SY6iFOr0/svp6XKbzOXxi3c=;
 b=fZpfN0rHuApg4517dvvFDaqtyc2VL/WAYAVrGBUz1VY1pYp5M/JXPz1hBRHOP4ho3E
 uwggaaHmfWYx6ElduZ/7VpurwzLvN/eXe0MEqBwtgCAhh7Upt6zajTIcDME800Y4OnFg
 6jOgbPqOm54xENl3cNCPv+gXqsh8HpHnNnTB/XswzOOMcytGxCLNo3bH2fG0dhGR225f
 hJF2LKysnl7klEFx8+9gJowyBnb2CcQUA9LMBVBSd8G6MINMAAbagAFI6zRcjMqIcEDa
 X6wDGCjkypXzOfNa93iHwN/ahnhiQ1X6bSpr/tlPTpRE3S21HwOQtxdXOGv3nrKcERic
 tJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180128; x=1718784928;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0z/gLbV7H1AqreyjOU1SY6iFOr0/svp6XKbzOXxi3c=;
 b=aItvzi3rbcVnEwMcy54Ukaf14pHWEodac1i+7BcmRDq8Q73aZXJRe2up6yc/rL1AcX
 XD8XqfFpIhGmlV5Whea4ZNRy33G2xLZMQwjarEvUko8GQynLsQJ7ZdDEX65iyZn51UpH
 1abU7E82GA2OM/vDiQHFKV1PF+af6pbhzrE5o47tf6rT8DEI9ZnVNQqaf/j/210fP+D9
 E3VBVYoXjkFVJDpQ9xWI5iYCsMkwCQE1T44KZlYkSMFdEMLjLlBcPWri3JPuXI6Lp2aH
 2WERYgM3cO8nQ94YloG6zUXtw8jUdmBOd7wjPW5whUahxCCosv6ojW1Xzjtk2ya1oFlA
 qK0w==
X-Gm-Message-State: AOJu0YxpMLENpl91q6MmdJxSSyqFKwujqqTA/NgZwIvIK/aBEaIlPQZk
 4vVq4bU+Z/AI307/2eJAee0fpo00Ad4hbhFjMRjsIGXbanD1tpYTTXj58UC6q2ZGmrcJYKpD3FV
 YWSDPk+D8IQTPPLedYvgA6uYz0NaBqtniv7fUPSlJ+iX2zeXLkLvpTsMuJ6kJD8FSSUgtIvmZI7
 eooL5aVD5BNotJloU4D57WIt1bp5Cy4Lf1LkiH22ZGlw==
X-Google-Smtp-Source: AGHT+IElBXpniJAtgpcO8h7wvvvpFvELLrYUqd6ldIz07LJ9f8BCphhJY5JR+yJoS8Eo7TnfJ1dFrA==
X-Received: by 2002:a17:902:e80a:b0:1f7:1931:7a9c with SMTP id
 d9443c01a7336-1f83b5df346mr14898975ad.15.1718180127879; 
 Wed, 12 Jun 2024 01:15:27 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:15:27 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
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
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 09/16] target/riscv: Implement WorldGuard CSRs
Date: Wed, 12 Jun 2024 16:14:09 +0800
Message-Id: <20240612081416.29704-10-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 4e87fa4d5b..ff1c22c71c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,6 +1022,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         riscv_trigger_reset_hold(env);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smwg && env->wg_reset) {
+        env->wg_reset(env);
+    }
+
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 50a0fba127..43ab558111 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -432,6 +432,11 @@ struct CPUArchState {
     uint64_t kvm_timer_frequency;
 #endif /* CONFIG_KVM */
 
+    /* RISC-V WorldGuard */
+    target_ulong mlwid;
+    target_ulong slwid;
+    target_ulong mwiddeleg;
+
     /* machine specific WorldGuard callback */
     void (*wg_reset)(CPURISCVState *env);
     void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..f3536e9e5d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4264,6 +4264,109 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
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
@@ -5230,5 +5333,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


