Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543DBC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjNE-0001Oz-KO; Thu, 14 Mar 2024 07:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMu-0001LL-Jp
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMs-0007Hb-1R
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6c9f6e654so135985b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710416118; x=1711020918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/UVv186fpZCEdDyDvMRnwoJ+6yboSsZXzEVi9CaxYI=;
 b=lqcXK51NxIlbLxPHDFo/NQF0foSHQj2S5Be9348GWgnviEMmLCi+Wh+wgr3dwduU6I
 gScZ+Hf5xyJdx/WMopoFgqS81XPojUb8gJ76MTbaU9xUhxCaGoXS5Bnbkhdao/JY3Pro
 riDM1vcZa0CX7hlcUxUDfKuxyxDo8Nu3ibWRKRieuNwRai59KkThFOn0vS8yzj5wjmU8
 707Fpxw2iYbhMAdYeBPjZ6eonB61XSZQxpsKnXC8xEDOjHZOkhGBaSCgVWpbD7W/H3Xl
 Q2RrFSsOFo1Ey34jzljsL1TNvY72ecBaNnQaAGlI9lU1mXoazHyqhNyVec2v9oGqaTUL
 BsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710416118; x=1711020918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/UVv186fpZCEdDyDvMRnwoJ+6yboSsZXzEVi9CaxYI=;
 b=OaGSEiTsvq1PwuJpeKv4iVTyR2W1dJ+0w+oZ3CS2lnpdiDM5DI8N0IBLasOSG0U1l6
 dWnGwg7wWe6ipr9eP4KXVz8vqQQs3iNkLJxL+OIf9oBxAQgGqU//4vjghWmtKk9IUPBE
 IgodiRagWCsdmKr98SHkfNCgMRHOXmBk3AbmtOd/R7Sfn5eaP1XEWqgopIl1mCFD+OT9
 uFaEEhPyRjmGM0Lml5vJ4UKomn7zkw2APrGGajiRR1m6JeSWvt9Hbu2h6BulhxmJOmSe
 XL/Zm1Qf0AJCYNuoO5Cr245FitFgwSblQE4pW7lCjFFCbZphaN7XphbuS+aPkKk9u8HR
 CXzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpYjJtOvw2fUtypPfUqoRQQQwY/em18g0SyfJve6mNyPVCOmsJXtluWoH3u7OX/dtdGsRKf6MJfhyxYUjGNQrw+/ELLfI=
X-Gm-Message-State: AOJu0Yyu+r23y8K1hCLDYpi0QyEcvkAitmExtVBDm2NRBHFXayxBrmSv
 GB6ckUCSmJ63Htdcnp7b/s4Nl1vuQ6xQn9WP5gMaL+yYqAlqv0GEBIBg3YrsIdc=
X-Google-Smtp-Source: AGHT+IGByuVp/nA/wgT8tnYB6zVKk+7w8r49tG/kGe8PH3xSr/FuoQkGEmV8/hWMCO0jET7jt0fXIA==
X-Received: by 2002:a05:6a20:43a9:b0:1a1:1a07:b0b3 with SMTP id
 i41-20020a056a2043a900b001a11a07b0b3mr1807777pzl.5.1710416118486; 
 Thu, 14 Mar 2024 04:35:18 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001dc6f7e794dsm1465859plg.16.2024.03.14.04.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 04:35:18 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v6 2/3] target/riscv: Expose sdtrig ISA extension
Date: Thu, 14 Mar 2024 17:05:09 +0530
Message-Id: <20240314113510.477862-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314113510.477862-1-hchauhan@ventanamicro.com>
References: <20240314113510.477862-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x429.google.com
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

This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
The sdtrig extension may or may not be implemented in a system. Therefore, the
           -cpu rv64,sdtrig=<true/false>
option can be used to dynamically turn sdtrig extension on or off.

Since, the sdtrig ISA extension is a superset of debug specification, disable
the debug property when sdtrig is enabled. A warning is printed when this is
done.

By default, the sdtrig extension is disabled and debug property enabled as usual.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2602aae9f5..66c91fffd6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1008,6 +1009,11 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
+    if (!cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
+        warn_report("Enabling 'debug' since 'sdtrig' is enabled.");
+        cpu->cfg.debug = true;
+    }
+
     if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
@@ -1480,6 +1486,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.34.1


