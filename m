Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E50FA374B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 14:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbgZh-0004wQ-S2; Fri, 02 Jan 2026 09:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbgZd-0004vV-R2
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 09:56:17 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbgZY-0000aD-HO
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 09:56:14 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso6607242f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767365771; x=1767970571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUIW7z2yIP3La9hQHRhbF9fczpypgO4LvHUwqtMhljM=;
 b=Ie4VfWcyk5tmac7Ez2XD0pS6p08LhLgU06LE8R919oBNvS5VQ+83FM21WpSZsP1jDg
 0blaH6JMrYNLOiBaRG9nd5v0xfiR21MOtzcTh1Zjz3mm0nfIADWJpO9/OndWRtDpix30
 a07kBmQBBhl+acFx0WsB032YuqMMxzM9oeBboVRjBSipbUREb8BZy4X3oRgM15nRiWms
 moDv087iK21rGR27O3yeAcD7h/3KFDtJ4wQ1+p+d7L9eOsQc8TBMjsLt22hcs49fb6zq
 UVmGW5l4Lu/f0iyPsi9l94QpMaN39hxYSmgbVz2Y0JMHHE2Hmo06dF7cbvmX5RPP6TIK
 +RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767365771; x=1767970571;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUIW7z2yIP3La9hQHRhbF9fczpypgO4LvHUwqtMhljM=;
 b=btdayveORz/Wu0QeFmDGSCQ1L79vR8tRwf8r7t+0hxwplEqQXiSuoWL8GOVhI1qIon
 k+m+4zsMvIf4lQ3iKgCWBMzi3Kc6bGg6PGct/fQXa3/AwkFUUi4rlCL+4eYQ2vUfECDG
 gbna8IWFwE9/efRJS1SuVXjzwqX+jTpIuyvT/MOcWrAMayuv4pbVQ5mKGhN0pq8pbk93
 BM3qr+ay/GFS8UGEUulgTYvV7hYFEypTKGVPG9RWOdBuRQCwzQJUO06thIG8WAglvEOI
 HR9WVnKAcvIUmpBpqumBtBA2E6h3+ctYYje6mOYzWryZ3pQmODb1ax1Hm04lMJTCI12w
 WsPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKzdRVZ8kjrH9IlyVbZc0m2dBBRAHchiSR9c7jW5kwZJNkIy2Ua5cj410YtUFUqWH/nDNFf9Eo0N4v@nongnu.org
X-Gm-Message-State: AOJu0Yxv1teUqopoOr1orRMYqLjfbl5WBmUDzXe6xG2hOAzcWyK5GeDH
 tTvVVldnYTyI34MXXNNgbtAId+Q5mv6yAaDYE0HzDT1oi+/xAcp/a9i5
X-Gm-Gg: AY/fxX5FIxehsmwgpO7Cymdzk46kLtrKmgKWPdvvvZ7Ig9MwzXdMQHkUGSvyy/tc1ML
 x8Av0CszPv/2wZcnRwN1kkVIPA9foovpwWmCkaCTrcuCdQ8tXuquQL/6dewho3uGhme46YI23U4
 M3VwRT8aAOQe1TuesJySXZqiV70SFT3DTF3M6CjHnWm/uOZyYHfSAtOtXvIwmp7OEcn2EhG8V+T
 XSG491tq8Ju7eGyuK8MjM0KzydHvK0Yi2uvVnKdZKpdhTLVWV62lvK7IATI8nGkzc///hiISrI0
 N0S5EtLoPSo8YKwzrdf0zKd35Q1Vu9/q+w644J//ISImtGOgHQf4/ozv0dWs3fhnIXoGhTOK4Tg
 S9ugzPX7rQsmgZlMvb2Y0JB6CtkK3NvugmTa0jbxvQDCtPca7NBSxmI+QZolrHOqAwcFIJDiv9s
 w/SbvFh2pWWnOgx1WCImU41JqsF718bc0iiwhnfoNPlpXqWFOXIS86/jiQtTYW3Eq80pjCeRkQ1
 iAAJr54oWI9JiPMtkMfyVwtEEm9y7UevcM=
