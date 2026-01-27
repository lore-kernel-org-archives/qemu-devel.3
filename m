Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB87D2F011
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiwI-0007J8-GA; Tue, 27 Jan 2026 08:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiw9-0007AE-Ob
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:54 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiw5-0004bR-Mq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso35441405ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769519808; x=1770124608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7s36Gnhgk2Vos6o6JQQC1qIECPmtRU7o2DM59bcTqc=;
 b=WRtwW2N3Yv+x2notsZhM9RZGYW3cDWdzwNNOIK4crKKWFJsxtd1Lx7QEIoN0ZWicrN
 tg68YBe1hkdfx/YuN+HgEHVr2kmEONFk0tYcNLW8ZDRE/wlkrRvznGpvgsjO53y3wxZS
 uIJDZMbv9V/Z989VsJ/Jexg1NpIYIxVT27xB3dYAo0m3PI4j2cYnTTY7tt4GMepY4CQO
 ShzDtUdXsGm/RnyRD63rumF/2fc8YSSWL5J2Cjyh65yd14sPTTKO+LOoOapeWG7703c2
 lP1WuRNgG5TCKeOXp+ZOZKGofkhRBPvkKzlXmRjXOg+v2I8csQpgJbCPU3Oqvh6o9+uz
 tmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519808; x=1770124608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P7s36Gnhgk2Vos6o6JQQC1qIECPmtRU7o2DM59bcTqc=;
 b=gfku3QrmHVnd5a7+sxOkjQ3fMY8z+5VrYWEiUPQN13pa6bYO2AfXt3/3CapQdO0lUU
 x374VGdhlZjKpprMv+ZV+RvWXsbaf6dGYBmzTgxrOnAOeByCcIB9t5U6ZnZi+nwdzcWy
 p8kg1za0wvRGWEOFCr8rLm7Uuf+CYW8mWXKZmxNEH+eXAEV3HxA22SY8Lza9H5fPiqsl
 NgVrKpiK5oEONoS3nUo9eSy4YI6nPxKmGgVn+mXc2SxEtPSY2Iza4EZb0K29ADqR8i9j
 19hyPE373U2SD4mCE8VeE4DTsLDkxy2pHSR/7ykY76nKvX8VPpPPp5osnv+eIXFT6M1n
 Jb2w==
X-Gm-Message-State: AOJu0YyFRvcHH/M56VLg0XpJpf/kfvPTA8pb6tQVIakF+VaLgHVUZEJq
 aIzU9XqAacvqUcCh53aiOwkk4u0KEJ0iwTgZl7HNnjwG3RpHky30atQ+
X-Gm-Gg: AZuq6aKJO0ZDubQzKyWOd2grYEPJKLsIW3IzmSIwl9A8xZb3vhKiEqcLQCPR5TSe/GK
 bRhlkZZvVNMgQMzPPZs8wSU9UNbs6JkgRKJnhrqDd2AzM0WreVH7mCG2XrKTfm0A/B+pSfUyZQ2
 kO/3FVwV++JkAtPlJ/CcuvPn7ullkX4lxlETFJLvOZ0Kq8JOT2DtutQhbdpEZENKF7LwgLfeGWd
 D8l7DA0OrimVVs4/z4CI1uFHMDkKg+NqClMuftWSjB8dBHqJ5QD8MO7GzvlwKV+HPNJobLjXsRF
 UfpAcf9GYW3oQrxnaR9vK3+a+7R3TTLFakgdJlKvzFOqJaKNKkepZCs1kAWUsQF9d5kwlDntFNE
 IJc6EIJcqL3RLswJJ6awZaTjt/f9nL9AN2gbrvxMFOuWflvLfjdBza2HK/3kNrCL9ug6XxXFqqg
 VmZGWsMjSsddf4ozetR2T7nImui8BZjIWmo/jGZf99ueTBxSNNisypj5vY5fc=
X-Received: by 2002:a17:902:f60d:b0:2a3:e7fe:645e with SMTP id
 d9443c01a7336-2a870d58d36mr17593205ad.1.1769519807845; 
 Tue, 27 Jan 2026 05:16:47 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.23.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb03b4sm117164345ad.82.2026.01.27.05.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:16:47 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 5/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Tue, 27 Jan 2026 21:15:49 +0800
Message-ID: <11206be920f2d74fcf25db2c8cf145720f69ecb0.1769517768.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
References: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x643.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  6 ++--
 target/riscv/op_helper.c                      | 36 +++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6140b6340d..acff73051b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
 /* Hypervisor functions */
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index f8641b1977..377f551bb3 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,9 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
-        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
-                      offsetof(CPURISCVState, badaddr));
-        generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
     return true;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 99736bbebb..dfe5388ab7 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -470,6 +470,42 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+    bool enter_debug = false;
+
+    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
+        if (env->virt_enabled) {
+            if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKVS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKVU;
+            }
+        } else {
+            if (env->priv == PRV_M) {
+                enter_debug = env->dcsr & DCSR_EBREAKM;
+            } else if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKU;
+            }
+        }
+    }
+
+    env->badaddr = pc;
+
+    if (enter_debug) {
+        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
+        cs->exception_index = EXCP_DEBUG;
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.52.0


