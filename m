Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FD4C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5h6-0004Vv-IT; Mon, 03 Jun 2024 07:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5h2-0004JX-EU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gx-0006FA-Vp
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so13613065ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413448; x=1718018248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISj/DJX6sVw1fF9xt8oQxJPLcdsC6nSxbO5ABU6lBG8=;
 b=cAM7R3b9MvorXxdy4nhsejvYytTFOip0fJI1uiMGavsWuvWjnbOMFAce8iD7H8igB1
 sH13fKLM5vnR+5ts1yuTsKgUDqeXdzGYIugwl8U133rFoWZcmR5w/LvlUXUG6yxQcJhk
 YwOaD7x9A5JOP4RtdM+N49E7rYOb1imKnq5XuuNH1Mh6Q9jUcq3eOozUqeAMFwwpDyxU
 +b5WWeYJlyEKjt/ODJd8axE4s2J2+Xb6dGa5w1ijKXbuVBrsvhgVuRP5QgIWN04cEUd2
 3LqVREMczoGSC6HphOXdIe2xYaUV7VBSyuKW/FX87cZfpV+qiRNaWs87pXushE5td+zD
 BkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413448; x=1718018248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISj/DJX6sVw1fF9xt8oQxJPLcdsC6nSxbO5ABU6lBG8=;
 b=v+x7u7kZGf0nnADA4WEsDZIklUyUiPHoqxDKOXsNMFOw6pjpHB4u1cuSo+jPfHv4hI
 ZTO2x7U6n2VaROzezBaJjWpNztFa+5iWDgwWthE8vQMPbH7Yetioh8vNg5cwsrXZj3II
 RgZtIlE82btfW6/IICxmAxJ6psgeQMnv13OHTRmcKk02uOjPeMWz22njP2qyuvnvFflX
 VcgSOk+HcNftcEsTP1f1CnaCs1mojxaEmwv5GvHkqXuNPQKTA8FlXILdOHj3pkpVj52i
 LBNniaeQcsZPOdHT0nPKuYb27Y/K6b4+05gxkGuv8XPGbi/8zAbweLd7G01rQuV158qU
 Wqkw==
X-Gm-Message-State: AOJu0Yx1DuVYHiFcqZxn8nz+e2zVnh7QbTWcY/s6fQrIDvpR88tVjFCn
 wLJBYXHZPvELXmhAX6Xp3xK+EvrRgDVEN5ubwoHjK9Y4/lYKQjHLMM7Kfw==
X-Google-Smtp-Source: AGHT+IGtrnR5/LOMf4poZjJx9NbdkH0Aq2n1hksxfgWeKyJG0+/5l8yc4cQ8+u48PRR9K75+6Gj4EA==
X-Received: by 2002:a17:902:cec1:b0:1f6:7dd7:e801 with SMTP id
 d9443c01a7336-1f67dd7e998mr26576795ad.67.1717413448512; 
 Mon, 03 Jun 2024 04:17:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 11/27] target/riscv: Add support for Zve64x extension
Date: Mon,  3 Jun 2024 21:16:27 +1000
Message-ID: <20240603111643.258712-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Jason Chien <jason.chien@sifive.com>

Add support for Zve64x extension. Enabling Zve64f enables Zve64x and
enabling Zve64x enables Zve32x according to their dependency.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2107
Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240328022343.6871-3-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 17 +++++++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index dce49050c0..e1e4f32698 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -94,6 +94,7 @@ struct RISCVCPUConfig {
     bool ext_zve32x;
     bool ext_zve64f;
     bool ext_zve64d;
+    bool ext_zve64x;
     bool ext_zvbb;
     bool ext_zvbc;
     bool ext_zvkb;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d744594cc4..a74f0eb29c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -156,6 +156,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
+    ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
@@ -1476,6 +1477,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
     MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e2cf5f429d..fedc035313 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -498,17 +498,22 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* The Zve64d extension depends on the Zve64f extension */
     if (cpu->cfg.ext_zve64d) {
+        if (!riscv_has_ext(env, RVD)) {
+            error_setg(errp, "Zve64d/V extensions require D extension");
+            return;
+        }
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64f), true);
     }
 
-    /* The Zve64f extension depends on the Zve32f extension */
+    /* The Zve64f extension depends on the Zve64x and Zve32f extensions */
     if (cpu->cfg.ext_zve64f) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64x), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32f), true);
     }
 
-    if (cpu->cfg.ext_zve64d && !riscv_has_ext(env, RVD)) {
-        error_setg(errp, "Zve64d/V extensions require D extension");
-        return;
+    /* The Zve64x extension depends on the Zve32x extension */
+    if (cpu->cfg.ext_zve64x) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
     }
 
     /* The Zve32f extension depends on the Zve32x extension */
@@ -670,10 +675,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64f) {
+    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
         error_setg(
             errp,
-            "Zvbc and Zvknhb extensions require V or Zve64{f,d} extensions");
+            "Zvbc and Zvknhb extensions require V or Zve64x extensions");
         return;
     }
 
-- 
2.45.1


