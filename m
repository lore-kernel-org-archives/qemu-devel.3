Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC0C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS8i-00086a-PF; Fri, 21 Feb 2025 07:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS78-0006GM-53
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:43 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS75-0007ZF-TU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:41 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220f4dd756eso39399295ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740140797; x=1740745597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcXDBri0g1fUiIwIh0GNJUeIssgoJJnkBzPq36LziBM=;
 b=fnhiyTEYh4WO5hP+oYnYevI6e+EM58N24CMJzarTJ0m952B0qbBEAbZtwnCWF5RI60
 HFS8i98fa9haPzQpld7NLuo7R/Gl6K22CxwaIeiNvMQuf1Chk0JiSpCSz7ZLA5YUmqtJ
 f61LOAeP6IgVqsb87lSzA5LHe0cC0/oJiZNQnQfdxeHv8f2oOr0U+28a8mP/rQvyXM2V
 zTsxZcuulWU2y6z0NeAV7X7UdtNLIHN7LcaXx1X1UldhEqmdSstgwVnFhiqOzRv5qV7E
 /UismeJl7IfjeoGG/5Hpxb4dRLpikpozMdrVls7efO5pTsfVgqSmeAWVN/7Ye/WWtguT
 i99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140797; x=1740745597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcXDBri0g1fUiIwIh0GNJUeIssgoJJnkBzPq36LziBM=;
 b=abhghINJpKRFgy3oDT5e0+uLIvsTjXNzOMiBjNt9yExVas0SoAC9g8eSTO0XKr8Ut+
 7TYC3zbhWEPDyXS2uVfr3I/yLJUVxwoyRtS53Q/qtsUHdttaH1LypYDzciKzL2Lz0aBT
 Y7ThlE78BmzFRahWs1dQZW+f/4DI6r/Wve/FbYZQAiYPZA/ELVILcREpSdLKyQC8ub47
 UDNOv0c3b+T4UFpn3ldSnCM8Ims0occBAXnPAZBhWZOLLFC5sjrMuQ1vQBYKqZfrl6jI
 t8b9UyDyRxmgzHlAka3lTem3ULsjn2Ud8ySlFwkaWogMQR5yU6TP9nUTPd7ifaj3o+Ns
 ebJQ==
X-Gm-Message-State: AOJu0YzC+5FCCzGD8T1SA3d5tv+h2+RtYZK+/+i042HzUiN1JOKmWRTN
 zruj+/e8cQLbHQkXVg5ByPZH/4ZtpJ+g9KTnxkO3k5wZiOt1uke1QVqhKo6LP9VVUXpG3ey2v7H
 6
X-Gm-Gg: ASbGncsajtaKTo2jcgHSWk8t/Hbr0rMsY5POcDE8DqwIKUp2trypSiAKa/ZRGZSvoLf
 E+FJKjLI7ghtvXPKuL+8LuBLAinNcmF9MokqhZSWx3pXFUrRQ6YxAnT2H2uYQoU0lVTh2LUCpJH
 pB0ZME0HpX9PlRIep/MtpQCScx40s19KShaXDHf9uk7uuGLn+O3IvzANtAv5IrdeAH7ooWMQ/nO
 DBqPQ83fEFMQ1rT3ek9k1dYKXn2N96wATMvFCZilZTmtXzUwIbARHARzfK8QKkqczmUIQ5FG+1F
 tFgPXJHkBXIulHmwt8EiGi6nXIjXisGiRwBbTpRtC99wzlKXYnZHZg==
X-Google-Smtp-Source: AGHT+IFV3tYjCFqEm2Jkp3XNzl1+zGp+f3P76lLYF/zVrUOLK3V8yvV1pSnoYT1DgmfgE5yXlZwhFA==
X-Received: by 2002:a17:902:e5d0:b0:21f:5cd8:c67 with SMTP id
 d9443c01a7336-2219ff5f44amr43503845ad.31.1740140797052; 
 Fri, 21 Feb 2025 04:26:37 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545e39bsm137349855ad.124.2025.02.21.04.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:26:36 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/3] target/riscv/kvm: add kvm_riscv_reset_regs_csr()
Date: Fri, 21 Feb 2025 09:26:22 -0300
Message-ID: <20250221122623.495188-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221122623.495188-1-dbarboza@ventanamicro.com>
References: <20250221122623.495188-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

We're setting reset vals for KVM csrs during kvm_riscv_reset_vcpu(), but
in no particular order and missing some of them (like env->mstatus).

Create a helper to do that, unclogging reset_vcpu(), and initialize
env->mstatus as well. Keep the regs in the same order they appear in
struct kvm_riscv_csr from the KVM UAPI, similar to what
kvm_riscv_(get|put)_regs_csr are doing. This will make a bit easier to
add new KVM CSRs and to verify which values we're writing back to KVM
during vcpu reset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 484b6afe7c..f14fcc58bb 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -605,6 +605,19 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
+static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
+{
+    env->mstatus = 0;
+    env->mie = 0;
+    env->stvec = 0;
+    env->sscratch = 0;
+    env->sepc = 0;
+    env->scause = 0;
+    env->stval = 0;
+    env->mip = 0;
+    env->satp = 0;
+}
+
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
@@ -1609,14 +1622,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     env->pc = cpu->env.kernel_addr;
     env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
-    env->satp = 0;
-    env->mie = 0;
-    env->stvec = 0;
-    env->sscratch = 0;
-    env->sepc = 0;
-    env->scause = 0;
-    env->stval = 0;
-    env->mip = 0;
+
+    kvm_riscv_reset_regs_csr(env);
 }
 
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-- 
2.48.1


