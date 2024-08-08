Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE04C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 16:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc5cf-0006Wv-HL; Thu, 08 Aug 2024 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sc5cd-0006WO-Cb
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sc5cb-0002as-Cd
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723133052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rMfdalaylN3MoSp615Hy9OKtdNsHJk2A6uEnyn6sLOM=;
 b=gLPcF3Hzi2D6dsAUYAEYNmqMn8o7fBOUnFUrgjtatNzyHuCFDNKRW7qoxccBGAfYNM23QN
 1Vt+dj54qf+Jt8QS8+JdWAKeIDAADk3TWxbaKkKyU252EeJ4MjhFaoHXz7RmgZ3/3Uy19y
 LD6fpOJVJXRW+YJphbG76rwjCtkZIEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-R2KSOtafPZmPLB0rghr84g-1; Thu, 08 Aug 2024 12:04:10 -0400
X-MC-Unique: R2KSOtafPZmPLB0rghr84g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-369bbbdb5a1so570821f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 09:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723133049; x=1723737849;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rMfdalaylN3MoSp615Hy9OKtdNsHJk2A6uEnyn6sLOM=;
 b=G2pQvkW0fe9GkNoYD1D6mqPAg9qlgVsQ78sj1TGuqs/rCQs8MTSJcSSPasCRzBol3z
 akKpvRvy158eC+vCz5yzzrdHwolpQRWTabm+9aHKokpRhlej2VMSFl+0zyb7/HBGYxnQ
 /wN8Nvdy3xKqxLw+76yqo3vnDJsCG0LeKZ/IUvw/XLNif0IImtFwRi31jyr1+JCLDh7s
 rRvxb4dCuSTUhjLmLTm672ZKntem5ueI/efAhhZnEmVexQoShjLi7IHnz5rsddhBHzmX
 ci64FRcpKBnngofcmDddyGzLmbuaYV0A5kLNPi3NMGU5mtczqmy9Jv64bP9yxQslUCDg
 D6Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+cz37zjObZ5Xcxq/uQ3AsIPOSeVo3/E4faW3bMe0gUC7KJlDKQt87mdY54rfWcCDbcec/1VY9282xNFx71wTHSTWjIew=
X-Gm-Message-State: AOJu0Yz7QXB7HX5pfD/5C0p18auKjVjUAV9BqDZWHBHJIw8x/sT9RFJM
 Jk29QKA+D9lBJ6bpxbEB6SlXO351tFYlEUI4MU7B8zihInIX1r8T8mj+7P4V2Ga1k9YTTtyKujI
 q9LtCGiXHo0vZLjjmrnilI4h9s/gBkRXHh37VbK13BVWa3Dw6paXl
X-Received: by 2002:a05:6000:1372:b0:362:69b3:8e4d with SMTP id
 ffacd0b85a97d-36d28174916mr2068130f8f.25.1723133049596; 
 Thu, 08 Aug 2024 09:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPfrwtTi7Ej84jlWl0gy4uw7yFi+3U3nH0fihy/m6eThAB6RXZARYVBP5hNa3dLt+PCAXjmA==
