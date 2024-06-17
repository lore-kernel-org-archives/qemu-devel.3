Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A53AC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJE4o-0004W7-DI; Mon, 17 Jun 2024 11:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJE4m-0004VK-5b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:15:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJE4k-00051k-4f
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:15:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4210aa012e5so39966035e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718637316; x=1719242116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=znYenmDJyAitrpjZrWLm6TJUdAqFs2a4bvQDiAz0fTE=;
 b=CVa5jZpulVNA3PmaNbgtDyx/R7AhUDAoOrIngFXtnK3LfQzh2IvjldNqiSX3AizCB/
 TYBOPaewPRF1zV1ghOxCxQgO4Buxj5mo2RrAZCM+O/n0Ja2gcA6N9iKN5l4nxHi1FqcP
 dWUbZDZ5seEk4FBhrzWInCgL+OLWl8IAtuhtTxZ4xHvdxtHWfZ/OQrgGKdsbGL5j2uXb
 EOcpwU0StWStMjn+xqGnw1DEHjisy2PVEABbXK7VvOGmZcMxx1xB6BJnr5VvPK6XAMML
 Fs9GhCOfQfrOMVl7W+TqzQLteoiRd3v1/60N/MUxxlBb8qUCvR18axCqyVISQFK8BtR2
 nxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718637316; x=1719242116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znYenmDJyAitrpjZrWLm6TJUdAqFs2a4bvQDiAz0fTE=;
 b=JME+eLw5pJoS3QKvASlWKyaNaViqofkcTI/2dSvjZbBhV8fLb41dclOwt4GvFdOGv7
 4JH9X5qb8d92w8P0zrsFDphTkoXKLe2S8Bq6LKKDqcllME+7n2+hxxhXA0/Z0NN6wIG4
 sokBUJxQJlz+5NdKW/mgZJx2/DpUCL094cWqRtWIX+NPgCvph4+JMjVWSNeflejphYj/
 yPsZcGIzcmAyo3qsni/KEvSBAf9JyiY3TRGeqcP1NnRXyGaHycmrjV363OLcZvW+6pdb
 JOeABjwbUWqg/pUet6U2ajvYqvi6tcDI5mVlFxhh69UsfFgx2N0KirWAyjOLTzxOBQcn
 ZVnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQDC5VTzqEzNfCRV8+zP8Y4iRrRfOLgmHB5+wDIwv/flQroJYE9PSdFGcV1Mcx2NMylneib9KGt0pJ+jLMUsM1wnkSFKw=
X-Gm-Message-State: AOJu0Yw2RTeamt0u+mrV2tJpROY0obmE1YTXe3quswU6zooPH65fri26
 1xshFVFthPWrscVsmtUkzS/2CMqfj6lpERwy4Gq8vqeoR7C0wymnnmGvHXkLpmqWL6lzBLR9NBI
 muPA=
X-Google-Smtp-Source: AGHT+IELmqvzRe3AvStEGJ9zlOhI2QCJq4V4kw9CnWIfigXDjd6Z+iq34fjTzWIFiYMU64cOLVAdBA==
X-Received: by 2002:a05:6000:1b02:b0:35f:1a84:35e6 with SMTP id
 ffacd0b85a97d-3607a768f45mr6897951f8f.42.1718637315782; 
 Mon, 17 Jun 2024 08:15:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f0d71sm12023933f8f.86.2024.06.17.08.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:15:15 -0700 (PDT)
Message-ID: <506a5c94-b9bf-479f-88b1-3c87ece9b9d9@linaro.org>
Date: Mon, 17 Jun 2024 17:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] os-posix: Expand setrlimit() syscall compatibility
To: Michael Tokarev <mjt@tls.msk.ru>, Trent Huber <trentmhuber@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
References: <20240614210638.5959-1-trentmhuber@gmail.com>
 <b9ed9c39-349d-4397-9b05-d7faa5b95fa2@linaro.org>
 <781afc0a-6ae1-4122-8a2d-8ca77191983f@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <781afc0a-6ae1-4122-8a2d-8ca77191983f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 17/6/24 15:07, Michael Tokarev wrote:
> 17.06.2024 10:19, Philippe Mathieu-Daudé wrote:
>> Hi Trent,
>>
>> On 14/6/24 23:06, Trent Huber wrote:
>>> Darwin uses a subtly different version of the setrlimit() syscall as
>>> described in the COMPATIBILITY section of the macOS man page. The value
>>> of the rlim_cur member has been adjusted accordingly for Darwin-based
>>> systems.
>>>
>>> Signed-off-by: Trent Huber <trentmhuber@gmail.com>
>>> ---
>>> The previous version assumed OPEN_MAX was a constant defined on all
>>> POSIX systems--turns out it's only a macOS constant. This version adds
>>> preprocessing conditionals to maintain compatibility with Linux.
>>>
>>>   os-posix.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/os-posix.c b/os-posix.c
>>> index a4284e2c07..43f9a43f3f 100644
>>> --- a/os-posix.c
>>> +++ b/os-posix.c
>>> @@ -270,7 +270,11 @@ void os_setup_limits(void)
>>>           return;
>>>       }
>>> +#ifdef CONFIG_DARWIN
>>> +    nofile.rlim_cur = OPEN_MAX < nofile.rlim_max ? OPEN_MAX : 
>>> nofile.rlim_max;
>>
>> Why open-code min()? (The man-page also suggests it).
> 
> I guess it's because stddef.h isn't included there, so min() isn't 
> immediately
> available :)

I see os-posix.c -> "qemu/osdep.h" -> <stddef.h>. Anyway,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Applied to trivial-patches,

Thanks!


