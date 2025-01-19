Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B1C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtu-0000zW-M1; Sat, 18 Jan 2025 20:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJts-0000bg-0z
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:52 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtq-0003Q9-8Y
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:51 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso5829442a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249289; x=1737854089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaW0tvq1/a5Vft8d/Xnu1qTzcCymb3qmshGEmEVK9kY=;
 b=CU3YDSqqNoTos/St6L79fqSaul9jU6B/ul//L6y0YUyEhjiDA1R8C5YX1BK/8xzLHy
 JCxl8kHcIFC/co/Y3A+qLK30WR1BmLVQm16Bd976mAF86XlR4iZXJuJduaE5+FNoBHdn
 vmVBwCkbNa+PFplaDK4/iRf8igmggCzHnYjep0fkjsHoapBBHEKyCTWj0NOrKC051EQs
 5l3vwnrOa5d5gmNewZKJw2H0ATws5P0afTW9MTGAuTUOCAaxwDM2mYeceo97R7HvKPnO
 61xeJkt2wiKymcnPMmGyfRYFLMnO+jwLsM4QzgMYGNFb1qCLe/IWCADqoUF2NmhyF0kl
 pmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249289; x=1737854089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaW0tvq1/a5Vft8d/Xnu1qTzcCymb3qmshGEmEVK9kY=;
 b=oitPUvW6xApkGuWfXJhk1TCH6LUn9s37ASUGWbP9MCFQpRtCD78jnOtokiHw4fRK9t
 r3OwUzAHWmMlT5UK7brQuc4F+AwyXM8WVaBx1n2RybI6yWNTHf/GzyvcrUKOAwmXmnLV
 XLH0Op4lnwMiesW10cygaoeVG0PwUToqiWWhNL+hSD1TieyfqsOEoGVD7CWcfIDiJRP1
 lX4UKv8O3rdvlvPl7y8BZGNwvPj1QL3kcZ6eC+YEPvRqPUoknYEJ5TIhluy1JFBAO49q
 y8Ri287/byomNn2Ky6Y70YkgtPyQdlAeZ4cNua8PkyXdEd1mx46yF5xe4oiEtK9I/0ck
 jL2A==
X-Gm-Message-State: AOJu0YyzxIL9S32I1eG1hrmIfKZ7kGoK+WcB/ncLyIkY1oCfWLH+Qwqn
 DC5M1VFdG0nAi+G7piTBeqBpetN2B/z/8UcuRZBp3VHzVkxLxBmfYByVYQjm
X-Gm-Gg: ASbGncuWAqXBu6uuW0ps8e/yRAg6MvltaJfa5z67K1WIesVapSPS21Wp58g/Aqlltez
 2R+/HeH8YTgYla4WeGXTwWc8J4Add9vRsFJUJRK68cjUHSxjPLzySV0e8xExbSFDqXTingEM0CU
 g2cm1PaBR7X3fwot3eGSrOdlgRazcLG/9RZLj7hT0lewWACTf6AS2qGcU7MnCGrBGdMFREAeySF
 VA2alzi+rH+hRKnvq7Jhdb/eDYsNZ6gT4/91IjzLW7hBs16PujWbtmmnxl6hEw34DivIAiDw8ai
 XWmRTA7NATi8/JDhCSMBsRM4a+at3t81yHbAQ/n22AXHirkrRDa3NvGX4iGxHcyQi/WwLccxfg=
 =
X-Google-Smtp-Source: AGHT+IE7fyr13Ys0HxTYXr4arcBJeTYAFH6jjZnwmv2oOQSTvdN1G2t4otoMFAQpSkpCsVt3YFPMhw==
X-Received: by 2002:a17:90b:54cb:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2f782cb4d3fmr12976874a91.16.1737249288755; 
 Sat, 18 Jan 2025 17:14:48 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 37/50] target/riscv: Add implied rule for counter delegation
 extensions
Date: Sun, 19 Jan 2025 11:12:12 +1000
Message-ID: <20250119011225.11452-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

From: Atish Patra <atishp@rivosinc.com>

The counter delegation/configuration extensions depend on the following
extensions.

1. Smcdeleg - To enable counter delegation from M to S
2. S[m|s]csrind - To enable indirect access CSRs

Add an implied rule so that these extensions are enabled by default
if the sscfg extension is enabled.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-10-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da40f68715..671fc3d1c1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2760,6 +2760,16 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssccfg),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
+        CPU_CFG_OFFSET(ext_smcdeleg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2777,7 +2787,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     NULL
 };
 
-- 
2.48.1


