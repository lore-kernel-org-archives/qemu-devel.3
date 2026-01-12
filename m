Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9158D2505C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfE9T-00022N-SF; Mon, 12 Jan 2026 04:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfE8u-0001xy-PD
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:23:24 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfE8r-0007zB-4i
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:23:20 -0500
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so10234571a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768209794; x=1768814594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZ/9xFl/2E6M/Jby6wt5Ct9O6BhC5H+Gs0R+iL3qzak=;
 b=G6OIvpZvQFCXmyXHDcE+JkcxjCOOpAiY+9SlBmqDPfX05fU/zK7O5Ibmc2CDNPndd9
 u3IDvs5sr3jRLqV+g+XOe7pDSIND17tkUFp//ms6OD/2u+dKKybIag3J7AhRnhuNDrsN
 HvNZcjp0T5iI6KLc0C5KLOmrDDwIIirppGjBABT7MqG2tBUBotsyJKPAIoZwsi74zYqS
 ZQgPUV9ydOH2cMTSjwuBozHhOrOv5rE4Wt1zCH9WNV0t1GaekE9K2MwVdfnyd8WpYi+2
 AnMCy+cKaTWhUBMcfI1q98uicnEwctGMFJAEDOAZYh3e+xeLbKMVm6mpMOsI+9W6qEgH
 6ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768209795; x=1768814595;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZ/9xFl/2E6M/Jby6wt5Ct9O6BhC5H+Gs0R+iL3qzak=;
 b=XqHM4W1Sy5qMAcs/q7lHPJS39N8GM34g+J96N24SjcrSpBKAPqGM9qMsNwOIgaOPUD
 e7qzkSOAs5b/Nj3v3g4G98vG/UZX+QL+hOEXeRejEeyIwN5F1yEenON3o15bwlS3Gt9A
 jlrJyDnWytByWBjvf0ngfpPxcB1pNO8T2RXd1SXPoqAQ/RIoRKhLOur5MS1QNjdkUXG9
 lneUuv+pmG7coTPEf1m9gG5JCz7mTC09e367vQBjZBExJtGbyY3QdrKJYMKtng1jtAfa
 jGsR27I3NyrpktsjoTQy1+IOWQmpXnogPQLkJ86++XkVMjAC3IIx6/eSXw75aRfDYpaO
 OWFg==
X-Gm-Message-State: AOJu0YygefmUNCPpOCGuEjrbxLhwe3EJrgI1jlPFyXLcuFlVKcAiC2yg
 qfOY72uy5qclmeuN1wVhOerknUfycelUMSoauwxI4+IEqU8zMtcRjU7qom8TXLVn
X-Gm-Gg: AY/fxX4N4bY+Yf/HtBJVmoSQbnPMy1RRYTvPgMkpTlb/urP7Pm4NEYqsAhjWyOdxYkY
 Kqx8txsNVP+Axlz5aRHwu7kE8TJjjtQS6ePdlgVP7jZf3x+yEYLxiI7VxpKPU6kitXYmSI20Oj+
 Z+GkYpS73IsocR5pkbmFaPeRBYldUA6Q1jFv4Zn/MNc6mFDRL+knfbHvQScvMRTbqU50pHEkBdP
 aPnFfLCBMeqeGOoMjXB5ou8ue8kK2uF9/QC2P4lD5ma3w+UN/ErmVm71onDgsVJCLNUwdlMy3cn
 ursMX1735g6eydsfrJW5xTgkK5qzL7P8xwTk6c6PgwieEjpDGxpXIuP7lwNNGwwL5OsX5sruhYS
 rnpU+AoM+0JKNBLXX0lkdib+XgzbTTEtSy4YFs9Kc/O0JoBKBTvBseWmeOsbOl6BOFag/6F79U3
 lUjwqCsezS+BFNR5TPBIqzD0vClGU4rxR816jAkLKc4fRl0VzBPBDUPfK3apH0YXK+UKt2rrwkb
 cl9m4GmQOpXaSZje8HhLKmZ7wWjOgPv54g=
X-Google-Smtp-Source: AGHT+IES/JBZ3b2T+dCERrhtmE0TdWBU0dbmUkLv/3SrtXen+NUcpjmio733C5vEyqfdtTZo5IpweQ==
X-Received: by 2002:a17:907:98d:b0:b73:7b97:5bfb with SMTP id
 a640c23a62f3a-b8444f4f7d3mr1805892966b.33.1768209794258; 
 Mon, 12 Jan 2026 01:23:14 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-299b-b200-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:299b:b200:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c3f89sm17353725a12.5.2026.01.12.01.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 01:23:13 -0800 (PST)
