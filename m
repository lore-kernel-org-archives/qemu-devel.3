Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A85CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 22:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKkYV-0000zT-09; Wed, 06 May 2026 18:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKkYT-0000xo-D3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 18:17:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKkYR-0003F9-31
 for qemu-devel@nongnu.org; Wed, 06 May 2026 18:17:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646LpaYb1527798
 for <qemu-devel@nongnu.org>; Wed, 6 May 2026 22:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cfr30T6tqHaO7a3SCLT7jY8vD2D/utKjmwMe+SOIuSU=; b=hRs6LIy9xRR0un2X
 nCTBSpSuohzXTIHl7r4aJUZp07v+ICoWHUlPfWMvmN7HJKEB9lP9QMxTlfAfJCaV
 oAi20UNglktcpzfr9OcyFZvB3qEo0p2KZegXXzXJq9k0YJEs7212O2yZmn1E7cTQ
 gD1vMo8Za6hR+LEyzBtUvYlWXN6+4QS5NtmJ8Tf5Zey4S2Fr6bqhoE2KlhsarHsF
 EyQ+52tR1409HC73fsunthM4IZZFKnkcutWmUAyYAMYfN6Ptr3rNp6B5Ko7u6SLT
 YcBKKG3iYrVMjuIFEgsdEpcak+ReyTVTsgYT4RsTEL/C/z1GgTwRVZjHNWGDrvcn
 tO0wZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128b95q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 22:17:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2eebb099efbso841052eec.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778105835; x=1778710635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfr30T6tqHaO7a3SCLT7jY8vD2D/utKjmwMe+SOIuSU=;
 b=FR/5p65Mfxzsl+J209viVvEpqurfHXhSLRimLVK3YTHQm84UFDK7d42bMgZx0dBH3K
 v4jU4KsiGn3c/6UeyysV+8d+LdU2x5lsLnRUKY1cyrokEANCjznbkLutpA3FQbnkRjxW
 Zu1tMArKh3PUbYzbyNQlWZNJX91ld4RX5cSS+mMjRZusuBwlAq9dGTU+pLxgJ1hvA8W0
 Pq5Mf821sjPS4Tf2YLLMK4Ro916weMwiYAV7vhUs3YkIoR1b3Ooz8IVH8ScrP15Vi6yQ
 srXrhcupLI/h2TxF14/W4GZdSeEvjVFrJhuGmlcTkJFsZkFofORS4Wuwi4rADQVhRuyC
 wl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778105835; x=1778710635;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfr30T6tqHaO7a3SCLT7jY8vD2D/utKjmwMe+SOIuSU=;
 b=c0UJtDDgEZziHcGMYI9HkLa3q6OH2F3LiruGPQDwOR3qGvLbQWOYhxMaYdHGkW6ilQ
 BLu7EyJGAYVxPqFK09VW34lmo8fzO0cDFt3fyXFHM3D+TxsO7otAx9P0JfucQKTPMQ21
 Jv7LpKOxqdv613EX49OJo527z4YFlngaPlS9ZhblAL0pTp8EYh6bZ9xRfY8Nd+FVNLot
 03faJzbHLtT1olkrNR/1Z3o8sUDDs4snNYeWJPOStwzY0dRu1EGv12Dv2alEe9CbtpBA
 Ga4gZCPgezhMRT7+THtKtRJ7rjJiXhaLMcPCarkfINg1lgM0h4hBhPjYkJ+kR/NQIIYt
 d4Eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9luMaOLXTC9jfUBZttCWmJSm6jqj+5Bu1x2dRoyBKyQLeAmnssK3bFM9WN7w92U6xXx0PB+N/JDPqi@nongnu.org
X-Gm-Message-State: AOJu0Yy4+FN9UM1sHy+GEyXpwga5Utwkl4sjunywJMXF4F4Baovj/fU0
 UlmLxOejOCgsng7btncjDaNzi8dgSaXKRv3bCOfGIx4drUuEGaXj9zZsL71wAU99SczAK8ZMbJS
 YtlXY1j6aOBTgpfpuNih6lh5Qa0u3NQM5UHY8jwyLMGHpC7Bgy2BTcrxGQQ==
