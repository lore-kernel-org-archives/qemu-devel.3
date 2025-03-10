Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899E6C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfdX-0003XG-3Q; Mon, 10 Mar 2025 12:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfdD-0003Tg-K4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:05:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfd9-0007QK-SB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:05:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22423adf751so62838385ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741622726; x=1742227526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YbY1/Z51r3gprkh+zmquFe1kI/774Z28NatggBtRhPA=;
 b=SvddEHqEtn4dIDMj7G+ni8uINZSWLarEMicqigReCUV0/eskRpGfAYqg6rTmRApj7F
 rSyJZn7hcnX8+OLYt/6UnqUFuJOr/CO9GINeFBexu+McYOokZ45KDZisWTQJI9ndHSe3
 J2vW5TcFlEwSHBJhUyOT6XaVsNapx3UJUCyVC4iXsB0nvoAwv9HJqRue9GyP73PLbSwK
 UyBV1QLnM79z4+SdkQLj5m7Bc6jqpqHVSyc/t8bzpT3cdAIenDluEpxbLr96Qq5anfGX
 7h6ioIj2/Jg0HVsACsUQsYRU+MfqWKx2oUnUbr8RXkk8cGmX38AsXpXv8r1NYLfAVR+N
 1dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622726; x=1742227526;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbY1/Z51r3gprkh+zmquFe1kI/774Z28NatggBtRhPA=;
 b=aMdgc9p/4MZlKZhe4Gq/7vUeE10k23qbTojMvJG2cv4cBOqurEE633xIha/3N43qid
 VfrLGESllPLrVzMCUNrNYxr+eBrjS80oiwj0plGV7ZPyKRs63Ono5aK6dt19OfK3woQ0
 1y6NhSIckGLLfT48ACbCQatergqKp+ZVFQRMckf+gqT+GpBpFUyTo2fsFfCg48zL7GIa
 pEkl2e6dKMURGmfWoAOj7VRftQcRipYRjyDaSr6NPov8al9v8pjhhkw/1st8dboNuYbv
 nNpT4fGz+tlQ4hjblBmrhMNEBt8nlgVqoatxdNZmEms3Drx5f2vhfrLyb7gRfLrSmDI6
 gV4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQDDvDfBV3WumJWyVVdy6bI+t/3wjzaUqUKJbgKBv/Z3vmhEMOlpFYAjuGd6uhXOqroVkzR97mgd17@nongnu.org
X-Gm-Message-State: AOJu0YxELj2cn4Ml3JQKlxk5Mi/731tkQXTzzJrJ6Wq1NcfJCMzgoKWa
 pdTCRnmt4y64A3nQawH2cdJEJFU7FDYaF4mJeCIS31FFZranaIL06qNSLtFVG40=
X-Gm-Gg: ASbGncsmwM+eCufvfpw2kSnaEaslTg5xS9h9aX3HWeLqxxhhHv7X7YFHnmnbLm/EN4n
 wq6pJNxLJetSQ0qrPo/FC46/x+PjMsHUJoXOGVRFGGwneiOrN61Pwk0yzRaKDvOhGbbJrS7upTm
 75IfvnIiODtyxeJTEDjLJMcdFHC+chR576iwISpXvD/SoBwRJ61s9yIhUt1e/ejPKveklE2j3jN
 JQUVQQ+fHCcHOFn7xwGC0aYwdeAAJZsG/PBltBZ06xr3GQ1w2n53xOr7lf7UjGg1T1uOsrkmi2L
 SSS99mL5YHkJe7C/3LILt7OUhveviGvxRJ77wpgJPaqdd12SUPVA2Sn3IQ==
X-Google-Smtp-Source: AGHT+IGQ73ovDK31rg6k5ppKMAseDZTGlV8ErerAzN3t3+ed0JQzVL7hV6f2vs/d1aOP1vg3eCmbEw==
X-Received: by 2002:a05:6a21:497:b0:1f5:8179:4f42 with SMTP id
 adf61e73a8af0-1f58caf4c7fmr578043637.6.1741622725872; 
 Mon, 10 Mar 2025 09:05:25 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b11bff3fsm6725526b3a.67.2025.03.10.09.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:05:25 -0700 (PDT)
Message-ID: <6a17647c-cafa-470f-9b00-1d036d799dec@linaro.org>
Date: Mon, 10 Mar 2025 09:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] include: move target_words_bigendian() from tswap
 to bswap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-4-pierrick.bouvier@linaro.org>
 <c5ff9020-8780-4358-84e7-0b729d783008@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c5ff9020-8780-4358-84e7-0b729d783008@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/10/25 08:21, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> This is needed for next commits (especially when implementing st/ld
>> primitives which will use this function).
>> As well, remove reference to TARGET_BIG_ENDIAN, as we are about to
>> remove this dependency.
> 
> Where is the TARGET_BIG_ENDIAN reference being removed?
> 

The comment part removed, during the move, is:
"Note that in target-specific code, you can use
  TARGET_BIG_ENDIAN directly instead."

>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>> index b915835bead..ebf6f9e5f5c 100644
>> --- a/include/qemu/bswap.h
>> +++ b/include/qemu/bswap.h
>> @@ -1,6 +1,8 @@
>>    #ifndef BSWAP_H
>>    #define BSWAP_H
>>    
>> +#include <stdbool.h>
> 
> You shouldn't need this.  It is included by osdep.h, for every file.
> 

I'll take a look at that.

> 
> r~

