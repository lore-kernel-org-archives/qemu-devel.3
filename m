Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E80CC48BF0
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbNK-00027V-FZ; Thu, 01 Feb 2024 13:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rVbNI-00025C-44
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:01:20 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rVbNE-0002FE-3z
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:01:18 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so1038455a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 10:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706810474; x=1707415274;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=a6iCiiJEkCihp55oAEAEl5G/BiNyoF0zUrNoSz0w21Q=;
 b=FdLcBubFv8plwFFeFZ/unso+bWl8HFIq2ioGu+rmQ0s1jtJn35qqvEB0XPWxoF0XJt
 9XvnHbVN8W06KQWc9+ZyRDSiIFtst6WogySYVjiYaKSK9aCAuV/R7WBROPDig/HlHcs+
 WxtNCVN+giaXbXS00d60W/z2a2zmpPpnj0m+E97XBE1piS0QHZnlChbBpOQT3AImdEBj
 9pxJWKXCPAKEY/dX8VhJOI3zHoWNAKgzaQ8myb/6n/AkGXSy+J3SxthxWgqGZovSLKbg
 HVBsYoqc238OlrUPqGom0q5/MBA3h6CFBArZmhTFM9KcJuYr2cXQsGrJEQXc+7QddHoP
 Ul1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706810474; x=1707415274;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6iCiiJEkCihp55oAEAEl5G/BiNyoF0zUrNoSz0w21Q=;
 b=CYL6lwPyN4dpQP+dA5pcWkkAz6+kX/zyFeY0fCHU2rE+1JRCt4HWn1FqQo6p2NLyN0
 FBnfYKjqRJI6hlWvFADhqKaVrYSGiBFakvWlbpUxWP4MhMrB+cqntGeVdG0axrCX8exT
 tS4dkSUA/35ZvXRBolSGLDRH+MEfi37KsySyKUeJ0dilmy/kuF0darSidk/A9N5bm9iN
 2Joi5yHNEXGh4J6c7tHRrcdwwO4jPBzzwej2DDiXnzCj7ora3Ijv5NfjkKfxuOrlU+iy
 g9NfjTU7u/QkxjGPQCbSHcoS2TbZ00aTRQl4pMFZad4uIrfWEvdK/WvJSOaA1nNtg7Fe
 otJA==
X-Gm-Message-State: AOJu0YyQh3Y2AkmwaS7ZIZm+JN1V0qUUqtt2kvcD65KUtOLdsFYZ7g/m
 etUBEvHAsbXF7bscAQIfV9cAKQj/wzdaIqBLVFNDeJOBfLRmr7+1OFyr9r7x1NE=
X-Google-Smtp-Source: AGHT+IF15aCA64A+pUYtrNvn3aPBFP3YvRRtEpAp7GhLaGBTwkos6AGRBMomIaVUMVTpq99RCQfFMQ==
X-Received: by 2002:a17:90a:bc89:b0:293:d87e:c0fa with SMTP id
 x9-20020a17090abc8900b00293d87ec0famr3127352pjr.17.1706810473841; 
 Thu, 01 Feb 2024 10:01:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVLFmKNxnofRAm9+gmbtAPqzFlddhJuk3PI7Q/NjyXtJ7ZmHp/iTXv0TqfWfZjBaYzFcJopyG/9CDE+R+Jvvm0AZE2oEp2H1XiQOasKu+bdMsINxyBmBY5jTw58tvIpPgG+8pFfE4REHtX6JYC4f0MnquUQN2FJgHlWUglZqdX0AAutrjhomLn4WOttNBDZowK8M6oTDpJIKMK5zEL7B57m8l2DzdVPdCvNWBdNIiiJJpTqImLPcPjW1TVcA+i/QJ+Smow81am9Ta9fUe93MosSLs3u5DtSGA71RgmAo0rrseQVq4kPrBBAL0YwWtv87oLFn0jnKEYoDs/3013pcUBUSS1NOLxp/ILGeAvZ8CtLkHexM/zGg2zr3jqNiiyjXNuFTOwvY7CH857u5/m6eEZC4kBw+4isj41JIR5jioNJPtspftVQDzfP51ZYtxZJvdJd1G/n1LmyzTdmgDM5DCZYxDVbq7r21JeY+DbRZ9cDGnbcC80C+Dq1YyM1TrSNFLrGFjr4cn4CPrY/V9vyNQTBRhdzHLpuJwBz3zxXJlwPr0XZN2BEmMZgokwZxh+BZVCbuy2MQwBBdL4evAMOsvE007/KWpdqC+Ehpyr8KJ5Stk4roUjeT1/2UPsSMDH/dPqhrm/ODu25Q02BsA==
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 w20-20020a17090aea1400b00295f2cb67d1sm3326389pjy.16.2024.02.01.10.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 10:01:13 -0800 (PST)
Date: Thu, 01 Feb 2024 10:01:13 -0800 (PST)
X-Google-Original-Date: Thu, 01 Feb 2024 10:01:10 PST (-0800)
Subject: Re: Call for GSoC/Outreachy internship project ideas
In-Reply-To: <87le84jd85.fsf@draig.linaro.org>
CC: stefanha@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 dbarboza@ventanamicro.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 afaria@redhat.com, 
 eperezma@redhat.com, gmaglione@redhat.com, marcandre.lureau@redhat.com,
 rjones@redhat.com, 
 sgarzare@redhat.com, imp@bsdimp.com, philmd@linaro.org, pbonzini@redhat.com,
 thuth@redhat.com, 
 danielhb413@gmail.com, gaosong@loongson.cn, akihiko.odaki@daynix.com,
 shentey@gmail.com, 
 npiggin@gmail.com, seanjc@google.com, Marc Zyngier <maz@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex.bennee@linaro.org
