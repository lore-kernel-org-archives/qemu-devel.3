Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677C9C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaH1-0006a8-A2; Thu, 27 Feb 2025 04:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gGIw=VS=kaod.org=clg@ozlabs.org>)
 id 1tnaGp-0005vS-ST; Thu, 27 Feb 2025 04:33:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gGIw=VS=kaod.org=clg@ozlabs.org>)
 id 1tnaGm-00008p-Q3; Thu, 27 Feb 2025 04:33:31 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z3R3M32Qkz4x04;
 Thu, 27 Feb 2025 20:33:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z3R3G0stXz4wcr;
 Thu, 27 Feb 2025 20:33:13 +1100 (AEDT)
Message-ID: <3d7f76c5-9163-4994-8720-d611b0ebd42c@kaod.org>
Date: Thu, 27 Feb 2025 10:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/28] hw/misc/aspeed_scu: Fix the revision ID cannot
 be set in the SOC layer for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-16-jamin_lin@aspeedtech.com>
 <33698876-0408-4d10-89fe-2348829bfd6e@kaod.org>
 <SI2PR06MB5041CF2DD57131E147A5199CFCC22@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB5041CF2DD57131E147A5199CFCC22@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=gGIw=VS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin,

On 2/26/25 07:38, Jamin Lin wrote:
> Hi Cedric,
> 
>>
>> On 2/13/25 04:35, Jamin Lin wrote:
>>> According to the design of the AST2600, it has a Silicon Revision ID
>>> Register, specifically SCU004 and SCU014, to set the Revision ID for the
>> AST2600.
>>> For the AST2600 A3, SCU004 is set to 0x05030303 and SCU014 is set to
>> 0x05030303.
>>> In the "aspeed_ast2600_scu_reset" function, the hardcoded value
>>> "AST2600_A3_SILICON_REV" is set in SCU004, and "s->silicon_rev" is set
>>> in SCU014. The value of "s->silicon_rev" is set by the SOC layer via
>>> the "silicon-rev" property.
>>>
>>> However, the design of the AST2700 is different. There are two SCU
>> controllers:
>>> SCU0 (CPU Die) and SCU1 (IO Die). In the AST2700, the firmware reads
>>> the SCU Silicon Revision ID register (SCU0_000) and the SCUIO Silicon
>>> Revision ID register (SCU1_000) and combines them into a 64-bit value.
>>> The combined value of SCU0_000[23:16] and SCU1_000[23:16] represents
>>> the silicon revision. For example, the AST2700-A1 revision is
>>> "0x0601010306010103", where
>>> SCU0_000 should be 06010103 and SCU1_000 should be 06010103.
>>
>> Are both these values supposed to be identical ? if not, we should plan for
>> changes at machine/SoC level too.
>>
> 
> Currently, these values are supposed to be identical. Therefore, we can reuse the current design of the
> silicon_rev in the machine/SoC layer for AST2700.
> 
>>>    static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS]
>> = {
>>> -    [AST2700_SILICON_REV]           = AST2700_A0_SILICON_REV,
>>>        [AST2700_HW_STRAP1]             = 0x00000800,
>>>        [AST2700_HW_STRAP1_CLR]         = 0xFFF0FFF0,
>>>        [AST2700_HW_STRAP1_LOCK]        = 0x00000FFF,
>>> @@ -940,6 +939,7 @@ static void aspeed_ast2700_scu_reset(DeviceState
>> *dev)
>>>        AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
>>>
>>>        memcpy(s->regs, asc->resets, asc->nr_regs * 4);
>>> +    s->regs[AST2700_SILICON_REV] = s->silicon_rev;
>>>
>>>    }
>>>
>>>    static void aspeed_2700_scu_class_init(ObjectClass *klass, void
>>> *data) @@ -1032,7 +1032,6 @@ static const MemoryRegionOps
>> aspeed_ast2700_scuio_ops = {
>>>    };
>>>
>>>    static const uint32_t
>> ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
>>> -    [AST2700_SILICON_REV]               = 0x06000003,
>>>        [AST2700_HW_STRAP1]                 = 0x00000504,
>>
>> why isn't AST2700_HW_STRAP1 assigned with s->hw_strap1 property ?
>>
> 
> This is a bug. The design of the HW_STRAP register has changed in the AST2700.
> There is one hw_strap1 register in the SCU (CPU DIE) and another hw_strap1 register in the SCUIO (IO DIE).
> The values of these two hw_strap1 registers should not be the same.
> 
> To fix this issue, I made the following changes. Do you have any suggestions?

All Aspeed SoC models currently define "hw-strap1" and "hw-strap2"
properties as aliases on the same properties of the SCU model :

     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
                               "hw-strap1");
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
                               "hw-strap2");

For the AST2700 SoC, you could change the "hw-strap2" alias to point
to the SCUIO model  :

     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
                               "hw-strap1");
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scuio),
                               "hw-strap1");

