Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3F9F43687
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfNA-0001c5-4C; Fri, 17 Apr 2026 05:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wDfN8-0001bx-6K
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:20:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wDfN6-0001SC-3P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:20:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so7143505e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776417618; x=1777022418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U4MAbSiDKDxo1l2wcYzuA5kDZsB+aQOQQmMqvYDQOs=;
 b=OJgp+tp245Ywke1AV/hkGz3M60Enf+Y3RDFys5vlEhYFuFMbp2dD2jLdOKzFmPi+2I
 Zqrft78E2Q7PBLKxoqwV0OO6knnr7e3Z7E73b17aapRYv62xnzhG1OB0Ax4wEhSfc2cD
 XT+Zn2m5OyQgbjHXgD5SYxo52kPknwyrS5Ui6oZDxd4Od7Ob/FMsrGm+4Z6AsM78kwuh
 dOCmFtkwH698BsHqPQL2OsyT3knSZX/aHRJz8c3CqLuS9f5aOA8XhZCMDNKigzIldae3
 REmDHQFJWluKDUvOiIjWherdZzMtq66KObVw7Zv29NzqaNWypECa6rYRjq/yo0tZMpqm
 xYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776417618; x=1777022418;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3U4MAbSiDKDxo1l2wcYzuA5kDZsB+aQOQQmMqvYDQOs=;
 b=sMagR7vZlH7uMX9C4mnCfHnNHAaIyT7jRWO14G7LIBP9GSMBS3dQQcL0lPpGj4+54P
 E/f69l4uTJcf3ONSUjWYs1wkT2teTMiaoaouNetghNuwbZIxKObGOZnLBniNpg2V7zLQ
 jbEYZPgAtGP4ckTsGGm+Pf9QYMLrVsOswqjUjsnxj+gvrBxDcbDkdB2V+HLKpqq57dVZ
 bVHZpBFlUySQ4dGeCVb4CU4yhm3pIE/OP73sstS9U3oEVFARt+EaYsdlwEmD/iGR+BIe
 QXoEtaZXu9O/6U5v2EFtKb3TN/kg3OM4cnOLGiTIpsRj8V4pEWkvYFHOyOx1/ioJEH/+
 GWNw==
X-Gm-Message-State: AOJu0Yya2b6XwilWD+iW/QAw9rRenYvur9mkeuYfAR4cM7DzXDRV0MFJ
 tGiVX8fJMNc4yVJJTmhvspLMUJBm1qdpAitB+eKof7zgIdA6COW/WU6qRtGaow==
X-Gm-Gg: AeBDieuRKk/cInWbV9Le2Mc74iH/LOxRjeBvGZ9n42PRd/t3rb2yVS9K3/TIWRrn+Ja
 R3jz+x9PSnbp/1RD1Q5PrFPZiS20JXMq4Fm8ndY9TeqbkZGGs14zLY9KDtRtY6XfqFqxunwL7+u
 GZ9wYP6HGXxpD9TrEYEjaNR/b0D9oHcQ09Q525NpGweTyBp0UY6uqxmqtxOjM8RkMnJt/vU+RxN
 aExv86LfQCnLCpXoKu0W9ULgG6ReoVt3YhkoegArXEJhHv52zqLJfub8cEZcbUb5YEz5RBXNNWf
 Wc0+rOxNZkwU5rbVJrC5VYiXnW5kn+V87X7AO+UrryVcFQGJIx4II4gzd8/UpYR1m2V7k38dAaF
 eZT9HaPkeckMwQ+TaX0X2aZyRvu0kwZgkoVYIkjmzFQYNhcbElAaNksiq5pSWk/qfYMTPKIbVDt
 jEQDV8QlVlD7dwIUyC1w3eodV5HxSrQ/S2apXIvYEuZ3eY2zLJrqpasRXMcRtudfsr0pF8qHFy6
 lNz0wuKHbCNbVASHDYHuy+Lt/l/cNSN
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-488fb6e815amr30762155e9.0.1776417617577; 
 Fri, 17 Apr 2026 02:20:17 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100c87fe1c3d3c00c97.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:c87f:e1c3:d3c0:c97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm12738175e9.11.2026.04.17.02.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 02:20:17 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:20:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv6_12/15=5D_hw/arm/fsl-imx8mm=3A_A?=
 =?US-ASCII?Q?dding_support_for_General_Purpose_Timers?=
