Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B74CE81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTt6-0005Zl-JH; Mon, 09 Feb 2026 11:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpTst-0005Qn-Jv
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:13:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpTsr-0007fS-65
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653588;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxG5pyOv89fxcBWTxy1aP7ZJ/L9bNG7cBr3lRfAOMJs=;
 b=W68QiqHueEL3z0djZ05RDYa/GvKKMqWPYDavy1BjR4FR8N1wMlTw9+WxQos4Y3SQkatfAH
 tSmpTYZRTls/R4SgYeNVrNkrSzHNadbbHDyPx73rnDT15qcsvi/V2z4sQSPZ/XM5Z9xJV6
 InTrVrxg/39+CeVhGA4/CL8AaV7ooe4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-U8EpYmNBPqyRZ1W8KBRloA-1; Mon, 09 Feb 2026 11:13:06 -0500
X-MC-Unique: U8EpYmNBPqyRZ1W8KBRloA-1
X-Mimecast-MFC-AGG-ID: U8EpYmNBPqyRZ1W8KBRloA_1770653586
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee1fe7b24so55152305e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653585; x=1771258385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxG5pyOv89fxcBWTxy1aP7ZJ/L9bNG7cBr3lRfAOMJs=;
 b=ScaFoQ/t+oBL5tnJNuQzUczezB4+/5WIjUQyXhk+5vXAVAgtBYxKH9Xet421T2qQLy
 r1wRoLWYOTzIlA8IENpicaNGghqkZqdLP8Ktw6SkQJ4Tl0ukKRzPLi6WlR04sFwPBbwV
 CVXlnMbvN/gi8Xwxh3HbNLb3/eOMLVeRLd6ICLuJtkwjv3hJ1q3YOahLKgQaEwBMNHg5
 c666JGr2bD+Csr2SetsKgTmnk1leOoISLVdbWZYjDGUmM3LfiJ4bP0j+eQ18E8ZSiacM
 fyubKaZkSWDerEkbwpimxCQ0JRdefh8iPp2IkUVz7PNvQ9fTh71kcSEtUjI9lFvwfn14
 yHyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQTqzdkRzYd+MTSrW4IgFA3FGj8jT+c22fN8iJh4hFHEXZcCXvHEDs0Upsa6pzPknbCmKBkShyGmcw@nongnu.org
X-Gm-Message-State: AOJu0YwbsPqcRcecxfA1gnlDi2CvSVEZaYy+w1os2Hu14t0fGYEGFeuS
 45/mef3y/IVEy1LdxYwlbusCJ2I87XXAzgzLIaPSPL4sGKnNV8jtxdo7Yo7FQMrhgxGZplIjcyX
 m8+2U8W5LmAYbAG2nnK7IVQcZIOY1hw2D++JzXXj7/tJGpJILGdPYXWQU
X-Gm-Gg: AZuq6aJ3USjqH1j5KXabPUSFgRFsvF60FujeRQvX241/3Oz6I/s48qlVQPfuGmMLxLQ
 02kKhWyCyvQon9RNscS6N+46C/LauzKDy+Tz7XVpR/GnwEYSaQsvqSglfgNBjU0ezYLt8ONS0sh
 RYpAurGY5BfdubXb7lv7HYSNTHgjJ7+T3MERoH3TQsx4iTcxc/YWPjkgRG26/L+f2kyMN+XGhV/
 mmsz1pYviPOVpoDhZHOSHKlh5N1OGh4lX6ZvxcbRrATfdbutxNH8WPzQHaLsu3ZZNf2ipCy0Pqa
 IfgD+5mRCA2eR+z2Ihk947dZsEW7sjJytHOkTyIeWYY36PulZZzD52Zt11hgPzObdDZZrHgddtk
 F8HTXmvvMztqnHy5IoJ5czdHb7e5ZQ2ucAA8EtrV7C70n+9Mp8+rZbIAIUQ==
X-Received: by 2002:a05:600c:608a:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-483201e4702mr164455015e9.9.1770653585512; 
 Mon, 09 Feb 2026 08:13:05 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-483201e4702mr164454495e9.9.1770653584941; 
 Mon, 09 Feb 2026 08:13:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209eeef0sm91835615e9.20.2026.02.09.08.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 08:13:04 -0800 (PST)
Message-ID: <7f1a98ec-cde9-45b5-8264-c25bfd876896@redhat.com>
Date: Mon, 9 Feb 2026 17:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com>
 <87h5rqyncj.fsf@draig.linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87h5rqyncj.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

