Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC0EC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfOT-0004Di-B7; Fri, 17 Jan 2025 00:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNQ-0008WK-7s
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:40 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNO-0006C0-Mg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:40 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21654fdd5daso29500605ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093517; x=1737698317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvdkqG4Go3/xSDmo4Ii1PJ0xtb5LrLWxZWiWdkHVtCE=;
 b=GFL+G3wcEcjMFSQ+kcP1tdYx8hsRCu7DKhbWhFf33j0VKZfeMUVyWAe9T066oJ1Fzo
 ao4hlFfNK+yo9nBE6ZqwY099MOspnlYznvVjZ04y/QdgvVD2a6qHIFkoHMp2skSuQJpS
 A7rsDavtBc5KMc34HzYG3DgSA+Y1dZ6AdtSnBVhF5VWxiTtlQziYtsdNzLzd9vvS6WEF
 VAtLwTCPS8TggW+Oher3i0CXz6kqJ3SX4b+7oc7rXpNUhry4ZF5aEx48lndbV1iF45Ty
 zDiaEGAsCSIIGg3z9TarMA3nR8BhYupSgOanaIs31kjXmmG/lBfV4QtHlM5mgrkycJLL
 ifMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093517; x=1737698317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvdkqG4Go3/xSDmo4Ii1PJ0xtb5LrLWxZWiWdkHVtCE=;
 b=sAmchZDHS0mzTJM4Msa/crjnOBhb+7ACvIRAjhBa8xONrfxvob46ifcxzduAyRIQU4
 UoZTNKedPpzCiFu6Ts2SvwobcWQqfSs3PQUT7vzBvMd/pTP4b+g+7658hekqo1xTPXiE
 dKupef/WEtwsKqXvXGOM2gTz3MJupSH3ilzgVk80NrSKqplwragqMVTSvQa/cExDRYFM
 Vwk5TlDDxd5T2AyBNFhL+5ITXv+hMSrpSd7Apouct3/Fur5od1oF2dwi93nFfUxaqNA6
 TS30i47Sa7bLB5HQGJYDB0NzBdGYl9NfPjfissVonFy7Z/nNXNOfz5QCFvmBv92MJGTz
 Fimw==
X-Gm-Message-State: AOJu0YyikReO34RlPbCGPfE9yQIT159OYIOBeCs4i0U+cJ9cOHnXjYJ8
 g04V1Vzs0LaXywbNmtObRMTAPSfDxnUaAlTd0IpBVDtg47ecU3sVv+PwOQ==
X-Gm-Gg: ASbGncvtHS1hOtpGRH/yLh0r2blDpiZPQ6nY9Q0kO8NQZ0yXp3XO/T+dqRtAaKSgmSz
 qYVcu5ATxEnGI6aGDqUuy8anv0LcY3p2CBYOwD37rYE/COxFGv5enXTegs3L7wdM7rDmxZF5Mil
 E10+cJoKlGsWZ3i7jkfYL1rZPsyYFknrWZN14t08st1+U+9LTfhfZX4r7U95iRZSsPjJfr2Lj84
 1o225Yy9it16CTsHFSMTyw9lm9axtVUvZLw+rpzoaGnP7QP/mO0mCkPJtrPzoWgYTASoKEfUAqF
 5nk3jD87H9r+HvImRIkYkTR6uIznZvI0wcw8y9dzUSGxOKgWhD8SLs0LcuKr
X-Google-Smtp-Source: AGHT+IFp1a/vI3JxYpqj9P6q1S+vPwr1tb3+tIPSlCIrtnWMTQbRf+nOR1o39hnGQngGET03xYaZBg==
X-Received: by 2002:a17:902:d2c5:b0:216:779a:d5f3 with SMTP id
 d9443c01a7336-21c353edbd7mr25262305ad.14.1737093516897; 
 Thu, 16 Jan 2025 21:58:36 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:36 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/50] target/riscv: Implement Smdbltrp behavior
Date: Fri, 17 Jan 2025 15:55:48 +1000
Message-ID: <20250117055552.108376-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
2.47.1


