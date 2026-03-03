Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDA2EC1459
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQui-0001Xq-5l; Tue, 03 Mar 2026 09:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuX-0001Rm-GK; Tue, 03 Mar 2026 09:39:46 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuQ-00026F-4H; Tue, 03 Mar 2026 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1772548769; bh=kPhYwXaieTxN8OjR+nIgi3Zg9NTyEWCU4usNgWlAsvY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MRaYL2CErZGh+0ev9Q8Lm8diodyddf2tTASjpX9foGo36WRYISRTZFSQyxHK621VU
 dV9CnD4/elC6oCpJNvq/UJdrzfoPRP4YfUIU5yw2oBR2Tqd8btnt/IMAos64/gT1qg
 Pe1+hX64KrjnsDGWJIX2xhH+Jl53TdatNwF7KFWs=
Received: from archlinux ([180.154.0.12])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id 7F901C7D; Tue, 03 Mar 2026 22:31:57 +0800
X-QQ-mid: xmsmtpt1772548320tq42h18jr
Message-ID: <tencent_4FB81C02E16BA91F62B23A5B45EB89A80F07@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7fXQXRnf+8DfaaHwGHrAaduYYA5xOEOJHLz1/gMfpkkCoPeOovz
 IBIyIQAkVypKuFDMtlXaN7nGVH0M5abaSeTFObI1QfjYClaq0mxjiGHZetY5QSXnugcuZiSYHbeh
 UnQLXahAMEnf06pluyY4FTCw/V+DvKHCk3qLXe6SnRdLWfZZzaxu7Fsyqdf9Thn+Hl1vZkuGZ1Mg
 uGooBFk1W6o7BjKU0vAiTa9StdYzmDa+XnBn9pDqkFsnQw0a14cJAh+Kcw+3DYUfXPMqiAh0/4Ip
 oeVEOUPQpqrUKJZHhuC8pFop+3zjpSRyRl8NFUb4yi2bN72ump6dW30t/Azw8DkV9ja63qz1L64+
 Ec3fgodCKE9VaTQ5f03XsKjAq1oNcJ9GRyp4NcIre0GWD/m4Oq+xSnLmMT7teQ6uXfQXEIiixMkG
 qAG/ki0PObFw/xO5oe3VuQLbdS5xQnMGH8RwTMF7JSA7MJmanSW/wYUQVAxFKMxHTgAnVT8rdu8Y
 Md5MKL6pWNosSRDxXAQXDBLnAW4YZ+DoU2kFp2tag4A5bC/eMnEolNslAUyEziDBSnFnz2cfRgX4
 vRH3EKTNAQMu3CvS1oY/cJoezFtCAGucYqivORxhEAyoGxttEcQgMiXH6+NRgQeIVbstOPIqmD5l
 yfeSLkIqeC/hzSTkJaOp+YIwymxPFInRObyuOKu7nN+T+kvm+PuSU1sNIoR5END8r+2hSvGxmthb
 L2K7n3Dw+Mjrf1X8k3EZk+u43U+NQjyPCjl2v6G1c91uOBTIoaYap1aFWj5gL9iMkvqcW/HC0JUn
 rFTd6LLksBBWMk70nduG2kpx3Mh0mqMec9FuOuXygT5g1Azn4dZ/M7nhDGofZLXi0RB8ljcWStxd
 v4KZ/O/wToApqg8VHg7BsP6G5Gn+0K275WxFtpg4LYirW/lSB6eBcc80281fS18fD0QCzUw90ONG
 0DjscZeG5QzOghV15Upa34f9T/nZ3uCO5NLltGJs5GIIQQo+d3bFROcuZZ5h1w1QeWXfasYPIepg
 rV8F/Q9KmMPw8UTmYw
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yucai Liu <1486344514@qq.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, jcd@tribudubois.net,
 pbonzini@redhat.com
Subject: [PATCH v2 3/3] hw/arm/fsl-imx6ul: Wire in the LCDIF device model
Date: Tue,  3 Mar 2026 22:31:56 +0800
X-OQ-MSGID: <20260303143157.80437-4-1486344514@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303143157.80437-1-1486344514@qq.com>
References: <20260303143157.80437-1-1486344514@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.50; envelope-from=1486344514@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

Instantiate LCDIF as a child object of the i.MX6UL SoC and realize\nit in the SoC realize path before MMIO/IRQ hookup.\n\nAlso make FSL_IMX6UL select CONFIG_IMX6UL_LCDIF and adjust the LCDIF\nMMIO size to 0x1000.

Signed-off-by: Yucai Liu <1486344514@qq.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx6ul.c         | 12 ++++++++++--
 include/hw/arm/fsl-imx6ul.h |  4 +++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..6655f6c34e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -641,6 +641,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select IMX
+    select IMX6UL_LCDIF
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 225e179126..1863558a0d 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/display/imx6ul_lcdif.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/core/boards.h"
@@ -136,6 +137,11 @@ static void fsl_imx6ul_init(Object *obj)
         object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 
+    /*
+     * LCDIF
+     */
+    object_initialize_child(obj, "lcdif", &s->lcdif, TYPE_IMX6UL_LCDIF);
+
     /*
      * SDHCIs
      */
@@ -656,8 +662,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * LCD
      */
-    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
-                                FSL_IMX6UL_LCDIF_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->lcdif), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->lcdif), 0, FSL_IMX6UL_LCDIF_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lcdif), 0,
+                       qdev_get_gpio_in(gic, FSL_IMX6UL_LCDIF_IRQ));
 
     /*
      * CSU
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 4e3209b25b..5af85dc8ff 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -33,6 +33,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
+#include "hw/display/imx6ul_lcdif.h"
 #include "system/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
@@ -84,6 +85,7 @@ struct FslIMX6ULState {
     IMX2WdtState       wdt[FSL_IMX6UL_NUM_WDTS];
     IMXUSBPHYState     usbphy[FSL_IMX6UL_NUM_USB_PHYS];
     ChipideaState      usb[FSL_IMX6UL_NUM_USBS];
+    IMX6ULLCDIFState   lcdif;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -143,7 +145,7 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_PXP_SIZE             = (16 * KiB),
 
     FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
-    FSL_IMX6UL_LCDIF_SIZE           = 0x100,
+    FSL_IMX6UL_LCDIF_SIZE           = 0x1000,
 
     FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
     FSL_IMX6UL_CSI_SIZE             = 0x100,
-- 
2.53.0


