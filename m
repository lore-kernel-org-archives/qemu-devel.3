Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC9F54ABA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52BA-0006V1-5m; Tue, 24 Mar 2026 09:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w52At-0006Gc-2a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:52:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w52Ap-0006py-4O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:52:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so2700817f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774360315; x=1774965115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNxcHylGEJrRuXK5LOihueLekjFUA3Rcv2HHQr54vi8=;
 b=sBgOExK/za+F9lHR+X3RHkr+bIGdXPQcgR6g9TWlzDbqI4NFiFikU/xVI3oAjsJnO9
 hIAPxIQd5VKvo59kzxNYr8+oVZFHaiP8aKuDj3uzwx8EynckdSvcCYfdvmAa8CQEOA6+
 wyuaFG6rL9H452sHTs7gtJkm516FFj3XlWYNQtOUNwfbKM8n+HmpdOPIJ2VcW12L1Fpq
 jIdLY3GTEqrkdYiiG2MDMarBAsFqof7xLC25d8PVRlnsd03o4c+hE0ZJfpKvM7UVSB67
 xoH0rnadzngk0VYcm8eBMM2j1Oa96HPEwYoQP55QzyicRJiMM389WqaxzIuqLOpxFHye
 tdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774360315; x=1774965115;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bNxcHylGEJrRuXK5LOihueLekjFUA3Rcv2HHQr54vi8=;
 b=BAl0UiGnzroX/LJYSKVx2MFO3SxWaxVLx4GaNp9RK+iHXOar4ozPMVw6auVsTfXuJ8
 dGfsfEvIYna1n7ENBfoyjbVcjXdvKJ3iIVls5IXd0GNXjPyKy/vcl64RnqIT0oK5aXx3
 92IaE+HqX45JLJL4z1pWFfDs9NQcoAaOOJczCJqP1Bx/K0SCYd+02XGjVXRLrEI3Ci2X
 4hr+Adz0iQqAESGtG12t16VMO47nT6/wYNOebEJxIXI5onLoeJgWLlQ4r2KWUpIayRGu
 s4mZcJVUjvGrq2StY8KuhEmeYqVqLHgthW07qhjRwUgMd77+4CN5hDMTeFgm/oFaoHrA
 6f4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUih+H8Kt+rCtw9kHt94ZrOsyTENIUEY/qSKdOd+HTELpfuo+qY2ei+lLrYkYyACOub4QzKh2f4rSES@nongnu.org
X-Gm-Message-State: AOJu0YzsuUxukbYbPZ12vWh+fs0GnfpLL6JwZI+gl+wAQR5h3TTioJej
 FtyqHCOfqvf55mbNnKoM3eAed71Dknl9RhgWwMlQFpkghKnN5gW32lmt
X-Gm-Gg: ATEYQzy0zCEuj6HSQhDAlWnNvSLedN3TMUV0Giw4iIycQINDdK3Ku1l8dtgduluOrK/
 730QWB47SSJ5jr6zWot0k9TLe6suBh7uhxHNwBKmioWOreZh1FwWU3LzWdAdnmfYKkYMSj6fENx
 ytels0FBUf/1+jE6y3TAytv/H7QhkeCqQipYK7OyHEQaKEDZ+6Ur0shjCsRknMsxmpDBfSDMrLu
 vjpGcRcCXZT5sHlVH8fSMafWeq90qwjHuv83XDIwapW4dXUj3R84ktGiSCUlu9EFS9JPLoEz7i8
 c4aBeOn2vK3e0ocSQtAjDLTh7qng2GE2JOu/y5AaR6YC2TkZRGkz5RMj/Asm96LqW+k8nMZuR6v
 6snYZAoL/dq3llOJPAFL4igLpLgDbibi3vQYxNG58r/7bYJFZ3piIZTn6E+9iX9txm3LZsnQgLn
 wbM8HGmA7hzTGW6vOB+nHa6/l08M557A==
X-Received: by 2002:a05:6000:2384:b0:43b:41b5:e021 with SMTP id
 ffacd0b85a97d-43b64243115mr26366044f8f.2.1774360314736; 
 Tue, 24 Mar 2026 06:51:54 -0700 (PDT)
