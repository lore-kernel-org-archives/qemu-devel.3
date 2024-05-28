Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B2C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqSs-0007rR-Qa; Tue, 28 May 2024 02:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBqSr-0007rB-LK; Tue, 28 May 2024 02:37:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBqSp-00087V-0I; Tue, 28 May 2024 02:37:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VpN9T2g18z4x23;
 Tue, 28 May 2024 16:37:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpN9M3wgSz4wyj;
 Tue, 28 May 2024 16:37:26 +1000 (AEST)
Message-ID: <00e9e21a-a793-407c-8fef-0ed082959fdb@kaod.org>
Date: Tue, 28 May 2024 08:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/16] aspeed/smc: support 64 bits dma dram address
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
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-9-jamin_lin@aspeedtech.com>
 <4bc9c170-52ff-48a9-a3a1-4c9c0f2c7153@kaod.org>
 <SI2PR06MB50414DFFD5AEF3FC245AC4CEFCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB50414DFFD5AEF3FC245AC4CEFCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=HxTW=M7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/28/24 03:34, Jamin Lin wrote:
> Hi Cedric,
> 
>> On 5/27/24 10:02, Jamin Lin wrote:
>>> AST2700 support the maximum dram size is 8GiB and has a "DMA DRAM
>> Side
>>> Address High Part(0x7C)"
>>> register to support 64 bits dma dram address.
>>> Add helper routines functions to compute the dma dram address, new
>>> features and update trace-event to support 64 bits dram address.
>>>
>>> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>
>> I will move the addition of the "dram-base" property to another patch. See :
>>
>>     https://patchew.org/QEMU/20240527124315.35356-1-clg@redhat.com/
>>
>> (Please review)
> Review done.
> If I need to resend v5 patch series, I will remove "dram-base property" from this patch.

ok. Wait a bit before resending though. We are not done with v4 yet !

Thanks,

C.


> Thanks for your help, Jamin


