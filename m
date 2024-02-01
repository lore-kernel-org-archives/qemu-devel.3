Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8198EC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVcFN-0005LV-IT; Thu, 01 Feb 2024 13:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVcFL-0005IY-JQ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:57:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVcFF-0004ik-IT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:57:11 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso11483245e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 10:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706813821; x=1707418621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhLDjG81/ovcY8yRJE8mXgATcxNb7RC9wXi5FRI4Atw=;
 b=iomTcs4b4jOR3eREBIr4DV32h0KnQ32Y+vgb8c24VDzdOT7//V/SRJ5MBSha9Ip9bs
 O/9omnX/TK9BfNnffcdS5h2PS3RoG4aMVDNt1JEIYqx6EBcTH3c/yl7WVd+J/c/YcmKW
 MiffAWC/lO2Q6BpHaJu5iT1fuUhK9D5J+embEudVtM2dFUSum+ZKOJ343UzqSpDNLr+z
 9EWXXeRwTI3SQZew5d+bDdJkwjl6U1SbBghbB/2MrRTFCUB+veGpzVIh13n3aDxVA1Yw
 LenEhRVDtAdiz9i++pSnM5tJN1M97OJoEeTA3zUutLip/9dyECZnkLQ3fu5G90VoqXvX
 9JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706813821; x=1707418621;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OhLDjG81/ovcY8yRJE8mXgATcxNb7RC9wXi5FRI4Atw=;
 b=IBMvZkGUEKJWsktBeYjmFb+kfE/OhoonxfLKBy8gIOkcp09rUapvsdrOF2Jp2y4PCr
 4hztF6TPAaZZ6D62CwoSoc/9u7+MTFTgnZRTHUEAJjFvvjB1ihfCmDgifQPOmgGN46MT
 dTkEvBdeBInrwf1TGdJUnXjgXlrv4xNcq7iAFLykxfocgq6N50FIRYJ++ug1ShyifCZ5
 tBf/WDy4eBUzyo9qBv0xTRBckyC5aLkWWwNeR9us3CNlv9wQs986BIHIi/uy16/vllZF
 l3hb/H52OBgpzoIHmxPnsKmXHGaL40jGMOM2kMcI1ToUEsVRhC7DwHXkwjkrpWRiKwCN
 Ypdw==
X-Gm-Message-State: AOJu0YyB5Y0sC+jkp2I4s+3U62XIJgJYloReBXHN1KqAcBX/45fL4Pkg
 bEwKdiT9E71qToIqdsgAYd5W3cZPGxdv/243l8R5Tdtp52xB3gZ9UnCoOETKBRU=
X-Google-Smtp-Source: AGHT+IH80KnwT5gxIbxzYss0X18Cpg6rCWGayEYNS/LRGEdnQGyT14Oh39/X0bp1JbAKToPQVs09ag==
X-Received: by 2002:a05:600c:1d09:b0:40e:61d4:5d3b with SMTP id
 l9-20020a05600c1d0900b0040e61d45d3bmr5584201wms.20.1706813821200; 
 Thu, 01 Feb 2024 10:57:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXHChzsBOgQsj3Hcz1Olw+g2tJ62QjElptVbb5fn6zNv2cWbrh4nVsmH4GAZYH2rwbIhoPPjlMwjOfEBMNLcY9LPHpm6d6prtw8ZNfMgSFypBBAM1RL/2uwfrCD1mfpQyy2Av2+ZytQMgfnJDwWJ2+VHE2eTHvF5smvIgCY0M8j3H4Ngp0+WFgclUSOj9wuD5eI7/aUxlr61COegGRcRRi62e1EMMCMMoZC9j+KSEV32LeynmGWj2fEXW2+f0eVYO9Pjo5CqZrm6Lo+Qd0DLfSZAaNaynknzlJoh+mIL0zLX4fLrC9hn9qdWkeKODpx4pQ9rchUmBBK1uPXM1DnCNFIT8rvHf43rM5IsuDB4ESeQeV7MUyaoxGafBqJKIpJ2y0NPJXg1JkbmDSK0KmrvCC1FqqNGzdGOOqqYc45pbCzIchKme2NYfP3HT7POXoqgTRj2ikTdhYe11sizbA3jSS2gR8DwJVFgNwaZrBH9nngtB8rRpsOlHVtjSm0cFrCOIXjopLlDjjVOLkHisnwwsF9ESvOXTS204ORKZMzXTgbVdrXUUm10zpRivG97r2O8599w67KXKvFhYghnMC2lwm4WQJeDQ2Qj6FwjuMqJgCoou07JXdtslcK+Oe1oAESvcmAqGL/pKGvmMOwmA==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z12-20020a05600c220c00b0040fbe0ad3efsm328945wml.45.2024.02.01.10.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 10:57:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DEE75F7AF;
 Thu,  1 Feb 2024 18:57:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: stefanha@gmail.com,  Alistair Francis <Alistair.Francis@wdc.com>,
 dbarboza@ventanamicro.com,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 afaria@redhat.com,  eperezma@redhat.com,  gmaglione@redhat.com,
 marcandre.lureau@redhat.com,  rjones@redhat.com,  sgarzare@redhat.com,
 imp@bsdimp.com,  philmd@linaro.org,  pbonzini@redhat.com,
 thuth@redhat.com,  danielhb413@gmail.com,  gaosong@loongson.cn,
 akihiko.odaki@daynix.com,  shentey@gmail.com,  npiggin@gmail.com,
 seanjc@google.com,  Marc Zyngier <maz@kernel.org>
