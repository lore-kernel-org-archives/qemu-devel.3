Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D85DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4lv-0007oE-U4; Mon, 01 Sep 2025 09:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ut4kc-0006ri-Ko
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:39:19 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ut4kL-0002x7-1M
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:38:59 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4c6fee41c9so3236016a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756733932; x=1757338732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4c1UhapPXWlX06VAlECXnxjVuo5dfuXxQHbFBsnDUU=;
 b=Nk2ql3Eze69a1NZiV0cWFYnWJtmL3D2tMzgPwgphp+1i4y7O/bpKzvXK+DmVfstF87
 aWbr3qknf2RtRRLJ3HW+3/D/LcT5qsXTCF1zuT9JiP8ClMui48oQEyNO95dG+3AVo1nJ
 HEEPB0ZYAeSw+CcRtqpAU7r0X9QIPnIt4xA+h/nocJ2jWmTp7dpMJJ+rpqtHdcr0ILve
 nff4d0uNWoboqqwySv9ueIOSeIacowpUA2t0cybZJpyDffvLVnQ1E040tR1st5eTEUpB
 zfHG0YQMu5W8L/s4ycU6zvrhgK/48dBLCaMy0FyL/U2z5S26Isk3MDwQeUb3DQ7zbIqs
 B5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733932; x=1757338732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4c1UhapPXWlX06VAlECXnxjVuo5dfuXxQHbFBsnDUU=;
 b=dV/KVYS0U0mSClyU+ogUWhE+r+oGWzwvSiukikC73LQc1FwGjpddcCBbdcnVol6Kav
 EAgmutNnNkv6JPA7i4UnCG2qoQAGq4o2QZbIgZetw/RJ8i/CwcC27qUa7r4HUhc/XsrY
 CzaMFG3GvNl6arW8w1u06A+BjvNDqc00aEzS5W+bqJxi1Pi0fuM820WYz1Qdq82mh4+f
 wDzYGKG3vC3d1my8fhO5sutcfreJPy63UMIdn7RUzd9yHKDt+bYf/wq3gD/pnqGduj5f
 kDMGJT25IzwZ7VgRiJ+pII6nWALW0UtziadS6lHTZBDFHmEsC3OZNLjEXfrHMNuLboOd
 Uebg==
X-Gm-Message-State: AOJu0Yyd9NeSjdxrGTuBYo7oDu0mTlVubWpoQwtPs+G5Oxm3pw5fW9Vk
 fAveSkX7wB4ZbEums6E9XIpQKv7MufmkBUVpwjtQSjwwBJ/seUY4fbCg3xj56/2LRZvh5VkMwvu
 bKM3wRyX9ZCPquMTLd78WBiimGBlp2zH3fgLyg3oC//q1i1QWTwjGRIpqv4ULS+5xGLImZn+eyj
 LhfBGLOSxwPi+P0aNmL1D8rnGHhu2pQY2S8QavZoVWxw==
X-Gm-Gg: ASbGncuCKNsmZ1exDfrLYSwHEC4IQR4t242isrqL3EC7HpZWyrqHxpk14Jhth959jNm
 OwfPQuMlm3aG47yXixBxidRdxmpK1CnT8LnvOG8yPEau4m88zP+TxCCwmJIBlmNVjnO7mA29n+s
 Uxmzs5PEP1IyzKPbxvH5+wLUwUhvyPh9K9hYS0t8CEKApwqVCxzkzz+isa/o5tmNXxKy6qkn/xN
 Qb/ZR4hZKo2sigjtKPZpuFegpOzAqfD996F2o7HALbeMD8gQ26WS3SXV0CRmuTAr/Sy+W99QT7R
 Ci0nWj2dhxwcfgiXJqcoQPT5PgJ2mYumxhlsi2KT6MNVfVirYPo6uhdYVdMByGGQjRYyD2iEDt1
 Ghr+XZU4FGf4FkmgnqvUcXmxOaMIub1HYSRRbGu9ioBG7adNoC0gqC1DaGoo4tg5URPI=
X-Google-Smtp-Source: AGHT+IEnF/RAKZaQrhKYf5FuOuJgMlB66iX/JmOciEXFcpKZoO3FLRNf3WXijjwNXlBqj7QSzAAwkA==
X-Received: by 2002:a17:902:ce02:b0:246:a42b:a31d with SMTP id
 d9443c01a7336-24944ad758dmr99381865ad.44.1756733932302; 
 Mon, 01 Sep 2025 06:38:52 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da3bbfsm103106375ad.70.2025.09.01.06.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:38:51 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 2/3] target/riscv: rvv: Add Zvqdotq support
Date: Mon,  1 Sep 2025 21:38:14 +0800
Message-ID: <20250901133815.1693077-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901133815.1693077-1-max.chou@sifive.com>
References: <20250901133815.1693077-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52b.google.com
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

Support instructions for vector dot-product extension (Zvqdotq)
- vqdot.[vv,vx]
- vqdotu.[vv,vx]
- vqdotsu.[vv,vx]
- vqdotus.vx

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 ++++++++++++++++++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 63 +++++++++++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f712b1c368e..80274f1dad6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1284,3 +1284,13 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+/* Vector dot-product functions */
+DEF_HELPER_6(vqdot_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqdotu_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqdotsu_vv, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vqdot_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotu_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotsu_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotus_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9b..50a61566670 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1066,3 +1066,12 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
 amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
 amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
+
+# *** Zvqdotq Vector Dot-Product Extension ***
+vqdot_vv    101100 . ..... ..... 010 ..... 1010111 @r_vm
+vqdot_vx    101100 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotu_vv   101000 . ..... ..... 010 ..... 1010111 @r_vm
+vqdotu_vx   101000 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotsu_vv  101010 . ..... ..... 010 ..... 1010111 @r_vm
+vqdotsu_vx  101010 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotus_vx  101110 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvzvqdotq.c.inc b/target/riscv/insn_trans/trans_rvzvqdotq.c.inc
new file mode 100644
index 00000000000..b203c826a2e
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzvqdotq.c.inc
@@ -0,0 +1,61 @@
+/*
+ * RISC-V translation routines for the Zvqdotq vector dot-product extension
+ *
+ * Copyright (c) 2025 Max Chou, max.chou@sifive.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool vext_zvqdotq_base_check(DisasContext *s)
+{
+    return s->cfg_ptr->ext_zvqdotq && s->sew == MO_32;
+}
+
+static bool vext_vqdotq_opivv_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_zvqdotq_base_check(s) && opivv_check(s, a);
+}
+
+#define GEN_VQDOTQ_OPIVV_TRANS(NAME, CHECK)              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return opivv_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                           gen_helper_##NAME, s);        \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_VQDOTQ_OPIVV_TRANS(vqdot_vv, vext_vqdotq_opivv_check)
+GEN_VQDOTQ_OPIVV_TRANS(vqdotu_vv, vext_vqdotq_opivv_check)
+GEN_VQDOTQ_OPIVV_TRANS(vqdotsu_vv, vext_vqdotq_opivv_check)
+
+static bool vext_vqdotq_opivx_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_zvqdotq_base_check(s) && opivx_check(s, a);
+}
+
+#define GEN_VQDOTQ_OPIVX_TRANS(NAME, CHECK)              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                           gen_helper_##NAME, s);        \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_VQDOTQ_OPIVX_TRANS(vqdot_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotu_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotsu_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotus_vx, vext_vqdotq_opivx_check)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2a..6f43ed1ffdb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1190,6 +1190,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
 #include "insn_trans/trans_rvvk.c.inc"
+#include "insn_trans/trans_rvzvqdotq.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7c67d67a13f..961b62add3f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -921,6 +921,10 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb, ste_b_host)
 #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
 #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
 #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
+#define QOP_SUS_B int32_t, uint8_t, int8_t, uint32_t, int32_t
+#define QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, uint32_t
+#define QOP_UUU_B uint32_t, uint8_t, uint8_t, uint32_t, uint32_t
 #define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
 #define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
 #define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
@@ -5473,3 +5477,62 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+
+/* Vector dot-product instructions. */
+
+#define OPMVV_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)          \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)            \
+{                                                                       \
+    int idx;                                                            \
+    T1 r1;                                                              \
+    T2 r2;                                                              \
+    TX1 *r1_buf = (TX1 *)vs1 + HD(i);                                   \
+    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
+    TD acc = *((TD *)vd + HD(i));                                       \
+    int64_t partial_sum = 0;                                            \
+                                                                        \
+    for (idx = 0; idx < 4; ++idx) {                                     \
+        r1 = *((T1 *)r1_buf + HS1(idx));                                \
+        r2 = *((T2 *)r2_buf + HS2(idx));                                \
+        partial_sum += (r1 * r2);                                       \
+    }                                                                   \
+    *((TD *)vd + HD(i)) = (acc + partial_sum) & MAKE_64BIT_MASK(0, 32); \
+}
+
+RVVCALL(OPMVV_VQDOTQ, vqdot_vv, QOP_SSS_B, H4, H1, H1)
+RVVCALL(OPMVV_VQDOTQ, vqdotu_vv, QOP_UUU_B, H4, H1, H1)
+RVVCALL(OPMVV_VQDOTQ, vqdotsu_vv, QOP_SUS_B, H4, H1, H1)
+
+GEN_VEXT_VV(vqdot_vv, 4)
+GEN_VEXT_VV(vqdotu_vv, 4)
+GEN_VEXT_VV(vqdotsu_vv, 4)
+
+#define OPMVX_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)       \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)       \
+{                                                                       \
+    int idx;                                                            \
+    T1 r1;                                                              \
+    T2 r2;                                                              \
+    TX1 *r1_buf = (TX1 *)&s1;                                           \
+    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
+    TD acc = *((TD *)vd + HD(i));                                       \
+    int64_t partial_sum = 0;                                            \
+                                                                        \
+    for (idx = 0; idx < 4; ++idx) {                                     \
+        r1 = *((T1 *)r1_buf + HS1(idx));                                \
+        r2 = *((T2 *)r2_buf + HS2(idx));                                \
+        partial_sum += (r1 * r2);                                       \
+    }                                                                   \
+    *((TD *)vd + HD(i)) = (acc + partial_sum) & MAKE_64BIT_MASK(0, 32); \
+}
+
+RVVCALL(OPMVX_VQDOTQ, vqdot_vx, QOP_SSS_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotu_vx, QOP_UUU_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotsu_vx, QOP_SUS_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotus_vx, QOP_SSU_B, H4, H1, H1)
+
+GEN_VEXT_VX(vqdot_vx, 4)
+GEN_VEXT_VX(vqdotu_vx, 4)
+GEN_VEXT_VX(vqdotsu_vx, 4)
+GEN_VEXT_VX(vqdotus_vx, 4)
-- 
2.43.0


