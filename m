Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00437CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfq3-00073p-4I; Mon, 05 Oct 2026 06:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmp-0002Oq-6y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmk-00014T-Ke
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso8423355e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195545; x=1791800345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mgVWeZ276Ptk3/+zMkn5/HpMKm4YkXpqgFDkFWs/ZN0=;
 b=J8xp19ApnkTqiyFeLRbM3PvTdx/9acEEG40BQuc/HqyW/Cy9FdEb0I8mi48Ljx2h5O
 0sR+Badjh5ERuoxp/ieC9vbr/eC3/JUYwJAHXrqXpC1qxXYcro29ugPWuqwMYNSxkjoN
 wf8x+WtTbPRZAlGNXiGp2oFsytVWJybOMaJwH3GzOvSQWH4xtdWOJ9mfWMTYLLpfAZGu
 KyfOZsypfI/Al6SQuPDhn+HTEJZuXQMiaktYpHN70OpEUZW6/poiYaOxtHRRklbFLqZS
 fRJz1OiRxgAYmaz0X2DzR9PKhw5LaDJasi8UquMaqC9Oi67UfGpnJ1LxEQ5d901YySNN
 obvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195545; x=1791800345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mgVWeZ276Ptk3/+zMkn5/HpMKm4YkXpqgFDkFWs/ZN0=;
 b=lp1ymnk+RPSATWGAFwnxaA8CJl+cCLXie6EQbVQlsiDKUrUssq43EJv39B6KzkEw13
 LH9SZYFgzRCTTJcF5puiycfu2PYjY6ri78dWnxDtTntXbWwkuujAYFMy6TTUpRzjNln+
 Di+fKbRkiBcShMGebpJBtmMOxyScnVRSTJo8dQQdF1WUQst8Eihr/YyWFiK5JllPw/iG
 nY45HJCb5Ecne1zubcDuD072BGdtgWEK2xWtyWkcMO5W/VrUU//ZLVmWnDogSbGVAooS
 t3pS+owVph9fJXFbQxQHZhHlluNjqxT4BoPWVmq84JXvJYmKU8rgqalT67o8KFVsBMl2
 x+cw==
X-Gm-Message-State: AFuF++lGNKKCmtRnv1hkBGP9t7yHXH6yijedQF9Sp8j5GSdMJT3K/npK
 YTENDXzzjyP3N/PEHAQAuVrARJxNU34L/EuDv9bBr0XNzcdcqvQINTRN6Vx3KA==
X-Gm-Gg: AYBFou1Yeyop61lF6xP3ZHlBFwYGFE1GhLw+h8eOWAs2UAYkiqfkHEdiiijAfvJymDE
 4zRAVQs5wOLwejTHH9Mp8IFCHM33T17YFQfEGj9ysAAGu6E8gzO1vBuQi29+xyXyjYzFH11mCT6
 7IU7Qk59q71uT2j7EehyD7MctQNXjYnYy5DnfKSwjOKJOkQJxSkSxkcC6DEPENpJsGyBhfsMIZl
 KDstA63GcoLfHNI77dp6X64xuffMvuH1s30pxOeHp+fNmPAlt8Il7EfQ+VOEvEHCT52gsAIzZ35
 UgWBcxtQSf8PVP0ZT1AtcNk/ICNcpiqS+nCbblEh4RWXLvotxSiIQNFwpI1gSQyxrl20MnFY9Ue
 T8PN96xEkMClItaRhMJhD5H1J2Fhy5FG7kLv+Tg2XVxE8naureZqUVDkhvt2DA9qQ1ZVO0iQ/sx
 b0UcMLE0sURgyvkzC3XDhwz1GywC4SHNWq/sEz3nK6uaoDqKx3U1Z3bceovV/FrKpqwRnuqTk/1
 QMusHriNa3e4DKX8K6VMWpwSQLGhbW0YfmZpw==
X-Received: by 2002:a7b:c3cc:0:b0:4a0:ff8:2a0e with SMTP id
 5b1f17b1804b1-4a01eb1e93fmr187174465e9.3.1791195544782; 
 Mon, 05 Oct 2026 03:19:04 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:19:04 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 31/31] hw/arm/fsl-imx8m: Fix typo
Date: Mon,  5 Oct 2026 12:17:58 +0200
Message-ID: <20261005101800.10821-32-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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


