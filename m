Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071C2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uNs-0006vs-Gn; Fri, 03 May 2024 10:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2uNr-0006qF-BQ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:59:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2uNo-000449-UE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:59:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so8253233b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714748371; x=1715353171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5S5vNoaR7zdTfcbpmjqWFAckKRaSQcxak5OzoM0OT/8=;
 b=PYMkiwf35QI9jhakWVPE0OQf9P7+bOSTWE+CMtrdEBjPaOI08yFNaa8X+CWTIiuamM
 iUBhQZd0V5R1CFfCsuipwhM0wem89PzmArZRNKN7eMeT3rIlNVoAwGbRoJQVoDDlY5Lj
 +xwRciaYJrkVxK/qLVDg19QUAeTFWtEZpQ4QjJ1mAPn5cQZul5HUz26hb3n6hHEYjuYs
 hPP/aszunGrWmI7mdz7z6Wkf2kHaEgkXnYrmOlxnE+j9oM9Tex7pdYRi2B6IpcX8F3XM
 tGMsyYi6XCaPVnPeaSv/J4jMSr5FUdwi0ZWUHfqXa2gd4Z5GEIBT8yspKZys2Uae6mj+
 fxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714748371; x=1715353171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5S5vNoaR7zdTfcbpmjqWFAckKRaSQcxak5OzoM0OT/8=;
 b=XhwtLGZe6lSZeRg0shMLiwFXhluyjXkA24SNsOXV7ePGH2FZ8Cv1/eXzNFjg9sl62M
 4fwmhdFE0FHRp0XD7vOSdDsorR5ck5L/FOkULpJ6esGWquQxvQGKLyu/qYq8XeQdbYjO
 BO41lhUDTMBmT2+hs8PuF/IELf7bZUBUGp+Y14t/s8Ghs7jJsNYvTRsB7P+qxGikWdsa
 BZkvd7YE9pGQ7IS94YZMm2LW4uUgLI37L+xA8tl86HBv34y+Dty0gDaMk7FwEktAh6xK
 Zv+sz3bq9Me9Nkl2Z8436xK4YM6tw9e/4ysWpSHG7FP2Eokss6l7ZBzBeFXinmU6EIzQ
 pXAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcRx16eAv07Gl40T1tyAxMZaXX8yn5BxP2vmhNCS8RbNkBriYxh5XJIEHFbRpYLsgrMzJPJ9EBqwsRlqX9lPzMMHQmjl8=
X-Gm-Message-State: AOJu0YzcF2BwPJonYyD+a7Vb5mMqlEliLvYYAUbR1E3rqH+iSHPsAk5n
 sCugGLhKydJ40tmcQF+VOeAjAvSVJoz4QIIqU2+G6RTvGfqtR1BdnzlBq9nFCiQ=
X-Google-Smtp-Source: AGHT+IEhVQtiD6zJX0b+kted15m1Yk/RbWPAGInr+0hdl0zJrQdPPuIgXOwGAWW98lbe4d0qv5Ew+g==
X-Received: by 2002:a05:6a21:151a:b0:1af:814f:ce69 with SMTP id
 nq26-20020a056a21151a00b001af814fce69mr3537040pzb.38.1714748371463; 
 Fri, 03 May 2024 07:59:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 gd5-20020a056a00830500b006eacefd8fabsm3150317pfb.64.2024.05.03.07.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 07:59:31 -0700 (PDT)
Message-ID: <2ee4256a-e0cb-4469-988b-8c7bf7e6fa09@linaro.org>
Date: Fri, 3 May 2024 07:59:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict translation disabled alignment check
 to VMSA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 qemu-stable@nongnu.org
References: <20240424170908.759043-1-richard.henderson@linaro.org>
 <20240424170908.759043-2-richard.henderson@linaro.org>
 <4906224c-b37e-4480-adc7-362ad2023b36@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4906224c-b37e-4480-adc7-362ad2023b36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/3/24 07:58, Philippe Mathieu-Daudé wrote:
> On 24/4/24 19:09, Richard Henderson wrote:
>> For cpus using PMSA, when the MPU is disabled, the default memory
>> type is Normal, Non-cachable.
>>
>> Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
>> Reported-by: Clément Chigot <chigot@adacore.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Since v9 will likely be tagged tomorrow without this fixed,
>> Cc: qemu-stable@nongnu.org
>>
>> ---
>>   target/arm/tcg/hflags.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
>> index 5da1b0fc1d..66de30b828 100644
>> --- a/target/arm/tcg/hflags.c
>> +++ b/target/arm/tcg/hflags.c
>> @@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, 
>> uint64_t sctlr)
>>       }
>>       /*
>> -     * If translation is disabled, then the default memory type is
>> -     * Device(-nGnRnE) instead of Normal, which requires that alignment
>> +     * With PMSA, when the MPU is disabled, all memory types in the
>> +     * default map is Normal.
>> +     */
>> +    if (arm_feature(env, ARM_FEATURE_PMSA)) {
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * With VMSA, if translation is disabled, then the default memory type
>> +     * is Device(-nGnRnE) instead of Normal, which requires that alignment
>>        * be enforced.  Since this affects all ram, it is most efficient
>>        * to handle this during translation.
>>        */
> 
> This one is in target-arm.next:
> https://lore.kernel.org/qemu-devel/CAFEAcA98UrBLsAXKzLSkUnC2G_RZd56veqUkSGSttoADfkEKGA@mail.gmail.com/

Yes, that was a stray patch that accidentally got re-posted with this series.


r~

