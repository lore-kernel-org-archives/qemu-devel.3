Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E011C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkra-0004UF-04; Mon, 23 Jun 2025 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTkrL-0004QR-PU
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:21:32 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTkrJ-0006Cp-Rn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:21:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235ef62066eso60215145ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750699288; x=1751304088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDqc6xvB3Efmye7dJiJOwmjCf6rKsctE8jjHmloXd8I=;
 b=o19qAVFn4txB3cpdTzv8eodocnxiu0T9vhwgHJ0TuIZE66xXweyY5nVR3ncqNNYOIu
 3FgwGgeBypcxeJByib8kHLfwsXLx0LVEnybecJsR60UmPqSltsneoXd/rsnU/uvAcTVB
 hQxjgGv94eK76yhSpF3BS0AM8IlJJTvN7JlqMq5wGewM/ENX4uDdIZ7tm4jIChbSP1lq
 o1Ui0KEhEr13jPdcHUorCJNG+2Uhe/scxtWK9/WmQbYH6GdjrPpaBtfO1t9HIO6JMxY/
 xfc06sBD6HwLyaZUhWjIRp3yST4ZbGKmHeeLyUGBaV6phzqPWBPifTFdag3lYJZMV2Oj
 EuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750699288; x=1751304088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDqc6xvB3Efmye7dJiJOwmjCf6rKsctE8jjHmloXd8I=;
 b=MXQwstcBb8RPjPcZc3aEqaUYT44XyZ/ei5bOGAl3gJAyTGVwwH7cJD5SpS8VQ+DHV0
 lz7J776fgAGsNqKOyr9I7nIhKjMiKMWhp6aNzK+gGW1suQur6rw96uDfkPkXAyiIbkrO
 VhL3gIvrAPxT+mwWoX48foAWoToVv1LIq1ppxIu0eRBkb7ph9srGI5KnU7bAmpLvMqUB
 S43meUI3jWXnZ3Hv1z+wBTJP8py45f7rKEnG6/JBFxXBdRBxvkG6EvwyIAVdiq4UyvyM
 oxeEEHCJmuY+5w3vvrL677KJ2WxRzsBiECW+vM9mJJyIMbCEXP5owGeu4eQ9EPPhXNzc
 yUfA==
X-Gm-Message-State: AOJu0Yx1iFmMHwAcul4QyoaiSA+8GxpZwY+acmutVRQTyLLjzzm2XlQa
 BQRJBh2uDARMH3Xw/eAJVC7JRPALCmnPi0QAy75C+wb0XA1F5gdYUheSV9LB5/m1tMg9zfemb8i
 VqPeD4IU=
X-Gm-Gg: ASbGncuKihOdwMssFZZ8ppYEiw3G2cnwXVcrLTpwt6Cm61SkOtTya1AI/2Soj418EA6
 Gp8yh9kX3ff1ziPC5TgoP3gD1xfCHjvjbIlmma2Rf9aW8Yb3523xPsxCzmxo8j2S2Nj1az7CFMm
 AHUIiz28uZNeAlv1MAhhgik+YJIU5jLoLf7DtqkHKzQB6fSMiOzszffZ1+IKNsSTUJr6xQebPHg
 /SdaZRnfVoWvvAQt0J2xKtK8CkrjZE7GHcjUy18vuHPAKXpHCKiBxaDV9cm0VNYoNtyWcewAR9c
 Sww1wwzxGoDqEsbPTjqlJGrxTFoN+d7Cern4kZ+jzbnhDgvHD1CdH3+6UrBpKpkX
X-Google-Smtp-Source: AGHT+IEUByln5o1Klzn0DH8+iv1KvSyApBvkHeCsK0Ub8sgyEQX1T56sqg1h2o5n/vzB4a8+uU3Mvg==
X-Received: by 2002:a17:902:d50a:b0:236:748f:541f with SMTP id
 d9443c01a7336-237d9891ca5mr216546745ad.33.1750699287846; 
 Mon, 23 Jun 2025 10:21:27 -0700 (PDT)
Received: from grind.. ([191.255.35.152]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d873845esm90847525ad.243.2025.06.23.10.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:21:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/3] target/riscv/cpu: add riscv_dump_csr() helper
Date: Mon, 23 Jun 2025 14:21:17 -0300
Message-ID: <20250623172119.997166-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623172119.997166-1-dbarboza@ventanamicro.com>
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

riscv_cpu_dump_state() is using the same pattern to print a CSR given
its number. Add a helper to avoid code repetition.

While we're at it fix the identation of the 'flags & CPU_DUMP_VPU'
block.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 54 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3f8ecef68..67e4eda4f9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -515,6 +515,21 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
+static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
+{
+    target_ulong val = 0;
+    RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
+
+    /*
+     * Rely on the smode, hmode, etc, predicates within csr.c
+     * to do the filtering of the registers that are present.
+     */
+    if (res == RISCV_EXCP_NONE) {
+        qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                     csr_ops[csrno].name, val);
+    }
+}
+
 static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -565,18 +580,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         };
 
         for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
-            int csrno = dump_csrs[i];
-            target_ulong val = 0;
-            RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
-
-            /*
-             * Rely on the smode, hmode, etc, predicates within csr.c
-             * to do the filtering of the registers that are present.
-             */
-            if (res == RISCV_EXCP_NONE) {
-                qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
-                             csr_ops[csrno].name, val);
-            }
+            riscv_dump_csr(env, dump_csrs[i], f);
         }
     }
 #endif
@@ -589,12 +593,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
     if (flags & CPU_DUMP_FPU) {
-        target_ulong val = 0;
-        RISCVException res = riscv_csrrw_debug(env, CSR_FCSR, &val, 0, 0);
-        if (res == RISCV_EXCP_NONE) {
-            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
-                    csr_ops[CSR_FCSR].name, val);
-        }
+        riscv_dump_csr(env, CSR_FCSR, f);
+
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s %016" PRIx64,
                          riscv_fpr_regnames[i], env->fpr[i]);
@@ -612,22 +612,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                     CSR_VL,
                     CSR_VTYPE,
                     CSR_VLENB,
-                };
-        for (i = 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
-            int csrno = dump_rvv_csrs[i];
-            target_ulong val = 0;
-            RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
+        };
+        uint16_t vlenb = cpu->cfg.vlenb;
 
-            /*
-             * Rely on the smode, hmode, etc, predicates within csr.c
-             * to do the filtering of the registers that are present.
-             */
-            if (res == RISCV_EXCP_NONE) {
-                qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
-                             csr_ops[csrno].name, val);
-            }
+        for (i = 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
+            riscv_dump_csr(env, dump_rvv_csrs[i], f);
         }
-        uint16_t vlenb = cpu->cfg.vlenb;
 
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s ", riscv_rvv_regnames[i]);
-- 
2.49.0


