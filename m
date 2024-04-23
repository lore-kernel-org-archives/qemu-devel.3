Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6422C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 16:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzIZm-0004nO-Ji; Tue, 23 Apr 2024 12:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bill.mills@linaro.org>)
 id 1rzIZk-0004kS-Ot
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:00:56 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bill.mills@linaro.org>)
 id 1rzIZi-0003dR-Aj
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:00:56 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b44071a07so49690186d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713888053; x=1714492853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QUXF0pbqPINBlWAL3oyQd0ZXBGy6HiUG13wz1FRP9pg=;
 b=e3WxsppzabUGtwSIrkp+Jxj2seXjbo6uxETvfh9X9Z3XJcbEoFFrXHYCKJydxyQkoA
 vav26T1IkqDTRm++jTu9UuFCmfFx8CDum2sHJfsmYTMLsPkHUE9EXtAUq7/WvXtSACJI
 NYQ9rEce8g/AkIE0Q+fyhAhcSkzRuZzaYfvYS5T5fcCGgF0zX1hiBfdzTL7uaF6neM8p
 7AZWOrOnd+N2pWAINoj8cryrOZ2NkiMHr09Tf53F3XkdWrOfM5L2KF7imo3/RsjO0DAl
 hWxQ7SGjjd8hQjzG2S0wLAsZkeRk+SkO6kcbQNqpnWWBHOCqYnC6/b3WMT+X6is9sJtQ
 dzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713888053; x=1714492853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QUXF0pbqPINBlWAL3oyQd0ZXBGy6HiUG13wz1FRP9pg=;
 b=HEGIPiBwG7MKiU0sl5q0Ei08SMAvjRHUXZJTj+vA6EBzN/ZdICMJShss6MP+k1GIaS
 dnoFvriIjFZT6nYwx1u5b3y/c0tMA4wgx4BWBwyr4kDV8+IeUurnkmm33e+IMawk876x
 ZNbu98o1t/rRb/nBcMDZrscDNK9ae9zH4hKbMgSrIxGVTdtX7iHm+/HaXofW7tcmSS8u
 bMtC+gG33QbnEsW9FvGH8cg24z4DoDsmNTDFFz6wLRrMHOkAsPUIPZCWnxVGFBNOGw/L
 dOb9+ClE9qskXXWgPQOE1wq0jkkNvg0b1vc1ArLxQ9kb+klxrOqDOysgd1ZvKOzwSkIZ
 3pvA==
X-Gm-Message-State: AOJu0YwtrT9AZUrZCn57X5mE3ReWxIk/J+YWg1s4jLtk3DnqiDb90d9q
 303xb0yV/dg3C4BVeB9FH1pCc17BYQMk/OLgI/A7acNWgePhfrPrqyi1052NsmQ=
X-Google-Smtp-Source: AGHT+IFHyYErQf67inmK+ur4lzrBBmXfVCID0ViuwnycAsaZ92iAIKWD0AY5tw4uOOU7fVDE46HlMg==
X-Received: by 2002:a0c:e58a:0:b0:6a0:582c:61a with SMTP id
 t10-20020a0ce58a000000b006a0582c061amr9791054qvm.55.1713888052666; 
 Tue, 23 Apr 2024 09:00:52 -0700 (PDT)
Received: from [192.168.2.7] (pool-72-83-14-124.washdc.fios.verizon.net.
 [72.83.14.124]) by smtp.gmail.com with ESMTPSA id
 ez4-20020ad45904000000b00690c77505bdsm4392053qvb.37.2024.04.23.09.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 09:00:51 -0700 (PDT)
Message-ID: <ecf04b2a-2038-43ac-a0bb-38d0baca7a7c@linaro.org>
Date: Tue, 23 Apr 2024 12:00:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add ivshmem-flat device
To: Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 lvivier@redhat.com, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 pbonzini@redhat.com, anton.kochkov@proton.me, richard.henderson@linaro.org,
 peter.maydell@linaro.org
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
 <87wmqp3xug.fsf@pond.sub.org>
 <a28f3657-c827-7a0d-a8da-b82d17d17577@linaro.org>
 <87sezc8irk.fsf@pond.sub.org>
Content-Language: en-US
From: Bill Mills <bill.mills@linaro.org>
In-Reply-To: <87sezc8irk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=bill.mills@linaro.org; helo=mail-qv1-xf29.google.com
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

Hi Markus,

