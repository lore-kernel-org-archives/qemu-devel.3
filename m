Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C352BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOD-0002ui-IB; Thu, 15 Oct 2026 21:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMc-0000kL-3I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMa-0004Kj-09
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e977109392so4902085ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112638; x=1792717438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPYm8qrhqsjaEWvJSiJ04ZVBdUZxvZ2CM271CGNTmcY=;
 b=qlmPf1b6Dn4mEKv1EgD2yDd7+/bbPBOGryIYXL67bn08NF3lVEA23BJX/X0JRaI7go
 eXfkZPPExz8JLI5zvhObT45vhuhNfIS0iMO01z4jSReQvGab6KF3NlelY0LsctCTYhpS
 QHT+as5ev3tpaH59WhWU8ZlKU9BlaH+uPtBJ/i25uXOFjki3V5AKD4JUCLPRz26NLefZ
 aiGAGnSc4eWA0tWXtdbX0f3vrV+WK0P+zn6gZIuVHVeccJ2K4LfNPgb714pH+U/bP1Bk
 Na82in5qPPtvVNqMNQpST4CDz0STK9owAYOsD+kV1YaqOmjAUosiTX+WVKfLVnc7xcRQ
 Y6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112638; x=1792717438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZPYm8qrhqsjaEWvJSiJ04ZVBdUZxvZ2CM271CGNTmcY=;
 b=xzhBhm5Ln6V9nDRBb9FingF7cb2RxJrjUPl1NClTL3Y8xYSAo0TQRUMLc8nYANG35u
 yQOJUJOVfLAZhsmLMeo2AACCwAeGn91VYFNa7Dn2ubuVvhYdQxSlBdZYZrBuCemMmAjS
 8T/2YCbVUsDMjNuVLjK0iGEz4tNjgyUqryQMUdwmscVnDlTUz0YIn/aNdi5+plYsOIYJ
 hHV5PYDbJqO2eoBHdTh27vRciGLp0YYZmApfBHeIAzC3d21xpo7bDqrE7wk6arXVr3Bo
 gSB0CrjOVP0KkPxGZyfivQ9MuyF06sbMFC4TXECjhY6d3V5yRkPGBaH12vntXohpcOEU
 cBzQ==
X-Gm-Message-State: AFq9FYJxYJAkqf5hiMSYpcS5nNKOUz8pq1QaAz5KKjI/PNVuZPjYnCo0
 uGL0iDbqwHNNxvK09nhSsQkKhm20BcshUVtNYJoTw98IYulzt0w0G+DucDD1iA==
X-Gm-Gg: AYBFou3G1rQfNWnjrYokvIVMd1Mw/XxzWsBe33h02e/b8IN6uj/i0HHi02OayimswLu
 AYP/CEZn9lcNlCwbz816EjJpyy8DWAj/6FF6uHqxhxVWYkGOVWzWfeOGXccPT/LL2g/ljXotmU9
 D0nSOGjnDkd1j4mZzPLmC1ORDtZi21D2GhSuVy2Q1DS3vvBWLlHDyR423RlZoO/F6UeYqd48Gvq
 rl6JL/mPvmgT9vK9Xt1w1ieoWEIQS9JUBt9tqc2O0N3efqVXjhSS4sgQ8tQYJaFNDHHZET3ka0k
 OX/D5hUQHvgybOhKawWuGcdWxjgwL+CDFoG+Ws33mFuLfuUk6mF/CZBkj8dTEglIFj2kaLYG6wT
 8Wurc+3I5zw6HDd9xo2KxraAEOYblDh+hBxx4LQfPmkaBu+4YWLFN6/gL/poqY0r7ijLQPt/1Rt
 Djdn6K8dwIoWLUIArSWf4CnZLiGWYU+36/IAjUGOagYcid/W4ok2vhy64HWUhGy+FxwUPUO1iPu
 zXx3lf7UG8TULTGTNq/3WcFatg=
X-Received: by 2002:a17:902:e806:b0:2e9:787c:8e68 with SMTP id
 d9443c01a7336-2e9787c8f08mr14941945ad.0.1792112638270; 
 Thu, 15 Oct 2026 18:03:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL v2 25/50] target/riscv: add sdext enter Debug Mode on ebreak
Date: Fri, 16 Oct 2026 11:02:12 +1000
Message-ID: <20261016010237.1102834-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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
index a790595b40..533dee1765 100644
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


