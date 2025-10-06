Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F2DCCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 06:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5f4l-0002th-BL; Mon, 06 Oct 2025 02:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v5f4i-0002t2-Tl
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:52:01 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v5f4f-0006JK-Gw
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:52:00 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.125])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cg90r5kCjz5vrk;
 Mon,  6 Oct 2025 06:51:40 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 6 Oct
 2025 08:51:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0028e78b4ca-78db-4b4f-af7d-ef3f58ee9698,
 2A4D30842C45B96828C1A5DB6F3240A43949B9E0) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3bd1c57e-3d6c-46ea-8a35-d26d7e7863cc@kaod.org>
Date: Mon, 6 Oct 2025 08:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 1/6] hw/arm/aspeed: Add 'ioexps-num' property
 for AST27x0
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
 <20250917013143.1600377-2-kane_chen@aspeedtech.com>
 <454d8e49-ce7d-4e6e-9115-8b2db2f645c5@kaod.org>
 <SI6PR06MB7631260957F33C379575C6F0F716A@SI6PR06MB7631.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631260957F33C379575C6F0F716A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 733eb03e-8a5a-4995-8f0a-538b8a1c8801
X-Ovh-Tracer-Id: 7420806289423043506
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGRBzDSxHYNVIch1torIeTBKO4NRdDQv2oHRhgIZxqcexoG1LAyEGMpYW9I6pX9/wJ0wg5nmSsoGFB5OmAvqTQc2xvxdM8Wy5gjl3qwXSQI00Kx8JbtNgUNKIfI++TI0pg7JXAwJRc8IHr1CUnzeSD4UudRqof2S0UFFYx3lXr+TZ8E2sG2nrknCKFPL5md3MnagKc62Z10PRtbXjxUcwQvN4D2b8b79yKxtvkpORKTHfLYnzx0gEma8PljoSlZf6ny06Mq64/KVW8gActGPGJv6rVQ8oF5x9E3JTmxuLoypcx3d/xQiqTivqu+O4ll3ZhEYWU6CwTnaNiJ9QydLgsgn6ZRGJs9++X0BMpl4JM+kQo9tjwb1cubhUrNddrSynkdrCd/Yjf/zidtId1x0Z306xVKq67GuMA8WSyk3MjA3Zq21q+8ujNdBJzUq+hK7fNc3lSewAZpk5hc2lQY31V2SoGGcWLQU/bEFR3q7Bem/s/7dhBJZmd6G65djt0CPJY2upEC5VddJGrEgjA18qjIpVUYqeO2ljtP/nMiI5LcX16/TPj2GLtj7f0pV+l9FK+WwIFJqQOiRKNriQUisyqvaT6iOyFrz7GjNSTuVqIq3c4FnBQbIX2CVXfjI8ROOhuhfRjbdXXJVk9JbCqjDGnBzqBJCaHsPWCv5+sUduhkUQ
DKIM-Signature: a=rsa-sha256; bh=oGbfUuNAiiuGsjMXsoqwrxkJIvJTMBUqCUH3xQV4yNg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759733502; v=1;
 b=AevP3+rwh3r1hKcSsFn8mdE+Yht0ymYs3G8+Z03PBHOdkX1argXiTBa6kA2mcr7S1o0few/v
 nKva1VQ+WjjlQJVDolk8rlO/MM8JQdSGBjR5sa0plVPrGfhr1Ld3GObY0MBaQU8phfuBvC9TO7I
 O13gIzGFt2YrAeCPHaqTRT/C1717o4aoGfl88zgLVy0earabWgAIGYNxqaFPgeKQ20mzGeHnYYH
 Zhct45RDPlfn/rQXr3TaDsCM815BGrxqA9Aem38ilPnuboHZDllu1YCQUUMH9CEXDdbd7AD/Tjx
 aqUPOyq/a90ux4x7wkwjPtd0u5Cg6Q7G9vAFzyJqzJdig==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello Kane,

On 9/18/25 11:46, Kane Chen wrote:
> Hi Cédric,
> 
> Adding a bit more context here: I'll fold these details into the commit log in the next revision.
> 
> LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM 2.0 specification (see Figure 2):
> https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
> 
> LTPI is a protocol and physical interface for tunneling various low-speed signals between the HPM and SCM. In Figure 2, the AST27x0 (left) integrates two LTPI controllers, allowing it to connect to up to two AST1700 boards. On the right, the AST1700 side consolidates the HPM FPGA and other interfaces (GPIO/UART/I2C/I3C, etc.) onto a single board.
> 
> Because the AST1700 exposes additional I/O interfaces (GPIO/I2C/I3C, etc.), we refer to it as an "I/O expander". Once connected over LTPI, the AST27x0 can control more downstream devices. Note that the AST1700 contains ROM code only and does not support firmware updates, so its behavior is fixed.
> 
> When using the AST1700, include the following DTS snippets to enable the additional interfaces:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi0.dtsi
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi1.dtsi
> 
> If any information is missing, please let me know and I will do my best to provide further details.


Sorry, I was distracted by other topics.

Please resend, taking into account my first comments.

Each device model proposal should include a commit log that briefly
describes the hardware unit, outlines what the model implements,
and what it does not.

AFAIUI, the AST1700 IO expander is different from the AST2700 SoC
and the implementation should rely on its own set of init and realize
handlers.

Thanks,

C.



