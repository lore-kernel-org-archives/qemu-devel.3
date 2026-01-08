Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E1BD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrmV-00020z-My; Thu, 08 Jan 2026 10:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrln-0001Dz-21
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:52 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrll-0003lS-5q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:50 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso2883525b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885466; x=1768490266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9qRPVM03Rx4n3geGklLvEZ9LglgGb2enjbhLFzxO7c=;
 b=l77va2N1jDY2UnX+qGzEYg+rmhGGXQKYlGSJ62uTAClPIgTloeW6//29ACmMQa3Ur/
 ueW8dYDY85O52zsjGsf6n2x/4Aqau6bMYR1e/YLWJmk9iWZkF4tVGSyJYBPQrQB2LT2Q
 UgsRmc4Q7jNfSRefqXB5uxzQh8j+jYsliSEdgrhrDtft8L1SAPrxjONa5zRopITh/8nm
 Yk6qwMdV4aQ0BS804PlaOsxnBSYVuZSooe/zLlAQsl4wGoAXsRYBYp4923Vj8e9vIyoG
 PP/40RFSKfpym3rcr/GHKLvqkAjaarWQzEeQq8Z5iA5h4qP/wBOF8f7/9ngQMcQfCOaT
 9sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885466; x=1768490266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9qRPVM03Rx4n3geGklLvEZ9LglgGb2enjbhLFzxO7c=;
 b=FLabn2iqgJB2gKJoVAVoJySjpadI6YG9Of/4O2QXl+dxVYW2M8o/KeVuhx2KveILr/
 3CdoaMtXHMkyRyK0FcKPirOamyARv/v8CSybLRm/CREWTa0I1En0cC98FXXgdyj0FKd0
 w9rBwvco8lv2rvv9AVSoCNyexO5OtDtl1Maf+aHAyfSP8lnhSv59oYTMAP25yv7Ff78H
 EyJGz1lpRIYIfUXYPrQn1W0PUJg4MYEyQOGcEoXN4qTfiY/ccjV/SOILytBhWyyIZyTa
 r75AlTvibZ7OZCvMHWmtyp9tUtUqIHmxF/bdvJutk09EnO5s0H8GtCrSPl26cpUMoD3H
 1Cnw==
X-Gm-Message-State: AOJu0YwvKeJBDfGHyttgEL7C82S6wtlsOIXaDQdoDScRa6AcM/Zny1ld
 tgAk18OMFrVr4umXZMFW5aLayrguRaX8j4xrzLlP/rV61wPixNE5lM1AIg9hx4kmenoD78TNSsn
 EUuuflVUXObL+uqjOK7FXLU+7Pdj3+9bZI/9KWiN/AZIfPnpwky9NtVxAQyXwo66uyfRgyIAdq8
 2V334Zc1Kg3whzM1r11xExtNwrej4E+f0Gr9dr6kM=
X-Gm-Gg: AY/fxX5jyWlmsiV+AADU18q7s/xwpb7ArTKF1FZP60mrq/sVtUywdhCuRw5PbwbmltJ
 21N4hAY922ZCsmVPUW7nYuGWGVG4YZXiV0bY1TUjG8pX2hMvrY66cAES2pS4RFx0JkxNSiEcJo/
 DF03ZGcIUWNVs29riDFmEnvTo8aqZR7P4WSElRlyoRX2Kh4CeM8DnofsssSgNKYmkWF/+zY9SZT
 XNF9gIRI9x+h88AHuu+xkXGpoQr31nJK9rePPnJx6T3cDeCgwzPlcZbSsZkVDbr+0KOJnf6Hnm5
 rXczd6iV3k4wP0V+0UvXQ2CIOsvPvKP/m3tap8L+Z5yOUlCFZOkxNMGcckicoXCpCxQplC1itOv
 IM6r5NaWRm8NZ/EyMQPRQ3cDlSOM/3H8jllvgSUsTl5DFyTwyO8qmbYOfgZuosY1/ANG4uc1/Rz
 l4x8z8C0qnN+YM6nVTbs+CKe62cnz/ssYVr6yQizBP/HyXD3rUPto1eXk=
