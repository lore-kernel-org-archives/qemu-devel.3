Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF1C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1QP-0001cC-0B; Thu, 09 Jul 2026 22:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QF-0001Sz-5F
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:03 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QC-0008U7-CL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:02 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca80d708489so281763a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652219; x=1784257019; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KYdh1sbz0qRR2rR+j8YCb03KdNxMuFUvxUVM9y5TQOM=;
 b=PccKvJV7pvJ6Ykpr54KJyy9f0opfnS9yBZnzNAoPxwTGORyDg8TY4W+wBqfrjyJSsk
 /TESzl7J5cCrDPdGVTkNdCqG0FH3wZoeHc9Qc47Fxq0ddHJqI/udN+GwicCwXLpzXVEv
 TxFws5mJ4nPcqWhBhJ7bey2aPJQ3O+UqbrEocckxpcs+NnXCLuBK8N05CcU9nqxPlzhh
 jquvTVYMRrMFdO5HBqQBvdGtzh/V+nA4ea3LdeK73DFjexawgjTzKCIEVFjR/6IF/8vf
 BZL/CeNPWtIYvNutxGXwm1SVUKQbNNwOLQQx/3Z9KopDt4WdMklJWc3GBIAezbaYtQs/
 njaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652219; x=1784257019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KYdh1sbz0qRR2rR+j8YCb03KdNxMuFUvxUVM9y5TQOM=;
 b=mV6V5KxaoSMZ08VmFlXC8Q3A3kSqQOJdX/TKpqJonC6oysmhpTbSApGhMux5INMSoO
 dPUz882TAuSSbHIkE+6ONPHtFmdmlRcewe3lbqHSe+Pka6BhJExBaAYlTUx8LVw5iNYo
 7TtzmKodAAPIWKkJCCucqLUOyBNEAH9fohHTchQwC3Dr3ugy1cvOp1KUK2a7QNrpzOb+
 4ZTNa86Qhr+lWfmUNvTD9WZ7W3TGAJJp2y2z31cpzIDHpm/rLx1H8De66uEcw2jltZLp
 HYqu97qTbykityfXP0dxdvA2xg6lYIdbFMXU/ZXo7i3LVfNB2tv1MSyfaONJDRO00TDm
 Fdxg==
X-Gm-Message-State: AOJu0YyQTbLj45ADaqA5noKPJw7q5UhwS4bPYlW7TD4iA5xiROxCNT/p
 8/CoMvNhZMx2n5j4WJQS5AS786+GzkGVboD0hqxXhTWagfrgeSpNqPhDxGZpYg==
X-Gm-Gg: AfdE7cmA4aFe95o5+UvtLzSYOnfOfrhQxpVjIUHpzx63togRa3n4ImlO10Z6AoUJHNL
 7OBqJA8zdcAvrrYh9KHMZY63PZVK7OKOWQ2VmWVkyCfFq1BX8bl7c8LYvqR2T7QTuJz35tqXTY0
 /hzmAIXgL6BtLNV1InZlUYW7np14kdCcSa0fiklrdx6iFHTP86R5baesjM24Ab2lQn5GIjJLAvg
 VJgrFUbrVOPU1qzv+2uzxM961tsK1pepHgueF5DOVZKwxTB4WhF/zckBS3q+P+GT1d1uvanos3F
 LzQBUo3EfQYFSzlww373BPXMJBR7/+96uAdyJyKFr/rZrWNiGqtVJ508z2JAAKAv76VEj6U1RYF
 e26QW216mPJ7D8Es8eFGPQFblfOLEFwrILDZTswgLTF+UfP63r3tn6pL5qicWQF8+a9ylDvPjxs
 SujkJlAaQF6sztVbTSYw7JaC3HlX5W2sM=
X-Received: by 2002:a05:6a21:6115:b0:3bf:aa54:4cbc with SMTP id
 adf61e73a8af0-3c0f0b6fda4mr1868336637.26.1783652218638; 
 Thu, 09 Jul 2026 19:56:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 25/40] target/riscv/gdbstub.c: isolate TCG only checks
Date: Fri, 10 Jul 2026 12:55:10 +1000
Message-ID: <20260710025525.1704417-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The following functions are TCG only and are broken, if they were ever
usable in the first place, with KVM:

- riscv_gdb_(get|se)t_csr
- riscv_gdb_(get|set)_virtual
- riscv_gen_dynamic_csr_feature

Gate everything with TCG enabled to at least get them out of the way to
enable --disable-tcg.

As a note for the future: other archs have distincts gdbstub files for
each accelerator.  There's a strong case for RISC-V to do the same.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703180538.3346781-20-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index f0a5e0d86f..9abbf5bcdf 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -164,6 +164,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
+#ifdef CONFIG_TCG
 static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -294,6 +295,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
 
     return &cpu->dyn_csr_feature;
 }
+#endif /* CONFIG_TCG */
 
 static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 {
@@ -336,7 +338,6 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     if (env->misa_ext & RVD) {
@@ -351,6 +352,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  riscv_gdb_set_vector,
                                  ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs));
     }
+
+#ifdef CONFIG_TCG
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+
     switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
@@ -371,4 +376,5 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                                  riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs));
     }
+#endif
 }
-- 
2.54.0


