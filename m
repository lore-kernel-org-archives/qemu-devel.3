Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E78C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf3if-0001hi-Tu; Wed, 01 Jul 2026 18:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ie-0001g7-59
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ic-0002aC-HG
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-473ba028d46so1168833f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782946065; x=1783550865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eXus05gydvHtWqwKIMnhXZV/4EZZVvMEfjI0FZggN0=;
 b=FpHTk8YhQrU9A6HSmCY6nRYCLB3AcWJSGPykaxb4qxZSNjgxmdEYSX+mpsp4cmVXSP
 TGm7UQaxi21nA03O3C+c5/CawugGMJ1tR7XW+5HSEtGRS6SlyJHGG4SU8jyBHj/vLoYc
 DjLXtxFzHB1XpldAXJhJM3vy345LLZW2OkssDj6gEUiQuGbu2oEpqHRgUrgQMNvbnxTb
 RL407JAX225NK/lUIf7r2/W8lPsk4D9+hcrQ3e9s/q504fdPhIA5L01cvX7T7QiKNcov
 JOpFNrHxW8VR51OFWcelfycGd9WzT0K1rEmnZWuHHbUe19ReNjuiGmENnUE3gy8TwSBF
 sXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782946065; x=1783550865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5eXus05gydvHtWqwKIMnhXZV/4EZZVvMEfjI0FZggN0=;
 b=WTcEZ0aCBA6uQmUpdWTpRkhrw0RXxvZ3BV8TUjVI7HJme8H3IJWw6eAZhCjyGWG7H+
 vGDt5dc/Yd7kl42pRqwiS2zWpWN75mfH+RwQaavWYpR/WHr52Ml/cqTscQihEpgJpVm7
 MNyRd3Qq4mjbVccGizn9AwlnzMveOIwXF2yf5acDCsp8Hg2iyQVrPq9mlIsn4K7XT/2q
 Bh6iaq4664RNt+AxXl7EBJVDQ+oHaJPsmBxin/mnaxSeyDdX58IkdmiOVK7PdyoxJrNX
 iTyawRoZV2SISR59+YkSW/UXSlJ2QgdngBfZyS1384bIXeL6NYs9yZSQa25xNiWAgc74
 gjWQ==
X-Gm-Message-State: AOJu0YyfQcUinp+L02nEPetKg9rV5yBnosM5m92BJnyXNhuX8r+dU/Po
 nknw+QHNo/3efvHPpYBhV1qN6e5ih1WEFphQeh7hEYkT3uw6FAe1qEIJy7IZcg==
X-Gm-Gg: AfdE7cliOobEJZjhyAWpreZAFEVsqHE4NYeSSMtwaY4/RODtWH1szKYesWZdkmXbOBA
 4/U/GE6XvhCEyR5HDshJcK7JMjRihkfof1aMVZ96S5EvPpBCcal0T6lcLmYBScWtQN4AVLf6Xfc
 Z6jCLXz1w1kbgfOXAwcqchlI/+pVij3N5vvjFvdLW+XnlZBESLTI+EhFwGOR65HIwYgC+NG8reU
 ZWsY7hZsVJyi+cSlzXMte0EaEXQNqX963rYfPt3IDsTvVK5F9XhoiFLPwSI+VClFghQS9lYVhnE
 KhIcJBI0jsybWREzt+QtrZrY03bZ7RBQYE7NobfNObaaFp87RBfAar9BGXhCOwbBkwM+IlO96gg
 qoIKHpHsxaOI9am8TnKSE7+syZbeG+lVW4KyBm9pqD3wsPxAGvEgdBIpO9ONlwTiOX2gky7S4a7
 uTrI8SiZHhRbxi/ZuICOrBNdYRxksvkakXFBKzhMFDYylROgd78aTYh34QHhgfQ3yvwK8VtTXoc
 Od3ESUnK+0dYBcvEgvb6ZFBjxgh0P9tLeRy
X-Received: by 2002:a05:6000:4203:b0:46f:f12b:e456 with SMTP id
 ffacd0b85a97d-47758db8316mr5367812f8f.25.1782946065010; 
 Wed, 01 Jul 2026 15:47:45 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2d44-b300-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2d44:b300:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm3178614f8f.7.2026.07.01.15.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:47:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/4] hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
Date: Thu,  2 Jul 2026 00:46:10 +0200
Message-ID: <20260701224612.48342-3-shentey@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701224612.48342-1-shentey@gmail.com>
References: <20260701224612.48342-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Open code the DEFINE_MACHINE_AARCH64 macro in preparation of creating
FslImx8mpEvkState class, needed for FlexCAN emulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mp-evk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index b84ac91a17..4a0c9df76b 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -113,8 +113,10 @@ static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
-static void imx8mp_evk_machine_init(MachineClass *mc)
+static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->default_cpus = 4;
@@ -124,4 +126,13 @@ static void imx8mp_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mp-evk", imx8mp_evk_machine_init)
+static const TypeInfo imx8mp_evk_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("imx8mp-evk"),
+        .parent = TYPE_MACHINE,
+        .class_init = imx8mp_evk_machine_class_init,
+        .interfaces = aarch64_machine_interfaces,
+    },
+};
+
+DEFINE_TYPES(imx8mp_evk_machine_types)
-- 
2.54.0


