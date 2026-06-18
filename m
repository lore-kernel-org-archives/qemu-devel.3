Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B667BCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEUS-0001xg-CX; Thu, 18 Jun 2026 11:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waEUQ-0001x8-Kv
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:17:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waEUO-0006oA-TO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:17:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IFFtf51914255
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wAOdJKwWRKT4XSHr1N6DuqVdP09PYeWCJx88NIiBQuU=; b=awZvIirw5kOhgEBz
 WbVcHy7Q79GOF+7SEU2w7Z96S6Ua462wahFXUw8QXNS1VxE/42be6whK0rjT56KG
 MBCNcJXkBt94k4+CrryJqyhQZILTefudtMxDHNeHoNqhD3xZv8956bUb30hmZ31j
 lR0uDwr5sn3F76B+uG7yaAgk5NUB3qry/olPUq0AjwuOCMF1it5+30oP4Cdet0ey
 gadrIdkI4FFfVsKKUfaUZylNsRA9TOhL+eosYjUFVeZwdgeNGv3opg+Un2mgdWEz
 SXM7ChalCIDwEUH9wQK0qqXmXqgKwIXHV/Pr8B4NuLeYgezBI0+++aYGsfYbt2r0
 8Rkzog==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc3qva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:17:07 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-486055c1c6fso1241474b6e.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781795826; x=1782400626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wAOdJKwWRKT4XSHr1N6DuqVdP09PYeWCJx88NIiBQuU=;
 b=Ig0NFdN+QhazKOPcaxKdHC87DJ50CnrMYOKEyQ7eaWspsOtSr3Bo8b2eFjLQizPnZM
 A96YCtWD0JUMBib7DBix8K3gYfVA48VgZnvsULs6K/fmwGRbYjZpvgF8lzSCMD2bVBwn
 FUqBOQY9kPKLU12zwgKbzcaQ7USjPTmV6YoXKNZl40090qtSUuh60xtENconpUZ9joCy
 McpVc3mbLdDUxu26emagT6noG3tsAXY8JbCL4bsoNtsHiBUceGzVxOTorLPKsYbwfZWi
 LXVPhK2w7RDv1tVMC7/3E1MOH+I2EKG7KD9TbLDmhegxQrq0rEm2YVYU2MD8Sd5AnWte
 XUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795826; x=1782400626;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAOdJKwWRKT4XSHr1N6DuqVdP09PYeWCJx88NIiBQuU=;
 b=JLpHJ5Y5+DwHdGZJhKbzXqOjN5S5KtFgisxtASDz+efJQcKdPUZMKqpVG9i7aG4jcs
 VkpVPv/sdQZ+wY78ixHWoMRZMKBVG9ULKyanop0kEXw5zOtfYYdc9pwOn5cQMEy25Qez
 h9iUEOJ87zJp6xD+XeMkAKzM1qlqlBJf8jNJX8XW1bpYTZXQjCEnyxOSETfiKqi72RYK
 7BM5MR9wefyssVOptvJvJmGrgdFujnJOxY4eZ0QSuXUB/TCpW2wCx2Wz4Bz/sMnmgXna
 R3aQ8BUq+TyJils+bho7tlfux8iVpBqPF/R81hYNltqgUz7wrPtImJTHoqwgYEMoZk5c
 HBTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99Noj+pLvJl3w1DkJkEu85lkQTXYIozouJiB0Sb/qloGEm/eyPLGwa5QPIgxQhSdAHfLXd6RXZ0oYK@nongnu.org
X-Gm-Message-State: AOJu0Yy30rElZwMxqht6YWbT6v5XBRApS72uaPKjIn1gVgrv/kN/HOHm
 Cb8ndoG7BTkX0HG8KTvJnOyIn4iJxaFJJ36UWrFHqph6cmsFrost8McuNi7M1MX9rsnMyVk2PQ2
 sEoTI3nSsSQLg7ZHIJ0x9wJLWMqNXjidgiLH7JBJZ7vVmfNe1QL4Yr74WGA==
