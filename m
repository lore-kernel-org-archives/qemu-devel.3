Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71079C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whw1S-0006d2-DF; Thu, 09 Jul 2026 17:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whw1Q-0006cB-05
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:11:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whw1O-0007Ty-Bv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:11:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWviN2374184
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 21:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cyqhzuNTNPLfTn4uZmqLwtYCYZG7eFH8G/DDno3ET9A=; b=hFZqk9mGgXC6YQbz
 bOPZRYFsaI/W0I361svfDe3cOmnD70l58M20+vn3oGHuc3Qd1clmnNcIosytlNIn
 UKu/+64m4mZqjnjcizzBcLJ77THyLTFfcyC04fN6TGSzBdEFssJoaf5n8atpakV+
 IPGuSvc0M78Umyw91S5mpO12YL72PUn9O/KQ6lUiElJ0CGNUqpZhSi+GAFRtY+mg
 PNxSMlIRgl/Hq7YpyJRqV5voMz3w7AQwJEpJZTuBYpQZEZ7zji8rLdRlFBA7j7R8
 SonpxnAcOzOx86n3HjuKFdU/XpD8jqASj0t0DixxmTv1YHgS33D8nZSwfd7kSBoD
 +6jyrg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5hfed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 21:11:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so2602271cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783631460; x=1784236260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyqhzuNTNPLfTn4uZmqLwtYCYZG7eFH8G/DDno3ET9A=;
 b=e+mvM5yXDq2VhchCO1YVewyTdeE24dhfKVHXvXKo0MiMf+828fm66KFZ3z9Sbz0z2p
 Pm7GybKV0GgWFXm2xyvsTgt82ZLP6/77AgydsQGGpZe/B0XRyqbgNg7QkEdPfYWbFtTY
 l72xWSApSNAAB6Sz6zvTqvdWEm2XYgfe52McNfh2cAcT9Kw8NPjTf4a05jI2sEU+LXcT
 huxXxS8xDzADPhoRRxar3XNmt9yKifSXXFLjHkGol3RpdP25fqHAGmtR7A5Jjriu8LkA
 OsIZqF+9iNu8MbGge2IGXu4Qgu0fWYLq6ujt/e7inziRsi61PQbMsLNpXMAMESukUA2f
 uvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783631460; x=1784236260;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyqhzuNTNPLfTn4uZmqLwtYCYZG7eFH8G/DDno3ET9A=;
 b=qmGfyggyiJKlueKKVBBwOAbkiRrZkwQKCp5Z/TNssOL9lE3tW5LCbCWWVM1aUaCXWX
 VPYDMlTSmpnxf0DVHtRe/rTHYG29OQF4vy3AiAlMuWsIWEvhMceKQ+EIhL4sUKqQTmuB
 Oz+GGWhhEvrqQtB4Je1IiiBQp6uoyzOKpQoAzxmrfd+u+/ZomOQxX8WoSJ68GSRGJlnH
 rP8XbS2Lx0zdhhhkEW0N6UxPkjrWEv8Nys2TXwX20Em/u5TnnJHRq73ZHOacGtd/hzqa
 SrJJJHp60R9OojflNQe5RdOqPEx0mIp1ps0e0DoZes1xFD3pKZKLvZIuf66J31BGOIpn
 VFPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqFo+lgEp+w4pUlGuMKGriEnWn5NtBoynlA9cQh3YYI4xWtKUNgVT2QiY77Zbw+J/a/ZvH0UsLX2q6@nongnu.org
X-Gm-Message-State: AOJu0YwWniY5Q15riSlhX7PqDuBX0+wVbce1mwM/3B/xu+4ZhkK9xYIP
 xU588NScGBZ54eQhouNCy3P7pJgGVcfDwTsyGQFvXWkAxiN7OJGepMOwdVOy7eUjz9xLxyLa/7T
 G49xm+mxEsMXl4NbqdWGOYPxi+1ljL9XE8FdUgze9nUUE6fDIO2i4n7tMWLppsuo35A==
X-Gm-Gg: AfdE7cnfJHbMHiCOgmahTUw86/9qz6yzvEKdxLDTDiL4w/ePvxfdFW0bkfoiawunhKc
 j3f0cIJb5UdJbHZ2aBqEYbDTGrYUI3Mttdg9/tXJX0zkXXaZj2jLDVHEYqpdl24a+0PiE9tZ7qz
 jEGbKmiS6Wg7Z+5EFS8d1IGE/DyjO50SHYSo7CL0Ly1Lx4IyN4miW8xfQIlO1vA3dOQutNdinnK
 sKCv8m2mS5oogvHMIE/q49QDg7/gdIzIuujDPu7VTC8+8DA4G67XTD1m4RROEs8exI8tEjVwox2
 Pqj0M9ZkwqLCYW7TjejJYv2hrIGSgQpdwobVfSzixo0PYxVPLvhfgJABcGhTJxb0cFf8yKzjYkv
 rDgb1duKmjmYTreGdgnl8E495nYzq6di/NMf21u6wo/+Wh2tWfN6gtzXMvsGzhw==
X-Received: by 2002:ac8:5f0c:0:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-51c8b12b474mr93656681cf.0.1783631459594; 
 Thu, 09 Jul 2026 14:10:59 -0700 (PDT)
