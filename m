Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC90BE8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHm-0007YS-4K; Wed, 04 Feb 2026 00:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHb-0007XU-Op
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:32 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHa-00080U-Cm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:31 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so5359497a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182309; x=1770787109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PAMSHiK5VxvAyBb7t1SnwzGu3eBjt9q5jInjPFmz0c=;
 b=XSCtIJHiWXpII5/aZEcncM/f5kBkJF4vWKqALqJHxMK51L3uwl3a/UeBSsoBnECeFG
 pVERnQYB2rL1Dk/viWfIUIB4ZiIGcqkNgvNOvltaJFDMEUdKMP4/iSrpySRS2TKNSwsf
 vLR4HmV4QWW338WRui+APKniU8AdmEaW5dCCYaMARc9NIwti1flDbbcGIdZkGg3hiX7z
 K8xtK1wqHynhvVGPEqNSqNQd6dm4cD3BYX57fyiCi1W4FFEiULtrocPwYnn3GKgwER0v
 TdNvFlTTIN7fbtVtU77mGyiW2ir/Z/jufSszFNYTJsyawUVZ71IBwOhek7aenWflmJQh
 0g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182309; x=1770787109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0PAMSHiK5VxvAyBb7t1SnwzGu3eBjt9q5jInjPFmz0c=;
 b=dT3L4J5HYlbo4uFrrkhZFWAGlRpXmYnRo6LCVm6LOBzQK2ugaCu6JDDJDDXoA/fawt
 byOn4uV6DjbDScojKu+wVxXOGAIREmWTgj7Y2yZmHddHRG3bf7RF70SfuVJIgJ9aKO7U
 LuDPLxOkTm6zCplbh1k5ZGSJgXNE0B3HksDdFTTWt5Tg8dCo4DbFLsRND0eTveYKIMu2
 zBjfI8Pz5W5/GeKLVS2gX/HWpsdeiUxZmORFRCUDbqdAW7AJf8/PKaGIh2nk3t6Yrr+O
 Q3Lox1WWGeC7LZEuprKqiZz3uYRQ4JE+mxHNRblzGmZzH8T+SMASIU1dFHhaxF+nv9VS
 E8EQ==
X-Gm-Message-State: AOJu0Yzum2mKIF1txT+noBmOWNb2jI0J6S+eqiiZ2tiExHSUM1XSEsdN
 TgrJYvvZIRAAs23VfchTQnYEvxI+sgrBFmhJKrz1RvWKRuQg9oAO2jOsBl1Mt7pQeWrkMw7+lLm
 oDP1RKOcKIxyFYmgXsKQO7ZWODx7NnKO7i6OVRTj38yPy/1aCbXehDPkmr0biA4o1yM9Yyh0SKV
 fz/hEvD3CBKM5d2teLJ9HTf2xdAg2t4ALpInXqTxEUijZH
X-Gm-Gg: AZuq6aI3ONRZKHwD4saRo+uuTw6nhBR7USQvA6qQeb8cb1FIYsnjpbRcoe0c9PDuBs0
 1VN5M72ggBhe1tSyoXRA/0DAYp4W7g+RTCj8x6mBPCqyNrlG353w/TOIOqhrkntQteVi6twLp+I
 yAnwFaeogsnPFYB6z+fRSbhsj4111NvwnxlXBhgAYfQ8C78lWrD7cw+71OzXvyO5/eqw204XLjb
 HBi4C1qTet09+qJhyoDVzgav7Z83YAypA/sbXEd2StRXtL5GOheBx7fzi52FvRc5xoj0bfFuMOS
 CJ5ZDfOtqOhH1Ns45seh1VVDwlK0kcZkwp2xzc9zCFIaCfauCX8lseBfPqyzF4M5+9VrZ3WSwMA
 psvSp6PIHFNBXUpyQjlUlctpLvd3r8loonBOA90/RPSBGK1Kb0VLxo3K42HtVJ4ECW30JDX/82o
 oLcEc/tXujgu6+gl4Zaom3wx4upurcuoMWlaMcYfymiDZr5Lkv3oocIa14YsTjwMpae9fxunsp7
 sM1gjzgrFUcLp0=
X-Received: by 2002:a17:90a:e7c5:b0:343:66e2:5f9b with SMTP id
 98e67ed59e1d1-3548718cec9mr1570053a91.24.1770182308803; 
 Tue, 03 Feb 2026 21:18:28 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:28 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 08/19] target/riscv: Add implied rules for Zvfofp8min
 extension
Date: Wed,  4 Feb 2026 13:17:44 +0800
Message-ID: <20260204051756.667397-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d6ce51ef5e..36fddce5bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2507,6 +2507,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
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
@@ -2635,8 +2644,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
+    &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
-- 
2.52.0


