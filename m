Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51FC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVb28-0003oZ-D5; Thu, 01 Feb 2024 12:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVb26-0003oQ-LK
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:39:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVb24-0003bP-S1
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:39:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40ef6da20feso7153085e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706809163; x=1707413963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzoZDvDII/Op/k856KqiHsOD8jArS3pDpqkAcYGo0Nw=;
 b=sB1kOSOxzX3bpEJZpkmUaNAA7PzqP4QF4H1udPSrD9BwrROqCgL8cwuvyT00JaBUDr
 wr/Cl9Wp5ZK5/kOfYjZ9u5WB6Pe+yEDTx9zjTjImHxA58sT4VNUt0w8Y4x/vfQnxjtP3
 nH1lEXVU6ml9z4zq/25OeMIy4DGti4IxL7GR0a5lNn89qCy3PxHqQHa+ldoi0BNDI1F7
 kI8WSvTTHmY54t/LtVcSLDqR8Q+Z3oImzdvu9QqcnH2m997SnKstQOKUnaANFtPuuyZu
 FBBXuFI+tl1DOG9eI5XhKaZC++GarzecJv6y1p5O1sJcfYu+tItBHheq8wP54CN20Ldp
 iqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706809163; x=1707413963;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzoZDvDII/Op/k856KqiHsOD8jArS3pDpqkAcYGo0Nw=;
 b=R1EIAJBrJcPLoZU2Z9DuIAll6eAlkepVo0AzOq/wmOY07kHDsusFNHRpsh0pVBXAFg
 b2etSBqUgPqblWOhiFitjcKaAvtli1lPQjuvkxbzCdO5dbdp/ZigKN2rnxnsUrd/WE5t
 rmpynH/UEbv+xv6zqs6wXyOuuUl5zgf5jS6Vn9ORoMoRNxEn9bC9vTKvxvHuKZ9XPI8Q
 V2ZIBt9KOpnoyzxoBY7vFP9cQPaKJM4qF7RuAdkae9BF62ol8NzzeiJnGjO5RShEkWGs
 +izxMU4iMCyVdZnGzX7RWzmiLZfb5BCrXi91pof3Bw2vVuMszXGmQpRdEVy71ODuJha4
 sfMA==
X-Gm-Message-State: AOJu0Yzr+QvKOPM1Icce9T9cISAPa/z3E09e1oaczV+Y60cl4Sej5oDI
 s6cHQhanAdYxOSaheEHF7MFHh84g6qUrp/TzTOckMHaD1XZ0b+IB8fBbSUF0BxM=
X-Google-Smtp-Source: AGHT+IEtGiborKIfQbJLWBuCUv3huaGcPbA7q0BWb9JZD3oxvCoNvcOtJRpS2hpUEL26RpAa9e6Xkw==
X-Received: by 2002:a05:600c:1c0a:b0:40e:e8e3:40c2 with SMTP id
 j10-20020a05600c1c0a00b0040ee8e340c2mr8118047wms.12.1706809163021; 
 Thu, 01 Feb 2024 09:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVOcVhgl2NT50x2K+iQRLmWZxW6bkz8eMXCrH2OwknGbH9+8scUaFH+cL7tVOQm48Uf2NvmOwxUIKNn1dIsfgqPw8b2/vZZAVDYDLvoVmmKo3xv8LeZYL6jxy6ARvrkem9jVY3EPVCwFzEGHl4WBKK2SVWVRKFfv41N99SCs5i0SXqkBSUI+1e+Ewg/xtC3wRtBI3miu+abWrpvw8/nHHeqYKOG3NXSQsEgPPFAHzOJaRZv/tTGgO52v3Zu/XacebJd9xzgvm7Z3DwwOWiWYd35uQp/bqPYtOU4zzFK6LxucK7I3N+1QZypAVgJ408LmgRQ3iU4NwxlqH4B6+Z8n1ZbBYFIoz+AX0JTjl6v8n0n6rCKKr49WCZBKnhU93ngVwzqMnnJozvvHsHFXtiMMdYbmq1C+JwGHUKpEX7GIr1P8gB5PWtEGmvMO7t+tjTd71C7+rwZzdCMrQdEQIAs+C6nsh24NOWIqfQx6zEVup2jeaeUQXK2DZRijyLfsqumNFnFMQanhb44SRxDNuwj6I0Lv69SYccZLbPyBLC+SGH8uaBcViwNlJXewA5ybtYHCRurYNYU94jMq9EyuytWWl6QrV6pApWDllnpp+n3AzUiEVBJCorGnN3LisRKwbkeTNwC8nL2RyCq97/mPg==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c510700b0040e880ac6ecsm5096977wms.35.2024.02.01.09.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 09:39:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50CBE5F7AF;
 Thu,  1 Feb 2024 17:39:22 +0000 (GMT)
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
In-Reply-To: <mhng-e7014372-2334-430e-b22e-17227af21bd9@palmer-ri-x1c9a>
 (Palmer Dabbelt's message of "Tue, 30 Jan 2024 16:29:34 -0800 (PST)")
References: <mhng-e7014372-2334-430e-b22e-17227af21bd9@palmer-ri-x1c9a>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 17:39:22 +0000
Message-ID: <87le84jd85.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

> On Tue, 30 Jan 2024 12:28:27 PST (-0800), stefanha@gmail.com wrote:
>> On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>>
>>> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
>>> > Dear QEMU and KVM communities,
>>> > QEMU will apply for the Google Summer of Code and Outreachy internship
>>> > programs again this year. Regular contributors can submit project
>>> > ideas that they'd like to mentor by replying to this email before
>>> > January 30th.
>>>
>>> It's the 30th, sorry if this is late but I just saw it today.  +Alistair
>>> and Daniel, as I didn't sync up with anyone about this so not sure if
>>> someone else is looking already (we're not internally).
<snip>
>> Hi Palmer,
>> Performance optimization can be challenging for newcomers. I wouldn't
>> recommend it for a GSoC project unless you have time to seed the
>> project idea with specific optimizations to implement based on your
>> experience and profiling. That way the intern has a solid starting
>> point where they can have a few successes before venturing out to do
>> their own performance analysis.
>
> Ya, I agree.  That's part of the reason why I wasn't sure if it's a
> good idea.  At least for this one I think there should be some easy to
> understand performance issue, as the loops that go very slowly consist
> of a small number of instructions and go a lot slower.
>
> I'm actually more worried about this running into a rabbit hole of
> adding new TCG operations or even just having no well defined mappings
> between RVV and AVX, those might make the project really hard.

You shouldn't have a hard guest-target mapping. But are you already
using the TCGVec types and they are not expanding to AVX when its
available?

Remember for anything float we will end up with softfloat anyway so we
can't use SIMD on the backend.

>
>> Do you have the time to profile and add specifics to the project idea
>> by Feb 21st? If that sounds good to you, I'll add it to the project
>> ideas list and you can add more detailed tasks in the coming weeks.
>
> I can at least dig up some of the examples I ran into, there's been a
> handful filtering in over the last year or so.
>
> This one
> <https://gist.github.com/compnerd/daa7e68f7b4910cb6b27f856e6c2beba>
> still has a much more than 10x slowdown (73ms -> 13s) with
> vectorization, for example.
>
>> Thanks,
>> Stefan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

