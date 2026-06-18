Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DECCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waE9I-0003Gi-Mx; Thu, 18 Jun 2026 10:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waE9I-0003GW-1a
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:55:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waE9G-0006ve-2z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:55:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IDrS631453158
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A8JdzEkIMsbeMIi6YXcdlo4ptdmJC9yikcjTAOXSBtA=; b=EPMyA6wnsjN8IDqJ
 KgkAuHWGCAXiRIRLX5biLQ5r4hKqRyCyKoju0fXCetZO31K9JuVqLPxwh4tevAJg
 nSgnBZd0NqWMGAeJRYTD+6oOTgl3JJ6ioiLY5qaH+YMPGGgULUAEJ2uVEPjOlWWA
 AJF6SXga4U5O9MpWbj4bb34wXnEp5sdElHVY9k6A8rlP1nAjXRNLqBdrhFzGU1gQ
 D5AldsPXhT4UZtA57TUOJaVz1zHsNULmCMq//Tkr1as6wm9PGSQJe5LKO1PXaOZQ
 2z/CaDlyzkB7LINRLEvZkg9naM/jkaDHFRTNoMF6g3PV5XMqTKevuzVTJC84Olu2
 aPByUA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2cd15d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:55:15 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-59eba8fe530so1653111e0c.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781794514; x=1782399314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A8JdzEkIMsbeMIi6YXcdlo4ptdmJC9yikcjTAOXSBtA=;
 b=ix/7d4bmtKYWYe25kjEtAZd0PjUhEJ6++quyztCsJ8gZzSXX2n46yw7kJ+JiXqP4Ph
 7n9MzyrgGjqeXwJ3QdQD4yQsH6I2UWATghs1+XhCknGTjacWUxtkvfgit1gNZ/yZYGV/
 XYU214tSZBo9UHxRWbQx4GJny/hbBYIFKIEfampBKAFVQmEyPwaaK441Cce3U5bSHSXC
 /9bU5gF5XBt1joz8R+kXUx2DRCkJwiI2qqOmG5W/4tzvjCCX6MhOUyNQilcIStKZcEVl
 AYi8wBdgHs19GK4IALvEpizbIUGoFS+S9sFRKG2AWUCOMuuT8PiCVOsb9+7DnfmqGqL/
 jJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794514; x=1782399314;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A8JdzEkIMsbeMIi6YXcdlo4ptdmJC9yikcjTAOXSBtA=;
 b=T5t4Hk7TwGQFsTae5/0Le2z8zPAnRCHqAHZJZS75BS+/+nLWJIGu5CZkU8j6IXaes2
 9dYoXMGcyx62lQuZ3CckJAwUVjUWv9g8heYyOyxLkM7+3Ea285F8N5SkJeJJ/lvEAOSB
 kvg80g0fUjwGhDsvCgmpP4g5kSXRVCM6Azwxxii+TqjEcrYwqxQagRRmDyTmFyAU/ylH
 WU/tdrHsWhcgK7D/DN3IiScwCCrujtYUuaNL2NAPrN1fjkWsXmvKk0xpWwRPhoA63Nbd
 JZ3BvaBrkZ4tRri4rezB+gfxLY2i2M6+jvjZHKPIbD5NmpfjbMeljZEwNNkCKdDtODVC
 GETA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8r9cTJi8vKxdCb5jvcPM7/XFujcj4qxvS5maE8frfjUU0h7E7o4Rl2EgUhp7KEYdH/pstkXRaPtR56@nongnu.org
X-Gm-Message-State: AOJu0YyERRgXck8OZ0dwLsOA21HZrXpq5VdpeUv1ypJj3ix917c5g35Z
 WFnfZNZp7AHjyX93ZxqrueFO2Q5mU2ffvqaTULo9v9ab+oErCPsTzWCIIl/dniJYGPt6QGcb2E7
 RXBRID7wnlhyqLU0ltNKzI2yLz1F9cWH+982U46cqUjYA8aUzCmtoK1EFsw==