X-Google-Smtp-Source: AGHT+IHEdKtBIgDJtrVZc7Lrn//YPFmnpf3fPZuboDmJHA9O4vJSaZhzzfGXoa2TF8CbJQ3cjrLHgw==
X-Received: by 2002:a05:6000:2890:b0:431:808:2d60 with SMTP id
 ffacd0b85a97d-4324e4c23a1mr63516993f8f.12.1767365770734; 
 Fri, 02 Jan 2026 06:56:10 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-237d-1400-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:237d:1400:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm83873423f8f.33.2026.01.02.06.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 06:56:10 -0800 (PST)
Date: Fri, 02 Jan 2026 14:56:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 4/6] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
In-Reply-To: <e3ce5bc65896f0cca0f641150ad09ddc2480d3e8.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <e3ce5bc65896f0cca0f641150ad09ddc2480d3e8.1765826753.git.matyas.bobek@gmail.com>
Message-ID: <F0588357-4A20-4368-8EEE-F14499700718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
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



Am 15=2E Dezember 2025 20:03:13 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <maty=
as=2Ebobek@gmail=2Ecom>:
>FlexcanState is added to struct FslIMX6State like other peripherals=2E
>
>Add two new machine properties to Sabrelite machine for linking
>the embedded FlexCAN instances to QEMU CAN buses by name=2E
>No other machine uses FslIMX6State=2E
>
>Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>---
> hw/arm/Kconfig            |  1 +
> hw/arm/fsl-imx6=2Ec         | 29 +++++++++++++++++++++++++++++
> hw/arm/sabrelite=2Ec        | 18 +++++++++++++++++-
> include/hw/arm/fsl-imx6=2Eh |  7 +++++++
> 4 files changed, 54 insertions(+), 1 deletion(-)
>
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index 7877506384=2E=2E76aa7fee57 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -530,6 +530,7 @@ config FSL_IMX6
>     select IMX_FEC
>     select IMX_I2C
>     select IMX_USBPHY
>+    select CAN_FLEXCAN
>     select WDT_IMX2
>     select PL310  # cache controller
>     select PCI_EXPRESS_DESIGNWARE
>diff --git a/hw/arm/fsl-imx6=2Ec b/hw/arm/fsl-imx6=2Ec
>index f3a60022d8=2E=2E19656ba571 100644
>--- a/hw/arm/fsl-imx6=2Ec
>+++ b/hw/arm/fsl-imx6=2Ec
>@@ -97,6 +97,10 @@ static void fsl_imx6_init(Object *obj)
>         snprintf(name, NAME_SIZE, "spi%d", i + 1);
>         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
>     }
>+    for (i =3D 0; i < FSL_IMX6_NUM_CANS; i++) {
>+        snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
>+        object_initialize_child(obj, name, &s->can[i], TYPE_CAN_FLEXCAN)=
;
>+    }
>     for (i =3D 0; i < FSL_IMX6_NUM_WDTS; i++) {
>         snprintf(name, NAME_SIZE, "wdt%d", i);
>         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
>@@ -379,6 +383,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error=
 **errp)
>                            qdev_get_gpio_in(gic, spi_table[i]=2Eirq));
>     }
>=20
>+    /* Initialize all FLEXCANs */
>+    for (i =3D 0; i < FSL_IMX6_NUM_CANS; i++) {
>+        static const struct {
>+            hwaddr addr;
>+            unsigned int irq;
>+        } flexcan_table[FSL_IMX6_NUM_CANS] =3D {
>+            { FSL_IMX6_CAN1_ADDR, FSL_IMX6_FLEXCAN1_IRQ },
>+            { FSL_IMX6_CAN2_ADDR, FSL_IMX6_FLEXCAN2_IRQ },
>+        };
>+
>+        s->can[i]=2Eccm =3D IMX_CCM(&s->ccm);
>+        object_property_set_link(OBJECT(&s->can[i]), "canbus",
>+                                 OBJECT(s->canbus[i]), &error_abort);
>+
>+        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &error_abort);
>+
>+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, flexcan_table[i]=
=2Eaddr);
>+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
>+                           qdev_get_gpio_in(gic, flexcan_table[i]=2Eirq)=
);
>+    }
>+
>     object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
>                              &error_abort);
>     qemu_configure_nic_device(DEVICE(&s->eth), true, NULL);
>@@ -482,6 +507,10 @@ static void fsl_imx6_realize(DeviceState *dev, Error=
 **errp)
