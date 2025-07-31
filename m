Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB32C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZkM-0005dn-2k; Thu, 31 Jul 2025 16:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhY2s-00080p-M9
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:30:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhY2q-0004KU-24
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:30:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bc55f6612so1241650b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753986621; x=1754591421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+t1EESDFAbGOqAdEQWLaXG6wL7K4P09+fmZeZbGBSg=;
 b=rldRbzaDQHeX+3JsJjilsIvaE80iw9aDHyK9lsh04RIBwGVz8jbH9DlkhRDFMiqvUq
 gyF9Ae4E1jqt4xNF/A0/mjDrSq+A2XEUF5SbOnfEZU8qbgG1+UEAl5iEDR3Fr/HscNDd
 MgOzqtVnPSa3eRQjK2SwucEroL+a3ZE5YA2d1+9TbWHrvHTZhEE9+TnukUrZtjlQIo0N
 7JE69GcpkGaCnmntOzViVmA+KpgvIGBoczSTLL1a+dK7u6BP51OvAEtsgSTE46Uh+HKK
 stUqFdPL7wytPa8x2q8veHckpiDx7sZKdAYKR5D6e94kbvu+5XEmEk7b44y8bEXnA8EB
 owhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753986621; x=1754591421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B+t1EESDFAbGOqAdEQWLaXG6wL7K4P09+fmZeZbGBSg=;
 b=prUYAQnOy4bAh7D+0C+PZhqejZUydph5+7V1swjuLPNrujQzgnl82to9nwhuZpyHwz
 ciP24epyXFlrgrm6i2wIjcnCilVfXc7PEJXj8devjCV+Ept3TaSmRhfR0FpjbZFZf0cG
 uaoeaMRLsuD5o+t80Q+bLPZMIj9zQMBI6b3xy8SK3HrTXILZM3OXgnoVnJNMFfNh/QVX
 zJiahZFpun/oYdEIVORGtO8tBZCo1mUO+mU07LVlaeVS5zX3G1zcitl7uO1KxZ9PgEkA
 sfSX1Rc/Vjx9y+4NH+ZakE0OGExeHD0IEwukk5+5FqsT2Q/1U2NW86C0Aq5ylMEqEgio
 yBHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAQ0N82HbRJhtp7zVE98oGWV9eEZGjYk/iKZRxQvs3Gg32URPh30iGqH8dTkRx1w7LXHLyqwgXx7YR@nongnu.org
X-Gm-Message-State: AOJu0YzD0nWZqBFDQzD8LTfjEy9HmBtE4zfjHXYBafPbDpCyyYjlk/Ng
 72tvmGsXrsVnEiIk3KYtT5U9JeIzDSc7/wc4q7XvdzopXOWFFunWnxrGqG+Gc/8u11o=
X-Gm-Gg: ASbGncvcXFlOUjU6iqNIUu1d5loWdCRR5IcmY9VBwJS7xRcp7Mub+FShzwgIO+pa8H5
 mMrRckqPPDx2s2pcnRZEZWeqlB5WhSlZ4SxsI3Stl9GzM8X1NhnK5JLUW42g+q4/QP4r4yu2UyT
 fhsuO7zhCkzGfv4HRE3IDk1QY69nfqXO0qItHtdbCUy9SNLaF3V6GKmKAkt1Bv7n3s5S8xiNtgy
 0wicYr20qZg2Qpk7ed7eqrx1apI0tpYlrAhd22cWLIdKBvvoaPeunV/ZndZ7ej4Sj9G/FI2r80z
 CYBmPWRXQEEZkAG3UzxCt2CDz0+junBYPKM8nK0wzqwZxRz5PCFkF6JZ9x6V2vpypJhg1uEl+C0
 2BjPlUDa4FOfc67XSPXDyLo5htnbSgmi+VEw=
X-Google-Smtp-Source: AGHT+IFRNdkBVeQRtr/IbDbG8Y6h9rmkiWtkGEkY3lZz9y2BXurDo+SC2a9hE+V2Ahu9VWIAVap5OQ==
X-Received: by 2002:a05:6a00:2382:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-76bcd398e77mr3946064b3a.11.1753986620990; 
 Thu, 31 Jul 2025 11:30:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfea38csm2203147b3a.128.2025.07.31.11.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 11:30:20 -0700 (PDT)
