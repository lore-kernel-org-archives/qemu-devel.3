Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031DBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 12:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgNZN-0005JW-2D; Tue, 20 Aug 2024 08:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sgNZL-0005It-By
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 08:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sgNZI-0002ZT-VD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 08:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724155349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tP3B4zzJ4sLM5bcZaraJalstUvfb28zTMKq30Pl5fkE=;
 b=X+OEh7wT712q0Yzz8tJKEjCbKDowkkUrlTuNhyxIm73rJ3tqy/fFRWbrjratN8o3ef6pdM
 rrZBwwD2HKalrGUEZkVCEzPfkeR2FP/8vZgEWLbbWMQT5pVA34PfIG7iTZQ16sHCtBqU/D
 C09NHiXSI/GSqRRgdsdr+o5A+N3psMo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-8TAbJWfNNYuQchEJgdozmg-1; Tue, 20 Aug 2024 08:02:27 -0400
X-MC-Unique: 8TAbJWfNNYuQchEJgdozmg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280c0b3017so47219195e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 05:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724155346; x=1724760146;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tP3B4zzJ4sLM5bcZaraJalstUvfb28zTMKq30Pl5fkE=;
 b=hi1+/TrkQa1vpxuatVREzrIVM20mxkza8C66/U0sAtk8Lf26aa8hwOqN0NXasmxiL9
 GYZ/H0S6BCPLO6P3ZeVswDnJKzaqBSdy6S+x9ZUsA8K8wbzTC2ddQQOOQSc5YZZAjI/J
 UppxOoMKJflLzw/EcuNCKdi0bsJl+trqozit3nrkJXW04uCsTu421BMaUM75m7mxkFAQ
 wEY7GLp2D3RIclaE0q3JPOKd+9pB9pnso2+jdpz1jh7fWNYPQezPZDla0SaJSCU1IBtj
 fyinDT1AQXJmJ3WOcNAI4VRuXxz+MtNwOpPtLNQNJk1YhXU6qYvOzf6BHA1LTEN9ACJ0
 wxyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO0COvyvq6sy1gqM3aIAjwh7e6xOep13PWSd9yArSvH6xZHQXnrTN13jNxZgDD5JUCoy88mcl9EMjMQRSimD9qQxFqQLA=
X-Gm-Message-State: AOJu0YwHwOfTGwNdwX0iwof/xYW9UWutOEQOzzFH/9iLY2BFMbRnBxVf
 WtV1CeP8t7kdCF21Z5Ta9fi+R4q+cpVKUGp+ds+vdjIT3zMekDgujIIm8ZMk/AGmN3LQgWPI1hu
 d/QQo3Ps8Ns29U+SAPkjJM6eYWBpqOg2i/XYAcb/BZ5S7ykZp3SrgMcYhgiIpG7o=
X-Received: by 2002:adf:fad1:0:b0:36b:a3f1:eb with SMTP id
 ffacd0b85a97d-371946bfa9amr7739587f8f.53.1724155346504; 
 Tue, 20 Aug 2024 05:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ80ELh+u0ki+kZQgW9OsB3Nu4XjCrouyBjxKv++IyAWDpQb6Ih1FJfAyiaf/Nnb2QeecLsA==
X-Received: by 2002:adf:fad1:0:b0:36b:a3f1:eb with SMTP id
 ffacd0b85a97d-371946bfa9amr7739548f8f.53.1724155345557; 
 Tue, 20 Aug 2024 05:02:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:e00:9c12:cdf2:bf1c:b8ed?
 (p200300cbc74b0e009c12cdf2bf1cb8ed.dip0.t-ipconnect.de.
 [2003:cb:c74b:e00:9c12:cdf2:bf1c:b8ed])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189849831sm12981139f8f.30.2024.08.20.05.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 05:02:25 -0700 (PDT)
Message-ID: <d4436eea-392d-47f4-90ac-d9aa5851506d@redhat.com>
Date: Tue, 20 Aug 2024 14:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
 <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
 <CAC2qdxAfvKubvO7fs4KF8dy_+Ad5kbAaxyn2P0FCDL-zkhEiMw@mail.gmail.com>
 <6ab58af7-3584-40b5-b56c-45544a06c7af@redhat.com>
 <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20.08.24 13:56, Peter Maydell wrote:
