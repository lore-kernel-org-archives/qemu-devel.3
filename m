Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF81CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEYe-00032N-9U; Thu, 18 Jun 2026 11:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waEYb-00030o-VI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:21:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waEYX-0001Sv-Cz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:21:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IFE6Pg1635312
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jsx9lPFEtq0p20h1wA6KKtp9YilP1RE9WchV1NPTF5I=; b=jPAdzJgHjSb1+7mi
 5K57uFmNlX7Eyfzjjw6Axks0xxvsiSJjkLHzYNUDL6wt46srkfJwsokE4cfLVyvC
 T8UbihGnx/xUEM3lY3ODNMfiiEP3DgAMsvQdbIhdql4cA4Nj49hEZ/AaYO4H+a1V
 GOgepnNjuK2WoKjxfWrMbTi/VunHrJGO7+Up9DCGjI7qvuYZJ5MYeWfYTUFQC+of
 tRQhxtPeO0o0Zdxd/yQX6IubUmnuBLmZ1Yp+F2/lQEc7g6mpTQqh5/9ksynZEUl3
 8TnZ2v+461D+1E32Y9NJXN1kDeSS1aAGpiYehBY9P0btjSXAFHJrglmKDookNhs/
 YBRJ6A==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2cd4qr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:21:04 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-48638da0e05so1211112b6e.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781796063; x=1782400863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsx9lPFEtq0p20h1wA6KKtp9YilP1RE9WchV1NPTF5I=;
 b=GaS9jJ9nn5Cq4H2pPwwSAk37t6zoIBoxdHveLSDre+9RmFTdrHJ9O/bSVtdNOlXwQv
 ZOzaEQU8uhgs52nZO46MV4k8UOf2nLYZYsUJ2QEsrexY2UbTGRmNms8LN9sqIF3cptZS
 oSBSxXGucZpLb10JC0oFfNrWx3C9hyV6u4sOXPVh1SRmeS1FLpkUNKDfQJDy+eCgHrPc
 4e+xXaDaVJjX6HsjUyC8PVMz2rEtWXIJYoGmu98SuUbr1cdtEA5iAfkNZtZIsl7W8Qht
 bFYFxtM9X+qJaD3V+8QqcF5La9io2KQFMQ2w95q0Q7OwoYm9uJQUV0xYR0g5HHfSijOm
 sUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796063; x=1782400863;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsx9lPFEtq0p20h1wA6KKtp9YilP1RE9WchV1NPTF5I=;
 b=CQE36kXB8czQbTANGKNUbfMhkSHVTQkU+/7PaEqWY7CLhKokab+vDb+7uh8JjcwvVw
 izPWT9x5hG7w4QMhoay1qMo/g3DVugtsWXy3LEUL3p2p1wvEQlo7ZL2Hvs+MptH72Vi/
 uMCMoWEmSldwYkH/oFv4qkVEJpfTV6OKx/NFGjlynDs/XwhjgLli8UlAmT1uN7xxl3F4
 rilRB0tisULPiE52VcvdtLuR6PBoQZDovKpgcu07eyllL7QcJUjjHItJk2BCQBUHEQJY
 ISEeOYSGv4OArY9NA3qNZIOCTCQnejhHwPP5mXwApwHskxcwmi5l89PNIAaZXzUOPlVq
 FsOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ94eRBm5P2NQBEZ0UE0Bq011dE9ZSA6w3sSo3dhR9foC1+2xFgbB3oSvMxDxrFazDgQI/TfxzVpGppL@nongnu.org
X-Gm-Message-State: AOJu0Yxj83dwuSh67cgW+P1+qPsMdmOTW1qVqMbO7NDSHQgJkVoZd+UW
 4/eyX4Rpf2IRBbXvaamy1zCTdElxDJTRWDhtLKMmU+5n9yAbAmCfLk5M4xihROuM8GlLaaiimW1
 6t0kmNh0z2dILz5uG18TYU9I1mMcHOOW7YjFmoYPfAy/cPyQjgM5btDprYw==
