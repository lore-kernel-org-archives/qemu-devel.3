Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44FEF43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg6o-0004UA-V4; Fri, 17 Apr 2026 06:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDg6l-0004Tf-Ed
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:07:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDg6i-0007i3-Pq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:07:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso308296f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776420447; x=1777025247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w00wy+8DffmkCYua+mrtVHSKyagTUvEZRc8Z1p2G8JE=;
 b=LA3sGAnaJzwN+qXD5aTgPNI4vhOINmEBCVcNXqbBkyr4S5Lr1Xbo32HvXFCrk10NVp
 FTA2BVCrdPuKEhI/xuv3fKzM7pYeMeJBuyAQbSrwUnMyNWOz4Gv+CQ7UazbPvjh+/0I1
 +q/9Q8rcTXEolszSN+0NlvGNHQmaYamjVnyOmws0kExb/D6aDbkeCS0OvXFWSGJYCA6P
 9mxgwTHL6Q2AeZHCrZjwmE535KKYDx7Zv7rbkNb/3wVk0k/Z9q6kPjrN2CMWcUBZWBT5
 P6rmDYHyam+A6sw6VAYUX8/DUCWps0R+KH/yxruywp5jyCMW/c/vrYMwgqdApvoweeXq
 efNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776420447; x=1777025247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w00wy+8DffmkCYua+mrtVHSKyagTUvEZRc8Z1p2G8JE=;
 b=qcBCdAXH+zlxXGaa+LR22yoMqwDnEVe3INvIaBZnm9Zw+sNsMFhr+VRyTxFJf+fPK4
 Jmd5MdDYGjjuYg7hq16aPN/pEQcjVDB8Wl8QIAE+Yg2/JMEoNScuxrCCb9lgHed4jcfK
 jQdk9ltF9EWyhTTRr6WuLuwKrV7rXiPzaADT3+dQAWJY7BYJzBF48W3GmiEz92JLL1y0
 Zc4BZSsPjFTljpPVkM3LaShR2cXtI9lvkSG2taPO0LbUSuD8U1C9HQT8UMzUHaXzhsGQ
 5hpp4tc4KRpT/9fwkavxqu8CTn5m/rY3gvJTyZ8pZD9rVxcVQKavY6YFYMoj6HdHFNDr
 PP7A==
X-Gm-Message-State: AOJu0Yxkp+ApEzDqkPHxw5z+MHO+Ua1GDDQagr3t4gZknMRJY8ipMQxI
 vLwtqOhvGN77fRuWm/7EVh9sZ7bJw84WcY2A8Aww107et+7rJHzJKW4LLZ6leeSsrUA7yxj+hiO
 CIr99O9w=
X-Gm-Gg: AeBDievrrg7FhAneoDawzskKt95rFYikPB9V5ahBQF9rFYF/72OLDbWM8Lz1vlo27FN
 oZ/usbd8JQ3IJcnyHPnkMQ73za0Dod6SJnnZPjM0pYfh32r9AEydOe3u41ROl2kDyiKFHVtcLTh
 GpzX3tWuwe6F8IZ9nFCSFkubA8Y2u/NQyzLE+KnCdxCbI39ce7l0UAmZxXWWXTGwBmT7FspGJ8t
 DCP2NZs2EgDiHf9TfgGroBr5GUNEgtVy/J9gOhIWM1imGCPHxp5JwkRNWUq0BMTHnCviyUV+2C0
 p2i5mXoWDIg2jWlP7uE8nFDkF+kvOdr8BHbVIkP39ybx+xLVbiy14oQaV9/dq16Ky7BmIE4vox4
 QmeMF54SEPDcXtu4GlgnTWFjR+EXebwm30bSZDJnBPlTYoU218T2NcXiKbN1znIeDz2w/fqpSC2
 RgBkwkFLbAjx04jsAdWCSBMzu0dE6Blvgh+GYDrfGTBEdrw7Z4PlJZtZDhwa9f5pNqunW38+uPZ
 FQA
X-Received: by 2002:a05:6000:2888:b0:43d:67d1:2022 with SMTP id
 ffacd0b85a97d-43fe3dcb8cemr3222348f8f.19.1776420446976; 
 Fri, 17 Apr 2026 03:07:26 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm3455336f8f.37.2026.04.17.03.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 03:07:26 -0700 (PDT)
