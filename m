Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC429C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSj-0001Se-NQ; Fri, 02 Feb 2024 00:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSc-0001Lu-P2
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:35 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSb-0001sj-1h
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:34 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so1686104a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853091; x=1707457891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms7csWcwYHLSl8fSIIPTDjdA8uF4eqoYfqQ702PkMLU=;
 b=MY9jpEdjrQ0Am71VNtrd8jvXoRgoZhLeixpq3TkfRwQuTgj57I2AJhwg+elZPSrYeJ
 y8w/SzXi++aAvtkIz6iQP6br59hy3XsS9a4hp5r2cZL1n0jKr0xKJFau4i+jercUSCeL
 8oa3yPFTJ/XgH/pX4ET2WMTQEqYAx7PugF+ighEtAaceiFkibJM33Bq8JViN7n5WUnCn
 56p2ETWKAu130Jx/VQ7s0smjnv+xm/Zt/I4Ljh8QZKOU++KbDf2ICBb5lRMvOtvEV1lC
 G1HiEyBfa9vZamHaF8hoeXaX6b6O4RaLYrZluoK9Ir8RPqRuf9ZEyYqp7qxJHoXCDv85
 FBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853091; x=1707457891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ms7csWcwYHLSl8fSIIPTDjdA8uF4eqoYfqQ702PkMLU=;
 b=BPcm41lA23tCnsaLgRDzSQxTImAhzrpEBSmkst8dOsdYORHSxE3C6N1xhPVD8bYDNV
 Nr0LmRs0TKL+p98K10iQvhOqgi0mzZY8QPNO9i24aKSKdixLu9bzx0RBblhu4fXjURNS
 mbzcWasFGz4XyMyrCt7hd4i6kgYnZwzgPkmg9dWnxvRUF73K9El21E+jiKiKKntA6gcD
 Y3SMFOMbFfHnagnA2gQsDVwhkrpMhY3tO7eSp7JIW1+q7L7kAJWHmT+T01JGivoihyZ1
 s6nod8Yk6tXlyYlssg3RngSkVI2pe2spdTkWw6VuvtFV8MRzzyuSnDTNL3lPu2qpL4eL
 VQqw==
X-Gm-Message-State: AOJu0YxmZ2opVzGX+7eVMNl30xtd6T2HECVy4bprTqaWsyBN2b6AwDss
 dyyVnPZlQtIEdMA6n33UUOXfEOpSlX6r2MoC5OR+9sSidSQWt0cDp2q0c9UU8LgHlQ01PEjI4LD
 bIZQ=
X-Google-Smtp-Source: AGHT+IEND4wlQpwpse0QwcTqyRAAjrKfm+TsZ39TAUK/IwvOF63Ckc6jYzmsrbh77srb6GbDGgQvHw==
X-Received: by 2002:a05:6a20:d393:b0:19c:a7e5:37cc with SMTP id
 iq19-20020a056a20d39300b0019ca7e537ccmr5948283pzb.41.1706853091440; 
 Thu, 01 Feb 2024 21:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV+iEpVpPMnk0B3LZSjT3zrp3LIUjiS7tlhzWvWcBXEg5Lr6pM2n/bWuqqGNFte92wYD/D4bOMrU/uneQHrXT2Hpg==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/57] target/riscv: Replace cpu_mmu_index with
 riscv_env_mmu_index
Date: Fri,  2 Feb 2024 15:50:02 +1000
Message-Id: <20240202055036.684176-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the target-specific function name in preference
to the generic name.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c    | 4 ++--
 target/riscv/op_helper.c     | 4 ++--
 target/riscv/vector_helper.c | 9 +++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 15f87ecdb0..b6b23b7d03 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -106,7 +106,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 #else
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
-    flags |= cpu_mmu_index(env, 0);
+    flags |= riscv_env_mmu_index(env, 0);
     fs = get_field(env->mstatus, MSTATUS_FS);
     vs = get_field(env->mstatus, MSTATUS_VS);
 
@@ -1200,7 +1200,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     CPURISCVState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
-    int mmu_idx = cpu_mmu_index(&cpu->env, false);
+    int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, env->virt_enabled, true)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5355225d56..f414aaebdb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -157,7 +157,7 @@ void helper_cbo_zero(CPURISCVState *env, target_ulong address)
 {
     RISCVCPU *cpu = env_archcpu(env);
     uint16_t cbozlen = cpu->cfg.cboz_blocksize;
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = riscv_env_mmu_index(env, false);
     uintptr_t ra = GETPC();
     void *mem;
 
@@ -205,7 +205,7 @@ static void check_zicbom_access(CPURISCVState *env,
                                 uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = riscv_env_mmu_index(env, false);
     uint16_t cbomlen = cpu->cfg.cbom_blocksize;
     void *phost;
     int ret;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c1c3a4d1ea..fe0d5d053c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -113,14 +113,15 @@ static void probe_pages(CPURISCVState *env, target_ulong addr,
 {
     target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
     target_ulong curlen = MIN(pagelen, len);
+    int mmu_index = riscv_env_mmu_index(env, false);
 
     probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                 cpu_mmu_index(env, false), ra);
+                 mmu_index, ra);
     if (len > curlen) {
         addr += curlen;
         curlen = len - curlen;
         probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                     cpu_mmu_index(env, false), ra);
+                     mmu_index, ra);
     }
 }
 
@@ -464,6 +465,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
     target_ulong addr, offset, remain;
+    int mmu_index = riscv_env_mmu_index(env, false);
 
     /* probe every access */
     for (i = env->vstart; i < env->vl; i++) {
@@ -478,8 +480,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
             remain = nf << log2_esz;
             while (remain > 0) {
                 offset = -(addr | TARGET_PAGE_MASK);
-                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
-                                         cpu_mmu_index(env, false));
+                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_index);
                 if (host) {
 #ifdef CONFIG_USER_ONLY
                     if (!page_check_range(addr, offset, PAGE_READ)) {
-- 
2.34.1


