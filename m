Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8187CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TNC-0000om-Bm; Tue, 30 Sep 2025 01:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TN8-0000l5-1x
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:57:58 -0400
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TMx-0004Hq-KU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:57:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.106])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cbS5H2dq1z6Mww;
 Tue, 30 Sep 2025 05:57:39 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 07:57:38 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002f59f1ff7-f3fa-458d-8289-6cf44d58ccd7,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <99ab7990-246f-4dfc-a9d7-138819467377@kaod.org>
Date: Tue, 30 Sep 2025 07:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Add support for the fp5280g2-bmc board
To: John Wang <wangzq.jn@gmail.com>, <lintao.lc@inspur.com>,
 <liuxiwei@inspur.com>, <duanzhijia01@inspur.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>
References: <20211014064548.934799-1-wangzhiqiang02@inspur.com>
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
In-Reply-To: <20211014064548.934799-1-wangzhiqiang02@inspur.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: aeab80e4-3d8c-456c-bf61-fec9a2114021
X-Ovh-Tracer-Id: 8165870550334999343
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFZ6FRRCOxoJb4epA3MXHEboTE03w9Lhs+STd70XQXmnypB60uFQz9KuHkzOzliANV9/shKe9if1Ctkg2lJayRFcYq9tQSPtjKwou5U0bbyL63rxctujp8V8kcijcvEMhfD3UORGXfEP6+EesUQKn2ZqbgFxSXhbIdfCqoJEin55/nK9dEP0Q6jZC6Eyxyfpl0QpNU9HGCrefztUfJZVK8unCkeddhvIRGTICDnvzSGy98lGgvNEMLMOaaoah5Et1QBbMTgUfZRt/roxtGcqQfu7ffs7gk/3b+giltgHGNRu0kuVY+R4pyHvkDdt/uCRuQxj9yMjNV479+AKA1NTWxkbqIXxCtABHwQmgbAFL0OhR39wPOMjqM0xCiLymXQytyjtJzQAIHtEEGwqcwf6NQbni3eIFn3hcj4HI9tVwcKGQM43NS4BHSYiWdXSmSc0XjPiMvlLPGPzJA55uQhuDaAiMdkZ97rTOnzTC67eoz9d3s7tGiVfJNcz5FCqkuaOl4b9vmGU++1/r+MensXQJeSpt34nc34jEEsDEtLeYyHuwKRnbW89+BmyLC05BU2ZF5s8WoEDoFuTvY0Gh/cddCYzY5/Ca2XghssMWNwI9BkDaB7hJdSs3H+IDcg8PiuqFWHwZLZZE2h+J/JEIGPdrK0WJJppu1z7dzYEVflIdv7mA
DKIM-Signature: a=rsa-sha256; bh=lo3Q7tm69kivvyw2+xXJF59gBIAhemsk3I674QG1GC0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759211860; v=1;
 b=U48Ci+B6pg9GPFnT/5CeXDJk5h82fbrO5hSauUVLBm73X0hsEB3G2ZPpisGivjBvXAMZHEgl
 fV5tP7cuo7lGNyBrRIogRifh6RVsZYMmQDscTPUyAF+n+s7i/TgHFPyE2Jxl81rMsXD4XfhMPDG
 GsrLaun623moh1fMXNbpA2FKji7Ipm0eTcFyYk2m4g0MtFupBFCvlATEipee6msVGl63aEopYxY
 AEUP/PoZZ49RFP58CEWvddJvwkJNiFseTB5ZPtY/gOF1u7YFgfw1cbmZEjSkNn1LFSmOgzI973E
 cmwyq53CnAkAIuKE2XnJrOtVU65jacPUC2DuTDe2T9y7Q==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=clg@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/14/21 08:45, John Wang wrote:
> The fp5280g2-bmc is supported by OpenBMC, It's
> based on the following device tree
> 
> https://github.com/openbmc/linux/blob/dev-5.10/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> 
> Signed-off-by: John Wang <wangzhiqiang02@inspur.com>
> ---
>   hw/arm/aspeed.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)

Hello John,


Would it be possible to contribute a functional test for this
machine ?

Since this machine contributes little to the Aspeed models,
its value lies in the firmware it can run to exercise the
models. Without functional tests, I plan to schedule the
removal in the QEMU 10.2 cycle.


Thanks,

C.





> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 01c1747972..21b690334e 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -141,6 +141,21 @@ struct AspeedMachineState {
>           SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
>           SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
>   
> +/* FP5280G2 hardware value: 0XF100D286 */
> +#define FP5280G2_BMC_HW_STRAP1 (                                      \
> +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
> +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
> +        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
> +        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
> +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
> +        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
> +        SCU_HW_STRAP_MAC1_RGMII |                                       \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
> +        SCU_AST2500_HW_STRAP_RESERVED1)
> +
>   /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
>   #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>   
> @@ -456,6 +471,15 @@ static void aspeed_machine_init(MachineState *machine)
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
>   }
>   
> +static void at24c_eeprom_init(I2CBus *bus, uint8_t addr, uint32_t rsize)
> +{
> +    I2CSlave *i2c_dev = i2c_slave_new("at24c-eeprom", addr);
> +    DeviceState *dev = DEVICE(i2c_dev);
> +
> +    qdev_prop_set_uint32(dev, "rom-size", rsize);
> +    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
> +}
> +
>   static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = &bmc->soc;
> @@ -717,6 +741,34 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
>                             eeprom_buf);
>   }
>   
> +static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = &bmc->soc;
> +    I2CSlave *i2c_mux;
> +
> +    /* The at24c256 */
> +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
> +
> +    /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
> +                     0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
> +                     0x49);
> +
> +    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +                     "pca9546", 0x70);
> +    /* It expects a TMP112 but a TMP105 is compatible */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), TYPE_TMP105,
> +                     0x4a);
> +
> +    /* It expects a ds3232 but a ds1338 is good enough */
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
> +
> +    /* It expects a pca9555 but a pca9552 is compatible */
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_PCA9552,
> +                     0x20);
> +}
> +
>   static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = &bmc->soc;
> @@ -1082,6 +1134,24 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
>           aspeed_soc_num_cpus(amc->soc_name);
>   };
>   
> +static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Inspur FP5280G2 BMC (ARM1176)";
> +    amc->soc_name  = "ast2500-a1";
> +    amc->hw_strap1 = FP5280G2_BMC_HW_STRAP1;
> +    amc->fmc_model = "n25q512a";
> +    amc->spi_model = "mx25l25635e";
> +    amc->num_cs    = 2;
> +    amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
> +    amc->i2c_init  = fp5280g2_bmc_i2c_init;
> +    mc->default_ram_size = 512 * MiB;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +};
> +
>   static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1146,6 +1216,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("g220a-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_g220a_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_fp5280g2_class_init,
>       }, {
>           .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,


