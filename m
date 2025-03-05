Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106D0C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdy1-0004fA-DG; Tue, 04 Mar 2025 20:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxy-0004UN-QX
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxw-0008WL-GQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223480ea43aso156424565ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139671; x=1741744471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQEm50w7hIBU99p2JPQi53vKIrZxWkieyhO8rz98ZNM=;
 b=YtKpntLsRPrR7l33dGXm11PXo9cnSykizwSUDkbfergKjJYf7HtofoNP625/sboJST
 KjJTJTpn55v6PlPYdNZLTmuLoGiR6z/tD9v0YDf2I+lbwp5aLzt62QA/wdvzGui6HTj5
 47SOG0Q3VwHBnjpOyqL9cndbJ3XhpAJyIYGwb86v8h+ysdj5Ax2tt8xZPk/76E/GayKj
 cV4ziETbb+2+9KIEXhIXxHnBQxH4b6TbO+P49a3XPIXFgVZgIZagD9YuRtgKDzVdDLWK
 LljJEvrwtErBK0no+h/t9LaLcgzsIp6m3d7/sNLXNH+iXYlfckZfdemxEVMBT1F5w7Qq
 BSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139671; x=1741744471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQEm50w7hIBU99p2JPQi53vKIrZxWkieyhO8rz98ZNM=;
 b=TVUCrifLiHfLQYa3eN63LdQtOMg/w5sLd8NUBSZ2YMtdRY4xxfRMK/X8bbBN3d/fu7
 qwVGxAZEIeLHMFaoBjQOYYHMHv+28Qugk2IQqeN0Vb0aa3HnebVdwGForK7hVhdeRxcI
 3ts4af3bgYBJ9Jx+GYmT3qiZbWWXVYlYsmkA4m0G+ct3gPmHnOfhBRZjq1o4BNq2600k
 C1SWuhZbC42dIjn2OYlDOTQaxb58Gi4eBnndDkCH/FashTKKrPvldxXKNVkia3d36Xty
 v9Zcr19jSaGdKYPRxRBGupJXua37Bsfy7V7PaFwry08ChqfA/A/DqDbl8PmeaUKUY/tJ
 mFOg==
X-Gm-Message-State: AOJu0YxhRpRmv4CgG5yKDLcUP9iluN1jWoGizetyWTg390jfj+2uoNEz
 7AbKos4rfWwsknL9cbY7+3zatRfiUo48d9ZzJQ6UoR+tTqrKG0A8WZwmuXDazDs=
X-Gm-Gg: ASbGnctC3tinH7LdJFiCR3wFTRAx72csnopp93bbm88YGUcm7m+xIe3OzaGK+gRYRxu
 OWaI8QCZir67Idnx3EY02QUXyr7XkpWgPkxvTfS5niTZubv7Qyg9fbvhoisJY7AMkBd6iZo75S0
 jZhhJZt+KNzSsa9mshk0fQ5llQZRQzLQNHYcSJWxmiih2ox/jHRrfYKXFYdSupVmGzeNcvLAR7S
 YtLbsnWPDSAhpst9ogBDc1gxm/wholrkCzwlmv4qqB2KFA+WCk8S+Y/akYGg6YVBpHPsTjw3C04
 ZJSVhMkgdPHEtTwKRIpLQhXLoBHAtp2gOfAKDbbM1AFYyvC8nmSbHhScgkp5DLJ9pjNankKAsar
 6Q/Lk/ckbFV1skTQRZqPRwjwMyl/yXaXbetkIBSo8eFM/M182lug=
X-Google-Smtp-Source: AGHT+IHS+0HhkTr1vynsGHC9+hEd5MVqmVnVMmu5gApYlVKEx8UYd+6jWf6bK/0s4UPnWmN3V32mTQ==
X-Received: by 2002:a17:902:db03:b0:223:4998:a75e with SMTP id
 d9443c01a7336-223f1c804f7mr19685385ad.3.1741139670866; 
 Tue, 04 Mar 2025 17:54:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/59] target/riscv: Add CTR sctrclr instruction.
Date: Wed,  5 Mar 2025 11:52:34 +1000
Message-ID: <20250305015307.1463560-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

CTR extension adds a new instruction sctrclr to quickly
clear the recorded entries buffer.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250205-b4-ctr_upstream_v6-v6-5-439d8e06c8ef@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                            |  1 +
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  1 +
 target/riscv/cpu_helper.c                     |  7 +++++
 target/riscv/op_helper.c                      | 29 +++++++++++++++++++
 .../riscv/insn_trans/trans_privileged.c.inc   | 11 +++++++
 6 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9e92144b61..616c3bdc1c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -619,6 +619,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     enum CTRType type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 163121ade5..85d73e492d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a98dab0205..6d1a13c826 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -114,6 +114,7 @@
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
+sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7dbdb34b17..356e84b9a2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -887,6 +887,13 @@ static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5a99c47b12..f156bfab12 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -485,6 +485,35 @@ void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
                         env->priv, env->virt_enabled);
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
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
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index ca52405d7d..8a62b4cfcd 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -75,6 +75,17 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     return true;
 }
 
+static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_helper_ctr_clear(tcg_env);
+        return true;
+    }
+#endif
+    return false;
+}
+
 static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     return false;
-- 
2.48.1


