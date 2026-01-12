Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF958C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDP-0002RU-EP; Mon, 12 Jan 2026 05:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfFDK-0001jK-6n
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:58 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfFDH-0001mt-Sj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:57 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so9132227a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768213912; x=1768818712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWGJxX6YeT+HvZFllgCLvBWI3AHV8+kEcqSyksG6mQk=;
 b=eThw3EJncvvq2VqqlVPXVxE6qhj907ERteH1FIc6S4OGGBoEbKLdkXPeU7JgA+brpJ
 /bb2UI7KU9JrFUzG71e/CUdGhUtzTUGXBJPlsfC9ePMqdXheP3AiGA22SxNqeojVL9An
 e4Ue1LzIC/IGyYsPXcyJVaHi83MbIJbjpe+LEj9auByo2gipGmQ1mD85UgAziErrljM/
 /KCt3JCyM8WfsxFVnyAtbVAqX3Kw+ia8y1d/565QuSPax4Mh1gyHm4QXBuC0WqrtgMzI
 3tsOBKCG4pR2F0psDFBuYkjeT2xkNjwuMDCCj5G0lR4fP/SwORBGMP54/LZ9B9/4eBbo
 UPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213912; x=1768818712;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IWGJxX6YeT+HvZFllgCLvBWI3AHV8+kEcqSyksG6mQk=;
 b=OKjtpeZVmLCWKn1s2C5WiXY9RJPAauC/ioACjRaQIUYlzkhHUsnQeR8DcTy2hJf7zI
 dBlBqVsnX18I4W80uKEi1EvG5uIyOmv1loN90LZkoEMdVRbn7Rd3UywyNIYmG2mV8V1O
 zxAlh4luSkRP48f7k/+LmdE2A5xVnjrkeeua3wPNrwZ6Q+Ad+1p9nojrNHvWZ+07tmpA
 Sy/rdnt4LHUUZAPtSDSF3obdG+Ps5UQcVp02DdLDkfr6t0Ls0S+xq3PtD8OxLmYzKVTx
 UZxwEu27Rkzn2S/37CS2DjZu/0ZTW43sQm68Dy5CwhTmHsf2XgcZABCFa4iW8W0yMWtj
 XsCA==
X-Gm-Message-State: AOJu0Yxnlfv2iiZ82Uul9wbPvC8Z573Q5aMmA/wanpv+7GpikezvZUoJ
 nEv6uy4s4S16F4R+okdskCn20a5gp7pPHVdFcfk8gF1myLYrHNTT2nogXQ7EAg==
X-Gm-Gg: AY/fxX7DW9A6NUjdyrVOdcRdhRTv4fGfV/AhQOnSv43SwBAWWtC3rpg6gaFbokEu7tc
 bNJ/wSxqnVcMuBk9dBGpdNs7m2SjOHMb4p2yBCEckbsbe0BD1CN6eZkKuoR1YkCEOASEtDYltfZ
 j4mbqGGum2bzhH2HHF681lNLAeBqvO/GKAcFCHzZiGnXtRkZxDGxiVzl2j9XUhVqcPraS/vltJN
 ceSxfCFzZyt6mp007ghNreWtZVNmkX1m6qDldMBDwCns96NI2vcNnynAhgEKpJSFZjyhc0FAYqG
 krT60yYEeIpXjAGxg41s2FP55oFc/UOuBxYgZo3UUbPrSoCICz4dUCfn2MM1+Zlgaiq+2s421v1
 jjgWBUKH1YDIZejtkXhgZwhO6pMlbOVghSNaemEHrKdm2UXE4K4v5qh/69e9Ufe5ZdlHcP+fAYl
 f/FUsvQvfjGv2gdKrWs6oF6YhHLUCHjE0FU29LN/ilvQTsIe6fGQQ0hkqSkV8aYVWearPkJm4e0
 7SAtz1rJx8bE3k45rCzu207oQ2aNP130Fa4yKKhpKaJRg==
X-Google-Smtp-Source: AGHT+IGBCZ+GrwEYc1fY+E5Jlq/jqqPFW525mUSLx3O/jBXldBNzlcGtiCDRVpgC4bmZCyhiyIKi9w==
X-Received: by 2002:a05:6402:27c8:b0:649:a63f:bea9 with SMTP id
 4fb4d7f45d1cf-65097e4ccabmr14713566a12.16.1768213912161; 
 Mon, 12 Jan 2026 02:31:52 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-299b-b200-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:299b:b200:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4479sm17520799a12.1.2026.01.12.02.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:31:51 -0800 (PST)
