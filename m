Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1289BCCD19A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 20:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKjeS-0002qV-Ot; Sun, 16 Nov 2025 15:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vKjeP-0002pg-QE; Sun, 16 Nov 2025 15:47:10 -0500
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vKjeM-00083e-OO; Sun, 16 Nov 2025 15:47:09 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.98])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d8jbl1kSTz5yfQ;
 Sun, 16 Nov 2025 20:46:58 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Sun, 16 Nov
 2025 21:46:57 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001f456cd2e-8db9-415e-bd1a-088123101773,
 341CA4BE1272FAB2DFA1B6D1A4625F22D6D7B78A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6253b8f4-7661-48b5-910d-2abe010c04e8@kaod.org>
Date: Sun, 16 Nov 2025 21:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 08/12] hw/arm/aspeed_ast10x0: Add AST1060 SoC
 support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
 <20251112030553.291734-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251112030553.291734-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 35b2dca2-4cb3-4a84-9bee-ae4cafe08427
X-Ovh-Tracer-Id: 4053802616971889470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTELNB8YEuNPcH7tImB3ujllpqAJgSE1UdOIpKFyeHSiSPD8rW0dBfviQVQefu9tXWnTYcWktdilKA/ib4GoQe5DL6lIT2GIQsGDuGE65VfTNaNrInh17EgT63pBjzHIVZLjit6zNIUlLFa5zTYyN636D3pq5jl8xNOgjY7CM+O10r4J6Kt/caZAqYk34WdEkz0o5FjEiIt7lNubQp9lOOETWvkbm8T6KcyarbfgdhWWwqc/9dOG9wkbKYLzXB3zqNBOzjOb6H6PSl683dnLR1tCcB6mluJOoaC1AfG836dgMxKQXeebMhDAHQcweXJ22JJB4tI30WGIbI8WSMhItSK7oDlerLeAFUwedI0Y6yOaBMm0QfBjNGeEsUjsHqRFSr/LvXdfF32/lHvW6uGhxgXMZg9zPyUOvdu7+nMlNO8SU8nLk1KgQD0JWw5ZFtsqrpaL1ZXhn6WDEqRG/ELyXIwEXPnXRGvGhw6qNkxf6g95gsbMk8UvBNpYWvBVx4nC4v05Z4q+rbLYGMhZ6t3/TJ9lBgBoP0pGURqMlowrfMuVKoFzwL8bmtOtoAruH3tTxA2/vbjahkxCSuoOBY4H2/MpPKHt9yrCSA8msp9rjU+ZU/nDqw+ZQeFgBqwv3IUlaubTRlmtT6l/j/Rt2nd1mcG5VQzooUs/w3VcwYUAUNLRSQ
DKIM-Signature: a=rsa-sha256; bh=l2TVH9YOQo/0hD0npMnI10Pg2uE7125Qkw4HpVPhRsk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763326020; v=1;
 b=sBWGe6DlYUK5to9U0fE1OS8MIGCdztyJZxuIDM4eDEeEdm1YokOugbmYNGY+sCC1E9hMxn5k
 gKDpZ52HXhKpo26Q1UIUPCillXD4Me2OG4Eevow9WjtDWeAN0FKvQtW7EHa81sYnbuXaP4QBZK3
 vWxYlcTfuIQkAjscrIv8G6H40bxfIhkooyacJm+RzrQ1hDJryUjo+jHsH0Iwqotuja+t1NbMA10
 jSidjFFBX9YRJpvUVYzFIXwPrfSIHXzXt0VN5tOu9itWXbR4R5CSHTUg64c/k1GBgKkXrt3Bp68
 DDsoDVBj/tf3FZPAmgF7Y5oOTYX/QsPa+gTcSy7speoOA==
Received-SPF: pass client-ip=188.165.58.48; envelope-from=clg@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/12/25 04:05, Jamin Lin wrote:
> Add initial support for the Aspeed AST1060 SoC. The AST1060 reuses most
> of the AST1030 peripheral device models, as the two SoCs share nearly
> the same controllers including WDT, SCU, TIMER, HACE, ADC, I2C, FMC,
> and SPI.
> 
> A new common initialization and realization framework (ast10x0_init
> and ast10x0_realize) is leveraged so AST1060 can instantiate the
> existing AST1030 models without redefining duplicate device types.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 59 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index 1521000af0..bcfe83bdb7 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -185,6 +185,23 @@ static void aspeed_soc_ast1030_init(Object *obj)
>       object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>   }
>   
> +static void aspeed_soc_ast1060_init(Object *obj)
> +{
> +    /*
> +     * The AST1060 SoC reuses the AST1030 device models. Since all peripheral
> +     * models (e.g. WDT, SCU, TIMER, HACE, ADC, I2C, FMC, SPI) defined for
> +     * AST1030 are compatible with AST1060, we simply reuse the existing
> +     * AST1030 models for AST1060.
> +     *
> +     * To simplify the implementation, AST1060 sets its socname to that of
> +     * AST1030, avoiding the need to create a full set of new
> +     * TYPE_ASPEED_1060_XXX device definitions. This allows the same
> +     * TYPE_ASPEED_1030_WDT and other models to be instantiated for both
> +     * SoCs.
> +     */
> +    aspeed_soc_ast10x0_init(obj, "ast1030");
> +}
> +
>   static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
>   {
>       AspeedSoCState *s = ASPEED_SOC(a);
> @@ -451,6 +468,15 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>                                   sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
>   }
>   
> +static void aspeed_soc_ast1060_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
> +
> +    if (!aspeed_soc_ast10x0_realize(a, errp)) {
> +        return;
> +    }
> +}
> +
>   static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
>   {
>       static const char * const valid_cpu_types[] = {
> @@ -479,6 +505,32 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
>       sc->num_cpus = 1;
>   }
>   
> +static void aspeed_soc_ast1060_class_init(ObjectClass *klass, const void *data)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
> +        NULL
> +    };
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
> +
> +    /* Reason: The Aspeed SoC can only be instantiated from a board */
> +    dc->user_creatable = false;
> +    dc->realize = aspeed_soc_ast1060_realize;
> +
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev = AST1060_A2_SILICON_REV;
> +    sc->sram_size = 0xc0000;
> +    sc->secsram_size = 0x40000; /* 256 * KiB */
> +    sc->spis_num = 2;
> +    sc->wdts_num = 4;
> +    sc->uarts_num = 1;
> +    sc->uarts_base = ASPEED_DEV_UART5;
> +    sc->irqmap = aspeed_soc_ast1030_irqmap;
> +    sc->memmap = aspeed_soc_ast1030_memmap;
> +    sc->num_cpus = 1;
> +}
> +
>   static const TypeInfo aspeed_soc_ast10x0_types[] = {
>       {
>           .name           = TYPE_ASPEED10X0_SOC,
> @@ -490,7 +542,12 @@ static const TypeInfo aspeed_soc_ast10x0_types[] = {
>           .parent         = TYPE_ASPEED10X0_SOC,
>           .instance_init  = aspeed_soc_ast1030_init,
>           .class_init     = aspeed_soc_ast1030_class_init,
> -    },
> +    }, {
> +        .name           = "ast1060-a2",
> +        .parent         = TYPE_ASPEED10X0_SOC,
> +        .instance_init  = aspeed_soc_ast1060_init,
> +        .class_init     = aspeed_soc_ast1060_class_init,
> +    }
>   };
>   
>   DEFINE_TYPES(aspeed_soc_ast10x0_types)


