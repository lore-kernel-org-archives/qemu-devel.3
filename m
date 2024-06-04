Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FD5C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZE-00077G-Bv; Tue, 04 Jun 2024 02:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZC-00076R-Jh
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:42 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZB-0006eb-3j
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:42 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c199abdbcbso3946240a91.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717482159; x=1718086959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWoDV3REDaOyIBoAP9q8U9FNjihkn4BpMGlDg6HC1JE=;
 b=hEk3bReEZpV5HPCV9oXY3Pcf2O2bEZYcmNWeO1kdMo9wbyg3s1twWguXTXfGQY6CXi
 vxNeUYDgBCkXxsqga0n0DpN8T0BgeglQsW/IMI1ZNy2AHVpzYQPskzbxSaKaZO/G+bBq
 h4NEe1HgkOYQAI2fcyL/q4cPPBnwMQhW1rS57/DnxlIfAGeiV1aNO8HS7DrPDnlgwG9c
 8r/IVKQQGlE7UxpzEIgy6atji8FaMlF1JmYuGFkqVimnmBrBmwmNknCbajLo/bbF4ntx
 ORGZNMrZFN1cbaFx3GVrn2nLajUC1RPkx7RgqfMlc9ZypapXjUQiAAN+wYQoOsojFOEY
 E8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482159; x=1718086959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWoDV3REDaOyIBoAP9q8U9FNjihkn4BpMGlDg6HC1JE=;
 b=VxNIaY7FXHzf7cqXaKassacNueYHVZF+9kqxTm+0cJlyFjbjsOJGUbEytjvftNtAVl
 uwEoSxH6zsBJLvbcrdrBFPKt+17q9cRnMyuJ7AqMWLXVMlrZEmXpiffGsWrW07Q6tQtp
 0sIvrtkiAd222N1x2mhRheklX5xW5FFCZtsZ52zLHhRowTJedD1vgIzahjhbrXAv3I7A
 B6dzu9u+QEuFidw3sXdmyl34gfVpdHIY0nf82RuMaEseH69P/up766+doe2BU4Sg0K/V
 W+Ie8xswJ4+hzZmp5ZWpRkFmxALbjbkaDBr9BmhUGG+uqEdfX39gbYwhCuCVekZp2g3x
 JXyw==
X-Gm-Message-State: AOJu0YyWuiLe/hPLgWui6z17eOfPhhiB+Ho5D6EDo6MY0eJNjOPS/n8o
 R4RofTXluGcxrDUGZN4k+8UQ/EvzgPSEbvlmMS4kvPU0IXuMKuTUanqRIBm6W5QeJfbShbJUZwi
 4S9epPhIDAv9xRB2Ekdx87V1AH/PSanK0aHytHRyRYmxGfXdmkoNxKTJKHSrgzhDSJaJueQyzX9
 j29N7F0C+MH06/SmSSCsxpnrBePpfVM2+P/uI=
X-Google-Smtp-Source: AGHT+IHFdZbIwWRb1HWC0iWFwceFrDTj7B1AoQU2iw3sv7QIpHOTxVla6tLXsaRI0Ei+JyVFgHmvag==
X-Received: by 2002:a17:90a:eb88:b0:2b1:b1a1:1310 with SMTP id
 98e67ed59e1d1-2c1dc590931mr9539035a91.29.1717482159170; 
 Mon, 03 Jun 2024 23:22:39 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1dcb56014sm7115617a91.25.2024.06.03.23.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:22:38 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 2/6] target/riscv: Define macros and variables for ss1p13
Date: Tue,  4 Jun 2024 14:27:43 +0800
Message-Id: <20240604062747.9212-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604062747.9212-1-fea.wang@sifive.com>
References: <20240604062747.9212-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=fea.wang@sifive.com; helo=mail-pj1-x1031.google.com
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

Add macros and variables for RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.h     | 4 +++-
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 94600b91fa..4d73486ea2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
 #define PRIV_VER_1_12_0_STR "v1.12.0"
+#define PRIV_VER_1_13_0_STR "v1.13.0"
 enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
     PRIV_VERSION_1_12_0,
+    PRIV_VERSION_1_13_0,
 
-    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
+    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e1e4f32698..fb7eebde52 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,6 +136,7 @@ struct RISCVCPUConfig {
      * TCG always implement/can't be user disabled,
      * based on spec version.
      */
+    bool has_priv_1_13;
     bool has_priv_1_12;
     bool has_priv_1_11;
 
-- 
2.34.1


