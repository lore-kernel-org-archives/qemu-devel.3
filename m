Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0ECED60B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJRD-0005Jn-6I; Tue, 18 Nov 2025 05:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJRB-0005I3-R7
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:53 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJRA-0000BU-EB
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:53 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso4719694b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763463590; x=1764068390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9Gr7L5oeBq63sdEzD0yI7lWtqief3TcLbZ7sPE4Otw=;
 b=EVlSM+DYjSnWMzmhWUgflImTqSNTI1yut/xDsp+EXL7Q1SxAQxmpeBNmcA/eHeONgd
 8+S/uoWE+CEM41Hunc/06VHABtnIk6jascoqvhe606QmXYRzShrUKwHi4mIfjx7yctjt
 FVzx2sFoU729TjSSxSEW0TB5XtPCMvdXGsJHSBSvsYxMBw8LeyIxsGymYuXN1q53O1K6
 eu6JTHa3eIbY6TCqjjh9Lw9XpTYszANrbOyCEp4H861nBfAtqmQbYEXfC2KxIAnF7zAs
 4TCsjx+eIoY/1o/mHeKNjs0nCS75hiL+m1+nr+ZG/YPiVzCl9E6gN0opo5pRPCp20tvW
 R2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763463590; x=1764068390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9Gr7L5oeBq63sdEzD0yI7lWtqief3TcLbZ7sPE4Otw=;
 b=iGUM6idjEYXgPM/DSmhR61SaKbUN41BT10nST0pNPzDwcM6xKANuRG9AQ9ERzJIDvg
 MYl53dfOsbu2+amqrLTfVZb3ezRpX0oMDd+fiA2fpE90+PdZgoN8Pr1MFjyZ9yyKC5mp
 FgQAUWhIa/FYHn+o88ZKBieZKP4lA0VK3Dym/hWHrSUqM5QQctDpp1VAVm89vwMAl7/C
 xr1gcuSWS4fDfZp29Ncbq98VHPjP4R7BCtcZPwM1UA8+oYHR9hLVBgKC2+X+hcn2pp6J
 nwR3qDvX1wjvPRsSN3Enq7VYqT1zF0E4CdhNghv1fnFttxjZA3Br1lP/pimEwhNvphA8
 PLKA==
X-Gm-Message-State: AOJu0Yw+aKwgsEaAHY/K2BXamUiKO1+lVEI1NzHGlAR151yr8VroNOdr
 ZsYEX4VNtWn6ZgKQDWdxSsUsVJchdmwxAlC/PdxYg05eEI5aUOvp/izXs5IGx5/4pZ7FZZy+IfB
 DcLdR3U4g+Cdu8va5+iuSrvwQ18fHJD6hs7wzD5c/JOIRqVZEg5c52V5G0/293v3MQugn72/ici
 hX6Mi6PRHlSCg5qid/aLehlXnN5hPWISvI8Pw3rmQSNxg=
X-Gm-Gg: ASbGncvwMy+0eaK30NzzgH6MHd5hgBTBZmQh4E9hGvAmeCfur4eAqlVZaTpLGYohq7L
 qVMWYPt+FM7kViXJpNAvqH/hXHnD9aDnLuMB0BbtjOadj/UhaQTK1Sdnjwn9bW3+l7JKJoN67HY
 w3ayhKD/+w1an+3fIbWawwg2LQyTuSXXAxK5j5CqmNi0ikmw6bKidZktFD5gHGjEyXgeXsfLA+C
 /KBZlchhHj5yyeQX2c2zd3LgKNOTOziH4Xo9r/Wx4XzuQ1msAMs1/8wttEAmMVCuCm+uf0wZ4MM
 UVC9vwcYvSQ54b8ivHN/1uEIcyXc+5fnXwnUkiJ0PvN+3DbtTDqVpTaFSdD3HgFdUbNTw6f1T8d
 ns/G/dsOFQ1Pws099hEh1OuyXCs+6yMLqec04bc7lw+Q+FlkwfdFOHCk6sLy8uhvk0WSjmBDQJ8
 48eR4JDosrRB8HVE5LF3xOogc6yuqFdd7+BjqNIMQrM62yVFpH
X-Google-Smtp-Source: AGHT+IEHFoQgddtd7tByF9qHOpNzZTVPQDJJro4H3PEe3qvDwYnPLuRxqAAFAECjo6gcovMpLfd2kA==
X-Received: by 2002:a05:7022:f513:b0:11b:a514:b63e with SMTP id
 a92af1059eb24-11ba514bb4fmr2633008c88.14.1763463590162; 
 Tue, 18 Nov 2025 02:59:50 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db4a36asm43989903eec.5.2025.11.18.02.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:59:49 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 3/3] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
Date: Tue, 18 Nov 2025 18:59:36 +0800
Message-ID: <20251118105936.2839054-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118105936.2839054-1-frank.chang@sifive.com>
References: <20251118105936.2839054-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x430.google.com
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

Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm() to better
reflect its actual usage. This function is used when checking the PMM
configuration for virtual-machine load/store instructions (HLV.* and HSV.*).

No functional change intended.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 2 +-
 target/riscv/internals.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8899bf7667a..abc87e64648 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -846,7 +846,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 112093012b0..40b1e8da471 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -190,7 +190,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     int priv_mode = cpu_address_mode(env);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 9b3f01144d2..b17b661e2a8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -190,7 +190,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     /* get pmm field depending on whether addr is */
     if (is_virt_addr) {
-        pmm = riscv_pm_get_virt_pmm(env);
+        pmm = riscv_pm_get_vm_ldst_pmm(env);
     } else {
         pmm = riscv_pm_get_pmm(env);
     }
-- 
2.43.0


