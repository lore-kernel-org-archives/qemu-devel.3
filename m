Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184C4E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHW-0000T2-Kn; Fri, 10 Jan 2025 03:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHK-0000OY-Vz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:22:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHH-0008Nk-GW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:22:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163b0c09afso30177215ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497317; x=1737102117;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8PO3KdPn6r4KLBmTxRjCZJWi5E4lKyq6ODCIoQJPeOA=;
 b=lyqGH2M93RXy+08uhkHocv1tez49F7zaWinxWxbCNM3Tlwj6ndtAU41gpTA/VYOn4E
 Ok/RN1BDZCDtCFd4SY5EknWonZteY9sTFDovslOUAR3iBxwXir3qmYfIRGozWMRzadHZ
 5RLjUGxF31vxK5EZFcpbwgP5YdgW5SVM5h7ufKOMLJwJulS4qhGIjIXMwNsnLkqUK1xP
 tOwC9qFNpKRUlhm+KyO9wZS35AiYljlah3tCgtQXjD2TLSRedyvOordjBQeTcfpaK+/3
 JgVRo6dfgsWzrVR91aX7MebexPBCaW8xzV8z9Q+se7wpmZ3FdOokBlgYXoetJFwWE2zL
 T+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497317; x=1737102117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PO3KdPn6r4KLBmTxRjCZJWi5E4lKyq6ODCIoQJPeOA=;
 b=udekIpna9DvdyEVNEcOpskaGxjuDPVGeSNk3n2xuMePIbdANYF5J7YFVVukoBHiJus
 uZqTxcxuRS6q62zi2seoGlGUBnmNEqDCXaAfcBbhyQrsNDSdQ6ufwtilIMeF7E7HgmQs
 dY/tmnHSxCffzzCIamfBKxSCln+bFfIX1FTzuEkyarHdU9u4P5cYVjvbzNYMPjHNarqz
 QVsT9j3naOUAHf4xrUuuIFkSoBHf2VUiR2LZFMEb2pPoX797G0qD2aYr9/zH+Y+beW48
 GlHd9JhWTo0pt5vIIIXyAg01eRmGPvzFPg78xQDqM0bgn2oW9r72hkKhg8iv6FCcKme1
 p02Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2eSYlTl3Dtisye9w/h84W5OASHE8L8iwHyq5ah9TRPY4RsVbeP2gCiSxEmQut9BHNcrn3sk8Mropw@nongnu.org
X-Gm-Message-State: AOJu0YzSb1rLANtLkD8BGCqLI1Xs9PUIKs7UHYI5z/FcS7JM00LIoSkR
 nPtYCBLXsutxa/j+ae06KL8G4/hXcqmpvHPvTZpTN1TAwRrGmb+LpizACsfEYW0=
X-Gm-Gg: ASbGncu00mW0Gc2KC8O7M+pCz8fis78+MVFcLQB0O4HUfOCRvOZrByd/RbYmLCkehb8
 +2IZ6t63pwKVRSJxKi8u+RD18szzlkPccDfkyxp91y+SeUckbvkbVBAwIwXsFPNf8tibqQfHVHM
 i26gpYBzup8zTFwD8R4Nyt5XUeh4IMrCifRa+c+bhvJ1gp5v0eOqp6YOryRZs6Y+UsJfEM2Or/t
 E2nMYbZR1drN4ZPEoDTr3BriVuo95cqe9x0dTi0C0Q8x7RhLdT4XiBwb43Bs7YeV9iJPQ==
X-Google-Smtp-Source: AGHT+IFFFB1vXn43se+hnqQBrd1cZjxg2mjB3gKDUPW0j5nRELOy2cBkGfw1POV4CnIISVFFUZQU5w==
X-Received: by 2002:a17:902:d2d2:b0:21a:8382:fcbb with SMTP id
 d9443c01a7336-21a83f5db86mr154800965ad.25.1736497317517; 
 Fri, 10 Jan 2025 00:21:57 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:57 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:38 -0800
Subject: [PATCH v5 10/11] target/riscv: Add implied rule for counter
 delegation extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-10-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The counter delegation/configuration extensions depend on the following
extensions.

1. Smcdeleg - To enable counter delegation from M to S
2. S[m|s]csrind - To enable indirect access CSRs

Add an implied rule so that these extensions are enabled by default
if the sscfg extension is enabled.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da40f6871572..671fc3d1c1fc 100644
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
2.34.1


