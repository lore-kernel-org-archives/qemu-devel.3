Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6F6F5545D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7ry-0000c2-W8; Wed, 25 Feb 2026 00:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7rs-0000bl-Dy
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:55:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7rq-0000wQ-ED
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:55:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4833115090dso60918625e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771998923; x=1772603723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ay4rJ04gFVAifpGDRyPu3Ebu6YW+EHNMxzhbOIOXHO4=;
 b=OrYRc5n+6RlBroS0ReAIUXaWcvXdMO571bFO3TEizAtDa3WLJOOb8QeW24uin7Fzu2
 K4YbIOgIK2VjAW9zJHfXxfnYrt2MCBkP5ZYzgn728O/HUznxErPWEG6M4kKMAfaIy50s
 tf3sRKsZLU2OerKTZiu853QxZUPOggQcvNNgEQKkb+g7KBCZZRPskMa9heGNfBZGL/nA
 wote5kEXt4p1Bgl3AxcP1dlesdTLvIDgL279+4HYX2ndxcKDiaO7/VZQmYv5DY7oLHkP
 S1zvam2tKRhS92ZxLP5P1lpXUuJdrzJYH8tDXQU83gOVoeYtP3Cxj5mraSIqf1R3DEq/
 3ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771998923; x=1772603723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ay4rJ04gFVAifpGDRyPu3Ebu6YW+EHNMxzhbOIOXHO4=;
 b=awpH3IiFr4KGGY+VqxOVJZ6PiKGZzGhxEfqM3ecw4BZyB4hOYNF/SXV0rEISIYR74u
 lfcoaOPb3YztLw3ITktlNC0yvJLB4z6v2iOwYQ5riL0ACYUETbONG2ZFxuByX04hAP5l
 VNn7GrZHXTq0455BNSbm7PgakeEeHwIc90S69/XIh1amHNKtVVWosSrqPbQL1jpUwWQi
 JqGlA0rJao0ZxSWY3ophL+d4JlrwBbiZ97U7XPchNkhYjO80XnEBkMYO3ZJbMKBwzbqR
 5Qemmulid4WWjc2qVeuqMa2OUr3mCXb7eXU5ALf97JD6FmJcizh1PM+wV9T1fvXfXZAD
 ckjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLHkfYgMO4bEGfknEsLK6JwwXpWzUHw8T7hys6B3dtqFJljoQlPRzWpZcSFkJlpz2oh5BrVWb83Srt@nongnu.org
X-Gm-Message-State: AOJu0YwFhzqKp6oiqEObcyWIvDrqf3XVJKlQ5VS+ai8+pms/Ty2Acheu
 pThqLH1gZ1pL6QaNjxovtmM85r6BJVD4trTC/YqlkC/tltlX+HTImbHdmtZdu2WwdFwPLWKXwAS
 QfxnrE80=
X-Gm-Gg: ATEYQzyakfeioWLjcDZvA6t5tF+WXV3a7RO1Sby8SKyeT4HEvCOjKKgpxbeeLbaUUuE
 PtbiWdC2wgIG+YmyizZhR5RusQ5whVgOB0Z1LcfVfU/rzsEC9wts05aj08KTpSs2f4CWY5YUjcI
 Q8CerJAAn80EhIC8lkXxne7c3brjwbGHNRdP7YWi+tycsidL7w3kGEIfLd5YffPAOF2F/+C9BGW
 IKcrPI1bowKCi7rlv+E4ove+UPPIS22S2h0XsSttTXH2RQ5HdPoP3EQZJz6oMJOBhY/EHuTi1zE
 K7qqbwywasfGZePCSp0MJczM26dg/uvO8LE+saV1QUhrIdmqVoMJTvFKBuElZHEU0bIjsgCQsjb
 djbhn6DjVu8HRdFRKwieQauwyYkoxf3+j5uRPFGPYO+6huw7jQ5kzvDwqrW7WGi/bH54u6VU67A
 5ghGsrKTBu0aIJ4CMVI5QvE948czGLl+cdoQaqYz3fSnvLZImC/ej8ZgLJsKLFnTXEuw==
X-Received: by 2002:a05:600c:821b:b0:483:71f7:2794 with SMTP id
 5b1f17b1804b1-483a95c9e73mr264579975e9.15.1771998923334; 
 Tue, 24 Feb 2026 21:55:23 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf8b6sm3960675e9.20.2026.02.24.21.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 21:55:22 -0800 (PST)
Message-ID: <0fef1895-b8dd-4091-a4af-6bcb5a974e32@linaro.org>
Date: Wed, 25 Feb 2026 06:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached
 if they have a bus
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mark Burton <mburton@qti.qualcomm.com>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
 <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+Bernhard

