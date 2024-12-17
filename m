Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0576E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNR1S-0003Ao-4S; Tue, 17 Dec 2024 01:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR1H-00031X-HC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:24 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR1D-00055Q-Qr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:22 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-728e3826211so3869414b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416716; x=1735021516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bK2ArkonOP0houuEuxLWOOOjjUDvLRrzXIxB3WX61g=;
 b=WRoWqIn0G11IPA3N9oyO2EwAbilzWqKz9qfeK35mqEO2AGBISlhYwFNAOkpqir7jdL
 euCoPgbftAHBQenffQNut4IJRfWT+pSLnFbtrN+LXWpy5d77GabsPGs0LG7ugC8OYVUv
 BKBoFRu6cj6OdrYZy/0dDw+9ZgYPsuy2Ic+OgFYjE1mpaFWh+eRCcX2UtnlDFiK9ofIa
 a2qc9cL+/nD+2BNVILleVVQC+4vAX3aPEN1pmfdwZ32iZDRmQjC7WflZb19PRNNr4MCv
 OWOkafgqKqn2KlcdaFLmB/ULEUq5/3GubHInl9kDon5ShH+y4/WEUlYmqJa+keFovLPJ
 Bh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416716; x=1735021516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bK2ArkonOP0houuEuxLWOOOjjUDvLRrzXIxB3WX61g=;
 b=cOPlheOXvkPCzRqzIXfOxZAbF4kvvL8gjbSUNtz5aF+UJHdAQm3ZSJuPJbUVf7TPGN
 YFYZZ7+TeJ9N9hYuFvVvSXdJAoHccGPfxIh9uhmMWZHNq9TpPgCxCdEF5VQvJRvh59zz
 H5OJw2YqxKGMQlMNH5V3TOFQLfugTvkCDIaLAbo0p1IpwBWQgdO837HYemCNNTAr5rey
 nvIKSkoo7EHUllO1SV9Ox0ucllgNWQH4p2z1/t+mwU1w5pMQrqlCoLIReByUdvlfLbve
 AguhENxfTA6Fz5EhJLqTkGuA53HoRIE9GQXDTjxOv8va7lTTm64kotFm4VoqmZ0fVPqJ
 vcGA==
X-Gm-Message-State: AOJu0YxFNypb3GbcZEs6Cxm3mnwMHN7ItehSDgUyZsKxcgFUFXZOz7kf
 DMq8yYR4/3Q0kX7i0HYwEaoB51K4A8pGjMjah0uh89qLsleLDteBd+kfF8M3JAjoDG3BvLXKRXM
 fQ+anU0e80GHqUbDOmsp+0MjwMiiGDJwJnrWGlq5yfYtHqi46OHYEKM697dNTky+ode0RSUuPjM
 OE94e7gMH9pmy8pTB+dRFtW94xqVee/kVcHYegrTmR+A==
X-Gm-Gg: ASbGncsq6Y6B9SRJul+6JoVuqbd2fNJPTycllXZduwIKEIZMS50yCdVxmSYwNY3p1bY
 t8U4VSPJ3LlqWMS7/0oGg6h1svDcNijX6r1JY/8xZAFadR3DJQsnLlDuh5Utsfso8d5YMG1nKdW
 XfZFnNPQfLOq3Yuta58w+4f98WcxVZ6ggqq4rSjrzOTqjhX78GWkQyKK7hRjpiZU/BYqDyAixH3
 67LLyFDtHXF7UsRPF7RuJdZZSZJEZTgx6TTCI1K7OkBTeEUHT2sVG3VsDZphaSp76IkhKmm9KnE
 g8chQpLCb2s=
X-Google-Smtp-Source: AGHT+IFuAMSns6PhkQ/yfA7NVjy2jjCp9gCmIn8Lk1qea84ycwOZHml7k11L9CYGzSG/T7/1at8XgQ==
X-Received: by 2002:a05:6a20:cf8d:b0:1e1:a094:f20e with SMTP id
 adf61e73a8af0-1e45ab381d0mr4876969637.17.1734416716474; 
 Mon, 16 Dec 2024 22:25:16 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72925e6e8b1sm4354301b3a.139.2024.12.16.22.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:25:16 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 6/7] target/riscv: Add Zicfilp support for Smrnmi
Date: Tue, 17 Dec 2024 14:24:39 +0800
Message-Id: <20241217062440.884261-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217062440.884261-1-frank.chang@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42a.google.com
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


