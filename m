Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12475C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24QR-0003K1-CR; Thu, 03 Sep 2026 06:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x24QP-0003Jn-Od
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:12:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x24QN-0000dQ-B2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:12:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso2222602f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788430321; x=1789035121; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EJNCiPvLRXWcnk4/DseDRhkwYXXWWmHlabIBxs49Y2k=;
 b=hVIfkyFnpV42RtvBO1JQd58xDFfW1FUMYVwr3Vpz+FbRUfHNX9+/VxQ8DsEW8QUHpK
 Yw2eYeci+kcGJCiAAUC2nu1QGrmajcNw6NeuZAzC9/iBhqiC5MUbNm29vBphU2mXxxbH
 cbqrVpPeGAlTaRSP7B7dZVa+NgzcqhczTVByUt3JyOdBcTqp1MLUJMrK4eM+4Ow/ccb/
 ftceUsD8zGhMwiLXwZbVQYfBCp9Fgn0U8TOCb/Le6iJEDYzF2N4V7ibBQy5jOFGKtxFN
 49sUnVAYDszAPm+NpoFWGvo5tRupW+LGhZ31YxiqZZcERGPcoll0E8vThDjTYIyPmEwi
 zhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788430321; x=1789035121;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EJNCiPvLRXWcnk4/DseDRhkwYXXWWmHlabIBxs49Y2k=;
 b=I0Bdxw+zh5XLBJzBiMjzbj0v1dZqfThkko2mWsQUXfiOYNcn1/B9cmvzRIPqXQFS1L
 jgpmrumzvmkKaaGOHY/qr/tCvJm2d8kd3Y/UG6bvnrKZGvsCs5oN7HACueXQTJKWd8+L
 LY45H7U4FfjVViLqLuBh2cfPwFv5Qcq/yowukV09zqfaSMHTWboRwASDybLMmpTbf7a3
 XGeCF/4ZCYj4IrRw0BeMupMQbS3q8hUPKegEt5F/cvctk7Yqnm1FyfvFWbFTluahhx2v
 nTy5hGUSzRtggaVrXSE0clnvrpFtgjt4FYbyVv0ovrOkO6wnNKJuQheSFc7M857naQYk
 MYcw==
X-Gm-Message-State: AFuF++nvkQ7ezQQ4LwPJxsjWg2nALQf4AGW/DXffBhrJFgi9G/SUViNl
 i5xb6osobeFt/r43kYcoYwP4OrWcg9LAnbBx8CCOegQLh2PA1Pqtn2ixAvoFGg==
X-Gm-Gg: AYBFou3WhqAAWu46vyT8IK9vgawQHQ4gUTr1PJbPU1oJsAjjbTl0A3VtH80b2VoMMYJ
 lxDWHbvTBRN5dlZrFyodsIpMqFBsNi4k+y4+C6y9/QpvV1VX4nWElMWe6DMKi+26fgO8TBHNCtl
 xSxVVv1uCYGmZJQ3/26TV3P5yXoSdOBX5g1zG7MKSEJDx7BwGCiv4SxYQTcTEqwHodagY2VYHIR
 cErmB+4fb3lVni+J/Hv1iwgXXbT465PiFsekSVG+fHn1y6tIfmni3bGMz3s5wjpvBRC57GXk+ok
 wB5EO/AI4furbuzWWK7aWg+1K5yiEy4yJUeGJxsH2bKhO1iFrBK+Ic6ql+v5K5U9jE9CQSl/PxU
 fZxFMZ8cWe3nneqIxZ4sbxttfzV2p5R/cUN01ECgwdx1KAxGQpvPWG44Vq7j/GUpXz4T/VIDS/T
 HEFD6zhTRwoO3pIJwH96ClCqv5FDVCgPNtaZz8q016EtqvAujqbClYL9D088diR5b5bA==
X-Received: by 2002:a5d:5850:0:b0:484:36c1:2881 with SMTP id
 ffacd0b85a97d-48488df7ccamr18170253f8f.2.1788430320999; 
 Thu, 03 Sep 2026 03:12:00 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72d2asm12032216f8f.8.2026.09.03.03.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:12:00 -0700 (PDT)
Date: Thu, 03 Sep 2026 10:10:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv2_3/7=5D_hw/misc=3A_Add_SRC_?=
 =?US-ASCII?Q?=28System_Reset_Controller=29_to_i=2EMX8MP?=