On 4/23/24 6:39 AM, Markus Armbruster wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Hi Markus,
>>
>> Thanks for interesting in the ivshmem-flat device.
>>
>> Bill Mills (cc:ed) is the best person to answer your question,
>> so please find his answer below.
>>
>> On 2/28/24 3:29 AM, Markus Armbruster wrote:
>>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>>
>>> [...]
>>>
>>>> This patchset introduces a new device, ivshmem-flat, which is similar to the
>>>> current ivshmem device but does not require a PCI bus. It implements the ivshmem
>>>> status and control registers as MMRs and the shared memory as a directly
>>>> accessible memory region in the VM memory layout. It's meant to be used on
>>>> machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
>>>> lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
>>>> 'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
>>>> memory-constrained resource targets.
>>>>
>>>> The patchset includes a QTest for the ivshmem-flat device, however, it's also
>>>> possible to experiment with it in two ways:
>>>>
>>>> (a) using two Cortex-M VMs running Zephyr; or
>>>> (b) using one aarch64 VM running Linux with the ivshmem PCI device and another
>>>>       arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.
>>>>
>>>> Please note that for running the ivshmem-flat QTests the following patch, which
>>>> is not committed to the tree yet, must be applied:
>>>>
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html
>>>
>>> What problem are you trying to solve with ivshmem?
>>>
>>> Shared memory is not a solution to any communication problem, it's
>>> merely a building block for building such solutions: you invariably have
>>> to layer some protocol on top.  What do you intend to put on top of
>>> ivshmem?
>>
>> Actually ivshmem is shared memory and bi-direction notifications (in this case a doorbell register and an irq).
> 
> Yes, ivshmem-doorbell supports interrupts.  Doesn't change my argument.
> 
>> This is the fundamental requirement for many types of communication but our interest is for the OpenAMP project [1].
>>
>> All the OpenAMP project's communication is based on shared memory and bi-directional notification.  Often this is on a AMP SOC with Cortex-As and Cortex-Ms or Rs.  However we are now expanding into PCIe based AMP. One example of this is an x86 host computer and a PCIe card with an ARM SOC.  Other examples include two systems with PCIe root complex connected via a non-transparent bridge.
>>
>> The existing PCI based ivshmem lets us model these types of systems in a simple generic way without worrying about the details of the RC/EP relationship or the details of a specific non-transparent bridge.  In fact the ivshmem looks to the two (or more) systems like a non-transparent bridge with its own memory (and no other memory access is allowed).
>>
>> Right now we are testing this with RPMSG between two QEMU system where both systems are cortex-a53 and both running Zephyr. [2]
>>
>> We will expand this by switching one of the QEMU systems to either arm64 Linux or x86 Linux.
> 
> So you want to simulate a heterogeneous machine by connecting multiple
> qemu-system-FOO processes via ivshmem, correct?

An AMP SOC is one use case.  A PCIe card with an embedded Cortex-M would 
be another.

> 
>> We (and others) are also working on a generic virtio transport that will work between any two systems as long as they have shared memory and bi-directional notifications.
> 
> On top of or adjacent to ivshmem?
> 

On top of ivshmem.  It is not the only use case but it is an important one.

I just gave a talk on this subject at EOSS.  If you would like to look 
at the slides they are here:
https://sched.co/1aBFm

Thanks,
Bill

>> Now for ivshmem-flat.  We want to expand this model to include MCU like CPUs and RTOS'es that don't have PCIe.  We focus on Cortex-M because every open source RTOS has an existing port for one of the Cortex-M machines already in QEMU.  However they don't normally pick the same one.  If we added our own custom machine for this, the QEMU project would push back and even if accepted we would have to do a port for each RTOS.  This would mean we would not test as many RTOSes.
>>
>> The ivshmem-flat is actually a good model for what a Cortex-M based PCIe card would look like.  The host system would see the connection as PCIe but to the Cortex-M it would just appear as memory, MMR's for the doorbell, and an IRQ.
>>
>> So even after we have a "roll your own machine definition from a file", I expect ivshmem and ivshmem-flat to still be very useful.
>>
>> [1] https://www.openampproject.org/
>> [2] Work in progress here: https://github.com/OpenAMP/openamp-system-reference/tree/main/examples/zephyr/dual_qemu_ivshmem
> 

-- 
Bill Mills
Principal Technical Consultant, Linaro
+1-240-643-0836
TZ: US Eastern
Work Schedule:  Tues/Wed/Thur

