Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9361C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 09:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ1OP-0003PD-9k; Sat, 06 Jul 2024 05:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1ON-0003Ot-Ce
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:07:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1OK-0007Ka-Aq
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:07:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70b1808dee9so419701b3a.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720256854; x=1720861654;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dEkc0pv50CiLbU5jMp8sMcrtkgSo3LWQIB9Nh1ylJcw=;
 b=STOm2VXTB1OAusjBreS3jvWas7oF2J3EqbHnX+dKusD0qjP7yvBFnLwlo82GUwp2Kg
 39lPLt3CQ5SgQDVFDI9dv87zM8ZdJJY59P0oqa0h5/MFfdzJ7TLD8epFd3qXPnitHZL8
 x8MuifDK+4xvQaKnAoJDsTR4KvRTgednMYFENhpmewbJ1u5bURD5fmTRPC3OKBp8DswR
 Cn5W7XFRXRllVwHfey/QlpLqpUzJirSkMFhxEEiladob2i3mGebR2Vp7E1qD/CBCgdR6
 5/xoVOli2iVKttwdM9yMpDqNkR8TeJoJFcLgsZG3JgpdK0QE9ADmaNwq3yA2dMJAw/q6
 eMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720256854; x=1720861654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dEkc0pv50CiLbU5jMp8sMcrtkgSo3LWQIB9Nh1ylJcw=;
 b=wfFveAdTEtY1fPwJ9mlWCZ8yUYge+N1Pg3+QbskXhHY9HaJF2sOprpNlyQNJJmHp8U
 L7F23g22iMl0B9nxitBIdhTrK0YTKjjJ9C7T9hbKq7qZDitFLl25UR+FuP0hXeDbURfa
 C1qzLm1td/0xYxouJ41peTN4bu4YBiJTcyu+3tbTzSOXcJ3fDJUbe2vczbJrb7ajx2l1
 HW0lAcMYC81LQsNck4jHiSsbIRRbi83mGK+CnIj1Il/V/SccRXTnL73p9bJVTauU57ql
 AEg2Tb65P2xJE5feimVuTJWcxG/l7j1Zz7C308QVznqqEuc+YMaw5JV03wtwkqrpyU7S
 DFUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW75AYqUIF2ZHiROuVoxWuhrJf3A/60aAIoKKiGENqBkvQz6HAtB0Fjc82zQBPSqHnlRPZcnEeDTKh3wwPMeLenLSAhuB4=
X-Gm-Message-State: AOJu0Yyfd+TdrSVNbfyAyT5sECm/oEaoukxGM6r7Lu9Eg63Op9/+h1x3
 ++XwgAxTaiAvTLWP2ggobi94LH/mJvByFpFHZmpY2roxzJeUNCwjjqrJ7nY2xBA=
X-Google-Smtp-Source: AGHT+IHM2r2udVbofZQuJf9RPZ2MZjuCcbCLqBy9IKJZinf+r/wstDFJPT82VT0hQ4ASCOTvzdTzvQ==
X-Received: by 2002:a05:6a00:3929:b0:70a:ff06:2728 with SMTP id
 d2e1a72fcca58-70b00b77ed6mr6576203b3a.29.1720256854244; 
 Sat, 06 Jul 2024 02:07:34 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b0c6a85d3sm2873099b3a.107.2024.07.06.02.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 02:07:33 -0700 (PDT)
Message-ID: <9c6c4985-0f8e-4fda-be4e-bc602ea294f5@daynix.com>
Date: Sat, 6 Jul 2024 18:07:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
To: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
 <D2HFW32A8VYB.2PS3EWIXHS2UY@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <D2HFW32A8VYB.2PS3EWIXHS2UY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/05 16:50, Nicholas Piggin wrote:
