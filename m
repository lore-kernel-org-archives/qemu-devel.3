Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D641D185F6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2S-0000rd-9M; Thu, 08 Jan 2026 08:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2Q-0000ik-4l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:54 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2O-0003W6-Df
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:53 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so2032885b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878811; x=1768483611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULAUR7NpM52/954YFwisSWw0nlMekmWH6Jtzqs31mW8=;
 b=aYjPeZNlUYIjjSTIwOsLejpZGV1PfCdK8mmZ/9+h9wXc/vbBf4xZHdxhWfVy/SKerY
 LT0B5Q6K7Ntk/lxl/WNy1tctwW1/HnB2mku07ueDuZix7bTqiEWAhDCzRochkeJDQYoL
 qo/l9q7/HSWv6ZpA5JruZmbo1X23UytqcUJDpr5cGxL6DeCM5vg5Ew6K++lyA6Xz4/8A
 a7AV8tZ2S3bKPUyyXzOJ6ovB00r/DpK0BkcGVHUymfel51C5mTox7BJeRGZIPAWiDJrb
 jdeosCu8S3AUn93wOmDmDUjgwjLDq8fgZ4CnBeD7fYrUaMDehzkaBTwtHeAzJi/Jn8b3
 n0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878811; x=1768483611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ULAUR7NpM52/954YFwisSWw0nlMekmWH6Jtzqs31mW8=;
 b=HIXBVNq5I8G7tSHIpMLR+PAPY/zh71aWNkltiG0ZssoKhRVdJl4vOZb3FAuxe1zwqO
 h7iLlABUAlYNlYQmHKnsell1sR2Yi1iyKzRq7myjkjg9NFNKOocaXpwFgoj48beNvaeX
 jUANhtXV9/H4l8+QrY80+44fBKTSVOhb6jtWdlVRk23KRlLwyF3KZpwLliSc2Gz4NJLy
 6+C+MZMmJwwKAscYlbbkivgJPa+AA+rFVBB9qwDpF9Nm5eq66uz5KWPb+qjtEG2gYxfA
 eD+MXxwERp4wHzni5v4AAOQDUbG2t/Sys2CciMRGaQBzIE96rIq5K2TxJ+EHSZKDkuaD
 BXjA==
X-Gm-Message-State: AOJu0YwrF5WHrJbzCgjnRlgt0yM9tnEMBsUFawLCPPdzdI2NVvOmQmMd
 eKvnw/Kng3GBFI47VIyi61ucNiUjjdgxkWOvgpEqaH2OYQ5exzsf5SwdCi/p7KRqX19zXVbQNRT
 DkrbH9gZZaxp0M1WznEEPl3tEvUFReSwxJkrhROq3flME0vj6cUDjYF1uI1w/A5wGm31pkwZjIl
 RDgXVF5n7NZsrBTAEdxbJsm2ci86I5zTGxOToeFgw=
X-Gm-Gg: AY/fxX4l/7Ti8SO1+Zto7UR8KvRuifVUmqot9bQcnbmrPovZpdtzFvdfDHD+IBq0hBG
 JAHVPDhaEfoLWoTaIZQu7aXwSE2Zv6NV84Eplu2yixSk1FtgllbAnhOm8PCe9q41GjKOUwveR2J
 Y4QwP9iJtpQ7SiykH8Em3LjXz7i//d+8fzW+W3PR0x57qcqFdvU8alGi4UwxtVfkGxQ1GGvBd6Q
 zt2feedoBZOC1jUsY6RB7bS/lOPyQ4dkOQXsEA6PfnFct8GqHL2VQxZvXnt3HgRvxLVDzC+HGP5
 Ty8lX27tpxVfP1XgQSckmLxWydWV7OlOB7QbPd3cpOkk0nqBqWG5QDi015DJlj2B829CmK08oo8
 vqV/ThGr1f0KeVepiA2A76LW03u5+ccYKoYSs9beX7jabvkQS5sNiOHBpmpc+/E65DaIk6YEnrJ
 Hx7cuzETl/FxOP8+ZtU6T3DT3aYVH90MCO3lOR47OdAwL7zJyh9rcDZrI=
X-Google-Smtp-Source: AGHT+IH08WGo0D3++qf/mwZsy7wYvtDT18AldpYmTNLFq7BmqKBvSKQt+v9i0ulTxGiWKS9YxDzLYw==
X-Received: by 2002:a05:6a21:6da4:b0:366:14b2:314 with SMTP id
 adf61e73a8af0-3898f9f883fmr5717584637.71.1767878810650; 
 Thu, 08 Jan 2026 05:26:50 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:50 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 5/9] target/riscv: Use the tb->cs_bqse as the extend tb
 flags.
Date: Thu,  8 Jan 2026 21:26:26 +0800
Message-ID: <20260108132631.9429-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

We have more than 32-bits worth of state per TB, so use the
tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.

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
2.43.7


