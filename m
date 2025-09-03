Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FD8CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn7f-000592-C8; Wed, 03 Sep 2025 09:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7d-000586-Lv
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:01:57 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7a-0000Va-Pb
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:01:57 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso4434578a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756904513; x=1757509313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wUrao0n4nWdP54HC/h+jX0z4mz8Yg3JgSDps2JrXvY=;
 b=ZNhdBP/GXQ58bOwQKroe7gQM39tsM/d6RGJJBh4Sk7Le2HRcZb050W/i8iwefQCX7l
 XVmjELH81Q8H5RW0ZoRvyQFnufPAhg4zyzrRrwaZPdoi09EieVPTrTG6kkeSHDA6Kve5
 aepke5kMYW1oahyieR3Y8aDEz8Qr2DzDrnBT25/O5p1SoVZd3w44Y5ZjCdgsgbag690P
 RPpmaC+xfx013fwhj7JHEjeXvNEBA5HpTTewM+AhG5Bgun/hCiruHjBbbdPWVVBtuctF
 pgvcPJwKHW7rAsY9xhGz4I3zuQobaIrascETsWtpuBeBGczueO5ndMcm6nVfzxjMmH9w
 srNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904513; x=1757509313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wUrao0n4nWdP54HC/h+jX0z4mz8Yg3JgSDps2JrXvY=;
 b=taA2disHtKDvMTxmRUuA9Yd2kgL5ADXydrgmiiY7cOosDce5PacRWKmkVbTNr3NlNt
 kIgDA/DMfJp/8tzSDnD3nuaHjuvAtj8M5XVJ6xSUrNcRPynR/qvIUhq6LNHiTK5nqNU/
 79WdgnKFfG4vHFHzWcsEIziVXI2hkT/b6h3MVQfG14kSCBQP2+Gmio9r5ORP76ORsjCa
 BuX/cZaGufqCJJXfgis7+v56Ns9xe6wXHdLU13gHdTz2NnSkfaC6GN7I3vng7oZfkpZ1
 urcOF2ZbSFoc32GpURXXbVbZxkFdIffmjfWQO1UiZABNWml7v2XvyEXPQ3VTXrUn6nA7
 dLEQ==
X-Gm-Message-State: AOJu0YyxEggKhp5Yzx+2JgXyR9hzHbscGKOljGYB9HQKGV8/VF5xdM7T
 q+yTbjtgNnow/e6Xu4pilsC6+mNHXOZZEC+/U2OrO8YFgKPrLPPtHQIXd6bz2tMkR7+UGSJsSVo
 2UIEV7lvJCSXPZ4458XTiLJSE6+S8C2v79cWaYUbdCwPtaNo6eTrleJXMZ+NP8heX8wACmwSHw+
 dFsAVe7ShedtOhJzzhzM+dKevqAOCDl2REEG1jQ4M6KQ==
X-Gm-Gg: ASbGnctWzKc2T1sl5yexR4U2W0Uwc0XjoWFtrxCXGU784EUiYXLe0MtQeyal/hFnVAR
 bz165RKVfuzLmTYpQXmyGP7RILfhKviho6FSnRx1QZMqeAU4OK1/gTtw1bivBkRRZN5jUWM6Fj0
 1Duxwu8PUg83ri990mX0dabXaHTVGK07o8XMiiiIh31tM/zvpwkGg4peG9USBLOk/337Sy5dS6g
 XiIDN+7IXNUBW6fu9w4Yy71UQ6FY2tJWI0DrkKdJIyTRMQ377Cp4BuuuS+QZfCGdc/VMz7+RMbj
 16gfdY6CSphrSgbEnKpPutVCdPIlROY5qRQeCY6Jkvp0r7Ex3V/OydiG6YRf3EGSiHV/ZSOUkbF
 NMveKghUGp6b908yzaVU+BA/vtuQAkx7/su5ydFJAzq/ocqDR5we0N+oqhG8r5F+ou0A=
X-Google-Smtp-Source: AGHT+IF04fZRraKA5pbdEXcMOb+/stKUasWd/5GyeJaG5rQyVc9Ol6xSj1CoEMKSDL7JQRdnbegvUw==
X-Received: by 2002:a17:90b:1848:b0:327:531b:b85c with SMTP id
 98e67ed59e1d1-328156e38b4mr22913603a91.35.1756904512427; 
 Wed, 03 Sep 2025 06:01:52 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-329e23858ecsm5472278a91.14.2025.09.03.06.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 06:01:52 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v2 1/3] target/riscv: Add Zvqdotq cfg property
Date: Wed,  3 Sep 2025 21:01:23 +0800
Message-ID: <20250903130125.1701363-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903130125.1701363-1-max.chou@sifive.com>
References: <20250903130125.1701363-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The Zvqdotq extension is the vector dot-product extension of RISC-V.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..95edd02e68 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -187,6 +187,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
+    ISA_EXT_DATA_ENTRY(zvqdotq, PRIV_VERSION_1_12_0, ext_zvqdotq),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..5da59c22d6 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -100,6 +100,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvqdotq)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb279184..7015370ab0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -767,6 +767,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvqdotq && !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Zvqdotq extension requires V or Zve* extensions");
+        return;
+    }
+
     if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
         error_setg(
             errp,
-- 
2.39.3


