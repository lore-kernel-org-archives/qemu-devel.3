Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11B9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1REl-0003dc-VA; Mon, 29 Apr 2024 09:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1REi-0003dF-70
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:40:05 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1REg-0000qj-1z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:40:03 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso4047340a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714398000; x=1715002800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FCayGo/UueZ0m9/2yY8GVfnM/jvfBIii0FHoaTwegUs=;
 b=bdw2yN0SDRV+HVlPphNBEKZaULW7nJR1T745mqZFpKf7yQd+gs1SC97FxBZq928iAX
 egMaeFBvw19v57DYxrN2H+eivj/L7eSZib/sg+cTPeSokLY3NT1s+fs8EL7UwELXQt+m
 eBQW8JeztAJ6EktkS8UxcxS43CaI/1ogBAZ9QpyIxZJo0RDXA6cwv7lwowUMyRrvA06/
 iZg1S7it6oi5kaTfe+2ZsbgdWT4jgwqeU4NpiHtkb9JRUUiOmOQM4es4nrtoE2c8uhG0
 P6lyhQZsHit3ixUANGsVn1ySYjOzRoBfRqWCwBvvM5iTFvVE/CRgtgxFXQo8Q1Sfv5d6
 eZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714398000; x=1715002800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FCayGo/UueZ0m9/2yY8GVfnM/jvfBIii0FHoaTwegUs=;
 b=pod69WLNaTCHGBtjAbePOVcJyK1z3pXZMftAgdi44bD/fs37poLQds+0KCkZTlFD1X
 LYn9a+BcnUh3vzMQRPgQ1nNj4BPSi0GdrTexnqf4/lhfsyRmDR+CFjOCQY5AmS02s2fC
 yoFQkW4Xfv/RDdwlTQQHB/vK8gxY7gGuUmRBYzV/T/GQnHMqrYoIgNkeyy5DDkeQbhFh
 45puauMFYgvDEso7YB+eDCwqNTlCiSJgXNfCF4Ao+8jT5RBtm7xoZK/ZCmAt0I9k/SVS
 YVHafrv7vOtnftecZYd9CNalXvjLp3q+z+wtVapHPNWOWxHwF3mInSDLGuTJIf8MKb4h
 vGWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPyEx7dFqijbbllYVYZ1kiT7XlOnp8h/9BN2xKzvJb7Uc63in6QTDuq6ZjIoGhsHKjqKcJP2Skeer3j6wVoW8aW/vvSqg=
X-Gm-Message-State: AOJu0YwU5c8igh3dDrDG5HW+GUbiDhxL4gB1ytnQ8a5bw0paa8zP4lY/
 O05incJoTx9SOeaomSHgfx8SVwklE+isVaMxP8JKrIW2jg52qEpBKgpmpoQ3UQc=
X-Google-Smtp-Source: AGHT+IES8inFL7lqk67DylQp1ZpXL20aJBi0rh2eLfFAi0eh/wSJ35LSwCYFSPEr8ZBEc4BqbC4kBg==
X-Received: by 2002:a17:906:c04f:b0:a55:6b76:eedc with SMTP id
 bm15-20020a170906c04f00b00a556b76eedcmr7155637ejb.14.1714397999944; 
 Mon, 29 Apr 2024 06:39:59 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 q10-20020a170906388a00b00a46aba003eesm13863118ejd.215.2024.04.29.06.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 06:39:59 -0700 (PDT)
Message-ID: <40bee8cc-6cad-4c5b-a319-49dcbb2b82f1@linaro.org>
Date: Mon, 29 Apr 2024 15:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
 <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
 <87plu8ieut.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87plu8ieut.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

(+Peter who has more experience on such design).

On 29/4/24 13:32, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Daniil, Markus,
>>
>> On 26/4/24 10:39, Markus Armbruster wrote:
>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>
>>>> This can be used to force-synchronize the time in guest after a long
>>>> stop-cont pause, which can be useful for serverless-type workload.

What is a "serverless-type workload"?

>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>> ---
>>>>    hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>>>>    include/hw/rtc/mc146818rtc.h |  1 +
>>>>    qapi/misc-target.json        | 16 ++++++++++++++++
>>>>    3 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>>> index f4c1869232..6980a78d5f 100644
>>>> --- a/hw/rtc/mc146818rtc.c
>>>> +++ b/hw/rtc/mc146818rtc.c
>>>> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>>        }
>>>>    }
>>>>    +void qmp_rtc_notify(Error **errp)
>>>> +{
>>>> +    MC146818RtcState *s;
>>>> +
>>>> +    /*
>>>> +     * See:
>>>> +     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt

What part of this document explains why this change is required?
I probably missed it. Explaining it here briefly would be more
useful.

>>>> +     */
>>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
                                       // Update-ended interrupt enable

>>>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
                                       // interrupt request flag
                                       //           update interrupt flag

>>>> +        qemu_irq_raise(s->irq);
>>>> +    }
>>>> +}
>>>> +
>>> Note for later: qmp_rtc_notify() works on all realized mc146818rtc
>>> devices.  Other kinds of RTC devices are silently ignored.  Just like
>>> qmp_rtc_reset_reinjection().
>>
>> IMO to avoid any future ambiguity (in heterogeneous machines), this
>> command must take a QOM device path (or a list of) and only notify
>> those.
> 
> Let's compare:
> 
> • With QOM path:
> 
>    · You need to know the machine's RTC device(s).
> 
>      Unfortunately, this is bothersome, as the QOM path is not stable.

But we'll need more of that with dynamic machines...

>      For Q35, it's generally "/machine/unattached/device[N]/rtc", but N
>      varies with configuration (TCG N=2, KVM N=3 for me), and it might
>      vary with machine type version.  That's because the machine code
>      creates ICH9-LPC without a proper name.  We do that a lot.  I hate
>      it.
> 
>      Likewise for i440FX with PIIX3 instead of ICH9-LPC.
> 
>      For isapc, it's /machine/unattached/device[3].  I suspect the 3
>      isn't reliable there, either.
> 
>      microvm doesn't seem to have an RTC by default.
> 
>    · If the device so named doesn't support IRQ inject, the command
>      should fail.

Yes, why the management app would want to run this command if there
are not RTC on the machine?

>    · Could be generalized to non-RTC devices when that's useful.
> 
> • Broadcast:
> 
>    · You don't need to know the machine's RTC device(s).
> 
>    · If there are multiple RTC devices that support IRQ inject, we inject
>      for each of them.  There is no way to select specific RTCs.
> 
>    · If there is no RTC device that supports IRQ inject, the command does
>      nothing silently.
> 
>      I don't like silent failures.  It could be made to fail instead.
> 
> If it wasn't for the unstable QOM path problem, I'd advise against
> the broadcast interface.
> 
> Thoughts?

Something bugs me in this patch but I couldn't figure out what I am
missing. The issue is when migrated VM is restored. I don't get why
the behavior depends on an external decision (via external management
transport). Don't we have post_load() hooks for such tuning?
This device implements it in rtc_post_load().

Regards,

Phil.

PD: BTW tomorrow community call could be a good opportunity to discuss
this.


