Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFD606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JEusUXqs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFoO-0006f3-VM; Wed, 25 Nov 2026 11:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFoJ-0006dJ-Ad
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:25:31 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFoH-0000k0-Ie
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:25:31 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so2947893b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795623928; x=1796228728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GPztONcZ8lwC49iucjg4RSLO/t2qSmbeUaOqnC1Zkc4=;
 b=JEusUXqstGgxkFcU9qdRZr5DluJV1iar2rJw1pbTrET0kUuGFWYuEzV374w0N6A553
 PYCPv5EySw9pUycx29jehokFcRUXA4NmfiQGNkTfXaLbmFZddFyxhjbWMS0tnKKVQfWz
 Or2eWkdQjJuCchkwessdPA8cpV90p+oL5+7FJccfAVmGbAGkAj982W4OHRkviPK1JpmX
 i1dFHwjylhmg5XJliP6ahm7ixBtyY2Esu9fM88kBRcC+OGbzx3yUh46/OyD2RGzcZYN4
 KK5LLUF4S2S8I+OIa81x39n10fD6UgujNMvklIKEZQ0hLp1TG9vc2ggehXZb2oCIGIRk
 yDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795623928; x=1796228728;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GPztONcZ8lwC49iucjg4RSLO/t2qSmbeUaOqnC1Zkc4=;
 b=Mnr/s3a5m/xBLroRs2diHDAMkpmZMgfdbv0jm9MZ+yYZGRflr21iEjGFWAArTgKwqH
 QLlIeUdhTzr09CJaIuxzah4gOchAuHKQV8ucB9c1Jr3T6ZhNJQxi2cfaYO9obh8LTMO0
 Hvdb4+uIkamWnvSblqSMNuFwZOERpPBbCQo7KSG/kDARBBXcSIHgzn8SiAlnbidNTTFF
 kGCHCVxrowE314fW3d1T1wMFpk6KUkHnlHy7QvdfRr8625UOtLKCcJQ98/qnWgWKlKen
 4XIwfx5aABqMCtNcoAU7zBpA5Q9gDvcC39bMGk6GiBfwpevbr3+CAtwUJa3kekBktk7M
 v5Qg==
X-Forwarded-Encrypted: i=1;
 AL+hErEzTCKVlbUSeVsCWDId9j4U/eHJju5D+owGaJXye1MzczIGTqDJU5HIDo9mXop5uFgquadcWkDZcBpI@nongnu.org
X-Gm-Message-State: APuU4Z92yEvSfcnVVwDcmBtoTMEFK8I+wUHOjyiwyZzmDdhhAFAcU+cs
 NpGXiXakJFnEw8eM5P313Gv9S+GBqKlwmCAm3ZfjtewChCqXPgaoN3RkuvN5rEJY4pw=
X-Gm-Gg: AZFdTZcpBwAOhy6XQkEFsDTHm8WZ6kvf1E7yTGkl2kZD8PSaliJg3vwozuatM+6rPbs
 Sh6uLjU3vya4jfAyqGikTEHq+B6ijil/bIsVc5HobOzXf54yaikv4YgYGHmbSreTbzs9vHXSS+M
 jjLosgehpg8rKA9frKEuziGZfzHVHSBzqoO0+tScyI+fCgYyB5uGxfPj/waftCMKmIi52WUOpNZ
 /jlcP2U7m8vihKa2Im1hzhfu4hck5ePDaPV2R0XcWtr+GyQaYNtPH9+C6WaMD7/7GHRIxDx/cuY
 kyFvJHE7dFv1FttUrZUSZPlVr2GwjfPfKt3g1KQcjMZ7qyO+5WQFCmQH4nYa4fSloMqqzDWP9U3
 BwxNN2DrvMk832ZYS0l2M70KxzhzYli809HaITonlvRSk0YlV7wrqlndUbCiNLDhu5OSafPE1Wl
 SpifPAVfvdMfsbEnFYjDddf4QBDjXNt+wTe27KhTR0DKa+1/EVc4qjtYt2L3ouWravYV5Pd7FVz
 qJ7d1OrMYmBjmGdSr9rAy0DIc2DTWovEhJD2O8lunOqLVT2V5PYJpEE9vxcq52QCqj2D5EfCTQm
 4mIXUCC2PtRn2u4U9THgyMJGOlp239xVOfK/Xfzl9x8=
X-Received: by 2002:a05:6a00:ad05:b0:8a0:70ff:ab28 with SMTP id
 d2e1a72fcca58-8c87daf37damr15132205b3a.60.1795623927524; 
 Wed, 25 Nov 2026 08:25:27 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077bff6sm9235422b3a.3.2026.11.25.08.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 08:25:27 -0800 (PST)
Message-ID: <d6db16f7-334b-4671-9547-6e94145e64c8@linaro.org>
Date: Wed, 25 Nov 2026 08:25:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Misc HW patches for 2026-11-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
 <903cd807-c7ce-4d44-ae74-aa81289a887a@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <903cd807-c7ce-4d44-ae74-aa81289a887a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 23:13, Philippe Mathieu-Daudé wrote:
> On 25/11/26 00:09, Philippe Mathieu-DaudÃ© wrote:
>> The following changes since commit 
>> 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
>>
>>    Merge tag 'pull-target-arm-20261124' of https://gitlab.com/pm215/ 
>> qemu into staging (2026-11-24 07:09:41 -0800)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20261124
>>
>> for you to fetch changes up to c3800302668ff745e10b810f12723eac7068abda:
>>
>>    hw/ppc/amigaone: Invalidate TBs on NVRAM write (2026-11-25 00:02:01 
>> +0100)
>>
>> ----------------------------------------------------------------
>> Misc fixes for 11.2
>>
>> - SD (card, controller)
>> - VMWare VGA display
>> - Parallel NOR Flashes
>> - I8257 DMA controller
>> - IDE ATAPI layer
>> - Amiga One
>> ----------------------------------------------------------------
>>
>> Denis V. Lunev (1):
>>    hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31
> 
> Please drop this PR, there is a issue with this patch I missed
> earlier:

Ouch.  I just pushed it.  Please send whatever revert/fix required.


r~

