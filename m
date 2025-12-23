Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E706FE6F098
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3w6-0006ZO-PR; Tue, 23 Dec 2025 10:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY3w4-0006Yh-Ad
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:04:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY3w1-0000Ei-KY
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:04:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso50513905e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766502262; x=1767107062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fHDpjuGXvGKSRCQT2esYAPbeUo3AFfx4iqRo8/vVi+E=;
 b=njNAn2i+hT7yWjwAfJ5DhdcPoCTHQs86QUhhiTiY8KYkx0yXYceVonSjug5gE4wuvF
 tuLpVYzQJufrGXh5ETYHHEaQbpSWIyhLdP0YPlxLCeAk5oSJiSQj0Vhwyim69CISh1Xa
 sYZg+wzOjHQXJ7+RQM/MCSpxwxicBfpUYmk1puZFmGK6hmdxdiBYp9z2fgQ1BFonZN8G
 VG6LsV89k0SXGoktPkXCcqBBKgyF4EIafJ9TRYhRd5axtMzf3S2JUZrWnCa8aZccRvbj
 2htJukTb0omBUfITqhRfuSm6826yl6zbGZBvB4qp61m23RMmqOnjFrMweYM9vjPygvxi
 1GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766502262; x=1767107062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fHDpjuGXvGKSRCQT2esYAPbeUo3AFfx4iqRo8/vVi+E=;
 b=DT/61QSxAu0Y0hcDTEMJSFTYTyJJpt/yBh/EK9V3qCvvQetLEN6pHcArpOgcAfzOq/
 lJWUvyCGC8Y0VVv5BnDgCKWdDY7fClPjWKOEl+AFeAin2JCyPH7o4xWqcE80MfTlPGVm
 zkmajJZYObl0lGJ6hCUoyIIefKSKZ/UeAkOdgsKnV+Yi+GexRc07SLU5aHsoe6w/Hh8g
 LMEWSLKWMaRZD4h6ZFXES7fuIUWpYoXB1WalcGXMph4MGki5f7XARZsaPHA3puvf6tPO
 0uErbPZxwWuwEi/Dopac6rqfpq+bJPRSH+MB+K67EY3ElLlCHwIMWkXdF67XBwyvsVIK
 rQrA==
X-Gm-Message-State: AOJu0Yzt22nyfY4rJXsr0zpr0dH/d08qRnQUXNCCtU6qjrALzG8lrRz3
 CkRq1j7s4Hy9EUxjxgIH+upn9apFNyzbjDz30q73cYR3nnWdnkwhHjCSq/ssU4jf5V0=
X-Gm-Gg: AY/fxX6n8m8RLoAwf4DmDZKQqkxMo3IOgatXy63T3wmmXSu5IcrnSo7KWjWsXrc/i+8
 KVGzSXsk5yMOI6q16Gy/gebW/lU9ifF8eRS3K1BPAis5R1uoDLOXhdANtSfufodbAlx0olmwWG1
 kue8M68Ynat2B8NHjguxMFPwJWu9nkookHuv1QSRdVPLxIt9uZQ7/IaLd3F3scVVoAUISMT33Iy
 bSLeUW5YJDvCW8Kyil2VInvWgjQj74nzuWZUyyh9vWHETwgQ+kXxAISmjOmoAqtOwioRzRP3GLz
 C3StIWJr3b9zantKmSYpECdCPIAsOjAd8up9lKuuFMBVJ7mHbfaeWTqnxws4mT4qT2iAIYGf2yu
 JDD+eK+qD6yECo6kMe15dtHjXTpRv+ke3cNaK9dw67OTlxOtTAMmKWa8IHqn8YVTyj1gJyQusYn
 OJTYe+AlyjrOLAblnRZ/GiLukCLC2vC+gKYFFuU2DF5i8SJkynIpilHQ==
X-Google-Smtp-Source: AGHT+IF+QHONoRX9Q3taAQdwxgUB1c5TYl3dZVgjaecb6WsqsKaCQ1RQn/mjUqArHHPlPnftJ+EVng==
X-Received: by 2002:a05:600c:190f:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-47d195a72fbmr149202495e9.22.1766502261375; 
 Tue, 23 Dec 2025 07:04:21 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm11697537f8f.26.2025.12.23.07.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Dec 2025 07:04:20 -0800 (PST)
Message-ID: <d6cd9810-b1bc-4738-a022-c3a521aca9ba@linaro.org>
Date: Tue, 23 Dec 2025 16:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20251126210832.34011-1-osama.abdelkader@gmail.com>
 <0d6a818e-1007-4e98-8504-b5e88a30b51f@linaro.org>
 <417ec469-91e3-4025-941e-f1587f5ebb15@linaro.org> <aUqnr9n_IvFq_zcD@osama>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aUqnr9n_IvFq_zcD@osama>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 23/12/25 15:31, Osama Abdelkader wrote:
> On Tue, Dec 23, 2025 at 02:57:34PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Osama,
>>
>> On 23/12/25 14:51, Philippe Mathieu-Daudé wrote:
>>> On 26/11/25 22:08, Osama Abdelkader wrote:
>>>> qemu/target-info.h is included twice.
>>>> ---
>>>>    system/vl.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>>
>>> And queued, thanks!
>>
>> Actually we can not take this because the patch is missing your
>> "signed-off" tag, see:
>> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line
>>
>> Replying with "Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>"
>> would fix this :)
>>
>> Regards,
>>
>> Phil.
> 
> Hi Philippe,
> 
> Thank you, and have a good day :)
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Great, patch queued again :)

Thanks,

Phil.

