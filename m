Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D1DD232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RL-0006I8-PU; Fri, 09 Jan 2026 01:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QR-0005Gy-5a
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:50 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QP-0002wA-B2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:46 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso2826232b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941804; x=1768546604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q481TRTvEXoLqWLHzNjV4ZTKaCxRPnqrOt8ohO8k5Y=;
 b=jT0OVISWqORuwVqO7Ar6q2NhKKEJUY6sXEhKWLf5oWUAWfwm5SUGoHaF0SDNmmTLmu
 rrCQrqkE3gsH0AhOjPXCvimIJhnXM2IzJUaQ4REsqkTV3ncxKPZ9WTnrQ/Qc2UBYx5xp
 hat1f8oyEgYyKV9i9o/Ifu6NqlEhE5dsgOcGGMV1p6GvX4hzyef/PERB3xwmSAr0Wp+w
 Aqz8H4QHfmodtBNjWE0xwtVqtj/0hbDnEO8T+OKl3tss6aAecTElIFKQ8P3Xo2xZghKM
 R2h8gXT9gcWcW2tYG8V/ejDn23t2RfsAuhO+nurm8ufBz/eqIbRNrc/BCf3lhym5Jefh
 4UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941804; x=1768546604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Q481TRTvEXoLqWLHzNjV4ZTKaCxRPnqrOt8ohO8k5Y=;
 b=wlitYQDHOpok8Mh8LGJFsxyQOXlnuNBLi4p6ZXVcp922sYyRp9hSvKfEjkYRFNV1iY
 vtkGG48Ij1XfOg6XwK9sP/AOKX/S4twRYj7mB4pXT3VXWMABF2Vhcfqp5ubAD3sqoqZS
 wSA3T2atD4kOVE3UfAHRqgyUvbTbk/qRGEvTuHmSHcJn3phzue5E3Rs54CPTYL0RCVui
 Wogo8vRE60aLy7m3kpOqYT96VU9GKgwXPaYHq96v9yXQVjnVuW9FwhiemPsFlR8crOGA
 Ov7HxK0olG6S1DYmGm/9MlltHWOMsjcXr2YTVkXjZ26LE/q/vO9sobotUdNbNzPCgD5i
 WmFw==
X-Gm-Message-State: AOJu0YxfDcgiwzx10InNIYxUkig8rCESEG1otyc2ocUucLXztdaP6FY3
 fpleb7JOnrH9uN8dXpDXr3OPgZ3r7DR5fChAvDJ3vqa0BMz1PsYbMPpeztJVmA==
X-Gm-Gg: AY/fxX4Na2ig5BiZ7cNm2LwYVI2wz88oQRE+myUXLW+dU4QXBzY7P0Zh3LUVGd/W7gO
 5YqNv+j0mkwDKDmt2FOOAdNMfRRuVNB03wkdHtvBxpYnyu19FEkukdvuXI0VbsjZFRIoIkUCtu4
 X/VGupNoPznt8SJW0HdGZ/kE40lFx2iZcvj3Ft2YzAbdraROiwmegVo4/vJtwdUAYTUT80PfPKz
 jHmnA4C6JonFqXS6qc+lHOD2QLVXhF0+URJnPIvvpo4WWR0JRMwAa0WcLQBn8IJkYgrBvwbLD3X
 6l311QiVw/Ml0G560B0/bgKtc+QH0FprNpLxGfK5ryD0CMHvKIwilSmGKA1g7CVMhQuz033Y8lF
 NG+miILVVv9okbhv185DLOo3uGXIJvRRwjS18VgV4PK3mILf0YA98euoS4DKUJzY2XXdsRMXNXI
 ttjj3PrXZW80S4xwXsDqWRw6Hc1nd6i7FPoRgoWF/PxcTpL9h/y+UxFV54GIJxgiZKI8fURdfe8
 +D5hg593q04+1fPGX8=
X-Google-Smtp-Source: AGHT+IFsTjx2UxZ1Zo+RQBBFzfkCjygJrlI4pYZGTSrki0ib8A96/LYc7OWhRVeKcHkNqMtUtu0I3w==
X-Received: by 2002:a05:6a20:918e:b0:34f:b660:770d with SMTP id
 adf61e73a8af0-3898f9dd14cmr8239983637.55.1767941803596; 
 Thu, 08 Jan 2026 22:56:43 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:42 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/34] target/riscv: Add Xmipslsp instructions
Date: Fri,  9 Jan 2026 16:54:53 +1000
Message-ID: <20260109065459.19987-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-7-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/xmips.decode                 | 23 ++++++
 target/riscv/cpu.c                        |  3 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
 
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
 
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index af92a7e615..70ec650abf 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -152,6 +152,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
 
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=ex_shift_2
+%imm_w     25:2 10:2              !function=ex_shift_3
+%imm_x     22:5                   !function=ex_shift_2
+%imm_y     23:4                   !function=ex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9a27097189..ffd98e8eed 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -254,6 +254,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1367,6 +1368,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
 
     { },
 };
@@ -3319,6 +3321,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
+        .cfg.ext_xmipslsp = true,
         .cfg.ext_xmipscbop = true,
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
 
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
 
+/* Load Doubleword Pair. */
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 = dest_gpr(ctx, a->rd);
+    TCGv dest1 = dest_gpr(ctx, a->rs3);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Load Word Pair. */
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 = dest_gpr(ctx, a->rd);
+    TCGv dest1 = dest_gpr(ctx, a->rs3);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Store Doubleword Pair. */
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 = get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+/* Store Word Pair. */
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 = get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
-- 
2.52.0