X-Received: by 2002:ac8:5f0c:0:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-51c8b12b474mr93656281cf.0.1783631459158; 
 Thu, 09 Jul 2026 14:10:59 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccdbbsm89697445e9.3.2026.07.09.14.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 14:10:58 -0700 (PDT)
Message-ID: <38bae6ba-b380-47a1-a134-f16313a1f7e3@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 23:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] hw/arm/aspeed_ast2600: Wire up the UDC
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
 <20260703074332.1049473-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703074332.1049473-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a500e64 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=mUOQmIRJj8fYqNWr_X8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIxMSBTYWx0ZWRfX2U3y2nHQXq2p
 tH17q3qRO+9RrG/ZacyTw4x+BvnwTZuIqe3RDOKtcrmHEmmmLcLFJA0PnrTVQ+TJoh3SwjMBQm9
 I7b7D6x22733coH1YjoGY090tjPUn50=
X-Proofpoint-ORIG-GUID: PAV_8g-J6MaapxxlUNppkrUGNIGVwUZE
X-Proofpoint-GUID: PAV_8g-J6MaapxxlUNppkrUGNIGVwUZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIxMSBTYWx0ZWRfX4Eh6DZNO/rZu
 /YqmRCpH6Nf/Sk9GFv4pyPRNdnOLKLb8AIYOd0YIhor5klV7UJtoPn5Xr1wuXK8HVnrAGJnvByc
 nmpD4dPl65vYhr7q3ivHvR4Ocmm6OqBYIoBxJmhuI7e/vTCP9aHN0wnOSAhvfNiRFkGtNVVpe3J
 IX0wILM+wQlHr6Y7QOZTYP2wdJZQuMfeo0vyzMLXkR1wUFN2xQB3UDzGy7iG+esrJfoTapm9y7f
 wEM3jcNaEW7HvUgUi927YQ1I9MmB7F0S3sV4o1BU/ucqvHYpRDmPT92CVkDZTiu2vfSjYTJFJkm
 lYh+TYjBmJK2ZG8PSWyLEBgoDpr+E2jAq59HHcOaVM7mAYxVl4QJ/lVbZlQtlPcmMnAvXXtpap+
 cGjHWtBE7Qmug/8qzIh+7YWtU/gufSXatjzQSvTIHad5qNoS5/i4+6ige2N9FLtXYoERWpsS11p
 0+yXJbo0whi/MVlbuvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090211
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

On 3/7/26 09:43, Jamin Lin wrote:
> Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC:
> map its registers and connect its interrupt.
> 
> The gadget USB device is not created by the SoC. It is a separate,
> user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a
> USB host controller's bus; it finds its controller through the "udc"
> link property, e.g.
> 
>    -device aspeed.udc-gadget,udc=/machine/soc/udc
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast2600.c     | 13 +++++++++++++
>   include/hw/arm/aspeed_soc.h |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index d1f18e471a..7d97f10448 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_SPI1]      = 0x1E630000,
>       [ASPEED_DEV_SPI2]      = 0x1E631000,
>       [ASPEED_DEV_EHCI1]     = 0x1E6A1000,
> +    [ASPEED_DEV_UDC]       = 0x1E6A2000,
>       [ASPEED_DEV_EHCI2]     = 0x1E6A3000,
>       [ASPEED_DEV_MII1]      = 0x1E650000,
>       [ASPEED_DEV_MII2]      = 0x1E650008,
> @@ -113,6 +114,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_SDHCI]     = 43,
>       [ASPEED_DEV_EHCI1]     = 5,
>       [ASPEED_DEV_EHCI2]     = 9,
> +    [ASPEED_DEV_UDC]       = 9,
>       [ASPEED_DEV_EMMC]      = 15,
>       [ASPEED_DEV_GPIO]      = 40,
>       [ASPEED_DEV_GPIO_1_8V] = 11,
> @@ -214,6 +216,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                   TYPE_PLATFORM_EHCI);
>       }
>   
> +    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);
> +
>       snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>       object_initialize_child(obj, "sdmc", &s->sdmc, typename);
>       object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -573,6 +577,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>                                                         ASPEED_DEV_EHCI1 + i));
>       }
>   
> +    /* UDC - USB 2.0 Device Controller */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,
> +                    sc->memmap[ASPEED_DEV_UDC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,
> +                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_UDC));

Do we need to mux this IRQ line?

>       /* SDMC - SDRAM Memory Controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
>           return;
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 3aac144cd4..74fd83e957 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -36,6 +36,7 @@
>   #include "hw/gpio/aspeed_sgpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
>   #include "hw/usb/hcd-ehci.h"
> +#include "hw/usb/aspeed-udc.h"
>   #include "qom/object.h"
>   #include "hw/misc/aspeed_lpc.h"
>   #include "hw/misc/unimp.h"
> @@ -138,6 +139,7 @@ struct Aspeed2600SoCState {
>   
>       A15MPPrivState a7mpcore;
>       ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
> +    AspeedUDCState udc;
>   };
>   
>   #define TYPE_ASPEED2600_SOC "aspeed2600-soc"


