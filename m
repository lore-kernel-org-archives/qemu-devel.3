Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FE7C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RCr-0002zh-Hg; Mon, 28 Apr 2025 12:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9RCO-0002tY-Nq
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:19:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9RCB-0001sA-R3
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:19:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225477548e1so53133105ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745857140; x=1746461940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nf7NQVMSpJmTKdNVJy+jyUWsH0JWF8uSRscU/L8n9D0=;
 b=H9eeaGaGb9EBmBVbmGxa2NS3QYFmlUFT4e3rKt6sgIL6e/3y7AykOBaS3WnvYmJwkM
 EWgUQTd+Wck2TRCE3ZEASuFWTrzDTMZSMeMvWX3Q4tZq5YjxAXDiL4wB9g4scF/oD+Sh
 pPvDSqqcCq6fqE7fLD0PTh696d3Y+DTYCngmYlINsQbXIXJdJilycPMpvOyEzntQWs0V
 14VwwMPMwZwLnFdLYjG2A2wcEmEZQiHc/X8aI4TulZExqO32hKrsOI788D9LSPKcDO/Q
 xoeyhvuQ//A7scuu1XrvELZSgFMrmXRbwG2FMStkiEEGOYEiHWhAMy2scWd3MlpiwsPK
 Awlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745857140; x=1746461940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nf7NQVMSpJmTKdNVJy+jyUWsH0JWF8uSRscU/L8n9D0=;
 b=bz0HihV6CxnvDuZTsUiQxp6eIMIYtrYp2s7E1p/tbQZ1vVNuDVGwnQCFY8Eai6AlaC
 OmIzguIWfzt5OmX4muAUSsNaOK98A1fvvz8xJK2Bhtw88osFgaOkNDBX2gRI7z9dLPLW
 aDlHohHLkxd3+cg1Xyiv3RngVU/AMGeCXi9czANQuSrJ5k7hlXHfqNyUHkXy8MPJL0qh
 Zp8qSMlWZ8ipKo5TmwpobeTinvBAbCefcNBkT2bSqS98pwfiuNQdmUwL3JS1+WUipwM4
 1fZKkS7RASOrbdC0qwOezEvrp4Qc5S7a8OHWW/zO0Zm+92usrcE8KhWM6u7I959Bv+cN
 ljlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuj384uP5uVldqgzHLnfk5q1JjznkSmIdVvOVmN8mYowvysMB95GZt58tvrzvtrPZbLCbCRR2SNCQn@nongnu.org
X-Gm-Message-State: AOJu0YzYD/Im35dPdjFIYyjNxPRKuvM3RkldEPdwxPwSxxCmuNlDjmCP
 FbDm4XOb4ugSgiTCV1+en0rgmrgpsDhn5kQxFe400QiP7ZSjJYa7IxnRnzhymNI=
X-Gm-Gg: ASbGncu+whA56C0hzHs48cPKIAM9DKnjoX9WXKpo/Dp5MIUEootrcaeKpQiApvK0Uk5
 kimWIIXfZ0DurLLnVvCh4KA2UnC1xVQvuIT++Tx/s9jDOxYdw/NnzHlzg2GXICAGBw+ldcGmrp/
 mcHaOOZ1ujTgZZSlOgi+il4V3/6ob/2YKzhgwHlBrw19fvxky2MPfEY1kKDBPJo+ZSrcjmbMCQP
 9jH1rFr4SJwvaVg8/J67A7an95RzSL9D0j9RJvTSkX7qf5aYwaGSEWrxE2dfOx389yyrqpthllk
 dWSeKkeFZdnYdWtalBKG5leE6PoLliB5RDVwL8g8huRS+Ls4XZ5Dcg==
X-Google-Smtp-Source: AGHT+IEkUbztsQpm4GcHu5c0PQk1rTUzVSA9XYrht6a9fuoRAhvzEcimVVZWICXyZVcW98uZMIf0mw==
X-Received: by 2002:a17:902:d2d0:b0:224:2715:bf44 with SMTP id
 d9443c01a7336-22de5fcef6dmr3730235ad.19.1745857139414; 
 Mon, 28 Apr 2025 09:18:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5101636sm84888375ad.180.2025.04.28.09.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:18:58 -0700 (PDT)
