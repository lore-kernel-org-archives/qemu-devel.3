Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F860D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RK-0006CN-6M; Fri, 09 Jan 2026 01:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QN-0005E7-Nd
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:46 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QL-0002vJ-Fk
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:43 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso1858745a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941800; x=1768546600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0GKX/kt0wdDuUaHM/I0P3t8tsMimjTykWNFFF9bH/k=;
 b=ToX9VDeFaQUgFVjE7lrR/Mrrg/kiyZUsO0vbwrcEqAmmtY9h9BffcN5g3RETZFdktS
 8btH7ZNzVkGuEBIXv6Emc3hyiSGVWoDxwmkCf5xxOOcjvMaEatlZKCgTg/CMQDV4BKBa
 w8BuuKvlVwW1lQz49qimdzJduGAxpTqeGxF1XU4yh20FuUWyWWMo9yHsDludbe7Ub0H6
 9U1QLFdQB7TS6ac5acexoyVFrWAvpzwEquyAtBMIxlamNDI/W15zH0VVn9FHdhTw3QQR
 qU1UbgPNdNFGbFrXD59y3TNpdEeJLLDypJ3vKLvJe22gasly4PbAEnzmlsjZF7J6pyxv
 Onsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941800; x=1768546600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w0GKX/kt0wdDuUaHM/I0P3t8tsMimjTykWNFFF9bH/k=;
 b=trXy31r62eElg6A3dqQN1M17fsMeQ4iCd/mRYnnu2ZatBtqPf1RG3lSo2wnaHE57nf
 ptkf+MTUIO6IOwu+tpd3V6acD12iEdF5n1LzDh2xVgZ9kqul04q2FqBYGK/3DolLCjoD
 efmNiqhW4vx/H+39bYGE2tmrLb0hIdS+8foeyBYfeumze1LSkDKqmYxz9RdxjaSZw0E1
 HVSuIeQespyTmuwIixltSQLKKx4Gmus/SfZFS9FcTLacGPILKj8x65C3jBg4W3rVfm2b
 slYCHqNl8yLH0TLckwiWeIyDQqpqFiBUBnapNeWo+D3+TRdOfTuor0eZgQmRx0YmTIe5
 LN4w==
X-Gm-Message-State: AOJu0YyHew00kQLtZ/FL2bUzrl2vTg/KBXIjXZzsaRxrv1kBNs2/yVnv
 SEcwNU0wCrvkd5jvRr2/GyUlk4YPL1g+iSWTKy4gq5KWmJT4v4FqJw1Pkzg7gw==
X-Gm-Gg: AY/fxX63t2mIpKx2O70X5EztEeCy4FiqFvpG2Uau3oxxGhuFS0LzL2F4hJq47AENHFl
 hHds3o+8CXSYPrAohpDyT5pCUZJc6SoRPTaBhzaQR4VMGHHX+dZ3iRSttTbGwl4xVUaeBcFTw32
 fMaM47OyAVMGGG/wQpp5k3oW5YgCkcJl5rDlrJUmu36YP4QyKLNK8t2Vjakyb2D07Z9srHkU/gX
 m+PRUsE2mq49kHApmmFUX26GgjniXfscMqQHOBCnNI9fdJEzaCXRxIG1DBeKhduEmaYYezieq+F
 8sABNo5JbUOl+EvSv1i5kzk0RE9xqn68Bsd/2JpSmw77HtXxzdcFBNpCoASFTw2IrgEKHJNZqVk
 sj0cNCWOFscJzsoZFM6ZtF67nLtPazFIUN4olC9lZHTMf6MHmBZYD5mKbbMavkUSR5kl4nxMAUe
 s0gATkZROrUTG2HAqxY19I4HJ0xToUUiFCBkWfkLCi3VYTlXr67FmwJPl+rrXyAZEEfWMsFOO3L
 aswITFn2ltKH2Bxj5E=
X-Google-Smtp-Source: AGHT+IFNkvYTAaD2GXsNFc3GMi8I7DTY6cgoZ7MQER2KfjMJR0Ddvc009DW9+90A3zc78hNpKb2drQ==
X-Received: by 2002:a05:6a20:94c7:b0:35e:3cac:858c with SMTP id
 adf61e73a8af0-3898f96cc2emr8781244637.33.1767941799800; 
 Thu, 08 Jan 2026 22:56:39 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:39 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/34] target/riscv: Add mips.pref instruction
Date: Fri,  9 Jan 2026 16:54:52 +1000
Message-ID: <20260109065459.19987-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-6-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/xmips.decode                 |  1 +
 target/riscv/cpu.c                        |  3 +++
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
 
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
 
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 0b461bb05b..af92a7e615 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -150,6 +150,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 
 BOOL_FIELD(mmu)
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
 
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d0a6a88a4e..9a27097189 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -252,6 +252,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1364,6 +1365,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
 
     { },
@@ -3317,6 +3319,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
+        .cfg.ext_xmipscbop = true,
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
 
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
-- 
2.52.0