> 
> Best Regards,
> Kane
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Wednesday, September 17, 2025 4:22 PM
>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
>> open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
>> here <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [SPAM] [PATCH v1 1/6] hw/arm/aspeed: Add 'ioexps-num'
>> property for AST27x0
>>
>> Hello Kane,
>>
>> On 9/17/25 03:31, Kane Chen wrote:
>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>
>>> AST27x0 platforms can attach up to two AST1700 IO expander boards.
>>
>> what are AST1700 IO expanders ? How are they attached to the main board ?
>> on which bus ?
>>
>>> Introduce the 'ioexps-num' property to let users specify how many IO
>>> expanders to instantiate for a given machine.
>>>> This enables modeling board variants that ship with 0-2 expanders.
>>>
>>> Note: AST2500 and AST2600 do not support IO expanders; this property
>>> is only available on AST27x0 machines.
>>>
>>> Command usage:
>>> ```
>>> ./qemu-system-aarch64 -M ast2700a1-evb,ioexps-num=2 \
>>>     -drive image-bmc,format=raw,if=mtd \
>>>     ...
>>> ```
>>
>> I would prefer these changes modifying the uapi to come at the end when the
>> modeling is done.
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>> ---
>>>    include/hw/arm/aspeed_soc.h |  2 ++
>>>    hw/arm/aspeed.c             | 49
>> +++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 51 insertions(+)
>>>
>>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>>> index 217ef0eafd..77263cc6ec 100644
>>> --- a/include/hw/arm/aspeed_soc.h
>>> +++ b/include/hw/arm/aspeed_soc.h
>>> @@ -49,6 +49,7 @@
>>>    #define ASPEED_MACS_NUM  4
>>>    #define ASPEED_UARTS_NUM 13
>>>    #define ASPEED_JTAG_NUM  2
>>> +#define ASPEED_IOEXP_NUM 2
>>>
>>>    struct AspeedSoCState {
>>>        DeviceState parent;
>>> @@ -103,6 +104,7 @@ struct AspeedSoCState {
>>>        UnimplementedDeviceState ltpi;
>>>        UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>>>        AspeedAPB2OPBState fsi[2];
>>> +    uint8_t ioexp_num;
>>>    };
>>>
>>>    #define TYPE_ASPEED_SOC "aspeed-soc"
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
>>> c31bbe7701..593cb87bfe 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -32,6 +32,7 @@
>>>    #include "qemu/units.h"
>>>    #include "hw/qdev-clock.h"
>>>    #include "system/system.h"
>>> +#include "qapi/visitor.h"
>>>
>>>    static struct arm_boot_info aspeed_board_binfo = {
>>>        .board_id = -1, /* device-tree-only board */ @@ -49,6 +50,7 @@
>>> struct AspeedMachineState {
>>>        char *fmc_model;
>>>        char *spi_model;
>>>        uint32_t hw_strap1;
>>> +    uint32_t ioexp_num;
>>>    };
>>>
>>>    /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
>>> @@ -444,6 +446,9 @@ static void aspeed_machine_init(MachineState
>> *machine)
>>>                                 OBJECT(get_system_memory()),
>> &error_abort);
>>>        object_property_set_link(OBJECT(bmc->soc), "dram",
>>>                                 OBJECT(machine->ram),
>> &error_abort);
>>> +
>>> +    bmc->soc->ioexp_num = bmc->ioexp_num;
>>> +
>>>        if (amc->sdhci_wp_inverted) {
>>>            for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
>>>
>>> object_property_set_bool(OBJECT(&bmc->soc->sdhci.slots[i]),
>>> @@ -1486,6 +1491,49 @@ static void
>> aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
>>>                                              "Set or unset boot
>> from EMMC");
>>>    }
>>>
>>> +#ifdef TARGET_AARCH64
>>> +static void aspeed_get_ioexps_num(Object *obj,
>>> +                                  Visitor *v,
>>> +                                  const char *name,
>>> +                                  void *opaque,
>>> +                                  Error **errp) {
>>> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>>> +
>>> +    visit_type_uint32(v, name, &bmc->ioexp_num, errp); }
>>> +
>>> +static void aspeed_set_ioexps_num(Object *obj,
>>> +                                  Visitor *v,
>>> +                                  const char *name,
>>> +                                  void *opaque,
>>> +                                  Error **errp) {
>>> +    uint32_t val;
>>> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>>> +
>>> +    if (!visit_type_uint32(v, name, &val, errp)) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (val > ASPEED_IOEXP_NUM) {
>>> +        error_setg(errp, "IOEXP number is exceeded: %d", val);
>>> +        return;
>>> +    }
>>> +
>>> +    bmc->ioexp_num = val;
>>> +}
>>> +
>>> +
>>> +static void aspeed_machine_ast1700_class_init(ObjectClass *oc) {
>>> +    object_class_property_add(oc, "ioexps-num", "uint32",
>>> +                              aspeed_get_ioexps_num,
>>> +                              aspeed_set_ioexps_num,
>>> +                              NULL, NULL); } #endif
>>> +
>>>    static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
>>>    {
>>>        MachineClass *mc = MACHINE_CLASS(oc); @@ -2032,6 +2080,7
>> @@
>>> static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
>>>        mc->auto_create_sdcard = true;
>>>        mc->default_ram_size = 1 * GiB;
>>>        aspeed_machine_class_init_cpus_defaults(mc);
>>> +    aspeed_machine_ast1700_class_init(oc);
>>>    }
>>>    #endif
>>>
> 


