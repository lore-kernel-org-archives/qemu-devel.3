Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE3D4A5F5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxul-0000zB-Sx; Fri, 16 Jan 2026 23:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuk-0000yJ-JO
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:54 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxui-0001bU-VK
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:54 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso1640165b3a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624072; x=1769228872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7s36Gnhgk2Vos6o6JQQC1qIECPmtRU7o2DM59bcTqc=;
 b=WyNNc/FkzWsYByF+bb5QRnoGyrx75ZqlWXxKFqhOSbYYsKEBXI6EqHY1ZCW56mgCSM
 7paUyzOjEA/+LYkL4QW2RZcdCDVme1+z3V3QdoUs3NUEJn0/5ywGf6/ienGqgDBJObox
 /zP+chiE8tk+We9xQHCqiGZm/b+wVCN1ewcyAdDFexhm4d32rsZknP3BgAUPUn42KuhY
 Ed0dFD9cHOECNfPj+QVRS/UOCFPpjdAtTCfeGLb6vLJU7kd0BQlCla6o8eLtKFmKOZkO
 aWR2dOTuHryf7Ge8LelYVYFh9IX+td2KLHqLJ47Mo54DbRv7PP61hfJUKQe3GOefF1NJ
 2kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624072; x=1769228872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P7s36Gnhgk2Vos6o6JQQC1qIECPmtRU7o2DM59bcTqc=;
 b=vblwRP8PYgDrAouyPxf3JhX4SJvx64c380hzODD2r67D/OblZ6L+zyX121PzDzFCiy
 8ro/JYJRrAsBoENE3ed4H+hJuUcz7sGNPd5VPqLPC792NMLKTxW1WinxCrMQCNDBO0WU
 E9V+leSJ+Vf19LRmxB113g3jvWsiy5urPiJKGNYvl9ft1vxCoINDj1fpY1MswzJ2knLc
 nr2vYTUwNIOh4jecYmHnZixnQOOxYdncnTvZuv17qTVxVyEJKDH+Y4kPso7Of1y6oqxB
 aBhC2oUdwzbBtBTEIgNw2SImPK75awzs7o5vvJN31NQBvCIdT+sRciQ+EYZg/o9RAWTg
 6LmQ==
X-Gm-Message-State: AOJu0Yw49W2KqvemIQNAzE2P2trKD/udN1oGXg9fK3YcbLAu8VaLlfP8
 c4dgIsEuVh779VmVrmwQ6M2/onxGWi6n/oB/f9CUB6tFN9uMJA5jvhQl
X-Gm-Gg: AY/fxX5YULG5w/iGtLc5HzEvQ6eKyCDlOfJIvMxK2luOGGfhQOX5iO/XOvIFnnJoi4W
 RhVjxef1eMUgyWUOfVEYhyqsoXucNg9CnFN4lU3/rMKvC727V6dMUEVtE9TsbS32PQDA4HK5QWq
 wqmmay/RvhNqtyuW6Sfn88O+H1rqfrK+9TJgbGu9DeQ/Le8CuUL9AHtTrdRgoN3Pl6q027WkA1S
 /p66L7jzoL15RG53wFOBmobgcnNXqR5cMEaE1aqAyf0Xar/R7luNYv+VkCtZfZmezehg13XlpG8
 0I/qZ305YD7xZVvghxoiVc3vR1OCHxO0vYPRyUwnh8iwu4HF7lFWkkLht5Cu6D7XBNpRl52ksnS
 UOBg2VTBwHP7dZvCPJvVtNeEGi36iAOKxfjw3paqZ9gmEyM9f1QHtB0yWuTv1ShrmwWkLRrLtF1
 nRBAsB8IhQNewDsF/8TWcHcdy911XkbNfZyh+X4puyojKR647a7yZ6qnRbfkppWA==
X-Received: by 2002:a05:6a20:3c8f:b0:341:c255:7148 with SMTP id
 adf61e73a8af0-38e00c1770emr5395203637.28.1768624071701; 
 Fri, 16 Jan 2026 20:27:51 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:51 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 5/8] riscv: add sdext enter Debug Mode on ebreak
Date: Sat, 17 Jan 2026 12:27:26 +0800
Message-ID: <f6a494d5f5661c69daa03782d0b268055605bc84.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x444.google.com
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


