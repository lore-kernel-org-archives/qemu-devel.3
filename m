Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AF5C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 07:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRnAj-0003cZ-A3; Wed, 18 Jun 2025 03:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1uRnAh-0003cM-7e
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:25:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1uRnAd-0002TL-6F
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:25:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so247130f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750231516; x=1750836316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Sm0cmSYbg/JJyBuaEjGFwDjbHuaiEgtTZwZeawIrhw=;
 b=DaYC/pKJg8GmMFVSPhsJJ3NWcyv4F/2np9pzGiHGsCoNVcAJulmqkzx2OAKTblHbky
 5BrHKtpejnpOR9z3jBpRlqJ+X5Aatbru3lfgQVEpHpiaXT/06SwSfejWMFqtEH33PXZg
 FAplzcYYeBVvWBGGx8iXOGOtoHKv55zBSdXrUBCqocbnpH+Nzx1I6qiThKep+8X5dnHF
 UUxYR7DuOgGf3Hipf49duq7SN6Ko1+XdUIGxwoEsN/ALOyUyjdZIMw6DjJD8pHClZ8CI
 IuBHkzbT4Jhe4BNTI187uieK9TRdd5KAaie2ayJiXmKU6AWXrM2rdVoe0m+TN2Pm6O+Q
 dR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750231516; x=1750836316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Sm0cmSYbg/JJyBuaEjGFwDjbHuaiEgtTZwZeawIrhw=;
 b=Pg2WMEFZMObFOfUbI0OQGoDyylC1p7XjWU/Z1etdH79lLU+ZAtxt9wgvmfh9RuMIfu
 smaJ3AcqSnPs8ukM0LOv1j4vRVIR25A4MnzGLqBYkbwx0Oe1jDLYYtwK2gfPqH0k49t7
 tePuv9ToqmsN7SRoTPo2YL0STGtdedL5Z8UHvagxY5WQ3OFF9Md83mz84EaGacuvAWVP
 o6vHrEs0yHtKH2lbB+M1PzobcqEfFMcrnyTK8Z9KHhktnuootwxtkBV9QaHaLiuL1jDC
 FiuXRyQhhymArw/dhyuoCl++0GxMM/DvnWaaQ/E4krqov4viLLclgFv7qP/E1bB79S7i
 zGrg==
X-Gm-Message-State: AOJu0Yz0jHZuIb1XuG2zznIKVN5RIC5fPh1xaEs2bOIFObZYBgoUXATM
 1EKNm6i68hB4tF5MX4iGZXkFi+sT/mRh1b8NTS9jUDUkVD8mkjbkTonCal8eR94MxC4wFDTAH7l
 Py5UOWOGh8g==
X-Gm-Gg: ASbGnctwSU1D0HiqLPzhx/lumYkrvycpEmD8U2ImcYAWZ2ZERUbPKy4Oof+ESYJaFGb
 iwwkwIUSAUu5fNUgYc8LVto8TQY8NYq8RIyCki56HAM9jOm3BFCWw/Lentzxo7cPb9mXbymWr1E
 P73/uvEXmBSVJrzXTz6a0sOXYHgJ/sBHxzX68BkUXeSUB9hLMrH3T8TTMzx5SAxyDlKTYLkge7E
 Zb/MOf+P4e33LwWId4AD0KT9h1bca9c28UqoxA2rdyGWM4+hd1FoXzPdmpXHVYmK6Iyng6liEVB
 W0LLYm4X9sUQTBck1IE5Ij3jyNMSxlWhfIVHWfQdGQ/x7Rdvqj7nHl87jRD+kg==
X-Google-Smtp-Source: AGHT+IGYm0rxg7L1Nx+sJXY53OBl6vCK+5oXYAFH8UZMMe6iQC/BGGk9XdyxtAe0VH7WJq0RX7/KdQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3a58e2656d0mr1203358f8f.23.1750231515699; 
 Wed, 18 Jun 2025 00:25:15 -0700 (PDT)
Received: from localhost ([91.140.111.118])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b2fe1639fadsm8603881a12.11.2025.06.18.00.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:25:14 -0700 (PDT)
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, ajones@ventanamicro.com,
 alistair.francis@wdc.com, philmd@linaro.org,
 Vasilis Liaskovitis <vliaskovitis@suse.com>
Subject: [PATCH] target/riscv: Add a property to set vill bit on reserved
 usage of vsetvli instruction
Date: Wed, 18 Jun 2025 09:25:00 +0200
Message-ID: <20250618072500.8469-1-vliaskovitis@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=vliaskovitis@suse.com; helo=mail-wr1-x444.google.com
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

Usage of vsetvli instruction is reserved if VLMAX is changed when vsetvli rs1
and rd arguments are x0.

In this case, if the new property is true, only the vill bit will be set.

See https://github.com/riscv/riscv-isa-manual/blob/main/src/v-st-ext.adoc#avl-encoding
According to the spec, the above use cases are reserved, and
"Implementations may set vill in either case."

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2422
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 target/riscv/cpu.c                      |  1 +
 target/riscv/cpu_cfg_fields.h.inc       |  1 +
 target/riscv/helper.h                   |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
 target/riscv/vector_helper.c            | 22 ++++++++++++----------
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..1c29ed3b2b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2595,6 +2595,7 @@ static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false),
     DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
     DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
+    DEFINE_PROP_BOOL("rvv_vsetvl_x0_vill", RISCVCPU, cfg.rvv_vsetvl_x0_vill, false),
 
     /*
      * write_misa() is marked as experimental for now so mark
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59f134a419..9c78a797cf 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -114,6 +114,7 @@ BOOL_FIELD(ext_supm)
 BOOL_FIELD(rvv_ta_all_1s)
 BOOL_FIELD(rvv_ma_all_1s)
 BOOL_FIELD(rvv_vl_half_avl)
+BOOL_FIELD(rvv_vsetvl_x0_vill)
 /* Named features  */
 BOOL_FIELD(ext_svade)
 BOOL_FIELD(ext_zic64b)
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 85d73e492d..f712b1c368 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -159,7 +159,7 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
 #endif
 
 /* Vector functions */
-DEF_HELPER_3(vsetvl, tl, env, tl, tl)
+DEF_HELPER_4(vsetvl, tl, env, tl, tl, tl)
 DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2b6077ac06..87071c5d62 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -202,7 +202,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
         s1 = get_gpr(s, rs1, EXT_ZERO);
     }
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2);
+    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl((int) (rd == 0 && rs1 == 0)));
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
 
@@ -222,7 +222,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 
     dst = dest_gpr(s, rd);
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2);
+    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
     gen_update_pc(s, s->cur_insn_len);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5dc1c10012..2545d73cc1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -35,7 +35,7 @@
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
-                            target_ulong s2)
+                            target_ulong s2, target_ulong x0)
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
@@ -64,15 +64,6 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         }
     }
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
-        return 0;
-    }
-
     /* lmul encoded as in DisasContext::lmul */
     lmul = sextract32(FIELD_EX64(s2, VTYPE, VLMUL), 0, 3);
     vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
@@ -83,6 +74,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     } else {
         vl = vlmax;
     }
+
+    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0) ||
+        (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl))) {
+        /* only set vill bit. */
+        env->vill = 1;
+        env->vtype = 0;
+        env->vl = 0;
+        env->vstart = 0;
+        return 0;
+    }
+
     env->vl = vl;
     env->vtype = s2;
     env->vstart = 0;
-- 
2.46.0