Received: from ehlo.thunderbird.net ([90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bdaf8sm43784652f8f.13.2026.03.24.06.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 06:51:54 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:11:51 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/7=5D_hw/arm/sabrelite=3A_?=
 =?US-ASCII?Q?Introduce_class_SabreliteMachineState?=
In-Reply-To: <6b21c46dde0f562eba1a5e2dfd9dc8635daaedf1.1773866323.git.matyas.bobek@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <6b21c46dde0f562eba1a5e2dfd9dc8635daaedf1.1773866323.git.matyas.bobek@gmail.com>
Message-ID: <1C02DA1C-F933-4C4D-9518-FB1A5FDC1CF5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 19=2E M=C3=A4rz 2026 19:13:09 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <mat=
yas=2Ebobek@gmail=2Ecom>:
>Create full class SabreliteMachineState extending MachineState=2E
>
>Previously, Sabrelite board MachineState was declared indirectly by the
>DEFINE_MACHINE_ARM macro=2E FslIMX6State was only instantiated in the
>sabrelite_init function=2E For FlexCAN device, machine properties
>will be used to select QEMU CAN buses=2E A custom class is therefore
>required, so the CanBusState "connections" can then be added as fields=2E
>
>Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>---
> hw/arm/sabrelite=2Ec | 39 +++++++++++++++++++++------------------
> 1 file changed, 21 insertions(+), 18 deletions(-)
>
>diff --git a/hw/arm/sabrelite=2Ec b/hw/arm/sabrelite=2Ec
>index 40ee8196ac=2E=2E7e036e6388 100644
>--- a/hw/arm/sabrelite=2Ec
>+++ b/hw/arm/sabrelite=2Ec
>@@ -20,6 +20,15 @@
> #include "qemu/error-report=2Eh"
> #include "system/qtest=2Eh"
>=20
>+struct SabreliteMachineState {
>+    MachineState parent_obj;
>+
>+    FslIMX6State soc;
>+};
>+
>+#define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
>+OBJECT_DECLARE_SIMPLE_TYPE(SabreliteMachineState, SABRELITE_MACHINE)
>+
> static struct arm_boot_info sabrelite_binfo =3D {
>     /* DDR memory start */
>     =2Eloader_start =3D FSL_IMX6_MMDC_ADDR,
>@@ -41,7 +50,7 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
>=20
> static void sabrelite_init(MachineState *machine)
> {
>-    FslIMX6State *s;
>+    SabreliteMachineState *s =3D SABRELITE_MACHINE(machine);
>=20
>     /* Check the amount of memory is compatible with the SOC */
>     if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
>@@ -50,13 +59,12 @@ static void sabrelite_init(MachineState *machine)
>         exit(1);
>     }
>=20
>-    s =3D FSL_IMX6(object_new(TYPE_FSL_IMX6));
>-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IM=
X6);
>=20
>     /* Ethernet PHY address is 6 */
>-    object_property_set_int(OBJECT(s), "fec-phy-num", 6, &error_fatal);
>+    object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fa=
tal);
>=20
>-    qdev_realize(DEVICE(s), NULL, &error_fatal);
>+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
>=20
>     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
>                                 machine->ram);
>@@ -70,7 +78,7 @@ static void sabrelite_init(MachineState *machine)
>         /* Add the sst25vf016b NOR FLASH memory to first SPI */
>         Object *spi_dev;
>=20
>-        spi_dev =3D object_resolve_path_component(OBJECT(s), "spi1");
>+        spi_dev =3D object_resolve_path_component(OBJECT(&s->soc), "spi1=
");
>         if (spi_dev) {
>             SSIBus *spi_bus;
>=20
>@@ -89,7 +97,7 @@ static void sabrelite_init(MachineState *machine)
>                 qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_f=
atal);
>=20
>                 cs_line =3D qdev_get_gpio_in_named(flash_dev, SSI_GPIO_C=
S, 0);
>-                qdev_connect_gpio_out(DEVICE(&s->gpio[2]), 19, cs_line);
>+                qdev_connect_gpio_out(DEVICE(&s->soc=2Egpio[2]), 19, cs_=
line);
>             }
>         }
>     }
>@@ -100,12 +108,14 @@ static void sabrelite_init(MachineState *machine)
>     sabrelite_binfo=2Esecondary_cpu_reset_hook =3D sabrelite_reset_secon=
dary;
>=20
>     if (!qtest_enabled()) {
>-        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
>+        arm_load_kernel(&s->soc=2Ecpu[0], machine, &sabrelite_binfo);
>     }
> }
>=20
>-static void sabrelite_machine_init(MachineClass *mc)
>+static void sabrelite_machine_class_init(ObjectClass *oc, const void *da=
ta)
> {
>+    MachineClass *mc =3D MACHINE_CLASS(oc);
>+
>     mc->desc =3D "Freescale i=2EMX6 Quad SABRE Lite Board (Cortex-A9)";
>     mc->init =3D sabrelite_init;
>     mc->max_cpus =3D FSL_IMX6_NUM_CPUS;
>@@ -114,18 +124,11 @@ static void sabrelite_machine_init(MachineClass *mc=
)
>     mc->auto_create_sdcard =3D true;
> }
>=20
>-static void sabrelite_machine_class_init(ObjectClass *oc, const void *da=
ta)
>-{
>-    MachineClass *mc =3D MACHINE_CLASS(oc);
>-
>-    sabrelite_machine_init(mc);
>-}

Let's do the merge in the previous commit, as explained there=2E

>-
> static const TypeInfo sabrelite_machine_init_typeinfo =3D {
>-    =2Ename          =3D MACHINE_TYPE_NAME("sabrelite"),
>+    =2Ename          =3D TYPE_SABRELITE_MACHINE,
>     =2Eparent        =3D TYPE_MACHINE,
>     =2Eclass_init    =3D sabrelite_machine_class_init,
>-    =2Einstance_size =3D sizeof(MachineState),
>+    =2Einstance_size =3D sizeof(SabreliteMachineState),
>     =2Eabstract      =3D false,
>     =2Einterfaces    =3D arm_machine_interfaces,
> };

With the above:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

