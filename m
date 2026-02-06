Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2060EB28D4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voG9s-0002Th-B5; Fri, 06 Feb 2026 02:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voG9p-0002TV-O7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:21:37 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voG9n-0007gk-56
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:21:37 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f102b013fso3750655ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770362493; x=1770967293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8g2vzEaydvB1DAsR6FJp/2X4dFGE78RDOVY4g90UZs=;
 b=wN1AGaxTg/qNcVjUep2oT94vabhnI3ya5uiAcuuKhfQwg4pQBjCG8UnIp8I6h9E4t6
 Cj6p5CZXBX8+lroMttwiWHXlFlIflcpJ3bEJIbe3DOmLCzY6FMXx2FkPO5bVSohXgQF8
 gii38A5rpmZqfdb7iJJGWxJ1vUOngulPcMdY6MIEAjr4l1rh8SOh0sfdW3boo2BhxduC
 PL7vIulNN2703Mr2IavK3NCRyJ6GTZqVWds31bTDA2xhUqTitKcfhpgeUGA8r7Z8+/dV
 uIiGYMIKJ4Qnbs7GodEspe0+NxuKyVyexVQuLX86IcvkrNLuf7UerJKgUj8RY4obWccH
 EphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770362493; x=1770967293;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l8g2vzEaydvB1DAsR6FJp/2X4dFGE78RDOVY4g90UZs=;
 b=ZoMHc2Aw/VOO7cHGOZVLmOeGDjtxg/cmBd3WJiePbTcIx+9dxA2FKqarCvMAskia+/
 SBrfk+WdpT5euWoPlBZtgRJJj8bbelmBgvXzZ4J4rJShTlXPJ00kjmCem/UFCIzLWSkS
 H0uwDgnYQGn5SGPqnPs7vnf4UZqYEUG5ufPOQe87BVGWEYOokAPuvlxGY0iJc5qNzeCm
 Mmu7EN91QrHi93OCpsBfX5kCJv1/GnU50Cjg4rcBxbiHy9wt+QN7vTKlaTqsWKxtT+QW
 idMIsn4F/v1gEiF699+9p1aEzOu0wJGCNNdNklE8RRqs8JfH+MWmHiknESwa7GRTALHQ
 8LGg==
X-Gm-Message-State: AOJu0YzynyfNyQeRir0f7L91tgHtj5+dA9Yp8HYAz3iM/1kGJIOyw8SB
 dvx5NMvitzvvh+R7dC7n9muhTRIP1fH/aqgxjCB6cswWuvrNTNhKkf1QKN1DirPict0=
X-Gm-Gg: AZuq6aKDhGAydqbt+LQycn81E/IWmfaum1dH0Kmf6L/CUbMm7AJP/faYIntWRTPVNbk
 +gk/3QplM7WBnJoKVHbc7FxD58ux8EsxXT5CWe9tytBEUZD7VIfarsCN1lJzUAVVJQE6bgPvSK4
 dO4TjVJ5/sRtpP5u5HRrtN2QGvsLfILBz2yiumxQFLBYYGu4laxpkol2udZpqpFj7a1PyuWhCPr
 zUuRrDp9K2/295eoU6cMlaSNN1XQv1X+smjsLRfk7sbTyFCWt96uoavrCZI8xOKQ6cj+Nuqr5uk
 FLjZ/4wJuIrD0gHiPan6C9GTMUwul0GNIRii90m/4ECulg06q8rskCs6FtSyx0s9dsuL/bibKoF
 50uraiTz+rj2lsL7jXqrGzG7A0Nsxsw4SL/pIlPKCY91Jk03ny1+p43ccowcnj9fORo9Cp6G5dK
 7c2/m1lMJIqy4qVyF0VGVFrl4eJv9OPoFUpg/mrbuNPY61nEx/Eo5ElQiF
X-Received: by 2002:a17:902:e84c:b0:295:62d:5004 with SMTP id
 d9443c01a7336-2a9516c4cb8mr21654425ad.26.1770362493064; 
 Thu, 05 Feb 2026 23:21:33 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521bae5csm13711525ad.60.2026.02.05.23.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 23:21:32 -0800 (PST)
Message-ID: <d293019a-218f-49d9-963d-6411c9b453a0@linaro.org>
Date: Thu, 5 Feb 2026 23:21:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Renaming targets
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
 <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
 <877bsr34au.fsf@pond.sub.org>
 <6ddad25a-192c-4b5a-80fc-b006436810a2@linaro.org>
 <878qd6xsrh.fsf_-_@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <878qd6xsrh.fsf_-_@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/5/26 10:58 PM, Markus Armbruster wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 2/5/26 19:52, Markus Armbruster wrote:
>>>> I assume the qapi string is the one that should take precedence; everything else appears to be merely qemu source level strings.  Marcus, can you confirm?
>>>
>>> What exactly would you like me to confirm?
>>>
>>> I *guess* it's about the messy part of the patch you posted upthread.
>>> There, you have to normalize TARGET_ARCH value 'openrisc' to 'or1k'.
>>
>> Yes.  I wanted you to confirm that changing the string in qapi is a non-starter, therefore
>> 'or1k' is the string we should standardize on.
> 
> Yes, changing enum value @or1k is problematic.
> 
> Enum SysEmuTarget is visible in QMP: query-target return member @arch,
> query-cpus-fast return member @target.  These are stable interfaces.
> 
> I can see two ways to change the enum value to @openrisc:
> 
> 1. We create a new qemu-system-openrisc, identical to qemu-system-or1k
>     except for the target name.  We deprecate qemu-system-or1k and
>     SysEmuTarget member @or1k, and remove them after the grace period.
> 
>     I doubt it's worth the bother.
> 
> 2. We cheat: we rename with the excuse that the target is bottom support
>     tier, and our compatibility promise doesn't apply there.
> 
>     I don't think that's a good idea.  If we want to qualify our
>     compatibility promise with tiers, we better define the tiers and what
>     they mean for the promise *first*.  Related:
> 
>      From: Daniel P. Berrangé <berrange@redhat.com>
>      Subject: [PATCH] docs/about: propose OS platform/arch support tiers
>      Date: Thu, 15 Jan 2026 18:01:23 +0000
>      Message-ID: <20260115180123.848640-1-berrange@redhat.com>
>      https://lore.kernel.org/qemu-devel/20260115180123.848640-1-berrange@redhat.com/
> 
>>> I figure this is about adding 'hexagon' to SysEmuTarget even though it's
>>> not actually a system emulator target now.
>>>
>>> The fact that adding it there helps indicates SysEmuTarget has leaked
>>> into user emulators, and its name has become misleading.  Is this true?
>>
>> Yes.  The target_info structure is used for both user and system, and one of these fields
>> is the SysEmuTarget entry.
> 
> Then SysEmuTarget has become misleading.
> 
> We *can* fix that: QAPI type names are not part of the external
> interface by design.
> 

Do you mean it could be renamed to EmuTarget without any consequence?

It seemed to me that everything exported from the json files could
potentially be consumed by another entity (libvirt for instance).

Regards,
Pierrick

