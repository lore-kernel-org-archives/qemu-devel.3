Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA2FC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNMY-0005lV-UY; Tue, 04 Feb 2025 13:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNLR-0004Um-DF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:08:29 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNLM-0007Cc-Ga
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:08:18 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38db104d35eso551382f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738692493; x=1739297293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnZ9WpmYKnZRCdSHS6mGnNZU52sWxPUChowKsSNdKf0=;
 b=lF9wVj6v6jmym3yWL16HVS1ghwUdpc7yDB6yOWNzWDO5hAgk30huJJpQgsIGFTliEI
 9UIwbocpYOp8RXFjoJBr+/7R0dAfWLygJCL0ecEuRAPDhcTWyN+xTWwCohfGh7KdYGeD
 Zkh2RSDsxudbEh2JVjr0UdRD25zckrqPYybpAyfPhpCrBG9iEcYnNlxthGqHnHzE8zzo
 JZCGmDJkAAmovSC1QkQoK1rF+S1OzSm4PdtFcYIGF/5ha4pO6TMYcNCaTngUFsSo8U00
 AkoNYA8tCxc3Mmr+AS0wstj0MCjD5BH0Obt0WCzv5YJbwzld+jPvyFF2KP2K0sirjLpC
 J2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738692493; x=1739297293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnZ9WpmYKnZRCdSHS6mGnNZU52sWxPUChowKsSNdKf0=;
 b=Eqe0lnNfjtPbOXxtXUT3ESHL+fOOCRpZ8X1T3DkldvPj0cLVJ/hkaKbBdHAJBirrb7
 d7V7fLdp+Th/wlM9NqW+rhYKb0CtFaa24aDaQpKTs6uFm4sNqRSsJ/xxvronkYkAzljF
 vlC5ZuhLeaDo+UbiCkRVJUVdrKCieFKJNUmyawc4L6DbBOz4LV1oFvwY/wZuSmCnNmT3
 V9vATsUsqMpPQ0Uj4nRsn71d8jD4uPPFY6ET58J6WJAIFvHUiPdnVLt4q23H0wjP1viU
 pb5Pt0RfAiaSNEOeR5YMWXQ3K9S2qQcH0+lOLxi20Iz2Hc2EJWe6vJI82PLE0QAaRuDZ
 MGyw==
X-Gm-Message-State: AOJu0YzZlXtWScGoDCyLALbxZdMIq/dNkcfXN3utlxFAU3f49tL82A4h
 QynZDCKmtfF5etSzhFBexTSi57vgY17ykrCJLyWrzq+sk/D4KzQRsm+u/P7xvv/FS9x0pVnFYyd
 Dx0g=
X-Gm-Gg: ASbGncujWz10bqG9ZYyhCno8RguYMRm2085iA58P/42o0P4LFklmdcQ5fNsNuB9Iz5O
 exEqGXSHydSrz7wiWTkU0ohzC6XGQtX++G6P3sTsnNH2wrGY0cqTT9SSgkNBrw8kfheFPKjTDk1
 XxaKgWSkJQ2srVZpabP9sbTqxs9WOzkrkPwKwZZAawjWse++Y8SO0IYu3r6Fu2x+Di8MjX1QbG1
 vpuCV4U1ey482IaTmtM/Ylsj6Yoq7oii7hUg6u7X3dpuZaTjReFhqdE9ZTIHWYNY3GjiM5zWqiN
 zCPgz9F2iAaxejMhiWscxkTX23uk3X/K82HZ4G7rK22V8nxejDPnYgmvWT6xOy6aIA==
X-Google-Smtp-Source: AGHT+IGTJZV0aGVO9MoQJyL0Qhv8RFG2VuSHnx95rtNRM4+mA7NEWT2zCLsgfge+bk0Wyc+BZ2kfSQ==
X-Received: by 2002:a5d:64e4:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38c519378b7mr26145829f8f.5.1738692493241; 
 Tue, 04 Feb 2025 10:08:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ebfdasm16677986f8f.17.2025.02.04.10.08.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 10:08:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] hw/ppc/e500: Remove empty ppce500_machine_class_init()
Date: Tue,  4 Feb 2025 19:07:43 +0100
Message-ID: <20250204180746.58357-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204180746.58357-1-philmd@linaro.org>
References: <20250204180746.58357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Previous commit left this method empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 59208da87de..26933e0457e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1285,10 +1285,6 @@ static void e500_ccsr_initfn(Object *obj)
                        MPC8544_CCSRBAR_SIZE);
 }
 
-static void ppce500_machine_class_init(ObjectClass *oc, void *data)
-{
-}
-
 static const TypeInfo e500_ccsr_info = {
     .name          = TYPE_CCSR,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -1302,7 +1298,6 @@ static const TypeInfo ppce500_info = {
     .abstract      = true,
     .instance_size = sizeof(PPCE500MachineState),
     .class_size    = sizeof(PPCE500MachineClass),
-    .class_init    = ppce500_machine_class_init,
 };
 
 static void e500_register_types(void)
-- 
2.47.1


