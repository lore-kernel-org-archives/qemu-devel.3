Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EECC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hw-0008C2-8E; Mon, 03 Jun 2024 07:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hs-0007vS-Ds; Mon, 03 Jun 2024 07:18:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5ho-0006Xd-EJ; Mon, 03 Jun 2024 07:18:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f44b5d0c50so32799735ad.2; 
 Mon, 03 Jun 2024 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413501; x=1718018301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN3SL80ZeNYtdgHnSA4EmYhdmlHM54QOJLaD6qM4+6Q=;
 b=hJCsjFK+q7C4DoKQAyv5VwRmUBolLS9gxFzK8qAE1J2zSW90qdaOBYcnDTASdlQz1A
 WVFiMzslDUpKGxo/Uwswhuc61Ob9xQeoPDpZcv8yOvIQXeudURcVmz5vv9xHWDhlJWPg
 9g2iofVsioDZVBb3a6TF/agwpLpDFA066xl2FOrZ2CCgfyexabAMGClSIgpgz7ZHvtLI
 5M6f/O4VZQw4pfDpam9SgS6ARlISpnKWoZ2QCO5X8vt+f3lOiXCFuErymAO4p3XcppdJ
 ijacddsQxuLc22wiGiGPwkDJTvSuJzCzfeupiYUWY4IcnQkXTXD9Xsc35ZEyyJaFnGY9
 fgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413501; x=1718018301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yN3SL80ZeNYtdgHnSA4EmYhdmlHM54QOJLaD6qM4+6Q=;
 b=YYqTIypQ3XCmG4TtIgtxletb9X+jQNiEiuodHGxtinQgA2JfvbmbLhRz3m2taRW/SS
 bNuLGKpMHCPiJiUVcQ//6wXll64vtL+1YYp0dTV5aaqmYwONa/r0v4W7aOyBdI5mRRwD
 JsSD3veOLmlN+O/cOw9V9ks238etL2JmlWr8CccWg+6svdj1Bu1yS9n4wbTjRtRsLRg/
 9Wkuh8wfbn6qSsB/BF7s1lkWHv/v0pNK93mT79w+ECGCUiTXEUEbEO4Uj44ogLWnXVyD
 5r4J1fh8nqytXLVMK73VBeFbblVFp67mJvdM1PZaFoVVnx0JzLKZ3mm+dBfRMvwY5MiZ
 SQfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN7xgKElj8yyEcboT5B3YU3LSBfhQU+guO9MNfAuFfAls2b42zA6a6/JOIjtnjJOeW09Dtsls9MiopVa4yNKKGnqx0XRBW
X-Gm-Message-State: AOJu0YwGcIXDxbRFTzbPC6BsYnVTdP69TIkFMeK/8VYNFlvlTZiQjuEo
 17MgD2HKf62YFiMhM3ROUBPO+jEzMA1g9pg9m4VhcHhqeduJ7TIYqBEOhA==
X-Google-Smtp-Source: AGHT+IH/KHWBocNyxzQqDylreZ+Eh2C6FavYssab9/L+y2dGp9guVUitn+08JLVQUt3xBOnDJcFShw==
X-Received: by 2002:a17:902:bb87:b0:1f6:3429:69d7 with SMTP id
 d9443c01a7336-1f63709e4ffmr79931185ad.52.1717413501040; 
 Mon, 03 Jun 2024 04:18:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:18:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robin Dapp <rdapp.gcc@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL v2 26/27] riscv,
 gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
Date: Mon,  3 Jun 2024 21:16:42 +1000
Message-ID: <20240603111643.258712-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 33a24910ae changed 'reg_width' to use 'vlenb', i.e. vector length
in bytes, when in this context we want 'reg_width' as the length in
bits.

Fix 'reg_width' back to the value in bits like 7cb59921c05a
("target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'") set
beforehand.

While we're at it, rename 'reg_width' to 'bitsize' to provide a bit more
clarity about what the variable represents. 'bitsize' is also used in
riscv_gen_dynamic_csr_feature() with the same purpose, i.e. as an input to
gdb_feature_builder_append_reg().

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Robin Dapp <rdapp.gcc@gmail.com>
Fixes: 33a24910ae ("target/riscv: Use GDBFeature for dynamic XML")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240517203054.880861-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index d0cc5762c2..c07df972f1 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -288,7 +288,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
 static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    int reg_width = cpu->cfg.vlenb;
+    int bitsize = cpu->cfg.vlenb << 3;
     GDBFeatureBuilder builder;
     int i;
 
@@ -298,7 +298,7 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 
     /* First define types and totals in a whole VL */
     for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
-        int count = reg_width / vec_lanes[i].size;
+        int count = bitsize / vec_lanes[i].size;
         gdb_feature_builder_append_tag(
             &builder, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
             vec_lanes[i].id, vec_lanes[i].gdb_type, count);
@@ -316,7 +316,7 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
     /* Define vector registers */
     for (i = 0; i < 32; i++) {
         gdb_feature_builder_append_reg(&builder, g_strdup_printf("v%d", i),
-                                       reg_width, i, "riscv_vector", "vector");
+                                       bitsize, i, "riscv_vector", "vector");
     }
 
     gdb_feature_builder_end(&builder);
-- 
2.45.1