X-Google-Smtp-Source: AGHT+IH7nP0MRU3KIqmmoXRNQ+g3mFL9XoNdy0F0IrzEP4xjyiXbtcjOeQ8Q/XCcupD0ai1+c5CkUg==
X-Received: by 2002:a05:6a00:1d9b:b0:7e8:450c:619c with SMTP id
 d2e1a72fcca58-81b7fcc7c2bmr6484555b3a.51.1767885466213; 
 Thu, 08 Jan 2026 07:17:46 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:45 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 16/18] target/riscv: rvv: Add vfext.vf2 instruction for
 Zvfofp4min extension
Date: Thu,  8 Jan 2026 23:16:47 +0800
Message-ID: <20260108151650.16329-17-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
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

The vfext.vf2 instruction converts a vector of OCP FP4 E2M1
floating-point numbers to a vector of OFP FP8 E4M3 floating-points
numbers.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      |  3 ++
 target/riscv/insn32.decode                 |  3 ++
 target/riscv/insn_trans/trans_rvofp4.c.inc | 54 ++++++++++++++++++++++
 target/riscv/translate.c                   |  1 +
 target/riscv/vector_helper.c               | 33 +++++++++++++
 5 files changed, 94 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 356c24d9fb..162303fb6c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1259,6 +1259,9 @@ DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
 
+/* OFP4 function */
+DEF_HELPER_5(vfext_vf2, void, ptr, ptr, ptr, env, i32)
+
 /* Vector crypto functions */
 DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f2b413c7d4..c58223ebd8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -754,6 +754,9 @@ vsext_vf2       010010 . ..... 00111 010 ..... 1010111 @r2_vm
 vsext_vf4       010010 . ..... 00101 010 ..... 1010111 @r2_vm
 vsext_vf8       010010 . ..... 00011 010 ..... 1010111 @r2_vm
 
+# Zvfofp4min Extension
+vfext_vf2       010010 . ..... 10110 010 ..... 1010111 @r2_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm11
 vsetivli        11 .......... ..... 111 ..... 1010111  @r2_zimm10
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvofp4.c.inc b/target/riscv/insn_trans/trans_rvofp4.c.inc
new file mode 100644
index 0000000000..4040a54ab6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvofp4.c.inc
@@ -0,0 +1,54 @@
+/*
+ * RISC-V translation routines for the OFP4 Standard Extensions.
+ *
+ * Copyright (C) 2025 SiFive, Inc.
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
+static bool vext_zvfofp4min_check(DisasContext *s, arg_rmr *a)
+{
+    return s->cfg_ptr->ext_zvfofp4min &&
+           (s->sew == MO_8) &&
+           vext_check_altfmt(s, -1) &&
+           (s->lmul >= -2) &&
+           require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (a->rd != a->rs2) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul - 1) &&
+           require_vm(a->vm, a->rd) &&
+           require_noover(a->rd, s->lmul, a->rs2, s->lmul - 1);
+}
+
+static bool trans_vfext_vf2(DisasContext *s, arg_rmr *a)
+{
+    if (vext_zvfofp4min_check(s, a)) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs2), tcg_env,
+                           s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, data,
+                           gen_helper_vfext_vf2);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+
+        return true;
+    }
+    return false;
+}
+
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 137022d7fb..bf403785b5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1220,6 +1220,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "insn_trans/trans_rvofp8.c.inc"
+#include "insn_trans/trans_rvofp4.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 759ebb3251..86057f2bf4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5117,6 +5117,7 @@ RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
 GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
 GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
 
+/* Zvfofp4min: vfext.vf2 - OFP4 E2M1 to OFP8 E4M3 conversion */
 /*
  * Vector Reduction Operations
  */
@@ -5916,3 +5917,35 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+
+void HELPER(vfext_vf2)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                       uint32_t desc)
+{
+    float_status fp_status = env->fp_status;
+    uint32_t vl = env->vl;
+    uint32_t vm = vext_vm(desc);
+    uint32_t esz = sizeof(uint8_t);
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vma = vext_vma(desc);
+    uint32_t i;
+
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
+    for (i = env->vstart; i < vl; ++i) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+
+        uint8_t input = *((uint8_t *)vs2 + H1((i % 2 ? i - 1 : i) / 2));
+        input = (i % 2) ? ((input >> 4) & 0xf) : (input & 0xf);
+        *((uint8_t *)vd + H1(i)) = float4_e2m1_to_float8_e4m3(input,
+                                                              &fp_status);
+    }
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+}
-- 
2.43.7