>>
>> Else,
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> Thanks,
>>
>> C.
>>
>>
>>> ---
>>>    hw/ssi/aspeed_smc.c         | 52
>> +++++++++++++++++++++++++++++++------
>>>    hw/ssi/trace-events         |  2 +-
>>>    include/hw/ssi/aspeed_smc.h |  1 +
>>>    3 files changed, 46 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c index
>>> ffb13a12e8..df0c63469c 100644
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
>>> +static inline bool aspeed_smc_has_dma64(const AspeedSMCClass *asc) {
>>> +    return !!(asc->features &
>> ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
>>> +}
>>> +
>>>    #define aspeed_smc_error(fmt, ...)
>> \
>>>        qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ##
>>> __VA_ARGS__)
>>>
>>> @@ -747,6 +757,8 @@ static uint64_t aspeed_smc_read(void *opaque,
>> hwaddr addr, unsigned int size)
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_CTRL) ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_FLASH_ADDR)
>> ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_DRAM_ADDR)
>> ||
>>> +        (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc)
>> &&
>>> +         addr == R_DMA_DRAM_ADDR_HIGH) ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN) ||
>>>            (aspeed_smc_has_dma(asc) && addr == R_DMA_CHECKSUM)
>> ||
>>>            (addr >= R_SEG_ADDR0 &&
>>> @@ -847,6 +859,12 @@ static bool
>> aspeed_smc_inject_read_failure(AspeedSMCState *s)
>>>        }
>>>    }
>>>
>>> +static uint64_t aspeed_smc_dma_dram_addr(AspeedSMCState *s) {
>>> +    return s->regs[R_DMA_DRAM_ADDR] |
>>> +        ((uint64_t) s->regs[R_DMA_DRAM_ADDR_HIGH] << 32); }
>>> +
>>>    static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
>>>    {
>>>        AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s); @@ -903,24
>>> +921,34 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>>>
>>>    static void aspeed_smc_dma_rw(AspeedSMCState *s)
>>>    {
>>> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
>>> +    uint64_t dma_dram_offset;
>>> +    uint64_t dma_dram_addr;
>>>        MemTxResult result;
>>>        uint32_t dma_len;
>>>        uint32_t data;
>>>
>>>        dma_len = aspeed_smc_dma_len(s);
>>> +    dma_dram_addr = aspeed_smc_dma_dram_addr(s);
>>> +
>>> +    if (aspeed_smc_has_dma64(asc)) {
>>> +        dma_dram_offset = dma_dram_addr - s->dram_base;
>>> +    } else {
>>> +        dma_dram_offset = dma_dram_addr;
>>> +    }
>>>
>>>        trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] &
>> DMA_CTRL_WRITE ?
>>>                                "write" : "read",
>>>                                s->regs[R_DMA_FLASH_ADDR],
>>> -                            s->regs[R_DMA_DRAM_ADDR],
>>> +                            dma_dram_offset,
>>>                                dma_len);
>>>        while (dma_len) {
>>>            if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>>> -            data = address_space_ldl_le(&s->dram_as,
>> s->regs[R_DMA_DRAM_ADDR],
>>> +            data = address_space_ldl_le(&s->dram_as,
>> dma_dram_offset,
>>>
>> MEMTXATTRS_UNSPECIFIED, &result);
>>>                if (result != MEMTX_OK) {
>>> -                aspeed_smc_error("DRAM read failed @%08x",
>>> -                                 s->regs[R_DMA_DRAM_ADDR]);
>>> +                aspeed_smc_error("DRAM read failed @%" PRIx64,
>>> +                                 dma_dram_offset);
>>>                    return;
>>>                }
>>>
>>> @@ -940,11 +968,11 @@ static void aspeed_smc_dma_rw(AspeedSMCState
>> *s)
>>>                    return;
>>>                }
>>>
>>> -            address_space_stl_le(&s->dram_as,
>> s->regs[R_DMA_DRAM_ADDR],
>>> +            address_space_stl_le(&s->dram_as, dma_dram_offset,
>>>                                     data,
>> MEMTXATTRS_UNSPECIFIED, &result);
>>>                if (result != MEMTX_OK) {
>>> -                aspeed_smc_error("DRAM write failed @%08x",
>>> -                                 s->regs[R_DMA_DRAM_ADDR]);
>>> +                aspeed_smc_error("DRAM write failed @%" PRIx64,
>>> +                                 dma_dram_offset);
>>>                    return;
>>>                }
>>>            }
>>> @@ -953,8 +981,12 @@ static void aspeed_smc_dma_rw(AspeedSMCState
>> *s)
>>>             * When the DMA is on-going, the DMA registers are updated
>>>             * with the current working addresses and length.
>>>             */
>>> +        dma_dram_offset += 4;
>>> +        dma_dram_addr += 4;
>>> +
>>> +        s->regs[R_DMA_DRAM_ADDR_HIGH] = dma_dram_addr >> 32;
>>> +        s->regs[R_DMA_DRAM_ADDR] = dma_dram_addr & 0xffffffff;
>>>            s->regs[R_DMA_FLASH_ADDR] += 4;
>>> -        s->regs[R_DMA_DRAM_ADDR] += 4;
>>>            dma_len -= 4;
>>>            s->regs[R_DMA_LEN] = dma_len;
>>>            s->regs[R_DMA_CHECKSUM] += data; @@ -1107,6 +1139,9
>> @@
>>> static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>>>        } else if (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN &&
>>>                   aspeed_smc_dma_granted(s)) {
>>>            s->regs[addr] = DMA_LENGTH(value);
>>> +    } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc)
>> &&
>>> +               addr == R_DMA_DRAM_ADDR_HIGH) {
>>> +        s->regs[addr] = DMA_DRAM_ADDR_HIGH(value);
>>>        } else {
>>>            qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%"
>> HWADDR_PRIx "\n",
>>>                          __func__, addr); @@ -1239,6 +1274,7 @@
>> static
>>> const VMStateDescription vmstate_aspeed_smc = {
>>>
>>>    static Property aspeed_smc_properties[] = {
>>>        DEFINE_PROP_BOOL("inject-failure", AspeedSMCState,
>>> inject_failure, false),
>>> +    DEFINE_PROP_UINT64("dram-base", AspeedSMCState, dram_base, 0),
>>>        DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
>>>                         TYPE_MEMORY_REGION, MemoryRegion *),
>>>        DEFINE_PROP_END_OF_LIST(),
>>> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events index
>>> 2d5bd2b83d..7b5ad6a939 100644
>>> --- a/hw/ssi/trace-events
>>> +++ b/hw/ssi/trace-events
>>> @@ -6,7 +6,7 @@ aspeed_smc_do_snoop(int cs, int index, int dummies, int
>> data) "CS%d index:0x%x d
>>>    aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t
>> data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
>>>    aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%"
>> PRIx64 " size %u: 0x%" PRIx64
>>>    aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x:
>> 0x%08x"
>>> -aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint32_t
>> dram_addr, uint32_t size) "%s flash:@0x%08x dram:@0x%08x size:0x%08x"
>>> +aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint64_t
>> dram_addr, uint32_t size) "%s flash:@0x%08x dram:@0x%" PRIx64 "
>> size:0x%08x"
>>>    aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%"
>> PRIx64 " size %u: 0x%" PRIx64
>>>    aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
>>>
>>> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
>>> index f359ed22cc..fb36c386c0 100644
>>> --- a/include/hw/ssi/aspeed_smc.h
>>> +++ b/include/hw/ssi/aspeed_smc.h
>>> @@ -76,6 +76,7 @@ struct AspeedSMCState {
>>>        AddressSpace flash_as;
>>>        MemoryRegion *dram_mr;
>>>        AddressSpace dram_as;
>>> +    uint64_t dram_base;
>>>
>>>        AspeedSMCFlash flashes[ASPEED_SMC_CS_MAX];
>>>
> 


