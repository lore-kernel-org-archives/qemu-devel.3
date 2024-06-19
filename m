Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C1C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 15:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJxDy-0005hW-BN; Wed, 19 Jun 2024 11:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDu-0005fP-21
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDs-0005ug-A3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f6559668e1so53938455ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718810863; x=1719415663;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIjql3w4xaxIIjjtiDy+C9BzNUeFkz1MCvH5a9XzY3Y=;
 b=y1esKRJUL8dPEAnxMyMoWF9f64oFYERfN+f/u4Bm9PQOfUtmfDvl3SZgpW+wU+GMrq
 VQ0Nhf+h6f0oQmQckzRYOkvbGSGVL7ifbzWBrI4MB+GJpWkOsX4AnEiOMqQPk1GLbrs0
 M+CL73jw9PiO1D/VNuAWwjB9MdW9i1KmgJ6v7Bkv5VgcldP/NMhvoZsT9y9JTeBj+JJX
 QLFHc/SJiILNdJxwYeY079OT28kX2k4Q7NWAlVWUjM6/saCEqq8PzSWALHa2AfCMHrk2
 w5m0GxN9IL49NipW9jEpkPqsjDqMsAQCZ5J583DsozbnZE5J7hvsN/ZSu27R6ok82Tx+
 uIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810863; x=1719415663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIjql3w4xaxIIjjtiDy+C9BzNUeFkz1MCvH5a9XzY3Y=;
 b=FJo2G8n4miu5RfVO/XVApT9Jgx9Fh3zalFzsYuUVcry0NUcoaLFPloaSm20YhWJTTp
 asp7xxnGaf28CnupvS2clasK3iPiTIs4gPwCJHPNG5k1fPCLK5vZqc5gZdTWE2IZBCkq
 4t7FpQM82rSGOxork9Q8tfW0gw+FbLxIWT5uZGRSRkxhuS8Fc4UB1GO92wfFhhwiJ15r
 tCX3EoaqgVyAxVk3cmCKj34n3Qr3z7zajLECyf/Iw7XSByg+OzgynESIdrSND4ALw2uj
 W/sS5hn9Z7dpog4ZJwRzpLauWajoN9QIvtuxnZrj2vpT3sDuEu1tz9LXELwoo2KV8BAj
 V/OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr+KbkW1C8J3yY6uFiQ01ys8u910Xs0uiqu2wamN2bPH7zVutQwcqddL2a9TMmia6JsKFJDrslJz1yHHJePJr6MNy1jPs=
X-Gm-Message-State: AOJu0Yz349sV21GoOowZj+X/Z4zQkIApo9L0md8FNKSiLZMTywGmca4b
 7j4SAvPT+ozQpDg1Czx6xrdA5NZMAxlDg+0HcOsoM/P0n1og0jf6zuImAaqRtpE=
X-Google-Smtp-Source: AGHT+IEa10MOIg0Esb3gAE9dOT8QYJB6c2b0xvyoWraQGWz9TmpemeqIdXBgGKa84fdRbfmJEFvk/A==
X-Received: by 2002:a17:903:1ce:b0:1f6:8be6:428d with SMTP id
 d9443c01a7336-1f9aa471097mr32009035ad.56.1718810862922; 
 Wed, 19 Jun 2024 08:27:42 -0700 (PDT)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9afada50dsm15956865ad.166.2024.06.19.08.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:27:42 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org,
 jason.chien@sifive.com
Subject: [PATCH v2 5/6] target/riscv: Add CTR sctrclr instruction.
Date: Wed, 19 Jun 2024 16:27:07 +0100
Message-Id: <20240619152708.135991-6-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619152708.135991-1-rkanwal@rivosinc.com>
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rkanwal@rivosinc.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.h                            |  1 +
 target/riscv/cpu_helper.c                     |  7 ++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 10 ++++++
 target/riscv/op_helper.c                      | 33 +++++++++++++++++++
 6 files changed, 53 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e32f5ab146..fdc18a782a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask, bool virt);
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
                          uint64_t type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1537602e1b..d98628cfe3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -702,6 +702,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask, bool virt)
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
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b8fb7c8734..a3b2d87527 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(sret, tl, env, tl)
 DEF_HELPER_2(mret, tl, env, tl)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
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
index 5a1e92c45e..15a770360e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -475,6 +475,39 @@ void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ulong dest,
     }
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
+    if (!riscv_cpu_cfg(env)->ext_ssctr && !riscv_cpu_cfg(env)->ext_smctr) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    /*
+     * It's safe to call smstateen_acc_ok() for umode access regardless of the
+     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If the bit
+     * is zero, smstateen_acc_ok() will return the correct exception code and
+     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In that
+     * scenario the U-mode check below will handle that case.
+     */
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    if (ret != RISCV_EXCP_NONE) {
+        riscv_raise_exception(env, ret, GETPC());
+    }
+
+    if (env->priv == PRV_U) {
+        /*
+         * One corner case is when sctrclr is executed from VU-mode and
+         * mstateen.CTR = 0, in which case we are supposed to raise
+         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
+         * smstateen_acc_ok().
+         */
+        uint32_t excep = env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
+            RISCV_EXCP_ILLEGAL_INST;
+        riscv_raise_exception(env, excep, GETPC());
+    }
+
+    riscv_ctr_clear(env);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.34.1