Message-ID: <5a737cad-3b66-462c-975b-24937fd92075@linaro.org>
Date: Fri, 17 Apr 2026 12:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
 <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
 <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
 <55bf85d3-3b62-4dab-9b21-ec1ca193dd15@linaro.org>
 <CAKmqyKN=pn997tWzN+-7rFT5ksN6hq7ae3nLW2yDczcCqCWhnw@mail.gmail.com>
 <ed6e6e5c-3cb9-4cf1-a773-e3cbe77a4552@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ed6e6e5c-3cb9-4cf1-a773-e3cbe77a4552@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/4/26 11:54, Djordje Todorovic wrote:
> 
> On 4/9/26 07:16, Alistair Francis wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> On Thu, Apr 9, 2026 at 3:04 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>> On 9/4/26 06:00, Alistair Francis wrote:
>>>> On Wed, Apr 8, 2026 at 12:17 AM Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>> On 6/4/26 17:49, Djordje Todorovic wrote:
>>>>>> Add a "big-endian" boolean property to the RISC-V CPU configuration,
>>>>>> defaulting to false (little-endian). This property allows machine
>>>>>> models to configure individual HARTs for big-endian data operation.
>>>>>>
>>>>>> The RISC-V ISA supports big-endian data accesses via the mstatus
>>>>>> SBE/MBE/UBE bits, while instructions remain always little-endian.
>>>>>> This property provides the configuration interface; subsequent
>>>>>> patches will connect it to the CPU state and translation logic.
>>>>>>
>>>>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>>>>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>>>>>> ---
>>>>>>      target/riscv/cpu.c                | 1 +
>>>>>>      target/riscv/cpu_cfg_fields.h.inc | 1 +
>>>>>>      2 files changed, 2 insertions(+)
>>>>>
>>>>>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>>>>>> index 70ec650abf..51436daabf 100644
>>>>>> --- a/target/riscv/cpu_cfg_fields.h.inc
>>>>>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>>>>>> @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
>>>>>>      BOOL_FIELD(ext_xmipscmov)
>>>>>>      BOOL_FIELD(ext_xmipslsp)
>>>>>>
>>>>>> +BOOL_FIELD(big_endian)
>>>>> Since it is runtime it doesn't belong to RISCVCPUConfig.
>>>> I think the idea is that a user can set the `big-endian` property
>>>> (from the command line or machine) and then MBE, SBE and UBE are
>>>> always 1 and big endian is always enabled. Basically to model
>>>> big-endian only hardware
>>>>
>>>> So in that context it isn't runtime, but it's not clear from the
>>>> commit description. Also if we are adding a property the property
>>>> should be exposed last, as in once all of the functionality is
>>>> supported. That way we don't have a property that doesn't do anything.
>>>> We would also need documentation added.
>>> Reading "3.1.6.3 Memory Privilege in mstatus Register" it is not
>>> clear to me whether MBE and SBE are hard-wired, I'd have expected
>> They don't have to be hard-wired. There is a note in section 3.1.6.5 that says:
>>
>> """
>> An implementation supports only little-endian memory accesses if
>> fields MBE, SBE, and UBE
>> are all read-only 0. An implementation supports only big-endian memory
>> accesses (aside from
>> instruction fetches) if MBE is read-only 1 and SBE and UBE are each
>> read-only 1 when S-mode
>> and U-mode are supported.
>> """
>>
>>> a HART to be able to reset itself in a different endianness, and
>>> in that case the current riscv_cpu_reset_hold() would overwrite that.
>> I suspect a lot of big-endian harts are just always big-endian.
>> Swapping at runtime seems tricky, although something we can support.
>>
>> This should all be made clear in the commit message and some documentation
>>
>> Alistair
> 
> Thanks Philippe, Alistair.
> 
> To clarify: big_endian is not a runtime flag — it models big-endian-only
> hardware as described in the privileged spec section 3.1.6.5, where
> MBE/SBE/UBE
> are hardwired to 1. It belongs in RISCVCPUConfig because it's a static,
> per-CPU hardware property (same category as mmu or pmp), not something
> the guest toggles at runtime.
> 
> The MBE/SBE/UBE bits are already effectively hardwired in the existing
> codebase: none of the write_mstatus/write_mstatush/write_sstatus CSR paths
> include them in their writable mask, so whatever value is set at reset
> persists for the lifetime of the CPU.

What do you refer to by "existing codebase"?

Section 3.1.6.5 note:

   [...] endianness control has been defined so as to permit, for
   instance, an OS of one endianness to execute user-mode programs
   of the opposite endianness. Consideration has been given also to
   the possibility of non-standard usages whereby software flips the
   endianness of memory accesses as needed.

Which I interprete as "runtime swap". I'm not seeing explicit mention of
hard-wired bits.