Date: Mon, 12 Jan 2026 09:23:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_02/15=5D_hw/misc/imx8mp=5Fa?=
 =?US-ASCII?Q?nalog=3A_Add_property_to_analog_device?=
In-Reply-To: <20251205053819.2021772-3-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-3-gaurav.sharma_7@nxp.com>
Message-ID: <A89B56FB-A417-427A-8725-37624FF9A088@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x541.google.com
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



Am 5=2E Dezember 2025 05:38:06 UTC schrieb Gaurav Sharma <gaurav=2Esharma_=
7@nxp=2Ecom>:
>Add configurable properties for register reset values that differ
>between i=2EMX 8M variants (Plus, Mini, etc=2E)=2E This allows the same
>device implementation to be shared across multiple SoCs=2E
>
>Properties added:
>- arm-pll-fdiv-ctl0-reset: ARM PLL divider control reset value
>
>Default value is set to match i=2EMX 8MP reset value (0x000FA031)=2E
>This can be overridden in the variant like iMX8MM with its own
>reset value=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> hw/misc/imx8mp_analog=2Ec         | 12 +++++++++++-
> include/hw/misc/imx8mp_analog=2Eh |  3 +++
> 2 files changed, 14 insertions(+), 1 deletion(-)
>
>diff --git a/hw/misc/imx8mp_analog=2Ec b/hw/misc/imx8mp_analog=2Ec
>index 23ffae84f8=2E=2E7c904d77f4 100644
>--- a/hw/misc/imx8mp_analog=2Ec
>+++ b/hw/misc/imx8mp_analog=2Ec
>@@ -12,6 +12,7 @@
> #include "qemu/log=2Eh"
>=20
> #include "hw/misc/imx8mp_analog=2Eh"
>+#include "hw/qdev-properties=2Eh"
> #include "migration/vmstate=2Eh"
>=20
> #define ANALOG_PLL_LOCK BIT(31)
>@@ -51,7 +52,10 @@ static void imx8mp_analog_reset(DeviceState *dev)
>     s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] =3D 0x0010003f;
>     s->analog[ANALOG_VPU_PLL_MNIT_CTRL] =3D 0x00280081;
>     s->analog[ANALOG_ARM_PLL_GEN_CTRL] =3D 0x00000810;
>-    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] =3D 0x000fa031;
>+
>+    /* Use property value instead of hardcoded */
>+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] =3D s->arm_pll_fdiv_ctl0_reset;
>+
>     s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] =3D 0x0010003f;
>     s->analog[ANALOG_ARM_PLL_MNIT_CTRL] =3D 0x00280081;
>     s->analog[ANALOG_SYS_PLL1_GEN_CTRL] =3D 0x0aaaa810;
>@@ -138,11 +142,17 @@ static const VMStateDescription imx8mp_analog_vmsta=
te =3D {
>     },
> };
>=20
>+static const Property imx8mp_analog_properties[] =3D {
>+    DEFINE_PROP_UINT32("arm-pll-fdiv-ctl0-reset", IMX8MPAnalogState,
>+                       arm_pll_fdiv_ctl0_reset, 0x000fa031), /* imx8mp d=
efault */

IMO the new comments in the code except this one merily state the obvious,=
 so I'd drop those=2E

With this fixed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>+};
>+
> static void imx8mp_analog_class_init(ObjectClass *klass, const void *dat=
a)
> {
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
>     device_class_set_legacy_reset(dc, imx8mp_analog_reset);
>+    device_class_set_props(dc, imx8mp_analog_properties);
>     dc->vmsd  =3D &imx8mp_analog_vmstate;
>     dc->desc  =3D "i=2EMX 8M Plus Analog Module";
> }
>diff --git a/include/hw/misc/imx8mp_analog=2Eh b/include/hw/misc/imx8mp_a=
nalog=2Eh
>index 955f03215a=2E=2Eb313820392 100644
>--- a/include/hw/misc/imx8mp_analog=2Eh
>+++ b/include/hw/misc/imx8mp_analog=2Eh
>@@ -76,6 +76,9 @@ struct IMX8MPAnalogState {
>     } mmio;
>=20
>     uint32_t analog[ANALOG_MAX];
>+
>+    /* Property for variant-specific reset values */
>+    uint32_t arm_pll_fdiv_ctl0_reset;
> };
>=20
> #endif /* IMX8MP_ANALOG_H */

