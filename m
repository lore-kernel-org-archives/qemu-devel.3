Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667EDD2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchx-0002q5-6n; Tue, 27 Jan 2026 01:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchv-0002pw-KX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchu-0006ih-93
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:47 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso49461515ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495865; x=1770100665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PAMSHiK5VxvAyBb7t1SnwzGu3eBjt9q5jInjPFmz0c=;
 b=ZjTYRrlOa2AskOi9jbDjW5XhzgYmTD/d843Ktgkf+1xbwGlEZtM6WcEtrc/cW/g5Cg
 qaKOua5WRoRVOt9TooVaDip+uVB9i1uytU1o0aC8arffjAcb1DOTujoj/mNeaMxDEQ/P
 erHKXs2N+gROBuVwCxywWy1d1bJIWPF6+0vSMuc7TYceIV/KPsM7nca3c8RsAsnM1A02
 CFF2JyoTzzMsH/Jl0nC8MpOQt1IfWeCpm8rIPKAXwCMw5a7oIo356aygEozEo3qFp0Ym
 pT6CFebc2hfzmwPcLJ5PV0Tyivt3yfOvBFB47ZuetyzQaYODMNk+9DWpIV6DmZPMNNhG
 TKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495865; x=1770100665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0PAMSHiK5VxvAyBb7t1SnwzGu3eBjt9q5jInjPFmz0c=;
 b=VmbDJnDXsjF4670hY11yXrxxb97ggJQDtsZJwME+7sj3krpZLfqr70xGjMQ4Wr6Itx
 IQsxWGiX1lKHoAGH4golf1iJ30/MU8X18v/qeyoRdaKBah3ZKyCERA4u5hluyGAQwS6c
 IK6jf2fQ0GkCpUa8cotU94TChSo6UOgYnr8lJUW1n25kc3bQT+zqSMVR2n25gcPO8b0p
 X+u1+wUp7OQBSm0ppoLZiXaqRazOOkKB/Y2suGoTHiIiF4Aqa2oeqqxx8sCQ7OLimilx
 1LU7jq8XONN+OwymdgD+Ei7M477Ow3P3FpNH45KGEo1jsqvKH1Oi134KzubGCq/CQr+u
 WkWw==
X-Gm-Message-State: AOJu0YxBbxwNCaumWjWdt6+mEyIJYLC6lBN1UNxOPTiGhebRrMsblo8z
 DuAuO3+RlGH8mpTpv8x6rRkn7MUsiQPn499TMrutGIqn8JjngPYXpJAa1TbwSFtzrCtXW4YJc5o
 C6bP4QD2o8aLEQHhDDB7t5iFZeNTRJgtgNcAXF/o2FqqIIWBzkyPCXUZs1uxSESuuIunN0bjXyl
 5BTygl/+M+79o2uDHxysM4B/LWWEeDAEwOtua6wL+0Ow==
X-Gm-Gg: AZuq6aIgArYo52HO8nH0lUY44sGrq3PYq4LYmAYRbfGPweUlr4j2wXGuQm4gm3e0oRn
 SMIRlXJmkEzepGPmk1HDFTfq3p03jXo7lONtJLophyXbyZoZg4gIZGwWbc3Dfaqq2tiYH7dwTpi
 dEixXMi/acZqXrrKyzIwdO1qBW3O95bh9//8+Bh2aqQq75xmgHi/tSUvTMrsRAtsd7RBkIH0dF6
 /+KSuWoytD14FLNvZ6XeVG9/cGzTh+fD2We5eT1L+xHZVykTitsexGwdRWOuAmjjaA5wMgmoGRu
 mrGiD7ca54nz0Ctcd3SkX63JxGt0b4YuOf/rfBDKl/0YPaam1XlA0FK+CsrgFuT3VM+twplQ+Dg
 loyFfTup0jrjUUKTo8v2zeXsMTzCWhrvzn2l5ah9Q5ZlYmojJmXzkt2rPyUQsEjlxUUk3VLaY5t
 cI9NWKXkPqG+W+820M28JRxMzk4wUAeNokQYkXPkQ9KOIg/g5rAj+KIrj2DmDGXyEr13bHgywO+
 zsjWMbTjzxtxeo=
X-Received: by 2002:a17:903:4b0c:b0:2a7:80bf:312e with SMTP id
 d9443c01a7336-2a870dbbb84mr8282765ad.28.1769495864606; 
 Mon, 26 Jan 2026 22:37:44 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:44 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 06/17] target/riscv: Add implied rules for Zvfofp8min
 extension
Date: Tue, 27 Jan 2026 14:37:12 +0800
Message-ID: <20260127063723.442734-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
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