Message-ID: <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
Date: Thu, 31 Jul 2025 11:30:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/31/25 9:23 AM, Peter Maydell wrote:
> On Mon, 28 Jul 2025 at 20:34, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> This old commit (7702e47c2) was the origin of having interrupt related
>> code in a generic folder, but I don't really understand the rationale
>> behind it to be honest. It seems to be an exception regarding all the
>> rest of the codebase, thus the idea to bring back things where they belong.
> 
> Most devices are both (a) architecture specific and (b) a particular
> kind of device (UART, ethernet controller, interrupt controller, etc).
> The nature of a filesystem hierarchy is that we can't file them
> in both ways at once. We picked "sort them by kind", which is why
> all the interrupt controllers live in hw/intc, all the UARTS in
> hw/char, ethernet controllers in hw/net, and so on. In this
> breakdown of the world, hw/$ARCH is supposed to be for board models
> and SoC models only.
> 
> The GICv3 and the NVIC are odd, because they are very closely
> coupled to the CPU. (A few other interrupt controllers are also
> like this, but many are not: for instance the GICv2 is a distinct
> bit of hardware that communicates with the CPU over the IRQ and
> FIQ lines only.)
> 
> One of my post-implementation regrets about GICv3 is that we
> didn't really get the split between the GICv3 proper and its
> CPU interface right. In hardware the GICv3 is an external device
> and the CPU interface is part of the CPU, with a defined
> protocol for talking between them. In QEMU we put all the
> implementation of this in hw/intc/, and the code in arm_gicv3_cpuif.c
> does some ad-hoc installing of hooks into the CPU.
> 
> For the GICv5 I'm trying to structure this in a cleaner way that
> is closer to the hardware structure, so the CPU interface
> will be code in target/arm/, with a clearly defined set of
> functions that it calls to talk to the rest of the GIC that
> lives in hw/intc/. (This would be too much upheaval to
> retrofit to GICv3 though, I think.)
> 
> In a green-field design of M-profile we might have made
> the NVIC be code in target/arm, and instead of a separate
> device have the CPU object itself do this code. But at the
> time it was written we didn't have the same QOM device
> class setup we did at the time, and IIRC CPU objects
> weren't a subclass of device.
> 

Thanks for your answer Peter, it makes more clear for me what is the 
rationale between sorting the devices this way. It seems the root issue 
is the lack of proper interfacing between target cpu, and devices 
relying on it.

I don't expect any silver bullet to solve this, but we still need to 
move forward, so I'll share some options below.

>> As well, I would prefer having a clean build system more than a clear
>> filesystem structure, considering it's quite easy to jump into any
>> definition automatically with your work editor nowadays, vs understand a
>> meson.build file full of tricks and implicit dependencies where no tool
>> can help you.
> 
> On the other hand, I prefer to have the source files in
> a clear structure, because then you know where to find
> things, and command line tools like grep etc are easier
> to use. (I don't use editor jump-to-definition: I've never
> felt the need to try to set it up.) Build system files on the
> other hand are things that most people don't need to look at
> or do more than very simple "add another file in the same pattern
> as the existing ones", so it's not too bad if they accumulate
> a little complexity.
>

This maybe explains why QEMU is a bit messy regarding its build system 
architecture, because people are not interested into it. IMHO it's a 
mistake, because a clean build system architecture will usually force a 
clean software architecture, at least in terms of components and 
interfacing. This is what we see right now, with some of the fixes from 
the single binary being to extract proper API with fixed types, that 
allow components to communicate in a proper way.
Complexity does not help neither, because it makes meson build files 
hard to understand, and probably push back a lot of people from looking 
at this. It's sad considering meson first objective is precisely to 
limit the complexity of build systems.

Regarding the "modern" completion support, I recommend you take a look 
at it. Even though you wrote or reviewed most of the code you navigate 
in everyday, and thus don't need it, it has become a standard tool for 
any developer, like sanitizers or omniscient debugging. It's especially 
interesting since those tools are based on compilers (clangd is the 
standard for C/C++ nowadays) and not a bunch of clunky regexps.
It's even more interesting when you learn a new language, like Rust.

> Looking at hw/intc, there is a lot of use of specific_ss
> here, so I suspect that these Arm interrupt controllers are
> not going to be the only ones that are using target-dependent
> code (there are 25 files which use CPUState, for instance).
> So I think it's worth figuring out how to build these in
> the right way where they are rather than saying that
> various interrupt controller models should move to
> a place where they don't logically belong because that happens
> to be a folder where we have the build machinery for it.
> 

Coming back to our issue, I can see two ways to solve it in a short term:
- On build system: define target hw before generic ones, so we can reuse 
all the source sets defined there. This has the advantage to be usable 
by all others architectures.
- Move gic related fields to a substructure in arm cpu, and provide a 
simple accessor to it, like "cpu_gicv3(cpu)", breaking the dependency to 
cpu.h. Concerned fields would be: gic_num_lrs, gic_vpribits, 
gic_vprebits, gic_pribits.

As you'll be the one having the final word and merging this, which 
option would you prefer to see?

> thanks
> -- PMM