X-Gm-Gg: Acq92OHKseUFM9D8+B7nD31FUbOKlPAfn62596hVkauka52bWwEUHRrsBNxO/wsY8Ps
 ql2oWWvRmoQhLGdOC4m/dmKK6TOtWBQcfvi2/flrFNP3spMmxGs3v+qmG/RmUNRDCfUKVkIC8M9
 W8xd0URpyJVZZ6flXjuIaCYVPb7LgaZuKqJjvGHa4mlqttPnEnnA20Eimofm5RDfWyEPYFzeQFK
 IxPXly63MGhY6uEHBdB0VQrkdhprU8CVGxufP5iiOySVgbLv9Qs94yAyAC5e7Y1pE/HQKz1xMzj
 EtcGoNKZuMEWfBkaZW24VyEr/UaKawNpV87OzhM9tsSgnZvHk/cPCtTIvvfA9BwYsSeS2NuAga6
 XPvA2kIDx/Dds0cMcBtMEtGzGU2RTasH8etGS+rFfACQqyCoCLaUBOVBZl/bRFA==
X-Received: by 2002:a05:6808:690c:b0:485:48da:132c with SMTP id
 5614622812f47-489444e5528mr6398715b6e.18.1781795826316; 
 Thu, 18 Jun 2026 08:17:06 -0700 (PDT)
X-Received: by 2002:a05:6808:690c:b0:485:48da:132c with SMTP id
 5614622812f47-489444e5528mr6398646b6e.18.1781795825684; 
 Thu, 18 Jun 2026 08:17:05 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d2d9esm47672995e9.1.2026.06.18.08.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 08:17:04 -0700 (PDT)
Message-ID: <41ffebd9-00fd-4a1a-a281-1e8bc475fa9f@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 17:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] hw/arm: ax3000-soc: Enable Axiado SD host
 controller
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-6-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618101249.2926976-6-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a340bf3 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=440cDlBIAAAA:8 a=KKAkSRfTAAAA:8 a=zwd_ef3A26EfFKNsC8UA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=d9D1X1bx8dWolqnE4HNT:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: N-T8_z_tLuIC4KOklysLVEZWfouIH93L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0MSBTYWx0ZWRfX7R9cfdFGR9eC
 nqiQn2Snx//VRXYCUjF7sm5jrpvhf+tRLSlcm+GsWIE0Qz6GrGD/Uf3OsNk4lmVJ6zkp10U+9iF
 VS2dSbC9s6a7PREu11OA/u7NiOJGbGk=
X-Proofpoint-ORIG-GUID: N-T8_z_tLuIC4KOklysLVEZWfouIH93L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0MSBTYWx0ZWRfX7G9sgqxbuBxN
 GkUfdAo3I47VeGRZqqhzaftlxflBgj+q/5JWYKPKoW7MwIFV3woaMtNJbwwWjo+hOMRvv5rKmZt
 YFi2AwpASjtcHDbF7xdfgYebJHnh9FwgpFAcIuZAXL1gJKdgplInWRV7mfxXQypF01NRz6B6meb
 YscuNG8xYBAKMq6FHV4J8KJqChBTT8SJXCmv/0WoG82aIpLHPHfbfG4iscsSd6PBkQyZbc1Y4bH
 2wi4QR4wFhzcg0GmeNJhNemx0Q+9fBk/fMYdBFwyY8Ua0cHO56FOvLca+X66w/ElMOcOGYhD+de
 PP+t8EFU7CBGIiUQCISvCctQ4FoECk+N3bjxASCYLPIQYVtX2jI1CYTQxQgOqkeqZaPxH6M+Y6b
 jDmzQ4Fu5vJEVXzQfhCYcy5u6xxTZfH4hxfdBakU/2uawhKdzoF2bNtKdv0tUdADhPz0IgkxN+C
 /ZkV2/NJ1LQjHNhkX4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180141
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> Enable SD host controller into Axiado AX3000 SoC to load kernel and rootfs
> from eMMC.
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig              |  1 +
>   hw/arm/ax3000-soc.c         | 18 ++++++++++++++++++
>   include/hw/arm/ax3000-soc.h |  7 +++++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 866e4b14e6f..13c0b44a180 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -724,4 +724,5 @@ config AXIADO_SOC
>       select ARM_GIC
>       select CADENCE # UART
>       select AXIADO_CLK
> +    select AXIADO_SDHCI
>       select UNIMP
> diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
> index 9a01d23bcc6..159385cf913 100644
> --- a/hw/arm/ax3000-soc.c
> +++ b/hw/arm/ax3000-soc.c
> @@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
>       }
>   
>       object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
>   }
>   
>   static void ax3000_realize(DeviceState *dev, Error **errp)
> @@ -165,6 +166,23 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, AX3000_PLL_BASE);
> +
> +    /* SDHCI */
> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
> +    sysbus_connect_irq(sdhci0_sbd, 0,
> +                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));

