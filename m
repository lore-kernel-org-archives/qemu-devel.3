Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409BDC27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDV2-0000nJ-9I; Thu, 06 Jun 2024 09:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDUz-0000mA-V7
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:49 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDUx-0008T0-Ds
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:48 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-702342c60dfso793333b3a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681786; x=1718286586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sq/U//JFw8G2FNWn5RrT6F2lqiqRwhS1p5ImKv+14uw=;
 b=OMiXhWoPcbM9H1XaIPfRY6Pxf30OXQ9NusUbGciJEL2u9eMt6ERQsrNcwyzAuk0WQN
 mjJfP+oVJ865nSsx4G/kFfpyfYCvo8k91qQL1z29BUvsvHPU/oKrqZxpl7KOHXKo/1FI
 ksmesYL9YJtKL6E44mzoHCqutpGnE05xb9bROdBv0Cf6atZ/0rjBegGgbYCt4P4BYhfZ
 ipAVTelmZWxg2rLT8NjhLO8cRNokLW6fLaC511xGDldkrRJSYUGklKYDbmQS6S+exIEY
 4UFOduzRjLAYBImpq4lj7tdi0SU9a6giXNGZTNM/O/xtOTY48DnBSKTbKSbsLwfp1TYc
 feLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681786; x=1718286586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sq/U//JFw8G2FNWn5RrT6F2lqiqRwhS1p5ImKv+14uw=;
 b=XLK3CYYhbWeZUL2xe0UbXYRdRHeqFSvnYlS9lKSWHrjlHDRFMBiMdVVK0hxTIG1Rfq
 Fpc3lVZjh/kzEsum4MmzdXp2OhRaaOb/XrSbexNlmXGrZs7m5eigj/mICPIGu/it32LX
 rP8Yo2G0vS1zc/RuBfyjZP7gE7brSMp2c+HoqjPOF0ykzp+htYKQjAtCTlfDis01MEEV
 PuMF3WUeU6FAClfgRZsw1caLuvvN9pMBj1tiBoYIvU+/D9wi5sfrw22Zr4AyUUnCogEz
 SSHf9aCdiyIHrqlLnFJvFWRjPAfxZY7BWa2l087hmuIbwsbQSZTfc6dzBgaUtqP2BWp8
 itzA==
X-Gm-Message-State: AOJu0YxVPXwioUsGLXPRtg1OqgMoAQ8P5FSSdj2LaZQ6wggW1rFvi9k4
 wf1RJsKheYxXIC2Y9TnnV+PtDMg9ZuHCtsvKcW+iAOilS00m4tp+zonDankiYn5qcWwJPTvF/mU
 3av1qaH+4MeuEFCrjaev6EtPtkcztJ6AUlAlWPQBS173FwfV3KGz/aNHhFYCwSGf7SsMsDebipN
 doyKticuIgvNArutRSQtw8dumos6fJUSzUNpQ=
X-Google-Smtp-Source: AGHT+IFauj0AgeHxujLXj00B/FWW1KHaX4OiKmSXYSD7uP9Wj6iTsdhGEz6iF+9eCkFf+3QGB4sDGQ==
X-Received: by 2002:a05:6a00:1795:b0:6ea:74d4:a01c with SMTP id
 d2e1a72fcca58-703e598df5emr6496001b3a.14.1717681785522; 
 Thu, 06 Jun 2024 06:49:45 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1150919b3a.175.2024.06.06.06.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:49:45 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 2/6] target/riscv: Define macros and variables for ss1p13
Date: Thu,  6 Jun 2024 21:54:50 +0800
Message-Id: <20240606135454.119186-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606135454.119186-1-fea.wang@sifive.com>
References: <20240606135454.119186-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42b.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 4 +++-
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b4c9e13774..90b8f1b08f 100644
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


