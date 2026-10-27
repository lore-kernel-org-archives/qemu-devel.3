Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB430606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kfIH8blG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLafo-0001qF-AJ; Tue, 27 Oct 2026 02:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafk-0001pn-Vn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:37 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafg-00088R-Ur
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:36 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1165806a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082511; x=1793687311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NT21BB/haHXC5lugxf0rFfJoiPO5jD8MU/i7Y/9GCfo=;
 b=kfIH8blGnLk+YfG4dnQFEjs1KBwZoe5Db46v6OujdBpkX1RmeMcPwb4di4gx7ZpDZD
 Tb3nBJNuj1aBa8DkKy8fycBX4TXYrsJU0RNAxwkNdEu4WQ2QVBANx77joqYf/AHRDnUS
 Kt/6ODeI+9NiUEONt7gLHAI67SALSl3pF90VXT1f/cw7ZWZnIZ2V6BhFa1nPx3d1BP2y
 jPfVccXLj+SQKJqdVTjwRbv2j6WLqRH71Ne3imm+qmx+pJRUHAAxkt3uIhRLzce+S8V7
 EcsFRFJ9/mBJ/LgpyUujghvOq4ppE3w9oQlBo41nYkBFkDk3GcEENZal54cp1HsXmCwz
 /9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082511; x=1793687311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NT21BB/haHXC5lugxf0rFfJoiPO5jD8MU/i7Y/9GCfo=;
 b=LKOg6MnzpE7106ngtw/5AfAOYCBR85s6WjE70Rrzc4EoqbOL9Y1RGM/uTS2QOsF3pi
 OG+eY+VlJeivMmadgPpckFveiCsVBGUuqE+eK/BE538NkmrysZ6+5CTNVvBgkzB3WPIh
 +dBGcK4R0cRce/mW9hXXnTLJbIDECiUtj7kmW/h/GZWMUn99l8gCJDeYGDIgL6YdJ6OE
 Fn8zBXFks4Vmd6wQZMl2DXv4m3HcpbnaGCvXnBEJKoLRlBQQ5mWgPEX98t3Mp3/Vmr30
 5UOmIsty1PfXlXJUHXl1eUqb9fuxVJOyI3IrckYNmKIE4cRyiux5oM/3Cu5b3mvVpQFW
 3lzw==
X-Gm-Message-State: AFq9FYL/IKsQCA3uCt4ZGwdUJN9UyU8Zg8MRPtDuXJNDdvs47KfYKxmj
 feD3sqZGHQJDSDfFzre7E05lfcIIuIaZvy+MM64gRwvpE53GLR6qId3KwYX+0A==
X-Gm-Gg: AYBFou2zA5UQI/QuB9ohl3wtSCqy+FzfBsfBt2UhlzsFT2KUoibZu09gVA4xHNg5djr
 J/xGqQb9DPK9rv72aYlkAjVaCBtO/HztOFAlKLI24CH2j1bDr8HEWM4dGAX4S2a6YEuACtVGbWD
 GlT2yAbecuqLeoK0T8jmGFKlz81eCXje20N0bGap6kJ2A6D0xxCfXuvFKf+5MepjXO7rzdP3V5O
 EYxycqdQLnZJuaTEbHQH3m1aZw2ZUfHSmAJBDVkHMJ/zwI1CpeWpN3okzmdEmccDYOvpNSjlqPV
 oT6Xz4zqSiAg8upo8NUXQ494uYTkkQflf/Ebou8jwnkKAj7zty6kImMly3lc/Z37Q5eaoYscima
 uJdaBFbYYCLw3s+YfksCONTUIXgLe95jFFDUQSMdVK8EXWWW2XiavZKbffNe1qsRrPdHpczfQrt
 6BYj8esm+IyDYiM53mJ0dPMdStOBQ6VRJCrPgxk/eA96Xso12cKNcoUMes/SwIf0L+ZfirQXOT8
 7nMN7tsV9G5+iW1/k7+kr9cBocOEecwRoIZj0gl19n2vE4du6OokD2Flmd7YBiSleXY2wPILI8=
X-Received: by 2002:a17:90a:e18d:b0:3a7:9045:fe29 with SMTP id
 98e67ed59e1d1-3ade9b2cf0fmr6978937a91.4.1793082511106; 
 Mon, 26 Oct 2026 23:28:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zhibo Hong <hongzhibo@bytedance.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>,
 Mingliang Liu <liumingliang.dev@bytedance.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/29] target/riscv: Add support for the Zvabd extension
