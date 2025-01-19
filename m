Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A9C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsb-0001ie-Pj; Sat, 18 Jan 2025 20:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsa-0001gA-1r
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:32 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsY-0003Dr-DN
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:31 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso4405744a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249209; x=1737854009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ges476hNnkpNnHf1j25jILToIcn3Oa5sIx2Zj7FHfM=;
 b=gIcGjgAa8uttZYxWwu2VjI+rR17dnlR9H6IHRX7YSdpYE7ez+BznB0bROF7AX/awGH
 1I31d2nwJcx/eCjXxKkTIp8EbSJHCjnHN6hojr7aOuK0LLukYZSuNBaJWjFnrF4sUdyE
 PhEvxv7E8EmqilY5DDmYKg71naYxKZFWMY9lva2A3bwB8leaKxyTIuo30wcFOixv1fPo
 mnYaI/g17lHOugFmkkF21ry4yl06N1Ub06OQpuvT2KoeG8PLVLBX/0ig+WnoCXFbVDAb
 TzYtbzvIN5C1qB4/Qo9NeOKghzxBMDqfqY+C3hHiORpMSelji+F/w9jd6UtC0uylvSdd
 3Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249209; x=1737854009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ges476hNnkpNnHf1j25jILToIcn3Oa5sIx2Zj7FHfM=;
 b=sS9rbpXdpUPXGDPlwxM1FaaMZwHKYF2W40zn5ZzqeFVd6yXF7GKBed2a/S1KwdyZQN
 5SIM78gkX4hh9bn8DBaAueLIcQG3c+C1zJpnlITNvewSGVe+HhW8SPvcSs4QznPLndG5
 gJl0QXP8JWakIpeQIK/Qykjyq2/lKEYpnbxIBkjv2ZW8yXE02VS1vzHo91uLdvYKPyU2
 tE+4djEcea/Yz5edvwQK9S+ehQy9K3Aks5NhlVnr6uwGFmK48MpEpuwf5UdOST7vWriG
 11Q6XiMcnmVPBCT2FinkKY6FYywjX5ouokcaC5oX8+Bv+Dxd9hnFZ7GPoJpegOuLCu23
 pRKg==
X-Gm-Message-State: AOJu0Yw+rD0g/QwUXjEg7yLtlc/IkTTwjburhVefZ7Ap8FINhoet48e2
 XmucIx6jlhuKtL9x3i859vMKrkVvHra/fTzmBuZ2szVHcfRQgiBa481LtFVW
X-Gm-Gg: ASbGncvIHGikkXb+oH91rBi7qJiepR2Fis2/aTO7FMhhh+GHWvSP+ujqVasSTnJ60hi
 xRNbuIGkui3mFxm5YJDvSYucUtg68AjjHUXC2nZ4qNt7V21xySvPNqakWDwNiQdY+0WmlVUQuiy
 n+qacHwrvOhWSJfILFKUmpylsp5G1ZU2izupPLX2keRwaloZiK61/RSt5gzKaJiL63addhXjsiV
 B3FAwSfRoXkOXeHuHZtnxS33c/UXsgWWIjrLhs+hXe8COtHzrj1yqp+3Z7aK1jR6ytGQbPCcSLz
 8xO9Q42XCF1GOD1V5c/6fSjna8kLGga14ndcFwCoXrxlwh3Dev1owtecMAh6KpHMiTnAUVaZqg=
 =
X-Google-Smtp-Source: AGHT+IHWQEOXeIfIOLdIkkgrbBxKvFRurzyPK1Ik8t2/6eXtJqF7hYprALLtfWT+0qcaUpyzRvvjiQ==
X-Received: by 2002:a17:90b:4ed0:b0:2ee:c1d2:bc67 with SMTP id
 98e67ed59e1d1-2f782c99704mr12660846a91.16.1737249208781; 
 Sat, 18 Jan 2025 17:13:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 15/50] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Sun, 19 Jan 2025 11:11:50 +1000
Message-ID: <20250119011225.11452-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106102346.1100149-4-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ad33e96ddf..5c85e8b28d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -772,8 +772,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8c1969294f..0e030d4ecb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,6 +214,84 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+
+    if (get_field(env->mstatus, MSTATUS_MPRV) &&
+        get_field(env->mstatus, MSTATUS_MXR)) {
+        return PMM_FIELD_DISABLED;
+    }
+
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        if (riscv_cpu_cfg(env)->ext_smmpm) {
+            return get_field(env->mseccfg, MSECCFG_PMM);
+        }
+        break;
+    case PRV_S:
+        if (riscv_cpu_cfg(env)->ext_smnpm) {
+            if (get_field(env->mstatus, MSTATUS_MPV)) {
+                return get_field(env->henvcfg, HENVCFG_PMM);
+            } else {
+                return get_field(env->menvcfg, MENVCFG_PMM);
+            }
+        }
+        break;
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->senvcfg, SENVCFG_PMM);
+            }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
+                return get_field(env->menvcfg, MENVCFG_PMM);
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return PMM_FIELD_DISABLED;
+#else
+    return PMM_FIELD_DISABLED;
+#endif
+}
+
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    int satp_mode = 0;
+    int priv_mode = cpu_address_mode(env);
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        satp_mode = get_field(env->satp, SATP32_MODE);
+    } else {
+        satp_mode = get_field(env->satp, SATP64_MODE);
+    }
+
+    return ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
+#else
+    return false;
+#endif
+}
+
+uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm)
+{
+    switch (pmm) {
+    case PMM_FIELD_DISABLED:
+        return 0;
+    case PMM_FIELD_PMLEN7:
+        return 7;
+    case PMM_FIELD_PMLEN16:
+        return 16;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /*
-- 
2.48.1


