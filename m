Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944ACD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Pk-00045h-Mx; Fri, 09 Jan 2026 01:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PB-0003ZT-2m
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:31 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P9-0002ox-HM
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:28 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so1285950b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941726; x=1768546526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEEhUQKWzw7fzFc87JZFv1y0Ud0JmfLrIoan4P4nv+Y=;
 b=Ze0Q1xwCc9rixAfERWQvIPvMaC7PStGRbonVkR7ja13SxoAqvYCZZEOR7yHPV/kF0H
 q0dqAk9yhzSqgkafxMhb0Byx9NvgsYYxEEW+BflAQQwziLL5Uuz3bstnLFHMmQaWKXVW
 +vJxx0YC8wQnMWX1Ylj9Uc6winoul/gLhGceozDyF5w1PLJfY4uva7WIoxxFyPZdbk2l
 W2Anu/hGiqkrJ1/WNx2eZViHUOEgflOYP9G5cHIJJSoic53W6YVbDqb5kDgoednpIJ4G
 euN3fp5zFEEC/1R+Y9je0Rq/xVkV412JK2/TsegEaOwPXVEPcPzW/QAISs/dikVIeHqF
 YV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941726; x=1768546526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEEhUQKWzw7fzFc87JZFv1y0Ud0JmfLrIoan4P4nv+Y=;
 b=v58cVJcMtaUb78exyUHXszvm95Xnxc0EWYmwhJ2hCqKQWsmC7tEw+z7JHNWh/ninuZ
 DY5b3FdOADZWl4poW1Gwmp54EFJ1LTVNfhMZNIOZD5VaU88O+Ts5da25x9aeacMm3rVR
 peNMnAa+I237IxTJSSix7LD9kYylJ8Uv60XtaO7BAvPMI9pZtV9FmTiLZ3JhgtjnPeYH
 xz/aoVr5w5pEv1cF9XCUJyUZZpBbrV3xvfXom6SwQoFLABaafDP4JbNWp0FdKXppzs0i
 DYnggIVWGmk3YT+U/2NVZzaZW/ZYG26udhPAahzVVWBx5R7q0cvez7oTtLQxygU2lusA
 IQHQ==
X-Gm-Message-State: AOJu0YyFZqKc77YVdEz+jeubRX4KyEaNuZ7AufTM5Ry5RK+5C2ekOD1p
 4Q6m914G78y2CQs0ziKQ5avzTn2wMi1CV+0O/Xt+ByORHdvnBIjukc4vEOEQKA==
X-Gm-Gg: AY/fxX6om5fpPx5Li/Q9DXkrqlk0IBV0P+94bEkI7yA2TRMgMGvuFNc3Kx8LDO395JR
 RBs+DTqzUY1AV+gHbcXKAYT3sUlj+Ny0c68GZFIQpyGdDs6y0J/WEyKmZl9tPGXzMjAXrsoJS3V
 3Puunns8SDlgShgUP9FRM6sh7Li1lRfqgMia3uj+BKcezYm0HaM8Z4xd/Zj0XpAfwcm1GJCKgUy
 npfnNmhoJkM9esVQGy0T3WUEUr43482eJKfxX0nzeffIrRDEMUC41GqBfFV164eCCjRwSM9DpwJ
 VEGj4phbt7gov09ZHun8Wg7QjagRCQn2JCQuQPZum4BpVcfsXKdMS5X3gkXzc8nssdnfOmXMMX/
 q8HgRL+EgEc2Iq15KLoStsfJTeHfrZjy3xNfzyoDSZwbQLF9zGsGl1kei1sBoKmuKOrwnN0uuIf
 4iXRaj6rCsELVzWeF1kPihizSa4KaZvy3On4o1yqj0Z8uJKENfqmrGl6hXO8rC3/H1jw7jZdW/O
 /6LMxL4ez6r0lqDZeg=
X-Google-Smtp-Source: AGHT+IGf6nWqEVlkx34GYjKr8HJ9qFysOJPGrnjVkzSZpiiRLX9ZvQgr1Sv8hf3VkZ5Ecz1OH15xWQ==
X-Received: by 2002:a05:6a21:62ca:b0:37d:e26a:bff2 with SMTP id
 adf61e73a8af0-38982b1ffbbmr12199079637.20.1767941725548; 
 Thu, 08 Jan 2026 22:55:25 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:24 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/34] target/riscv/cpu: add riscv_dump_csr() helper
Date: Fri,  9 Jan 2026 16:54:30 +1000
Message-ID: <20260109065459.19987-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

riscv_cpu_dump_state() is using the same pattern to print a CSR given
its number. Add a helper to avoid code repetition.

While we're at it fix the identation of the 'flags & CPU_DUMP_VPU'
block.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250623172119.997166-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 54 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f26d8b8b0..c22c418625 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -516,6 +516,21 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
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
@@ -566,18 +581,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
@@ -590,12 +594,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
@@ -613,22 +613,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
2.52.0


