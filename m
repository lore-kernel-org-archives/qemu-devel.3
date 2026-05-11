Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1728BCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI2-00056B-Cx; Mon, 11 May 2026 14:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHl-0004r0-Dw
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:22 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHi-0002uh-9o
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:19 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4527294a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523796; x=1779128596; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FlakYH7kx2XQcE7j7V6CqlqT/aTTxeKWnMexihxfdas=;
 b=S9s6Fw+2Yp7r00FjlfrLROtG2ob51GEhWlhwWu015eiv0Vxi1IfCzgdafJlmkV3Dna
 c8sdJdXsJtRpSKQpBuJCrbljm2XWM9hi5tGj0YIrg8lf/aQqGQZgoi+Q1d+IdopkwYx2
 5WsJ3ADEdNHLwYWQVnOKgmfwuVhqwiUV+mQn5t1tEbWMNcakv9rw2qnhq4VGujl8Eajl
 HEJyWJNK+ekIrlIU5QrTMS8d9d25wsteFj0dIRkEfLBk8v1RdnBGt1T3WuJpT2ZxEhSd
 FrFBzXoAF1nO8q+0/SwTGgmjlw9KuVrhxpAU2vB0q2msDQ1sfR5A/X8wzyxkE4hfu5XX
 K4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523796; x=1779128596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FlakYH7kx2XQcE7j7V6CqlqT/aTTxeKWnMexihxfdas=;
 b=ARebKZXz8eRdYYJ+R5kuWrC4KUzlgSupqKn8+2Cc/jO3jMHvA6LZRMqLV/RjvmSaqm
 tz5QUua7ykvhGrQOtIpDyBL89oBtyNlK5YqH00/a6qCSLo4de64C/H2QaMfSuNPY3rHj
 cpCyCKZZQUnbb7fMJkN5qf+siLimQbMerubytIltL8aXq2mWY7vBpG3nwBl/82vPqNHE
 F21gdxoxuKTo08JYtCnhnqWhCZAgLkXFSEUmDDW+XyK71VG5rPh87pvE0hWmonxjxr+W
 WPPYy8l3F17F8RCmP6B0W0BbhTzBFlUUkNV+/tHiy1JsERUc2+K+mJOB/ELmTzw5U6iK
 g8bQ==
X-Gm-Message-State: AOJu0Yw1ihv2Ph7dR9mCpythrVP9Jg6HamDPBGfddqO8iKrYhuOvpru8
 KEbuh8Oo5ZO2PrCRQv4LCZAWiwfg5KnOyZ5NrrEBSHogWViQsmxnZoqo
X-Gm-Gg: Acq92OFmW82n403BRsi8zZIxcJawnwd4yI8+WZtyPj+sjY0XcyE0ZQolAih6bZd2vuo
 gC/rJd/FsdbFT6b2MjR4f3NpB8LNVLdRA0cQcjPEH0SwR1E5J/pX/Y1rACepLgSS3gNv92iRW35
 KL5MtgLpjcX3m4pGEMdM2A6qDSWxRM6q7fRtsFO9EJA/6Rmib6L61tBhA9qgqyEf9mFBNU7/OUT
 IJSeq0Q48c5Ee5eIJ5KhyPoL/5vlBl7NBdAhVkEGcselb9CmAEV4gdrtJd45QXgWPSL3vV9z0oE
 NDdb2f/GpuC1CJ5icmnsHAwOoWZQU2zauH0r2hu66Y+QDjhkJti8HQ1DyDYO8MKkxYSKF6kZBSq
 CZW29cvj7jvGVYAt+Zl+OzIHQS2Tw4rmA4+q1bAfFF9Ztt91PFCoCjRGXO763/FqdUY8WGCiWmn
 O9jglfwjG/yCLxK0N9KfL7FdvS2XMwhoOc5mHYfbO3mpOzS/Ka8dg5x/rASAacdKKn/QE6cE8Rn
 KEkyA+RCPa8zBIh7qEvT3BRPv+4/AeFu9Y62n0fJ6Lvxsfom09qdSTooPhyvCI59nj2
