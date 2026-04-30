Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF877CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIT6q-0005bD-DI; Thu, 30 Apr 2026 11:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIT6o-0005a0-Fk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:15:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIT6m-00047U-2I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:15:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so6324755e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777562118; x=1778166918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WHnLeiqNY3w/hpdj/V3mbonlH4f4MJl2qZofcEOpRHI=;
 b=Dp1Up9vX9wkyMyYVwOYAaD0zt3kKgAbGQlj09qBZALa+e556dedexLabhDRLOnPXfp
 NJDxnzUq+IR//CdXIbZhnGQb1xn937wSNmO8vsvMbhdX8RVgnqgb8BBOVms+ug2/MXoy
 00M9cWHh+ND6EotGvjXSg6Nj6oNidZKKgp6KokUW+QBiWyYyIz4h5pi2ISFkMHDp1UFU
 u7SyY5XOKez2J9631Sq/cYXrJQ+NKxYT5ajCyCt4zW9gjH1Grslx5Myvg4IdnGdgWZom
 HUFS2MQXG9CZQnrqCkzAr30fmX0Vx3K/wrXZP6a0bsNKaoEGeystRQ+abZEhi5wNwJLk
 kWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777562118; x=1778166918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHnLeiqNY3w/hpdj/V3mbonlH4f4MJl2qZofcEOpRHI=;
 b=rD2cYLhThx2Jf6m5X6omCrhWJYrnryP4w9jowP+R96+OFFYVsUa8rlJz5GuTg3THpx
 0zWzxB0zX5L9ASs9QiIUf5IHFmeV9Dq8QuQ4I7o7UMgoPUpQ7t9T/MYJtEnH28en7/nA
 bKq1K/yRu/m+0KqMdawfIRZkEUupyExE5Dnu8vuDTvqZeYt8C/t/HvZGuzZC2T6zrn0R
 x/g5qLY08QwGfapcWKwvjK755eu7ae6bBUnM/GvDFq6ahWHW/STwYLOsYkQ+iO30mdSX
 DYXvxneaZbmJmm9Mwf5yh47/o5IxWcoxPo6dXCfe1zS+aGbDq2r1zMrTDtrzWNCIh5jS
 Ev8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ82vy6E4lr9HpmGMo1cleI1Mu/QILYVRBQqUdItrLohOL+ep6olPoQpmcvMCWM6abDqCydjUb6Y53Qg@nongnu.org
X-Gm-Message-State: AOJu0YyApxVJzXJN7vxrROxVexLEGcDIQhJKTU+JCcgHjI8Szb0lML75
 1Rlm7ffz2h9TYuHzUXLZgADVl2lJA3J6K0RH8VVAfl5qNFz7FX4FVAaSGzLkyzZiETk=
X-Gm-Gg: AeBDievUq8nss8b3jHTe+/WMGOGKSofRE2s9B9N58OJ/bk+HMVDMNKgN5cKT0hD3Lsi
 i3ThUzIDNRaRhQVotFJsa8y4d3jK8OytUdZH7E2xEEUesoumvSLUg7X5K7GOtcn0bCq0yWmunvy
 LMSbyolFblJDqsH7/6/RuIffKfFONGE52whMiSneK5giArGJ1eUJVm25NYs6H/1cSDS0BHbm5nl
 BdUgK8zQIFO8DNrRIji3yeiTpQFfcW62CMGx9Mv/aG4Mx4qSbYLgKSNkL9VHCRPljlIdWwgKtGI
 AxoK33j36qvS3gJcGUpaJiII+VyARiXmzlN0s/ovzc39w8PfVRJ14gHTxFp6/EMYcFhvitASyoX
 LtGxTMruM/3yDDsP+MRvDPhNvMErURnkrvAf86OlqYi+1y95+Awy6p/CK/T5ylUad8RpWsVUGTk
 QjMD8mRv/2CRGoXYunjQodcZQxavRzztOtKkuB+l/vKLyjtbH5LkpK6O37paenDTyxduuPhetjL
 44X
X-Received: by 2002:a05:600c:4e05:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-48a84473724mr58233295e9.22.1777562118255; 
 Thu, 30 Apr 2026 08:15:18 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c31f1ddsm41895295e9.29.2026.04.30.08.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:15:17 -0700 (PDT)
Message-ID: <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
Date: Thu, 30 Apr 2026 17:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Harsh,

On 30/4/26 08:54, Harsh Prateek Bora wrote:
> Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
> 
> Glenn,
> Please take a look and let us know your thoughts.

Glenn can have a look, but I think we are good to remove them now,
they have been deprecated for more than 1 year, enough time for
any reaction ;) Otherwise that'd defeat the point of deprecating
and the pain for us to schedule and wait for months.

My 'Should we proceed' was more of a polite ping than a question ;)

> regards,
> Harsh
> 
> On 30/04/26 11:00 am, Philippe Mathieu-Daudé wrote:
>> On 14/1/25 08:47, Cédric Le Goater wrote:
>>> On 1/14/25 08:11, Nicholas Piggin wrote:
>>>> On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
>>>>> On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Cédric,
>>>>>>
>>>>>> Cc'ing Laurent & Richard for user emulation.
>>>>>>
>>>>> ...
>>>>>> The deprecation message (see previous patch) was about the
>>>>>> "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
>>>>>> for user emulation?
>>>>>>
>>>>>> $ qemu-ppc -cpu help|fgrep 405
>>>>>> PowerPC 405d2            PVR 20010000
>>>>>> PowerPC 405gpa           PVR 40110000
>>>>>> PowerPC 405gpb           PVR 40110040
>>>>>> PowerPC 405cra           PVR 40110041
>>>>>> PowerPC 405gpc           PVR 40110082
>>>>>> PowerPC 405gpd           PVR 401100c4
>>>>>> PowerPC 405gp            (alias for 405gpd)
>>>>>> PowerPC 405crb           PVR 401100c5
>>>>>> PowerPC 405crc           PVR 40110145
>>>>>> PowerPC 405cr            (alias for 405crc)
>>>>>> PowerPC 405gpe           (alias for 405crc)
>>>>>> PowerPC npe405h          PVR 414100c0
>>>>>> PowerPC npe405h2         PVR 41410140
>>>>>> PowerPC 405ez            PVR 41511460
>>>>>> PowerPC npe405l          PVR 416100c0
>>>>>> PowerPC 405d4            PVR 41810000
>>>>>> PowerPC 405              (alias for 405d4)
>>>>>> PowerPC 405lp            PVR 41f10000
>>>>>> PowerPC 405gpr           PVR 50910951
>>>>>> PowerPC 405ep            PVR 51210950
>>>>>
>>>>> Up to the ppc maintainers.  I don't know of anything interesting at 
>>>>> the user-only level
>>>>> wrt these cpus.
>>>>
>>>> Just getting back to things after the break...
>>>>
>>>> We are looking at modeling some microcontrollers on the POWER
>>>> chips. There is an OCC power management controller which is a 405
>>>> and some other weird cut down 405 derivatives, we're not up to
>>>> those yet but we want to model them.
>>>>
>>>> We should be able to remove a bunch of boards and CPUs, I just
>>>> haven't started looking, so might be easier to wait for a bit.
>>>> If it's not causing others too much problem, could we leave this
>>>> in for the time being?
>>>
>>> Sure. We will need a new SoC for the OCC and a firmware image. I think
>>> these can be built from https://github.com/open-power/occ or, if not,
>>> they should be made available.
>>
>> Should we proceed with this removal now than v11.0.0 is released?
>>
> 
> 
> 


