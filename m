Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEEACD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQj0-0005zq-Fm; Tue, 16 Jun 2026 06:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQit-0005xR-Uv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQis-0003j5-98
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so2741217a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604525; x=1782209325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3u9rzQOI9J4UTnWjFA47Hld4PgjrsYGswxeHP/aXJpU=;
 b=cNI4XQLUKwt18hQUHA/ctHpJEZU4FTY3qS9vsTSII0UgnsmHW+bftOtX6Wrmd2+QTo
 X8c7z7SnGRMJ7SVHEtjLasXG5cZggm/+PuXoN+uYP0naJKJngdQZcYROhFz5J3BBdsAq
 MK+L5w/S02DHn0EcO/Sh9CIQgxzQ7JQa//6Oh+YDN7eZtX+WKgRXPy6+2+/xVAGFFzbe
 8q8ARupx0ZNoMk+3IDYv8XOUMHca1tsqB6NmRgmLSDpl3R94Nk90Bvbgyr2wjxZgZxEv
 YXqD8rynB51In3OajGS9a9S4llv6V/L8/ApOE/CMrtJyeb/7vzB7580s3Sh1I0LDIqiD
 /EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604525; x=1782209325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3u9rzQOI9J4UTnWjFA47Hld4PgjrsYGswxeHP/aXJpU=;
 b=kOmMmrKiBgo/LJSq8xT5+IouRwxRcBQilgq2a/KYnBHlME6zI58UffWKx6zM+g07PY
 DUcYInck4cRmVAKip3dTrKFEPhgb5cDYB17ch5492riUSZkf6/wyxQPh3uWuC5ODEE8/
 6J+JGIq8dRl7Scf4SdDc1EFgtMuIy4qtsB/ISedIrc0x4ovyAO2Ybe+zP4pwOW3m63CV
 bZvVEGkeqiF/3HKu2zYK/XCGsHOR187thOGKN7k6GZ+c4Q8gmT0cSiWEdX1E5xiD6Bbi
 o8im4lgHwLruX2uyAs1waMGDtJPrP6M5kbpGqvCv7TXon+J1XaIhA4jIJnMIF3kSxbYF
 Tp7w==
X-Gm-Message-State: AOJu0Yx6XysBBN6BIT/FUE0hs5wAwsQoIy18zWOWXQA3kQ5khYvX4OvV
 B6twL7RSw2F3jGAR07+wju1n5LyhhUoK6OA3xuHpQ+wsj5i1NJ8PyIXsEqXJeu3y
X-Gm-Gg: Acq92OF7LVVRVj/OfXdqc4aiUjjz8RYZ9dtKSVDWnXdxefHkPPE5bRQvkE6kfU6lV9O
 Z+MxDpT4pMo/nTJHC5wNOZHZHN1Xx0ktCqzMp84njS3XzMmKWvwSeswaz7RjTDPNXtBiYVSBiX5
 b5aHMpOMw+X1bHfZbbGNVmDF57+8bhMmGqw23jRWxjJAjGYAjCeFYaz4K85JZ2//0Ddwu1rsUxZ
 Z4cdKO8HrVotAwmxf0V0Ez2FF2il9aCvepxdv9DF48t/g4fA001nGU0JLvFxoioNvyG9lfNHDq9
 eAD1ffjHohNJGkIa8e8nA9t04Pik/wz4mE5TU5zQ6LTwcyQycofX50+Q48bD80RLb97b28dtUit
 t+ELCCXawtVL4uuxoMAfXYHgM3mLbPC4N17siKmYJkxoqC8+hYpGfDzhCfqDG/zdAnPtHqdmp5V
 nPxlYiIWabkGXUWO8UH6MP6EfJqnnNUWzJtg3Z6ALj
X-Received: by 2002:a17:90a:dfc7:b0:36d:5d1c:c4ad with SMTP id
 98e67ed59e1d1-37c5283eb6dmr2787744a91.9.1781604524857; 
 Tue, 16 Jun 2026 03:08:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Jim Shu <jim.shu@sifive.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 54/83] target/riscv: Add standard B extension implied rule
Date: Tue, 16 Jun 2026 20:04:57 +1000
Message-ID: <20260616100527.1939565-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add the missing implied rule for standard B extension.
Standard B extension implies Zba, Zbb, Zbs extensions.
We can also remove the auto-enables in riscv_cpu_validate_b()
as Zba, Zbb, Zbs extensions can be enabled by the implied rule.

RISC-V B spec: https://github.com/riscv/riscv-b

Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Message-ID: <20260528054213.678458-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 18 +++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 455d5b3d48..df101b1213 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2107,6 +2107,17 @@ static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVB_IMPLIED = {
+    .is_misa = true,
+    .ext = RVB,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2514,7 +2525,8 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
+    &RVB_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 942c2851e8..b73e3e9dd4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -517,27 +517,15 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
     const char *warn_msg = "RVB mandates disabled extension %s";
 
     if (!cpu->cfg.ext_zba) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
-            cpu->cfg.ext_zba = true;
-        } else {
-            warn_report(warn_msg, "zba");
-        }
+        warn_report(warn_msg, "zba");
     }
 
     if (!cpu->cfg.ext_zbb) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
-            cpu->cfg.ext_zbb = true;
-        } else {
-            warn_report(warn_msg, "zbb");
-        }
+        warn_report(warn_msg, "zbb");
     }
 
     if (!cpu->cfg.ext_zbs) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
-            cpu->cfg.ext_zbs = true;
-        } else {
-            warn_report(warn_msg, "zbs");
-        }
+        warn_report(warn_msg, "zbs");
     }
 }
 
-- 
2.54.0