In-Reply-To: <20260706162859.3361063-4-gaurav.sharma_7@nxp.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <20260706162859.3361063-4-gaurav.sharma_7@nxp.com>
Message-ID: <4F6F83C2-7154-47C1-B88A-A7288B30FC4F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
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



Am 6=2E Juli 2026 16:28:55 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@nx=
p=2Ecom>:
>From: Bernhard Beschow <shentey@gmail=2Ecom>
>
>Add emulation of the i=2EMX8MP System Reset Controller=2E
>The SRC manages reset control for various subsystems on the i=2EMX8MP SoC=
=2E
>SRC registers are used to start/stop/poll the M7 core, hence needed for
>AMP boot=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> docs/system/arm/imx8m=2Erst    |   1 +
> hw/arm/Kconfig               |   1 +
> hw/arm/fsl-imx8mp=2Ec          |  10 ++
> hw/misc/Kconfig              |   3 +
> hw/misc/imx8mp_src=2Ec         | 275 +++++++++++++++++++++++++++++++++++
> hw/misc/meson=2Ebuild          |   1 +
> hw/misc/trace-events         |   5 +
> include/hw/arm/fsl-imx8mp=2Eh  |   2 +
> include/hw/misc/imx8mp_src=2Eh |  31 ++++
> 9 files changed, 329 insertions(+)
> create mode 100644 hw/misc/imx8mp_src=2Ec
> create mode 100644 include/hw/misc/imx8mp_src=2Eh
>
>diff --git a/docs/system/arm/imx8m=2Erst b/docs/system/arm/imx8m=2Erst
>index 1e110bc810=2E=2E49c100c4b1 100644
>--- a/docs/system/arm/imx8m=2Erst
>+++ b/docs/system/arm/imx8m=2Erst
>@@ -27,6 +27,7 @@ following devices:
>  * Clock Tree
>  * General Power Controller (GPC)
>  * General Purpose Register (GPR)
>+ * System Reset Controller (SRC)

Let's avoid introducing abbreviations we don't use later=2E This one as we=
ll as GPC, GPR, etc=2E

