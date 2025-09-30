Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C89FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TMc-0000R7-Cm; Tue, 30 Sep 2025 01:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TMa-0000Qk-L8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:57:24 -0400
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TMS-0004Ax-MY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:57:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.133])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cbS4l1c0jz6Mww;
 Tue, 30 Sep 2025 05:57:11 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 07:57:10 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S00788094cb5-eeb5-440e-a5ad-5adcde07db5f,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a3e42923-d81a-40c2-8b17-28d6264d5518@kaod.org>
Date: Tue, 30 Sep 2025 07:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] aspeed: Add support for the g220a-bmc board
To: John Wang <wangzhiqiang.bj@bytedance.com>, <xuxiaohan@bytedance.com>,
 <yulei.sh@bytedance.com>, <joel@jms.id.au>, <f4bug@amsat.org>
CC: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20201025131435.144-1-wangzhiqiang.bj@bytedance.com>
 <20201025131435.144-2-wangzhiqiang.bj@bytedance.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20201025131435.144-2-wangzhiqiang.bj@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: a3b539e8-98d1-4e35-9d1e-f187b2f886c8
X-Ovh-Tracer-Id: 8157989253279550255
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGWbseo7FTNtuJMt3NG/7jcy6airEsBG+lEOtZR/pLSrn005JiYb89/n2h2eOpFDsgEdLm4pB7iZQjpsLX7sdmxwe/bLeXKBxC+0zBLAvQZLgBXEht4mE3hiSEEdyq4/o5HXpt4LBiQaQ7uXPbVlY23BEVGNPPSRhEcpUCePBpaAYSp6lyQpj6smzK7M/9NXvcQen0LLA8PyH3xEG8tx+SH2PiDxUW/zsaI2oTK7y0OLolXH6Y7NC5criVTu5J2eMQkl0rxvvpkAVszea/dw7AmZHn8lk3Wq/L8B9i4tK4nChAdVGJFDOM48z4D6DAnkcB/h+Kzcdi1QUPAjVBausNbY96/BWqPfUqGB5tt1hqTu9VEkol/r5XVi06Bu+Jjiqtww5x+O1F2dB4t3i35ev+hlb9cEqZvUUaCSxONW3OvdxqkiomDdktW5e/O7BJF9zv/WiKcutiu8qxWhfTtScZXXCuLlsGJ7O2RxJqrA3ZT8R529y0rTwxZcp2elKc4eMYz/0f5JpED0eln2Bim9S5J8R31ho38Ovyy7M9GHJo9/4QsQP/hgd6vk2ZUSwNMmL16Jyxy4QkcvG3gYsJ4uzIYWi9ObYbfpc3oNFSRU3r5UFxG1s3SpiqoHgxjYZDBKWWtHm0HiItQvXj727x3t72EIrTAQYZOTUSNuQfpn3gY/A
DKIM-Signature: a=rsa-sha256; bh=K0rfuzrXAMNT00wtdL1mBIv/pHPZZXToEbhC+2FWkwI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759211831; v=1;
 b=cCCaivbDHAEsjrCwqwD5qwJzIe/N3+pwnPJrWKlxkRjiXEw7kLUyDLLjDF1rFtAZVUBWdGlj
 cuOXOJ7yycW9vHzgUHbiaEBGdDkTJD4SsNXLIfu4QVxAcsHkmzYc885+dT7hkMGqgS8SbdbzbmC
 CFGdIw751wdgMlAyKn90v1KbxzxRgeYz7HNv/HhZpOdC61yX46CtondDTtBhvcsps2EG7Sa/8eM
 WeUL+O5OZpNID+hdONgexFQEmWmsnAa6NiEVR3cxHZpuyhCdUhrXjA5d6MtZLM34UZts2wxCNPF
 ZgMvt3fweuxz+5V3uipmJPFby9wyS3uD14Ngn1PAPMjVg==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/25/20 14:14, John Wang wrote:
> G220A is a 2 socket x86 motherboard supported by OpenBMC.
> Strapping configuration was obtained from hardware.
> 
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Hello John

Would it be possible to contribute a functional test for this
machine ?

Since this machine contributes little to the Aspeed models,
its value lies in the firmware it can run to exercise the
models. Without functional tests, I plan to schedule the
removal in the QEMU 10.2 cycle.


Thanks,

C.



> ---
> v3:
>    - No changes
> v2:
>    - No changes
> ---
>   hw/arm/aspeed.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index bdb981d2f8..04c8ad2bcd 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -120,6 +120,20 @@ struct AspeedMachineState {
>           SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
>           SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
>   
> +#define G220A_BMC_HW_STRAP1 (                                      \
> +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
> +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
> +        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
> +        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
> +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
> +        SCU_HW_STRAP_2ND_BOOT_WDT |                                     \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
> +        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                       \
> +        SCU_AST2500_HW_STRAP_RESERVED1)
> +
>   /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
>   #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>   
> @@ -559,6 +573,30 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>       /* Bus 11: TODO ucd90160@64 */
>   }
>   
> +static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = &bmc->soc;
> +    DeviceState *dev;
> +
> +    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +                                         "emc1413", 0x4c));
> +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
> +
> +    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12),
> +                                         "emc1413", 0x4c));
> +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
> +
> +    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 13),
> +                                         "emc1413", 0x4c));
> +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
> +}
> +
>   static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
>   {
>       return ASPEED_MACHINE(obj)->mmio_exec;
> @@ -798,6 +836,24 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>           aspeed_soc_num_cpus(amc->soc_name);
>   };
>   
> +static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Bytedance G220A BMC (ARM1176)";
> +    amc->soc_name  = "ast2500-a1";
> +    amc->hw_strap1 = G220A_BMC_HW_STRAP1;
> +    amc->fmc_model = "n25q512a";
> +    amc->spi_model = "mx25l25635e";
> +    amc->num_cs    = 2;
> +    amc->macs_mask  = ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> +    amc->i2c_init  = g220a_bmc_i2c_init;
> +    mc->default_ram_size = 1024 * MiB;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +};
> +
>   static const TypeInfo aspeed_machine_types[] = {
>       {
>           .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
> @@ -835,6 +891,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("tacoma-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_tacoma_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("g220a-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_g220a_class_init,
>       }, {
>           .name          = TYPE_ASPEED_MACHINE,
>           .parent        = TYPE_MACHINE,