Date: Mon, 12 Jan 2026 10:31:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_04/15=5D_hw/arm/fsl-imx8mm=3A?=
 =?US-ASCII?Q?_Add_Clock_Control_Module_IP_to_iMX8MM?=
In-Reply-To: <20251205053819.2021772-5-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-5-gaurav.sharma_7@nxp.com>
Message-ID: <BA1E2D72-6AE7-42C3-967B-CED2DEE09901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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



Am 5=2E Dezember 2025 05:38:08 UTC schrieb Gaurav Sharma <gaurav=2Esharma_=
7@nxp=2Ecom>:
>Add the Clock Control Module (CCM) device to i=2EMX8MM SoC=2E
>The CCM implementation is shared with i=2EMX8MP as the register
>layout is identical between the two variants=2EHence iMX8MM will
>be using the source of iMX8MP CCM=2E

The last sentence seems a bit redundant to me=2E Regardless:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> docs/system/arm/imx8mm-evk=2Erst |  1 +
> hw/arm/Kconfig                 |  1 +
> hw/arm/fsl-imx8mm=2Ec            | 10 ++++++++++
> include/hw/arm/fsl-imx8mm=2Eh    |  2 ++
> 4 files changed, 14 insertions(+)
>
>diff --git a/docs/system/arm/imx8mm-evk=2Erst b/docs/system/arm/imx8mm-ev=
k=2Erst
>index 408253193c=2E=2E09aa63240a 100644
>--- a/docs/system/arm/imx8mm-evk=2Erst
>+++ b/docs/system/arm/imx8mm-evk=2Erst
>@@ -12,6 +12,7 @@ The ``imx8mm-evk`` machine implements the following dev=
ices:
>  * Up to 4 Cortex-A53 cores
>  * Generic Interrupt Controller (GICv3)
>  * 4 UARTs
>+ * Clock Tree
>=20
> Boot options
> ------------
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index 3737335841=2E=2E758addea22 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -630,6 +630,7 @@ config FSL_IMX8MM
>     bool
>     select ARM_GIC
>     select FSL_IMX8MP_ANALOG
>+    select FSL_IMX8MP_CCM
>     select IMX
>=20
> config FSL_IMX8MM_EVK
>diff --git a/hw/arm/fsl-imx8mm=2Ec b/hw/arm/fsl-imx8mm=2Ec
>index 2c84e70c01=2E=2Ea3eddfe3f6 100644
>--- a/hw/arm/fsl-imx8mm=2Ec
>+++ b/hw/arm/fsl-imx8mm=2Ec
>@@ -169,6 +169,8 @@ static void fsl_imx8mm_init(Object *obj)
>=20
>     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>=20
>+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
>+
>     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALO=
G);
>=20
>     for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>@@ -305,6 +307,13 @@ static void fsl_imx8mm_realize(DeviceState *dev, Err=
or **errp)
>         }
>     }
>=20
>+    /* CCM */
>+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
>+        return;
>+    }
>+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
>+                    fsl_imx8mm_memmap[FSL_IMX8MM_CCM]=2Eaddr);
>+
>     /* Analog */
>     object_property_set_uint(OBJECT(&s->analog), "arm-pll-fdiv-ctl0-rese=
t",
>                             0x000fa030, &error_abort);
>@@ -340,6 +349,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Erro=
r **errp)
>     for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
>         switch (i) {
>         case FSL_IMX8MM_ANA_PLL:
>+        case FSL_IMX8MM_CCM:
>         case FSL_IMX8MM_GIC_DIST:
>         case FSL_IMX8MM_GIC_REDIST:
>         case FSL_IMX8MM_RAM:
>diff --git a/include/hw/arm/fsl-imx8mm=2Eh b/include/hw/arm/fsl-imx8mm=2E=
h
>index 4601f57f2b=2E=2E03ab45d94e 100644
>--- a/include/hw/arm/fsl-imx8mm=2Eh
>+++ b/include/hw/arm/fsl-imx8mm=2Eh
>@@ -14,6 +14,7 @@
> #include "hw/char/imx_serial=2Eh"
> #include "hw/intc/arm_gicv3_common=2Eh"
> #include "hw/misc/imx8mp_analog=2Eh"
>+#include "hw/misc/imx8mp_ccm=2Eh"
> #include "qom/object=2Eh"
> #include "qemu/units=2Eh"
>=20
>@@ -34,6 +35,7 @@ struct FslImx8mmState {
>=20
>     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
>     GICv3State         gic;
>+    IMX8MPCCMState     ccm;
>     IMX8MPAnalogState  analog;
>     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
> };

