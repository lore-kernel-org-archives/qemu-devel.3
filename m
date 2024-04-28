Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12103C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 20:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Aty-0004Xx-9X; Sun, 28 Apr 2024 16:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Ats-0004XI-Dm
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 16:13:28 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Atq-0002g6-Ld
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 16:13:27 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5726716a006so2019135a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714335205; x=1714940005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O6ndXcjZ1uhjC9iOXqQtViQr00wGjNx4SQ9xRIB4zz0=;
 b=hHRM+b1GkRiqi7SgOOVesz+lklOUF+b4VXUuPV4/qDyNoCch4I8k+w8ddbuoDy4V70
 Yizsa/wl9QsZln2rPFdSrySJMu23/v6kzpkd2TOT11g56OoDG4yCF+8ETfzD8fpCf6AH
 /OsDZckzJrUbKGuCCc6iGf5YwWjvJyCkkcEIM6sli2u37fE2MYwwopz8Pm4+6Nk/sFoH
 xUQ9p8NTI5jEvBa51WaQJ9ocCIU13aU0aulN1oClWtuSELGPiky0R/GctqA2Pysu61il
 9gyfMTbBQmEM2rb4ohgpxXk4N6vfqSRaZYqSze/ZBOeAWyoiO8+FG6/o51+weiJg9dkP
 jrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714335205; x=1714940005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6ndXcjZ1uhjC9iOXqQtViQr00wGjNx4SQ9xRIB4zz0=;
 b=fk1Ha/5xKacdEA4klNBkldXCIV8SBoU/cJvypHy3DAVg1tlFO5ECxqjZnF7TbqgbXx
 9GwDiLV4VJrYpR5ZPvqD01QgrWdLJPhedLTzQJ3yJX0ullvmthC2/krW6JrdKfjTn8xa
 lJyaZYxdgqsYRpE9FnBaTPOCR4u2HGUKfbNyhYBm1eT7mTmJy5LGiRQBAKA2nYKJzCkt
 tyaZG7IJb215M0rrAmU2eNv4FSPDVv4ASr8GRdSBefb8V9zXMAkqCxNwSzFkph4MwnLM
 iNQcUVlVpU8+Hn7vSPvqpBUCoKzzIsjzpFhgKtqY0HdEE8swLyfeP90mP8G2xkDYeeUb
 1WwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO9VXL971ez0fjGqJ3xkwCfoPHYY9Y77P5fU3HI1J6ZD3RNaJSan/uZxFBSTIaCutcBurmeaaVEKDyFUiiow3WvWF3X/E=
X-Gm-Message-State: AOJu0Yx/tupy+hrITCCn3sRGsAgHk3uwuRYufmEFi5E0YKW0FwYkshKs
 nQyr6IXaflJHrDbu+7zvNJunA7kXBbGeDIw0fp+sE/iP7ItUsQAM3jsS/8ffd4fo99ka6EK9L7M
 3
X-Google-Smtp-Source: AGHT+IFRRryKAyeLUtUJOUzF0l9HFtZuPLj0RMKG6OHnFb+Tnx6dNQuT1LynIy6Bpeu8x+kRJxvJIg==
X-Received: by 2002:a17:906:81d5:b0:a58:871f:8eb0 with SMTP id
 e21-20020a17090681d500b00a58871f8eb0mr5984936ejx.7.1714335204551; 
 Sun, 28 Apr 2024 13:13:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 cf8-20020a170906b2c800b00a58d14479adsm3067736ejb.59.2024.04.28.13.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 13:13:24 -0700 (PDT)
Message-ID: <47c109cd-a79a-43b1-ae48-38a59435659f@linaro.org>
Date: Sun, 28 Apr 2024 22:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] exec/user: Restrict 'syscall-trace.h' to user
 emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-11-philmd@linaro.org>
 <cef95745-f6f4-4485-be8b-9f833fa49126@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cef95745-f6f4-4485-be8b-9f833fa49126@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 28/4/24 20:32, Richard Henderson wrote:
> On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
>> System emulation shouldn't use "user/syscall-trace.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/user/syscall-trace.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
>> index b48b2b2d0a..6926434d9a 100644
>> --- a/include/user/syscall-trace.h
>> +++ b/include/user/syscall-trace.h
>> @@ -10,6 +10,10 @@
>>   #ifndef SYSCALL_TRACE_H
>>   #define SYSCALL_TRACE_H
>> +#ifndef CONFIG_USER_ONLY
>> +#error Cannot include this header from system emulation
>> +#endif
>> +
>>   #include "exec/user/abitypes.h"
>>   #include "gdbstub/user.h"
>>   #include "qemu/plugin.h"
> 
> Are we really going to do this for all include/user/ headers?

I'd like to, there are only 2 more files left,
user/tswap-target.h and user/thunk.h.