> On Fri Jul 5, 2024 at 3:12 PM AEST, David Gibson wrote:
>> On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
>>> On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
>>>> On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
>>>>> On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
>>>>>> On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>>>
>>>>>>> On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
>>>>>>>> On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>
>>>>>>>>> FDT properties are aligned by 4 bytes, not 8 bytes.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>> ---
>>>>>>>>>   hw/ppc/vof.c | 2 +-
>>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>>>>>>>>> index e3b430a81f4f..b5b6514d79fc 100644
>>>>>>>>> --- a/hw/ppc/vof.c
>>>>>>>>> +++ b/hw/ppc/vof.c
>>>>>>>>> @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>>>>>>>>>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>>>>>>>>>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>>>>>>>>>       if (sc == 2) {
>>>>>>>>> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
>>>>>>>>> +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
>>>>>>>>>       } else {
>>>>>>>>>           mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
>>>>>>>>>       }
>>>>>>>>
>>>>>>>> I did wonder if there was a better way to do what this is doing,
>>>>>>>> but neither we (in system/device_tree.c) nor libfdt seem to
>>>>>>>> provide one.
>>>>>>>
>>>>>>> libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
>>>>>>> not an automatic aligned-or-unaligned helper.   Maybe we should add that?
>>>>>>
>>>>>> fdt32_ld() and friends only do the "load from this bit of memory"
>>>>>> part, which we already have QEMU utility functions for (and which
>>>>>> are this patch uses).
>>>>>>
>>>>>> This particular bit of code is dealing with an fdt property ("memory")
>>>>>> that is an array of (address, size) tuples where address and size
>>>>>> can independently be either 32 or 64 bits, and it wants the
>>>>>> size value of tuple 0. So the missing functionality is something at
>>>>>> a higher level than fdt32_ld() which would let you say "give me
>>>>>> tuple N field X" with some way to specify the tuple layout. (Which
>>>>>> is an awkward kind of API to write in C.)
>>>>>>
>>>>>> Slightly less general, but for this case we could perhaps have
>>>>>> something like the getprop equivalent of qemu_fdt_setprop_sized_cells():
>>>>>>
>>>>>>    uint64_t value_array[2];
>>>>>>    qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
>>>>>>                                 ac, sc);
>>>>>>    /*
>>>>>>     * fills in value_array[0] with address, value_array[1] with size,
>>>>>>     * probably barfs if the varargs-list of cell-sizes doesn't
>>>>>>     * cover the whole property, similar to the current assert on
>>>>>>     * proplen.
>>>>>>     */
>>>>>>    mem0_end = value_array[0];
>>>>>
>>>>> Since 4/8 byte cells are most common and size is probably
>>>>> normally known, what about something simpler to start with?
>>>>
>>>> Hrm, I don't think this helps much.  As Peter points out the actual
>>>> load isn't really the issue, it's locating the right spot for it.
>>>
>>> I don't really see why that's a problem, it's just a pointer
>>> addition - base + fdt_address_cells * 4. The problem was in
>>
>> This is harder if #address-cells and #size-cells are different, or if
>> you're parsing ranges and #address-cells is different between parent
>> and child node.
>>
>>> the memory access (yes it's fixed with the patch but you could
>>> add a general libfdt way to do it).
>>
>> Huh.. well I'm getting different impressions of what the problem
>> actually is from what I initially read versus Peter Maydell's
>> comments, so I don't really know what to think.
> 
> If I'm not mistaken, the sanitizer caught an unaligned 64-bit
> load which is the bug.
> 
> The tuple address calculation itself I think is not buggy. I suppose
> Peter was thinking of an accessor that takes care of addressing and
> alignment. I don't think we're at the point it warrants it here, but
> could be convinced (maybe a bunch of other code would use it).
> 
> I think the API is a little dangerous for overflows though, hard to
> static check. sscanf() style could be checked by the compiler but
> seems overkill to implement.
> 
>> If it's just the load then fdt32_ld() etc. already exist.  Or is it
>> really such a hot path that unconditionally handling unaligned
>> accesses isn't tenable?
> 
> Yeah that's true, hardly any point to adding the faster variant.
> 
> It could just be fixed like this then? The original patch is a
> fix too, but I do prefer using the same style for both, and
> I think using the fdt accessor is nicer to read.
> 
> Thanks,
> Nick
> 
> ---
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index e3b430a81f..a666a133d7 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -646,9 +646,9 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>       if (sc == 2) {
> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
> +        mem0_end = fdt64_ld((fdt64_t *)(mem0_reg + sizeof(uint32_t) * ac));

I don't like the extra cast to fdt64_t. Strictly speaking, casting into 
uint64_t * is undefined in the standard and the compiler is free to 
optimize it as an aligned access after the cast. clang and gcc does not 
perform such an optimization, but it is better to avoid such a construct 
if possible.* It is unfortunate that libfdt requires it.

Nevertheless, I won't object to use fdt64_ld() and fdt32_ld(). That's 
what the upstream provides anyway.

Regards,
Akihiko Odaki

* By the way, I had a related discussion with sanitizer developers:
   https://github.com/llvm/llvm-project/issues/83710

