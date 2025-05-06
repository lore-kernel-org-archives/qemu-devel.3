Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13081C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEBC-0001GS-Ib; Tue, 06 May 2025 05:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fu8x=XW=kaod.org=clg@ozlabs.org>)
 id 1uCEB9-0001Fn-MM; Tue, 06 May 2025 05:01:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fu8x=XW=kaod.org=clg@ozlabs.org>)
 id 1uCEB7-0000Gx-6y; Tue, 06 May 2025 05:01:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZsC7B3bwtz4x8f;
 Tue,  6 May 2025 19:01:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZsC764j8Vz4wbV;
 Tue,  6 May 2025 19:01:22 +1000 (AEST)
Message-ID: <2043a4a4-a700-4562-8a46-846fb5a8e8b3@kaod.org>
Date: Tue, 6 May 2025 11:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/22] hw/misc/aspeed_hace: Remove unused code for
 better readability
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
 <20250321092623.2097234-2-jamin_lin@aspeedtech.com>
 <1c4176c4-6077-4260-b96d-69ab5b920afb@kaod.org>
 <SI2PR06MB5041C4C35CD83984D7A7FC5DFC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB5041C4C35CD83984D7A7FC5DFC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fu8x=XW=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/5/25 05:28, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v1 01/22] hw/misc/aspeed_hace: Remove unused code for
