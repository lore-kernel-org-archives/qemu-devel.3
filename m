Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42CDFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOG-0008ND-TJ; Mon, 27 Apr 2026 08:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNO-0007m1-BJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNL-0005TP-04
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso86366585e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294065; x=1777898865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OaA4SrpRYNI755AyNOvMWIZPb6FG92odJC0438gwgBQ=;
 b=lcFLd+UjWtxoVB2+tfkVLF8nij+CAI1TZuYrXt3BThMncjCEbFzlXBR/ZiOr5k8hwQ
 65bsRrC2HWVOEFgm292W3CgyHxROAXhhyim7UPLqB1kmP67JiFOYBlDQWv22xACifzs+
 rrYsl4NzN/7fTcx6r71xeOrzamJszI2qCuibkmvrwfGT1Ci3HZ11al6/byMAfA9XlzH1
 6+exmIyIwRbWQG5/5RPkxrAzIlBVB4n45/1tk5wqyBwK3kGCPu3SHKoOoPSZUVgyWLu2
 ZuMDXKc6c2pwJyQUPdC/LzBuNj8elbJzmlYd+HxP0biIxWrA/RxKlNl+niNqFqsRb/eF
 D48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294065; x=1777898865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OaA4SrpRYNI755AyNOvMWIZPb6FG92odJC0438gwgBQ=;
 b=NR0Vk04jaznZkVuDTZyEnmqO6MjUVW0DTuUcF6q3y3zay+4s7++eGw1pjzUCnc/5Y+
 F5ttu04ylCXVzJgZhy8g5kGnlRgaZahYWPzDTrOhNEVL9MoGG4FfNd88Noo+yIOQ3oBF
 fXwUfjLEZTtJZRcfMjQo+oy+gfyms1H5YjrYzItvKEmGk9SePNmGBL09zma+fSg3CVdq
 Hj46TPqOzqrAIljGFePEPq677udUGyaoRhwxdbagIxHqBxBUa4HVtvl9/1W61XMiGbdO
 bxpvMC7lX/o5DUR4HRks9LpSi6/gJuO6rc2U/Z1oVAGw2olTXY0Hm1B/RwU+pTGLKxHT
 jr6w==
X-Gm-Message-State: AOJu0YyXEB+abhY4c6dd8tP97Oo/BhetCxSZ/gW3q18xqxPaHbcCmXs0
 MxwvBHfnVvlBVi+lfQpAf4olLJL/+Mn1gNYBJpDo7as3iMAt0P1qSG0JbrUIEXYZaNDBQ5jqx1t
 AVmr+
X-Gm-Gg: AeBDies6flJc2vrRz5hxxlwxjMNuOjPlPvVDKRNjYllHjp00ni+eLXMGNrNBLXu0rvI
 JQr6glyN3ITJpDnChOi06mWH04Wi9P0VdwW0Pgm1mCv5MlI4IYGONrha5ekgrxW7UJNvfVmUvRs
 c0VoB//GfcxAUKH1WoVGDEx54bnAoglJhYtOaTeymnmeN73Y5qTIF2yoglkP1DzArmj9J9bysp5
 RBlE2tBRPxwBtVme436+iN5v1tc5vWWR/oHgOdxUnJmnW2nH2A0A8TKV5OUpXFfuRs0+McRuZ+l
 GRW7XrsXPOJUwFWeWbbsuAdl49uJj2Auh9UpR+J6nDVtivwvWn/ky7+gN+qSTBSXl9vTUjorK5A
 PVlpGbuSb04KxRzSz3S3FFIrxJFREl3GShZm8TVo2dixZd5Snc7U3yfvC+Lk5IjQ9DoOjNyVBc1
 7YX2Ujea8SWSuzjf96KSux1M7gLZh0yaMiiCBWP1LwaxKhf2QmASScMDFrZ8AVgD3LNpRB75QIO
 VF43kyC0KAxUwAqDXdGE130UJfAXd93Yvv/wn9kh8WlF67k4EPw
X-Received: by 2002:a05:600c:c0c8:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-488fb787ba3mr442359235e9.27.1777294064663; 
 Mon, 27 Apr 2026 05:47:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/63] hw/arm/fsl-imx8mm: Implemented support for SNVS
Date: Mon, 27 Apr 2026 13:46:40 +0100
Message-ID: <20260427124738.966578-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

SNVS contains an RTC which allows Linux to deal correctly with time

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mm.c         | 10 ++++++++++
 include/hw/arm/fsl-imx8mm.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 053434412c..8999bc701e 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -173,6 +173,8 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -355,6 +357,13 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,
                                 &s->ocram);
 
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
@@ -364,6 +373,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
         case FSL_IMX8MM_OCRAM:
+        case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
             /* device implemented and treated above */
             break;
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index df35f0f5ac..8a172b89e0 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
@@ -37,6 +38,7 @@ struct FslImx8mmState {
     GICv3State         gic;
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
+    IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
 };
-- 
2.43.0


