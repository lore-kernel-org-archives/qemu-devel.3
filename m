Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C90DD1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlL-0000w6-2t; Thu, 08 Jan 2026 10:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlJ-0000uu-6y
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:21 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlH-0003Qd-NB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:20 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so3102240b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885438; x=1768490238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7wCa0YXDG1WZGTAd5yQcAdLDTV1ISPY3aUEnnKDKJs=;
 b=A2xvjh3JNT6de/B12WDTSXYQOY7QXkc4JipqwVlaN9iTTk0HEzx5p8b/PxiZd13BkE
 ZGFoo+tCJXHvQ1aWJnqwhdNaa3YJZt9erWrMu33c45+DyCgBn7F/+3q2hDjXrXCDx7Wj
 +dvJUeesv1N4qxRmdAlzinu441SXVKNu2QUcpDujaZ6J4FmIrxymxMOI2KTQV918ljHT
 uWZL/tbW5b43SNh5j0T5pAWyYUoDMwGYiO3Mbw7d8ENG3R3CIqnj0NKBGViRESW0l8cq
 vVEbk2Ku67qYB82dXnWwKSskhNmWW5zBnzDGZkxhTNXPRr9asbbdeAWlJRkhfT3TnTCz
 quZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885438; x=1768490238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r7wCa0YXDG1WZGTAd5yQcAdLDTV1ISPY3aUEnnKDKJs=;
 b=K1M5CB/TFV2lIzEortAohzN9L2K0vxDrCNczv65a5H5PSvVYnSWf/K5x8O573E+U4J
 5UoIwv+KrsRKOHEnZFUZGYSUXDtdPZkFong2rmi5yZR8nxapJlt/pIeZ5xQLkzC0zAPJ
 0OhTgm9hTSpuWRbRb94+f8jatewIOrZSbkPqr1yyNoYud3V+ky8DMJXS5jC4Q2HPgIv6
 guviK8YxUtTWHVHTStEh7mItqIbkFk18fT9c0jTiMwuguzO+nUPQmWOVREsjOPkUZqMl
 MEXbwVQUsGNhXqQkxm4krntBDvOxDBhhY4MET1CBqRpSsCLqZhq7GHse2Y1ttv4Of0gz
 uzvA==
X-Gm-Message-State: AOJu0YyuJjs2lzoAU1B7kgu0bpQfaIeOGBrlv5FrG4r44qSEHYGk9Uo4
 1kmAp08vz8KiTWDivskmDLQ7qbdR1UZdvTl7l2Alwel6nGo4yNoheOJkShuYeVUvQJQYJP8xDcP
 GhqrV2sO79KNZN+yN6bdOt9/rWRjo6vuJdKdQjQhmoyarIJ1u3bagsP3OJHFZcz/jjJsoWMHX3H
 ON3TkMcypuHiqJnf5W10MRhudJeMuP326eDZNew48=
X-Gm-Gg: AY/fxX5RgH3gVsNRFvHV9iwqcdxg89pmfbItpMAgkYolG/mN7vA4xsbCeYkQec0hcaW
 H1iBWjdMuL7OHug4ifcPQ7+B+0cKnoy6LBXnw8vchSlbaJwnTg7+ZXzRHvFZFm/KvUPIMGhSx7m
 rS812ob22eY1pQ0HcImgzWb7OnhLz/XCKrvChQ8AfapIhfdmXH31pxk+jZF5/3cgjSvS+3iRy3T
 oR/3fd7s1U0fwRDOvp2agJMWheQiOGP48/2mtZRhPHq5mz9XK1S4NvNE5mSWY5Ih/A91iUsiL6+
 gQMGRhfjlLMj9xV5plqZJMK0Sh3BR3bGvXgO84JWjkfDuzK8+Wdgi6e7rZjynE63jFG2CuKi4fX
 1OQuHEAqokOD0arwI3WY6K1l090oVG7XvEzsl8RemiTcqz5WR41uEAeBPMv6chpZMP1rj5aaZSp
 pe88/sP4zidPdAavH2QSykHGcHtTXEJAitRFTge9fGkmlVtGQofJWOJok=
X-Google-Smtp-Source: AGHT+IGG6PAwQ2XgEISJ05CX7b0ya2Keebs0YuZrgkEkdqLxU6yzwqe5kspvk7YufKf94wmU8H6hWQ==
X-Received: by 2002:a05:6a00:e19:b0:7e8:43f5:bd18 with SMTP id
 d2e1a72fcca58-81b7f3f1ff7mr5796620b3a.45.1767885438156; 
 Thu, 08 Jan 2026 07:17:18 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:17 -0800 (PST)
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
Subject: [PATCH 07/18] target/riscv: Add implied rules for Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:38 +0800
Message-ID: <20260108151650.16329-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
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

Add implied rules to enable the implied extensions of Zvfofp8min
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b4b10b52d8..53b5aeb9b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2513,6 +2513,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp8min),
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
@@ -2650,7 +2659,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
+    &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
-- 
2.43.7