>=20
> Boot options
> ------------
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index 382819fb7b=2E=2E382b454b49 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -604,6 +604,7 @@ config FSL_IMX8MP
>     select FSL_IMX8MP_CCM
>     select FSL_IMX8MP_GPC
>     select FSL_IMX8MP_GPR
>+    select FSL_IMX8MP_SRC
>     select IMX
>     select IMX_FEC
>     select IMX_I2C
>diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>index c4aafbdc1c=2E=2E168fcb0334 100644
>--- a/hw/arm/fsl-imx8mp=2Ec
>+++ b/hw/arm/fsl-imx8mp=2Ec
>@@ -208,6 +208,8 @@ static void fsl_imx8mp_init(Object *obj)
>=20
>     object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX8MP_GPR);
>=20
>+    object_initialize_child(obj, "src", &s->src, TYPE_IMX8MP_SRC);
>+
>     for (i =3D 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
>         g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
>         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL)=
;
>@@ -426,6 +428,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>                            qdev_get_gpio_in(gicdev, serial_table[i]=2Eir=
q));
>     }
>=20
>+    /* SRC */
>+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
>+        return;
>+    }
>+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0,
>+                    fsl_imx8mp_memmap[FSL_IMX8MP_SRC]=2Eaddr);
>+
>     /* GPC */
>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpc), errp)) {
>         return;
>@@ -716,6 +725,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
>         case FSL_IMX8MP_PCIE_PHY1:
>         case FSL_IMX8MP_RAM:
>         case FSL_IMX8MP_SNVS_HP:
>+        case FSL_IMX8MP_SRC:
>         case FSL_IMX8MP_UART1 =2E=2E=2E FSL_IMX8MP_UART4:
>         case FSL_IMX8MP_USB1 =2E=2E=2E FSL_IMX8MP_USB2:
>         case FSL_IMX8MP_USDHC1 =2E=2E=2E FSL_IMX8MP_USDHC3:
>diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>index 1d09474545=2E=2E0f63a85924 100644
>--- a/hw/misc/Kconfig
>+++ b/hw/misc/Kconfig
>@@ -107,6 +107,9 @@ config FSL_IMX8MP_GPC
> config FSL_IMX8MP_GPR
>     bool
>=20
>+config FSL_IMX8MP_SRC
>+    bool
>+
> config STM32_RCC
>     bool
>=20
>diff --git a/hw/misc/imx8mp_src=2Ec b/hw/misc/imx8mp_src=2Ec
>new file mode 100644
>index 0000000000=2E=2E8e5e357775
>--- /dev/null
>+++ b/hw/misc/imx8mp_src=2Ec
>@@ -0,0 +1,275 @@
>+/*
>+ * i=2EMX 8M Plus System Reset Controller
>+ *
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/misc/imx8mp_src=2Eh"
>+#include "hw/core/resettable=2Eh"
>+#include "hw/core/registerfields=2Eh"
>+#include "migration/vmstate=2Eh"
>+#include "qemu/log=2Eh"
>+#include "trace=2Eh"
>+
>+REG32(SRC_SCR, 0x0000)
>+
>+REG32(SRC_A53RCR0, 0x0004)
>+
>+REG32(SRC_A53RCR1, 0x0008)
>+
>+REG32(SRC_M7RCR, 0x000c)
>+REG32(SRC_SUPERMIX_RCR, 0x0018)
>+REG32(SRC_AUDIOMIX_RCR, 0x001c)
>+REG32(SRC_USBPHY1_RCR, 0x0020)
>+REG32(SRC_USBPHY2_RCR, 0x0024)
>+REG32(SRC_MLMIX_RCR, 0x0028)
>+REG32(SRC_PCIEPHY_RCR, 0x002c)
>+REG32(SRC_HDMI_RCR, 0x0030)
>+REG32(SRC_MEDIA_RCR, 0x0034)
>+REG32(SRC_GPU2D_RCR, 0x0038)
>+REG32(SRC_GPU3D_RCR, 0x003c)
>+REG32(SRC_GPU_RCR, 0x0040)
>+REG32(SRC_VPU_RCR, 0x0044)
>+REG32(SRC_VPU_G1_RCR, 0x0048)
>+REG32(SRC_VPU_G2_RCR, 0x004c)
>+REG32(SRC_VPUVC8KE_RCR, 0x0050)
>+REG32(SRC_NOC_RCR, 0x0054)
>+REG32(SRC_SBMR1, 0x0058)
>+REG32(SRC_SRSR, 0x005c)
>+REG32(SRC_SISR, 0x0068)
>+REG32(SRC_SIMR, 0x006c)
>+
>+REG32(SRC_SBMR2, 0x0070)
>+
>+REG32(SRC_GPR1, 0x0074)
>+REG32(SRC_GPR2, 0x0078)
>+REG32(SRC_GPR3, 0x007c)
>+REG32(SRC_GPR4, 0x0080)
>+REG32(SRC_GPR5, 0x0084)
>+REG32(SRC_GPR6, 0x0088)
>+REG32(SRC_GPR7, 0x008c)
>+REG32(SRC_GPR8, 0x0090)
>+REG32(SRC_GPR9, 0x0094)
>+REG32(SRC_GPR10, 0x0098)
>+REG32(SRC_DDRC_RCR, 0x1000)
>+REG32(SRC_HDMIPHY_RCR, 0x1008)
>+REG32(SRC_MIPIPHY1_RCR, 0x100c)
>+REG32(SRC_MIPIPHY2_RCR, 0x1010)
>+REG32(SRC_HSIO_RCR, 0x1014)
>+REG32(SRC_MEDIAISPDWP_RCR, 0x1018)
>+
>+static const char *fsl_imx8mp_src_reg_name(uint32_t reg)
>+{
>+    switch (reg) {
>+    case R_SRC_SCR:
>+        return " (SRC_SCR)";
>+    case R_SRC_A53RCR0:
>+        return " (SRC_A53RCR0)";
>+    case R_SRC_A53RCR1:
>+        return " (SRC_A53RCR1)";
>+    case R_SRC_M7RCR:
>+        return " (SRC_M7RCR)";
>+    case R_SRC_SUPERMIX_RCR:
>+        return " (SRC_SUPERMIX_RCR)";
>+    case R_SRC_AUDIOMIX_RCR:
>+        return " (SRC_AUDIOMIX_RCR)";
>+    case R_SRC_USBPHY1_RCR:
>+        return " (SRC_USBPHY1_RCR)";
>+    case R_SRC_USBPHY2_RCR:
>+        return " (SRC_USBPHY2_RCR)";
>+    case R_SRC_MLMIX_RCR:
>+        return " (SRC_MLMIX_RCR)";
>+    case R_SRC_PCIEPHY_RCR:
>+        return " (SRC_PCIEPHY_RCR)";
>+    case R_SRC_HDMI_RCR:
>+        return " (SRC_HDMI_RCR)";
>+    case R_SRC_MEDIA_RCR:
>+        return " (SRC_MEDIA_RCR)";
>+    case R_SRC_GPU2D_RCR:
>+        return " (SRC_GPU2D_RCR)";
>+    case R_SRC_GPU3D_RCR:
>+        return " (SRC_GPU3D_RCR)";
>+    case R_SRC_GPU_RCR:
>+        return " (SRC_GPU_RCR)";
>+    case R_SRC_VPU_RCR:
>+        return " (SRC_VPU_RCR)";
>+    case R_SRC_VPU_G1_RCR:
>+        return " (SRC_VPU_G1_RCR)";
>+    case R_SRC_VPU_G2_RCR:
>+        return " (SRC_VPU_G2_RCR)";
>+    case R_SRC_VPUVC8KE_RCR:
>+        return " (SRC_VPUVC8KE_RCR)";
>+    case R_SRC_NOC_RCR:
>+        return " (SRC_NOC_RCR)";
>+    case R_SRC_SBMR1:
>+        return " (SRC_SBMR1)";
>+    case R_SRC_SRSR:
>+        return " (SRC_SRSR)";
>+    case R_SRC_SISR:
>+        return " (SRC_SISR)";
>+    case R_SRC_SIMR:
>+        return " (SRC_SIMR)";
>+    case R_SRC_SBMR2:
>+        return " (SRC_SBMR2)";
>+    case R_SRC_GPR1:
>+        return " (SRC_GPR1)";
>+    case R_SRC_GPR2:
>+        return " (SRC_GPR2)";
>+    case R_SRC_GPR3:
>+        return " (SRC_GPR3)";
>+    case R_SRC_GPR4:
>+        return " (SRC_GPR4)";
>+    case R_SRC_GPR5:
>+        return " (SRC_GPR5)";
>+    case R_SRC_GPR6:
>+        return " (SRC_GPR6)";
>+    case R_SRC_GPR7:
>+        return " (SRC_GPR7)";
>+    case R_SRC_GPR8:
>+        return " (SRC_GPR8)";
>+    case R_SRC_GPR9:
>+        return " (SRC_GPR9)";
>+    case R_SRC_GPR10:
>+        return " (SRC_GPR10)";
>+    case R_SRC_DDRC_RCR:
>+        return " (SRC_DDRC_RCR)";
>+    case R_SRC_HDMIPHY_RCR:
>+        return " (SRC_HDMIPHY_RCR)";
>+    case R_SRC_MIPIPHY1_RCR:
>+        return " (SRC_MIPIPHY1_RCR)";
>+    case R_SRC_MIPIPHY2_RCR:
>+        return " (SRC_MIPIPHY2_RCR)";
>+    case R_SRC_HSIO_RCR:
>+        return " (SRC_HSIO_RCR)";
>+    case R_SRC_MEDIAISPDWP_RCR:
>+        return " (SRC_MEDIAISPDWP_RCR)";
>+    default:
>+        return " (reserved)";
>+    }
>+}
>+
>+static uint64_t fsl_imx8mp_src_read(void *opaque, hwaddr offset,
>+                                    unsigned size)
>+{
>+    FslImx8mpSrcState *s =3D opaque;
>+    const uint32_t reg =3D offset / 4;
>+    uint32_t value =3D 0;
>+
>+    switch (reg) {
>+    default:
>+        if (reg < FSL_IMX8MP_SRC_NUM_REGS) {
>+            value =3D s->regs[reg];
>+        }
>+        qemu_log_mask(LOG_UNIMP, "[%s]%s: Unimplemented register at offs=
et 0x%"
>+                      HWADDR_PRIx "\n", TYPE_IMX8MP_SRC, __func__,
>+                      offset);
>+        break;
>+    }
>+
>+    trace_fsl_imx8mp_src_read(offset, fsl_imx8mp_src_reg_name(reg), valu=
e);
>+
>+    return value;
>+}
>+
>+static ResettablePhases imx8mp_src_parent_phases;

A freestanding global variable like this should be avoided and instead be =
placed into a class struct=2E I wonder if we want or need to call the paren=
t impl in the first place=2E Peter?

>+
>+static void imx8mp_src_reset_enter(Object *obj, ResetType type)
>+{
>+    FslImx8mpSrcState *s =3D IMX8MP_SRC(obj);
>+
>+    if (imx8mp_src_parent_phases=2Eenter) {
>+        imx8mp_src_parent_phases=2Eenter(obj, type);
>+    }
>+
>+    memset(s->regs, 0, sizeof(s->regs));
>+
>+    /*
>+     * Default CM7 STOP state for Linux imx-rproc MMIO mode detection=2E
>+    */
>+    s->regs[R_SRC_M7RCR] =3D 0x000000A8;
>+}

