Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5111BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDdUp-0000dc-7p; Sat, 10 May 2025 02:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HX7T=X2=kaod.org=clg@ozlabs.org>)
 id 1uDdUm-0000aJ-14; Sat, 10 May 2025 02:15:36 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HX7T=X2=kaod.org=clg@ozlabs.org>)
 id 1uDdUj-0007dO-La; Sat, 10 May 2025 02:15:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZvbFs032Pz4xS7;
 Sat, 10 May 2025 16:15:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZvbFm6Qszz4x0L;
 Sat, 10 May 2025 16:15:24 +1000 (AEST)
Message-ID: <ba12c8bd-2d9e-46f1-a89e-fa3692e1098a@kaod.org>
Date: Sat, 10 May 2025 08:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-9-jamin_lin@aspeedtech.com>
 <ff5e84c5-4714-4897-90b6-40df76746443@kaod.org>
 <SI2PR06MB504194D74CCFCBB9403B7214FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB504194D74CCFCBB9403B7214FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=HX7T=X2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/9/25 09:04, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits
>> dram address.
>>
>> On 3/21/25 10:26, Jamin Lin wrote:
>>> According to the AST2700 design, the data source address is 64-bit,
>>> with R_HASH_SRC_HI storing bits [63:32] and R_HASH_SRC storing bits
>> [31:0].
>>>
>>> Similarly, the digest address is 64-bit, with R_HASH_DEST_HI storing
>>> bits [63:32] and R_HASH_DEST storing bits [31:0].
>>>
>>> Ideally, sg_addr should be 64-bit for the AST2700, using the following
>>> program to obtain the 64-bit sg_addr and convert it to a DRAM offset:
>>>
>>> ```
>>> sg_addr = deposit64(sg_addr, 32, 32,
>>>                       address_space_ldl_le(&s->dram_as, src +
>> SG_LIST_ADDR_SIZE,
>>>
>> MEMTXATTRS_UNSPECIFIED,
>>> NULL); sg_addr -= 0x400000000; ```
>>
>> I don't think the code extract above is useful.
>>
>>> To maintain compatibility with older SoCs such as the AST2600, the
>>> AST2700 HW HACE controllers automatically set bit 34 of the 64-bit sg_addr.
>>
>> I suppose that's what bits [30:28] of the first word of the scatter-gather entry
>> are for ?
>>
>>> As a result,
>>> the firmware only needs to provide a 32-bit sg_addr containing bits [31:0].
>>> This is sufficient for the AST2700, as it uses a DRAM offset rather
>>> than a DRAM address.
>>
>> yes the HACE model can use a relative address because the DRAM memory
>> region is directly available. There is no need to construct a physical address.
>>
>>> Introduce a has_dma64 class attribute and set it to true for the AST2700.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    include/hw/misc/aspeed_hace.h |  1 +
>>>    hw/misc/aspeed_hace.c         | 27 ++++++++++++++++++++++++++-
>>>    2 files changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/misc/aspeed_hace.h
>>> b/include/hw/misc/aspeed_hace.h index a4479bd383..58fb66009a 100644
>>> --- a/include/hw/misc/aspeed_hace.h
>>> +++ b/include/hw/misc/aspeed_hace.h
>>> @@ -52,6 +52,7 @@ struct AspeedHACEClass {
>>>        uint32_t src_hi_mask;
>>>        uint32_t dest_hi_mask;
>>>        uint32_t key_hi_mask;
>>> +    bool has_dma64;
>>>    };
>>>
>>>    #endif /* ASPEED_HACE_H */
>>> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
>>> 51c6523fab..8f333fc97e 100644
>>> --- a/hw/misc/aspeed_hace.c
>>> +++ b/hw/misc/aspeed_hace.c
>>> @@ -148,6 +148,7 @@ static bool has_padding(AspeedHACEState *s, struct
>> iovec *iov,
>>>    static void do_hash_operation(AspeedHACEState *s, int algo, bool
>> sg_mode,
>>>                                  bool acc_mode)
>>>    {
>>> +    AspeedHACEClass *ahc = ASPEED_HACE_GET_CLASS(s);
>>>        bool sg_acc_mode_final_request = false;
>>>        g_autofree uint8_t *digest_buf = NULL;
>>>        struct iovec iov[ASPEED_HACE_MAX_SG]; @@ -182,6 +183,9 @@
>> static
>>> void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>>>                }
>>>
>>>                src = deposit64(src, 0, 32, s->regs[R_HASH_SRC]);
>>> +            if (ahc->has_dma64) {
>>> +                src = deposit64(src, 32, 32, s->regs[R_HASH_SRC_HI]);
>>> +            }
>>
>> That's where a little helper would be nice to have.
>>
> I add hash_get_source_addr help function.
> Please see patch 6 comments.
> 
>>>                src += i * SG_LIST_ENTRY_SIZE;
>>>
>>>                len = address_space_ldl_le(&s->dram_as, src, @@ -190,6
>>> +194,21 @@ static void do_hash_operation(AspeedHACEState *s, int algo,
>> bool sg_mode,
>>>                sg_addr = address_space_ldl_le(&s->dram_as, src +
>> SG_LIST_LEN_SIZE,
>>>
>> MEMTXATTRS_UNSPECIFIED, NULL);
>>>                sg_addr &= SG_LIST_ADDR_MASK;
>>> +            /*
>>> +             * Ideally, sg_addr should be 64-bit for the AST2700, using
>> the
>>> +             * following program to obtain the 64-bit sg_addr and
>> convert it
>>> +             * to a DRAM offset:
>>> +             * sg_addr = deposit64(sg_addr, 32, 32,
>>> +             *      address_space_ldl_le(&s->dram_as, src +
>> SG_ADDR_LEN_SIZE,
>>> +             *
>> MEMTXATTRS_UNSPECIFIED, NULL);
>>> +             * sg_addr -= 0x400000000;
>>> +             *
>>
>> I don't think the above comment is useful. Please keep the one below.
>>
>>> +             * To maintain compatibility with older SoCs such as the
>> AST2600,
>>> +             * the AST2700 HW automatically set bit 34 of the 64-bit
>> sg_addr.
>>> +             * As a result, the firmware only needs to provide a 32-bit
>> sg_addr
>>> +             * containing bits [31:0]. This is sufficient for the AST2700,
>> as
>>> +             * it uses a DRAM offset rather than a DRAM address.
>>> +             */
>>
> 
> Thanks for suggestion will update them.
> 
>> The SG_LIST_ADDR_MASK needs an update though. AFAICT, it's bigger on
>> AST2700.
> 
> The value of SG_LIST_ADDR_MASK was wrong for AST2700, AST2600 and AST1030.
> The correct value should be 0x7FFFFFF8.
> Will create a new patch to fix it.
> Please see patch 4 comments.
> By the way, AST2500 do not support SG mode.

Should we introduce a class attribute then ?

Thanks,

C.

