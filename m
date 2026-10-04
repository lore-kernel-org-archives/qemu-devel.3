Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D0BCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJu-0006Zk-Um; Sun, 04 Oct 2026 08:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJo-0006Vi-Q1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:53 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJn-000792-1c
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:52 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48afd5b1678so461259f8f.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116869; x=1791721669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WBsXfO3snhKIDH4IKw5hWj29fah4NwiGsJLdWllQFRc=;
 b=fsr4l0CqyvdzCvEcbPHTsYmPxr6HotMkwQbryhXFp9uHxzvVP3G4Dve6kLMVVt9lzx
 IzZZwxxIDMNeMjeZtI9qb9PIQLFy+VCPyDDVpIz41Jpz9ECESXmujlycz3w5gaF/TWAh
 Efo+6swWi2gDUBh2/Z1lbLbKmvfa/ObuLeZfcJjQI7k+lkPrFGtZQpGnO7MOhp8CDpWr
 7FMielujdN9QgNj61gPmfA4iEzanh2DyRWpJMweuKiMNVL6xenGJIvmNXLhzDZQqK/kM
 PAr1oOxyCFIHK55ZWLqA8mTPEZ+zV+N5F+6jxB0uZiulRFKHytD2HVqkkUSKL2C3Bo+1
 eBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116869; x=1791721669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WBsXfO3snhKIDH4IKw5hWj29fah4NwiGsJLdWllQFRc=;
 b=UgA4MsZQJNuPFIiOZ+brsMjbpXl9XEK6CIvlNFV7vodccBnBoeDi9kbLF5pZD8OyJJ
 X5EaxPGDyONTrRvEqaJsk6pWLTr2pG1I3NkPfuU6qp31nLi6aFwjR3GhHzA6Q3qJ4L4e
 l9MVxJai5bRhfUBif4RiHMto5/WQO/SGSAjuYH/+CmL3YdhPIm5RDn+9Kny4dJZZB1Xk
 OUggUVZrb6uhuZ52ViETzx7uvnYDRMXXIg+Vs8/I39wK0KdCeU0i3a0Y4Ytqln8Xf1i0
 naw77vXEE7BtRIIWJd3gsE8SNsCJ0DEZINRCXGhfghu4A3FwmHR33ySnUYOx6TIoqyF9
 TnYg==
X-Gm-Message-State: AFuF++lnrZHDUz5LVx8b0CQNQjvJ2OJP9EA8Od9lQpKTlh11A1h0GK4H
 lucgXMarKnpMZ85//z/ChKfuwbZDF+yhoo/d3KL2K8u+o2vYygRi+doYbixiSA==
X-Gm-Gg: AYBFou0rNYclF47OoTFL5vKD0w5T4ViNO5wCB/a75IG0o8EsCPqZuCXj1rDNISBLLDq
 Ek31yKoJEbdpeyFg6wB/2i4jaekV0xhcZFemF6ufXKMWw6IufFkT1DcJL41kIeFDCsN6fceUgdI
 VbNSIqC/Oe8ct7wGZCg8Jol1D5CfzOSIPe577Cwmr/xeilUDk/Rz6DM1lJfo1qeeoRiU41nj0DW
 zpaJGuZavuH2ae9M2+DKCJwEAvLsmX6K2CK8pq6odPjPYNR56EZN5M3jPD5EKGs2CXBTNoR5cXx
 +FEaMin4/86WHIbFhm5Fqu748bTXyPHBcgoYSXXP491fudf++otZmvPLbX3GrvdQ1IcjdqpzwHN
 cBPpVEaj7ADSK72cruTIJMIljY8+qLlwEHrIJj/Mw7DwN+/GnRlH7m8OSgw/Gc3UCsRMzrWttPY
 Ww7adXa+g9HqJWHWzsqXqkHKY82ejBg52GhYSksp4WNISnri7BHd3iFzaUHQF8mteL8Qbm2ON3j
 5Wg+vn8CPYTnuEcLJKb+eL+lC8NVluyeMkJgZ4=
X-Received: by 2002:a05:600c:1c0e:b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a02759bbf7mr158615135e9.21.1791116869292; 
 Sun, 04 Oct 2026 05:27:49 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 11/30] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Date: Sun,  4 Oct 2026 14:26:27 +0200
Message-ID: <20261004122647.3913-12-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
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
 include/hw/arm/fsl-imx25.h | 5 ++---
 hw/arm/fsl-imx25.c         | 7 +------
 hw/arm/imx25_pdk.c         | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index b68d4334a0..4bb4d5b3e5 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
 #define FSL_IMX25_NUM_USBS 2
 
 struct FslIMX25State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX25CCMState  ccm;
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7f65f4ca4b..efb22359c5 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx25_properties);
     dc->realize = fsl_imx25_realize;
     dc->desc = "i.MX25 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the imx25 board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx25_type_info = {
     .name = TYPE_FSL_IMX25,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX25State),
     .instance_init = fsl_imx25_init,
     .class_init = fsl_imx25_class_init,
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e..6ce3e35ee3 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
-- 
2.56.0


