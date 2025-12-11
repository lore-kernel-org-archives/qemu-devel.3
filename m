Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09CAD3E78B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 03:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTXPe-000853-90; Wed, 10 Dec 2025 22:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTXPX-00083P-7P; Wed, 10 Dec 2025 22:32:11 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTXPT-0004a4-C9; Wed, 10 Dec 2025 22:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765423928; x=1796959928;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UDdOGxQwwovFx0PVnidZNaPWNNdCzKtTEqbECXf/6VQ=;
 b=W4VY0SBf3dFETCMyLjTsGF8LcZ1J3xiju0MwUgRQT5lgtnnu0TVKbGqS
 kopHH07Ig0etc7C5eM2rLY+I3xD8vrGJM+WTGcjLm0c0P1cA3dSvyx+Ag
 7iuyhL+BSV1K/t7lmZxaI6ubY786HG13hwrvzX9ZSluR1d5vFEWFKZshh
 E8ll8tlMGe6APUhw+qgl1YMxuXXOWOU0ICwurLC3+itd9r5XfzbXPdqM6
 86Fz6HFVS0GOzck4c4E76qZ4iePxIeO+/r1m/gIw9Vq0BnZDTC3D1UrXP
 TfO2lCPkXR+Ip8v5mPuK1DYFiV+2yh+hzMv4US+SDsD9NHDYz4MqLw2Ke g==;
X-CSE-ConnectionGUID: 0roEQLJBSD2a56Ua8Io9bA==
X-CSE-MsgGUID: uc07dF0FRgmN0vX7O8nIPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78515729"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="78515729"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 19:32:03 -0800
X-CSE-ConnectionGUID: hwYxna3qRbGPJouULLV7QA==
X-CSE-MsgGUID: t+SsGPxjRD2gipjS8kTBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="195950972"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 19:31:59 -0800
Message-ID: <048e2c5a-8e16-4625-8382-9478a8af5c9a@intel.com>
Date: Thu, 11 Dec 2025 11:31:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
To: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 thuth@redhat.com, pbonzini@redhat.com, jak@jak-linux.org,
 qemu-devel@nongnu.org
References: <20251203131511.153460-1-dave@treblig.org>
 <87a4zzu230.fsf@draig.linaro.org> <aTBCLbDbpXgkTLHr@gallifrey>
 <CAFEAcA-Uy0UQwGEK+f95BJmDripg1-8vhzPF5qRSY40=duhRUQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAFEAcA-Uy0UQwGEK+f95BJmDripg1-8vhzPF5qRSY40=duhRUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/4/2025 12:06 AM, Peter Maydell wrote:
> On Wed, 3 Dec 2025 at 14:00, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>>
>> * Alex Bennée (alex.bennee@linaro.org) wrote:
>>> dave@treblig.org writes:
>>>
>>>> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>>>>
>>>> -M is used heavily in documentation and scripts, but isn't actually
>>>> documented anywhere.
>>>> Document it as equivalent to -machine.
>>>>
>>>> Reported-by: Julian Andres Klode <jak@jak-linux.org>
>>>> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
>>>> ---
>>>>   qemu-options.hx | 12 +++++++-----
>>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index fca2b7bc74..ec92723f10 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>>>   #endif
>>>>       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>>>       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
>>>> +    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
>>>>       "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
>>>>       QEMU_ARCH_ALL)
>>>>   SRST
>>>> @@ -179,6 +180,9 @@ SRST
>>>>
>>>>               -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
>>>>
>>>> +    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
>>>> +        Define an SGX EPC section.
>>>> +
>>>
>>> This seems unrelated.
>>>
>>>>       ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
>>>>           Define cache properties for SMP system.
>>>>
>>>> @@ -208,12 +212,10 @@ SRST
>>>>   ERST
>>>>
>>>>   DEF("M", HAS_ARG, QEMU_OPTION_M,
>>>> -    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
>>>> -    QEMU_ARCH_ALL)
>>>> -
>>>> +    "-M              as -machine\n", QEMU_ARCH_ALL)
>>>>   SRST
>>>> -``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
>>>> -    Define an SGX EPC section.
>>>> +``-M``
>>>> +    as -machine.
> 
> Surprisingly, this and -h/--help are our only two options where
> we provide a short synonym. I note that this handling of -M
> is not consistent with how we document -h/--help, where we
> print both on a single line:
> -h or -help     display this help and exit
> 
> But it would be trickier to fit that in for -machine and
> perhaps confusing given the suboptions.
> 
>>> Did we have a merge conflict at some point that messed things up?
>>
>> It's not clear - it was the only option hanging around in -M and it was
>> already appearing wrong in the man output.
>> I wondered if it was some requirement to have *something* in the -M
>> definition so thought it best to move it at the same time.
> 
> It looks like this was incorrectly added under -M by
> commit dfce81f1b9 ("vl: Add sgx compound properties to expose
> SGX EPC sections to guest"), which should have put it under
> -machine like all our other machine suboption documentation.
> 
> The result is that the sgx-epc documentation appears OK
> in --help because the --help output just concatenates
> everything so it gets tacked on after the -machine help,
> but it is misrendered in the HTML docs:
> https://qemu-project.gitlab.io/qemu/system/invocation.html
> as it appears as if a top level option rather than one
> indented to indicate that it's a machine sub-option.
> So this change fixes that bug (and should ideally say so
> in its commit message).

Yeah, I found this bug before and sent the fix: 
https://lore.kernel.org/qemu-devel/20250714091953.448226-2-xiaoyao.li@intel.com/

But I was occupied with other stuff then so that had no time to sent out 
the v2.

> Before that it simply read
> -HXCOMM Deprecated by -machine
> -DEF("M", HAS_ARG, QEMU_OPTION_M, "", QEMU_ARCH_ALL)
> 
> (Commit dfce81f1b9 also silently dropped that "deprecated"
> comment, which it shouldn't really have done.)
> 
> thanks
> -- PMM
> 


