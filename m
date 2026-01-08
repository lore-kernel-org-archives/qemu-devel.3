Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F453D1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrmU-0001ve-Vz; Thu, 08 Jan 2026 10:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrli-000197-2F
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:46 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlg-0003ho-IW
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:45 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso2402614b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885463; x=1768490263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OstMPI/h+uk1U6Kh39t8Ott75csp0bQMtJ3rPEB+Wdo=;
 b=ijYhj0aFMZwQvnLM/r1cCbHCkdLYDuoHVJ2ueqGo80axJk/GVIksEqjdN851Rm/5xb
 IQuuEg2T9CLobIjWrFWi+hpKPSKUT2sB6Pei4RH4hvEN9nNgeQJGLc7zCY6YFtKADNdF
 e3ha0ZeWIDCJePcGgzMu/5LhV4AHrITmyRCTKscKiwJGzUFn10wV2wuxoh6GQ2neIZmR
 VOAwv2/kSKSK7VzAOy1H9Yy9uiEGz4uB6eLuzzRVQu8ovBueEJVLZYQBa8tpCiqTBAan
 XjwdbQ+Nsw9V+2zy0K4tIx/hdaFm4rJpxcZgQJOS3c1qS76jY4rRblwGNsq8Aa1/3psC
 UMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885463; x=1768490263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OstMPI/h+uk1U6Kh39t8Ott75csp0bQMtJ3rPEB+Wdo=;
 b=lZcBiznAarjblzPvHkABJx9P1JyRLk4YOS+iazlmG/7w6n52C5rXXoJIN+A5uMtIlN
 7AkuggBLFg66p8FSWwLuj/hKUA27VN+mjhQMxuXgd73H/0y8ZgOE4wm3pmheOLoI15Rc
 aHLwsgu0Szajr4g9qeV3VrKodkeAT+gGPtH54lbjRUyt2Z3l2W4g7u/RJsgf9bqEa3ss
 Ykv+cdemiYiXuNKMcDDG3GaXZ8F87XrC3+DIMWoaqs4BA27UyxemQex0HaeueYuC8QCN
 0OBDNKj3nb9XkwXISdGhUE588JbHNXU+0GPYYODac1evsOAzF1YK02PEz5AgSPyivXoR
 ddaw==
X-Gm-Message-State: AOJu0YxfMFccRCO3zexTKNbkCnYTfR6EZ1mx+pEBe492JLxD6Aq5ysCd
 v9X6n6WRLZMwKM5AWN7YwZOog+0m8MhEscY1TBNvhdJbZwTvfB8cCWItx90SVaRomVLIgdUT+Te
 e12FI0A8V8qWMx6VbmZlTrNyDVe9de5ihER+tXLb2/F0o54b0qu32W4cPOioLadr1tuEGILGVHX
 w9374vi6HgCFN15XqD/EuX1Q9WB2eZTYyIQdmiSZw=
X-Gm-Gg: AY/fxX5gXp8rzgGMoqd/jJuS6nWVqqQ7xF+Sd9ptFNgAhVma77VQiSgrrzPanFrNjRW
 A8dl2CuWV5xnHRFy3NIKlYp/+U0Hv8TCXYjJeutID6Wbg2h89HUjim0uo57119F+qMm2dCmu4yl
 wFSiAztWqi22jwK6rHNEsUk6j4hSB+oiT+55ne75KiElCT9S8ydANsDIulwJKkhzfIVjZGg0KTI
 Sre9HnCeh3vrLulPs6Esuw8R7A+v8FPscGX62T8KREPVU6MM34E65+j/YP9V1kOG67RPPvEy1lR
 P38ZHv3/DwvpL/uXt1r8HoGd6gBGrxOLkSGhOwvoDPoWE+806EAkY8fRu7ABU1P2zURIEQDQdwo
 vWX5cp+g9Z8qTBCaBtCovb/VR+LngEsfSDBUTNLyFfVd5pvwgTA8p5w8GcrwQD0t1kv4nHTpQKX
 04p5S9Mh9uPQ6GBBEiY1Oyu5/nL1e0r9UzK27t0mdz3Kh8meK8t11sB2g=
X-Google-Smtp-Source: AGHT+IGAWXKTVLCGV2cgP6GXeMpT36rzH+UtA/2TLx3c5kyW3/RiuZ/XUnJDQ4EqS7jTl5Uay6l1Jw==
X-Received: by 2002:a05:6a00:a383:b0:81c:717b:9d35 with SMTP id
 d2e1a72fcca58-81c717ba5bamr3536690b3a.28.1767885463090; 
 Thu, 08 Jan 2026 07:17:43 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:42 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 15/18] target/riscv: Add implied rules for Zvfofp4min extension
Date: Thu,  8 Jan 2026 23:16:46 +0800
Message-ID: <20260108151650.16329-16-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
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

Add implied rules to enable the implied extensions of Zvfofp4min
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9d4fc3ab6b..ec1bf8034f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2526,6 +2526,15 @@ static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP4MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp4min),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -2663,7 +2672,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP4MIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
     &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.43.7