X-Gm-Gg: AeBDiescEJyXLbVvSQJhB5oBI3yzxEjBT0pgTP6BqjjZlee7suJ/obgQ0ftTAFAN3xb
 GxcsRyemEil0rTOUHkYnczvZaNuFjlAVTOiXEH1zmAEx+lniJBvSQt3Rt4xOAy7QYchZAqFcPpa
 UAqlg1WVfkKG+rrdNUyV5uc9PGxhkz0cMS4l8WZCENGebCeLWWDE1Hfnsv1cBd0PIy4ws4aQceK
 deS2+qoPUk+uYI3Dj5LG9G8wiWCNT/0t/Jk7ybd6P2JQIh7v0FJ/aZriv7ZQN7V6UxJW/oT03Ll
 B4NBTXApIBzUciwWXIg1kuXcPkkUgbxEbC0Z495280yF8dREv64Y3SmJwBXYR7jeR0V8lQ6W3xU
 IgdKSXCRjC+aqAD3r96qZ1MyT0Rt0bh9u8GHfTRGSI7erKMg8Yz/TclyGLebigfC+timI8eD4O/
 FgTHiFMlCKX2yIc3/7HBzQsfOX
X-Received: by 2002:a05:7301:3f16:b0:2c9:1943:e7ff with SMTP id
 5a478bee46e88-2f54b35fb00mr2630618eec.10.1778105834685; 
 Wed, 06 May 2026 15:17:14 -0700 (PDT)
X-Received: by 2002:a05:7301:3f16:b0:2c9:1943:e7ff with SMTP id
 5a478bee46e88-2f54b35fb00mr2630591eec.10.1778105834040; 
 Wed, 06 May 2026 15:17:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm4846025eec.30.2026.05.06.15.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 15:17:13 -0700 (PDT)
Message-ID: <4a46393d-08be-40e9-8f52-788d46ab36cf@oss.qualcomm.com>
Date: Wed, 6 May 2026 15:17:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future of target/arm "max" CPU type
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>
References: <CAFEAcA-WB+vfiHZpPut=AdEOCXacsTfrvxiGAmhaGH1abHD8ag@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-WB+vfiHZpPut=AdEOCXacsTfrvxiGAmhaGH1abHD8ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7qY6O-K5pf-hkHh2UH13Vmums8h6hV95
X-Proofpoint-ORIG-GUID: 7qY6O-K5pf-hkHh2UH13Vmums8h6hV95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIxOCBTYWx0ZWRfX6BfJutXFFLBC
 z+7SIDS4p/pnxC1qs9ZgZsIbq+eQJ+1nh3Vvpq14xOrujL7ozxteFBcmcuyiaAmcxWiZueZse7H
 iZ988I7Myz9UFCtcSE/OkKszQw14QXmzJa1uoGlwlt5agb8Wd9mk2vW3jaolHZod9YUtKoMtQjd
 c4/ww5C2ZSYMXiFxOketeuqYQ1sGUcPK4bZRqDaX8zGlD9sM8b8hUEYoHdy2C7LySyNy8VRq9kB
 IjLM5/hhssUWmKioUQNO/d5IjAdIJtohxLoUGvwPn5yN5Bhc/howCmdSpjzpRnC1oUEXgDINn+P
 4Fz0xG0pmGBTl0lZnYJ6uLyjkj84pdZUfwYLh2yvY8Fa555rahQ670PAQ+xB3m/kJ0YM9/w7/+B
 Ug91NlNKAl/XRiTB5tNoszUj8mMCRY8TVNIMFoh3yxvcRSXfJnUmkGa1VqEk2H7Xb/3n+4qpFSc
 Sn+kwWTiECBQHA3gEoA==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fbbdeb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=6x5By2YnlfchJYQ9f5wA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Peter,

