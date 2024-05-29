Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F053C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsc-00013O-PX; Wed, 29 May 2024 12:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsa-0000yz-DW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsF-0003Mx-CT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so19662115e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716998998; x=1717603798;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iI6lEcod+kV6vGmbuxWzdf/Up/aCvnaIBFk1W2Klj5Y=;
 b=3NdSmr1YeY4zkUZX/DTdnpFiMdGIU/bQ51OQeY8ovFixbhDGJvdI40OycVyjm18nb0
 brEAFM3/CipaBwlsffIt2iMgFgAsbS67k02+PxWAWuNptkM3Hhge+aV51oWiTzF0BjWY
 N9S2n7bzUf9BymdOIdbzLmetoqr50z4Glz1Mb3vi4pH2SmWyvW6qYbxYkWXVFmrx5LcE
 bmugpYhVvMhWRjVbevEeHiNY3SPM9XVpsvBmWg50WYFRkhEXD4hGGafheAWEuYEQDol9
 6L1LPffn585/pt5E4ltituR28UH+jEG+ANsXjF9nnSil1n7IAxFYC3QfXHxfIeLR3JFn
 ibgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998998; x=1717603798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iI6lEcod+kV6vGmbuxWzdf/Up/aCvnaIBFk1W2Klj5Y=;
 b=XbvlKH59lbE4isYyYI+fUtt1ICkUJxmKQIQ7mQo8XO3RGseNLr9x1k0mQeGcuPF69J
 5UwahO7PZEWPeSlrhMmPVqX7mGpw2M1SHGTzB3dNeV/NA0dtWa8hqCQ56myQjpb1JhdO
 zoaReEQfTKCUgJ/Rag2iWZGysHkNyZPxTRpakbcXu2DJhHGoyN/ZuxK/33SfeTCV9NAj
 IaHDEWtGHSV9yeqeO38p2+BtuwN0f6b9Kj2+qP3dZDyVFf6OT2cFCx6vyIGM8FpEO5RY
 suskH4/sKxaWkBqwpXMpxGNp+vsfQBJD3VUXS/9+vF1aeKQf8BNNgW/wB67e9e+vARDF
 IhNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaa20aa8zuKABqH5OHCvp6EUDuT5knZPMALFyU/D94pHtTE+QYxKbwxKd3CBXNX4mttv2mFdEmAk+CTqZX0FSpTN1JSp0=
X-Gm-Message-State: AOJu0YyQgC17C8WaqrpGCeDsBTfJtD9bj/wQ25u6UGPTNh+X2wQz7idm
 LT360OOd7YZzl5j7Wyp7Wor6ImVnodMWlS50f/6ioGpvCLZ4TYvFs9B1LGrxxks=
X-Google-Smtp-Source: AGHT+IEKSXVpvPWdRNTTnkZUuQVzuld8coqRKSWudhLmkIpv62J6mN57sHkahY14egGZJ3Mcm6UJpA==
X-Received: by 2002:a7b:c305:0:b0:41c:2313:d966 with SMTP id
 5b1f17b1804b1-421089d3943mr132846665e9.1.1716998997854; 
 Wed, 29 May 2024 09:09:57 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0740sm15228213f8f.107.2024.05.29.09.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:57 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Subject: [PATCH 5/6] target/riscv: Add CTR sctrclr instruction.
Date: Wed, 29 May 2024 17:09:49 +0100
Message-Id: <20240529160950.132754-6-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160950.132754-1-rkanwal@rivosinc.com>
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

CTR extension adds a new instruction sctrclr to quickly
clear the recorded entries buffer.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h                             |  1 +
 target/riscv/cpu_helper.c                      |  7 +++++++
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 10 ++++++++++
 target/riscv/op_helper.c                       |  5 +++++
 5 files changed, 24 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a294a5372a..fade71aa09 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask);
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
                          uint64_t type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e064a7306e..45502f50a7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -704,6 +704,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask)
     }
 }
 
+void riscv_ctr_clear(CPURISCVState *env)
+{
+    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
+    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
+    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
+}
+
 static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
 {
     switch (priv) {
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 9cb1a1b4ec..d3d38c7c68 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -107,6 +107,7 @@
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
+sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 339d659151..dd9da8651f 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     return true;
 }
 
+static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_ctr_clear(tcg_env);
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c8053d9c2f..89423c04b3 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -461,6 +461,11 @@ void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ulong dest,
     }
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
+    riscv_ctr_clear(env);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.34.1


