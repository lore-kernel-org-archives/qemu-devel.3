Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1439C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjh6d-0002tu-AW; Mon, 11 Mar 2024 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0FuT=KR=kaod.org=clg@ozlabs.org>)
 id 1rjh6a-0002tJ-HD; Mon, 11 Mar 2024 10:58:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0FuT=KR=kaod.org=clg@ozlabs.org>)
 id 1rjh6X-0006sz-FX; Mon, 11 Mar 2024 10:58:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Ttfyz2NGJz4wyq;
 Tue, 12 Mar 2024 01:58:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ttfyv3zPBz4wcl;
 Tue, 12 Mar 2024 01:57:56 +1100 (AEDT)
Message-ID: <52e3caff-fc03-435c-9c08-eae172c121c1@kaod.org>
Date: Mon, 11 Mar 2024 15:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] aspeed/sdmc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-4-jamin_lin@aspeedtech.com>
 <2e975f92-26f4-4bdf-b195-996b69f705aa@kaod.org>
 <SI2PR06MB504121BEAFBFE40022D48C05FC242@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB504121BEAFBFE40022D48C05FC242@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=0FuT=KR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/11/24 08:21, Jamin Lin wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Monday, March 4, 2024 10:47 PM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Andrew Jeffery <andrew@codeconstruct.com.au>;
