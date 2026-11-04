Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4226070777
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=f6+NujlB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgth-0004D8-48; Wed, 04 Nov 2026 14:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtc-00040f-To
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:44 -0500
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtb-0002bd-BD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:44 -0500
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-35b2c599f43so287390eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821421; x=1794426221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GE4roIx9tbUgyAJEwFuHtGPxuObZsnSnt+tyeOPCqS0=;
 b=f6+NujlB0M9kXJE1mavzVuAOTqa1X5En8jlZQlXzFlNPCzzErirHx1aLvVOecfwbVr
 4Zoh/9EZslUcpY3TtWdCkKdLK2KXAKCdgbq8Jbqp5ay+eHQfInncNSsrANk3vHlK7cJj
 AEnGjVvQCiJvc+Ua/ICHp6qSRYR6qT/CE76qhPrSe72drZaQQYSLLavWu0HEEkK6a/U2
 f3YkmxkUNhQE16XzJTFgbcAHfMr4oa4qTT5IOaklL2UfA0o/t/80lwyQVrw1vhOiQy69
 C7ZktDm99pImImLPR1vPfKbK67Aprg8K0BvRQwRhQMWmNwmqN+kumD9zg0jqGsggng7y
 Uqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821421; x=1794426221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GE4roIx9tbUgyAJEwFuHtGPxuObZsnSnt+tyeOPCqS0=;
 b=ElquwbQjXn4rcU3t2u0/DZrz9HBeS7HTydNMMwvhrbJdzbS1bje3e7IuCADV0UKRil
 bMoUIiEizI6+EmmmEoCQ09UutriGdEcKuzdjQhZIGuzFZHw4JUsy/Ej7hFUTuHZfSIDi
 FjhYsq63bzxVZXJGt5PQkoewMtzSVp3ERNKfaTo0shwyTCk9/joQAycGeR5VqyoTAMG8
 gQhHib04aH5kH/pGUOQ1fM3v8X8Dzm4ZGo8NwQ9Qwe7QCWZnWZFmZwmBrze9lc3MtFHQ
 HQSX2HSbHLZZyNfxWBVA79Aa5+0FGKG49iX11X/31RAQK2DQGhWT2aHwTFpeuoRqOmDg
 rcyw==
X-Gm-Message-State: APuU4Z97viOgDZ8SmWeMoAhxuyIwa2DH+SJIn2uNuAvXAt1/Otx3XZEg
 jH7+sOEoONPTxl/qAP/bJ9aga5nE/Dl63b/GK8gzJfubOrZTxYVTKrcauSeQ3OzQnhPsTzX+jHR
 XVZfmMEulQefs8AFm/kB/R5A47jyIloVSjiZqgSNAiQErsL1lSa9LtHkQNWkIOoc3gme1hGgPpj
 kIlosQ/jf5kOWscqe5W0/q2IUbH0gvrYJZlrLPnAoQJw==
X-Gm-Gg: AYBFou2r61UyDOvsT0RKKi6dzF1rNzEY9o2/OdwjCo94yMxl0b8NvZuQjg10FXyif2k
 2Xdv27nIwqu0VrC3fYaM/v4vWSquA/p01lMvg1A59BgkCtZrk1rT/qCBugQOlxRijUjtKxoorlb
 vYwD3Z32VPmZIyWUEIITppJoMbmcQqfq1QGVulUaDnS5PEb7F7HyXnlbEGfhVvvwvVHMgGUCwA9
 zML7TlNXJ9UOFbELo9rh8bqHqVfASSc8UJfUNW4Wxrcie+uS1BW1Kw8vzMdnztYXfiYjWDmzdG/
 Ww6rX7IO0RLt6DRjeyG/fQDXsQgQLc8Pwkq71bH6+S7kP5f++1X9cSB1UByEiiZOXeFveJV/EGa
 KE13+tbGsKjSqI6yZGnhUToXN7nArigwbk6uI3jJiO3K8cXurrXgta7d/C65wcoLZfbskCFulnp
 q7j0uWLJ+i7q+b5A7kM85w9exKwxP82SIbik+8N7gsBUBRaaHGBcoqMy7tf0fgHjodxqTCLKI3Q
 f8qukJpVejLoO1Gg6GUaj5qe6DiMK0qsyNzWoCFq5luED20ffaLkFUAoARgcJDtR4pjPIs4tTjt
 65Aaim0wbkmA63ZLSdFr851ER0YJExHh7UjK5tGzq/ddsQhZQNao6kIvT7Tsb714BeR9Fhf+35r
 kYSVH5vlneZeBGPT0Z8cngoNBvtgI
X-Received: by 2002:a05:7301:6404:b0:36a:79e7:2fd with SMTP id
 5a478bee46e88-36a79e708c7mr9266668eec.40.1793821421255; 
 Wed, 04 Nov 2026 11:43:41 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:41 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 27/38] target/riscv: Add implied rules for Zvfwbdota16bf
 extension
Date: Thu,  5 Nov 2026 03:41:42 +0800
Message-ID: <20261104194155.679241-28-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add implied rules to enable the implied extensions of Zvfwbdota16bf
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c33885542f5..566e2e835ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2890,6 +2890,15 @@ static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
     .implied_multi_exts = {
@@ -3115,6 +3124,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED,
     &ZVFHMIN_IMPLIED,
     &ZVFQWDOTA8F_IMPLIED,
+    &ZVFWBDOTA16BF_IMPLIED,
     &ZVFWDOTA16BF_IMPLIED,
     &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED,
-- 
2.56.0


