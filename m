Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D17C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfMP-0007Pg-A2; Fri, 17 Jan 2025 00:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMI-0007GN-Na
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:30 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMH-00063N-3l
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:30 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163dc5155fso31302735ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093447; x=1737698247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbmZFP4XCtouA6CK9YZLO8kEiCPTIzzgDDbq0k5y8NE=;
 b=Kzh8rzWczgzfQPFbxpDkIzzUAslk6O7uX5/okLs3dcOsWpjjO80JGQXfJcWknHyMq3
 17Vm6nLA1Een96s9U/ZFlUAI2MeSspUV3IyrfSlBS81b5Co/Oz93LuE1gXyhkCwyoDte
 RIiUDKpSxDl/+MR7R1kypF8TljMpXvHVgPx6cVJB9uzsIiAKk8vCfkKRs0CNSeGh/Tdb
 UWsRseZYaLftYEgfNNGFIangKgKqosIUkJ3BraPUQSyoXOiIfR6HjrIsb9jLX0EDSG9z
 Ld4g/pqUcrlfNBi7a6jZaFrVfXS+u0hlRIwzdy9AZHrfJQ9ytfkyGVfDfnX0LK+FwO8L
 HvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093447; x=1737698247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbmZFP4XCtouA6CK9YZLO8kEiCPTIzzgDDbq0k5y8NE=;
 b=rfRzL9bq7MMMB6n+4vETddJ6kGQ26XGSWSIeXz7cW0R79EXlPHXvaTb/VTtYR1olio
 /lXBXSemyDAZCJwAVLMfHTIePv+yE/ql7z2v4VwvJU3u23wPHdY6Nlf1N0n68chqsjHz
 Jir19JWWV+gDBrcWExz//AyLEmSLAY0ozLmQ/zVmjMlQZhENDSe7rYt5/p/1f4/d2+pO
 0xZ51Vt39RucX00KakPuEro8FI/91M1TFSsUd/9osv5j7eMbWG28NCnZw6V7t7NhHzfr
 rQgQijB8aW81IAwGYDP6okR5lKKIXTjr7e0+Kx91j8V2ZgfyKbzxEQVebXzteWw4eQIq
 gajQ==
X-Gm-Message-State: AOJu0Yx0oy5F6RURcRhAY80obvzrWiF06qQ0P+DLHWMmtycYl+VZFrcg
 7M8+JY8tBpOVY1GoCK1Rk4FJNcFZ6jsEff6zjC5fJX5W5L7rXQvHlcQwag==
X-Gm-Gg: ASbGncuqD+PT1e3610riOE9+67EFIrichSpkY7H8ksi3z5+f6h4k0OD2GJ55VgWVEaU
 qfoMp7t4jRGcSOiPaoBo5NLR5rnu0cMCAP5slXbkhtrLF1erwgEsk4keuB04kMFhvdofon6nfeU
 LCiuK8mrrhQQcND2pSOngia57RLUpSPDuVT9MyZ22OfqMYIh16NuaI1T0TF6ROqBfGd8D7dZVvg
 wxJ8iL7Y+NKVhkaHJZ7FNnql5DxW+tQCvntvWNPOvwmmUw6lXjzWBGtgIbKsIJUy65+rAbeC4Y5
 fRjdBsl5+LhJj2+xMZOpV95P5LprIIB8V+1cLD3x9hof+BaZHi6w9P6oMI0c
X-Google-Smtp-Source: AGHT+IFx8yXJR0i08tz7DZYjoUNu5mMzPUJAF/a/8pEbmUgyMhNiFugJscEw8zYQ5dHdsc1QVVW2/g==
X-Received: by 2002:a17:902:d2d2:b0:215:6cb2:7877 with SMTP id
 d9443c01a7336-21c352c7b8emr27888365ad.4.1737093447142; 
 Thu, 16 Jan 2025 21:57:27 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:26 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/50] target/riscv: Add Zicfilp support for Smrnmi
Date: Fri, 17 Jan 2025 15:55:27 +1000
Message-ID: <20250117055552.108376-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
The MNPELP field holds the previous ELP.

When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
value y, then ELP is set to the value of MNPELP if yLPE is 1;
otherwise, it is set to NO_LP_EXPECTED.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-7-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 11 ++++++++++-
 target/riscv/op_helper.c  |  9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32525f00d6..d51f3d8cef 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -613,6 +613,7 @@ typedef enum {
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPELP     0x00000200
 #define MNSTATUS_MNPP       0x00001800
 
 /* VM modes (satp.mode) privileged ISA 1.10 */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4c70db6def..3318ce440d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1966,6 +1966,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mnepc = env->pc;
         env->pc = env->rnmi_irqvec;
 
+        if (cpu_get_fcfien(env)) {
+            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+        }
+
         /* Trapping to M mode, virt is disabled */
         riscv_cpu_set_mode(env, PRV_M, false);
 
@@ -2133,7 +2137,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index bb022d89e2..c825336519 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -409,6 +409,15 @@ target_ulong helper_mnret(CPURISCVState *env)
 
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
2.47.1


