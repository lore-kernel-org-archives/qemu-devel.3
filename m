Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF91C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirE5-0006Tb-9B; Mon, 04 Aug 2025 05:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uirDy-0006R4-TU
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:11:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uirDw-0008Mv-Se
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:11:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45994a72356so9371445e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754298675; x=1754903475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GUFL+PCQAw1XecoGCIlAMwnFAQXOYe51tVUl0XTXhJA=;
 b=iBcZV2ofjtG7kckkFnPeeCtJJCpoi5u3CVcYL/Wvzqi7aSVK0BUzns+OW9JCAjTJgG
 hJ+JbwsSw9UpoQWfrCqnoGDJQL1I53a+02OprUNGQ3sW+jHelBX7l+sp+QbcrbRT3P3d
 GekiaJHXR5ZYB6MMAn+PdTbpC/rc074r+PlChGefEljYroKUwMdgS4sMDi+AVARDOksr
 xjj1z2McUdRdcfygGD2TaQhyKbGTM+/Ynn3mWWp1M2QtJPYrby70PWG1TnTpu8SWZpLd
 6E2NHNLtoL+8vIUU5AcNuA7hl2lb4odCN7IdVzsPtdThGZztqZtyojpnFpYVq11rK0ab
 tC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754298675; x=1754903475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUFL+PCQAw1XecoGCIlAMwnFAQXOYe51tVUl0XTXhJA=;
 b=O6ky94CrxOQaKIBtlwqVra9Ww1IfKh9fECAmnvpHvNndXlhZJutnIzpGLXNinuNhap
 suXf+x2/z5xYsJzuPZz/PMba9sYM7a/xzcehypc5C2/lXxwRpUJm/3oohAmRf6AIdt7M
 IR8Y4x33YPu1F9m8iHg+dA0gUj+zvFZBCYZz2mKzy0+BKsT1RVWEYCizlmO0YP9t2DdR
 jw61dvKkLRxWNodTEKZ3EBEqL/Fa4g/XP1NTzmoVo4coOyzUU3e37Os2C9Z9Q+Zehlek
 CwUkOCldAjWZ5lP9sm1DFsN+E6+EuqJIaqYwCPKIDdD439kzpSxBsOU4e33/ifFkEeC/
 qbYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1qyvSZqXi1xWZUdDiobyfTOfi5j52Fif3q3KSrYDpaF3jJxy2rohiq9GMpr9QlubuqWHpQ95hatn3@nongnu.org
X-Gm-Message-State: AOJu0YyfOPrT1ccc5L1bG0W/0grtxF9tEf+PYLNUDdC2Iv57omEnScOS
 jFn0U4ma/OPwTY++A3qrt1ANU3k7RW6xVhuV03aDKyrLdrn0k8Fcn6ZradDcaAMeSw0GCfpiq0C
 f04C/
X-Gm-Gg: ASbGncuiIK/dOhS+EVb3YUskFlp4ruogBmfj+GYlqWfDGXBG0cUxxgL7rYZbz7QTXkT
 BivH1GzerNbM5SiBs6fqmTgimp8ZMwsWdvkph6jgoHXRRXbm8/vPBfhLT+zzM1t0m+Cwl7cWih3
 hwkLJxbV2R/zRgw7pDX3JhPXWyE39uE9+f6QIp//oA9fuuis1s3mysj85aYyMB2nTzyw/ZA2PfJ
 Wd6JDpFiitLfQc4yF7Fz8biLYWY12zb4VN+KmjIEM84MWjLKFcqVnNbf2y87vy7G05btGDMXxb3
 StZm23ziJAluWinPgGQLGJcWLP88GcPN1ydRNSR5c1xl8WhEfPNxugl4EXfIykLEWR1h0dv+nr7
 Qywo3EWn+GjZtCBnPGnVqyeK7JvxSXX0YcpBuwXwsbAsUNUe4NVigUSUJSaE5NTX6BP2aT+s=
X-Google-Smtp-Source: AGHT+IGO2WhFf7DsDavKy5XubBprTwg4oOVKYn7FvmOZ/M0QaPY3qWXl86FhDH8AD7KchSz7YtoB5g==
X-Received: by 2002:a05:600c:a206:b0:459:dd4e:4435 with SMTP id
 5b1f17b1804b1-459dd4e4b88mr7291165e9.5.1754298674600; 
 Mon, 04 Aug 2025 02:11:14 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458a7c91c0esm138971055e9.11.2025.08.04.02.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 02:11:14 -0700 (PDT)
Message-ID: <c513f4ee-16ae-4f34-9183-633f622fe132@linaro.org>
Date: Mon, 4 Aug 2025 11:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 04/11] hw/sd/sdcard: Fill SPI response bits in
 card code
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250731212807.2706-1-philmd@linaro.org>
 <20250731212807.2706-5-philmd@linaro.org>
 <21dec4c1-dcf9-427b-8eb3-84ba278308fc@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <21dec4c1-dcf9-427b-8eb3-84ba278308fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/8/25 09:19, Richard Henderson wrote:
> On 8/1/25 07:27, Philippe Mathieu-Daudé wrote:
>> @@ -746,6 +761,10 @@ static size_t sd_response_r3_make(SDState *sd, 
>> uint8_t *response, size_t respsz)
>>   {
>>       size_t rsplen = 4;
>> +    if (sd_is_spi(sd)) {
>> +        rsplen += sd_response_r1_make(sd, response, respsz);
>> +        response++;
>> +    }
>>       assert(respsz >= rsplen);
> 
> Incrementing response, but not decrementing rsplen?
> Missed return?

In SPI mode a R1 response is prepended. I'll add a comment.

>> @@ -771,6 +790,10 @@ static size_t sd_response_r7_make(SDState *sd, 
>> uint8_t *response, size_t respsz)
>>   {
>>       size_t rsplen = 4;
>> +    if (sd_is_spi(sd)) {
>> +        rsplen += sd_response_r1_make(sd, response, respsz);
>> +        response++;
>> +    }
>>       assert(respsz >= rsplen);
> 
> Likewise.
> 
> 
> r~
> 