X-Gm-Gg: Acq92OF/AzQcmP3ImtS5ln/dgQu+gexQmDbNKzv1FZmeaEDNX7lD0LEIs/cEzpPlVmO
 N6lB5ws/pnwtVduoySrXapW+Ions+dYZWu7IDrE8KPqb3QbUBEkgPm9dBS5TfAos4OY6wRNQQjF
 aEQu0ZCfVR+xH3DgQn8DnDBJ5/gwlhScDRI1t81LwCyiZJvFC/YTLDiTHiR6iTSUdhPYx3giMpz
 vPSLqNuRAMHU2893sxHWIieqECHzQwmSux2lliUSwXa7+xd8gSsNlb2lG0QNS9cDC0akSZZ+JJU
 takCsb5he5bM6l9DOY51vavT1MQubm/4JgEmYPhbnzMIYlak3B651pGcWE6g9UFt4ExecHK0EyJ
 yPXl8BGy6XosQEjLv5NciNYarpDSz3oD23ezPm7h/SQIm1qwZ+qy29w/z6jO14Q==
X-Received: by 2002:a05:6808:14cd:b0:479:e96e:65aa with SMTP id
 5614622812f47-489446a7fd2mr7146412b6e.42.1781796063357; 
 Thu, 18 Jun 2026 08:21:03 -0700 (PDT)
X-Received: by 2002:a05:6808:14cd:b0:479:e96e:65aa with SMTP id
 5614622812f47-489446a7fd2mr7146383b6e.42.1781796062705; 
 Thu, 18 Jun 2026 08:21:02 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d585esm62825235e9.2.2026.06.18.08.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 08:21:01 -0700 (PDT)
Message-ID: <b1dac60a-f4fb-47cc-9a92-f45732f9d684@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 17:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-9-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618101249.2926976-9-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0MiBTYWx0ZWRfX2As1FnWlNAvn
 EhlP7YCqEy5SbjvSOtL5KpMFzk3vftEjnbuy6c7nP/jN+7AHrB8NuE7VOnHGB40jK9vUWgaCcH9
 9yH6FB7bCDdbuGy5bHlh/CiQeKNyaaL94QFLtpX4TCsT8h8/dBTBLi0h0vzCXfTtUUUKW8lt6xY
 zPRbpKnAiCGZyp2hBeHUlRi3SHMNo4x4z2y2YoiHvV8ZPkWeKrqAd63AsVpIhON2+fbi6o5ju7B
 jjz7NcGc4AHVv2OS4RckCr+wsyw91oGkSKEIIkDGxbOzYszqcJEgVZ4pw1jqPNFcVOhyvZqSZqp
 MNKfX5aXoBZg2rMG6nA1IW5ZpRX+twMRASnTwZ+l0pwILIlQscPV23lAl5NzfHdx9cdkzOddSdz
 dXK1ZORhsRYQZhqeQRS5cNb1xmqFCNSigXMjzDmYdIm4cHB8Oq5kaOO8iuhGaVYCihidG8S68Cl
 3p++Lk+3gwOoaLwKxTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0MiBTYWx0ZWRfX+sW0zI1SMzRM
 PAfW91lKtkebu5ArSt/xxqDhGNViilrUohQvon4ICuua5pgwD368FaNbGNht5sa//OQE1v6yBFl
 eGooB/e3Fn0u9HwU5LLRYKviYahzM/c=
X-Proofpoint-GUID: qAXu8dTh4sBbQHVmUwXJUkHNWoFy5RKY
X-Proofpoint-ORIG-GUID: qAXu8dTh4sBbQHVmUwXJUkHNWoFy5RKY
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a340ce0 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=440cDlBIAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
 a=d9D1X1bx8dWolqnE4HNT:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180142
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

On 18/6/26 12:12, Kuan-Jui Chiu wrote:
> Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig              |  1 +
>   hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
>   3 files changed, 52 insertions(+)


>   static void ax3000_realize(DeviceState *dev, Error **errp)
> @@ -183,6 +188,31 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
>                               blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
>                               &error_fatal);
>       qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
> +
> +    /* GPIOs */
> +    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {

static const

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } gpio_table[] = {
> +            { AX3000_GPIO0_BASE, AX3000_GPIO0_IRQ },
> +            { AX3000_GPIO1_BASE, AX3000_GPIO1_IRQ },
> +            { AX3000_GPIO2_BASE, AX3000_GPIO2_IRQ },
> +            { AX3000_GPIO3_BASE, AX3000_GPIO3_IRQ },
> +            { AX3000_GPIO4_BASE, AX3000_GPIO4_IRQ },
> +            { AX3000_GPIO5_BASE, AX3000_GPIO5_IRQ },
> +            { AX3000_GPIO6_BASE, AX3000_GPIO6_IRQ },
> +            { AX3000_GPIO7_BASE, AX3000_GPIO7_IRQ }
> +        };
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +                           qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
> +    }
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