In-Reply-To: <20260414182313.1691519-13-gaurav.sharma_7@nxp.com>
References: <20260414182313.1691519-1-gaurav.sharma_7@nxp.com>
 <20260414182313.1691519-13-gaurav.sharma_7@nxp.com>
Message-ID: <F6937551-6B4D-483B-BCB9-8766E225BBDB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 14=2E April 2026 18:23:10 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:
>It enables emulation of GPT in iMX8MM
>Added GPT IRQ lines
>
>Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> hw/arm/Kconfig              |  1 +
> hw/arm/fsl-imx8mm=2Ec         | 56 ++++++++++++++++++++++++++++++++++++-
> hw/timer/imx_gpt=2Ec          | 26 +++++++++++++++++
> include/hw/arm/fsl-imx8mm=2Eh | 11 ++++++++
> include/hw/timer/imx_gpt=2Eh  |  2 ++
> 5 files changed, 95 insertions(+), 1 deletion(-)
>
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index 946c9eb693=2E=2E07a3f3273b 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -627,6 +627,7 @@ config FSL_IMX8MM
>     select FSL_IMX8MP_CCM
>     select IMX
>     select IMX_I2C
>+    select OR_IRQ
>     select SDHCI
>     select PCI_EXPRESS_DESIGNWARE
>     select PCI_EXPRESS_FSL_IMX8M_PHY
>diff --git a/hw/arm/fsl-imx8mm=2Ec b/hw/arm/fsl-imx8mm=2Ec
>index 34645555d6=2E=2Ee3c618751b 100644
>--- a/hw/arm/fsl-imx8mm=2Ec
>+++ b/hw/arm/fsl-imx8mm=2Ec
>@@ -180,6 +180,13 @@ static void fsl_imx8mm_init(Object *obj)
>         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL)=
;
>     }
>=20
>+    for (i =3D 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
>+        g_autofree char *name =3D g_strdup_printf("gpt%d", i + 1);
>+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX8MM_GPT);
>+    }
>+    object_initialize_child(obj, "gpt5-gpt6-irq", &s->gpt5_gpt6_irq,
>+                            TYPE_OR_IRQ);
>+
>     for (i =3D 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
>         g_autofree char *name =3D g_strdup_printf("i2c%d", i + 1);
>         object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
>@@ -385,6 +392,52 @@ static void fsl_imx8mm_realize(DeviceState *dev, Err=
or **errp)
>                                 fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM]=2Ead=
dr,
>                                 &s->ocram);
>=20
>+    /* GPTs */
>+    object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
>+                            &error_abort);
>+    if (!qdev_realize(DEVICE(&s->gpt5_gpt6_irq), NULL, errp)) {
>+        return;
>+    }
>+
>+    qdev_connect_gpio_out(DEVICE(&s->gpt5_gpt6_irq), 0,
>+                          qdev_get_gpio_in(gicdev, FSL_IMX8MM_GPT5_GPT6_=
IRQ));
>+
>+    for (i =3D 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
>+        hwaddr gpt_addrs[FSL_IMX8MM_NUM_GPTS] =3D {
>+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT1]=2Eaddr,
>+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT2]=2Eaddr,
>+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT3]=2Eaddr,
>+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT4]=2Eaddr,
>+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT5]=2Eaddr,
>+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT6]=2Eaddr,
>+        };
>+
>+        s->gpt[i]=2Eccm =3D IMX_CCM(&s->ccm);
>+
>+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
>+            return;
>+        }
>+
>+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_addrs[i]);
>+
>+        if (i < FSL_IMX8MM_NUM_GPTS - 2) {
>+            static const unsigned int gpt_irqs[FSL_IMX8MM_NUM_GPTS - 2] =
=3D {
>+                FSL_IMX8MM_GPT1_IRQ,
>+                FSL_IMX8MM_GPT2_IRQ,
>+                FSL_IMX8MM_GPT3_IRQ,
>+                FSL_IMX8MM_GPT4_IRQ,
>+            };
>+
>+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
>+                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
>+        } else {
>+            int irq =3D i - FSL_IMX8MM_NUM_GPTS + 2;
>+
>+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
>+                               qdev_get_gpio_in(DEVICE(&s->gpt5_gpt6_irq=
), irq));
>+        }
>+    }
>+
>     /* I2Cs */
>     for (i =3D 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
>         static const struct {
>@@ -555,7 +608,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Erro=
r **errp)
>         case FSL_IMX8MM_GIC_DIST:
>         case FSL_IMX8MM_GIC_REDIST:
>         case FSL_IMX8MM_GPIO1 =2E=2E=2E FSL_IMX8MM_GPIO5:
>-        case FSL_IMX8MM_ECSPI1 =2E=2E=2E FSL_IMX8MM_ECSPI3:
>+        case FSL_IMX8MM_GPT1 =2E=2E=2E FSL_IMX8MM_GPT6:
>+    case FSL_IMX8MM_ECSPI1 =2E=2E=2E FSL_IMX8MM_ECSPI3:

Existing case label gets wrong indentation which you fix in the next patch=
 again=2E

>         case FSL_IMX8MM_I2C1 =2E=2E=2E FSL_IMX8MM_I2C4:
>         case FSL_IMX8MM_PCIE1:
>         case FSL_IMX8MM_PCIE_PHY1:
>diff --git a/hw/timer/imx_gpt=2Ec b/hw/timer/imx_gpt=2Ec
>index 168cadcb3f=2E=2Ecdc0257126 100644
>--- a/hw/timer/imx_gpt=2Ec
>+++ b/hw/timer/imx_gpt=2Ec
>@@ -6,6 +6,7 @@
>  * Originally written by Hans Jiang
>  * Updated by Peter Chubb
>  * Updated by Jean-Christophe Dubois <jcd@tribudubois=2Enet>
>+ * Updated by Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>  *
>  * This code is licensed under GPL version 2 or later=2E  See
>  * the COPYING file in the top-level directory=2E
>@@ -137,6 +138,17 @@ static const IMXClk imx8mp_gpt_clocks[] =3D {
>     CLK_NONE,      /* 111 not defined */
> };
>=20
>+static const IMXClk imx8mm_gpt_clocks[] =3D {
>+    CLK_NONE,      /* 000 No clock source */
>+    CLK_IPG,       /* 001 ipg_clk, 532MHz */
>+    CLK_IPG_HIGH,  /* 010 ipg_clk_highfreq */
>+    CLK_EXT,       /* 011 External clock */
>+    CLK_32k,       /* 100 ipg_clk_32k */
>+    CLK_HIGH,      /* 101 ipg_clk_16M */
>+    CLK_NONE,      /* 110 not defined */
>+    CLK_NONE,      /* 111 not defined */
>+};
>+
> /* Must be called from within ptimer_transaction_begin/commit block */
> static void imx_gpt_set_freq(IMXGPTState *s)
> {
>@@ -570,6 +582,13 @@ static void imx8mp_gpt_init(Object *obj)
>     s->clocks =3D imx8mp_gpt_clocks;
> }
>=20
>+static void imx8mm_gpt_init(Object *obj)
>+{
>+    IMXGPTState *s =3D IMX_GPT(obj);
>+
>+    s->clocks =3D imx8mm_gpt_clocks;
>+}
>+
> static const TypeInfo imx25_gpt_info =3D {
>     =2Ename =3D TYPE_IMX25_GPT,
>     =2Eparent =3D TYPE_SYS_BUS_DEVICE,
>@@ -608,6 +627,12 @@ static const TypeInfo imx8mp_gpt_info =3D {
>     =2Einstance_init =3D imx8mp_gpt_init,
> };
>=20
>+static const TypeInfo imx8mm_gpt_info =3D {
>+    =2Ename =3D TYPE_IMX8MM_GPT,
>+    =2Eparent =3D TYPE_IMX25_GPT,
>+    =2Einstance_init =3D imx8mm_gpt_init,
>+};
>+
> static void imx_gpt_register_types(void)
> {
>     type_register_static(&imx25_gpt_info);
>@@ -616,6 +641,7 @@ static void imx_gpt_register_types(void)
>     type_register_static(&imx6ul_gpt_info);
>     type_register_static(&imx7_gpt_info);
>     type_register_static(&imx8mp_gpt_info);
>+    type_register_static(&imx8mm_gpt_info);
> }
>=20
> type_init(imx_gpt_register_types)
>diff --git a/include/hw/arm/fsl-imx8mm=2Eh b/include/hw/arm/fsl-imx8mm=2E=
h
>index fd62b19a87=2E=2E607ac86666 100644
>--- a/include/hw/arm/fsl-imx8mm=2Eh
>+++ b/include/hw/arm/fsl-imx8mm=2Eh
>@@ -18,10 +18,12 @@
> #include "hw/misc/imx7_snvs=2Eh"
> #include "hw/misc/imx8mp_analog=2Eh"
> #include "hw/misc/imx8mp_ccm=2Eh"
>+#include "hw/or-irq=2Eh"
> #include "hw/pci-host/designware=2Eh"
> #include "hw/pci-host/fsl_imx8m_phy=2Eh"
> #include "hw/sd/sdhci=2Eh"
> #include "hw/ssi/imx_spi=2Eh"
>+#include "hw/timer/imx_gpt=2Eh"
> #include "hw/watchdog/wdt_imx2=2Eh"
> #include "qom/object=2Eh"
> #include "qemu/units=2Eh"
>@@ -36,6 +38,7 @@ enum FslImx8mmConfiguration {
>     FSL_IMX8MM_NUM_CPUS         =3D 4,
>     FSL_IMX8MM_NUM_ECSPIS       =3D 3,
>     FSL_IMX8MM_NUM_GPIOS        =3D 5,
>+    FSL_IMX8MM_NUM_GPTS         =3D 6,
>     FSL_IMX8MM_NUM_I2CS         =3D 4,
>     FSL_IMX8MM_NUM_IRQS         =3D 128,
>     FSL_IMX8MM_NUM_UARTS        =3D 4,
>@@ -48,6 +51,7 @@ struct FslImx8mmState {
>=20
>     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
>     GICv3State         gic;
>+    IMXGPTState        gpt[FSL_IMX8MM_NUM_GPTS];
>     IMXGPIOState       gpio[FSL_IMX8MM_NUM_GPIOS];
>     IMX8MPCCMState     ccm;
>     IMX8MPAnalogState  analog;
>@@ -60,6 +64,7 @@ struct FslImx8mmState {
>     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
>     DesignwarePCIEHost pcie;
>     FslImx8mPciePhyState   pcie_phy;
>+    OrIRQState         gpt5_gpt6_irq;
> };
>=20
> enum FslImx8mmMemoryRegions {
>@@ -192,6 +197,12 @@ enum FslImx8mmIrqs {
>     FSL_IMX8MM_I2C3_IRQ     =3D 37,
>     FSL_IMX8MM_I2C4_IRQ     =3D 38,
>=20
>+    FSL_IMX8MM_GPT1_IRQ      =3D 55,
>+    FSL_IMX8MM_GPT2_IRQ      =3D 54,
>+    FSL_IMX8MM_GPT3_IRQ      =3D 53,
>+    FSL_IMX8MM_GPT4_IRQ      =3D 52,
>+    FSL_IMX8MM_GPT5_GPT6_IRQ =3D 51,
>+
>     FSL_IMX8MM_GPIO1_LOW_IRQ  =3D 64,
>     FSL_IMX8MM_GPIO1_HIGH_IRQ =3D 65,
>     FSL_IMX8MM_GPIO2_LOW_IRQ  =3D 66,
>diff --git a/include/hw/timer/imx_gpt=2Eh b/include/hw/timer/imx_gpt=2Eh
>index 7f0d55b349=2E=2Eb5d73c5e4b 100644
>--- a/include/hw/timer/imx_gpt=2Eh
>+++ b/include/hw/timer/imx_gpt=2Eh
>@@ -6,6 +6,7 @@
>  * Originally written by Hans Jiang
>  * Updated by Peter Chubb
>  * Updated by Jean-Christophe Dubois <jcd@tribudubois=2Enet>
>+ * Updated by Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>  *
>  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>  * of this software and associated documentation files (the "Software"),=
 to deal
>@@ -81,6 +82,7 @@
> #define TYPE_IMX6UL_GPT "imx6ul=2Egpt"
> #define TYPE_IMX7_GPT "imx7=2Egpt"
> #define TYPE_IMX8MP_GPT "imx8mp=2Egpt"
>+#define TYPE_IMX8MM_GPT "imx8mm=2Egpt"
>=20
> #define TYPE_IMX_GPT TYPE_IMX25_GPT
>=20

