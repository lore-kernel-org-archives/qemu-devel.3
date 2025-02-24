Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B766C021B8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTll-0000G1-2Y; Mon, 24 Feb 2025 03:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlW-00005W-8Q
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:41 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlR-00019Y-9Y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:35 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22104c4de96so67765765ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385471; x=1740990271; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AqEFQR6NtqYF016dWrhbdwKDvTxMgBYRr2uJaanV30U=;
 b=gWq9A+ify6ClIR+tq8nSwPQHghtwaY9ls2lsirVyosmNtw1W7bigd0bsIvdrOMtuCq
 q4HNE1G4OA07EuT1wJqkwgqqMh/JWhF2gnXig29cVQ8OqqUjEL+t64L/V3iLi7b42NXd
 jDp2edwGNzzRZ6H0M7VneTqS4fcUOpGaH6zJV2vdpyK8pPEH6hrcNwfOK0kLaFY8M76u
 nKd/BaS9+AHddRUfxArHgasDlyiVZb0I2E3flk0Mt0LjLmYoy/TudQIbMWh9S2gb/Ogk
 MHHUFG+ObnaRhrLKUJzjxayajJyaY/yXqbs0bnsgMt9M1XO/2ySdB12o/LvICfV7DlzE
 O32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385471; x=1740990271;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AqEFQR6NtqYF016dWrhbdwKDvTxMgBYRr2uJaanV30U=;
 b=gumdV4tz++uEhXx5ergQCbTK60rUp21bw00g7RYn02Ll+0X2SkMmkvPAvb441R2H9K
 9PHi4I13VPEi/pzOclW+TRL1U6daUsQYXxseDYNW4VyOFCn4Yb7o/I4OljR202G4WOTV
 MutNT6eCNaDa3xk3sor/iqwUrk9Hj4hhpcM+g3Raqs4JzWlYP7lTedNaXFku3zzBWLVk
 3KDkawHzkvMlYuzYe58Ecpz/xaIYENNMcMWjgSh8qZMIygQOtg2QFMjxNgliPIa6syUJ
 CVIDvcyAWRjcbl4adlxQQuVZaKrPjEtF6N6xMDjf5D7T3EM9SbbVODGMORFOYaM8S0Rj
 2DMQ==
X-Gm-Message-State: AOJu0YzRe/JMeFZjoLGtCNW3Kii/YuhknVqm8NkgLNGTxsR15PdT42dy
 Oa7rIpfJrH37JdLYeU6/KcAQXczTNsshp9PVbNa3/uiDsBrnzO7gAKmRNT5o9xZEEODDEM5pMc6
 eTbI55TRjEJ3liZTFsY23RycJUZD4VdUgYnrv9UyA5YCbVfTFxVqaZoZ/Qsaj3w6oJVwF4jpHS5
 /CFfVjPr4K17DHCRdhLdMJpqvmERbmvTrh9AXA7A31Zg==
X-Gm-Gg: ASbGncu6eR9fDldKQIyM1pPmkaGyFshegMaPvVrhsNYh+t+LfzIdV3tKVzzcQyiZU+P
 sb6AUGkE6WPShxR1dSy8vhF4Qzc5ML/Bpfkj6pNA56vGDZiQuCtgEuMaf916kffb23yYFCyDJl8
 W1rHFyfH0/AXOWNVSgwMnIEk4MHb4caJ2ITejlHNXrT4rEdcmghjehtRt/aE0jolNtx3AYA5JN6
 x8ZDQ4ds0h8iLdBgY12Ygw7J9hrXXtDwJigSfMvX1r7ERjSgpxH2NBRPIOeOHfk3OR3EIzhN5+o
 EhaEe7EHvQz5ViNuNVmZ32w80LB/9ukTc0vjGgIdUzy3KPRlf67fJpa9
X-Google-Smtp-Source: AGHT+IF5QqudS/guWJAwcTCu7MubeLiRik2qZEgTLndydkU2C2LlObe5fgmUapkZfrPinHV8GkaCVw==
X-Received: by 2002:a05:6a21:501:b0:1f0:ea87:b40e with SMTP id
 adf61e73a8af0-1f0ea87b40fmr4464540637.41.1740385471311; 
 Mon, 24 Feb 2025 00:24:31 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:24:30 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/8] target/riscv/kvm: rewrite get/set for KVM_REG_RISCV_CSR
Date: Mon, 24 Feb 2025 16:24:08 +0800
Message-Id: <20250224082417.31382-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x62b.google.com
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

As KVM_REG_RISCV_CSR includes several subtypes of CSR, rewrite the
related macros and functions to prepare for other subtypes.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/kvm/kvm-cpu.c | 70 +++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 471fd554b369..ff1211d2fe39 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -111,9 +111,8 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
                            KVM_REG_RISCV_CORE_REG(name))
 
-#define RISCV_CSR_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
-                           KVM_REG_RISCV_CSR_REG(name))
+#define RISCV_CSR_REG(env, idx) \
+    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, idx)
 
 #define RISCV_CONFIG_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
@@ -130,17 +129,20 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
-#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
+#define RISCV_GENERAL_CSR_REG(name) \
+    (KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(name))
+
+#define KVM_RISCV_GET_CSR(cs, env, idx, reg) \
     do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
         if (_ret) { \
             return _ret; \
         } \
     } while (0)
 
-#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
+#define KVM_RISCV_SET_CSR(cs, env, idx, reg) \
     do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
         if (_ret) { \
             return _ret; \
         } \
@@ -608,36 +610,50 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
-static int kvm_riscv_get_regs_csr(CPUState *cs)
+static int kvm_riscv_get_regs_general_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sstatus), env->mstatus);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sie), env->mie);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stvec), env->stvec);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sscratch), env->sscratch);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sepc), env->sepc);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(scause), env->scause);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stval), env->stval);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sip), env->mip);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(satp), env->satp);
 
     return 0;
 }
 
-static int kvm_riscv_put_regs_csr(CPUState *cs)
+static int kvm_riscv_put_regs_general_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sstatus), env->mstatus);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sie), env->mie);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stvec), env->stvec);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sscratch), env->sscratch);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sepc), env->sepc);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(scause), env->scause);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stval), env->stval);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sip), env->mip);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(satp), env->satp);
+
+    return 0;
+}
+
+static int kvm_riscv_get_regs_csr(CPUState *cs)
+{
+    kvm_riscv_get_regs_general_csr(cs);
+
+    return 0;
+}
+
+static int kvm_riscv_put_regs_csr(CPUState *cs)
+{
+    kvm_riscv_put_regs_general_csr(cs);
 
     return 0;
 }
-- 
2.17.1


