Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417EBFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtA-0007Nu-I9; Wed, 29 Apr 2026 00:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwss-00072i-Tr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsq-0000oH-OU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so72269315ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438247; x=1778043047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyWTd4V1LX1FwIyi0fsHKZKqus546/diDeVLNl78gPI=;
 b=R/EqJdLMI7sSu3+G20o+wtCk5jOM9WjqIjp7eyCy6M85RZxN1buhxEFcFPE9E1WlkX
 juY3SGxEpwG/SsrsbsQEWSwjbBcC3BV1QXicDTeEEG9fr85oqysKhH3cjKUtehJBbbc+
 m+plw75BzTgghWkhpWgCnD+B1C756mza4ZLe370Sr+DgfsnQnEmm56vc5PPTZUWRLGYe
 7kLlRqtccYexM36s1p+CfgKAQqwHqgunEzjGB+FT/cmutb/xeUawAY12wcH/zp7g4uvQ
 a4Gj90iirQrAkl5rqJ1M1EVb2+6tveROE7ZZKKfdJlwkHn+ZNKjT4m2Zjq8XZL3zpWGX
 PkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438247; x=1778043047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CyWTd4V1LX1FwIyi0fsHKZKqus546/diDeVLNl78gPI=;
 b=p3lDd/jJe5KwyuejLHh2C9mNhLlJPW4Qf6HGpKfXsOEev0SODPPtuuDyhkbMwJyHZ4
 QWYLQfDQhyyfGRtrr3Dr+MAHqHpkOaDj7EvwyXewWA6WQjMTLSisYdyoDDIvReGHWtXD
 iCHqG35IcdGOlf5RebgkwPcmO3o3mS3K03B3Q2O5gewU4poFqDzx7MTKXIo29Cvds/af
 rBiRZwRdwsVY6fYgXqjCH2av5s0KQ1rsQXclZ21uuDLZ7GBXZrWbkhnqCRKTvPU2d6Dm
 fO6chWk3/TkKxCkQ4cZruqwuqzDtOsLyavfCOvgrun2WzzwP0MN1u1Xw7IB1fnzTqGx4
 hPMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+COue6U0/ZjZTclxkv2TWtStzfOhWEnAkewU0ADhRgf4cJtdRKNI9M9dCEiTZudgESs8d01HLUVDtm@nongnu.org
X-Gm-Message-State: AOJu0Yz4tEYfKGkwLlOS4ZstR3be2i05UTrIEawMnGnxCzCS9HD76kdD
 FdpmROHsxMDofm1kEDhGErfiC4Sq70LCZlHUbwNbjRDJf5uqGvKiR8+i
X-Gm-Gg: AeBDietXq53wknx4gMc6cBuUUjwS0W8SufgKTbt/c+GRUwNb6MZu2MkNUnq0ox/Zwkm
 w96kqIOiHE6t/6pzlZneBoj9Jk5ao+R1g1FBLSBG9SJc3Rh1PQTejVNv8LRCx2ZIVhvhuYfRvp/
 HeHUQK05tSKvJqkFVS/PG5/wEPRBWBvb39NRbpFJHBTM6SYJiz03bWNS/w3uykfLlMzjN632i1v
 oevu1aZpj4OSCBvcvhQKTxL9g/mtU/Sj70HTnjTge8UnmsHRcfymNevCQ8cqb0+DTa8/PGCmWtu
 IAAVlq5OMyBFzjWv6Qs26y1Oa+CudNhilpoPEARR+u9Ks0ljCvqcNXg0tVjZDMTkG+4MDlzYUTy
 RaY7HgjmEXOgXp3SP00NfYa58MWrtniUrx0Lwatds0OKQqomoWD0wO9s52kuNX9rFjwK9gdsPvE
 8VGOMqMo26r/QqyhBWjDNN0jPVx/zJ/R76aXnQ9Raw77O1waY9wgRU
X-Received: by 2002:a17:902:c40e:b0:2b0:7e4d:f390 with SMTP id
 d9443c01a7336-2b97c4f4770mr60006375ad.41.1777438246956; 
 Tue, 28 Apr 2026 21:50:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/51] target/riscv: Use the tb->cs_base as the extend tb flags
Date: Wed, 29 Apr 2026 14:47:32 +1000
Message-ID: <20260429044752.4176397-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Max Chou <max.chou@sifive.com>

We have more than 32-bits worth of state per TB, so use the
tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-6-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/exec/translation-block.h | 1 +
 target/riscv/cpu.h               | 3 +++
 target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 4f83d5bec9..40cc699031 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -65,6 +65,7 @@ struct TranslationBlock {
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
      * sparc: the next pc of the instruction queue (for delay slots).
+     * riscv: an extension of tb->flags,
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 962cc45073..4c0676ed53 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -703,6 +703,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
+FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
+FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c4f7da7193..f3f7808895 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    uint64_t ext_flags = 0;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     if (cpu->cfg.ext_zve32x) {
@@ -118,6 +119,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 
         /* lmul encoded as in DisasContext::lmul */
         int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
+        uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);
         uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
         uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
         uint32_t maxsz = vlmax << vsew;
@@ -133,6 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
         flags = FIELD_DP32(flags, TB_FLAGS, VMA,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
@@ -189,10 +192,12 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
+    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
         .flags = flags,
-        .cs_base = env->misa_ext,
+        .cs_base = ext_flags,
     };
 }
 
-- 
2.53.0