X-Received: by 2002:a05:6000:1372:b0:362:69b3:8e4d with SMTP id
 ffacd0b85a97d-36d28174916mr2068080f8f.25.1723133048972; 
 Thu, 08 Aug 2024 09:04:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6?
 (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de.
 [2003:cb:c713:2a00:f151:50f1:7164:32e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d270163dfsm2371486f8f.0.2024.08.08.09.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 09:04:08 -0700 (PDT)
Message-ID: <bf8d2172-ddd3-499c-a164-6b358c6496a7@redhat.com>
Date: Thu, 8 Aug 2024 18:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
 <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
 <CAC2qdxDhfon3Xe7J4jCVyqx7VdR-CMbo2r7Vat=WOA0qWLoFMg@mail.gmail.com>
 <34840c40-1a54-4aa0-a424-defd93d3b2b2@redhat.com>
 <CAFEAcA9LNj1JENcCKHU+BvKE+K5_b3jUSS_prwAC2X084xvT8A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA9LNj1JENcCKHU+BvKE+K5_b3jUSS_prwAC2X084xvT8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08.08.24 17:56, Peter Maydell wrote:
> On Thu, 8 Aug 2024 at 16:31, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.08.24 17:28, Juraj Marcin wrote:
>>> On Thu, Aug 8, 2024 at 2:18 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
>>>>> +``RESET_TYPE_WAKEUP``
>>>>> +  This type is used when the machine is woken up from a suspended state (deep
>>>>> +  sleep, suspend-to-ram). Devices that must not be reset to their initial state
>>>>> +  after wake-up (for example virtio-mem) can use this state to differentiate
>>>>> +  cold start from wake-up can use this state to differentiate cold start from
>>>>> +  wake-up.
>>>>
>>>> I feel like this needs more clarity about what this is, since
>>>> as a reset type it's a general behaviour, not a machine
>>>> specific one. What exactly is "wakeup" and when does it happen?
>>>> How does it differ from what you might call a "warm" reset,
>>>> where the user pressed the front-panel reset button?
>>>> Why is virtio-mem in particular interesting here?
>>>
>>> Thank you for the feedback!
>>>
>>> I have rewritten the paragraph:
>>>
>>> This type is called for a reset when the system is being woken up from
>>> a suspended state using the ``qemu_system_wakeup()`` function. If the
>>> machine type needs to reset in its ``MachineClass::wakeup()`` method,
>>> this reset type should be used so that devices can differentiate
>>> system wake-up from other reset types. For example, a virtio-mem
>>> device must not unplug its memory during wake-up, as that would clear
>>> the guest RAM.
>>>
>>> Is it clearer? Thank you!
>>
>> Conceptually, if we want to avoid the "WAKEUP" terminology here, maybe
>> we should consider talking about a WARM reset -- in contrast to a COLD one?
>>
>> During a WARM reset, memory content is supposed to stay untouched, which
>> is what we effectively want to achieve with virtio-mem.
> 
> Right, I guess that's my question -- is "WAKEUP" ever any
> different from "WARM" reset? I think the latter is a more
> common general concept.
> 
> On the other hand it looks like we already have the
> concept in the runstate state machine of
> RUN_STATE_SUSPENDED versus RUN_STATE_RUNNING, and so if we
> define "WAKEUP" as "goes from SUSPENDED to RUNNING" that's
> quite a clearly defined condition.

Right.

> Whereas WARM reset would
> be a much wider range of things and ought to include for
> instance "guest triggers a reset by writing to port 92"
> and all the other SHUTDOWN_CAUSE_GUEST_RESET cases.
> (Side note: do we document all these runstates and transitions
> anywhere?)
> 
> For virtio-mem, on a guest-triggered reset, should it
> (a) definitely not unplug all the hotplugged memory
> (b) definitely unplug all the hotplugged memory
> (c) we don't care?

During ordinary system resets (COLD) where RAM content is not guaranteed 
to survive:

Effectively (b)

During special kexec-style resets (e.g., on s390x there is a difference) 
where RAM content must survive:

Effectively (a)


On implementing architectures (x86, arm64), kexec-style resets are 
really like warm resets. For example, when we trigger kexec->kdump we
must not suddenly lose the RAM content.

In that sense, at least virtio-mem wants to treat WARM and WAKEUP resets
alike. But I agree that simply because virtio-mem want sot treat them 
alike doesn't mean that we should represent in QEMU using a single reset 
type.

WARM reboots like s390x supports are rather stuff for the future (once 
s390x actually supports virtio-mem and could end up triggering it).

> 
> If (a) then that seems to push towards calling all these
> cases of a "warm" reset; if (b) then that would be a
> reason to make "warm" and "wakeup" different.

Likely different then.

-- 
Cheers,

David / dhildenb


