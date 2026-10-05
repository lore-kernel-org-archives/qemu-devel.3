Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D594CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfp4-0004nU-IQ; Mon, 05 Oct 2026 06:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmQ-0002He-8g
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:55 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmN-0000yd-N9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:46 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b00a0ac65so752680f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195522; x=1791800322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5BgOm8ABXH25gZPPmMC7stVsyb70VMWWrYYHJ+SXr/o=;
 b=KAP2agGMRaCDUWNdcGCRpJajP7BpDeSTVFQpx0wPY+UZiMy/kWjrZ2Sytrn/MnuV87
 hyqQyr0Copko6WQ0kzlfd/fGuvTMtAxGl++qeKCdc0dwQzUDMz9ApRUAW1/U1IjiLJIk
 tWELSnYPSopzttPVAmtiosArHKFCFtAXrROQl1Pj6Hyha1/883biW24ewwG5pFKEZjmB
 0Xy83X5UZMtlHAWhIK8A42O7vizFnSKwoQVZ+s1OrLy/VX+Vp1vsTIod4x91igv23Eik
 HaH2miEY9KBvZ933zHBUvG3SO5JpTefd9DxJP1kIe4hW2Lh98NT7qsgQ0/YuOZidC3VG
 9hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195522; x=1791800322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5BgOm8ABXH25gZPPmMC7stVsyb70VMWWrYYHJ+SXr/o=;
 b=djeFDJwTBRPu2P1e+f4DhpTnIc8P8uTElQQcG+iEAaPDAVJZvPEByYDyAbRpyg8rWb
 DuMhaD3ihZpmzoQ5lNn9fmratXK49YniexwTrqnbDYA5Ire/tAqi6pY7nZlY9OHf9+81
 2ceh35O9PzDV7g0t+9iD1eztqQTxa0I6u+mxKQylPnD6+7NenePj1r+R0nyVFhwc4dMP
 nfmgBC5jnHsPakVqRoppjtnNoMybagKQp4XJz/yHZE3JoymQVjURByP2vRciIuMR9mLn
 xXonf588hZ6ZOKNG3DNmcNfvuONc1hc28DZZSL7ZCEjv1Vb7h9pHAYLDWrJgmuwqa8vr
 6mwQ==
X-Gm-Message-State: AFq9FYJUKY2dYakvKSWwXEObgkjDvCMDaFZY0Q+zZJmKAgTEOo9lpu9t
 Arb/C4+IXMDOC+754q0F1vkh6/w7AqaCuWc00KDbMCHZ75ZyvIVT83HO64osvg==
X-Gm-Gg: AYBFou2ySdZsmqjVkLXXCReL1CAb5p+TjsmtNiu59pEOP1Pln0vPrn9VpL0lpYRH5AB
 E71PNqBft77eU8UCv+If3b6Jm2J/xzdu3jMnmHrbnqjdmUqX721c8+5qF8gHXGuL3gKIQKUNZsv
 SsBvC5PZ28lo3SxHxPGxzhz7x+QU0vEm3Y1xj0jxURFUI0ZbPcueFSp4ch7WWskUslC1VzvaHV0
 rwuAEkkFUrEPKmHK2ChXkSS9paYepbyC0TFeAS8tavA95ObIUUQZbfJ4HS1Xx/wLDfCcTGKXJXw
 mFlzpU7FZWXZm1BUj7BpGlOoDO169hDxRL02nub/x5Dtv/c8sQAW7smDpfraGayjdEl7Srn2Wcn
 vVvku+jcun3AHgpMYkluJURKJGudVbNoNm+94SkMNNT69d5DHIw4HHFmh/5/dnPeW8XQEeq35Ls
 vUhcJykZei5dbVUiEyfGoZHV5D4FiB5n+B3SwpP4vnyxI6z8vMI4VjtNsQXOohzsSNOhuPw6GsQ
 0ml253L0OHSVEKJmcpEialmCEKBIwIXFMslWieYYAczcrfK
X-Received: by 2002:a05:6000:200f:b0:488:7dbc:893f with SMTP id
 ffacd0b85a97d-48c424de020mr17774914f8f.55.1791195521836; 
 Mon, 05 Oct 2026 03:18:41 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:41 -0700 (PDT)
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
Subject: [PATCH v3 14/31] hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon,  5 Oct 2026 12:17:41 +0200
Message-ID: <20261005101800.10821-15-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
machine reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx6.h | 5 ++---
 hw/arm/fsl-imx6.c         | 4 +---
 hw/arm/sabrelite.c        | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 376deea3a4..4cf26f1fbc 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -35,6 +35,7 @@
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "net/can_emu.h"
@@ -56,10 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_CANS 2
 
 struct FslIMX6State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX6_NUM_CPUS];
     A9MPPrivState      a9mpcore;
     IMX6CCMState       ccm;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index eec9673c6f..7ba9b85a2e 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -519,13 +519,11 @@ static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6_properties);
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
-    /* Reason: Uses serial_hd() in the realize() function */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6_type_info = {
     .name = TYPE_FSL_IMX6,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6State),
     .instance_init = fsl_imx6_init,
     .class_init = fsl_imx6_class_init,
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 34f302f83c..201766d8ea 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -66,7 +66,7 @@ static void sabrelite_init(MachineState *machine)
                                  OBJECT(s->canbus[i]), &error_fatal);
     }
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


