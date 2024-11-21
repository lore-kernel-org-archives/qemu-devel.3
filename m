Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16394D743F3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 00:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDueo-00079R-7U; Wed, 20 Nov 2024 19:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDuem-000799-AU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 19:02:48 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDuek-00054L-E9
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 19:02:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso2555315ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 16:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732147364; x=1732752164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Llwyjr3i+PAPO6dJR2Vc1wg3xjbFk6zBmPAWLj6DxAo=;
 b=Iy01PZW7DhCU0h/LZnDnqx3qNuEoQfahad9PGf/LlAYZqp05PAr/vAU1Qsl2kXYnOV
 xpUOKhKcplZnYpef9IcgkZynnaTRFUWjLStr8fP3hR//EFfgJAd3UVbU4sh4wRK8sJeH
 ZfZYs+fpEsxeqFj2N71QHJEmABtka3+SSAnhno17Z9B/nEkqCDdzinGbNdueBjAqXZUH
 3qjuFvyYZIe8XKTwLXmu35hrPl2gEw5s8hO0GdbeSf9GTwRPb3ntAiA3QsE5lGoPcwev
 VOSyC4byfzMgR/TnRW5gc2CX4ChiWjmufg+O7XI/3gftIcPImEtYwfMrcX2BjRuu5VUH
 rECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732147364; x=1732752164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Llwyjr3i+PAPO6dJR2Vc1wg3xjbFk6zBmPAWLj6DxAo=;
 b=glpnncegrSmyz542Jsq0/rgvgEBtdeiX2Ai3DcruYxYIef7dS+u1NvFpPTrtir+DgI
 YORhdlGpWVt0xWkWnPG3ZqWYNa2Y3VD2ta59toH58ROGF47H+IR8wvKgGSapGGhadklJ
 U3Qw25IXssmLc+vK9UA1YPkH6VkZpFm6VXT3GfW7RVkFcN1QirGm/R2MNTdYQuJkWHQm
 saXMnvXAbefAU0+aPM9JiMxMIuQ0TTPWb8TvFnfCYig1UlCaXvSMPFmd4wR4BzElPM1x
 sp7V7vsOUTX492zuCyYFltjwUE8/mqWoaRnuh1nxDhkFjNnFWqyP++kUXB2sx9lLIk/Y
 aDWA==
X-Gm-Message-State: AOJu0YxS3goxZoVzyirLkLlrG1OdfobJDIUs5MOMVDu21o+/79waBRfV
 Ndea7zVx2ZFVRTiwhox36iWBZKwGg/l1/aV/kP3mxpL6usyChOiJHr+WWZ84JMhN9VL1Nmp6gcE
 wmso=
X-Gm-Gg: ASbGnctCJ+ULhVE4p5CRj4pw68vIwpc3/h5FWgNCPoxzR5J9qSliU2q8XS6l0u1qbgC
 8hPzAp0R+F42aKU+22TtujH+tI4DtDqS0Ed2I8CSfH7fHk74cgc724NVOKpOPr0a9jVhZHXIKnD
 W/KebuYM6WGe/93YGzKRB7vn7hiLCDG71bNzE5C6/PPMhigyy/ql31s1gQ3pSDqH+YjgRq8WhPY
 CSAp2Oe/uXPii12M+JVKJB2iciEMI2TfdY0Fta36l+nv53PXP/n4e25ldD7ePAhx+35Eui3GJav
 QPFRZZdQOEf0SgmHH/oL0A==
X-Google-Smtp-Source: AGHT+IFitI38wTP7oWyjOs9G/fSKBFHf1TRGwpvZxBVLjq3unN1sdGwfd08lbUMZrUd0Hd2tCys7YQ==
X-Received: by 2002:a17:902:e84b:b0:212:4d24:5364 with SMTP id
 d9443c01a7336-2126a3737b3mr52095365ad.9.1732147364012; 
 Wed, 20 Nov 2024 16:02:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2128788ababsm1340005ad.4.2024.11.20.16.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 16:02:43 -0800 (PST)
