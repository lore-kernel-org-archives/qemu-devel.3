Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F09DC5AE5D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtIzx-0003yA-0X; Mon, 10 Aug 2026 01:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtIzv-0003xd-C5
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:31 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtIzt-0007lp-Jz
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:31 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso776807a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 22:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786341388; x=1786946188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O+KedBK0LIQjUeflj2umeqFE7dycfuQEFCinnKZzYWE=;
 b=XhyW/Lw9APOHsMLlOixTB1Uf35FFfcDC44Nh4lwXLKxKlLg4kdjhi0sP51HA+o6PoY
 0N3aVtcBwIKD2RexpX1dmTE+QIKTPN5Vw+70Wrgs6LDGf5aZYCbm8ryHp11vYNIHNp/C
 Sj4jlhns6W8NH5zVBpBBP3NyDR18vmClljDw/hJeC6oAeJN19xaNoFsTLy69OwqQ2WwS
 S18vh3q6tzRCnjKdyIsbrXE4Cy5l3luz9twDG5Q8rI1D3nryiiqF5avugPXIzLajgpcH
 8jyT1H5ulfZgdoJ6QBJBwTksq96S+l8LzzHJxY4v/kjN8RkVjqAAsMu2tfJpiqHjgD6m
 djNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341388; x=1786946188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O+KedBK0LIQjUeflj2umeqFE7dycfuQEFCinnKZzYWE=;
 b=ZYiNXtaQVKLeE5Hi8UHq0vlkffNtfWn+XU2pRAXNdaPUsOp5oJ45/EFNvmagC1hjkT
 SCy+TuxN58cXi1SsEZn11JMaf7jzMbJk3Xg6fcxl/yKVl6AHnhaSmwZZxoIRzgpZ5LG4
 3eGgMvmlLt9kGCtPZXPHMkyaX/xT6eyUi4H6HZTvYP6V0Bhik1s1w0Fna51c5PqlfLKI
 BBnlyKCBFiZFRheoZWP1E0PXpXcBEtOAyFeK5ucM3Iht3A06dq4ilxah921DT67GnJS6
 h6AVetNZLEmDpOLeA8PpkR8N4lQogoSACQkPgdXiyCeH+oDIFwaVkLiBKkK7zswvd2SE
 tsqA==
X-Gm-Message-State: AOJu0YwStZET2WF0p1VutWRyrnwSiZzMp92p20ld4DunaAyGbaWJqjHD
 n48xBfPdmVoOmNuJzIdSEkufa167SE+iD/mWfhjNzcfigEPne21ZWU5aikGBviHvdRNgjdcowrj
 lnYbW9VBwheeuKItyXi3lVmiL6tQD1T7kEugi2vQAdGh6r7Kjp0Y/ZqdRwevdnYflRQfu2Q3xds
 yD9cFlY2V6XZJlXGxo7J18RobUPh31Y2WLCXUjopyGFRUkTGVP
X-Gm-Gg: AR+sD12A5naJlV1Ex29x9eKd4ltztdPAK7N+bCfbfsGfvwJrb6SCsja6vZ2QfKynE36
 8Bj8fdR7z0JcqkQ7rX50NEgS7/FeS3Fomtv2lJy4PwgC6Wwe0SCK+J3yi8+/Par99+UbzUjxU5e
 eutz84pEnGJq9KdFqhADD+twZOiCywi/6T+Po9bH07mrdUDLnKM/DYYYlaj9EHsI4CJ7uaw9kTk
 hS4iIqmpWlOf5r39Xlm732CUgF/eFS7n29OBit8QXGCmDbT4AJNP5wgKuu/5hNnSLuJZLXJha6g
 RX5JIEaJi2wO+RJ68QsbgxPD5QNs+ENNb8FY9DrQSXa/wHWkgnM7c9x414jOLNEqPoMaL9kaSXD
 +LO6Udlez0CyxTvdzlI/sz7swACHNWXLTiw77xGnjzzib397CO9m74G1sm8eYv7tHYpQDJln6U+
 b8X0ymNVknUyNzy0HrrWNAOUPoWJ58NOdrgQY/IlGBVpYttx/Lu4e7WN2ZaHvxSLm0cPEBYYkB9
 4FCxLlsJZFEyGI=
X-Received: by 2002:a05:6a20:430e:b0:3cb:9bb0:8b63 with SMTP id
 adf61e73a8af0-3cbadb03dbbmr29175913637.12.1786341387944; 
 Sun, 09 Aug 2026 22:56:27 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm39172122eec.1.2026.08.09.22.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 22:56:27 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 1/7] target/riscv: Add Zicclsm CPU option and enable it for
 the eligible CPUs
Date: Mon, 10 Aug 2026 13:56:12 +0800
Message-ID: <20260810055618.1175500-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810055618.1175500-1-frank.chang@sifive.com>
References: <20260810055618.1175500-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x532.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option and enable it for the following eligible CPUs:

- Base 32 CPU (to be backward compatible)
- Base 64 CPU (to be backward compatible)
- XuanTie (T-Head) C908
- Tenstorrent Ascalon
- Ventana Veyron V1
- XiangShan Kunminghu
- MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims that
  it has unaligned load/store support in hardware)

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c                | 7 +++++++
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..7ee89f6fc4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3268,6 +3268,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3340,6 +3341,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3426,6 +3428,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbs = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zbkc = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zihintpause = true,
@@ -3469,6 +3472,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicond = true,
         .cfg.ext_zicsr = true,
@@ -3518,6 +3522,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         /* ISA extensions */
         .cfg.mmu = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
@@ -3577,6 +3582,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
      * The RISC-V Instruction Set Manual: Volume I
      * Unprivileged Architecture
      */
+    .cfg.ext_zicclsm = true,
     .cfg.ext_zicntr = true,
     .cfg.ext_zihpm = true,
     .cfg.ext_zihintntl = true,
@@ -3633,6 +3639,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
         .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a76..f8c27a574f8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
-- 
2.43.0