>> Joel Stanley <joel@jms.id.au>; Alistair Francis <alistair@alistair23.me>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>> <yunlin.tang@aspeedtech.com>
>> Subject: Re: [PATCH v2 3/9] aspeed/sdmc: Add AST2700 support
>>
> Hi Cedrice,
> 
> Thanks for review and sorry reply you late.
>   
>> On 3/4/24 10:29, Jamin Lin wrote:
>>> The SDRAM memory controller(DRAMC) controls the access to external
>>> DDR4 and DDR5 SDRAM and power up to DDR4 and DDR5 PHY.
>>>
>>> The DRAM memory controller of AST2700 is not backward compatible to
>>> previous chips such AST2600, AST2500 and AST2400.
>>>
>>> Max memory is now 8GiB on the AST2700. Introduce new
>> aspeed_2700_sdmc
>>> and class with read/write operation and reset handlers.
>>>
>>> Define DRAMC necessary protected registers and unprotected registers
>>> for AST2700 and increase the register set to 0x1000.
>>>
>>> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/misc/aspeed_sdmc.c         | 215
>> ++++++++++++++++++++++++++++++----
>>>    include/hw/misc/aspeed_sdmc.h |   4 +-
>>>    2 files changed, 198 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c index
>>> 64cd1a81dc..63fb7936c4 100644
>>> --- a/hw/misc/aspeed_sdmc.c
>>> +++ b/hw/misc/aspeed_sdmc.c
>>> @@ -27,6 +27,7 @@
>>>    #define   PROT_SOFTLOCKED    0x00
>>>
>>>    #define   PROT_KEY_UNLOCK     0xFC600309
>>> +#define   PROT_2700_KEY_UNLOCK  0x1688A8A8
>>>    #define   PROT_KEY_HARDLOCK   0xDEADDEAD /* AST2600 */
>>>
>>>    /* Configuration Register */
>>> @@ -54,6 +55,46 @@
>>>    #define R_DRAM_TIME       (0x8c / 4)
>>>    #define R_ECC_ERR_INJECT  (0xb4 / 4)
>>>
>>> +/* AST2700 Register */
>>> +#define R_2700_PROT                 (0x00 / 4)
>>> +#define R_INT_STATUS                (0x04 / 4)
>>> +#define R_INT_CLEAR                 (0x08 / 4)
>>> +#define R_INT_MASK                  (0x0c / 4)
>>> +#define R_MAIN_CONF                 (0x10 / 4)
>>> +#define R_MAIN_CONTROL              (0x14 / 4)
>>> +#define R_MAIN_STATUS               (0x18 / 4)
>>> +#define R_ERR_STATUS                (0x1c / 4)
>>> +#define R_ECC_FAIL_STATUS           (0x78 / 4)
>>> +#define R_ECC_FAIL_ADDR             (0x7c / 4)
>>> +#define R_ECC_TESTING_CONTROL       (0x80 / 4)
>>> +#define R_PROT_REGION_LOCK_STATUS   (0x94 / 4)
>>> +#define R_TEST_FAIL_ADDR            (0xd4 / 4)
>>> +#define R_TEST_FAIL_D0              (0xd8 / 4)
>>> +#define R_TEST_FAIL_D1              (0xdc / 4)
>>> +#define R_TEST_FAIL_D2              (0xe0 / 4)
>>> +#define R_TEST_FAIL_D3              (0xe4 / 4)
>>> +#define R_DBG_STATUS                (0xf4 / 4)
>>> +#define R_PHY_INTERFACE_STATUS      (0xf8 / 4)
>>> +#define R_GRAPHIC_MEM_BASE_ADDR     (0x10c / 4)
>>> +#define R_PORT0_INTERFACE_MONITOR0  (0x240 / 4) #define
>>> +R_PORT0_INTERFACE_MONITOR1  (0x244 / 4) #define
>>> +R_PORT0_INTERFACE_MONITOR2  (0x248 / 4) #define
>>> +R_PORT1_INTERFACE_MONITOR0  (0x2c0 / 4) #define
>>> +R_PORT1_INTERFACE_MONITOR1  (0x2c4 / 4) #define
>>> +R_PORT1_INTERFACE_MONITOR2  (0x2c8 / 4) #define
>>> +R_PORT2_INTERFACE_MONITOR0  (0x340 / 4) #define
>>> +R_PORT2_INTERFACE_MONITOR1  (0x344 / 4) #define
>>> +R_PORT2_INTERFACE_MONITOR2  (0x348 / 4) #define
>>> +R_PORT3_INTERFACE_MONITOR0  (0x3c0 / 4) #define
>>> +R_PORT3_INTERFACE_MONITOR1  (0x3c4 / 4) #define
>>> +R_PORT3_INTERFACE_MONITOR2  (0x3c8 / 4) #define
>>> +R_PORT4_INTERFACE_MONITOR0  (0x440 / 4) #define
>>> +R_PORT4_INTERFACE_MONITOR1  (0x444 / 4) #define
>>> +R_PORT4_INTERFACE_MONITOR2  (0x448 / 4) #define
>>> +R_PORT5_INTERFACE_MONITOR0  (0x4c0 / 4) #define
>>> +R_PORT5_INTERFACE_MONITOR1  (0x4c4 / 4) #define
>>> +R_PORT5_INTERFACE_MONITOR2  (0x4c8 / 4)
>>> +
>>>    /*
>>>     * Configuration register Ox4 (for Aspeed AST2400 SOC)
>>>     *
>>> @@ -76,10 +117,6 @@
>>>    #define     ASPEED_SDMC_VGA_32MB            0x2
>>>    #define     ASPEED_SDMC_VGA_64MB            0x3
>>>    #define ASPEED_SDMC_DRAM_SIZE(x)        (x & 0x3)
>>> -#define     ASPEED_SDMC_DRAM_64MB           0x0
>>> -#define     ASPEED_SDMC_DRAM_128MB          0x1
>>> -#define     ASPEED_SDMC_DRAM_256MB          0x2
>>> -#define     ASPEED_SDMC_DRAM_512MB          0x3
>>>
>>>    #define ASPEED_SDMC_READONLY_MASK                       \
>>>        (ASPEED_SDMC_RESERVED | ASPEED_SDMC_VGA_COMPAT |    \
>>> @@ -100,22 +137,24 @@
>>>    #define ASPEED_SDMC_CACHE_ENABLE        (1 << 10) /* differs
>> from AST2400 */
>>>    #define ASPEED_SDMC_DRAM_TYPE           (1 << 4)  /* differs
>> from AST2400 */
>>>
>>> -/* DRAM size definitions differs */
>>> -#define     ASPEED_SDMC_AST2500_128MB       0x0
>>> -#define     ASPEED_SDMC_AST2500_256MB       0x1
>>> -#define     ASPEED_SDMC_AST2500_512MB       0x2
>>> -#define     ASPEED_SDMC_AST2500_1024MB      0x3
>>> -
>>> -#define     ASPEED_SDMC_AST2600_256MB       0x0
>>> -#define     ASPEED_SDMC_AST2600_512MB       0x1
>>> -#define     ASPEED_SDMC_AST2600_1024MB      0x2
>>> -#define     ASPEED_SDMC_AST2600_2048MB      0x3
>>> -
>> Please move the removal above in a separate patch.
> Will fix
>>
>>>    #define ASPEED_SDMC_AST2500_READONLY_MASK
>> \
>>>        (ASPEED_SDMC_HW_VERSION(0xf) |
>> ASPEED_SDMC_CACHE_INITIAL_DONE |     \
>>>         ASPEED_SDMC_AST2500_RESERVED |
>> ASPEED_SDMC_VGA_COMPAT |            \
>>>         ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB))
>>>
>>> +/*
>>> + * Main Configuration register Ox10 (for Aspeed AST2700 SOC and
>>> +higher)
>>> + *
>>> + */
>>> +#define ASPEED_SDMC_AST2700_RESERVED        0xFFFF2082 /* 31:16,
>> 13, 7, 1 */
>>> +#define ASPEED_SDMC_AST2700_DATA_SCRAMBLE           (1 << 8)
>>> +#define ASPEED_SDMC_AST2700_ECC_ENABLE              (1 << 6)
>>> +#define ASPEED_SDMC_AST2700_PAGE_MATCHING_ENABLE    (1 << 5)
>>> +#define ASPEED_SDMC_AST2700_DRAM_SIZE(x)            ((x & 0x7)
>> << 2)
>>> +
>>> +#define ASPEED_SDMC_AST2700_READONLY_MASK   \
>>> +     (ASPEED_SDMC_AST2700_RESERVED)
>>> +
>>>    static uint64_t aspeed_sdmc_read(void *opaque, hwaddr addr, unsigned
>> size)
>>>    {
>>>        AspeedSDMCState *s = ASPEED_SDMC(opaque); @@ -231,7 +270,10
>> @@
>>> static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>>>        AspeedSDMCState *s = ASPEED_SDMC(dev);
>>>        AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>>>
>>> -    assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
>>> +    if (!asc->is_bus64bit) {
>>> +        assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
>>> +    }
>>
>> May be :
>>
>>      assert(asc->max_ram_size < 4 * GiB || asc->is_bus64bit);
>>
>> ?
> Will fix
>>
>>> +
>>>        s->max_ram_size = asc->max_ram_size;
>>>
>>>        memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops,
>> s,
>>> @@ -311,7 +353,8 @@ static void
>> aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>>>                                       uint32_t data)
>>>    {
>>>        if (reg == R_PROT) {
>>> -        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED :
>> PROT_SOFTLOCKED;
>>> +        s->regs[reg] =
>>> +            (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED :
>>> + PROT_SOFTLOCKED;
>>>            return;
>>>        }
>>>
>>> @@ -369,7 +412,8 @@ static void
>> aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>>>                                       uint32_t data)
>>>    {
>>>        if (reg == R_PROT) {
>>> -        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED :
>> PROT_SOFTLOCKED;
>>> +        s->regs[reg] =
>>> +            (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED :
>>> + PROT_SOFTLOCKED;
>>>            return;
>>>        }
>>>
>>> @@ -449,8 +493,9 @@ static void
>> aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>>>        }
>>>
>>>        if (s->regs[R_PROT] == PROT_HARDLOCKED) {
>>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked until
>> system reset!\n",
>>> -                __func__);
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: SDMC is locked until system reset!\n",
>>> +                      __func__);
>>>            return;
>>>        }
>>
>> The checkpatch changes could be in a separate patch. This is minor.
> Will fix
>>
>>>
>>> @@ -512,12 +557,142 @@ static const TypeInfo aspeed_2600_sdmc_info = {
>>>        .class_init = aspeed_2600_sdmc_class_init,
>>>    };
>>>
>>> +static void aspeed_2700_sdmc_reset(DeviceState *dev) {
>>> +    AspeedSDMCState *s = ASPEED_SDMC(dev);
>>> +    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>>> +
>>> +    memset(s->regs, 0, sizeof(s->regs));
>>> +
>>> +    /* Set ram size bit and defaults values */
>>> +    s->regs[R_MAIN_CONF] = asc->compute_conf(s, 0);
>>> +    s->regs[R_2700_PROT] = PROT_UNLOCKED;
>>
>> The default reset value is unlocked ?
>>
> The sdmc controller is unlocked at the SPL stage for AST2700.
> However, currently QEMU only support to emulate that AST2700 booting start at the u-boot stage.
> That was why I set the default value was unlocked, so firmware(u-boot)
> able to write the sdmc registers.
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2023.10/board/aspeed/ibex_ast2700/sdram_ast2700.c#L716
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2023.10/board/aspeed/ibex_ast2700/sdram_ast2700.c#L277

Since the model is diverging from HW, a comment explaining the reason
why would be useful.

As an extension preparing SPL support, you could add a new "unlocked"
property, set to "false" by default. The AST2700 SoC realize handler
would set it to "true" and the reset handler would test the value to
initialize the R_PROT register.

Thanks,

C.



> 
> Thanks-Jamin
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>> +}
>>> +
>>> +static uint32_t aspeed_2700_sdmc_compute_conf(AspeedSDMCState *s,
>>> +uint32_t data) {
>>> +    uint32_t fixed_conf =
>> ASPEED_SDMC_AST2700_PAGE_MATCHING_ENABLE |
>>> +
>> ASPEED_SDMC_AST2700_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
>>> +
>>> +    /* Make sure readonly bits are kept */
>>> +    data &= ~ASPEED_SDMC_AST2700_READONLY_MASK;
>>> +
>>> +    return data | fixed_conf;
>>> +}
>>> +
>>> +static void aspeed_2700_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>>> +                                   uint32_t data) {
>>> +    /* Unprotected registers */
>>> +    switch (reg) {
>>> +    case R_INT_STATUS:
>>> +    case R_INT_CLEAR:
>>> +    case R_INT_MASK:
>>> +    case R_MAIN_STATUS:
>>> +    case R_ERR_STATUS:
>>> +    case R_ECC_FAIL_STATUS:
>>> +    case R_ECC_FAIL_ADDR:
>>> +    case R_PROT_REGION_LOCK_STATUS:
>>> +    case R_TEST_FAIL_ADDR:
>>> +    case R_TEST_FAIL_D0:
>>> +    case R_TEST_FAIL_D1:
>>> +    case R_TEST_FAIL_D2:
>>> +    case R_TEST_FAIL_D3:
>>> +    case R_DBG_STATUS:
>>> +    case R_PHY_INTERFACE_STATUS:
>>> +    case R_GRAPHIC_MEM_BASE_ADDR:
>>> +    case R_PORT0_INTERFACE_MONITOR0:
>>> +    case R_PORT0_INTERFACE_MONITOR1:
>>> +    case R_PORT0_INTERFACE_MONITOR2:
>>> +    case R_PORT1_INTERFACE_MONITOR0:
>>> +    case R_PORT1_INTERFACE_MONITOR1:
>>> +    case R_PORT1_INTERFACE_MONITOR2:
>>> +    case R_PORT2_INTERFACE_MONITOR0:
>>> +    case R_PORT2_INTERFACE_MONITOR1:
>>> +    case R_PORT2_INTERFACE_MONITOR2:
>>> +    case R_PORT3_INTERFACE_MONITOR0:
>>> +    case R_PORT3_INTERFACE_MONITOR1:
>>> +    case R_PORT3_INTERFACE_MONITOR2:
>>> +    case R_PORT4_INTERFACE_MONITOR0:
>>> +    case R_PORT4_INTERFACE_MONITOR1:
>>> +    case R_PORT4_INTERFACE_MONITOR2:
>>> +    case R_PORT5_INTERFACE_MONITOR0:
>>> +    case R_PORT5_INTERFACE_MONITOR1:
>>> +    case R_PORT5_INTERFACE_MONITOR2:
>>> +        s->regs[reg] = data;
>>> +        return;
>>> +    }
>>> +
>>> +    if (s->regs[R_2700_PROT] == PROT_HARDLOCKED) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: SDMC is locked until system reset!\n",
>>> +                      __func__);
>>> +        return;
>>> +    }
>>> +
>>> +    if (reg != R_2700_PROT && s->regs[R_2700_PROT] ==
>> PROT_SOFTLOCKED) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: SDMC is locked! (write to MCR%02x
>> blocked)\n",
>>> +                      __func__, reg * 4);
>>> +        return;
>>> +    }
>>> +
>>> +    switch (reg) {
>>> +    case R_2700_PROT:
>>> +        if (data == PROT_2700_KEY_UNLOCK)  {
>>> +            data = PROT_UNLOCKED;
>>> +        } else if (data == PROT_KEY_HARDLOCK) {
>>> +            data = PROT_HARDLOCKED;
>>> +        } else {
>>> +            data = PROT_SOFTLOCKED;
>>> +        }
>>> +        break;
>>> +    case R_MAIN_CONF:
>>> +        data = aspeed_2700_sdmc_compute_conf(s, data);
>>> +        break;
>>> +    case R_MAIN_STATUS:
>>> +        /* Will never return 'busy'. */
>>> +        data &= ~PHY_BUSY_STATE;
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +
>>> +    s->regs[reg] = data;
>>> +}
>>> +
>>> +static const uint64_t
>>> +    aspeed_2700_ram_sizes[] = { 256 * MiB, 512 * MiB, 1024 * MiB,
>>> +                                2048 * MiB, 4096 * MiB, 8192 *
>> MiB,
>>> +0};
>>> +
>>> +static void aspeed_2700_sdmc_class_init(ObjectClass *klass, void
>>> +*data) {
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>>> +
>>> +    dc->desc = "ASPEED 2700 SDRAM Memory Controller";
>>> +    dc->reset = aspeed_2700_sdmc_reset;
>>> +
>>> +    asc->is_bus64bit = true;
>>> +    asc->max_ram_size = 8 * GiB;
>>> +    asc->compute_conf = aspeed_2700_sdmc_compute_conf;
>>> +    asc->write = aspeed_2700_sdmc_write;
>>> +    asc->valid_ram_sizes = aspeed_2700_ram_sizes; }
>>> +
>>> +static const TypeInfo aspeed_2700_sdmc_info = {
>>> +    .name = TYPE_ASPEED_2700_SDMC,
>>> +    .parent = TYPE_ASPEED_SDMC,
>>> +    .class_init = aspeed_2700_sdmc_class_init, };
>>> +
>>>    static void aspeed_sdmc_register_types(void)
>>>    {
>>>        type_register_static(&aspeed_sdmc_info);
>>>        type_register_static(&aspeed_2400_sdmc_info);
>>>        type_register_static(&aspeed_2500_sdmc_info);
>>>        type_register_static(&aspeed_2600_sdmc_info);
>>> +    type_register_static(&aspeed_2700_sdmc_info);
>>>    }
>>>
>>>    type_init(aspeed_sdmc_register_types);
>>> diff --git a/include/hw/misc/aspeed_sdmc.h
>>> b/include/hw/misc/aspeed_sdmc.h index ec2d59a14f..6df2f0a3b7 100644
>>> --- a/include/hw/misc/aspeed_sdmc.h
>>> +++ b/include/hw/misc/aspeed_sdmc.h
>>> @@ -17,6 +17,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState,
>> AspeedSDMCClass, ASPEED_SDMC)
>>>    #define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
>>>    #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
>>>    #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
>>> +#define TYPE_ASPEED_2700_SDMC TYPE_ASPEED_SDMC "-ast2700"
>>>
>>>    /*
>>>     * SDMC has 174 documented registers. In addition the u-boot device
>>> tree @@ -29,7 +30,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState,
>> AspeedSDMCClass, ASPEED_SDMC)
>>>     * time, and the other is in the DDR-PHY IP which is used during DDR-PHY
>>>     * training.
>>>     */
>>> -#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
>>> +#define ASPEED_SDMC_NR_REGS (0x1000 >> 2)
>>>
>>>    struct AspeedSDMCState {
>>>        /*< private >*/
>>> @@ -51,6 +52,7 @@ struct AspeedSDMCClass {
>>>        const uint64_t *valid_ram_sizes;
>>>        uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
>>>        void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
>>> +    bool is_bus64bit;
>>>    };
>>>
>>>    #endif /* ASPEED_SDMC_H */
> 