Message-ID: <mhng-ec5f9ea7-e704-4302-8542-c8c36ea979d8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=palmer@dabbelt.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 01 Feb 2024 09:39:22 PST (-0800), alex.bennee@linaro.org wrote:
> Palmer Dabbelt <palmer@dabbelt.com> writes:
>
>> On Tue, 30 Jan 2024 12:28:27 PST (-0800), stefanha@gmail.com wrote:
>>> On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>>>
>>>> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
>>>> > Dear QEMU and KVM communities,
>>>> > QEMU will apply for the Google Summer of Code and Outreachy internship
>>>> > programs again this year. Regular contributors can submit project
>>>> > ideas that they'd like to mentor by replying to this email before
>>>> > January 30th.
>>>>
>>>> It's the 30th, sorry if this is late but I just saw it today.  +Alistair
>>>> and Daniel, as I didn't sync up with anyone about this so not sure if
>>>> someone else is looking already (we're not internally).
> <snip>
>>> Hi Palmer,
>>> Performance optimization can be challenging for newcomers. I wouldn't
>>> recommend it for a GSoC project unless you have time to seed the
>>> project idea with specific optimizations to implement based on your
>>> experience and profiling. That way the intern has a solid starting
>>> point where they can have a few successes before venturing out to do
>>> their own performance analysis.
>>
>> Ya, I agree.  That's part of the reason why I wasn't sure if it's a
>> good idea.  At least for this one I think there should be some easy to
>> understand performance issue, as the loops that go very slowly consist
>> of a small number of instructions and go a lot slower.
>>
>> I'm actually more worried about this running into a rabbit hole of
>> adding new TCG operations or even just having no well defined mappings
>> between RVV and AVX, those might make the project really hard.
>
> You shouldn't have a hard guest-target mapping. But are you already
> using the TCGVec types and they are not expanding to AVX when its
> available?

Ya, sorry, I guess that was an odd way to describe it.  IIUC we're doing 
sane stuff, it's just that RISC-V has a very different vector masking 
model than other ISAs.  I just said AVX there because I only care about 
the performance on Intel servers, since that's what I run QEMU on.  I'd 
asssume we have similar performance problems on other targets, I just 
haven't looked.

So my worry would be that the RVV things we're doing slowly just don't 
have fast implementations via AVX and thus we run into some intractable 
problems.  That sort of stuff can be really frusturating for an intern, 
as everything's new to them so it can be hard to know when something's 
an optimization dead end.

That said, we're seeing 100x slowdows in microbenchmarks and 10x 
slowdowns in real code, so I think there sholud be some way to do 
better.

> Remember for anything float we will end up with softfloat anyway so we
> can't use SIMD on the backend.

Yep, but we have a handful of integer slowdowns too so I think there's 
some meat to chew on here.  The softfloat stuff should be equally slow 
for scalar/vector, so we shouldn't be tripping false positives there.

>>> Do you have the time to profile and add specifics to the project idea
>>> by Feb 21st? If that sounds good to you, I'll add it to the project
>>> ideas list and you can add more detailed tasks in the coming weeks.
>>
>> I can at least dig up some of the examples I ran into, there's been a
>> handful filtering in over the last year or so.
>>
>> This one
>> <https://gist.github.com/compnerd/daa7e68f7b4910cb6b27f856e6c2beba>
>> still has a much more than 10x slowdown (73ms -> 13s) with
>> vectorization, for example.
>>
>>> Thanks,
>>> Stefan
>
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro

