Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C1C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U5D-0003iy-5B; Mon, 28 Apr 2025 15:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U5B-0003iW-SR
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:24:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U59-0007Ot-Ih
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:24:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2260c91576aso44454545ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745868237; x=1746473037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZIvABSaT73JoHWdEqC95e5mabS4fGuob+IqY91t3yE=;
 b=deS0xEFEcqPrwb3FxBMwRf31WYltW7O1wHH1PsfMgvEHR5w4RlzD3KdJmJdDNOe7pm
 pu/nFHkQc1j4XSSNsG7Yjdvd8s5Cflkz04nJ+x/ZK809AIserlJlPv/6jqs0njdv/lqJ
 XddUtks9PNTziOCjrQ3IrE7ZXIVokuu9jCn4MzgkS+tqZSlPRY9EF7+ELCFuSk/xGPjm
 tavZq6K62OzjM9i23ymEqYYCi8nIzi8ZjdFw3xEOa7K9Vr44SV/Xnj6+KbCo8+2rHYN1
 diMJ0dzAS7tszxVvBGSBTNLjuvLlfOtNLsZOAw5VldN56LsVPuwjD5MvI1Q08jimYkZ0
 S18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868237; x=1746473037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZIvABSaT73JoHWdEqC95e5mabS4fGuob+IqY91t3yE=;
 b=BUPeFekkllyiqfia+q18RfD2COC5bR+/PuEKuVQgQUkydy+BelkjsjzEzODseE866x
 7oW9rhlmR6YpOa9/BavvjsCrBIQvDSaFNu/ZfzltRgqBfQfNvZYLis1u/Q9/Kemjpk3M
 TFywc51glfelnIKvHIdEyXW3BIRQZguH1z4uOXS7w8WdxaG/iwnLHS045iLbORjDCRpB
 NRsu75yRDrkF0u/m7XTLjEXeP/6zjdGUdM/qVeDkyuS4/5HPlzoQgLng3Xpb5LJCZF1N
 K0fXJ0w9Zed/8YiIYIMC9n6mQpcleYGMJia6DdHa6EjiH1cNOTzEukqxfV7WEh5UXe8T
 2Aew==
X-Gm-Message-State: AOJu0YwLl9oR8DiARZr5/KuZ4uY8Vg7Mh4Yas5WCfwoWf5qHaAIWFIG5
 bKh2nPKEg23Bq82knQzC9dPU37Pmew60FCQI5XAwxXK9o+0MFfpMC2RkwVgcfhOBmL8JDJg//yn
 D5dk=
X-Gm-Gg: ASbGncsPyJlBXpdt7LwueiApSWv7mVI42c0dS+esK2MzbHaJzFmIbWCA6V2bxXfh5h8
 oSWyGZiaQqZ8IrdzzOWCaAFNe80DTv4D6U8PV3cDRjMpnBIWBEh4/5u0TJku3+AT9RaJpMXLAhU
 0CyEefC52g5TXlATNAVME9oVV6t3dYDvp4V8WC9gPELdDtnebF/KWKLYgsaSDAbRyMw7I8tKEvK
 TaGR1Kp1EKGCQxa9/ADpwbLqKSjJ6j+y4LX8rRcced63OeK+i/rkB+XuKH1FXwT/CnF2w5gm54+
 XBjrfeKUJOthr0wkQDDk9aU13j7p4szXhwfG2E//C2F8
X-Google-Smtp-Source: AGHT+IFiCW5aKSRjo0qafxqjcMegLspQ0FUZXgMv2FGWGNhd/N8Al89jp1+nRuK04bPpe344dISrJQ==
X-Received: by 2002:a17:903:2292:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22dc6a0d4d1mr150313595ad.25.1745868237391; 
 Mon, 28 Apr 2025 12:23:57 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4db99d3sm87300565ad.53.2025.04.28.12.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:23:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 8/9] target/riscv/kvm: read/write KVM regs via env size
Date: Mon, 28 Apr 2025 16:23:22 -0300
Message-ID: <20250428192323.84992-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428192323.84992-1-dbarboza@ventanamicro.com>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
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

We're going to add support for scounteren in the next patch. KVM defines
as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
field. This will cause the current code to read/write a 64 bit CSR in a
32 bit field when running in a 64 bit CPU.

To prevent that, change the current logic to honor the size of the QEMU
storage instead of the KVM CSR reg.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5efee8adb2..53c34b43a2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
     const char *description;
     target_ulong offset;
     uint64_t kvm_reg_id;
+    uint32_t prop_size;
     bool user_set;
     bool supported;
 } KVMCPUConfig;
@@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
 #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
     {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
      .kvm_reg_id = reg_id}
 
 static KVMCPUConfig kvm_csr_cfgs[] = {
@@ -632,6 +634,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint64_t reg;
+    uint32_t reg32;
     int i, ret;
 
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
@@ -646,9 +649,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
             return ret;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
-            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
+            reg32 = reg & 0xFFFF;
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg32);
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
         } else {
             g_assert_not_reached();
@@ -671,9 +675,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
             continue;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
         } else {
             g_assert_not_reached();
-- 
2.49.0


