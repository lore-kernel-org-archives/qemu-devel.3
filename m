Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DBDE7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 03:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSSul-0000BF-Te; Mon, 30 Dec 2024 22:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuf-00008V-3H
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuc-0006EK-Mg
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:20 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21619108a6bso119406435ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 19:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1735615636; x=1736220436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlRV80oTXU+VXLaSiP/MteNjJWJt5n2iSGOMeGmK5Js=;
 b=DGH/SFrukWA3/WHDUC+TyW8INew1D/3F6VatPMYvZFoAQGrbTvgZVwqPW5DgEpzrxp
 BJgYNNkGZYEek9CmLO7Ae8ZsrAaK/1rc6a3VSv/ZHOIezmkOVS83ZuXe+kvCecExcA3U
 cfPadrjWHMcfvLAMECbL0LUNsdCv9/+A6L/CcAfQaAGN7PsEv940cd2VaOLLKARW01VG
 PzADYqGF599JSUpElnACbM4p5MaUFpC9A8R2w8W8xSYwOh5qEEDYBg6Sa75fSOOsJDur
 9Qvqkk17HY+gZd/ICdZgjL2WMjrcqhwlLIuq3iXZX4NY2WdxGol38ZrvlgTjqb9vJm84
 ZOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735615636; x=1736220436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlRV80oTXU+VXLaSiP/MteNjJWJt5n2iSGOMeGmK5Js=;
 b=DWS6FWyW6gpFVY/RtM9l+UVVXobHhN5gYkJP8tWsNlesIBNagFcRNtdEYB91/BZlCO
 iWbjGXFIRzYF8BC1jJ1VbujjhJ4/lMHQ/QVYnjO6IiJ4tnFEvhsVYLj32W6LaPlAhJNt
 aRh6gdzBUykj68LJjawGw7TybpSDB8090dzd0tZimc8ddss8C5AWaImgpZjguRuFXZgr
 9RB8n42fMqlDQxELP66Sp7G/F59d3u/U5KHFH9doqjK+Hq/UYV9uZyM0x8sHU3zx5KQY
 9j1xkeJPnh9LWm3lDysmviYv+T9h13AHxUzf+6d8rWpQwTGSMUduPWu8GDkzd1bRNaQK
 jSnw==
X-Gm-Message-State: AOJu0YzV9RHsWEnN24haU1Mm35BqHjNueDH6S/mMxcyk3AHRy5d0eQ9w
 YmQEAaEdYpN5Y0HUJBpfl5UVVWTtdpN9TljdxikcHKoyFRkY2J7w5ke8zZse6IC00wyujd6wh9Q
 Ud3/X9FUjofg+X+D8xlK2JwFiUIPA9Xz45bLBz/h88gA05SCrOjaRs6csct8cB5LNgK17CY984b
 l5hkhZEhfwRgVBRjnGvEcFeSuiHR4OypOMMdkZtqlIeTtx
X-Gm-Gg: ASbGncuQyCA8j00nPwYajCb/9O1r0SH9rG3A6gqGFtdCGffnvipZ3K58TB82cG9CQg+
 WRmBup0t2i4JL4K7OZnFwQd1vsQBcuPFZlwAReiXZy7M08O0kmrn8SOpLB8Mn1rRyKSI2kgvqF4
 DoGe9qS7GqVb9ePWfaSqdNUPIZl8OSyVysi0uG9lEDmcx2Fybig1o1/Gl1e17bQCo/XftJT30Xy
 0/gAbLuASkpY9yOUGQAFKQjUzbMJ5LQ50IOy8byqbZeJ0Ass7u6LsU+zHmanpUcAlmt2tO8fR+V
 fkf0rZELoGKKRhF7F2Ms
X-Google-Smtp-Source: AGHT+IF/ZFq7bSD0E5DCDEnA+4zSeF6tUE5fNkxqPZqAk1VThT7UK+5SlFj0T9ojQBnRwCUknk8Wpw==
X-Received: by 2002:a05:6a21:7742:b0:1e6:50a0:bbc5 with SMTP id
 adf61e73a8af0-1e650a0c0b5mr10022030637.21.1735615636471; 
 Mon, 30 Dec 2024 19:27:16 -0800 (PST)
Received: from fchang-1826.. (1-169-235-48.dynamic-ip.hinet.net.
 [1.169.235.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-92587c62eacsm291797a12.21.2024.12.30.19.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 19:27:16 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v11 6/6] target/riscv: Add Zicfilp support for Smrnmi
Date: Tue, 31 Dec 2024 11:26:54 +0800
Message-Id: <20241231032654.133039-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231032654.133039-1-frank.chang@sifive.com>
References: <20241231032654.133039-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
The MNPELP field holds the previous ELP.

When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
value y, then ELP is set to the value of MNPELP if yLPE is 1;
otherwise, it is set to NO_LP_EXPECTED.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 11 ++++++++++-
 target/riscv/op_helper.c  |  9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 17787fd693..be9d0f5c05 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -643,6 +643,7 @@ typedef enum {
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPELP     0x00000200
 #define MNSTATUS_MNPP       0x00001800
 
 /* VM modes (satp.mode) privileged ISA 1.10 */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e5ffbbbd83..1fb1e31031 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1918,6 +1918,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mnepc = env->pc;
         env->pc = env->rnmi_irqvec;
 
+        if (cpu_get_fcfien(env)) {
+            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+        }
+
         /* Trapping to M mode, virt is disabled */
         riscv_cpu_set_mode(env, PRV_M, false);
 
@@ -2085,7 +2089,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* handle the trap in M-mode */
         /* save elp status */
         if (cpu_get_fcfien(env)) {
-            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            if (nnmi_excep) {
+                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
+                                          env->elp);
+            } else {
+                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            }
         }
 
         if (riscv_has_ext(env, RVH)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 63ec53e992..a4b625fcd9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -402,6 +402,15 @@ target_ulong helper_mnret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mnpelp in mnstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mnstatus, MNSTATUS_MNPELP);
+    }
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, 0);
+
     return retpc;
 }
 
-- 
2.34.1