Date: Tue, 27 Oct 2026 16:27:40 +1000
Message-ID: <20261027062808.1995205-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhibo Hong <hongzhibo@bytedance.com>

The draft Zvabd extension version 0.9 provides vector integer
absolute-difference operations for image, video, and other
data-processing workloads. It introduces eight new instructions:

  - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
    8 through ELEN, with SEW 64 requiring Zve64x.
  - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
    and 16 and accumulate into a double-width destination.

This patch implements the extension, including instruction decoding,
TCG translation, and helper functions. This implementation targets
version 0.9, whose instruction encodings differ from version 0.7.

The specification is under review at:
https://github.com/riscv/riscv-isa-manual/pull/3279

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Zhibo Hong <hongzhibo@bytedance.com>
Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Tested-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20261015134337.3354723-2-liumingliang.dev@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                       | 26 ++++++++++
 target/riscv/cpu_cfg_fields.h.inc           |  1 +
 target/riscv/insn32.decode                  | 10 ++++
 disas/riscv.c                               |  8 +++
 target/riscv/cpu.c                          |  1 +
 target/riscv/tcg/tcg-cpu.c                  |  6 +++
 target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++++++++
 disas/riscv-op.c.inc                        |  8 +++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 45 +++++++++++++++++
 9 files changed, 161 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 372f10497261..1cffcad580c2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1353,6 +1353,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
 
+/* Zvabd Extension */
+DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabdu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabdu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabdu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vabdu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabdu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabdu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+
 /* CFI (zicfiss) helpers */
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(ssamoswap_disabled, void, env)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index bcff8f55f16b..85fc3ad8bb8c 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)
 BOOL_FIELD(ext_zve64f)
 BOOL_FIELD(ext_zve64d)
 BOOL_FIELD(ext_zve64x)
+BOOL_FIELD(ext_zvabd)
 BOOL_FIELD(ext_zvbb)
 BOOL_FIELD(ext_zvbc)
 BOOL_FIELD(ext_zvkb)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 46b00411ff68..795badc8a7d0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1087,3 +1087,13 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
 sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
 sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
 sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
+
+# *** Zvabd Extension ***
+vabd_vv       010101 . ..... ..... 010 ..... 1010111 @r_vm
+vabd_vx       010101 . ..... ..... 110 ..... 1010111 @r_vm
+vabdu_vv      010110 . ..... ..... 010 ..... 1010111 @r_vm
+vabdu_vx      010110 . ..... ..... 110 ..... 1010111 @r_vm
+vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
+vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
+vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
+vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
diff --git a/disas/riscv.c b/disas/riscv.c
index d755172164a3..fd6e0bd61379 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2025,6 +2025,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 48: return &op_vwredsumu_vs;
                 case 49: return &op_vwredsum_vs;
                 case 53: return &op_vwsll_vv;
+                case 61: return &op_vwabda_vv;
+                case 62: return &op_vwabdau_vv;
                 }
                 break;
             case 1:
@@ -2167,6 +2169,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         break;
                     }
                     break;
+                case 21: return &op_vabd_vv;
+                case 22: return &op_vabdu_vv;
                 case 23:
                     if ((inst >> 25) & 1) {
                         return &op_vcompress_vm;
@@ -2352,6 +2356,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 46: return &op_vnclipu_wx;
                 case 47: return &op_vnclip_wx;
                 case 53: return &op_vwsll_vx;
+                case 61: return &op_vwabda_vx;
+                case 62: return &op_vwabdau_vx;
                 }
                 break;
             case 5:
@@ -2428,6 +2434,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         }
                     }
                     break;