>> better readability
>>
>> On 3/21/25 10:25, Jamin Lin wrote:
>>> This cleanup follows significant changes in commit 4c1d0af4a28d,
>>> making the model more readable.
>>>
>>> - Deleted "iov_cache" and "iov_count" from "AspeedHACEState".
>>
>> It would be good to say why we can remove these. I think this is because
>> s->iov_count is always zero, right ?
>>
>>> - Removed "reconstruct_iov" function and related logic.
>>> - Simplified "do_hash_operation" by eliminating redundant checks.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    include/hw/misc/aspeed_hace.h |  2 --
>>>    hw/misc/aspeed_hace.c         | 35 -----------------------------------
>>>    2 files changed, 37 deletions(-)
>>>
>>> diff --git a/include/hw/misc/aspeed_hace.h
>>> b/include/hw/misc/aspeed_hace.h index 5d4aa19cfe..b69a038d35 100644
>>> --- a/include/hw/misc/aspeed_hace.h
>>> +++ b/include/hw/misc/aspeed_hace.h
>>> @@ -31,10 +31,8 @@ struct AspeedHACEState {
>>>        MemoryRegion iomem;
>>>        qemu_irq irq;
>>>
>>> -    struct iovec iov_cache[ASPEED_HACE_MAX_SG];
>>>        uint32_t regs[ASPEED_HACE_NR_REGS];
>>>        uint32_t total_req_len;
>>> -    uint32_t iov_count;
>>>
>>>        MemoryRegion *dram_mr;
>>>        AddressSpace dram_as;
>>> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
>>> 32a5dbded3..8e7e8113a5 100644
>>> --- a/hw/misc/aspeed_hace.c
>>> +++ b/hw/misc/aspeed_hace.c
>>> @@ -137,25 +137,6 @@ static bool has_padding(AspeedHACEState *s,
>> struct iovec *iov,
>>>        return false;
>>>    }
>>>
>>> -static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
>>> -                           uint32_t *pad_offset)
>>> -{
>>> -    int i, iov_count;
>>> -    if (*pad_offset != 0) {
>>> -        s->iov_cache[s->iov_count].iov_base = iov[id].iov_base;
>>> -        s->iov_cache[s->iov_count].iov_len = *pad_offset;
>>> -        ++s->iov_count;
>>> -    }
>>> -    for (i = 0; i < s->iov_count; i++) {
>>> -        iov[i].iov_base = s->iov_cache[i].iov_base;
>>> -        iov[i].iov_len = s->iov_cache[i].iov_len;
>>> -    }
>>> -    iov_count = s->iov_count;
>>> -    s->iov_count = 0;
>>> -    s->total_req_len = 0;
>>> -    return iov_count;
>>> -}
>>> -
>>>    static void do_hash_operation(AspeedHACEState *s, int algo, bool
>> sg_mode,
>>>                                  bool acc_mode)
>>>    {
>>> @@ -237,19 +218,6 @@ static void do_hash_operation(AspeedHACEState *s,
>> int algo, bool sg_mode,
>>>            iov[0].iov_base = haddr;
>>>            iov[0].iov_len = len;
>>>            i = 1;
>>> -
>>> -        if (s->iov_count) {
>>> -            /*
>>> -             * In aspeed sdk kernel driver, sg_mode is disabled in
>> hash_final().
>>> -             * Thus if we received a request with sg_mode disabled, it is
>>> -             * required to check whether cache is empty. If no, we should
>>> -             * combine cached iov and the current iov.
>>> -             */
>>> -            s->total_req_len += len;
>>> -            if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
>>> -                i = reconstruct_iov(s, iov, 0, &pad_offset);
>>> -            }
>>> -        }
>>>        }
>>>
>>>        if (acc_mode) {
>>> @@ -273,7 +241,6 @@ static void do_hash_operation(AspeedHACEState *s,
>> int algo, bool sg_mode,
>>>                qcrypto_hash_free(s->hash_ctx);
>>>
>>>                s->hash_ctx = NULL;
>>> -            s->iov_count = 0;
>>>                s->total_req_len = 0;
>>>            }
>>>        } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, @@
>>> -432,7 +399,6 @@ static void aspeed_hace_reset(DeviceState *dev)
>>>        }
>>>
>>>        memset(s->regs, 0, sizeof(s->regs));
>>> -    s->iov_count = 0;
>>>        s->total_req_len = 0;
>>>    }
>>>
>>> @@ -469,7 +435,6 @@ static const VMStateDescription
>> vmstate_aspeed_hace = {
>>>        .fields = (const VMStateField[]) {
>>>            VMSTATE_UINT32_ARRAY(regs, AspeedHACEState,
>> ASPEED_HACE_NR_REGS),
>>>            VMSTATE_UINT32(total_req_len, AspeedHACEState),
>>> -        VMSTATE_UINT32(iov_count, AspeedHACEState),
>>
>> This is a vmstate change which is breaking migration compatibility.
>> We could preserve compatibility [1] but I think this is overkill.
>> However, we should say so. Please add a comment in the commit log.
>>
> 
> How about the following commit log:
> 
> ```
> hw/misc/aspeed_hace: Remove unused code for better readability
> 
> In the previous design of the hash framework, accumulative hashing was not
> supported. To work around this limitation, commit 5cd7d85 introduced an
> iov_cache array to store all the hash data from firmware.
> Once the ASPEED HACE model collected all the data, it passed the iov_cache to
> the hash API to calculate the final digest.
> 
> However, with commit e3c0752, the hash framework now supports accumulative
> hashing. This allows us to refactor the ASPEED HACE model, removing redundant
> logic and simplifying the implementation for better readability and
> maintainability.
> 
> As a result, the iov_count variable is no longer needed—it was previously used
> to track how many cached entries were used for hashing.
> To maintain VMSTATE compatibility after removing this field, the VMSTATE_VERSION
> is bumped to 2
> 
> This cleanup follows significant changes in commit 4c1d0af4a28d, making the
> model more readable.
> 
> - Deleted "iov_cache" and "iov_count" from "AspeedHACEState".
> - Removed "reconstruct_iov" function and related logic.
> - Simplified "do_hash_operation" by eliminating redundant checks.
> ```


OK Let's see in v2.


Thanks,

C.


> Thans-Jamin
> 
>> Thanks,
>>
>> C.
>>
>> [1]
>> https://qemu.readthedocs.io/en/v9.2.0/devel/migration/main.html#vmstate
>>
>>>            VMSTATE_END_OF_LIST(),
>>>        }
>>>    };
> 


