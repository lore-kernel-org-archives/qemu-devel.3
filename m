Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44644C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnPcJ-0004zB-6c; Thu, 21 Mar 2024 17:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnPcG-0004yk-UZ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:06:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnPcD-0006DU-Pb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:06:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dff837d674so11937555ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711055180; x=1711659980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uDg7JpxWzxo8zZq+P+MctUosVMT/EUBcSM5l9VJuqo=;
 b=QwL/wfJ+Mhu40ABrdZEzYY2Kybv80PmP7SLW8AfuDbgh+SHacitHM9R6bDPJvl21wJ
 kUTe85rN+KjtezVTCcys7HKNrCBb+xIjEKDPFFVm0SycPPrPRLs6bTabET9bYk+zwFjZ
 KwBYtc8oLcSXeskPLZ40aFc34Q93k6PurcTPwCv5TxTuFAm0AtZOerc8zEsoNfk70+SR
 JHO7wKbhVGYFEShmc1THjCd3RikNKa0Pu/40m9/shLT7IZ/NDXNPt8ANXN1qh99mBqo2
 XUlPLaPU5fLO1mFE04vs63k01pbP8HiWE8lzroS/f7UDdbKf+rXaTQEHQrYYyjDm6e3W
 G0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711055180; x=1711659980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uDg7JpxWzxo8zZq+P+MctUosVMT/EUBcSM5l9VJuqo=;
 b=NYiZnOHeZN+EJt2ohzRjRnIuui9jfxAVCBoZpQijKNrIyw82GNjtypm3TpbGUxxpBE
 iRbF/57/Hf88kgdQ+xBnZ4Mw9MZLNlcZ8DK3hnVtrR9fej0qOEmR9OXbnkc2I1W4kHFr
 BaociV3+hz/Lylnzc86kmqfERf0b+i2XIg2yHtnHcL5eep1lmcnagcwCwahHp5vFZkrM
 GVfI6ta7CsoQwI7uOSrPMCiPiGyKdkWbeqmIkdBlJ+fUDlZrayZVlj7JltyT0E4cJW56
 Nshh8RSv7xImUo8aRiHpXMnBOnUTHIaiXO0ncSJwv7kOq7lw7jhold6tHtWIuYeqhKD5
 Tr3A==
X-Gm-Message-State: AOJu0YyYGswYh1E1RNxHwuRXHUjE9Sy5+5PoyS0BessHpezpHMsVpgmF
 oorNeaUsHbUBB/R00jFeCc91cscscO+AS0zkCkc0xFmmWRKsoRBciOWlwIQGVDI=
X-Google-Smtp-Source: AGHT+IFL1nknkDv9yeyJp69KB3gZ+OiRHnjlaZkYSdC2ewajWqSDwDJhCczVuMCLBX7WTYcE9S02tw==
X-Received: by 2002:a17:902:d501:b0:1dd:6780:179 with SMTP id
 b1-20020a170902d50100b001dd67800179mr651595plg.68.1711055179834; 
 Thu, 21 Mar 2024 14:06:19 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 z6-20020a170903018600b001dd7321036csm288494plg.195.2024.03.21.14.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:06:19 -0700 (PDT)
Message-ID: <48897a44-72ec-4c46-ae85-26528360daf8@linaro.org>
Date: Thu, 21 Mar 2024 11:06:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hppa: add unit conditions for wide mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240321184228.611897-1-svens@stackframe.org>
 <134f8055-6b5a-4610-93d3-524d2f3de003@linaro.org>
 <874jczmjlk.fsf@t14.stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <874jczmjlk.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/21/24 10:10, Sven Schnelle wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 3/21/24 08:42, Sven Schnelle wrote:
>>> Wide mode provides two more conditions, add them.
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>    target/hppa/translate.c | 25 +++++++++++++++++++++++--
>>>    1 file changed, 23 insertions(+), 2 deletions(-)
>>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>>> index 8a87996fc1..f493e207e1 100644
>>> --- a/target/hppa/translate.c
>>> +++ b/target/hppa/translate.c
>>> @@ -963,11 +963,22 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
>>>          switch (cf >> 1) {
>>>        case 0: /* never / TR */
>>> -    case 1: /* undefined */
>>> -    case 5: /* undefined */
>>>            cond = cond_make_f();
>>>            break;
>>>    +    case 1:
>>
>> Wants a comment for /* SWZ / NWZ */
>>
>>> +    case 5:
>>
>> /* SWC / NWC */
> 
> Are you going to fix that up, or should i send a v2?

I'll fix it up.


r~

