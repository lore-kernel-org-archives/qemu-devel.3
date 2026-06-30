Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84388C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVxF-0006Fp-Pn; Tue, 30 Jun 2026 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwp-00067W-UM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwm-0004wZ-8a
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c9d87b1f9eso14588905ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1782816246; x=1783421046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2T+s0I+pb39JwLsJ+WkCJFqSBOBfYUHzaqPSRYlffE=;
 b=C+zt6lzW+G675YeoGDdRE7WkHBzx0kwS2QRSw5QfbCjphvKopeWea0Uqe18vnVZN6K
 vl1SkoZxXjc3t/EQadmUlUDKTDZ6gfcIZi1qsOFqDkf3ho8hgC3B3zygM9MFVVu+uRcc
 F2eOc56hsbsDzCuSA4+3HA5M1DEB0BE53Gsr6cNwTDxA6ZHKHE6TxxjfhzxO6vdRL7hn
 mEeShHl5ty4eKcEL+7bn1sjhTNRNo5JxA6Q3L3kGRgtvLrH6XEtTWpf1kMH2RiermHxA
 0ilQDKcvlg1MqSacbTLdkeED3eZSF5ezw3/K2havp/hnKdGK6rfwIGptysOkOLS+55FJ
 i7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816246; x=1783421046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q2T+s0I+pb39JwLsJ+WkCJFqSBOBfYUHzaqPSRYlffE=;
 b=Yi/fJJhmos5RT9vhnBBgf2B+OSugTwJrwX5tT4EM9kTHpRCbZzqvbH0Yqmg2ovRXgn
 2oPc46O3ePDX13auXOlcDJpxStY1+5n6HXCMQddx8mqPFXV+E+1FVmzV586BszkPDASK
 Ub+RqA75vznUk6IEXXoWbjFyrVQs+WfIIE7svuVGhN6N5q3fTx8isBfXyZVId/0H25SS
 HyVc2+5rWRIa2n409WSJ0Mj7+swoCQzQht8m137RUc7WHan/jVHzDJFCvo0z3bpay/cn
 33x6HY58DgptxZqrPPvIvVfRH/lV88fTSSbR/A4TSLmJYsfpqeeKzFwthVAhvHgNPZsv
 pJVg==
X-Gm-Message-State: AOJu0YxG8D67/dIc8KX2Rqw8T34WmOpYkkkvCgDihnIt8gBD0wtIYL/y
 7CUKqXCxREjZYR7Yaz9FLUOYtzMoWn1lEjHriNI9cyudtpdaw+QD7KxRSC2cVxn2T52e3A2ZC2g
 tyWZOSA3y3rUUny5gwBO7Mv5iwtLFN56SIcbWtUwKSzDnLnseZt3aPIw5+8B1Q0Bwajme7NB60O
 D7FPuPggRAq3K925TAGe62jBa1mISLYSnSIewDpx7jEsO/rCMj
X-Gm-Gg: AfdE7cnp6BqLQv1snMIq2d2pMVXSoHIDBoVjTU2v+8gW1oErdVsg338fNVWis9i4LWY
 ZY2L1oza/xAdgycfPIdBX+Xcf3KzX9ASYdzjVXjhhqkbhfRktWiV94uN1cnd72C8nUxKsOXNKet
 +m64Pwya9EE2yx0wZW6G8nKU1fMwW4lwMcm2UqWyI61agCeivAdyp2ayQYypVf1g/7QPvFH+pnF
 Ku0IvTtyfxkbUhEx7P47Snu7CMgVdBPjuRmdKI7hmHrDWTnwbiqqyUAvy2f1PFuWWttO9oHXrQX
 zhIrBIk7Uf2RaRWxrFbPOy3w6G8ZqGjYEc5mZzPbof7CTJiwV9Y42pd2sWlAmfXqJVL2sAUVahY
 PIfFOe+yrkt91yH9J+PQ+BUaih4VzdunTqoff0NQ9RDo9dNnLXYNPbzkm0IO/BWFjmySpTieXsR
 1tquk9HDC6c9bKw6WDV8g65dA0NV87JjOMclYvies=
X-Received: by 2002:a17:902:c941:b0:2c6:a772:7e43 with SMTP id
 d9443c01a7336-2ca2e333005mr21878875ad.18.1782816246224; 
 Tue, 30 Jun 2026 03:44:06 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bbf95be56sm1274745a12.16.2026.06.30.03.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:44:05 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 4/5] target/riscv: Enable Zicclsm for the compatible CPUs
Date: Tue, 30 Jun 2026 18:43:49 +0800
Message-ID: <20260630104350.748267-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630104350.748267-1-frank.chang@sifive.com>
References: <20260630104350.748267-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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

Now that Zicclsm is supported, let's enable it for the following
compatible CPUs:

- Base 32 CPU (to be backward compatible)
- Base 64 CPU (to be backward compatible)
- XuanTie (T-Head) C908
- Tenstorrent Ascalon
- Ventana Veyron V1
- XiangShan Kunminghu
- MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims that
  it has unaligned load/store support in hardware)

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bff3ed5de14..a3cccdfed3c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3021,6 +3021,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3093,6 +3094,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3179,6 +3181,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbs = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zbkc = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zihintpause = true,
@@ -3222,6 +3225,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicond = true,
         .cfg.ext_zicsr = true,
@@ -3270,6 +3274,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         /* ISA extensions */
         .cfg.mmu = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
@@ -3329,6 +3334,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
      * The RISC-V Instruction Set Manual: Volume I
      * Unprivileged Architecture
      */
+    .cfg.ext_zicclsm = true,
     .cfg.ext_zicntr = true,
     .cfg.ext_zihpm = true,
     .cfg.ext_zihintntl = true,
@@ -3385,6 +3391,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
         .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
-- 
2.43.0


