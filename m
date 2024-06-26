Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD49C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWH-0007ku-2f; Wed, 26 Jun 2024 19:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWF-0007kQ-OO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWB-0005WJ-Uc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7065a2f4573so4282563b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446258; x=1720051058;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yfA8kZLlWPSq5Lhmc8PIv081g1iqyyY7M5czamR1zeA=;
 b=1GcHd0vfAhQm+6jFWNQ95zBhKgGwlI23eLzP0/EDZZ+UwS7plcc3DqBEQgb9GolHd5
 ZB5X/wAYC1Nn4uSL0V1OAzR64HbKYKLGp8Ck6cZFbQsAPBRh2BAynOYssTdSvOwe/rQi
 9ZB4aswCsITzzyMrWgXrGJzNQ4Mn1lrhDAaxTr5MsaD0mXBUtFinSP88xskalEry8NTQ
 loPlYf3/3lFRCL/iscIw5C2RP4LxwwcW+Z2d2p0kCEHAgyWL8diMLGaxzc2MjpdstXHw
 JlMT8u58GlY64TUPXZsoOmp3AfN6buVXl1D0bhvb+2olB4iNwNvndWlikzskF0Fckcuz
 K85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446258; x=1720051058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfA8kZLlWPSq5Lhmc8PIv081g1iqyyY7M5czamR1zeA=;
 b=Xe5GmerTt1sPRxB8gjuMMKsiIl8fyYhqfAojs/wWmncb3Fg3IPiWZR/wyoM52tIejw
 /rTECAFSZcC/YHynn0Y47x1HQcKf21SBQo3DR7+03winimglE3fDFI12PlgThfAzx5Ur
 r2TB7RHaSBRlzYf42Jb1ooFDQN6Fzte97owlr6TbE+KXsWcAWpiMBsrYruh81l9UpHLH
 DofHWkg612Kkei0um8I36r7gF+DvAPb9lZhR0wMPu7g9CuaNBFFr4wiE1kxSW8qgv8h3
 8jOFz0p3stMoP5RveWVE3V87lzL/iDXzY9/JC7yVmQj2kubUXO0YRgyqVyVE/ZPX55gC
 DM4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+bmKsgqQ5G3ffxE5eP9HVJ2CKXYyysn8CiKDDFGKuoj9SnZWpN31Nr0q1EBSpfYEX3WUAZgj5Boysc4FTMOIfm45xdcw=
X-Gm-Message-State: AOJu0YwozUrzCzugK+WUio3CekpCJuZtzDrAow3hiP+5r4KkAvcfQnJt
 XLkqcb/OFV361HyiQ+PmC9/VgCbTRaaG65sN/PeNE0+h6zl3Bt8F9owIHBs/L44=
X-Google-Smtp-Source: AGHT+IEI0UGaUstHNn6efoVnqxG7CxRjYut0FhkLoArJx7zzyiJtzp6cgVw4oMYSYOh3pQrJUUfzow==
X-Received: by 2002:a05:6a21:183:b0:1be:d032:f002 with SMTP id
 adf61e73a8af0-1bed032f1demr213644637.55.1719446258620; 
 Wed, 26 Jun 2024 16:57:38 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:37 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 16:57:24 -0700
Subject: [PATCH v7 04/11] target/riscv: Add cycle & instret privilege mode
 filtering definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-smcntrpmf_v7-v7-4-bb0f10af7fa9@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the definitions for ISA extension smcntrpmf.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h      |  6 ++++++
 target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 46faefd24e09..c5d289e5f4b9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -339,6 +339,12 @@ struct CPUArchState {
 
     uint32_t mcountinhibit;
 
+    /* PMU cycle & instret privilege mode filtering */
+    target_ulong mcyclecfg;
+    target_ulong mcyclecfgh;
+    target_ulong minstretcfg;
+    target_ulong minstretcfgh;
+
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c257c5ed7dc9..5faa817453bb 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -397,6 +397,10 @@
 /* Machine counter-inhibit register */
 #define CSR_MCOUNTINHIBIT   0x320
 
+/* Machine counter configuration registers */
+#define CSR_MCYCLECFG       0x321
+#define CSR_MINSTRETCFG     0x322
+
 #define CSR_MHPMEVENT3      0x323
 #define CSR_MHPMEVENT4      0x324
 #define CSR_MHPMEVENT5      0x325
@@ -427,6 +431,9 @@
 #define CSR_MHPMEVENT30     0x33e
 #define CSR_MHPMEVENT31     0x33f
 
+#define CSR_MCYCLECFGH      0x721
+#define CSR_MINSTRETCFGH    0x722
+
 #define CSR_MHPMEVENT3H     0x723
 #define CSR_MHPMEVENT4H     0x724
 #define CSR_MHPMEVENT5H     0x725
@@ -884,6 +891,28 @@ typedef enum RISCVException {
 /* PMU related bits */
 #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
 
+#define MCYCLECFG_BIT_MINH                 BIT_ULL(62)
+#define MCYCLECFGH_BIT_MINH                BIT(30)
+#define MCYCLECFG_BIT_SINH                 BIT_ULL(61)
+#define MCYCLECFGH_BIT_SINH                BIT(29)
+#define MCYCLECFG_BIT_UINH                 BIT_ULL(60)
+#define MCYCLECFGH_BIT_UINH                BIT(28)
+#define MCYCLECFG_BIT_VSINH                BIT_ULL(59)
+#define MCYCLECFGH_BIT_VSINH               BIT(27)
+#define MCYCLECFG_BIT_VUINH                BIT_ULL(58)
+#define MCYCLECFGH_BIT_VUINH               BIT(26)
+
+#define MINSTRETCFG_BIT_MINH               BIT_ULL(62)
+#define MINSTRETCFGH_BIT_MINH              BIT(30)
+#define MINSTRETCFG_BIT_SINH               BIT_ULL(61)
+#define MINSTRETCFGH_BIT_SINH              BIT(29)
+#define MINSTRETCFG_BIT_UINH               BIT_ULL(60)
+#define MINSTRETCFGH_BIT_UINH              BIT(28)
+#define MINSTRETCFG_BIT_VSINH              BIT_ULL(59)
+#define MINSTRETCFGH_BIT_VSINH             BIT(27)
+#define MINSTRETCFG_BIT_VUINH              BIT_ULL(58)
+#define MINSTRETCFGH_BIT_VUINH             BIT(26)
+
 #define MHPMEVENT_BIT_OF                   BIT_ULL(63)
 #define MHPMEVENTH_BIT_OF                  BIT(31)
 #define MHPMEVENT_BIT_MINH                 BIT_ULL(62)

-- 
2.34.1


