Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F10C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KE-0000Me-WB; Thu, 11 Jul 2024 18:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KB-00007k-Bn
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2K9-0001ZJ-Gc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb19ca5273so9716585ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737095; x=1721341895;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=her5EAPO1IPqX9VrTf46ZxZu9jmSV9v3DRrDQ/OenVY=;
 b=HCHfiT9GRpGpMxFb0LG/vTi+BhdXnhRiBXu2bX9mS5ImZ22IXwnwCubk204tWGggxR
 kD0Ow0K1zM7Y3cOFdzP9gjsQolCI+ZFfiVqCqG4069jjpnhfBOnnRpcy767+2mWZHGjT
 7cIgPJJH1JH3Oieyz1enz4JqwJGKEHlZd0IyVXIR6GQXZ481bmB5Hpzub2ik+F21eYpG
 QhkbogDGXd7OCXRTtBoargNlxNM1a8JX7M86dovxxcnpICPE5DjqsVGGhPQdrHAjQopF
 76WpTj2TmxQ4iYOqrElXeUQW8LOYhZF4hvc3/pSEZpSdwlkGAFChF8iV8TOFDCZNxDvR
 t33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737095; x=1721341895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=her5EAPO1IPqX9VrTf46ZxZu9jmSV9v3DRrDQ/OenVY=;
 b=IIOwMT/ryMEsllMuOrhhKlF6NaxFd3jcCJwD85iFm6/Dt/f0C11+QF/m2oAj8OcoAV
 HBI1AbN9LWzARjrnykD5N8I2xAy/3V06UyZ1XFgc7+GDfxnICjLt94IlHzJmzofCgqi0
 5WmBViniSHDlM5a+0HOMuqFpCLKkL1yvsw0kfEFa75EhF9fxlKj1HVhxBbqElcFZVGPv
 lCDJbQ2lZaKOL40idx+ZWxvcQylnJKNpKIiJqZqs22fmHxxRipbbmG+HXiRui3QONOSO
 RxjvyVg6BAgmx94D97U4uyHaXNR9hs3JfJwaJ+ejdpzYrbTfC1l4qsY+HKsqK5x27I/6
 6w6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxcf+7uWib7VGcyU4NSwzI3F5UEUOuetDK5yeSx4dgDVNHX0I7f1ci0AkEqEJk7Vh9SGfcz1xScip3tYpATIEXRNlhlf4=
X-Gm-Message-State: AOJu0YyUYyKNMU0JZcv9IBop9p4B4Hgl8UrVE443vUH058UVYjvTa+PH
 FF1AZhwMFlBAhtOAs8uQFlGiiodDZbL7NK8oORU7/y+9aF2w7N87KVlcJQ/DPAs=
X-Google-Smtp-Source: AGHT+IHsBJk8qM+U/qH7tC4q4EYjQGUeHTnhgmyAaCRaDz8b2wS9pzILyHsUgh0pce2JfpsyHWrmjw==
X-Received: by 2002:a17:902:e5cb:b0:1fb:9471:84b5 with SMTP id
 d9443c01a7336-1fbb6d4df2cmr77549705ad.37.1720737095072; 
 Thu, 11 Jul 2024 15:31:35 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:34 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:07 -0700
Subject: [PATCH v8 04/13] target/riscv: Add cycle & instret privilege mode
 filtering definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-4-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x635.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


