Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D80BCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprU-0007kP-MJ; Tue, 13 Oct 2026 23:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprO-0007Qd-7i
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:59 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprM-0001hT-7G
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:57 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so2978254a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949255; x=1792554055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WCycABNROlozKLIFwIHhszPrs7e0pM0vWpiAyi00g1w=;
 b=QX3aVHeXEomRYJKe1qYYkxNQyYNesFHNdrao8DiIdhYiyT9Qa6uHJY2pOVrQhZi74Z
 /vU3eOMTxnEmToEetiA9EBaozZEMnr9kGAIiW28hrsOXTGLsHsZcpocpVCeSM2t777/Q
 wIaRIGjARMU4hEJB4TIA7z8i4CwXbVRs3BswS1daTRGhPcg0DvfDcRwqG6VoTtZiQ9YZ
 MK5VBemKgDdv6uRCXKZx0j0RbktOMJ6fkP29dCr10cIuodiJmLw5jm6RW57c+lDwa0uC
 t3R240v3SFM9Mhvhfu/RNOxqV+raFdEjE9fG3c1/iPByKHckkwxCq71nh6ejgU9ncupz
 8pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949255; x=1792554055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WCycABNROlozKLIFwIHhszPrs7e0pM0vWpiAyi00g1w=;
 b=zSl/HQJQLfVTKVK5DeQCZgtnm3EkP3QtaBT+XlvNru4jg/LK+GO5CE/RQBodZvYeuq
 PDyGTbMP99XqDf/YkqNO/Gmq+0eyhfh6jXphLklVPg3gl54SgTRospZAXJT9LZAC+U6l
 8l8AWhHWqgSHzppIpNVaFe+LCTpRFqkXxF07g16oCcklvKzUjFujDIc6adSkcMLS/sqm
 HW1yQrwPL/jj7mzfKfgOJ4pXjF6D9SeqpZTJvGxhbWl1oO5LqFI2h7C+IlJmxSAgVujl
 siW9Ozyt4e+4Ga/U3T/BGMnWXndb7rkm7qFl4uH/xqu0inDZG0FBCDSeRuRyNZEleFOQ
 w1Uw==
X-Gm-Message-State: AFq9FYIkNzUfJkh89mr6BMt0CWg+IKYQQRQ/QNCoL07VXmINrcvD1zkg
 j3YSidSSivWGsmFctJYnSRETAa7JUOG+gRLzOQsp2PSpugNWQkvEY2lU9u2hMw==
X-Gm-Gg: AYBFou0PAUsAk7s7UZPcECDP0SZiQ7J7vPvoZOwAnAcIKDXQTjAOZjTLMHvOEUvFEmO
 plqQqsr6epu5z5fX2YbKauREB1rZcad2cLyrk22HXiuDUkRcfxb8VWvni91kzT+GK/iF5Qmaunl
 Pxq5isjyxOIsJGFZ2AdqIEcWP9BfIOqdBdVYWgXSPaO03NiCFZJrfILEgI5Tq6cKssu1jAz62Q5
 IuwdbIDR6k16fMSEeTkPCjNOBXPsGDJToTsPEs//jJJWNpc/YXb7Tf/VRnRp9PQr3tbKFIf5V1K
 iOnJ5V7UixmYXQmTsnSUa3p0cmgQpleZyDeotIJ9sCE0rsXRqfh7c130Ia/oBDXc6lDA1+Z16Em
 cBke1GmwW5Q877ZCF8Fo7h/vEVHp9mg8bE9FHV60J0nsrPVxOD8tP4DuSExysnRrGIkCjftqj4h
 ZmJKOEHaffWem+Y0ZuI+45CQA2y9rmSZBKauOPUdsGU5SwsaXyYLOkCY7aFdBUzrSCmYkYRtkrH
 /NpzHzzA1wSjsFm
X-Received: by 2002:a17:90b:5886:b0:3ab:be66:ddc8 with SMTP id
 98e67ed59e1d1-3abbe66dfdfmr9024456a91.14.1791949254761; 
 Tue, 13 Oct 2026 20:40:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 30/52] target/riscv: add sdext enter Debug Mode on ebreak
Date: Wed, 14 Oct 2026 13:38:45 +1000
Message-ID: <20261014033907.3332383-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260928195902.2045235-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/tcg/op_helper.c                  | 34 +++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc     |  6 ++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d7111ff4b2..14dd891f08 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
 /* Hypervisor functions */
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index dbdaa64f5e..53e9eb445f 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -526,6 +526,40 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
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
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index f1a042d57f..e22df6fbe7 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+#ifndef CONFIG_USER_ONLY
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
+#else
         tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+#endif
     }
     return true;
 }
-- 
2.55.0


