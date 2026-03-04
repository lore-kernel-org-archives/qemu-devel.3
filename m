Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5257CEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTn-0007lV-US; Wed, 04 Mar 2026 08:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSn-000753-7l
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:36 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSk-0005GB-GR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:32 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-827390e8a3cso4441504b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631629; x=1773236429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEStfTYF6dMKGYdU7+74hxiaVaOWeU/uihc0yMQ82GY=;
 b=Cpl0oo7Q+zsbV52O4dkIUduq3SmOVBll8beItQhITSQMoHX7ziqyv9JmvVUzrBguae
 N47G5yAV7qcobkR+1boqDgaORCgS40ICMbgYlHhyaEvPBEEpKfQ4XB2VDRS+Q5aR1p3B
 gSFOC4YMgV9IMgNnpZbnvjwdOa6685t8wXrCRSyY3OYjQQid/D6qVv0UsHUfRnb137cu
 9c0UV+tbj4j9C5e/Wp3eJjCkhL7ZtYnsqQfViQSleLHQqD/K3+vTAfameEn7oYSfdqN6
 cVG9lelWQGLFFDvhB4NFrfM0/czW4niXrN6aMSYfrhfNlrVOGKCvl8bjiw0UsR8fVZUN
 Xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631629; x=1773236429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEStfTYF6dMKGYdU7+74hxiaVaOWeU/uihc0yMQ82GY=;
 b=cq0OiUOHImsKzbyMyUXnqEbcBK9zzFCKg3wB/txqjLCbaWRhcusedzoWgrq0cvJCYE
 kdJ4ay7a3uavSXazZ4v9MUITK7CVj+uohZaTPNYA+nBZxzV67IIbZ3sv9nHgsInLTCT/
 qEu6wKCC02tue1Di+TLH9UxN3CBXqbIRHjL8bcWTGGewupUkN1AAkZJGhHjooJNrUnOc
 QCRTNf7sb/MP7SO9NSHOOfkTPUUAS8hP7qdgIiIhiuMJA2DCrNVTS6xSs8An76fYH37r
 QnyPYD6/+zqdQlBP14IDsaxv8H3PAW/PKDIhwFKunrsh9UeNLT22ptFVh6+MsKnPHi4n
 XPwg==
X-Gm-Message-State: AOJu0YyPPesL9tdRj+yF9xOys51BL5tIPke01xESQGT1qubGU1m2NSdA
 XFuFRIYrwLpa9MpirNS9SZkBv8VI6HQi8zeyrW3nQoR9gqKRiZp+uaFZKwy0BUQPoTKZ704W7mF
 aq87m6E24pF5KMRmjB8KNsBlVpyUCD2vXXBMLeyHpdVqzxVQm/eIi/yuluNYrz1P9KkF2IH+Ayr
 2KIHIhL9lpsryVRxYlz6Yr7RZXbs9GBgTWV/tNRTFdjA==
X-Gm-Gg: ATEYQzwpoVxlIwEpMhibwt8Mafnt9AoVcBNZ+cqS00YgXjLxcGQdNyXzwRhkuScHUr0
 cgBcHa0vIAyUg2+cwyWlwPiLUBhHtOgqqS+/acymMjWJ6bz0o8CYGtBAUwPpnlb4FW0H6KZYK5M
 hPF29GzrVrjklYfm5Cbvi2S2H6CUgQXHrVBwQF8jpZ+Q2BKej551zZnSH+7fDJCpo4220J6hgNS
 XxRLtu+dlPVEzMs2EfsgIfHp2MQ6K4/4a83BcQ1NJdoeOQbshgpvkrVHCf4TiS7LGKkWoARaxX1
 7gmlBuFoC2/mZUQt6oGSUNIA+LTb7ZvBY7SAANcOO6N7wctPEYlP+Z1pDK+0tG8f6nz8A4b4yMH
 VAgiySHOLUhKswSwG6fSFp6Ps1CFLurZR5no9UpBWoLXG1/18uQhVUqK4mplrs0PQmfA33uYshY
 5Sb5yGAb0ItLMiixCejththHzBmCur/8zcf9E/yoSUfC+ZiZ8lT+Lq5XDmOeaRAoxzXMkd88IWL
 0/T4NOR0HJgEAri8NajFPvAtOc=
X-Received: by 2002:a05:6a00:992:b0:823:ec5:430c with SMTP id
 d2e1a72fcca58-8295da0214bmr5013280b3a.29.1772631628563; 
 Wed, 04 Mar 2026 05:40:28 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:28 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 03/14] target/riscv: Add implied rules for Zvfofp8min
 extension
Date: Wed,  4 Mar 2026 21:39:55 +0800
Message-ID: <20260304134006.2908449-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c3ddcefedc..1cd74f01b7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2508,6 +2508,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
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
@@ -2645,8 +2654,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
+    &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
-- 
2.52.0