>=20
> static const Property fsl_imx6_properties[] =3D {
>     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
>+    DEFINE_PROP_LINK("canbus0", FslIMX6State, canbus[0], TYPE_CAN_BUS,
>+                     CanBusState *),
>+    DEFINE_PROP_LINK("canbus1", FslIMX6State, canbus[1], TYPE_CAN_BUS,
>+                     CanBusState *),
> };
>=20
> static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
>diff --git a/hw/arm/sabrelite=2Ec b/hw/arm/sabrelite=2Ec
>index 29418af190=2E=2E4bb8fe80d5 100644
>--- a/hw/arm/sabrelite=2Ec
>+++ b/hw/arm/sabrelite=2Ec
>@@ -23,6 +23,7 @@
> typedef struct SabreliteMachineState {
>     MachineState parent_obj;
>     FslIMX6State soc;
>+    CanBusState *canbus[FSL_IMX6_NUM_CANS];
>=20
>     struct arm_boot_info binfo;
> } Sabrelite;
>@@ -65,6 +66,13 @@ static void sabrelite_init(MachineState *machine)
>     /* Ethernet PHY address is 6 */
>     object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fa=
tal);
>=20
>+    for (int i =3D 0; i < FSL_IMX6_NUM_CANS; i++) {
>+        g_autofree char *bus_name =3D g_strdup_printf("canbus%d", i);
>+
>+        object_property_set_link(OBJECT(&s->soc), bus_name,
>+                                 OBJECT(s->canbus[i]), &error_fatal);
>+    }
>+
>     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
>=20
>     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
>@@ -118,7 +126,15 @@ static void sabrelite_machine_instance_init(Object *=
obj)
> {
>     Sabrelite *s =3D SABRELITE_MACHINE(obj);
>=20
>-    (void)s;
>+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
>+                             (Object **)&s->canbus[0],
>+                             object_property_allow_set_link,
>+                             0);
>+
>+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
>+                             (Object **)&s->canbus[1],
>+                             object_property_allow_set_link,
>+                             0);
> }
>=20
> static void sabrelite_machine_class_init(ObjectClass *oc, const void *da=
ta)
>diff --git a/include/hw/arm/fsl-imx6=2Eh b/include/hw/arm/fsl-imx6=2Eh
>index 124bbd478f=2E=2E8edbcebe46 100644
>--- a/include/hw/arm/fsl-imx6=2Eh
>+++ b/include/hw/arm/fsl-imx6=2Eh
>@@ -30,11 +30,13 @@
> #include "hw/sd/sdhci=2Eh"
> #include "hw/ssi/imx_spi=2Eh"
> #include "hw/net/imx_fec=2Eh"
>+#include "hw/net/flexcan=2Eh"
> #include "hw/usb/chipidea=2Eh"
> #include "hw/usb/imx-usb-phy=2Eh"
> #include "hw/pci-host/designware=2Eh"
> #include "hw/or-irq=2Eh"
> #include "system/memory=2Eh"
>+#include "net/can_emu=2Eh"
> #include "cpu=2Eh"
> #include "qom/object=2Eh"
>=20
>@@ -51,6 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
> #define FSL_IMX6_NUM_WDTS 2
> #define FSL_IMX6_NUM_USB_PHYS 2
> #define FSL_IMX6_NUM_USBS 4
>+#define FSL_IMX6_NUM_CANS 2
>=20
> struct FslIMX6State {
>     /*< private >*/
>@@ -73,6 +76,7 @@ struct FslIMX6State {
>     IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
>     ChipideaState      usb[FSL_IMX6_NUM_USBS];
>     IMXFECState        eth;
>+    FlexcanState       can[FSL_IMX6_NUM_CANS];
>     DesignwarePCIEHost pcie;
>     OrIRQState         pcie4_msi_irq;
>     MemoryRegion       rom;
>@@ -80,6 +84,9 @@ struct FslIMX6State {
>     MemoryRegion       ocram;
>     MemoryRegion       ocram_alias;
>     uint32_t           phy_num;
>+
>+    /* CAN bus=2E */

I'd remove the comment since it merely states the obvious=2E Not a big dea=
l though, so:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>+    CanBusState       *canbus[FSL_IMX6_NUM_CANS];
> };
>=20
>=20