+                case 21: return &op_vabd_vx;
+                case 22: return &op_vabdu_vx;
                 case 32: return &op_vdivu_vx;
                 case 33: return &op_vdiv_vx;
                 case 34: return &op_vremu_vx;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae750f85c6c9..916038e8e47f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -222,6 +222,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
     ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
     ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_VERSION_1_13_0, ext_zvabd),
     ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
     ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 80c046361754..1369b7c4ded2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -760,6 +760,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if ((cpu->cfg.ext_zvabd) && !cpu->cfg.ext_zve32x) {
+        error_setg(errp,
+                   "Zvabd extensions require V or Zve* extensions");
+        return;
+    }
+
     if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
         if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_zicntr))) {
             error_setg(errp, "zicntr requires zicsr");
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 0d1e4e09646e..917a48b5106f 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -5911,3 +5911,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+/* Zvabd Extension */
+#define DO_ABD(N, M)  (N > M ? N - M : M - N)
+#define DO_ABDACC(N, M, D) (DO_ABD(N, M) + D)
+
+RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H1, DO_ABD)
+RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_ABD)
+RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)
+RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)
+RVVCALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)
+RVVCALL(OPIVX2, vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)
+RVVCALL(OPIVX2, vabd_vx_w, OP_SSS_W, H4, H4, DO_ABD)
+RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8, H8, DO_ABD)
+RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, DO_ABD)
+RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)
+RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)
+RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)
+RVVCALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)
+RVVCALL(OPIVX2, vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)
+RVVCALL(OPIVX2, vabdu_vx_w, OP_UUU_W, H4, H4, DO_ABD)
+RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D, H8, H8, DO_ABD)
+
+RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_B, H2, H1, H1, DO_ABDACC)
+RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H, H4, H2, H2, DO_ABDACC)
+RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H2, H1, DO_ABDACC)
+RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2, DO_ABDACC)
+RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, DO_ABDACC)
+RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, DO_ABDACC)
+RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABDACC)
+RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)
+
+GEN_VEXT_VV(vabd_vv_b, 1)
+GEN_VEXT_VV(vabd_vv_h, 2)
+GEN_VEXT_VV(vabd_vv_w, 4)
+GEN_VEXT_VV(vabd_vv_d, 8)
+GEN_VEXT_VX(vabd_vx_b, 1)
+GEN_VEXT_VX(vabd_vx_h, 2)
+GEN_VEXT_VX(vabd_vx_w, 4)
+GEN_VEXT_VX(vabd_vx_d, 8)
+GEN_VEXT_VV(vabdu_vv_b, 1)
+GEN_VEXT_VV(vabdu_vv_h, 2)
+GEN_VEXT_VV(vabdu_vv_w, 4)
+GEN_VEXT_VV(vabdu_vv_d, 8)
+GEN_VEXT_VX(vabdu_vx_b, 1)
+GEN_VEXT_VX(vabdu_vx_h, 2)
+GEN_VEXT_VX(vabdu_vx_w, 4)
+GEN_VEXT_VX(vabdu_vx_d, 8)
+
+GEN_VEXT_VV(vwabda_vv_b, 2)
+GEN_VEXT_VV(vwabda_vv_h, 4)
+GEN_VEXT_VX(vwabda_vx_b, 2)
+GEN_VEXT_VX(vwabda_vx_h, 4)
+GEN_VEXT_VV(vwabdau_vv_b, 2)
+GEN_VEXT_VV(vwabdau_vv_h, 4)
+GEN_VEXT_VX(vwabdau_vx_b, 2)
+GEN_VEXT_VX(vwabdau_vx_h, 4)
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 1d334e485772..07b56f5d529d 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -490,6 +490,10 @@ OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
 OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
 OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
@@ -861,6 +865,10 @@ OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
 OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
 OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
 OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vwabda_vv, "vwabda.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwabda_vx, "vwabda.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwabdau_vv, "vwabdau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwabdau_vx, "vwabdau.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index a22e2cae6ce8..14ef961607f4 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
 GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
 GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
 GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
+
+/* Zvabd Extension */
+#define GEN_ABD_CHECK(NAME, CHECK_FN, MAX_SEW)                       \
+static bool NAME(DisasContext *s, arg_rmrr *a)                       \
+{                                                                    \
+    return CHECK_FN(s, a) && s->cfg_ptr->ext_zvabd &&                \
+           s->sew <= MAX_SEW &&                                      \
+           (s->sew != MO_64 || s->cfg_ptr->ext_zve64x);              \
+}
+GEN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)
+GEN_ABD_CHECK(vabd_vx_check, opivx_check, MO_64)
+GEN_ABD_CHECK(vwabd_vv_check, opivv_overwrite_widen_check, MO_16)
+GEN_ABD_CHECK(vwabd_vx_check, opivx_overwrite_widen_check, MO_16)
+
+GEN_OPIVV_TRANS(vabd_vv, vabd_vv_check)
+GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)
+GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)
+GEN_OPIVX_TRANS(vabdu_vx, vabd_vx_check)
+
+#define GEN_ABD_OPIVV_WIDEN_TRANS(NAME, CHECK)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    static gen_helper_gvec_4_ptr * const fns[2] = {                     \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
+    };                                                                  \
+    return s->sew <= MO_16 && do_opivv_widen(s, a, fns[s->sew], CHECK); \
+}
+
+#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (CHECK(s, a)) {                                                  \
+        static gen_helper_opivx * const fns[2] = {                      \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
+        };                                                              \
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm,                \
+                           fns[s->sew], s);                             \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
+GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
+GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
+GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
-- 
2.55.0


