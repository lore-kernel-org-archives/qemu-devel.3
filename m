Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE29C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKH-00024A-Bw; Tue, 29 Apr 2025 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKB-0001s2-S6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:35 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kK7-0004Kv-8e
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:34 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22401f4d35aso71677105ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930669; x=1746535469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6R3EUC6CKMFKAnlwhLj+btXOWn++vvQKz0yRoESdjA=;
 b=X2i/1Pd6UXzyP3hFj9U0jz1yOBA4hIMM5CEaSJ2CAACKMBN2XJv0aG17FEtqiWrp+k
 Y9NVzXtcSJKDpf7hPNVBS7BPlbJ42tGifRw1r1xynA95b5yeWrHQW6OMj2q3eVP6awae
 bTprXO5ezsOI7AyB+34iVPm13T6DIG/HPEYrgub3vesYh0HfVH9w8Vra5FoPUxDm3fzh
 hrbM/C2RlNaCD7mS9KEyXYPDSQcEqZefQY9QPSiNxkrCzWLreuE0svS6qLYMEaHrCpiH
 tseJKkg/r5b1tR23QVZ6q8CHsKUk2s0/grhyEPzRPKDV8Ka8EDhBwoZysZcGC2PAjgeG
 7W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930669; x=1746535469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6R3EUC6CKMFKAnlwhLj+btXOWn++vvQKz0yRoESdjA=;
 b=v6hjBZ2uynIptBDEDkJGZZ/IPnxt3U+EwVaIVhr2IfM4U4YD6yd3rJqhpX7FAOFwt7
 K3YWSq648AfuKpD68D47uXoK8LFoFCMAKPZAvFOZcAl2D0PqWoUezYxdfRTlHmQ8A7UN
 w4bqGZO9R4HE8TrJG4qs9eG+PG0TGEBKplmvCbxrjBj8U5S9I1NjoL2DsNDoUPtuD9iW
 54aS37iipU8cOI8t1XDFxMuZjNuv3rJmiiV4KHIFFUgOvUYijuB6TDy5MmFYASEse33M
 77DXtuiSbU2ISfkgYU4SN5p5pZ0FMo1duCFePILYYHFu2qRVlvMosLnUmLNIGF+HMnog
 Oo1Q==
X-Gm-Message-State: AOJu0Yw0ux54x6gNgs7HFLbZvJ53HavgQnww23tTOFmfBipFq/RY8dC9
 DhjtFFJWY7sk7rX/iNLsA8gMcX8G9R+2iEfSAVae2c1Dbq3ApyLocyY585c6HJ7j636Y0/BIbzE
 t
X-Gm-Gg: ASbGncse/P7g3PHBVUIluze2J8Gi+KVbBdABy9K0q3yt0biPrNNJQH88ZRYLob3i6oy
 dx/njH/ENisbDIzON/xzzQd5wUT3e+r+XgerxikaRk+OxEaLQ8EvJTHEDvF9YBWDPQFGQzpwkwj
 YN6P0XqDvo1gODvp+dxOWkE9iJK7zbNMS/1OQwJThsDE6dxFixeODKq8QXTb6wLuSZg8JomoVEF
 dJB4r02t4WEDGOTghRL7lZd7yVHkol+qCTMwbouAFXHZ9Fql+YCaVaZnGA7uiCD5ycVaHA7a9Wf
 lkhzAmDlmluCvARuDrEgBvakbFFO1Maml0YhRNOjZXw=
X-Google-Smtp-Source: AGHT+IGmMhlkUUOja7G84fk0iUqVZ+TD8ZVcKKFoDQZ9WqFsELGXmOs256cY8/umL4ISSk5CqAKbJA==
X-Received: by 2002:a17:90b:2750:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-30a23de91d4mr3386528a91.20.1745930669041; 
 Tue, 29 Apr 2025 05:44:29 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 1/9] target/riscv/kvm: minor fixes/tweaks
Date: Tue, 29 Apr 2025 09:44:13 -0300
Message-ID: <20250429124421.223883-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

Remove an unused 'KVMScratchCPU' pointer argument in
kvm_riscv_check_sbi_dbcn_support().

Put kvm_riscv_reset_regs_csr() after kvm_riscv_put_regs_csr(). This will
make a future patch diff easier to read, when changes in
kvm_riscv_reset_regs_csr() and kvm_riscv_get_regs_csr() will be made.

Fixes: a6b53378f5 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


