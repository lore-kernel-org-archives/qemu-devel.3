Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA4DCD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtga-0006FJ-Ju; Sat, 09 May 2026 22:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgX-0006Df-OQ
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:25 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgU-00031n-6i
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:24 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso2805913a34.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379260; x=1778984060; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EJ2oE7Ibi/Ra+NyqvCfuwYfcQJOMAuOBJKcb/LSErpg=;
 b=U4TI8txVlR6yB5CsZ5NY6p6JVQfpLR/hIHu8GmWvkh44kDHuRmDniG8jtzZ/Z/8N1f
 LNyZ6ujn2AzHvvVDKDT7Mr1qAmw34h5TgCeJlMf9ImKSKLV1ACptw1PqZJ0lZGQ+QC3k
 ZGa2FJzrbiPZcKKB/FcFmfkefM73ZLA3ElsrjlKR/sD15R4xRGgUynokyu2bU2VnlFsR
 hWxbRAySbntJYoiBYnBKUD3XsASG3BrnX6w1ehz+R+f41d7o2y5atNbppYMdGKTxTePo
 gM87eI4sB5c+kIHvw4h7t4NZ1yBexPPv2vzK38PgzrYQIOzYdxOFezP+8lPUrzyqxd6U
 yEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379260; x=1778984060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EJ2oE7Ibi/Ra+NyqvCfuwYfcQJOMAuOBJKcb/LSErpg=;
 b=hyDKusILK4r1GOQdwRQiMG6h1ArhTXaka5f4D2RHha62swXFzarrXYuiuM5V7J4M/2
 ol27RWdPdzbT3OeBcqnkUzmc1qwxSGXKD4npC409s3aICixi06rLQEU1f6ct8Y9ibAAy
 hLNJBSZmVbxcQYBjV9o2NpORac16Xi1urbok+UdW7qaiGFWrqAotc9BUIvY241wUMgcf
 7T18XE5HQv7fpxqe10gSfBa80cLj8NcOMv4mNJkf2W253a7MI7cRTdszdiWhEW6lDtYk
 cx0yqoSEpKVZtXAppOD7n8r/mmZ3wmw/OAj8mhzB0K8a1T4LDj1MrVCtbLIourN3juDV
 F+jA==
X-Gm-Message-State: AOJu0YyI8rJF30ygLWRKEKSUYz+J3h/JE34LudJXcMrCD0fBY8xJJxfl
 sk4AiPEf4TWYDWrDYcix7sx9RA9bKoHso3sGfj4TuF+FWqtWxIRevRdyNzZjPud0
X-Gm-Gg: Acq92OElqRVHLkq8LiO75MxLB7qazqcr4zaB5LasX1/+OWkxbzGmSewyB2PCm+C67P9
 AfeLOOG+Y2BNKyKw0Mpx0XgRQ0HPry0FpTEfCwG356aPkxPmM5aWD/gi67p3vwiTPqa21MTefUa
 xeJHui1/GS0Ad7tdPbOzqkK4e9mSnih88xAXtXL+gw4SPyiFIFXDH+XShM3KwZsjv4yN9nyrIll
 VOerNB3x6OijxiJmMePNbdA9N/07cmMFb4AsmWgS9BUWTaGBMMY9ZThhbNiIvTpHo/b0pyt16z5
 LodhVx+AqonkuYyb/7S0gz/y2QkdB7lPbZtzLgbAFQPSesjTvw6C/7sF4CDjgybZcUj/6tKqITV
 InuAcZJMu0z0Pxd//AgcGqvXkDms/nI64xcfmHoSsn1n0ucNhR96GBzHhx1LsgGEEFLQfOugX3p
 zCJFdzb9tu7M2Rz9izqfidip8drwhNMtRPeH5a1qdj7cBbDY8ISBh3yPXyGa4/7Lc56h7UWxm2J
 4JiTqczmp2RaIPCgTahBWpGLuwgMdiUcI56x4S9e+tdaJG+D14NiTGxzjdQgOSlVZXjOxclEA7F
 GkEjvNTu2Ifu+A==
X-Received: by 2002:a05:6820:1513:b0:696:70f0:7ade with SMTP id
 006d021491bc7-69998c9fbfcmr10552843eaf.8.1778379260476; 
 Sat, 09 May 2026 19:14:20 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:48 -0600
Subject: [PATCH v4 25/32] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-25-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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
---
 target/mips/tcg/octeon.decode      | 17 +++++++++
 target/mips/tcg/octeon_translate.c | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 54ca92a654..6f4102044f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -59,6 +59,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
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
 ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 7d45fc3d29..bc06d25e26 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -181,6 +181,68 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_la_common(DisasContext *ctx, int base, int add_reg,
+                            int rd, int64_t imm, MemOp mop)
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
+static bool trans_law_common(DisasContext *ctx, int base, int add_reg, int rd,
+                             int64_t imm, MemOp mop)
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
+static bool do_lai(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_laa(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_la_common(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
+static bool do_las(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_law(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_law_common(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
 static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
@@ -293,6 +355,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(LAI,  do_lai, 1, MO_SL);
+TRANS(LAID, do_lai, 1, MO_UQ);
+TRANS(LAD,  do_lai, -1, MO_SL);
+TRANS(LADD, do_lai, -1, MO_UQ);
+TRANS(LAA,  do_laa, MO_SL);
+TRANS(LAAD, do_laa, MO_UQ);
+TRANS(LAS,  do_las, -1, MO_SL);
+TRANS(LASD, do_las, -1, MO_UQ);
+TRANS(LAC,  do_las, 0, MO_SL);
+TRANS(LACD, do_las, 0, MO_UQ);
+TRANS(LAW,  do_law, MO_SL);
+TRANS(LAWD, do_law, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