Let's not interrupt the MemoryRegionOps section with reset code and instea=
d move it down, e=2Eg=2E just in front of realize (as in the original versi=
on)=2E

Best regards,
Bernhard

>+
>+static void fsl_imx8mp_src_write(void *opaque, hwaddr offset, uint64_t v=
alue,
>+                                 unsigned size)
>+{
>+    FslImx8mpSrcState *s =3D opaque;
>+    const uint32_t reg =3D offset / 4;
>+
>+    switch (reg) {
>+    default:
>+        if (reg < FSL_IMX8MP_SRC_NUM_REGS) {
>+            s->regs[reg] =3D value;
>+        }
>+        qemu_log_mask(LOG_UNIMP, "[%s]%s: Unimplemented register at offs=
et 0x%"
>+                      HWADDR_PRIx "\n", TYPE_IMX8MP_SRC, __func__,
>+                      offset);
>+        break;
>+    }
>+
>+    trace_fsl_imx8mp_src_write(offset, fsl_imx8mp_src_reg_name(reg), val=
ue);
>+}
>+
>+static const struct  imx8mp_src_ops =3D {
>+    =2Eread =3D fsl_imx8mp_src_read,
>+    =2Ewrite =3D fsl_imx8mp_src_write,
>+    =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>+    =2Evalid =3D {
>+        /*
>+         * Our device would not work correctly if the guest was doing
>+         * unaligned access=2E This might not be a limitation on the rea=
l
>+         * device but in practice there is no reason for a guest to acce=
ss
>+         * this device unaligned=2E
>+         */
>+        =2Emin_access_size =3D 4,
>+        =2Emax_access_size =3D 4,
>+        =2Eunaligned =3D false,
>+    },
>+};
>+
>+static void imx8mp_src_realize(DeviceState *dev, Error **errp)
>+{
>+    FslImx8mpSrcState *s =3D IMX8MP_SRC(dev);
>+
>+    memory_region_init_io(&s->iomem, OBJECT(dev), &imx8mp_src_ops, s,
>+                          TYPE_IMX8MP_SRC, 0x1000);
>+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>+}
>+
>+static const VMStateDescription imx8mp_src_vmstate =3D {
>+    =2Ename =3D TYPE_IMX8MP_SRC,
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_UINT32_ARRAY(regs, FslImx8mpSrcState, FSL_IMX8MP_SRC_NUM=
_REGS),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
>+static void imx8mp_src_class_init(ObjectClass *klass, const void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>+
>+    resettable_class_set_parent_phases(rc,
>+                                       imx8mp_src_reset_enter,
>+                                       NULL,
>+                                       NULL,
>+                                       &imx8mp_src_parent_phases);
>+    dc->realize =3D imx8mp_src_realize;
>+    dc->vmsd =3D &imx8mp_src_vmstate;
>+    dc->desc =3D "i=2EMX 8M Plus System Reset Controller";
>+}
>+
>+static const TypeInfo imx8mp_src_types[] =3D {
>+    {
>+        =2Ename          =3D TYPE_IMX8MP_SRC,
>+        =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>+        =2Einstance_size =3D sizeof(FslImx8mpSrcState),
>+        =2Eclass_init    =3D imx8mp_src_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(imx8mp_src_types)
>diff --git a/hw/misc/meson=2Ebuild b/hw/misc/meson=2Ebuild
>index bc2996c165=2E=2Ef71323bde7 100644
>--- a/hw/misc/meson=2Ebuild
>+++ b/hw/misc/meson=2Ebuild
>@@ -61,6 +61,7 @@ system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_tr=
ue: files('imx8mp_analog=2Ec'
> system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_cc=
m=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_GPC', if_true: files('imx8mp_gp=
c=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_GPR', if_true: files('imx8mp_gp=
r=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_SRC', if_true: files('imx8mp_sr=
c=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_IMX', if_true: files(
>   'imx25_ccm=2Ec',
>   'imx31_ccm=2Ec',
>diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>index 99910fc068=2E=2E7e67e52ea3 100644
>--- a/hw/misc/trace-events
>+++ b/hw/misc/trace-events
>@@ -129,6 +129,11 @@ imx7_gpr_write(uint64_t offset, uint64_t value) "add=
r 0x%08" PRIx64 "value 0x%08
> imx7_snvs_read(uint64_t offset, uint64_t value, unsigned size) "i=2EMX S=
NVS read: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
> imx7_snvs_write(uint64_t offset, uint64_t value, unsigned size) "i=2EMX =
SNVS write: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
>=20
>+# imx8mp_src=2Ec
>+fsl_imx8mp_src_read(uint64_t offset, const char *reg_name, uint32_t valu=
e) "[0x%" PRIx64 "%s] <- 0x%" PRIx32
>+fsl_imx8mp_src_write(uint64_t offset, const char *reg_name, uint64_t val=
ue) "[0x%" PRIx64 "%s] <- 0x%" PRIx64
>+fsl_imx8mp_src_clear_reset_bit(const char *reg_name, uint32_t value) "re=
g[%s] <=3D 0x%" PRIx32
>+
> # mos6522=2Ec
> mos6522_set_counter(int index, unsigned int val) "T%d=2Ecounter=3D%d"
> mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "lat=
ch=3D%d counter=3D0x%"PRIx64 " delta_next=3D0x%"PRIx64
>diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=2E=
h
>index b3aca1f692=2E=2Ec6c133cc05 100644
>--- a/include/hw/arm/fsl-imx8mp=2Eh
>+++ b/include/hw/arm/fsl-imx8mp=2Eh
>@@ -19,6 +19,7 @@
> #include "hw/misc/imx8mp_ccm=2Eh"
> #include "hw/misc/imx8mp_gpc=2Eh"
> #include "hw/misc/imx8mp_gpr=2Eh"
>+#include "hw/misc/imx8mp_src=2Eh"
> #include "hw/net/imx_fec=2Eh"
> #include "hw/core/or-irq=2Eh"
> #include "hw/pci-host/designware=2Eh"
>@@ -64,6 +65,7 @@ struct FslImx8mpState {
>     IMX8MPAnalogState  analog;
>     IMX7SNVSState      snvs;
>     IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
>+    FslImx8mpSrcState  src;
>     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
>     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
>     IMXFECState        enet;
>diff --git a/include/hw/misc/imx8mp_src=2Eh b/include/hw/misc/imx8mp_src=
=2Eh
>new file mode 100644
>index 0000000000=2E=2E2a8c1ca2bd
>--- /dev/null
>+++ b/include/hw/misc/imx8mp_src=2Eh
>@@ -0,0 +1,31 @@
>+/*
>+ * i=2EMX 8M Plus System Reset Controller
>+ *
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#ifndef FSL_IMX8MP_SRC_H
>+#define FSL_IMX8MP_SRC_H
>+
>+#include "hw/core/sysbus=2Eh"
>+#include "system/memory=2Eh"
>+#include "qom/object=2Eh"
>+
>+#define TYPE_IMX8MP_SRC "fsl-imx8mp-src"
>+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpSrcState, IMX8MP_SRC)
>+
>+#define FSL_IMX8MP_SRC_NUM_REGS (0x100 / 4)
>+
>+struct FslImx8mpSrcState {
>+    SysBusDevice parent_obj;
>+
>+    MemoryRegion iomem;
>+
>+    uint32_t regs[FSL_IMX8MP_SRC_NUM_REGS];
>+};
>+
>+void imx8mp_src_start_cpu(FslImx8mpSrcState *s, int cpuid);
>+
>+#endif /* FSL_IMX8MP_SRC_H */

