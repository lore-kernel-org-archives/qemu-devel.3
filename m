Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B359FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJzP-0002V6-2V; Thu, 30 Apr 2026 01:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJzJ-0002U6-GA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:31:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJzA-0008Ac-II
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:30:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso2614615e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777527051; x=1778131851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXjCajR/XUaiqqQ2d8SWSMh6Z3J0tTwBQcCYJ6nII9k=;
 b=zO0KeB9bUsX09DgtGiBpfjQ+uJNAi98mIrKzg8uznyZuMmTs0XCJCgZuKgFHLqzL32
 4a8b1jWRsg6ZMVIWF9vyr8ddAUv4haCrZ/rx27NHV2ymDWZghlTe9MFN2m3P4ZslN0tA
 50Kw2CokvXGQlkuDqyeFmJQhAhOkqm8IsOdyG56vDOLwO3lWFHlsPCbm68z/Sl5M0tGB
 QXXAWX9ZCvLrahQJY83tl51Y7jlIGQnvZP9NEsjcyfjD5gnOpf72thiMEYpcEM9ZYT0/
 JVM1tkp5KJhmnVrKeUOSfOlu4ocnaDO+9KvTLmbu5m1asDf5EeW41D6/5o/0k3qmInw0
 yK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777527051; x=1778131851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXjCajR/XUaiqqQ2d8SWSMh6Z3J0tTwBQcCYJ6nII9k=;
 b=beSq7+0yG2Ihpsc6D4mPKob/ppjj1zg+FieX4HaD1+lQZ+FnqR1E/S9rCnfG2V5Pfc
 VuXTsAy2eyzdhrMFc1LfybVGWxkYAv+zu8gZfI5nhzETkAuV9qXB5mIzuuL2beMY6o3y
 ckfeFIWEqb/nawnHuLUv2tHtlGAOjz7DooPuaCj97ztwfNvuu/b9fHJuvGxegfd4MA69
 ord0nB6BFpmxd23Wd+LvU+JxsA4rEBnHkJnvHqmGvMwQtd+gQmKcVfK8Qjo5vh9E4/41
 GNDl/KvOd/yrbBWhU/KMoUOsAmPwA6EaiT5renEa/pRwOn3ZqF7gfb4C4JcVa5ca8odX
 0/Dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AcEKZwng7cKbX9GaxH0OGoMjSAmTRXoM9uimrOCFVPjZ/PnxIIODcVcn/bGFzL7jQHOY+YJENz177@nongnu.org
X-Gm-Message-State: AOJu0YzUI3nzc+1wsFLKUjt5LbS0YtXrH0Cwu0zkbuy4dLYTf9gsTFhp
 CsGF8rJsTpRaMtJDhAdlQd7fG+UJd/Lh0Ou2jndr6BxXPv3xit+xZfruPkuK1pjuh5I=
X-Gm-Gg: AeBDiet8DGW6fs0jlWYjUa9PyP/ZC8Pe3Wfpz620Uwn4HTMHVtj2dq0Bum+yzpAgE11
 5k6hzDTdEi8cDpuGfGRcsT9+xcPLt0QIDLsDu31Xn0dxr9Wmw1+fRiJJcdN2F9S1ToYh5cH32jA
 LbHmpum8bkOsnzZuX74zAd4bkEhYe/plHpkLfc57boluy4Ie2fowe6omQjTKiueGFT01B8nn2Ca
 c4hSkovGYKAtCI36QB0Ra3CM29x0r/E2A1Lo1rxFPefi88Wl285t8js/UL0MCYcN5vf9rsjvLq8
 9MGdmgHLqfhb7w196UXzof2dHCbtwyWE/9ChcOWBzTe9KiWHPi4q9cKpd2BFqEC3gniAXzLr8To
 CdyAwd26PkXkxQZuTRm6JnaP0HRZI6/FwK7hhO1MIyucVHdalp2bDOLvOYwjmH5+PV1QqiWglT4
 H24hARqbOOF9kf/QhuAu0ugh+/T9C5wG0LbBADezMSMllgNL+1xxPl+0duwYMDA9/qYErXX4Bs+
 pBu
X-Received: by 2002:a05:600c:638f:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-48a845210a5mr22239955e9.19.1777527050611; 
 Wed, 29 Apr 2026 22:30:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822d4b3csm41206245e9.13.2026.04.29.22.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:30:49 -0700 (PDT)
Message-ID: <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
Date: Thu, 30 Apr 2026 07:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 14/1/25 08:47, Cédric Le Goater wrote:
> On 1/14/25 08:11, Nicholas Piggin wrote:
>> On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
>>> On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
>>>> Hi Cédric,
>>>>
>>>> Cc'ing Laurent & Richard for user emulation.
>>>>
>>> ...
>>>> The deprecation message (see previous patch) was about the
>>>> "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
>>>> for user emulation?
>>>>
>>>> $ qemu-ppc -cpu help|fgrep 405
>>>> PowerPC 405d2            PVR 20010000
>>>> PowerPC 405gpa           PVR 40110000
>>>> PowerPC 405gpb           PVR 40110040
>>>> PowerPC 405cra           PVR 40110041
>>>> PowerPC 405gpc           PVR 40110082
>>>> PowerPC 405gpd           PVR 401100c4
>>>> PowerPC 405gp            (alias for 405gpd)
>>>> PowerPC 405crb           PVR 401100c5
>>>> PowerPC 405crc           PVR 40110145
>>>> PowerPC 405cr            (alias for 405crc)
>>>> PowerPC 405gpe           (alias for 405crc)
>>>> PowerPC npe405h          PVR 414100c0
>>>> PowerPC npe405h2         PVR 41410140
>>>> PowerPC 405ez            PVR 41511460
>>>> PowerPC npe405l          PVR 416100c0
>>>> PowerPC 405d4            PVR 41810000
>>>> PowerPC 405              (alias for 405d4)
>>>> PowerPC 405lp            PVR 41f10000
>>>> PowerPC 405gpr           PVR 50910951
>>>> PowerPC 405ep            PVR 51210950
>>>
>>> Up to the ppc maintainers.  I don't know of anything interesting at 
>>> the user-only level
>>> wrt these cpus.
>>
>> Just getting back to things after the break...
>>
>> We are looking at modeling some microcontrollers on the POWER
>> chips. There is an OCC power management controller which is a 405
>> and some other weird cut down 405 derivatives, we're not up to
>> those yet but we want to model them.
>>
>> We should be able to remove a bunch of boards and CPUs, I just
>> haven't started looking, so might be easier to wait for a bit.
>> If it's not causing others too much problem, could we leave this
>> in for the time being?
> 
> Sure. We will need a new SoC for the OCC and a firmware image. I think
> these can be built from https://github.com/open-power/occ or, if not,
> they should be made available.

Should we proceed with this removal now than v11.0.0 is released?

