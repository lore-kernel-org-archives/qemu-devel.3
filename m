Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB5BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPUJe-00020f-FF; Thu, 04 Jul 2024 17:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPUJb-0001zs-VU
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:48:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPUJO-0006U0-UE
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:48:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so6881295ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720129697; x=1720734497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UXdXNrzXHs1jAxaiZC3oyN3h2LVQFfAai4/0LTZpJeQ=;
 b=D6is066qetXFxoKcaIbRy4egePaY4+F3y2l6wrJrgUY7kss71Z7GFiHbEyNJglHjaY
 TFPuJdC7gPS1z1mDxdWjAp1yCUWhJ7lNLUV3kWgVrJOENnd4tdAMIb4VjvtB5MkO80xG
 FPPxviny3Wl268TS7GEvNs99DO1N5vi963cGrceeLmMKy0P/n8+IGpiM4vNDQMLYLARX
 j7uAjM05YTr2Du06FEUBcgzxBOQ52pYBS5bDxUhHcs5CrOjWhcmiaNrVVddvEjSiByoU
 +AjljVfwNrCV8Hm6/BBPz/Eq3vimLK7FxNssP9CwmIY+JE4kKqL7Z0tUu4ZfDCdTRTeh
 NjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720129697; x=1720734497;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UXdXNrzXHs1jAxaiZC3oyN3h2LVQFfAai4/0LTZpJeQ=;
 b=uYQlSOjGAsKWqOSrOLwsefZEJCcsEMJ7MxLewHrY9GdAPijVmRYBseacAKgzlcnx+2
 J+3iX9p9IEX4Ukn3aNkevaiYTnlxblBpPNknJ3+dXwMGg9OmbscADXzkMNegjZD+2pJE
 MjRh6vVm9CYFd4KRexQ0+j4llRyV6gdg81L3Y/WiSpFPSgXnoFjQ7n/s+bmLC1Amuwj+
 lT2juiRT3BkZEjQsauNk7z3gSYQmcylxM7QRPBOeQLDgIMn29nB3J7lshUH953X6IQYN
 XdaI3sAp8FjwcQ7Ip+4QFkbV3JpSFgk6AzWTqMyKJNM0Y4xjkMwrx49OHjQB5Fn10Gsq
 bZ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMsybUQTyL7/WND5oExVr51FI0Sm6fFjlJE28+BeTty/X4l/gwB1Xxrrtc9P79teDzXQYte2gH3V3RfRMPP7H98FB4IzQ=
X-Gm-Message-State: AOJu0YyeNQXWJMssQPVhiPfpbD49fMD45P7jYF4M+CVhS0EiQNdMM5yS
 aRX6QRBBUoRLmckRfssGdt8ITQZsOPvTyL5gRfEbJymneO0oCngdnEWD67Gtg1mEcwiCWm9TKwC
 P
X-Google-Smtp-Source: AGHT+IHmhPr1jUdZhcbQUQ+TBnVSPq6XqApMncpA5qxcDC7Ou8x7epxeapxz6esvZGv/pOr/HRM0Ng==
X-Received: by 2002:a17:903:110e:b0:1fb:167e:fb15 with SMTP id
 d9443c01a7336-1fb33f218fbmr21733495ad.64.1720129696792; 
 Thu, 04 Jul 2024 14:48:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb2eb50710sm22600315ad.201.2024.07.04.14.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 14:48:16 -0700 (PDT)
Message-ID: <426dbf1d-cfa8-4fd4-b857-8b8a283dd55e@linaro.org>
Date: Thu, 4 Jul 2024 14:48:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
From: Richard Henderson <richard.henderson@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, david@redhat.com,
 balaton@eik.bme.hu
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
 <13b19a4859e25274d05663bc0ca05621c56af985.camel@linux.ibm.com>
 <9fe81eeb-473a-4ffb-ad6f-f93e40283e8a@linaro.org>
Content-Language: en-US
In-Reply-To: <9fe81eeb-473a-4ffb-ad6f-f93e40283e8a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/4/24 08:18, Richard Henderson wrote:
> On 7/4/24 07:50, Ilya Leoshkevich wrote:
>> On Tue, 2024-07-02 at 16:41 -0700, Richard Henderson wrote:
>>> While looking into Zoltan's attempt to speed up ppc64 DCBZ
>>> (data cache block set to zero), I wondered what AArch64 was
>>> doing differently.  It turned out that Arm is the only user
>>> of tlb_vaddr_to_host.
>>>
>>> None of the code sequences in use between AArch64, Power64 and S390X
>>> are 100% safe, with race conditions vs mmap et al, however, AArch64
>>> is the only one that will fail this single threaded test case.  Use
>>> of these new functions fixes the race condition as well, though I
>>> have not yet touched the other guests.
>>>
>>> I thought about exposing accel/tcg/user-retaddr.h for direct use
>>> from the targets, but perhaps these wrappers are cleaner.  RFC?
>>>
>>>
>>> r~
>>>
>>>
>>> Richard Henderson (2):
>>>    accel/tcg: Introduce memset_ra, memmove_ra
>>>    target/arm: Use memset_ra, memmove_ra in helper-a64.c
>>>
>>>   include/exec/cpu_ldst.h            | 40 ++++++++++++++++
>>>   accel/tcg/user-exec.c              | 22 +++++++++
>>>   target/arm/tcg/helper-a64.c        | 10 ++--
>>>   tests/tcg/multiarch/memset-fault.c | 77
>>> ++++++++++++++++++++++++++++++
>>>   4 files changed, 144 insertions(+), 5 deletions(-)
>>>   create mode 100644 tests/tcg/multiarch/memset-fault.c
>>
>> This sounds good to me.
>>
>> I haven't debugged it, but I wonder why doesn't s390x fail here.
>> For XC with src == dst, it does access_memset() -> do_access_memset()
>> -> memset() without setting the RA. And I don't think that anything
>> around it sets the RA either.
> 
> s390x uses probe_access_flags, which verifies the page is mapped and writable, and raises 
> the exception when it isn't.  In contrast, for user-only, tlb_vaddr_to_host *only* 
> performs the guest -> host address mapping, i.e. (addr + guest_base).

I should clarify: probe_access_flags verifies that the page is mapped *at that moment*, 
but does not take the mmap_lock.  So the race is that the page can be unmapped by another 
thread after probe_access_flags and before the memset completes.


r~


