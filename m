Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A1CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HuX-0007zi-Le; Wed, 15 May 2024 12:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7HuW-0007zX-9X
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:55:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7HuT-0003ei-Uo
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:55:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420180b58c5so24332555e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715792119; x=1716396919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f5U+kzbsNxM53h5jTC+vM9rYS70UupvlWdmghJNSuM4=;
 b=ZmmXsqQo4s3hes/ye3YV4s5tJDr1bDXO69ca+fMOyBecuLvVgleAC0nuAK6Wr855zj
 xrPb85aBP+GlyZB9/Yw97smY7P3Uu6QH4VaiJz34lXH77zLP165+dmulzJhR34N42qZA
 dukvHKEf1L5vPEyySZUKUtbF6zu2edg86H+aUBrjxihWf8oUb4JWR1SEFkI2lYY5XvBK
 QXjoKtOgejzdW3Yvz4IsvOiIDvNBLlsUaujjaOzemNE4JCTxrD5S45tWMBUMyxONV3RC
 XaC5a75hu37h4UCGMoSYDhTzIilzJbN2yUtP+GjlkCwyAA+bjbdHh7BPb3WtGddPANIc
 MjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792119; x=1716396919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5U+kzbsNxM53h5jTC+vM9rYS70UupvlWdmghJNSuM4=;
 b=ugSQ5ONClaR4PDW1a8KveofMfwHKPQZZGS+PrN8SLft3fUNzyXbhT7EShmmJ/sdjPW
 2oEEklcf+dJKBSNWWlCWbSfsa++je7sLIJvEf5I7r0ipSzS5HV6234k91JybY3RG3/pI
 eVp5jIao+tSSQ2K3zL5SdtM/7RZ0L0sAwc9Ze4oIV/0cgMRqsaHxu8aNAB1YyQoBtd3R
 FL4YYMv6g0kM3ufgycgpN3TWLg06MgOjtEIMEc5xGY4Yy0TJD1M1uAGtGk2mmP6BIehn
 FRERLRDLTcmtjPtTjE/Wm0yfrkpFWBizxDZSW/bgpcFGN29lv6hSGXTI+ucRwYlahZc+
 SEIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmTWTIGKgQqe/3xAjqssfjclO0+J/iZungAh1nbIWXOJQaqjNAVHFqcJaOi4toJ1WJNEAYd0CpeY7rF3PQioT8mq/kWX4=
X-Gm-Message-State: AOJu0YwJOGYE0PqY1Ao8fF1IOjIDQouGG1kRElY5XnXF/WLE3ufUGIzv
 SRjjRbozm6GbKFFgYBMM7iACoz9/VLRd258BCZPC2U7svTesHdwfLQPsWJvbM0U=
X-Google-Smtp-Source: AGHT+IHsFaJRs3LrKmxRdeO+NCHs/Uul3HTkb9GWMMfj0lwALNtNUoOyl1e/z2mdDnxohuwWhA3EdA==
X-Received: by 2002:a05:600c:4f4e:b0:418:969b:cb37 with SMTP id
 5b1f17b1804b1-41fead61f2fmr129595505e9.39.1715792118256; 
 Wed, 15 May 2024 09:55:18 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42012276231sm139714365e9.26.2024.05.15.09.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:55:17 -0700 (PDT)
Message-ID: <cd4fff5b-809a-46dd-85b5-5b4d6b5b7573@linaro.org>
Date: Wed, 15 May 2024 18:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] ppc64: Fix <sys/user.h> include order
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-2-richard.henderson@linaro.org>
 <e24b2563-b2cf-407e-a4b3-e0c5ef847ef4@linaro.org>
 <7af9d602-8252-4e94-b34b-a194f1f5e9ae@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7af9d602-8252-4e94-b34b-a194f1f5e9ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/5/24 15:53, Richard Henderson wrote:
> On 5/15/24 15:11, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 11/5/24 13:53, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   risu_ppc64.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/risu_ppc64.c b/risu_ppc64.c
>>> index 9df8d58..62cf6aa 100644
>>> --- a/risu_ppc64.c
>>> +++ b/risu_ppc64.c
>>> @@ -11,9 +11,8 @@
>>>    *     based on Peter Maydell's risu_arm.c
>>>    
>>> *****************************************************************************/
>>> -#include <sys/user.h>
>>> -
>>>   #include "risu.h"
>>> +#include <sys/user.h>
>>
>> What is fixed exactly?
> 
> I don't remember (patch dated in 2022).
> It is probably a #define namespace issue with cfarm hosts running Centos 
> 7.9?
> I suppose I should investigate, and drop it if irrelevant.

It was just out of curiosity (I had a quick look at the headers
and couldn't see anything obvious, and other headers also include
system headers before "risu.h").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


