Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EEFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KFO-0000uu-DX; Wed, 24 Sep 2025 03:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KFJ-0000tZ-J1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:49:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KFC-0007dz-6h
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:49:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2698d47e776so48064215ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758700127; x=1759304927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojdUEYl9Lbk4rUbClRXCfBPwqK3RCWoKxJJxNd/cr2s=;
 b=PBR5+1aE/dZF03ocNTuTAOs0w9KXqQp5Sr8CcrDO7muT7jGzzLRwhsAYXQWyPKuP3r
 0nbDi0HFVn3QdmIXt4uvXT5LQFhFSGEl07+90T7IRQA1RjDZXJUA80Row5EIDFSQXx3w
 gRvdUTHRRaMF1W1A718DqzwcRcFIkmgFxBMWOzFjHcaa53T1DPwFvNDcVw1ZeoT3sC7E
 auxThna8GqWkWJGH3ljy5vDJ24KDAxkXjZpFi73+xWdPXtCc6nGAcOlckpuy9fgpAt0h
 Bd2GOPMYr8L0IHbEtRrtTF7soXTXcR8tVBQ2esu2KnKwquFX14Ywwxz/seT83Kh4pttN
 nqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758700127; x=1759304927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojdUEYl9Lbk4rUbClRXCfBPwqK3RCWoKxJJxNd/cr2s=;
 b=iIl4qLxBDUHTaw8hVbdUDs7tiKz0vfQYbmhlSA+M+nVICjbSFWjsBb7jDFWDKblhpk
 hq8Fe34KHufePL/b5r1xZ3F81QgqIzftKvNTHLBX2ET/4zOPBprV5tJ2twI+nKmTEzh0
 ZeRplO2rcsF/WCQlqSJK1jxe3/JpvdtwWMrDDybPckCVMKpto9Z0vzQOh5YRwBHPQQfx
 uqgACfc+HPVqa599fcQ45YuhR5ErMVU68fZYwKbuQONjmBCcilVIXNOem6Dwvxo5EBwG
 iCwfBDXjtpYV4aT70Cfd3bvuOXyG8kMzQQSnd7bcGDfPLsLtM+IqGBxBy9iEvnp4gkg0
 KC5g==
X-Gm-Message-State: AOJu0YzgyB+HE4SUuz4CXEtwNQL9aZ7LE5uwJ4P2B2oxUQ+zk4wHXloi
 dbpMtFcO6BhMRblh+QQlP/YlyhszZPTja1McBsp+CFFo+a6UNrVeK5/onXxGUE41iaIJjadnC2p
 zzdeaTNycpC1Ob0eBdnj6pfYXOx3msLDDlef9C4N5PPikH2mQOKjiJBAlEfeR8xhR3T//sgB54U
 LL3fZFH0DD/oGHtSgEMyCdYzolwuPMGGR1pC7gmA==
X-Gm-Gg: ASbGncv5lIctRAANiOOBynH89+jrS/BVsBUAfz4EATGblqZVl7prDTPTeRW6PMOXZkG
 WXbJ/wj5ujtfIr+GLxegVO6h5ha8opsxtwbmCKzPCuDCf2DiHrt/w1+4uoROS0XSGdHuyOuHyx7
 QzVg++NafWYvhC/edXoIjlBKOl/M6NLfmfR2XkYTqUBzsF5fmdoXjRDZ2iUhl6XpYeAgHdxOpH6
 XKEWVd91WDa1Hx/57C4EdfaV2cIvPzJloJkBiJTrXzA/rTstxioWHL+w5l88owZtKO11DmJM7SS
 sOpMR08JNByoJx0I6YwtsRhAgdKB2VSnjtLMfKhZD1lSnyN+mnIeh4WmGqKvEpBOawwvdJuAiKC
 xhtvGLk6zRmCligktvcQTLAHEhECTyUVElHunSMzzmZvm
X-Google-Smtp-Source: AGHT+IH/1pYoQAma4pPmBTo3WalDFbmbrpkTdz+H3LWfkBXZsc4ls0A7feq/6dzkiQ51t16jgFUe1Q==
X-Received: by 2002:a17:903:32c8:b0:24c:7b94:2f87 with SMTP id
 d9443c01a7336-27cc156e18dmr69369035ad.14.1758700126617; 
 Wed, 24 Sep 2025 00:48:46 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5541f0374csm8778502a12.49.2025.09.24.00.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 00:48:46 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v1 3/3] target/riscv: Fix ssamoswap error handling
Date: Wed, 24 Sep 2025 15:48:18 +0800
Message-ID: <20250924074818.230010-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924074818.230010-1-jim.shu@sifive.com>
References: <20250924074818.230010-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62c.google.com
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

Follow the RISC-V CFI v1.0 spec [1] to fix the exception type
when ssamoswap is disabled by xSSE.

[1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/helper.h                         |  5 ++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  8 +++
 target/riscv/op_helper.c                      | 49 +++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f712b1c368..c82bacdc39 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1284,3 +1284,8 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+/* CFI (zicfiss) helpers */
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(ssamoswap_disabled, void, env)
+#endif
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 45686af4d6..f4a1c12ca0 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -91,7 +91,11 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     }
 
     if (!ctx->bcfi_enabled) {
+#ifndef CONFIG_USER_ONLY
+        gen_helper_ssamoswap_disabled(tcg_env);
+#else
         return false;
+#endif
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
@@ -116,7 +120,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     }
 
     if (!ctx->bcfi_enabled) {
+#ifndef CONFIG_USER_ONLY
+        gen_helper_ssamoswap_disabled(tcg_env);
+#else
         return false;
+#endif
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 110292e84d..8382aa94cb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -717,4 +717,53 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
 
+void helper_ssamoswap_disabled(CPURISCVState *env)
+{
+    int exception = RISCV_EXCP_ILLEGAL_INST;
+
+    /*
+     * Here we follow the RISC-V CFI spec [1] to implement the exception type
+     * of ssamoswap* instruction.
+     *
+     * [1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location
+     *
+     * Note: We have already checked some conditions in trans_* functions:
+     *   1. The effective priv mode is not M-mode.
+     *   2. The xSSE specific to the effictive priv mode is disabled.
+     */
+    if (!get_field(env->menvcfg, MENVCFG_SSE)) {
+        /*
+         * Disabled M-mode SSE always trigger illegal instruction when
+         * current priv mode is not M-mode.
+         */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+    if (!riscv_has_ext(env, RVS)) {
+        /* S-mode is not implemented */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    } else if (env->virt_enabled) {
+        /*
+         * VU/VS-mode with disabled xSSE will trigger the virtual instruction
+         * exception.
+         */
+        exception = RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        goto done;
+    } else {
+        /*
+         * U-mode with disabled S-mode SSE will trigger the illegal instruction
+         * exception.
+         *
+         * Note: S-mode is already handled in the disabled M-mode SSE case.
+         */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+done:
+    riscv_raise_exception(env, exception, GETPC());
+}
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.43.0


