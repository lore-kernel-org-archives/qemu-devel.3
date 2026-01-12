Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70133D232D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEJl-0000yW-VX; Mon, 12 Jan 2026 04:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfEJl-0000y6-3k
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:34:33 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfEJi-0000yu-K8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:34:32 -0500
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so9312616a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768210468; x=1768815268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mq2+EYmkO2lkrmdvDwz3VTwZ4DLSDbQN0PN1HwjJcuc=;
 b=ERixqa/OZe0NjVLTxW2wl95k9mzpOSnyeh6OFxWPaCqjnuW3miLn6+q2vfUjE+U9me
 D8m/YsyRygZpIS2NwsSmbeWMbwEsq+59FdodCy6T3iPYGrJVuM6xuxAa7tZmjXq/0LxA
 dGmtV+3rW26oMNkY9d923Pncx+oGdvBQAKwTGQ/M6Qsj+sID1nHQdPUt0FJV/e/I0hKc
 W4b5BciWNAZv3MEV7hXaWsCDGAzkotGG7/kAdv5yslfVCsqf1YFvrwR+Uzh3CUlgTCpM
 T7mpNmG0zZl5k8lYA07a2nEsHaX3f+k637JkDT1sT/s1XqLuIktfaDDKEZHm+L9daqNv
 OpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768210468; x=1768815268;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mq2+EYmkO2lkrmdvDwz3VTwZ4DLSDbQN0PN1HwjJcuc=;
 b=M9RxB8+EVWW5Eww0ni6sSVz0t8BkV0PSoyVFT0qaaeh7+CcWxVSWeVnQoSQfxq6GXY
 fJHyDNqCtWNCDDQXs4XjpAT/70v/jUyH+aZER5cUHgiAX4OcCoAVSVUpgmmQ2VUnmv+A
 Atxm/CTuwi45FSAlsMs1SzuV/6V5PSfSqkGB3RVp/haO9PeuAVRVKVfGYJvLymGcNnPz
 32ZCzv4WDg2fQjS4GavUIKrfpGWNvuNQ48fyIO/yKEbn5mX9jjNZoU92EdOU+maKnTbU
 P2NGsSYy0MD1GSURdTbc8WLfXPMMqzG+8QQFxJ+M7gbOoS/IMblnA2oDOmbmXeKvVpIK
 Gcdg==
X-Gm-Message-State: AOJu0Yx7YHk0i2BSrHC21HcDleMh4rXK8g3yHyFHtpw9NLCwJgVRK5Bc
 1sYq/W41nMrnzRTKWXYzP0UY7hk1ZyFS7s/PiuCxtdt8xsf7yBt2a2bfVVGYNpwp
X-Gm-Gg: AY/fxX4nQK+Wp2pdpQvNHJt/BlLds2qgyl6aPAQvriB7UDKf6onyLnmwOc8OgsvItO+
 QrlySehAQg2NHv9ZUrlvAEnaWpzuZDT2vPpFEjvPjFW3nojZBl7z2PhTqwCEZRv/NP6BDZlysoe
 7WcWMSJZD6e5f1WTsBCefWEXZaOIzvSFs9pbA7I+C6jkACEH3aSCYgKhrU70wC6KjlHYB+cG81+
 VTA2yo3iXsy6uh9R+e0LFUeKvzSDaQRbetgzsKz/Rv8ZRzMkYiRwJxcas1qg0Tz3apw2pe2neml
 bmJwio/cCztiDYLwCF/hjDWBn2mZBiE85xO2ou0V48IOqBO+ttprB0cKc85aGvUMJb233SUob04
 I9LsvYJk/OGasgkI3FV0k1mSe0+qvbQ9Bm+YedO5+Ovi7YHN6AHDPyb7ZxAc6Y6/+QSnV4D4OlX
 klryJYvt4JZfCayygCwqxbQG/+6WGgoHDax89df6XqgfpyhHOPWDeSuHSAicIyOiy9uVwGSc7Xx
 sUApzJxP+yBC7kpaTPvd9ZqHc9PYU5MpvjsPK1FRQHbKQ==