On 5/1/2026 6:26 AM, Peter Maydell wrote:
> This is something we've discussed before. I don't think I have a very
> solid grip on it and I suspect I may be missing some parts of the
> "problem description" (i.e. what are we trying to achieve) and perhaps
> some implications of the choice. Overall it feels to me like a "no
> obviously correct answer, make a tradeoff" question. I've written this
> up to try to clarify my thinking and canvass for opinions and for
> people to point out what I'm missing.
> 
> For a long time now the arm targets have defined a "max" CPU type
> whose definition is roughly "all the features that QEMU
> implements". This is helpful for:
> 
>  - giving us a way to provide newly emulated CPU features to users
>    without having to define a specific named CPU type matching some
>    hardware that implements the feature (which might not exist at the
>    point we add the emulation, or which might also need some other
>    features we don't yet support)
>  - giving users a way to say "I just want everything"
> 
> Mostly this has worked pretty well, I think. (It can cause problems
> for some workloads that break when a new feature is added; TF-A
> firmware seems particularly prone to this.)
> 
> However, it doesn't work so well if the architecture decides to drop a
> feature and mandate that newer implementations may not implement
> it. Up til now that hasn't been a big deal, as only a few very niche
> items (like FEAT_DoubleLock, an old mechanism for quiescing external
> debug before a CPU power-down) have ever been removed.
> 
> With the Armv9.0 architecture, a big feature gets removed: support for
> running in 32-bit mode at anything above userspace (EL1, EL2, EL3) is
> not allowed to be implemented.  We've got away so far with ignoring
> that requirement, but as new v9.x features are added, they are
> designed under the assumption that there is no 32-bit system mode
> code. For instance, the GICv5 CPU interface defines only 64-bit system
> registers, and our non-compliant "32-bit is actually there"
> implementation would give you a 32-bit OS that couldn't handle
> interrupts. Other similar (or harder to spot) issues are likely to
> also turn up.
> 
> So my suggestion is that we should have two new CPU types:
> 
>  v8-max : "all the features we implement that are valid
>    for the v8.x architecture"
>  v9-max : "all the features we implement that are valid
>    for the v9.x architecture"
> 
> v9-max would not implement AArch32 EL1/2/3; v8-max wouldn't implement
> any feature the architecture says is v9-or-later.
> 
> For the existing 'max' CPU:
>  - on qemu-system-arm this would be a synonym for v8-max
>    (since it must be 32-bit)
>  - on qemu-aarch64 and qemu-system-aarch64 this would be a synonym
>    for v9-max
>  - on qemu-arm it can also be v9-max, since v9 doesn't drop 32-bit
>    usermode support. (Though we don't currently implement qemu-arm
>    max this way, so it might end up being effectively v8-max until
>    we get round to implementing support for selecting AArch64 CPUs in
>    qemu-arm.)
>

This seems like a good approach. A side effect is to solve the
duplication we encounter for the single-binary also, by correctly
deduplicating QOM types associated.

The concept of having a "max" alias that maps to a specific type (in
this case, distinct depending on the binary) could be used for other
arch if needed also.

> I don't think it's worth claiming 'max' as deprecated and dropping it:
> as an alias it's trivial to support, and there are a lot of workloads
> that won't ever notice this change.
>

I agree.

> It's possible some workloads currently using "max" will need to switch
> to 'v8-max", but I think this will be rare: it would have to be
> emulation of an EL2 guest which is itself 64-bit but which runs some
> inner-guest VM within itself that is 32-bit. The failure mode will be
> that the (outer) guest will report that it can't run a 32-bit (inner)
> guest (in whatever way that hypervisor reports that kind of error).
>

That's a good solution, and only a small minority of users (the one that
has to really deal with this) will be concerned.

> So that's my sketch of a proposal -- what do people think? What
> have I forgotten about?
> 
> thanks
> -- PMM
> 

Do you have a time frame in mind for this? It's on the path for having
the single-binary, and we can help with it if needed.

It should be a pretty straightforward change, just renaming QOM types,
and adding the "max" selection mechanic.

Regards,
Pierrick