So there is no link between the SDHCI and the PHY. Thus no need for a
particular AXIADO_SDHCI, simply instantiate a generic SDHCI here, and
register the MMIO region for the PHY.

in ax3000_init():

     object_initialize_child(obj, "sdhci[0]", &s->sdhci[0],
                             TYPE_SYSBUS_SDHCI);

and in ax3000_realize():

     object_property_set_uint(OBJECT(&s->sdhci[0]), "sd-spec-version", 3,
                              &error_abort);
     object_property_set_uint(OBJECT(&s->sdhci[0]), "capareg",
                              0x216737eed0b0, &error_abort);

     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[0]), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
                        qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[0]),
                     0, AX3000_SDHCI0_BASE);

Then you simply map the state-less eMMC PHY region:

     memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
                           "axiado.emmc-phy", 0x1000);
     memory_region_add_subregion(get_system_memory(),
                                 AX3000_EMMC_PHY_BASE, &s->emmc_phy);

> +
> +    card = qdev_new(TYPE_SD_CARD);
> +    qdev_prop_set_drive_err(card, "drive",
> +                            blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
> +                            &error_fatal);
> +    qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
>   }
>   
>   static void ax3000_class_init(ObjectClass *oc, const void *data)
> diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
> index 329aa4e7698..52b47aa8294 100644
> --- a/include/hw/arm/ax3000-soc.h
> +++ b/include/hw/arm/ax3000-soc.h
> @@ -13,6 +13,7 @@
>   #include "hw/intc/arm_gicv3_common.h"
>   #include "hw/char/cadence_uart.h"
>   #include "hw/misc/axiado_clk.h"
> +#include "hw/sd/axiado_sdhci.h"
>   #include "hw/core/sysbus.h"
>   #include "qemu/units.h"
>   
> @@ -34,6 +35,9 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
>   #define AX3000_UART2_BASE       0x80620000
>   #define AX3000_UART3_BASE       0x80520800
>   
> +#define AX3000_SDHCI0_BASE      0x86000000
> +#define AX3000_EMMC_PHY_BASE    0x80801C00
> +
>   #define AX3000_TIMER_CTRL       0x8A020000
>   #define AX3000_PLL_BASE         0x80000000
>   
> @@ -52,6 +56,7 @@ typedef struct Ax3000SoCState {
>       MemoryRegion        dram[AX3000_NUM_BANKS];
>       Ax3000ClkState      ax3000_clk;
>       CadenceUARTState    uart[AX3000_NUM_UARTS];
> +    AxiadoSDHCIState    sdhci0;
>   } Ax3000SoCState;
>   
>   typedef struct Ax3000SoCClass {
> @@ -65,6 +70,8 @@ enum Ax3000Irqs {
>       AX3000_UART1_IRQ    = 113,
>       AX3000_UART2_IRQ    = 114,
>       AX3000_UART3_IRQ    = 170,
> +
> +    AX3000_SDHCI0_IRQ   = 123,
>   };
>   
>   #endif /* AXIADO_AX3000_H */


