Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF87EC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HNE-00018r-N0; Fri, 25 Apr 2025 07:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNC-00017T-Ot
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HN9-0006Vu-AD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223fb0f619dso23656745ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581043; x=1746185843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xE7yE+VfO5HYyjZXuEBehNSR+hFc01/eJnRx7ZSIFg=;
 b=b8NXDMmB9ekYRF6aBqFNDLZH02ZYBIgjtp2QUVwsbuF1FhsYvmAfNcsW8B1/S726o1
 lvNIQvIUDnaPEbQ6+IOWcpb0QRvcv7G0GAJF1YAjJqlPkU4uwLJzE+Q9KY9PbNmna0sL
 6MOVPRGzsS4K6kZR+jNdt95XnZkKAwIq1HSutH7vJdsVHDLvoz5jYCNqy1aHA+75JsWl
 4iFtdTd1WLXvLb6xmp4ZjeU39Pu7xP8Lyj0OSnH1DjOl7CNYzssOcE5egc/WpFdBI9VH
 uMdzS+p41NpK8Jz9uhvBwiXmcxJXDDPbvMfExLjX+k8IuOmZT/GkBA1Xa29jFP2WsVUq
 mSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581043; x=1746185843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xE7yE+VfO5HYyjZXuEBehNSR+hFc01/eJnRx7ZSIFg=;
 b=UPmtfKyrRRXpEnBPLK3PNljemp55Udv35HddkAGsp0zkm91l2YyjyUxOwrZZvy9b8F
 AOZwZVchn52fCLF2/h2Wh93f9fCsdAoAfyHDo7NLK/cPEqiOUbEH7ptvDzeGaoZZ4um9
 ZDY/OZ1MjnjSg29Xmr1t0o3YgN4Fv8R8Ym222YyTVC/04r4fIXGjIRVMqqY/dIhNIpmp
 mrf0i5eb//imiPa54Ru7fc2BWkYy5tF6j3h6ExG7NlcuWPBUtBPCyyzPzV9iOOgLBa8c
 8/nGsrRsT7dEVVrKaSiMjUV+VwntvcSkmRl1ay8uAz9gFdufNKrp+DpYUYftMNEUyCzw
 oZiw==
X-Gm-Message-State: AOJu0YzhahwAsCocxaRWk+Q0iHqg8Xzw6nB3zO/P4kpI1AxrVkhofovs
 uFRzkzsy0UEQJI+HBPRhJpAFIaGdxAD31/JZYFTHelXkT42c87rUMBTn+IpK2+JodmRmEfkn9aG
 /
X-Gm-Gg: ASbGncse5+BNtOco90M1zWe60qMTR1kP6IYNXvo7ID4+6qMbCqD7+trZKVJv1uEgaBo
 6ym0szxAprrcc1Qq7BaHTZAwwD3mnm+uIya67VH/rMN9XwD5iLAg8HBGGZu6/wj+mreGtZdsfV4
 30AxsC8zhu7exhbAXDlX1ylmeMj1wNV6efFtuP3CPOJmMbbkOb1Ks9p9T4TQTaUibCNxjV9kLe8
 0/XT+gSjFaH4jBavfCSTO8WskPndnZ0Yt6GEgqAF94b/SUsEdIAUI10Js3TR6ZUgMTDGFzRa01c
 EHXkf47tVQkH7nGWSxQnixdsQmkSopuLP0vSGibmThF8e5sLnZtT03A9orDY2b7alWQ/EInKFA6
 1fuM=
X-Google-Smtp-Source: AGHT+IE/OyCR8d3Q5+sn1AC7dw44Kkl+GnydtgznWDhOMK8DCOkyXcM01gSBltb8eKbuoFMwdd1sjg==
X-Received: by 2002:a17:902:f651:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-22dbf5ef6bdmr30356485ad.15.1745581040846; 
 Fri, 25 Apr 2025 04:37:20 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a40sm29881055ad.147.2025.04.25.04.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 04:37:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/9] target/riscv/kvm: minor fixes/tweaks
Date: Fri, 25 Apr 2025 08:36:57 -0300
Message-ID: <20250425113705.2741457-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Remove an unused 'KVMScratchCPU' pointer argument in
kvm_riscv_check_sbi_dbcn_support().

Put kvm_riscv_reset_regs_csr() after kvm_riscv_put_regs_csr(). This will
make a future patch diff easier to read, when changes in
kvm_riscv_reset_regs_csr() and kvm_riscv_get_regs_csr() will be made.

Fixes: a6b53378f5 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9214ce490c..accad4c28e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -613,19 +613,6 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
-static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
-{
-    env->mstatus = 0;
-    env->mie = 0;
-    env->stvec = 0;
-    env->sscratch = 0;
-    env->sepc = 0;
-    env->scause = 0;
-    env->stval = 0;
-    env->mip = 0;
-    env->satp = 0;
-}
-
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
@@ -660,6 +647,19 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     return 0;
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
 static int kvm_riscv_get_regs_fp(CPUState *cs)
 {
     int ret = 0;
@@ -1078,7 +1078,6 @@ static int uint64_cmp(const void *a, const void *b)
 }
 
 static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
-                                             KVMScratchCPU *kvmcpu,
                                              struct kvm_reg_list *reglist)
 {
     struct kvm_reg_list *reg_search;
@@ -1197,7 +1196,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
     }
 
-    kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
+    kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
-- 
2.49.0


