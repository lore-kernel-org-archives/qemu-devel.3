Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD46CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TM4-0008WF-OQ; Tue, 30 Sep 2025 01:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TLx-0008UH-CZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:56:47 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TLt-00042c-44
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:56:44 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.226])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cbS430H0Tz5wr9;
 Tue, 30 Sep 2025 05:56:35 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 07:56:34 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006cb911638-ef03-4498-9a4e-84254a9fcbb5,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <02fbbe79-277d-4d0e-b86d-ee04aae4a478@kaod.org>
Date: Tue, 30 Sep 2025 07:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Add support for the quanta-q7l1-bmc board
To: Patrick Venture <venture@google.com>, <peter.maydell@linaro.org>,
 <andrew@aj.id.au>, <joel@jms.id.au>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Hao Wu
 <wuhaotsh@google.com>
References: <20210416162426.3217033-1-venture@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20210416162426.3217033-1-venture@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 58fea24b-6054-4d25-a588-57b2969debbb
X-Ovh-Tracer-Id: 8147574676045335401
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEgRiVgyQ65njAjSCP8e2TKx6Khk4b1lwCDOK8AxTk/fHA9TZRfcatUOTkIM4hL04eim1AFjj3PJ5gdX2YrDFl3coGuOyuS1Q5aTohQH8UjO4edV/cuHYOd4vKmqyovgAKO/MeaDo+HAT8sLp8dWQ2tlOThfwXBIH9lgq4oqdahrkXb7zrEa+njwsxCyOdIBvFpICSItNFX+oOYr4nBR9kKliEQFsLocoNrmzNntDwEyYQwhQ+6+YQVCiesSMJfVSlXVGUH3XchE0y+VFc3iQNHXkNAO9OLzRu/lFQ//1Ji8k4f3I8+IIyy0/X7qSzRSOICFyjcS/lUkGKRqi/q8w3CQbpmAVwFFDfO1kgnoDHS0bf548ZdFsrxanzoZVZFxhuXbDTpzu5cG50SXSWIDAxR3LLVXD4cQvS3maSRvncEm/LHQjIMrnBGK00p4mVEUoJNxyON91Fcxhj3vwRXg+y4hy/FrScWh22NoSk3AcafpdkkdFW6BpNvNVv1qrGeM4BwPb5dhYHwOJPS7/8X+BJhEVBIvtoMGS8/kF/9qlNkSdJXtNSUPS0VgaZCTXJHcVZos45Yfiy4k1oV0L5QET6FzypkbBvS/jhVSsGlHTM4E9dazkqYa0/HuPVZUlrB67T1EOybqy577cyszukmFNvHT1hVWrO/csEf8EA2rv0P2A
DKIM-Signature: a=rsa-sha256; bh=AvexobqeaGNOEZPmAsSMRAApSsvwXjwfxEJgP3TJFcg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759211796; v=1;
 b=vqqReG0lFr98YQKW78PxMAOK4UcuP7deQHqrHpzvxpOoSbpRtNw+1YKixdI82LhEBhJ+jWD6
 8FerjwBMOzreMzO2V8/yrKXdHgyX3OSnEgpg7ew5Y4y8VcAnChKIEV6XCkmJ4/heSXs8PDo07yg
 i2f4Se2AW/v+nB0lOGWmQkpABngp9msnzM9Ch4VlOOqxf0QJaLMXuxlOCNd9Kpt0zODHYESyFBB
 +nzLOLBRebxHnkLweQYWTSqUxuB8VLeNrJissKiKE0Esfnt0gC+6ZmNsCkqG+9T/++HrVpJ4Q14
 okjJwrgVKGNOrGIg9rPWBA3f+/4CIy5MhdJ1vwPh5ddFw==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Patrick,

On 4/16/21 18:24, Patrick Venture wrote:
> The Quanta-Q71l BMC board is a board supported by OpenBMC.
> 
> Tested: Booted quanta-q71l firmware.
> Signed-off-by: Patrick Venture <venture@google.com>
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/arm/aspeed.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)

Would it be possible to contribute a functional test for this
machine ?

Since this machine contributes little to the Aspeed models,
its value lies in the firmware it can run to exercise the
models. Without functional tests, I plan to schedule the
removal in the QEMU 10.2 cycle.


Thanks,

C.



> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a17b75f494..4611996d21 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -138,6 +138,19 @@ struct AspeedMachineState {
>   /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
>   #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>   
> +/* Quanta-Q71l hardware value */
> +#define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
> +        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
> +        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2/* DDR3 with CL=6, CWL=5 */) | \
> +        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
> +        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_24M_IN) |       \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_PASS_THROUGH) |          \
> +        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
> +        SCU_HW_STRAP_SPI_WIDTH |                                        \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_8M_DRAM) |                        \
> +        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
> +
>   /* AST2600 evb hardware value */
>   #define AST2600_EVB_HW_STRAP1 0x000000C0
>   #define AST2600_EVB_HW_STRAP2 0x00000003
> @@ -433,6 +446,34 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>       object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
>   }
>   
> +static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = &bmc->soc;
> +
> +    /*
> +     * The quanta-q71l platform expects tmp75s which are compatible with
> +     * tmp105s.
> +     */
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
> +
> +    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
> +    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
> +    /* TODO: Add Memory Riser i2c mux and eeproms. */
> +
> +    /* TODO: i2c-2: pca9546@74 */
> +    /* TODO: i2c-2: pca9548@77 */
> +    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
> +    /* TODO: i2c-7: Add pca9546@70 */
> +    /*        - i2c@0: pmbus@59 */
> +    /*        - i2c@1: pmbus@58 */
> +    /*        - i2c@2: pmbus@58 */
> +    /*        - i2c@3: pmbus@59 */
> +    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
> +    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
> +}
> +
>   static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = &bmc->soc;
> @@ -728,6 +769,23 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
>           aspeed_soc_num_cpus(amc->soc_name);
>   };
>   
> +static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Quanta-Q71l BMC (ARM926EJ-S)";
> +    amc->soc_name  = "ast2400-a1";
> +    amc->hw_strap1 = QUANTA_Q71L_BMC_HW_STRAP1;
> +    amc->fmc_model = "n25q256a";
> +    amc->spi_model = "mx25l25635e";
> +    amc->num_cs    = 1;
> +    amc->i2c_init  = quanta_q71l_bmc_i2c_init;
> +    mc->default_ram_size       = 128 * MiB;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +}
> +
>   static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
>                                                           void *data)
>   {
> @@ -927,6 +985,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("g220a-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_g220a_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_quanta_q71l_class_init,
>       }, {
>           .name          = TYPE_ASPEED_MACHINE,
>           .parent        = TYPE_MACHINE,