On 24/2/26 13:22, Mark Cave-Ayland wrote:
> On 24/02/2026 11:10, Peter Maydell wrote:
> 
>> On Tue, 24 Feb 2026 at 09:48, Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>> IMHO, it is slightly more subtle - people believe they are already
>>> adding children.
>>>
>>> Consider this code.
>>>
>>>      port92 = isa_create_simple(isa_bus, TYPE_PORT92);
>>>
>>> my reading of that is that I'm creating a "port92" device that is a
>>> child of "isa_bus". Why would I need to tell QEMU that it is a child
>>> for a second time ?
>>>
>>> If I trace calls through isa_create_simple I get to a call to:
>>>
>>>     qdev_realize_and_unref(dev, parent, errp);
>>>
>>> and once I again I'm left wondering why I would need to tell
>>> QEMU 'dev' is a child of 'parent' a second time.
>>>
>>> Of course I know the answer. We need to give a name for the
>>> child and it isn't trivial to "do the right thing" to invent
>>> an automatic name.
>>>
>>> Still, overall I'm inclined to largely blame our API designs for
>>> not guiding people into doing the right thing.
>>>
>>>
>>> Picking another random unattached set of objects "smbus-eeprom"
>>> I again find they've being created with qdev_realize_and_unref.
>>>
>>> Pick another unattached device 'i8259_init_chip', and again
>>> we end up calling into qdev_realize_and_unref()
>>>
>>>
>>> It feels like qdev_realize_and_unref() is a common point of
>>> blame in unattached devices. IMHO it ought to be taking a
>>> "const char *name" parameter.
>>
>> I think that is because this is the function that is used
>> in older code that predates the "everything should be in
>> the QOM tree" model. Newer code doesn't use it, I think;
>> and it's not surprising that old pre-QOM code doesn't do
>> anything to put objects into the QOM tree.
>>
>> The two patterns are:
>>
>>   dev = qdev_new(...);
>>   ...
>>   qdev_realize_and_unref(dev, bus, errp);
>>
>> and
>>
>>   object_initialize_child(...);
>>   ...
>>   qdev_realize(dev, bus, errp);
>>
>> This also is somewhat tangled up with the question of whether you want:
>>
>>   * call a function which allocates memory and initializes it
>>     with an object of this type
>>   * I have the memory here, init the object in-place
>>
>> If we could come to a definite conclusion on what we want then
>> we would probably be in a better position to try to enforce it.

I recall a previous discussion where we said in-place allocation
does not scale with dynamic machines (data driven config), and IIRC
Bernhard said by switching to dynamic heap allocation we'd use more
QOM cast macros and lose compiler safety type checks. Can't find it
now in the archives.

We have some model declension where we allocate in-place $MAX members
and expose a QOM property to initialize up to that number (or worst,
de-initialize and unparent what is left!) in the DeviceRealize handler.
Not "in-place" could simplify this.

> Exactly this! I think what tends to happen is that we get stuck in 
> situations where someone suggests an improvement, but then we get hung 
> up trying to work out the corner-cases where it doesn't work and then 
> things don't progress.
> 
> The approach I believe we need to take is to work out what we want the 
> API and QOM tree to look like first, and then work backwards from there.
> 
> I tend to be in agreement with Akihiko's argument that we want to 
> deprecate in-place initialisation with object_initialize_child() and 
> simply use refcounting everywhere because then we don't hit any lifcycle 
> issues if something retains a reference to the internal object (memory 
> regions!).
> 
> The questions I think we need to answer as a starting point:
> 
>    1. Which API shall we converge on: qdev or QOM? Can we come up with a
>       code sample(s) showing what we want object/device initialisation to
>       look lie? Longer term can we unify the QOM and qdev trees?
> 
>    2. Should we convert to use external object allocation with
>       refcounting?
> 
>    3. How do we handle memory regions? With Akihiko's recent refcount
>       fixes then Zoltan's memory region changes could work: I don't agree
>       with the motivation of simplifying devices as I think it's i)
>       subjective and ii) harder to debug if we lose the pointer to the
>       memory region, but I can see how it fixes the RCU-thread doing an
>       unref after the owner device has already been destroyed issue.
> 
> As several people have already pointed out in this thread, we do have a 
> poor track record of API conversions but the introduction of memory 
> regions shows how this can be done successfully.
> 
> Given that we already have multiple ways of doing the same thing, I tend 
> to lean against not introducing yet-another-API unless we can come up 
> with a long-term strategy for its use. In particular this causes 
> problems in review where e.g. one reviewer may want to use QOM to setup 
> a device whilst another may want to use qdev which is confusing for 
> everyone, including the code submitter.
> 
> If we can at least get an answer to 1) then I'd be willing to have a go 
> at writing some kind of specification document and put it out for 
> feedback...
> 
> 
> ATB,
> 
> Mark.
> 
> 


