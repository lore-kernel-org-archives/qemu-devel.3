Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE1AC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuDS-0007Fa-Um; Wed, 21 Feb 2024 16:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCO-0005Dh-AZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:17 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCJ-0004Q9-1K
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:13 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dc418fa351so1710015ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708551124; x=1709155924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nju837T+xAifM6nWfhQ0ZVlDyxhFZ0h0UYzFI8YcPFQ=;
 b=YkCMdFY/n3bk1zNtROVGY223a+AarBZ2mUJiB1F9hcidQaL8ApK1FMTse0DcTH9pi/
 +WLvdKdyK8l//bV8VoB6O+RZ0+dzkV3mDmlHEshayP4uMGe3GdMtWYXNlJP6u0v53wg1
 3N+TldjMKvp+d0H3kSN2xbv67QkY3Tm3vMGGBuQ1JAKh2PpDN5wl+P108YzwShcNVPTq
 2LbH5KNCDVCUIzdHzmfw9vuWVveGu95dyjstDwCW3Q7sTk38+U2v6nSahcyflMKT4U6M
 C8wRrluawjccFzWlYHo9KDDEhzkVx6x3d6Vng+yxRKOG3/FKpy9ImLX074fLimvOra6W
 FF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551124; x=1709155924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nju837T+xAifM6nWfhQ0ZVlDyxhFZ0h0UYzFI8YcPFQ=;
 b=iDKlJMMiHLXuhXlOkhngIp+VMtQkytbMFkP1o+93VW2uqHg7jlS7McgyvoyEd+JyzU
 +27IvY0yvX5wQimQO8Wq5aqKc1FEj6ZInfp4IVVm8vSyMYnpKymAHh70ifA66Y+hMkOE
 mwK6AXze2HMzyYrCw9dLcO/RqIYjmUbDaHCH2lM1er4Qsnr1RWg/UmJtV3uqA4XxxXHy
 GcG+oGIMKQzP/ypVHhIj0AULQJMF0yljlTBFS5UraqUbCpehVSFr6wwWPGygKo9JIqB2
 xC9yumLr3VqMpsHymDD3IjR/VnIw2F+g75KLdKeEaEyIgaHM9/ro4ZyKkpTqK+qf8JLE
 devw==
X-Gm-Message-State: AOJu0YySP5X5MSaCvFCj/d2jbWNRn4ljKddCJMotFhrNVjkdtzv0KJS/
 8L8z4tJmY4IaQ6m24y3HEvnEATOB6tPYg8gvme/WyIJ12Q1rGYm9gYRzlmhezXOTaqyCyx4z/6t
 y
X-Google-Smtp-Source: AGHT+IHOBv/oXV4YElh5tu6CpXCWmpQZ6AN8W/Om10lz8GeBRW8OWI66ykLH++ts36ElX/MD204QWg==
X-Received: by 2002:a17:903:18d:b0:1d9:a15:615d with SMTP id
 z13-20020a170903018d00b001d90a15615dmr1149831plg.1.1708551124326; 
 Wed, 21 Feb 2024 13:32:04 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a170902ee9300b001dbb0348733sm6618051pld.67.2024.02.21.13.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:32:03 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 5/9] target/riscv: remove 'cpu_vl' global
Date: Wed, 21 Feb 2024 18:31:36 -0300
Message-ID: <20240221213140.365232-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221213140.365232-1-dbarboza@ventanamicro.com>
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

At this moment the global is used only in do_vsetvl(). Do a direct env
load in do_vsetvl() to read 'vl' and remove the global.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
 target/riscv/translate.c                | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 58299d9bb8..69f32d081e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -157,7 +157,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
 
     if (rd == 0 && rs1 == 0) {
         s1 = tcg_temp_new();
-        tcg_gen_mov_tl(s1, cpu_vl);
+        tcg_gen_ld_tl(s1, tcg_env, offsetof(CPURISCVState, vl));
     } else if (rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_constant_tl(RV_VLEN_MAX);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f2f0593830..3040f5e0e4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -38,7 +38,7 @@
 #undef  HELPER_H
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl;
+static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -1320,7 +1320,6 @@ void riscv_translate_init(void)
     }
 
     cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
-    cpu_vl = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), "vl");
     load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
-- 
2.43.2


