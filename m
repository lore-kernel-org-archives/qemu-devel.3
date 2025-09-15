Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9182ACAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4mD-0007cz-M1; Mon, 15 Sep 2025 04:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lt-0007Wy-Sm
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:17 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lg-0002PC-Vw
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:11 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b4e84a61055so2524976a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925656; x=1758530456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhMmTfFoDwvXS9pekfyE6D9LZ1tYlMgaaUM52Ww6Wx0=;
 b=J2w4lMje8rJJpg7HdFyn+w7y7z77xYCoG7kWHiaam11sGLGOCzf7/8W2YzptdOm+0K
 JDmdOED7ZVN1HEGEUGIBSXgjKd01QYh0yf2j1Gn5G1byOnKbudR0B/yAHGkhW0m2fGWf
 STot+LcA7libLspLQ3+p4Vx7HGn5poYxDvp6oZIwmg3faXjhqcLBtUb0uowCCZBEWRlw
 3ha19Y2ekxrZ/jqZFwkZZr58H5vvFnXjphOA6E/X9lzPwXAe9Yp+NNubQUSrUSQycnlu
 u+Kwd6vhbmMuHHYweNQaAP+IYveoXG4Bldk5Y5OLdMbppqSItLJpktlX7O9JWq0l/JwM
 pdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925656; x=1758530456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhMmTfFoDwvXS9pekfyE6D9LZ1tYlMgaaUM52Ww6Wx0=;
 b=Wyk0MYGXXkAeby4gNVaADQvb0M9ROn9qJt+XSVmt1O753icd6mSMsy1FfYpO/AS2vF
 MY2vml3kYdDEE7B11fE6nuWgG2x01DV5t2iAH4Si3oyY2wRGAT3VM1kR7HVlEzB2hTAS
 LCcJ3TgpLPDJi4Gmh+VMbAvz+mcrUHVRL0cxtBMkioUsimjDMDELJltTfstLF/7ko6SB
 Wp6f/21jXJqiaVJ/JQ3crA2fmgM6xlqKKgDxFB9W4kifMxyB18wZxYBzKjepefdwtHzF
 iAFHYSpPM/lYe0T1QddLZRSS6jZz6LNeNiU1lfb/94/3aMQwGBPURbFrT3iNTvHp13vO
 HR0A==
X-Gm-Message-State: AOJu0Yzlysk++wS9vGACErDS3IWj+FoUQuRXLz3VTsqj4ZDp7Uv+36jn
 WfgmhKRjXEQs2PQx9CTJvVRCNHTz4PWtWB6blkkhlVyyRejLFNRezVf3iy/v+Hrx/tu1H8nhYiv
 Bt1GrsCDQocCqt8hzqat9GMWA3MPbMNueNCu6JaTVq/xWvAQ6J5gqYmMxRdu467hsoyCW2jUTFD
 NtHeqxYouHG3D7USSPvmPiQZ0ErBj7lc2NUQQH0Gjtww==
X-Gm-Gg: ASbGncuyu65Ub4aUpNSf9jbpcS8DCbh5JThEmvFr9hQDyb2QUW89QQGJefzBAV2xNTq
 7FT8XNFnsHeHh2U7oOhe+F/7M+Fr7SrW/RGlwMb67SfVmMx6ok/3QPnnnKI7H4NUz6y3kcpj3/W
 E1wLz6f9q0HGZ3ZChfsZR62P4PkLBzI4Y0tmMw6XABs5qPzDQIFJjqaHLO+VKYOzl3qr79McNSi
 /W+/biimYFL2kx1YPGFmb9dMeRUZgSkQw9XqvXUzLx0uiC31eyhZQyB4Q9gl5HJsrvlVh7XA6l6
 JmT+nL+6gsUaxgy16S6cr282Vs2TP80gK979LTuL3PVyLNE3mV1NYo7suuqON19ue9pkPceFOAH
 4wtsudnGa4NCWgQJnjX/69r/mummspYRFwFIdt7Pch/PZY1NqtLr17QdRAWa9rN1eBhes3YfRmc
 CHOw==
X-Google-Smtp-Source: AGHT+IGxyaYJmgKRu2cjfCccFrzO9nyEurzrGCCFFP3MJMvf6j3jS2v+mkqbjKVpqgcb0Y/nYhXchw==
X-Received: by 2002:a17:903:38cf:b0:25d:df7a:b1a4 with SMTP id
 d9443c01a7336-25ddf7ab55dmr142643985ad.12.1757925655716; 
 Mon, 15 Sep 2025 01:40:55 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:40:55 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 2/8] target/riscv: Add the Zvfbfa extension implied rule
Date: Mon, 15 Sep 2025 16:40:30 +0800
Message-ID: <20250915084037.1816893-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fc0614dadba..b5c9f9ac586 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2576,6 +2576,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2589,8 +2598,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
     &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
-    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.43.0


