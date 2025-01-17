Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75735C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLn-00058A-LB; Fri, 17 Jan 2025 00:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLi-0004sY-MZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:54 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLh-0005yh-4F
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:54 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21670dce0a7so38078855ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093411; x=1737698211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuU1hYhxh08Sxup+rf86tvq3N0a9u06+eK7+anvC8hk=;
 b=gx30zsehbtGMwtDzxa7uBFU0qu4R1sjeTR0NbKZYa+rMOcNlmLh9RNVKNJ8gBAZhDk
 BRpI0TovBjSvCGVKkd0zIskJQlqS9IdH5kfzXslh4FIK6FP4da/zKVKN7r0XDtBc2mmR
 JStz6p+0E/AC2G4VHl6E49pCwwM4F/TS3Fqk4ZicALOjJGynfM6fkYHqANW9Kvzl8uRy
 BBQKU9FcDm9ylxS4gtv/yZIQINgfWSXalZVZzRML54YCjYSeyzotpG1G3J5joDE11+cE
 Aei7XSekzbKyku1i7frS3/V1loHnSuvO4OhvjfmD0IzishStI9kId9/dm/NLzeEydPjT
 ic2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093411; x=1737698211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuU1hYhxh08Sxup+rf86tvq3N0a9u06+eK7+anvC8hk=;
 b=OUaNGa1/q5GQwL5+PFjnjR0CfzSRt5IvHsHsj4lXBJIKnbGt3Yjsjy8PS3lZKgofoh
 LN0f19js5feQNorFue2FS++O+jtvdCsz+MzvicsUBFbR1GlQxb5cZ/W0BTs3yy6d2tiw
 vlyGwN6wwS7jpnbLdy3xEId4a9DHxInMscJZZRTnQLI4Kc4jNLzQlBP1/BStieZHPIM0
 IiFn9Bb6X60yvvRbem75p/SmlPv9cYqmKdayxEbl1EmKZVoqr+0/VyLazeskW7kCXVU8
 OaN+b0FUjB7IGRyYL8vkv9nTkC5f9GtESJDhuSOjAsOdr2jwYS1HoZtBQQnQ9coHlNST
 fYpg==
X-Gm-Message-State: AOJu0YzCNb406M3TSOm69d3iaezpQIDJJZ+vSBYkcAfmwVP6lN4Cq31F
 8ukEOh4EucpXKh/GYU6YolrdNFMasVqVAP1NT8fTR5gKpHtGTy/6BG25og==
X-Gm-Gg: ASbGncvyrNtACoSNeWdPfSoLs7wBTWhq4wjM6XgLHqpu9haKaGgfo4Hkw4lRNyJINcu
 2LrN+Ifh4gut4lrQNus/uYCOn+XqoqBrB3z8kxa22sjic5qqwWxmU5alMbjNMManXYMwtyjMORH
 cyDeFlumfY06jeCs9M+o97olReuTNJEsSBoIlRshUTJiqY7OGXft9ITlTlrZCIj3E3QNZSb1UlZ
 cQVv57Cw+usl9VLjoNqgNSrR/3n1+UDSPNF2cJaO8Bw6ZKJ+0Tcg1hPaDPtJUrixZBXrL+BzOMa
 /ZfXnhsBBn6of5+7hgTmRP26U2Cm28RsDBy9Hg5+D2/UAtSeC/ZEG8OnOTH9
X-Google-Smtp-Source: AGHT+IFUTXOaqEXrJ/XcTHq5ubTbE6XcLvEpCLB33qH8eExEohyZYQskpRk2EQYKR/jiwhmMz2QMQg==
X-Received: by 2002:a17:902:c946:b0:215:8f2e:eeda with SMTP id
 d9443c01a7336-21c35609304mr18184175ad.52.1737093411538; 
 Thu, 16 Jan 2025 21:56:51 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/50] target/riscv: Add helper functions to calculate current
 number of masked bits for pointer masking
Date: Fri, 17 Jan 2025 15:55:17 +1000
Message-ID: <20250117055552.108376-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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
2.47.1


