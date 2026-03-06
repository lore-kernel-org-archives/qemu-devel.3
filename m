Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909E5F51415
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLL-0003CB-EJ; Fri, 06 Mar 2026 02:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLJ-0003BM-OC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:25 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLI-0007jl-2f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:25 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c738aa3cbbcso1206606a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781083; x=1773385883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwkyvuFqvL3DmB3RXIctZctihtn2i06JRpc/WAF1Vhk=;
 b=U8R9jJcx6rVyWcxHx83DIfoyBldIIzNkStSAvlITKwD+snQhZDuuXmrWGSIcsWosZF
 aEpv3cAwC6RTyixIItoHQewMJX7Motb8u++EFirBaTkxPDbTghOWG+0XL8mudyoaeh+y
 dqN4rR0sTBN+1Rz5y8vGIlqeO5QQK2hDTCSbPCvg750bniwRzV7VWqTN6o+1SnX9IUof
 fjuVG7UYAnTwofIBgPQMNeLnlFiiDBX18JLPDFICssnLAoAtpvwWxtpuXGCSQbk7XM4Q
 Icg9OP8XmdR+6/O647nBsYYtsnkEsvlOrp8kGHDNgqPGZnBAInSBlPcY02a0FIgppbZ5
 wMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781083; x=1773385883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwkyvuFqvL3DmB3RXIctZctihtn2i06JRpc/WAF1Vhk=;
 b=ZWhXa0xlQ3UMdbrYPfznMuDew/GHDg1TfrSYnLYTSv7IkN1JZe/+tk1+uZrpcRmLTs
 MtaddqjjiDy17woa+Z7ukRLa9RNq1jT83DeyL2OFQguRrMhczKDTmBvzezBf/E1znTZZ
 +xGER1pXPMMJqa1ogKPeKfYR3RzMsnmb7JYnHm1Q83r0Ms1TqJ8Z8rJwXND957M4cdFw
 EZx59BuKiAbUwJB+pBLWynohKEzCQQFQ8/bnZw5R698PfXPfK259L8OadZhA3QqEJFqZ
 Mw17xwc7X4fm2uPKdRtJpSXxzUgGytuDS3/IWlx4Wgryvec05YLCQQFO+5zH46F7lXgU
 DCjQ==
X-Gm-Message-State: AOJu0Yy5uCcGxSCyvvMHItauhix7syChs47L18Z4NN+ZRRzaJ7t2MA55
 3LE9HDcoWyow5P6iiboeSlc1OV545vQnBuFovxnkiPOw1MvvvgaXuI+9M2ZOc0tFbIZPos6LNdj
 XeGrIXGrrUWDA2+z4PCevet9uVTl70iuustDyyB8/DkhAAL2iP/+lu/3B6MlHr1ZH8D2SzKhcVU
 Cy0zt7lXGRH8NUOmTmm4FhhJAw0hsxqrJjE7YXFizE5Sdh
X-Gm-Gg: ATEYQzyBk6LQo6OIUs1DQ9fex8h+Plf+G65coQM1Q0ELGLUvflEVhDDTClv471qor9d
 DeOHjcyul04Hs0bnL8c8DLllnJoL9J9vLTuXju3dcR7Rlqs8coFi2iHQQRlsZnHyX4Ib6DuK6bx
 38/qoq8eIR7J9mNknCtSct9088ghzG16ZLMxznfn02bzL47xuydE8YRFOrn78t7KEHZ8KJp9tNM
 2rtXKfyzMJCM7AoLnLDFf11aSupWXBuH2Qg+IckaqRdFNHoArrl85MWLqmHPQKVTDdotEMAnZ3E
 h1gm5+M1Uvf/4pUdGyDCeECXZjKZcXY+DgUD8pcDGnz8EzNb7F1wSK+B7so96KzX6SIXlowPCYZ
 uynwl/LaAPtMP2P/LcUHDcARz3v5fJvTbFJMQhyFCtIDlIv/vbRfljLaqUlxpOMzx51SdZFtA0x
 OrMA2fhCFFwiRehYm4xPctoOBdCObAC5945F3uLGaTnsm4CtIwSpMx5GPV9r+8jOuoHruap4ppP
 OR3GnKEx0SCXtpUHyLbDq3QoU0=
X-Received: by 2002:a05:6a20:cd96:b0:398:4af5:9e04 with SMTP id
 adf61e73a8af0-398590d65dfmr1324100637.68.1772781082298; 
 Thu, 05 Mar 2026 23:11:22 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:21 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags
Date: Fri,  6 Mar 2026 15:11:00 +0800
Message-ID: <20260306071105.3328365-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x536.google.com
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