Subject: Re: Call for GSoC/Outreachy internship project ideas
In-Reply-To: <mhng-ec5f9ea7-e704-4302-8542-c8c36ea979d8@palmer-ri-x1c9a>
 (Palmer Dabbelt's message of "Thu, 01 Feb 2024 10:01:13 -0800 (PST)")
References: <mhng-ec5f9ea7-e704-4302-8542-c8c36ea979d8@palmer-ri-x1c9a>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 18:57:00 +0000
Message-ID: <87frycj9mr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Palmer Dabbelt <palmer@dabbelt.com> writes:

> On Thu, 01 Feb 2024 09:39:22 PST (-0800), alex.bennee@linaro.org wrote:
>> Palmer Dabbelt <palmer@dabbelt.com> writes:
>>
>>> On Tue, 30 Jan 2024 12:28:27 PST (-0800), stefanha@gmail.com wrote:
>>>> On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrot=
e:
>>>>>
>>>>> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
>>>>> > Dear QEMU and KVM communities,
>>>>> > QEMU will apply for the Google Summer of Code and Outreachy interns=
hip
>>>>> > programs again this year. Regular contributors can submit project
>>>>> > ideas that they'd like to mentor by replying to this email before
>>>>> > January 30th.
>>>>>
>>>>> It's the 30th, sorry if this is late but I just saw it today.  +Alist=
air
>>>>> and Daniel, as I didn't sync up with anyone about this so not sure if
>>>>> someone else is looking already (we're not internally).
>> <snip>
>>>> Hi Palmer,
>>>> Performance optimization can be challenging for newcomers. I wouldn't
>>>> recommend it for a GSoC project unless you have time to seed the
>>>> project idea with specific optimizations to implement based on your
>>>> experience and profiling. That way the intern has a solid starting
>>>> point where they can have a few successes before venturing out to do
>>>> their own performance analysis.
>>>
>>> Ya, I agree.  That's part of the reason why I wasn't sure if it's a
>>> good idea.  At least for this one I think there should be some easy to
>>> understand performance issue, as the loops that go very slowly consist
>>> of a small number of instructions and go a lot slower.
>>>
>>> I'm actually more worried about this running into a rabbit hole of
>>> adding new TCG operations or even just having no well defined mappings
>>> between RVV and AVX, those might make the project really hard.
>>
>> You shouldn't have a hard guest-target mapping. But are you already
>> using the TCGVec types and they are not expanding to AVX when its
>> available?
>
> Ya, sorry, I guess that was an odd way to describe it.  IIUC we're
> doing sane stuff, it's just that RISC-V has a very different vector
> masking model than other ISAs.  I just said AVX there because I only
> care about the performance on Intel servers, since that's what I run
> QEMU on.  I'd asssume we have similar performance problems on other
> targets, I just haven't looked.
>
> So my worry would be that the RVV things we're doing slowly just don't
> have fast implementations via AVX and thus we run into some
> intractable problems.  That sort of stuff can be really frusturating
> for an intern, as everything's new to them so it can be hard to know
> when something's an optimization dead end.
>
> That said, we're seeing 100x slowdows in microbenchmarks and 10x
> slowdowns in real code, so I think there sholud be some way to do
> better.

It would be nice if you could convert that micro-benchmark to plain C
for a tcg/multiarch test case. It would be a useful tool for testing
changes.

>
>> Remember for anything float we will end up with softfloat anyway so we
>> can't use SIMD on the backend.
>
> Yep, but we have a handful of integer slowdowns too so I think there's
> some meat to chew on here.  The softfloat stuff should be equally slow
> for scalar/vector, so we shouldn't be tripping false positives there.
>
>>>> Do you have the time to profile and add specifics to the project idea
>>>> by Feb 21st? If that sounds good to you, I'll add it to the project
>>>> ideas list and you can add more detailed tasks in the coming weeks.
>>>
>>> I can at least dig up some of the examples I ran into, there's been a
>>> handful filtering in over the last year or so.
>>>
>>> This one
>>> <https://gist.github.com/compnerd/daa7e68f7b4910cb6b27f856e6c2beba>
>>> still has a much more than 10x slowdown (73ms -> 13s) with
>>> vectorization, for example.
>>>
>>>> Thanks,
>>>> Stefan
>>
>> -- Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