X-Google-Smtp-Source: AGHT+IG/WGaZaPv5EQJMvPmggG1yEF8wT3jNmiRA0UIR+XamAbmr4zggYzcP3m3zTWNVT7gTJpVz2g==
X-Received: by 2002:a17:906:7947:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b84451df3c4mr1670494266b.24.1768210467550; 
 Mon, 12 Jan 2026 01:34:27 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-299b-b200-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:299b:b200:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b871f50cdc4sm189861066b.20.2026.01.12.01.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 01:34:27 -0800 (PST)
Date: Mon, 12 Jan 2026 09:34:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_03/15=5D_hw/arm/fsl-imx8m?=
 =?US-ASCII?Q?m=3A_Add_Analog_device_IP_to_iMX8MM_SOC?=
In-Reply-To: <20251205053819.2021772-4-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-4-gaurav.sharma_7@nxp.com>
Message-ID: <398C5FD3-CF28-4E42-8AD1-4B1EE398FC01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x542.google.com
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



Am 5=2E Dezember 2025 05:38:07 UTC schrieb Gaurav Sharma <gaurav=2Esharma_=
7@nxp=2Ecom>:
>Add the Analog IP to i=2EMX8MM SoC=2E iMX8MM and i=2EMX8MP uses
>the same Analog IP so the analog ip source will be shared=2E
>
>The ARM PLL divider control register (arm-pll-fdiv-ctl0) has
>a different reset value on i=2EMX8MM (0x000fa030) compared to
>i=2EMX8MP (0x000fa031)=2E So iMX8MM will be overriding this property
>with its own reset-value=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> hw/arm/Kconfig              |  1 +
> hw/arm/fsl-imx8mm=2Ec         | 12 ++++++++++++
> include/hw/arm/fsl-imx8mm=2Eh |  2 ++
> 3 files changed, 15 insertions(+)
>
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index be38c67a1c=2E=2E3737335841 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -629,6 +629,7 @@ config FSL_IMX8MP_EVK
> config FSL_IMX8MM
>     bool
>     select ARM_GIC
>+    select FSL_IMX8MP_ANALOG
>     select IMX
>=20
> config FSL_IMX8MM_EVK
>diff --git a/hw/arm/fsl-imx8mm=2Ec b/hw/arm/fsl-imx8mm=2Ec
>index fb6a78adba=2E=2E2c84e70c01 100644
>--- a/hw/arm/fsl-imx8mm=2Ec
>+++ b/hw/arm/fsl-imx8mm=2Ec
>@@ -169,6 +169,8 @@ static void fsl_imx8mm_init(Object *obj)
>=20
>     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>=20
>+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALO=
G);
>+
>     for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>         g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
>         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL)=
;
>@@ -303,6 +305,15 @@ static void fsl_imx8mm_realize(DeviceState *dev, Err=
or **errp)
>         }
>     }
>=20
>+    /* Analog */
>+    object_property_set_uint(OBJECT(&s->analog), "arm-pll-fdiv-ctl0-rese=
t",
>+                            0x000fa030, &error_abort);
>+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
>+        return;
>+    }
>+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
>+                    fsl_imx8mm_memmap[FSL_IMX8MM_ANA_PLL]=2Eaddr);
>+
>     /* UARTs */
>     for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>         static const struct {
>@@ -328,6 +339,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Erro=
r **errp)
>     /* Unimplemented devices */
>     for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
>         switch (i) {
>+        case FSL_IMX8MM_ANA_PLL:
>         case FSL_IMX8MM_GIC_DIST:
>         case FSL_IMX8MM_GIC_REDIST:
>         case FSL_IMX8MM_RAM:
>diff --git a/include/hw/arm/fsl-imx8mm=2Eh b/include/hw/arm/fsl-imx8mm=2E=
h
>index 133f519b7c=2E=2E4601f57f2b 100644
>--- a/include/hw/arm/fsl-imx8mm=2Eh
>+++ b/include/hw/arm/fsl-imx8mm=2Eh
>@@ -13,6 +13,7 @@
> #include "cpu=2Eh"
> #include "hw/char/imx_serial=2Eh"
> #include "hw/intc/arm_gicv3_common=2Eh"
>+#include "hw/misc/imx8mp_analog=2Eh"
> #include "qom/object=2Eh"
> #include "qemu/units=2Eh"
>=20
>@@ -33,6 +34,7 @@ struct FslImx8mmState {
>=20
>     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
>     GICv3State         gic;
>+    IMX8MPAnalogState  analog;
>     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
> };
>=20

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