X-Received: by 2002:a05:6830:4388:b0:7d7:cb13:3fef with SMTP id
 46e09a7af769-7e382139708mr6839131a34.20.1778523795958; 
 Mon, 11 May 2026 11:23:15 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:57 -0600
Subject: [PATCH v6 26/35] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-26-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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

Implement the Octeon LA* read-modify-write atomic instruction family:
LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.

These operations are architecturally distinct from SAA/SAAD and are used
by existing Octeon user-mode code for atomic counters, bit operations,
and exchange-style updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Keep LA* atomics naturally aligned per Octeon L2 transaction
    semantics.
  - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
    Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Drop redundant TARGET_LONG_BITS guards from doubleword atomic paths.
    (suggested by Richard Henderson)
  - Group LA* translator wrappers by argument shape instead of adding one
    wrapper per instruction.  (suggested by Richard Henderson)

Changes v3 -> v4:
  - Use i64 atomic helpers for both word and doubleword paths and select
    word sign-extension through MO_SL.  (suggested by Richard Henderson)

Changes v5 -> v6:
  - Rename the shared translator helpers to distinguish fetch-add and
    exchange operations.
---
 target/mips/tcg/octeon.decode      | 17 +++++++++
 target/mips/tcg/octeon_translate.c | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5edcd95884..801d35d680 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -64,6 +64,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&la          base rd
+&laa         base add rd
+@la          ...... base:5 ..... rd:5 ........... &la
+@laa         ...... base:5 add:5 rd:5 ........... &laa
+LAI          011100 ..... 00000 ..... 00010 011111 @la
+LAID         011100 ..... 00000 ..... 00011 011111 @la
+LAD          011100 ..... 00000 ..... 00110 011111 @la
+LADD         011100 ..... 00000 ..... 00111 011111 @la
+LAA          011100 ..... ..... ..... 10010 011111 @laa
+LAAD         011100 ..... ..... ..... 10011 011111 @laa
+LAS          011100 ..... 00000 ..... 01010 011111 @la
+LASD         011100 ..... 00000 ..... 01011 011111 @la
+LAC          011100 ..... 00000 ..... 01110 011111 @la
+LACD         011100 ..... 00000 ..... 01111 011111 @la
+LAW          011100 ..... ..... ..... 10110 011111 @laa
+LAWD         011100 ..... ..... ..... 10111 011111 @laa
+
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
 ZCB          011100 base:5 00000 00000 11101 011111 &zcb  # ZCBT
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b41bc1f81e..07674f0d44 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -190,6 +190,68 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_la_fetch_add(DisasContext *ctx, int base, int add_reg,
+                               int rd, int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool trans_la_xchg(DisasContext *ctx, int base, int add_reg, int rd,
+                          int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool do_la_imm_add(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_la_fetch_add(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_la_reg_add(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_la_fetch_add(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
+static bool do_la_imm_xchg(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_la_xchg(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_la_reg_xchg(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_la_xchg(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
 static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
@@ -313,6 +375,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(LAI,  do_la_imm_add, 1, MO_SL);
+TRANS(LAID, do_la_imm_add, 1, MO_UQ);
+TRANS(LAD,  do_la_imm_add, -1, MO_SL);
+TRANS(LADD, do_la_imm_add, -1, MO_UQ);
+TRANS(LAA,  do_la_reg_add, MO_SL);
+TRANS(LAAD, do_la_reg_add, MO_UQ);
+TRANS(LAS,  do_la_imm_xchg, -1, MO_SL);
+TRANS(LASD, do_la_imm_xchg, -1, MO_UQ);
+TRANS(LAC,  do_la_imm_xchg, 0, MO_SL);
+TRANS(LACD, do_la_imm_xchg, 0, MO_UQ);
+TRANS(LAW,  do_la_reg_xchg, MO_SL);
+TRANS(LAWD, do_la_reg_xchg, MO_UQ);
 TRANS(QMAC,  trans_qmac, gen_helper_octeon_qmac);
 TRANS(QMACS, trans_qmac, gen_helper_octeon_qmacs);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


