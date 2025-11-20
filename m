Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071DCCF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4Fe-0008JZ-So; Thu, 20 Nov 2025 07:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4Fb-0008J9-UT
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:59:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4FY-0006Jv-Nr
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:59:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so8807895e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763643539; x=1764248339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=OebhfLYaHxJEKsgVIjzo+BWpmy+zPozqpzFN+N+b7GeOX+5gDFLvXoEtZD0VIOjGaR
 WnJcQUELIYfaTMueSiHTN8RqfofHSWdoNlvWUZ72y3B42JHMnsrobeFCgQ7XuD31iIOh
 d1iHuY2hz/WljgxiMV4vaPQxVecyozEh/2093yciagA0XZo9n7EB/05XranpEE+WzvfC
 Dj/aKtU52yWJcMWiprIHZj2igbC6oVHf0vzq0Ld34pPn/JUhuclv2DrznSceMS8dYwvX
 xx+HqNNpVhcL/H3BgHjMIGmOTm49XWGL8FQ2ENJ70JnhQTq/E3TBFwTJWWnxJ+KDeqpe
 EPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763643539; x=1764248339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=B+8ReT3nP5AyQvgROzpwbvyP/vI+tNGvuoZZwAn29XGmvc699c20cCwal/ItAQ1IrW
 lzhBeDnRzaraPIQLxcGyFb0GNU1Tu/Zc7BNBSZkR1HaRbXY5RFTAYCuj+H69z0maxMXp
 oEyLvBZnDd33f2l6S6leRGGDkkTussGzbmBKvHbRtT1yM6/SeVqT+VtZoh0+yFiEoQ3Z
 F9P3DVez1ktj/KTdbmdyscMxvlC+Vga+n1tmLwsLAcOQ4+jMlLqpoB4EbMRm8HLQ0lz/
 smzBSYRMcYpCFsketpcnpgORGY69gj/exCxYf82ibbVcYbyOGIrdr+b7yhxd1nwbeI7e
 i5fw==
X-Gm-Message-State: AOJu0YxjvCzzNC1Z7Un9mek31sOD85TqNl6DsEh955Jojf6wuXW6VpYX
 pUXCw8moY13e4DWHBnNBPKVF3C7vtlZqvAk4LKM8eVMJdMkISDyR9L4YUNfanmYU+c1UfUsVbdC
 HVfBDV2Q=
X-Gm-Gg: ASbGncv7Kn8w5vMzavTZ4QNeAiEO0iByfbPoeve6O+T3UT84kmwqfpi7IdjIlbSuN9+
 q5xs5fS/OIEAwaNLBNG9fkMbF62Vk+Gfv2alpdtpthBNuRCLgOTpbVS5/3u0Vr97uqWbq+6IUIN
 7Fdf/j5Z+xaCbM3aMwdZYB0LzVv6lEQeK196OGX92tAyYt8z8hqmkfjQm9JT0PlLaeXc05gccZR
 SxFtxzcJa+8p2R7cXhAtHYi7yzP313T4Y8ArME/r0X3Y7MMgJ8ue17YHt+cwasFQsmHruQv7E5u
 5oqbXIjgsZRnxrqB0CMgLpkcQ3mmgGIdR08ODeitiht8Q+yT1iNIMgOuk+WnYUUig80NYWO/34i
 dUVP8HMYDkxvnezYeTScvvFm4UaRg5TG+9Tr+DxMGV9/q8a5IPe/RHPhNhzi0lECg1ftwuJu/nv
 J+DFrtBIUkeUE0
X-Google-Smtp-Source: AGHT+IGTwDVQoT7mM3aRvhCrZj7yqdNtffNPWSyZ+e9AG9g2XgcW98WThY+QRfpyS5a8Mv18Hp1dPg==
X-Received: by 2002:a05:600c:4694:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-477b8954873mr25015895e9.6.1763643538827; 
 Thu, 20 Nov 2025 04:58:58 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:1328:3324:f0af:9332])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b831421fsm46082145e9.10.2025.11.20.04.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 04:58:58 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 1/3] target/arm: Enable ID_AA64MMFR4_EL1 register.
Date: Thu, 20 Nov 2025 12:54:14 +0000
Message-ID: <20251120125833.123813-2-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120125833.123813-1-jim.macarthur@linaro.org>
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..c20334fa65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0


