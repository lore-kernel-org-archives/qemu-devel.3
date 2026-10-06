Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B92CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIL-0006Dd-MU; Wed, 07 Oct 2026 04:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJkE-0000AI-Pd
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:59:22 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJk8-0004Mq-G0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:59:08 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5ba3ec92031so1356592e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349141; x=1791953941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mgVWeZ276Ptk3/+zMkn5/HpMKm4YkXpqgFDkFWs/ZN0=;
 b=VF6m0GCh6mJpUYxweFS2bUGig9s+Ai+gE/n7PhyIIBzqEC95/YG45e+X1THDs87aRC
 jVANjVY7mIw1MEqxhgqI6e0ovtinL//UqwBTLeOOvmSdmagk/BjmeJsRRW1ABQX1yQxo
 h1m1M1Z2Z3X1fj8Ray4JZeBbw/iv8So6idT0LSqeg7Pqj8P5WzwT7FZf6xVc4VhvDMIG
 mTf+1vpYcPS3ytY89gIfKILgc10PEaaaRYG/9ZxT+hfrhEGTdvJXhDatQGvzYLc7Ivxg
 He3NuEzMPCpn+LLM0Zp/Dr9HBu3qa7jdRhDuoboiaFQvItUviMvOXHsC060n9XN1Moip
 vs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349141; x=1791953941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mgVWeZ276Ptk3/+zMkn5/HpMKm4YkXpqgFDkFWs/ZN0=;
 b=JLlnEC/86xGoWjzw5agEBKhregyK8Gx99V8cox9OCxp5LAMzWUqO0J6+m+T2VC4BH8
 2Qwxo5gl5uZam+SIs9+Cm06UEsWIEN6uANhoJYQbjNjthI+ZvEVAlI1B3j+DP0bhXBBX
 f7NqEddDZpZ/L9WYxsa04m83vAjp6KzpQ/KcRPbKIKTIk3kVUxJ3lFEC8usxjYF0wIIe
 I/9sDpwQ1B7FeH51YuGfeVzG0g3boo/kLb4JtkcLoGxND2fl/dtWzLssoCZcOP75vUhJ
 wgskzNaoH63g54WuyLJlneNWI+ykaBUeIHhMF9N7g2ZsY3wA47H+v2KDXLbiaYMcI6Dc
 IuZg==
X-Gm-Message-State: AFq9FYJCu6m6NlhgYYj0dy4cFKRT7O5/eB4meZ+xErvoisObKCmAiA57
 Pqb7Mjdtw29Jz+c90VQlSmBbxoCoO8Z/r2oK1gZc5QopzDqi+uyUc6I2dRaqNg==
X-Gm-Gg: AYBFou3vuEEhJ/wbmWiA0adVsUO1iQvY0OTdPfLZspLbO1Q0c63+MIMxY3Gb3Rmx4ZF
 JJ7XIz1hx/u+JXfmWzfqC0KIXamQNVsPhUPijvuf2Xr1sZ7YD8I422rU1NhoNrXe/xVREubruEq
 RP+Inhz22kS5egMzJiZwPiS7BYFWGiqLKA2ZdErRbFXA2BlZNuHxJyOLZHXDlz4AV6eHS/oCRXz
 tfSI14j+d2A/VTKGXXdBvv8NE18Fbalhs0CUR3H1pEb39psTTvzqQtnr1I5ovXzttR3aLKdUbtt
 Bpgcl3ywza9Qu45JR2mMfx+6V4Y1PdLRVcCXvbTx9s0+tz/kNx+ivLN6/MlafTjgRe4gtbr3kVE
 DmvXhloF32xO4fzQspqxdFxaL18F2coSoZ+cDWc3SR5Qh8utVxcueTqvQDbEgw2qXkDG4X/YjWo
 aqC4wVsNBNwO+dtblG+aA+JnqY8HKfY7LM8txBQ2bN40YvJhGM97fFHxbKV1WsQlRT1NUYj+6u9
 u/4hAW1ZecZqvZsdMswWMIoWwnXtPloc3AV5Q==
X-Received: by 2002:a5d:5f54:0:b0:483:3695:6ea6 with SMTP id
 ffacd0b85a97d-48c6d1ad188mr1086450f8f.20.1791275758024; 
 Tue, 06 Oct 2026 01:35:58 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 31/31] hw/arm/fsl-imx8m: Fix typo
Date: Tue,  6 Oct 2026 10:34:43 +0200
Message-ID: <20261006083445.30362-32-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is IMX8MP and IMX8MM, not IMX6.

Fixes: 0c105b261551 ("hw/arm/fsl-imx8mp: Add Ethernet controller")
Fixes: 857670200c51 ("hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller")
Reviewed-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx8mm.h | 4 ++--
 include/hw/arm/fsl-imx8mp.h | 4 ++--
 hw/arm/fsl-imx8mm.c         | 2 +-
 hw/arm/fsl-imx8mp.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 60d79a6e3c..1966fa505f 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -229,8 +229,8 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_WDOG2_IRQ    = 79,
     FSL_IMX8MM_WDOG3_IRQ    = 10,
 
-    FSL_IMX8MM_ENET1_MAC_IRQ    = 118,
-    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+    FSL_IMX8MM_ENET1_MAC_IRQ      = 118,
+    FSL_IMX8MM_ENET1_MAC_1588_IRQ = 121,
 
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 2be3c51af5..3acfffd30f 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -276,8 +276,8 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_WDOG2_IRQ    = 79,
     FSL_IMX8MP_WDOG3_IRQ    = 10,
 
-    FSL_IMX8MP_ENET1_MAC_IRQ    = 118,
-    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+    FSL_IMX8MP_ENET1_MAC_IRQ      = 118,
+    FSL_IMX8MP_ENET1_MAC_1588_IRQ = 121,
 
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 875e92bb34..dd79188e0c 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -589,7 +589,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bcd91739d9..0b46a4971f 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -619,7 +619,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
-- 
2.56.0