> On Tue, 20 Aug 2024 at 12:40, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.08.24 14:32, Juraj Marcin wrote:
>>> On Tue, Aug 13, 2024 at 6:37 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Tue, 13 Aug 2024 at 16:39, Juraj Marcin <jmarcin@redhat.com> wrote:
>>>>>
>>>>> Some devices need to distinguish cold start reset from waking up from a
>>>>> suspended state. This patch adds new value to the enum, and updates the
>>>>> i386 wakeup method to use this new reset type.
>>>>>
>>>>> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>    docs/devel/reset.rst    | 8 ++++++++
>>>>>    hw/i386/pc.c            | 2 +-
>>>>>    include/hw/resettable.h | 2 ++
>>>>>    3 files changed, 11 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
>>>>> index 9746a4e8a0..a7c9467313 100644
>>>>> --- a/docs/devel/reset.rst
>>>>> +++ b/docs/devel/reset.rst
>>>>> @@ -44,6 +44,14 @@ The Resettable interface handles reset types with an enum ``ResetType``:
>>>>>      value on each cold reset, such as RNG seed information, and which they
>>>>>      must not reinitialize on a snapshot-load reset.
>>>>>
>>>>> +``RESET_TYPE_WAKEUP``
>>>>> +  This type is called for a reset when the system is being woken-up from a
>>>>> +  suspended state using the ``qemu_system_wakeup()`` function. If the machine
>>>>> +  needs to reset its devices in its ``MachineClass::wakeup()`` method, this
>>>>> +  reset type should be used, so devices can differentiate system wake-up from
>>>>> +  other reset types. For example, a virtio-mem device must not unplug its
>>>>> +  memory during wake-up as that would clear the guest RAM.
>>>>> +
>>>>>    Devices which implement reset methods must treat any unknown ``ResetType``
>>>>>    as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
>>>>>    existing code we need to change if we add more types in future.
>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>> index ccb9731c91..49efd0a997 100644
>>>>> --- a/hw/i386/pc.c
>>>>> +++ b/hw/i386/pc.c
>>>>> @@ -1716,7 +1716,7 @@ static void pc_machine_reset(MachineState *machine, ResetType type)
>>>>>    static void pc_machine_wakeup(MachineState *machine)
>>>>>    {
>>>>>        cpu_synchronize_all_states();
>>>>> -    pc_machine_reset(machine, RESET_TYPE_COLD);
>>>>> +    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
>>>>>        cpu_synchronize_all_post_reset();
>>>>>    }
>>>>
>>>> I'm happy (following discussion in the previous thread)
>>>> that 'wakeup' is the right reset event to be using here.
>>>> But looking at the existing code for qemu_system_wakeup()
>>>> something seems odd here. qemu_system_wakeup() calls
>>>> the MachineClass::wakeup method if it's set, and does
>>>> nothing if it's not. The PC implementation of that calls
>>>> pc_machine_reset(), which does a qemu_devices_reset(),
>>>> which does a complete three-phase reset of the system.
>>>> But if the machine doesn't implement wakeup then we
>>>> never reset the system at all.
>>>>
>>>> Shouldn't qemu_system_wakeup() do a qemu_devices_reset()
>>>> if there's no MachineClass::wakeup, in a similar way to
>>>> how qemu_system_reset() does a qemu_devices_reset()
>>>> if there's no MachineClass::reset method ? Having the
>>>> wakeup event be "sometimes this will do a RESET_TYPE_WAKEUP
>>>> but sometimes it won't" doesn't seem right to me...
>>
>> One thing one could consider would probably be to send a WARM reset to
>> all devices. The main issue here is that other devices will default to a
>> COLD device then, and that's precisely what the other machines that
>> implement suspend+resume do not want. And ...
>>
>>>
>>>   From my understanding that I have gathered from the code (but please,
>>> someone correct me if I am wrong), this is machine specific. Some
>>> machine types might not support suspend+wake-up at all. The support
>>> has to be explicitly advertised through qemu_register_wakeup_support()
>>> (for example, aarch64 with a generic virt machine type does not
>>> advertise support). Even if the machine type advertises
>>> suspend+wake-up support, it might not need to do anything machine
>>> specific. This is the case of pSeries PowerPC machine (sPAPR) that
>>> advertises support, but does not implement MachineClass::wakeup()
>>> method as nothing needs to change in the machine state. [1]
>>>
>>> So, if a restart during wake-up happens, it can be differentiated with
>>> the wake-up reset type, and if the machine type does not need to reset
>>> its devices during wake-up, there is no reset that needs to be
>>> differentiated.
>>
>> ... if the machine does not do any resets during suspend+wakeup, this
>> implies that there is not even a warm reset.
>>
>> I guess we should make that clearer in the documentation: it's up to a
>> machine implementation whether it wants to trigger a WARM reset during
>> suspend+wakeup. If not, not resets will be performed at all.
>>
>> @Peter, does that sound reasonable?
> 
> Well, so far we've established that we need a "WAKEUP" reset
> type, but not that we need a "WARM" reset type. The latter

Sorry, I meant "WAKEUP" ... :)

> would be something we'd need to trigger for quite a lot of
> reset-causes where we currently default to COLD reset, so
> I don't think we should do that until we need it.
> 
> If suspend-and-wakeup really is supposed to be a reset event
> on some machines but not on others, that sounds unhelpfully
> nonstandard, but then hardware designers rarely make choices
> to make our lives easier :-) And yes, we should make sure
> that's clear in the documentation.
> 
> I think with adding new reset events it's going to be
> important that we're clear about what they are (and in
> particular what the triggering events that cause them
> are) so that we have a solid guide for what it means.
> The thing in particular I'm hoping to avoid here is that
> we vaguely define, for example, a "warm" reset type and then
> different parts of the system interpret "warm" in different
> ways.

Okay, so we should make it clear that a WAKEUP reset may be used on 
machines (especially x86) during a wakeup after suspending, when most of 
the devices are supposed to just do the same as a COLD reset, and only 
some of them (especially memory-layout/content related) need to preserve 
their state. The primary reason of the WAKEUP event is for these devices 
to handle these wakeups properly.

Then, we should document that some machines might not perform any reset 
during a wakeup, which will result in no resets to be triggered at all.

-- 
Cheers,

David / dhildenb


