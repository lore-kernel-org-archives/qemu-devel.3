Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3C5C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGz1-0008D3-UB; Mon, 17 Jun 2024 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGyv-0008B1-Sx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:21:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGyt-0007Jp-S1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:21:29 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7042882e741so3727216b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718648486; x=1719253286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=547rbhcPZrKk7LmWNv4ISRu960rjBXjWOlp8Gx3hYJY=;
 b=IEq4M5GveUhYuULvjk+0zf9diF16bZC/TxTtsTCz5vlj7La/wswzbohz0nwGV/F1xW
 Z3u7wpV1oVGczdS/BGS3ctGCPZXh5ho2ayj8n807/ztwvUYg+lTeKVGzzzSzVqBIxgIT
 t6pCWHUnVW8mfvwrwaYQerAXcgsELxfNY242+DNgtpX8omH/z8IkIdb/utME9P5Xe33N
 VRwxGFpDa31qie+ytKEOBSboKL7TLkFLsUrWa5WXMRSj1bkIKqrAq8csITTh1dyuvIeB
 j1xPmq6agQFEbvm90mR4CUvnWwITlJ+KKzzVyj1KmV0hcHBFbKPfiPO9Wi4E2sKidlmT
 GBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648486; x=1719253286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=547rbhcPZrKk7LmWNv4ISRu960rjBXjWOlp8Gx3hYJY=;
 b=YxFfXAxnn1QjzKe9uGbBBLry1Io/MOFtAWP3lGyK+owG5gIbgbpnGEMdNTKAtrAmcY
 nhuKVxycTrLdyTgDT30NDmMoKxvjOO7kEC0hJ4bzDW2ZBVtxuyzR++RjAsIljpFbur1R
 uAtRQxK4JV2t9C9p8ER6EytHN/Gv3bL5oCGZKQvWUTkEs2XPo0m3TrTCmk3UpJEsI5/0
 mPKHJ0LxI1wAmv9uxwkdMbErIp/9L3O6A9gDB5iyugOcFX8NfErsEV/KDsE3CBLglSyu
 VjE40pkeUVGMSdB+qXhIrzI+wy5uVTn21cmF0p0SONuE7nA+yjUA4X3uXTy0C2/gelmc
 uY8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwoPuaU6Sk0gIYYT9Govn06I/QjZJ+WsksioTLeiowBQs+2DySmSOtr2BoxK0jQfuROcmpChQdVc74eOgk3F7nvoXCbTM=
X-Gm-Message-State: AOJu0YxPE5fJudd4H6KQ7YdFRKU3vwj3F4yN223h5EJcR2YcTeJ/TGNO
 IEuhng1CubWFxAEYs1C+hxvoHU5c8BKQno93G5tJDlY8qTCmdy2DNmtdcAiw4AE=
X-Google-Smtp-Source: AGHT+IGnvS12MdQz6dK7Vef2eGRBferjLciH3zY0TbDKsZknI4wQDYFJmO7og+NvF6/69DIo0TcmlQ==
X-Received: by 2002:a05:6a20:e609:b0:1b5:69cd:87b with SMTP id
 adf61e73a8af0-1bae7e3cbe1mr9735409637.4.1718648486263; 
 Mon, 17 Jun 2024 11:21:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb98380sm7574241b3a.215.2024.06.17.11.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 11:21:25 -0700 (PDT)
Message-ID: <b6b26e50-ad06-4d07-a8ee-f13d0a1a5b63@linaro.org>
Date: Mon, 17 Jun 2024 11:21:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] os-posix: Expand setrlimit() syscall compatibility
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Trent Huber <trentmhuber@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
References: <20240614210638.5959-1-trentmhuber@gmail.com>
 <b9ed9c39-349d-4397-9b05-d7faa5b95fa2@linaro.org>
 <781afc0a-6ae1-4122-8a2d-8ca77191983f@tls.msk.ru>
 <506a5c94-b9bf-479f-88b1-3c87ece9b9d9@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <506a5c94-b9bf-479f-88b1-3c87ece9b9d9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 08:15, Philippe Mathieu-Daudé wrote:
> On 17/6/24 15:07, Michael Tokarev wrote:
>> 17.06.2024 10:19, Philippe Mathieu-Daudé wrote:
>>> Hi Trent,
>>>
>>> On 14/6/24 23:06, Trent Huber wrote:
>>>> Darwin uses a subtly different version of the setrlimit() syscall as
>>>> described in the COMPATIBILITY section of the macOS man page. The value
>>>> of the rlim_cur member has been adjusted accordingly for Darwin-based
>>>> systems.
>>>>
>>>> Signed-off-by: Trent Huber <trentmhuber@gmail.com>
>>>> ---
>>>> The previous version assumed OPEN_MAX was a constant defined on all
>>>> POSIX systems--turns out it's only a macOS constant. This version adds
>>>> preprocessing conditionals to maintain compatibility with Linux.
>>>>
>>>>   os-posix.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/os-posix.c b/os-posix.c
>>>> index a4284e2c07..43f9a43f3f 100644
>>>> --- a/os-posix.c
>>>> +++ b/os-posix.c
>>>> @@ -270,7 +270,11 @@ void os_setup_limits(void)
>>>>           return;
>>>>       }
>>>> +#ifdef CONFIG_DARWIN
>>>> +    nofile.rlim_cur = OPEN_MAX < nofile.rlim_max ? OPEN_MAX : nofile.rlim_max;
>>>
>>> Why open-code min()? (The man-page also suggests it).
>>
>> I guess it's because stddef.h isn't included there, so min() isn't immediately
>> available :)
> 
> I see os-posix.c -> "qemu/osdep.h" -> <stddef.h>. Anyway,

We also have MIN in osdep.h.


r~