X-Gm-Gg: AfdE7cl+bmi1Fy+tO21jg4XyY5Yj2STyDA4KCdTpHfni+pJ9/aMNU1N3MA+JMJz/OTo
 eM3CK8sZwtsG64rUXs3/USVPsU4LC28Wm6yWG8xu81SoLlPcmkyI4oAljFahb8S3NKOARttqgCg
 6/vN3RtlFtp9c4l3xKkf0YUDLNn6LONdr+Yu2bv2aJW5O4TxwsO8Uex3zokrMyqQEupkucd57E9
 oAKDEDVQorrmPe0EgHaj4m1CzA3pMyUN36M+9dx+aWvIU6HBazpl0GKy3ZU45LrJaX8n9SqKO2i
 DaR8YLATYSirCCm64tscWZJHxu/LpGZ0ueAWMakt7zQ3D37Snc/d1QbgsoTMOpV2Vk3L8Vbhlze
 bu3oXcmA37O1K+4sQ5ZleSGnGscfISHZUqEAHYFOYB+nW5D7ejxUectMTMqmbPA==
X-Received: by 2002:a05:6122:4699:b0:5a0:c38e:6199 with SMTP id
 71dfb90a1353d-5bbbe48d0b4mr5334480e0c.1.1781794514387; 
 Thu, 18 Jun 2026 07:55:14 -0700 (PDT)
X-Received: by 2002:a05:6122:4699:b0:5a0:c38e:6199 with SMTP id
 71dfb90a1353d-5bbbe48d0b4mr5334452e0c.1.1781794513896; 
 Thu, 18 Jun 2026 07:55:13 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58becsm244176695e9.7.2026.06.18.07.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 07:55:12 -0700 (PDT)
Message-ID: <90cf5582-4792-444c-be21-34b22675078d@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] hw/sd: Add Axiado SD host controller with eMMC PHY
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-5-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618101249.2926976-5-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzOCBTYWx0ZWRfX2ZxQWGspesef
 E+Lpf8nEl0nn5oXYFomAo8Kc6hUNc361V4Q1n/g14fZZS2DYKN0DfAKDhj5FKR/H4SXswLhWhDx
 bH1jfkwKIsuL7EznxGXsW1bcJ0SEb1xaDuAz4d4LfW6DIqL79YH02o3zE6VVBkUy1NHAeGGgUF7
 ZByosSl0rx6VaMud9oiOAeWcLl1MqitcUXG0s7XH5ORgRnbiaj3+KHONjY4gOnzxSrH86bO5mpv
 00uc2HOg8cx044fPjwneNkNs4Fdg8946FsVrNdq0Z03DyxXF/tBOteE476WxLD9QSUhSIbjUxxa
 a8DfvPxM2K0SecCp78QhnoXaWsHpRZ8gHQW+BZkpVYjdo/1AB5W9zljvWOfHZrhiDs/SRIDsEVh
 3EZMfZTjakFoA+UlMpwydC3hzPX2eQDmY4nOadaBpnZ4YhE11iiNn0pZ5iQ0E5Pqu40UkfbMETO
 UEMMrG2z1K/ppzxNzDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzOCBTYWx0ZWRfX+palox2oBFLa
 8vdlrPBfjo3YYBPA+9xJGrDjj+f0vFo/b2bw+O7ipKBUUj07+qCgGYPgSMT9evEY9Pt4Moh/cFg
 kFmlFLdldSpds+D/efBGaUv4rfn/KYg=
X-Proofpoint-GUID: w-DAm0ld0QcykBZT2Vaoq5Stix6Gz5vS
X-Proofpoint-ORIG-GUID: w-DAm0ld0QcykBZT2Vaoq5Stix6Gz5vS
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a3406d3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=440cDlBIAAAA:8 a=KKAkSRfTAAAA:8 a=3KuOPZt-03f9vLCSZKsA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=d9D1X1bx8dWolqnE4HNT:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Kuan-Jui,

