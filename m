Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A412D3942B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILL-0008TR-0H; Thu, 02 Apr 2026 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IL3-0005fW-1Z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXc-0008Oi-8I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:52:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so704240a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134373; x=1775739173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1RmrZvmgqn2zibYL2Q6/3V19GhkiYpqpBgRyY5xHio=;
 b=PB5NTTMH0N/aYwIG16sPAEGDfVgjRXcXc4rZH9CIQZExK2TsnQb3LZB+qV4Wn7US8G
 ccELh8KEoBEmvgQt+PovM/jsdHXA5nY5gqg1HcTMw7/Kssl0SluhE4LC6/vSnUDKYqGs
 LQFKVffocvrbb26wNNrUv4Xb243Ym+JStGq4gFTjyR5inZT/qL7hxBsMAtJcAxYf76hk
 zuCzBpq3eVIe9kXIJ+QJafyd6CmwJySL6A3pYMbnrcFA89guh8F0K2CotSVycbRMlzi8
 pnZK34MzaSdjDSKTOtz7BciY5sKD7RGHR4lR2oH/Dynn6g5WiEReovnNOcUByfChZy8U
 M9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134373; x=1775739173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1RmrZvmgqn2zibYL2Q6/3V19GhkiYpqpBgRyY5xHio=;
 b=LZpcD9LcmUpmDwlaFKHh4enYxlj3Z3wfKgzsf2Ud9fP0z9B85HyDbhfThFaSz79euw
 XYr20M6J2l4JZDTWWAftbdWS8lgaY9q/ZyvSlRs5zZAt1uD9leuNp9fyr0bbu3lYQHBM
 UdrJRuWYTHHB0goY5E8HcHppCTdJ23qyMgJzyLNQbkJ3Crp0vgSfxNOUA3GV5XhITEK3
 Z0YwB/cfhummn2ZUpLyOskaQJKUFCcEUeMZ8Un9IUN72y9Y6zphclbqpoiFEH4g071f9
 8NQsccKRB1Qec4HygOuiJd9yIgCGJcCREZzgFDwr4+Z96hU+xCAWJ8DeM93wnHh8zF47
 HpqQ==
X-Gm-Message-State: AOJu0Yzjwkrh4wbaWwL8xW8P68hbZWROmRREK2HhS8jROikHbk43EZLJ
 /WjBlIEVBYXbFeO62U8F2tu8MJGkfHdAfkwNv2hvvd65b3xFtryvduJetjLdMsTOOL806orDVZb
 3temazwiHWoJWPFG3p71nI6uLg8ZvaUDXkhlwuO0TGb5fgNaSfDEcRIgvtbA74dNbpFWLM8nxoT
 vyzspv6FrF3DaVm+rlF/gAKlIcPOhWylH4gE7Y7+E=
X-Gm-Gg: AeBDiesV2/H4PRML1PcqJOmxZi3ApBn7W5T5ceKkU+K9CRL3ODytEjM9qGecfKbFFL5
 l+eX60+p8HhdZxqsURqJSXI45f47R0Mz/sgUIC9/6e5PynBKvkD67pLLDOKPqvXDKNrwEUuaa6e
 vrzXtPPK6nqb7SZmVUVn6zYbS4pj4HpzZ5Bqfqb1lmYJ/rC/VRjk4EaLnsIkN1CRqbBUwvx1Cks
 wGGUS0pQdXsfcLH0inrUkdTl0X7vhuV3YW5+Ujn4ipr1K2T2sTNeFnD4ILqGTulu1ihfGCzsUOA
 3sglNcIGHAg7s4+mdPYXqysZ8OAvhJovmeu8k/CiOdDuV264t2RU5vWtaUm48S+Zrg559+HP0l3
 oOhy9UR38Vy4OMpfIol7Nx2bLn1H0HrHOJnKY1JpU/RCynwe1y5mWU2kHHTPcy0nhgCe8PSrgPN
 dndIhjnBgexqlC/vcXR0xiSbPfT3pFOXVGCBIF1gfUVC56u/Wouz5mAvKXE5HOvw2mushSgMbL4
 L71iUxOHMWMJyTv99YLuaPHgsE=
X-Received: by 2002:a17:90b:4c8e:b0:34c:2db6:578f with SMTP id
 98e67ed59e1d1-35dc6f6a323mr6888004a91.19.1775134372643; 
 Thu, 02 Apr 2026 05:52:52 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:52 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags
Date: Thu,  2 Apr 2026 20:52:30 +0800
Message-ID: <20260402125234.1371897-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102a.google.com
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
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
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
2.52.0


