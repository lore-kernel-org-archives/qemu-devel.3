Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D7BCFA471
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJK8-0006GT-Vy; Fri, 21 Nov 2025 00:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJz-00069x-Tl
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJy-0006pg-6H
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-295548467c7so18938075ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 21:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763701472; x=1764306272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuxsSWXc0dTR/oYhQOqPPr2cG5wBOrul760l+HkCixA=;
 b=ZFXbg6MBIiRohprZwVqGYgDnjb2loY7rKrB3hxbn9I+5+cTOa+gCGy0KFPtPqPOya6
 8Y1cBZmW1JyqrLHAxSj01vKbHols70ysX+8YIWvO7ermzrctLSjWWaAGcwZvwM+Co8sV
 yr3X1bt1PLn/AqeNHhUzHf/R6csmxhN1qp53xysZzu96+scnwWJkWgdHnWreX6QTcK+A
 HHcvA34I9zAVovDt6QYF7+KJYihAdd4j2M61AwRA1DEP6yI4GtUVVXQ4plAtv11N7YQU
 8r5HlXWwXKCRC7AUgBgpeGoqJEwWl1ipzr02GDfrj5g/8U70gOYEYH0pgedKy+KxoSYV
 YSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763701472; x=1764306272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuxsSWXc0dTR/oYhQOqPPr2cG5wBOrul760l+HkCixA=;
 b=A+VttsNYec3Ta92qfQxIBjb6Co+9ASsFkoAu6IJyV3NzA65M5qKMoLhK0bEDdxwQK8
 onc61MlZwkoYn+erlqb5STIQ/3lgCjsQsFSOFGCKg7qmpoXHzvgDkVoErnL1JC4bioRj
 oSEzkItGSu5hW8KKP2zPYGrDapvemWLBDFyFQwPTuKddTF8a/MY9ZhHq42WHOVCsav3d
 n3iCoCRpoPkqFRqjR2OLQDOzyZvHLQ6K8NVd88KcaWbwpwlkNryyYXHDSn7TebiZqFE+
 8qO33+2tSpCaCUNUpEIfSoE0xoBktOnTLXKCm0ZXucSb3f+HapUMx168E/AUOvfpSNXP
 TCHw==
X-Gm-Message-State: AOJu0Ywcy72GbWjAgmK4oGlwf1KbwQu6vjpnQOLLgA9lQoUIz74hOola
 p2BavlnOjYWTwv7/1GEBtCpxTXs9DO2thvKz4Nqlrq8FgPfFaw3d0DwBWQiVuovPrGEalRm14Cc
 Ogl3GHv4w3MKepgfdMO5zwFnQrQEqhzrT1vOWNaHvVdm2IJjWRFVQbLzXi4XyIEwq9M0/QIBrUA
 cAMbk5mHQC5rhAonExTJPY3C52gvBH6wV/erCOLDFp7Aw=
X-Gm-Gg: ASbGncslvJhK9espLZHbfoLTNvhjJuIdnPOUvmWaENVbVyZ4DXlZwbsLl4gL9ZIrZxI
 wc9vbBtx0gnrVvJ0Xld/BgWR8ZCprTC0Lc/HUkLjKdo9DYpy9kjY7bfde2+uC429Qggzi/pR4tQ
 rI5XLPZU56JCjTQrPm/xANYqgJmgLndqHAlzaTlK1NZMf8QnVovH1fJt3UuOENJpAht+27LCjop
 DZ5s4qyGYr9HTn9dqZkCgLtq72lsjnGNUoXjoxqQJvNsDVhJjEKOgmBSaPzaAWAwGJ1sghhdPwq
 UZJi7qWId7XWBRFuoW8egpG5zrS5ggqDRjJGhVRSkkvysE3tllh77PGEfogtLYxAc/YS6V6V+zy
 Vr8Mg2FeHn0zcmN6GW9RDlLM5gtodzADNg9/Z+xu+OM51UZy5jV7JpwDa8+LGspQb9xENhwwnbp
 /4aHKJJsQMevxuvRgzMSU5iO/tqTeFnkLGYYblYw==
X-Google-Smtp-Source: AGHT+IG7hA0Pl8XgYJs6k+FG46KS+uEPyomMUV8HOVZfuC4sVjqW7NHDT1pH1bYsXRz7kttzK4etvQ==
X-Received: by 2002:a17:902:ebc8:b0:295:290d:4afa with SMTP id
 d9443c01a7336-29b6bec6564mr14878085ad.23.1763701471444; 
 Thu, 20 Nov 2025 21:04:31 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b26fed2sm43384525ad.69.2025.11.20.21.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 21:04:31 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 6/6] target/riscv: Fix pointer masking translation mode
 check bug
Date: Fri, 21 Nov 2025 13:04:13 +0800
Message-ID: <20251121050413.3718427-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121050413.3718427-1-frank.chang@sifive.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When running with virtualization in VS/VU mode, or when executing the
virtual-machine load/store instructions (HLV.* and HSV.*), the type of
address that determines which pointer masking rules apply should be
checked against vsatp rather than satp.

As a result, sign extension also applies to the virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h         |  2 +-
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/internals.h   |  4 +---
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9ba01b9f90a..c98f95179cc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -845,7 +845,7 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 958b05aaa32..54ff2881831 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -286,16 +286,27 @@ RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 #endif
 }
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst)
 {
 #ifndef CONFIG_USER_ONLY
     int satp_mode = 0;
-    int priv_mode = cpu_address_mode(env);
+    uint64_t satp;
+    int priv_mode;
+    bool virt = false;
+
+    if (!is_vm_ldst) {
+        riscv_cpu_eff_priv(env, &priv_mode, &virt);
+    } else {
+        priv_mode = get_field(env->hstatus, HSTATUS_SPVP);
+        virt = true;
+    }
+
+    satp = virt ? env->vsatp : env->satp;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        satp_mode = get_field(env->satp, SATP32_MODE);
+        satp_mode = get_field(satp, SATP32_MODE);
     } else {
-        satp_mode = get_field(env->satp, SATP64_MODE);
+        satp_mode = get_field(satp, SATP64_MODE);
     }
 
     return ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b17b661e2a8..38d438fbf93 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -200,9 +200,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
         return addr;
     }
 
-    if (!is_virt_addr) {
-        signext = riscv_cpu_virt_mem_enabled(env);
-    }
+    signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
     pmlen = riscv_pm_get_pmlen(pmm);
     addr = addr << pmlen;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 440626ddfad..2b4bcefa0c9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -104,7 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
-    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env, false);
 
     if (cpu->cfg.ext_zve32x) {
         /*
@@ -255,7 +255,7 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
         return result;
     }
 
-    pm_signext = riscv_cpu_virt_mem_enabled(env);
+    pm_signext = riscv_cpu_virt_mem_enabled(env, false);
     if (pm_signext) {
         return sextract64(result, 0, 64 - pm_len);
     }
-- 
2.43.0