On 18/6/26 12:12, Kuan-Jui Chiu wrote:
> This patch add a new model for Axiado SD host controller which is compatible
> with SDHCI 3.0 spec
> 
> This device model also includes a eMMC PHY which helps to control SD/eMMC
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                  |   2 +
>   hw/sd/Kconfig                |   4 ++
>   hw/sd/axiado_sdhci.c         | 114 +++++++++++++++++++++++++++++++++++
>   hw/sd/meson.build            |   1 +
>   include/hw/sd/axiado_sdhci.h |  21 +++++++
>   5 files changed, 142 insertions(+)
>   create mode 100644 hw/sd/axiado_sdhci.c
>   create mode 100644 include/hw/sd/axiado_sdhci.h


> diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
> new file mode 100644
> index 00000000000..e1a76b80a67
> --- /dev/null
> +++ b/hw/sd/axiado_sdhci.c
> @@ -0,0 +1,114 @@
> +/*
> + * Axiado SD Host Controller

"Axiado SD Host Controller with embedded PHY"

> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sd/axiado_sdhci.h"
> +#include "sdhci-internal.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
> +
> +#define EMMC_PHY_ID     0x00
> +#define EMMC_PHY_STATUS 0x50
> +
> +#define DLL_RDY  (1u << 0)
> +#define CAL_DONE (1u << 6)
> +
> +static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint32_t val = 0x00;
> +
> +    switch (offset) {
> +    case EMMC_PHY_ID:
> +        val = 0x3dff6870;
> +        break;
> +    case EMMC_PHY_STATUS:
> +        val = DLL_RDY | CAL_DONE;

Out of curiosity, how long a PHY generally takes to be ready?
(We had issues with firmware when not modelling a micro delay
to allow PLLs to stabilize).

> +        break;
> +    default:

I suppose there are other registers, could we qemu_log_mask(LOG_UNIMP)?

> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
> +                           unsigned size)
> +{

Is it legal to write? Can we log LOG_UNIMP / LOG_GUEST_ERROR?

> +}
> +
> +static const MemoryRegionOps emmc_phy_ops = {
> +    .read = emmc_phy_read,
> +    .write = emmc_phy_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 2,

Your current implementation is min_access_size = 4 (you are not
handling EMMC_PHY_ID+2). Using min_access_size = 4 is simpler,
the core memory layer will deal with the 16-bit access for you.

> +        .max_access_size = 4,
> +    },
> +    .valid = {
> +        .min_access_size = 2,
> +        .max_access_size = 4,
> +    }
> +};
> +
> +static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    SysBusDevice *sdhci_sbd;
> +
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
> +
> +    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
> +    if (!sysbus_realize(sdhci_sbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
> +
> +    /* Propagate IRQ from SDHCI and SD bus  */
> +    sysbus_pass_irq(sbd, sdhci_sbd);
> +    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");

@sd_bus is not used AFAICT.

> +
> +    /* Initialize eMMC PHY MMIO */
> +    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
> +                          "axiado.emmc-phy", 0x1000);
> +
> +    sysbus_init_mmio(sbd, &s->emmc_phy);
> +}
> +
> +static void axiado_sdhci_instance_init(Object *obj)
> +{
> +    AxiadoSDHCIState *s = AXIADO_SDHCI(obj);
> +
> +    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
> +                            TYPE_SYSBUS_SDHCI);
> +}
> +
> +static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = axiado_sdhci_realize;
> +    dc->desc = "Axiado SD Host Controller with eMMC PHY";

Shouldn't we have a reset handler to propagate to the SDHC block?

> +}
> +
> +static const TypeInfo axiado_sdhci_info = {
> +    .name          = TYPE_AXIADO_SDHCI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AxiadoSDHCIState),
> +    .instance_init = axiado_sdhci_instance_init,
> +    .class_init    = axiado_sdhci_class_init,
> +};
> +
> +static void axiado_sdhci_register_types(void)
> +{
> +    type_register_static(&axiado_sdhci_info);

DEFINE_TYPES() is preferred for style but not required.

> +}
> +
> +type_init(axiado_sdhci_register_types);

Regards,

Phil.