> Additionally, would it be possible to submit a separate patch for the SCU silicon_rev and SCU hw_strap fix?

yes we should please.

> The patch series for supporting AST2700 A1 is quite large.

yes. That's why I asked you to split it :)

> Thanks-Jamin
> 
> 1. I dumped the real values of both registers on the EVB
> 
> root@ast2700-a0-default:~# md 14c02010 1  ----> SCUIO hw_strap1
> 14c02010: 00000500
> root@ast2700-a0-default:~# md 12c02010 1 --> SCU hw_strap1
> 12c02010: 00000800
> 
> The value AST2700_EVB_HW_STRAP1 0x00000800 is used for the SCU hw_strap1.
> The value AST2700_EVB_HW_STRAP2 0x00000500 is used for the SCUIO hw_strap1
> 
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -181,8 +181,8 @@ struct AspeedMachineState {
> 
>   #ifdef TARGET_AARCH64
>   /* AST2700 evb hardware value */
> -#define AST2700_EVB_HW_STRAP1 0x000000C0
> -#define AST2700_EVB_HW_STRAP2 0x00000003
> +#define AST2700_EVB_HW_STRAP1 0x00000800
> +#define AST2700_EVB_HW_STRAP2 0x00000500
>   #endif
> 
> 2.  Change to set hw_strap2 in the SCUIO model. Note this will modify the hw_strap1 register of the SCUIO.
> 
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -410,14 +410,14 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                            sc->silicon_rev);
>       object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
>                                 "hw-strap1");
> -    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
> -                              "hw-strap2");
>       object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                 "hw-prot-key");
> 
>       object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
>       qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
>                            sc->silicon_rev);
> +    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scuio),
> +                                  "hw-strap2");

Why use "hw-strap2" and not "hw-strap1" ?

Please add comments in the AST2700 SoC and AST2700 SCU models so that the
information does not get lost.

> 3. I introduced a new aspeed_ast2700_scuio_reset function for the SCUIO model and
> set the value of the hw_strap2 property to the HW_STRAP1 register of the SCUIO model.
> 
> s->regs[AST2700_HW_STRAP1] = s->hw_strap2;

That's weird. I would use s->hw_strap1.

Thanks,

C.


> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 259b142850..23ab7526f5 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -912,7 +912,6 @@ static const MemoryRegionOps aspeed_ast2700_scu_ops = {
>   };
> 
>   static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
> -    [AST2700_HW_STRAP1]             = 0x00000800,
>       [AST2700_HW_STRAP1_CLR]         = 0xFFF0FFF0,
>       [AST2700_HW_STRAP1_LOCK]        = 0x00000FFF,
>       [AST2700_HW_STRAP1_SEC1]        = 0x000000FF,
> @@ -942,6 +941,7 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
> 
>       memcpy(s->regs, asc->resets, asc->nr_regs * 4);
>       s->regs[AST2700_SILICON_REV] = s->silicon_rev;
> +    s->regs[AST2700_HW_STRAP1] = s->hw_strap1;
>   }
> 
>   static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
> @@ -1034,7 +1034,6 @@ static const MemoryRegionOps aspeed_ast2700_scuio_ops = {
>   };
> 
>   static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
> -    [AST2700_HW_STRAP1]                 = 0x00000504,
>       [AST2700_HW_STRAP1_CLR]             = 0xFFF0FFF0,
>       [AST2700_HW_STRAP1_LOCK]            = 0x00000FFF,
>       [AST2700_HW_STRAP1_SEC1]            = 0x000000FF,
> @@ -1057,13 +1056,23 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
>       [AST2700_SCUIO_CLK_DUTY_MEAS_RST]   = 0x0c9100d2,
>   };
> 
> +static void aspeed_ast2700_scuio_reset(DeviceState *dev)
> +{
> +    AspeedSCUState *s = ASPEED_SCU(dev);
> +    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
> +
> +    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
> +    s->regs[AST2700_SILICON_REV] = s->silicon_rev;
> +    s->regs[AST2700_HW_STRAP1] = s->hw_strap2;
> +}
> +
>   static void aspeed_2700_scuio_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
> 
>       dc->desc = "ASPEED 2700 System Control Unit I/O";
> -    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
> +    device_class_set_legacy_reset(dc, aspeed_ast2700_scuio_reset);
>       asc->resets = ast2700_a0_resets_io;
>       asc->calc_hpll = aspeed_2600_scu_calc_hpll;
>       asc->get_apb = aspeed_2700_scuio_get_apb_freq;
> 
> 
>> The above changes could be merged as a fix.
>>
>> Thanks,
>>
>> C.
>>
>>
>>>        [AST2700_HW_STRAP1_CLR]             = 0xFFF0FFF0,
>>>        [AST2700_HW_STRAP1_LOCK]            = 0x00000FFF,
> 


