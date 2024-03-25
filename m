Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89AEC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rofmb-00046t-QL; Mon, 25 Mar 2024 04:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmZ-000400-RY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:34:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmY-0004IW-4s
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:34:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e0511a4383so28492615ad.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711355651; x=1711960451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LARwlzsTr4ldj+8MRUTX5TBzI1AqrTCdeZ6xoCBGfdc=;
 b=djvxxrlCnfrRP2Tgx17xytXq6LTlKO0Yw7kT6gBLYgiDWQFspBYA4d4Mv3o6F5uMis
 RWmely4T8Wdi2hGt+cLPtfi6k94ZwV1kV5BHhGXWmYkH4bRX0IdMU0eeyhamtU9mEaFU
 KREJDQrdPq/3kgGKhS9kXX/bauLhuQG+ioL7Qm1cTToeVsWtaTJ3Fr3j3gaCArx0Opj8
 mGsljRlAxRlNMd26jFxV+qfm2D3DbVfQ3mtFotXsR6W+5IqOVZe7JOdxQiHiJyBwIlJc
 ppRvr3aYjh96jvovyC8onxpKbb+X7FM9W1QxV8p56hYjP6Ox5kN38M8c5QYE+aoHQauH
 V5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711355651; x=1711960451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LARwlzsTr4ldj+8MRUTX5TBzI1AqrTCdeZ6xoCBGfdc=;
 b=SUBv7E6pwBWQWAVk/jfJLLKFjLoZeSZx+O6B4N2srsS68ch4HihvOA65xyTZfvcXiZ
 gHrXnLEYWU54JpJD+mhXc5L0c+vf+PDCP/6ZBNPSUxkb8Ob90RBqTj3XPhHIA6YaAUxb
 frBii+MGhJ8tZ09C8Hpz4r+disv1eg9LiKJcP9sTrcxn7dkS6bzLnUpe6JysFnFc8VcW
 4yS6+83UQYqV20y9TOlECnmu9HjJp+ZVWgyOX2Es/J0KFPAD5D+oa+k+wkoZR6cgt89U
 2/NcTocD0agUWmWXpCe8m/L458PyJXArrHfFXG9UMdYl2tS6esjdvFWhTst5pxBuTjHJ
 6BHA==
X-Gm-Message-State: AOJu0YwVA8zivnhhuExw8viRbhhQ15qa5DK8B8PyIDYNJVq23VSk9xBh
 lgwGNrDVYGFRtZ/kWUnhWx6G3UWX9ZERdhne5RJLQFjmqv1GFsNH2GAgdh6dTvve1Pg/xRqX3yi
 e+G3zN3fPRY7h44b95CObQtXmv8ItuzA9U4HJPU63AeA2H1AQkodfJP8QT7c7WC9iM64ekoxqkF
 +H1KbhY/PWve31xyKEWcgZINsC365KtZAOUrq0Tvw=
X-Google-Smtp-Source: AGHT+IHv8/RVEphAY6nvIwsFXW5/Q5khAbnFRSmCDfT2FAANgyDcGw0MBNVQnCFryjjwn3ksCWke8w==
X-Received: by 2002:a17:903:2308:b0:1e0:b8df:1083 with SMTP id
 d8-20020a170903230800b001e0b8df1083mr2696376plh.0.1711355651361; 
 Mon, 25 Mar 2024 01:34:11 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b001e0287592c4sm4311269pln.267.2024.03.25.01.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:34:10 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 3/5] target/riscv: Add support for Zve64x extension
Date: Mon, 25 Mar 2024 16:33:37 +0800
Message-ID: <20240325083346.16656-4-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325083346.16656-1-jason.chien@sifive.com>
References: <20240325083346.16656-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add support for Zve64x extension. Enabling Zve64f enables Zve64x and
enabling Zve64x enables Zve32x according to their dependency.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 17 +++++++++++------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6bd8798bb5..f6287bf892 100644
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
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ff0d485e7f..4ebebebe09 100644
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
2.43.2


