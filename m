Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58ACC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hsq-0006rz-Ov; Tue, 30 Apr 2024 03:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cenw=MD=kaod.org=clg@ozlabs.org>)
 id 1s1hsV-0006ob-Rk; Tue, 30 Apr 2024 03:26:18 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cenw=MD=kaod.org=clg@ozlabs.org>)
 id 1s1hsT-00025S-I9; Tue, 30 Apr 2024 03:26:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VTBZV3yl6z4xMC;
 Tue, 30 Apr 2024 17:26:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTBZP5SHgz4x0K;
 Tue, 30 Apr 2024 17:26:05 +1000 (AEST)
Message-ID: <01232b1d-2646-46e0-bb4e-0162d2035889@kaod.org>
Date: Tue, 30 Apr 2024 09:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] aspeed/smc: support 64 bits dma dram address
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-9-jamin_lin@aspeedtech.com>
 <9b6d5078-121d-4370-86fc-4bb25ad4e72f@kaod.org>
 <SEYPR06MB50377414AEA2C2CAEF28A5E8FC0D2@SEYPR06MB5037.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SEYPR06MB50377414AEA2C2CAEF28A5E8FC0D2@SEYPR06MB5037.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=cenw=MD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/19/24 08:00, Jamin Lin wrote:
> Hi Cedric,
>>
>> Hello Jamin,
>>
>> On 4/16/24 11:18, Jamin Lin wrote:
>>> AST2700 support the maximum dram size is 8GiB and has a "DMA DRAM
>> Side
>>> Address High Part(0x7C)"
>>> register to support 64 bits dma dram address.
>>> Add helper routines functions to compute the dma dram address, new
>>> features and update trace-event to support 64 bits dram address.
>>>
>>> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/ssi/aspeed_smc.c | 66
>> +++++++++++++++++++++++++++++++++++++++------
>>>    hw/ssi/trace-events |  2 +-
>>>    2 files changed, 59 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c index
>>> 71abc7a2d8..a67cac3d0f 100644
>>> --- a/hw/ssi/aspeed_smc.c
>>> +++ b/hw/ssi/aspeed_smc.c
>>> @@ -132,6 +132,9 @@
>>>    #define   FMC_WDT2_CTRL_BOOT_SOURCE      BIT(4) /* O: primary
>> 1: alternate */
>>>    #define   FMC_WDT2_CTRL_EN               BIT(0)
>>>
>>> +/* DMA DRAM Side Address High Part (AST2700) */
>>> +#define R_DMA_DRAM_ADDR_HIGH   (0x7c / 4)
>>> +
>>>    /* DMA Control/Status Register */
>>>    #define R_DMA_CTRL        (0x80 / 4)
>>>    #define   DMA_CTRL_REQUEST      (1 << 31)
>>> @@ -187,6 +190,7 @@
>>>     *   0x1FFFFFF: 32M bytes
>>>     */
>>>    #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
>>> +#define DMA_DRAM_ADDR_HIGH(val)   ((val) & 0xf)
>>>    #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
>>>    #define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
>>>
>>> @@ -207,6 +211,7 @@ static const AspeedSegments
>> aspeed_2500_spi2_segments[];
>>>    #define ASPEED_SMC_FEATURE_DMA       0x1
>>>    #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2
>>>    #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4
>>> +#define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08
>>>
>>>    static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)
>>>    {
>>> @@ -218,6 +223,11 @@ static inline bool
>> aspeed_smc_has_wdt_control(const AspeedSMCClass *asc)
>>>        return !!(asc->features & ASPEED_SMC_FEATURE_WDT_CONTROL);
>>>    }
>>>
>>> +static inline bool aspeed_smc_has_dma_dram_addr_high(const
>>> +AspeedSMCClass *asc)
>>
>> To ease the reading, I would call the helper aspeed_smc_has_dma64()
> Will fix it
>>
>>> +{
>>> +    return !!(asc->features &
>> ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
>>> +}
>>> +
>>>    #define aspeed_smc_error(fmt, ...)
>> \
>>>        qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ##
>>> __VA_ARGS__)
>>>
>>> @@ -747,6 +757,9 @@ static uint64_t aspeed_smc_read(void *opaque,
>> hwaddr addr, unsigned int size)
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_CTRL) ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_FLASH_ADDR)
>> ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_DRAM_ADDR)
>> ||
>>> +        (aspeed_smc_has_dma(asc) &&
>>> +         aspeed_smc_has_dma_dram_addr_high(asc) &&
>>> +         addr == R_DMA_DRAM_ADDR_HIGH) ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN) ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_CHECKSUM)
>> ||
>>>            (addr >= R_SEG_ADDR0 &&
>>> @@ -847,6 +860,23 @@ static bool
>> aspeed_smc_inject_read_failure(AspeedSMCState *s)
>>>        }
>>>    }
>>>
>>> +static uint64_t aspeed_smc_dma_dram_addr(AspeedSMCState *s) {
>>> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
>>> +    uint64_t dram_addr_high;
>>> +    uint64_t dma_dram_addr;
>>> +
>>> +    if (aspeed_smc_has_dma_dram_addr_high(asc)) {
>>> +        dram_addr_high = s->regs[R_DMA_DRAM_ADDR_HIGH];
>>> +        dram_addr_high <<= 32;
>>> +        dma_dram_addr = dram_addr_high |
>> s->regs[R_DMA_DRAM_ADDR];
>>
>> Here is a proposal to shorten the routine :
>>
>>           return ((uint64_t) s->regs[R_DMA_DRAM_ADDR_HIGH] << 32) |
>>               s->regs[R_DMA_DRAM_ADDR];
>>
>>
>>> +    } else {
>>> +        dma_dram_addr = s->regs[R_DMA_DRAM_ADDR];
>>
>> and
>>           return s->regs[R_DMA_DRAM_ADDR];
>>
>>> +    }
>>> +
>>> +    return dma_dram_addr;
>>> +}
>>> +
> Thanks for your suggestion. Will fix.
>>>    static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
>>>    {
>>>        AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s); @@ -914,24
>>> +944,34 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>>>
>>>    static void aspeed_smc_dma_rw(AspeedSMCState *s)
>>>    {
>>> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
>>> +    uint64_t dram_addr_high;
>>
>> This variable doesn't look very useful
> Will try to remove it.
>>
>>> +    uint64_t dma_dram_addr;
>>> +    uint64_t dram_addr;
>>
>> and dram_addr is redundant with dma_dram_addr. Please use only one.
> Please see my below description and please give us any suggestion.
>>
>>
>>>        MemTxResult result;
>>>        uint32_t dma_len;
>>>        uint32_t data;
>>>
>>>        dma_len = aspeed_smc_dma_len(s);
>>> +    dma_dram_addr = aspeed_smc_dma_dram_addr(s);
>>> +
>>> +    if (aspeed_smc_has_dma_dram_addr_high(asc)) {
>>> +        dram_addr = dma_dram_addr - s->dram_mr->container->addr;
>>
>> Why do you truncate the address again ? It should already be done with
>>
>> #define DMA_DRAM_ADDR_HIGH(val)   ((val) & 0xf)
>>
> The reason is that our firmware set the real address in SMC registers.
> For example: If users want to move data from flash to the DRAM at address 0,
> It set R_DMA_DRAM_ADDR_HIGH 4 and R_DMA_DRAM_ADDR 0 because the
> dram base address is 0x 4 00000000 for AST2700.


Could you please share the specs of the R_DMA_DRAM_ADDR and
R_DMA_DRAM_ADDR_HIGH registers to see what are the init values,
how these registers should be set, their alignment constraints
if any, how the values evolve while the HW does the DMA transactions,
etc.

Thanks,

C.