Message-ID: <d4b7c671-61af-4832-9bfb-f1607a02e4bf@linaro.org>
Date: Mon, 28 Apr 2025 09:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Peter Krempa <pkrempa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <aA9XsYFIxw-XIcix@angien.pipo.sk>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aA9XsYFIxw-XIcix@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/28/25 3:25 AM, Peter Krempa wrote:
> On Fri, Apr 25, 2025 at 14:07:34 -0700, Pierrick Bouvier wrote:
>> On 4/25/25 08:38, Markus Armbruster wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> Note: This RFC was posted to trigger a discussion around this topic, and it's
>>>> not expected to merge it as it is.
>>>>
>>>> Context
>>>> =======
>>>>
>>>> Linaro is working towards heterogeneous emulation, mixing several architectures
>>>> in a single QEMU process. The first prerequisite is to be able to build such a
>>>> binary, which we commonly name "single-binary" in our various series.
>>>> An (incomplete) list of series is available here:
>>>> https://patchew.org/search?q=project%3AQEMU+single-binary
>>>>
>>>> We don't expect to change existing command line interface or any observable
>>>> behaviour, it should be identical to existing binaries. If anyone notices a
>>>> difference, it will be a bug.
>>>
>>> Define "notice a difference" :)  More on that below.
>>>
>>
>> Given a single-binary *named* exactly like an existing qemu-system-X binary,
>> any user or QEMU management layer should not be able to distinguish it from
>> the real qemu-system-X binary.
>>
>> The new potential things will be:
>> - introduction of an (optional) -target option, which allows to
>> override/disambiguate default target detected.
>> - potentially more boards/cpus/devices visible, once we start developing
>> heterogeneous emulation. See it as a new CONFIG_{new_board} present.
>>
>> Out of that, once the current target is identified, based on argv[0], there
>> should be absolutely no difference, whether in the behaviour, UI, command
>> line, or the monitor interfaces.
> 
> Okay, so assuming that the correctly named binaries will apply whatever
> necessary magic to have them behave identically as they did.
> 
> I'll also ignore the distros that rename them assuming they do it in a
> way that stays compatible.
> 
> The question is how the new unified binary will behave when being
> introspected:
> 
>   - Can the unified binary be introspected without selecting an
>     architecture?
>     (by introspection I mean starting with -M none and querying stuff via
>     QMP)
> 
>     if no: libvirt will have a chicken&egg problem deciding what to do
>
>   - What will be the answer for the platform-specific stuff such as CPU
>     definitions?
>

It's a good question, to which I didn't really spend time thinking of, 
mainly because I prefer to stay focus on achieving a single-binary 
having a *single-target* available at runtime first.

Once we have this, which should be a "zero effect" change, I think we'll 
be ready to discuss how the monitor and QEMU command line should be 
affected by heterogeneous emulation.

I feel that several people expressed their desire to create a new and 
minimal command line/monitor for this new heterogeneous scenario.

IMHO, I would prefer to see things going towards the direction of having 
a "main" target, and secondaries targets available at runtime. 
Basically, for a aarch64/microblaze mixed board, it would be the same as 
enhancing qemu-system-aarch64, with microblaze cpus available. 
Eventually, we can add specific options/monitor commands associated to 
this, but I'm not sure that refactoring the whole thing is the good way 
to go.
That said, my experience on such usages, and on QEMU in general, is much 
more limited than all the people here, so I would be happy to listen and 
follow what they will design and implement.
It's just my personal software engineer alarm which gets triggered when 
I hear "Let's create another new way to access this", when we are not 
even sure at this point of how many heterogenous boards we'll have in 
the next 10 years. Maybe heterogenenous scenarios will concern only a 
few exotic boards, and it would not be worth buying new shiny wheels for 
the QEMU car ahead of this. Just my two cents.

In all cases, my current focus is to be able to compile and link such a 
binary, without which we can't do any step further.

Regards,
Pierrick