Message-ID: <a10c7bf6-38c6-4e69-9b36-0d8422e44908@linaro.org>
Date: Wed, 20 Nov 2024 16:02:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Status of some Arm features
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
 <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
 <33af12d7-9269-4c21-96d4-aa76becd0f09@linaro.org>
 <CAFEAcA9YGBxGTOXT0F3eCAVD+pqEa-kLY94GtFKHU31reSb=rQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9YGBxGTOXT0F3eCAVD+pqEa-kLY94GtFKHU31reSb=rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 11/19/24 09:14, Peter Maydell wrote:
> On Tue, 19 Nov 2024 at 16:52, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 11/19/24 02:09, Peter Maydell wrote:
>>> On Mon, 18 Nov 2024 at 23:33, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>> I'm currently reviewing the QEMU Arm documentation, and I have a
>>>> question about the status of following features:
>>>>
>>>> 8.0:
>>>> - FEAT_DoubleLock, Double Lock
>>>
>>> This is actually an "anti-feature" :-)  It is optional from v8.0
>>> and it must not be implemented from v9.0. We implement the handling
>>> of it based on the DOUBLELOCK fields in ID_AA64DFR0 and DBGDEVID
>>> (so it does the right thing on older named CPU types) and don't
>>> advertise it in "max".
>>>
>>
>> Despite this singularity on versions implementation, should we list that
>> in our documentation?
> 
> Yeah, I think we reasonably could.
> 

I'll add it in my upcoming series then.

>>>> 8.2:
>>>> - FEAT_ASMv8p2, Armv8.2 changes to the A64 ISA (bfc and rev64 instructions)
>>>
>>> This isn't a feature for CPU implementations; it's a feature for
>>> assemblers and disassemblers, which have to recognize BFC and
>>> REV64 mnemonics as being ways to write special-case flavours
>>> of the BFM and REV instructions.
>>>
>>
>> Reading the feature description [1] or the A-profile manual:
>> FEAT_ASMv8p2 introduces the BFC instruction to the A64 instruction set
>> as an alias of BFM. It also requires that the BFC instruction and the
>> A64 pseudo-instruction REV64 are implemented by assemblers.
>>
>> I understand it's both introducing the BFC instructions *and also*
>> ensure that BFC and REV64 are implemented by assemblers.
>> Is my interpretation wrong?
> 
> For an implementation, there is no BFC instruction. If you look
> at the Arm ARM entry for BFC, it says "This instruction is an alias
> of the BFM instruction", which means it exists only for
> assemblers and disassemblers and assembly authors.
> (And if you look at the BFM instruction, there is no subset of the
> encoding that is gated on any feature; so there is no extra
> behaviour of BFM that got added here.)
> 

Thanks, I have been confused by the presence of BFCI and BFM 
instructions, making me think we implemented something specific.
It's more clear now.

> These "alias" instructions are there to make the assembly be
> a bit easier to read. The only unusual thing about this alias
> is that it wasn't in the architecture right from the start,
> which I think is why it got a FEAT_ name: to flag up that
> if you're writing asm or if you're an assembler author then
> you need to do something here. But if you're creating an
> implementation of a CPU, then there's nothing to do, because
> you already implemented the handling of BFM as part of ARMv8.0.
> 
> For an example of an alias that was present from v8.0, look
> at "MOV (to/from SP)". This is an "ADD (immediate)" instruction
> under the hood, but you can write it in assembly source as
> "MOV SP, Xn", and the assembler will put in the same bit pattern
> as if you'd written "ADD SP, Xn, #0". In QEMU (or in a hardware
> implementation) we don't need to do anything for "MOV SP, Xn",
> because our implementation of "ADD (imm)" will catch it.
>

Got it, thanks.

>>>> 8.4:
>>>> - FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)
>>>
>>> This is optional, and we don't implement it yet. (There's an
>>> open ticket for it in Linaro JIRA at
>>> https://linaro.atlassian.net/browse/QEMU-309 )
>>>
>>
>> Ok. For my personal knowledge, does the implementation in
>> hw/timer/sse-counter.c is related to it?
> 
> I elaborated a bit on that in my other email -- they're
> doing a similar thing, but sse-counter.c is M-profile.
> 
> -- PMM


