Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA55C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpPn-0003pb-WD; Tue, 27 May 2025 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kr5U=YL=kaod.org=clg@ozlabs.org>)
 id 1uJpPk-0003os-PO; Tue, 27 May 2025 04:12:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kr5U=YL=kaod.org=clg@ozlabs.org>)
 id 1uJpPh-0004EE-BJ; Tue, 27 May 2025 04:12:00 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4b65272n4mz4x1t;
 Tue, 27 May 2025 18:11:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4b65236ybmz4wcD;
 Tue, 27 May 2025 18:11:39 +1000 (AEST)
Message-ID: <05a02b39-a76a-4f1c-8562-cc93ff0c21c8@kaod.org>
Date: Tue, 27 May 2025 10:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC controller
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
 <20250512091014.3454083-3-kane_chen@aspeedtech.com>
 <67ced980-d6d8-4a2d-85ba-c918298ecf8b@kaod.org>
 <SI6PR06MB7631337C549FA649031173DFF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631337C549FA649031173DFF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kr5U=YL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/27/25 09:46, Kane Chen wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Tuesday, May 27, 2025 3:02 PM
>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP
>> memory device to SBC controller
>>
>> On 5/12/25 11:10, Kane Chen wrote:
>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>
>>> Integrate the aspeed.otpmem backend with the ASPEED Secure Boot
>>> Controller (SBC).
>>>
>>> This patch adds command handling support in the SBC to read and
>>> program the connected OTP memory using READ, WRITE, and PROG
>> commands.
>>> It enables basic interaction with OTP content for secure boot or fuse
>> modeling logic.
>>>
>>> Tracepoints are used to monitor command activity and unsupported paths.
>>>
>>> The following QOM hierarchy illustrates how OTP is connected:
>>>
>>>     /machine (ast1030-evb-machine)
>>>       /soc (ast1030-a1)
>>>         /sbc (aspeed.sbc-ast10X0)
>>>           /aspeed.sbc[0] (memory-region)
>>>           /otpmem (aspeed.otpmem)
>>>             /aspeed.otpmem.backend[0] (memory-region)
>>>
>>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>> ---
>>>    hw/misc/aspeed_sbc.c         | 179
>> +++++++++++++++++++++++++++++++++++
>>>    hw/misc/trace-events         |   5 +
>>>    include/hw/misc/aspeed_sbc.h |   5 +
>>>    3 files changed, 189 insertions(+)
>>>
>>> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c index
>>> a7d101ba71..237a8499d9 100644
>>> --- a/hw/misc/aspeed_sbc.c
>>> +++ b/hw/misc/aspeed_sbc.c
>>> @@ -15,9 +15,14 @@
>>>    #include "hw/misc/aspeed_sbc.h"
>>>    #include "qapi/error.h"
>>>    #include "migration/vmstate.h"
>>> +#include "trace.h"
>>>
>>>    #define R_PROT          (0x000 / 4)
>>> +#define R_CMD           (0x004 / 4)
>>> +#define R_ADDR          (0x010 / 4)
>>>    #define R_STATUS        (0x014 / 4)
>>> +#define R_CAMP1         (0x020 / 4)
>>> +#define R_CAMP2         (0x024 / 4)
>>>    #define R_QSR           (0x040 / 4)
>>>
>>>    /* R_STATUS */
>>> @@ -41,6 +46,19 @@
>>>    #define QSR_RSA_MASK           (0x3 << 12)
>>>    #define QSR_HASH_MASK          (0x3 << 10)
>>>
>>> +typedef enum {
>>> +    SBC_OTP_CMD_READ = 0x23b1e361,
>>> +    SBC_OTP_CMD_WRITE = 0x23b1e362,
>>> +    SBC_OTP_CMD_PROG = 0x23b1e364,
>>> +} SBC_OTP_Command;
>>> +
>>> +#define OTP_DATA_DWORD_COUNT        (0x800)
>>> +#define OTP_TOTAL_DWORD_COUNT       (0x1000)
>>> +
>>> +#define MODE_REGISTER               (0x1000)
>>> +#define MODE_REGISTER_A             (0x3000)
>>> +#define MODE_REGISTER_B             (0x5000)
>>> +
>>>    static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int
>> size)
>>>    {
>>>        AspeedSBCState *s = ASPEED_SBC(opaque); @@ -57,6 +75,143 @@
>>> static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int
>> size)
>>>        return s->regs[addr];
>>>    }
>>>
>>> +static bool aspeed_sbc_otpmem_read(AspeedSBCState *s,
>>> +                                   uint32_t otp_addr, Error **errp)
>> {
>>> +    uint32_t data = 0, otp_offset;
>>> +    bool is_data = false;
>>> +    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(s);
>>> +    const AspeedOTPMemOps *otp_ops;
>>> +
>>> +    if (sc->has_otpmem == false) {
>>> +        trace_aspeed_sbc_otpmem_state("disabled");
>>> +        return true;
>>> +    }
>>> +
>>> +    otp_ops = aspeed_otpmem_get_ops(&s->otpmem);
>>> +
>>> +    if (otp_addr < OTP_DATA_DWORD_COUNT) {
>>> +        is_data = true;
>>> +    } else if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
>>> +        error_setg(errp, "Invalid OTP addr 0x%x", otp_addr);
>>> +        return false;
>>> +    }
>>> +    otp_offset = otp_addr << 2;
>>> +
>>> +    data = otp_ops->read(&s->otpmem, otp_offset, errp);
>>
>>
>> why not call directly :
>>
>>       ret = address_space_read(&s->otpmem.as, addr,
>> MEMTXATTRS_UNSPECIFIED,
>>                                (uint8_t *)&val, sizeof(val));
>>       if (ret != MEMTX_OK) {
>>           error_setg(errp, "Failed to read data from 0x%x", addr);
>>           return OTPMEM_ERR_MAGIC;
>>       }
>>
>> The otp_ops business looks useless to me. Same for the write and prog
>> handlers.
> 
> The OTP memory has some regions that are protected from guest access,
> so I use a custom read function to handle that behavior.

Why not fail the transaction on the address_space then ?

> The write path
> also has some special handling (see aspeed_otpmem_prog in patch 1),
> which is why I'm using AspeedOTPMemOps for both. If you have concerns
> or comments about this implementation, please let me know.
If you want to keep routine program_otpmem_data at a low level,
under the AspeedOTPMem model, it could be implemented using the
drive backend directly instead of doing address_space transactions.
You could also move all the code from aspeed_otpmem_prog() code in
aspeed_sbc_otpmem_prog(). As you wish.

I don't see any reason to keep AspeedOTPMemOps.

Thanks,

C.


