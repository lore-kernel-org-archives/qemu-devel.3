Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0DC02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJv3-0004Hz-H4; Sat, 18 Jan 2025 20:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuM-0002lu-RI
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:23 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuL-0003iK-2O
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:22 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so4529939a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249319; x=1737854119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcbXbYKvKk1rPgH2xyMQUdBkQyQwxvE26ek83eQoc/s=;
 b=l5AnVxRqcim/a61/IC+pHHW6rB37s2TEirH3UgjQYzB1mo+8IV3Cv4LUdoVfZesIzu
 H/cXPVv/VMDeQNl0Wm51zSOZ1nm8H3V6OEY/nxBmEIrB6LqBw1REsxMV19bQeq0SWymz
 pC+rdBc0naF6P6GqZVx8+MBFjnOGL0Xn1c1VISjTiitOkKws3+SKJSBQg1rIRSS6xlri
 SSa+bREh2YnxLbvV/qaSrYNq1CYG/BZPCuI9icYNCOGVZJVHPXO6zI34wMvEvGM8xBhL
 EgQWrM2npzPbZ0kk17SZVkIM5trHyVJKzBKK++6IXrOUn8PJIpDWKzdR6udcYXsgkSbU
 EVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249319; x=1737854119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcbXbYKvKk1rPgH2xyMQUdBkQyQwxvE26ek83eQoc/s=;
 b=dPIQe2wHeGZ/awSD8S2PNSqBFO78X5QRdEmhIPFCi7Twz4eEfUOdnLTqgfzvcsHl8B
 hIlzasmmgLQljxDNah2riZU9+TCiEuZNOk1XHmlHslYa5jilawU7YKCGzhzGIsC3Jtkw
 B2+ng+jdMzUavKUGKPtxSoHl+Pcg6ady6sfMk6wEz20JYgNlAml5Cq9YneSKojgf62yM
 8nq5IKjfn0dzDpbvvKI3ruH/VPiR0EBghQTPxRa2tX49xRdUy5N3JzZRrgOWo3QHyDt0
 zXRGllZbKDuqwN27WRLLTGFkgt9fGzzuUjLQ34MVHVzoaOxYuCs69hxQRTlE0ftjK46C
 IdBQ==
X-Gm-Message-State: AOJu0YwIjbXlUTx6Wo1uSf6Z6vsDJVHLiPRC1pBtKTe+f5qbSgRFxV8U
 ZkbeKQ9oKb3gDI0QF1RCx5ub5WjyF3QjvF06MmwVCLe33qkRr0UgK4TGvI8r
X-Gm-Gg: ASbGnctXamw0yPhZ4O/pGTjy45wt9Pah/DFn90H3FQlvIqqVpPZVv+NjoAdfmWZkKLk
 qPIMbtUNTxtIvDW3275jgh3QQFPUzBRBN+uaGoo6TftDEkqphm06I1CC4gmJbMGtrq/jda32EpE
 xB4TrnSLuTUEsogeROTNxWbMGMm9/w1ZMxB2dr1UIPxzhbJturXnzuXWN1B7oTWmtrVXw0bcX9U
 jR/lV4GvgFX8kNK+wUS08g78wpBGltMTfwnzCvWHaOlRYJTPw4zWQrzAofiKojD9lu8btlIKioo
 yZLcpWyxpnYJrvgaAwa6aH0uA7o+1WVXZZjHYDAkBlc8Z1JXFhLKHzznIT6wsTl0XpDxLdUXKQ=
 =
X-Google-Smtp-Source: AGHT+IEXi7vV4jwZ67Y1gk+m8plPkFz0wCvxI8pkYxig5m1/29esQcN0Q5y1GqB+MUm61TzlFyLvCA==
X-Received: by 2002:a17:90a:e183:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2f782d4f2cdmr11529343a91.28.1737249319407; 
 Sat, 18 Jan 2025 17:15:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 46/50] target/riscv: Implement Smdbltrp behavior
Date: Sun, 19 Jan 2025 11:12:21 +1000
Message-ID: <20250119011225.11452-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Clément Léger <cleger@rivosinc.com>

When the Smsdbltrp ISA extension is enabled, if a trap happens while
MSTATUS.MDT is already set, it will trigger an abort or an NMI is the
Smrnmi extension is available.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-9-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 57 ++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 539ba327e7..e1dfc4ecbf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1938,6 +1938,24 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
     /* if no promotion, return original cause */
     return orig_cause;
 }
+
+static void riscv_do_nmi(CPURISCVState *env, target_ulong cause, bool virt)
+{
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV, virt);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP, env->priv);
+    env->mncause = cause;
+    env->mnepc = env->pc;
+    env->pc = env->rnmi_irqvec;
+
+    if (cpu_get_fcfien(env)) {
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+    }
+
+    /* Trapping to M mode, virt is disabled */
+    riscv_cpu_set_mode(env, PRV_M, false);
+}
+
 /*
  * Handle Traps
  *
@@ -1977,22 +1995,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool nnmi_excep = false;
 
     if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
-        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
-        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV,
-                                  env->virt_enabled);
-        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP,
-                                  env->priv);
-        env->mncause = cause | ((target_ulong)1U << (mxlen - 1));
-        env->mnepc = env->pc;
-        env->pc = env->rnmi_irqvec;
-
-        if (cpu_get_fcfien(env)) {
-            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
-        }
-
-        /* Trapping to M mode, virt is disabled */
-        riscv_cpu_set_mode(env, PRV_M, false);
-
+        riscv_do_nmi(env, cause | ((target_ulong)1U << (mxlen - 1)),
+                     env->virt_enabled);
         return;
     }
 
@@ -2204,11 +2208,32 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             /* Trapping to M mode, virt is disabled */
             virt = false;
         }
+        /*
+         * If the hart encounters an exception while executing in M-mode,
+         * with the mnstatus.NMIE bit clear, the program counter is set to
+         * the RNMI exception trap handler address.
+         */
+        nnmi_excep = cpu->cfg.ext_smrnmi &&
+                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
+                     !async;
 
         s = env->mstatus;
         s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
+        if (cpu->cfg.ext_smdbltrp) {
+            if (env->mstatus & MSTATUS_MDT) {
+                assert(env->priv == PRV_M);
+                if (!cpu->cfg.ext_smrnmi || nnmi_excep) {
+                    cpu_abort(CPU(cpu), "M-mode double trap\n");
+                } else {
+                    riscv_do_nmi(env, cause, false);
+                    return;
+                }
+            }
+
+            s = set_field(s, MSTATUS_MDT, 1);
+        }
         env->mstatus = s;
         env->mcause = cause | ((target_ulong)async << (mxlen - 1));
         if (smode_double_trap) {
-- 
2.48.1


