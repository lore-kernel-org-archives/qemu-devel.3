Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83315D1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6m-00012k-UC; Mon, 26 Jan 2026 20:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6h-0000z1-99
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:07 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6f-0008DB-2G
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:02 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-352f60d6c2fso3340236a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478180; x=1770082980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLrMOOfJRndwrguF9Yjw86k+4kSMb46Puxz6hJTHups=;
 b=jzwAy1iXwxUOAHZtPydbpXiH4YKRiL9OjYpm9IDVlIlJsFgHFRSQCaZmomzsBZCSex
 SX6MMphJR+ZJb6s4joz38kmbBqNugsknVV2/546L0h1NBwg6SAcM9a69gp2LtPi/L9GI
 xLcmIdC/FAXKmV4VAoc+3VnRlhymH668dxlrqQhR9rDB2VT7C7FcEdjLx8KyfI5jJLoD
 ahT4A69xRskX9gIM9XzKawznaoNdklx7lJx9TVmKrXGtylDLcPVqVrPlqbbukLLtYSth
 f/4GRlOMT4CoBAUm8p3XCYsnLkUOLa5+saqnkP1ANFf7VQHXIWZdlP2OzGJmGaeDIgNP
 1yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478180; x=1770082980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLrMOOfJRndwrguF9Yjw86k+4kSMb46Puxz6hJTHups=;
 b=a8T0jFSb1YHL+/ersz0cYrH/ABXWMwClvvq4cCkzu4b7DOXCGvELwgWJFPeDYFMVEd
 C6/t/TlMCnNn1rlsq9QPiMfsG8wRdUdjnzek0nB22ZefMIjyNhtrl3MscR+Zgo7FiAiG
 qRMD1/TGEMsiz2CxIhHkxlMe3YezuWGZUJdqhQd3/CWlpx+eBetcZDDOmKkdNiWfWxCU
 E7Rn7sheleeuh+RFlJiD3uZeyNvxT4uCPBQ6fzR5e+DZ9wzNCCYntwZSoGKrowy/Rh/T
 FISgNxntxo5+ixOiYPyGNcn63UctOZVht7G8s5Q5huQxOxeQCAGAAJF7r2FA/NcPr7Gj
 F+bQ==
X-Gm-Message-State: AOJu0YxWi3WSpFlEaCKlY+Lp4G9ZuT/KM+pFonn//QIgihncNN5MNqfg
 Xq7A+XKcw42W/v+U42KE7XRsrK8c1/jA6yDKtYxELQoDdAYruvBFE1w2vNjLJQY5GV0ilj2mE2l
 c34gfXVas6ArARg0T2L8mFLltEHuw2SjNSOsZcl9Pkxj4lLm4glMU1hV/6gdZcdO2/w/79PZUza
 No/EcpUeiHN6vyIfdiWuIWjwjufvILKzTZLQ5Efxepqw==
X-Gm-Gg: AZuq6aL71JDPWQFHZNA/M9sWrFk4shC2jzPhI75MobDlojPlvBeECbMygyqxFYfdSHs
 9EFoyHPBEqD8EhTd6OLr3drps6KD4eggENPl9jie3eh01TiOUkQldSq7yZVN4xP+uoUIBTlXp+I
 xum0X+T1pW2d84e2PDzS21g+plGKOs9NmDNBUlChXBErki4HljRtSrsBgskG16Nj+bK1cOqjwvz
 63UZg/YMSGW+ySSwT/eU+eEg9y9+izg4zaKD45UZFSTlGiqBR+PDw2w6KXSa5UfPmAfwGNg5N5D
 cpAiaMkmLLtfX0bmQS4DH8i6wFLs09JcllFeOvBIyRyYhwGm4QvE8+Hw9W0dsqSNL2nGYOHBnDq
 Yt4UMOsjdUqQweKcxFhn7Oj0xfCZ+1ggp7k3OXaQO5Zx4pW/BxzLa0ikPNFqaPw/43/Wr6iqkGi
 JN4VsJ79FQLLQ9MoaOn40VTgMpRPvog3NevpXhqC3ScDvSs0QlvgB7achritDJ2iE3QfKnU2jn/
 2ezm2mal1ild58O6uqh+Au5PQ==
X-Received: by 2002:a17:90b:54d0:b0:34a:b1ea:6648 with SMTP id
 98e67ed59e1d1-353fecba67bmr195647a91.2.1769478179500; 
 Mon, 26 Jan 2026 17:42:59 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:42:59 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags.
Date: Tue, 27 Jan 2026 09:42:23 +0800
Message-ID: <20260127014227.406653-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127014227.406653-1-max.chou@sifive.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102e.google.com
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

We have more than 32-bits worth of state per TB, so use the
tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
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
index 720ff0c2a3..378b298886 100644
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
2.52.0


