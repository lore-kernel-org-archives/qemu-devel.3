Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356A3C98313
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxuk-0000yL-N7; Fri, 16 Jan 2026 23:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxui-0000wu-UI
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:52 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxug-0001bA-Cx
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:52 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c0ec27cad8cso1101875a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624069; x=1769228869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhKx6wgfTyYatD8qmCVKg9zN0KuHu56SoyCFvmL9LT4=;
 b=kFQlfNqet1/rwN1NePJluWTA+dTDK8xjQk4RWAl0zyEObyMbg6qdMPMsQr1D8v4Yay
 SBdU2T8ebmqYE2HMJ0FmagddtXD6OThH7k/E1UCwTHi8s3YKrj3YNLaW9eZ7HoXfArYQ
 pGQN5jmzkhRMIeDVRl6co1UDEUkX4/YwJsx7kARdrQwzWNUY5gjsEOqDK5b2Ti/rQ3Ll
 5+aZEYIH1IkpMeFyfmlhtjckKsx6YdhUCrfEr8oLToKd5t9jtNZfnuDzDMuDihq/axev
 kSjbyMIrnvg9E8TXtBUlOczr4ZwVj52BQcTePAHrL0mEjUr3WvMSwWxAFBr2CDDFIWHg
 K2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624069; x=1769228869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YhKx6wgfTyYatD8qmCVKg9zN0KuHu56SoyCFvmL9LT4=;
 b=aK6iE4D2xpV4qjjj/VBuk1t8UNpIK3D4lSfpG2Z1Z1qEuspJHrDzRQLyvb7s1TBf7p
 KMPy1TAuSNZc2GUa4nw5p/Zdat6WKcNR9E+OW4hcTGMWLl/iOfXC2Zfb+cXRVYmiOI90
 UJ0XYiGPWFEVKq1x4+1RfR0vN6AXo1C+cFOqPSq5BDwmS0ojWVliQk8pbbBdQKNAkFWA
 IV7AlDuGsCcJ+jXs4hWxcaJ2vQdCgICi1TW1/vqg49GTJwFCS4umZrUGvSqL28Wrbxsr
 3lkz5cwkpa3DISovKgMJ+NZ1XrzbFy+x4GYrqB5MJAHB/ikB7sPfo4x5vVR7oeNLDeuY
 EafQ==
X-Gm-Message-State: AOJu0YyKthhYMv48i3+54l/hWzSijOHmhzUBFOfmTjekci491zk+YM4p
 MH8hSK9nPMKCXXduDgigDlohYQ1Rm2tO74fW8se432lrOx8mP51i6SnT
X-Gm-Gg: AY/fxX7RBodkpIt0qM0jIlgwAtElUl7Pw4xlVE8icrdWoVBvvg5hCaSxfETRDP9LnAS
 380Rboc8vdCt9XCqOTg16uGSNBE3Sjc7Qu8ggF1Vcg8zf9KLEowVVoVwoVomU8RzQ/Gv8+yoLFX
 3hkm7vTN/97bl3GZZu+PTYP/pO4UdqY5y3tRtRkmNtCibiANViWtDFYl6wUz53eNCYTAsPlWUl9
 PFxvEM50st6U3MPpk5ZOYo5ib/aMewy2bhv9Do23H4KxfOz57GL7p0pV2N+ipgrBvW89lV3c7Et
 iLfnl/Qoi16Vt7UY8qOmdQ7aTJO+c846LkZrnIjdKDZ6jBacUsD1krxJhCzmW8eukXs0Dk5WUrI
 r6fpIQ/fiID8aGpGV4iB+PxKcq/sJs3wiZa6T4Fy/7Yn3HwKtb7HgSXTLLTr05I+DZquPGfSCsW
 9jvfAi8Vb+T4G2p8GqjV5IbNEFIZjZCFkpMre276pVaQlqpEzDKgWPrXp+HZHeyQ==
X-Received: by 2002:a05:6a21:6d95:b0:33f:df99:11e5 with SMTP id
 adf61e73a8af0-38dfe64d86emr6082743637.28.1768624068795; 
 Fri, 16 Jan 2026 20:27:48 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:48 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 4/8] riscv: add dret instruction
Date: Sat, 17 Jan 2026 12:27:25 +0800
Message-ID: <4e95ab6c30b7ca58140533eda21801c1bf6b9243.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 18 ++++++++++++++++++
 target/riscv/op_helper.c                       | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..6140b6340d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9..318d330c57 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
+dret        0111101    10010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..f8641b1977 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_dret(DisasContext *ctx, arg_dret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->cfg_ptr->ext_sdext) {
+        return false;
+    }
+    decode_save_opc(ctx, 0);
+    translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
+    gen_helper_dret(cpu_pc, tcg_env);
+    exit_tb(ctx); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..99736bbebb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -454,6 +454,22 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+    uintptr_t ra = GETPC();
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    return 0;
+#else
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+    target_ulong retpc = env->dpc & get_xepc_mask(env);
+    riscv_cpu_leave_debug_mode(env);
+    return retpc;
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.52.0