On 2/9/26 3:59 PM, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Mon, 26 Jan 2026 at 16:54, Eric Auger <eric.auger@redhat.com> wrote:
>>> When migrating ARM guests accross same machines with different host
>>> kernels we are likely to encounter failures such as:
>>>
>>> "failed to load cpu:cpreg_vmstate_array_len"
>>>
>>> This is due to the fact KVM exposes a different number of registers
>>> to qemu on source and destination. When trying to migrate a bigger
>>> register set to a smaller one, qemu cannot save the CPU state.
>>>
>>> For example, recently we faced such kind of situations with:
>>> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>>>   register from v6.16 onwards. Causes backward migration failure.
>>> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>>>   from v6.13 onwards. Causes forward migration failure.
>> Hi; sorry I haven't given this series any attention before.
>>
>> (1) Yes, this is definitely a problem we need to solve.
>>
>> (2) What are the requirements we have for this?
>>
>> This series sets up CPU properties controlling this, and then
>> sets them in the virt machine model based on the machine
>> type, but this seems awkward for two reasons:
>>
>>  * using properties confines us to using a "text string"
>>    way of describing the behaviour; if we could implement
>>    the handling in code and C data structures in target/arm
>>    we could potentially do it in a more flexible and
>>    readable way (e.g. being able to specify the register
>>    via something other than a raw hex value)
>>  * different host kernel versions isn't really related to
>>    the QEMU version, so tying it to a versioned machine
>>    type doesn't seem to fit
>>
>> Q: Do we need the user to be able to control this (e.g. adding
>> extra registers to be ignored) on their command line, or
>> can we say "you need a newer QEMU that understands how to
>> deal with this register if you want to do migrations involving
>> this newer kernel version" ?
>>
>> Q: This series adds a "hide this register" option which
>> stops the register appearing in the outbound migration data.
>> Do we need that, or would it be enough to have "ignore this
>> register in the inbound migration data" ? Assuming we're
>> not trying to migrate backwards to an older QEMU version
>> that's unaware of the new register, that seems to me like
>> it should be equivalent.
to me we may try to migrate backwards to an older QEMU version that's
unaware of this new reg.
> As I understand it these signal to the guest what services the
> hypervisor supplies. I assume the guest kernel only reads these once at
> boot up rather than before invoking any particular service?
>
> If this is the case then things would break if a new host couldn't
> support the guest's request of the hypervisor service.
Effectively we need to make sure the reg value is not different from the
reset value (meaning qemu has not enabled any feature on src that the
dest is not able to run). 

Eric
>
>> (3) Categories of sysreg that are causing problems:
>>
>> a: "controls" -- like the PSCI_VERSION pseudoreg. Here the setting
>> controls what the kernel is exposing to the guest, and so we need
>> to be able to have the user tell QEMU to use a specific version
>> that's not the host kernel default if the default isn't one
>> that's valid for all older kernels. Sometimes the new kernel
>> default is the same as the old kernel's behaviour and in those
>> cases we also want handling of "if you see the control reg in
>> the incoming data and its value is the default then it's OK to
>> ignore it".
>>
>> b: "things exposed that should not have been" -- where the old kernel
>> exposed a register but the new one does not because exposing the
>> register was wrong (i.e. a bug). The handling here can be
>> "ignore this in migration input if present". Examples are the
>> TCG2_EL1, PIRE0_EL1, PIR_EL1 regs that shouldn't exist if the
>> corresponding feature was disabled for the guest.
>>
>> c: "things not exposed that should have been" -- where a new kernel
>> exposes a new register that the old one does not, and so migration
>> from a host with the new kernel to the old one fails. In most cases
>> it should be possible to handle this with "ignore in migration input
>> if present", or "fail migration if incoming value is not some safe
>> default, but if it is that default value then ignore".
> Shame we don't know if the guest ever read the register. If the old host
> provides features the new host doesn't but it never probed anyway then
> neither the guest or new host needs to care about the register.
>
>> Have I missed anything ?
>>
>> (4) Mechanisms for handling them:
>>
>> This series provides two mechanisms:
>>
>> "safe missing reg" -- these registers are ignored if they appear
>> in the incoming migration data.
>>
>> "hidden" -- the behaviour here is that we effectively entirely
>> ignore the register, so we do not read it from the kernel or write
>> it back, do not send it in outbound migration data, and do
>> not expect to see it in incoming migration data.
>>
>> The "arm: add kvm-psci-version vcpu property" series handles one
>> specific "control" register, with a specific user-facing cpu property.
>> If new "control" type registers are rare, this seems like a good
>> way to go, because it means we can give the user an interface that
>> is reasonably clear about what it does, and we can provide better
>> errors on the migration-destination side (e.g. pointing the user
>> at the need to specify the property on the source side to get a
>> VM they can migrate to this destination).
>>
>> The only use of "hidden" so far is for KVM_REG_ARM_VENDOR_HYP_BMAP_2.
>> However, I'm not sure this is the right way to handle this register.
>> Judging from the documentation, this seems to be a "control" register:
>> it would let QEMU enable certain things to be visible to the guest.
>> It also is odd to treat this differently from the existing
>> KVM_REG_ARM_VENDOR_HYP_BMAP register, which has exactly the same
>> semantics.
>>
>> I think that the right way to treat this register would be
>> "if this is present in the incoming migration system and the
>> host kernel doesn't know about it, a value of zero is OK, but
>> any other value should fail migration".
>>
>> In general I'm not convinced that "hidden" is a useful thing
>> to provide -- it should always be fine for QEMU to read and
>> write back to the same host kernel some sysreg it doesn't
>> know about, so what "hidden" is mostly doing is "don't put
>> this into outgoing migration data". Do we need to be able
>> to do that, or can we instead always use a "ignore in
>> incoming migration data" strategy?
>>
>> (5) My preferences
>>
>> I think that assuming that it meets the requirements, I would
>> prefer something like a mechanism where we use some kind of
>> C data structure / code in target/arm/machine.c to represent
>> "this register needs some special handling", where the special
>> handling might be:
>>  - ignore if present in input
>>  - if present in input, value must be X, otherwise fail
>>    migration
>>  - maybe some other things if we need them
>>
>> and this is not tied to specific QEMU machine versions and
>> isn't something we expose via QOM properties.
>>
>> I'd rather avoid the "hidden" register idea unless we
>> definitely need it in addition to "ignore in incoming data".
>>
>> thanks
>> -- PMM


