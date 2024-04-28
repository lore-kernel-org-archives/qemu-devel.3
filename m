Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D653AC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19Ki-0002U7-KS; Sun, 28 Apr 2024 14:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Kg-0002Tg-Tq
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:33:02 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Kf-0002Zq-GI
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:33:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so3079021a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714329179; x=1714933979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UEKsQH/gh0x9KdkeGPUdBWKIQcK1c1vHkoyErCzn5f4=;
 b=MJAf30UihFrHywQatJu4pjEEQKF5zRU7JzwNqTi6k+bD7tJEQ3UkIShrgKnhc55m0y
 P744bP1hEDRtOb2YR3G8x61vJNqzlJ5z79anDD9ti18K2kfCrRYieC8Y4OfmA60G2pun
 eFIV9MtjjPyZAvdSyVY+SOgWxJsVPSSf6B2K6Yk9407ctvFuakjDoeEb9SbQGeS3Y35g
 cOgoT4m7ETOub+amL7+E4KptMzaJOUIvRee3UFumixnjvbDxcZ1OLkwUuPADx8uhwyRO
 VaO9Q9cZVQ3i6G/EX0cO+uv4ZC9d2AfLlmTdDcTkWI+4SlKH54Mb5p6RKDnv8CUK3lLZ
 IDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714329179; x=1714933979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEKsQH/gh0x9KdkeGPUdBWKIQcK1c1vHkoyErCzn5f4=;
 b=PMZA48VSDnRQw58W2Hywfz7DtMphAQvJZrEoykM4NpNoBZgno/BT5lQRDnVsEFiPKj
 Go7ZCeXI56QyppSTvmc9sQ9ZDef/AtDzpcze9qzgNblQCXwB0OiiapSjtGdDD4zNhMjw
 dHFoGf3jlxTtHL9Ox7A4PLHOfRmbaXICz974QvKm8IgsC9W3476TZMuHZGXfwRvTdFSe
 xOYrTILFxdJZh7tUGhkIzjxzfxb3UgOQGSStjnmuieQH+uOYF9TlHXlMDHHxJf1DQzwv
 cWiAeJKe+NOki+ivsscptHwFnF0aBev8X8Fg3Vi+Iuyi/D3qWuLl7qg9kEgvuEID4rzj
 mmkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsCiu8IGQHpCTV4scmcnLurpXcejTKW5EXjZST7/sz3ER4Ckn0H3IKNljTt3vIRC5GBzB7mQQ6zB0da17uOBgp3zPBMkQ=
X-Gm-Message-State: AOJu0Yy74mavDIIRK/226PCwhlhYhdNh6tGr+5SRCB9lnH4Vxz1hHiih
 f8nIy760tH4YNMgAYiRmrLOeFvhlfAjENfq8+/gjw7809hEZ2QwGA8TVCi9X1M2XrxM81vkh2rt
 G
X-Google-Smtp-Source: AGHT+IHBSf2QEaGssjoclwo9IF14n12IS+gVBHKXxGsEJ1+FHouuxO+JxYH+FYan9+E/bbioXSFJgQ==
X-Received: by 2002:a05:6a20:4309:b0:1af:45f7:6dff with SMTP id
 h9-20020a056a20430900b001af45f76dffmr2331507pzk.42.1714329179240; 
 Sun, 28 Apr 2024 11:32:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f33-20020a056a000b2100b006ecee611c05sm17933141pfu.182.2024.04.28.11.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:32:58 -0700 (PDT)
Message-ID: <cef95745-f6f4-4485-be8b-9f833fa49126@linaro.org>
Date: Sun, 28 Apr 2024 11:32:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] exec/user: Restrict 'syscall-trace.h' to user
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> System emulation shouldn't use "user/syscall-trace.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/user/syscall-trace.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
> index b48b2b2d0a..6926434d9a 100644
> --- a/include/user/syscall-trace.h
> +++ b/include/user/syscall-trace.h
> @@ -10,6 +10,10 @@
>   #ifndef SYSCALL_TRACE_H
>   #define SYSCALL_TRACE_H
>   
> +#ifndef CONFIG_USER_ONLY
> +#error Cannot include this header from system emulation
> +#endif
> +
>   #include "exec/user/abitypes.h"
>   #include "gdbstub/user.h"
>   #include "qemu/plugin.h"

Are we really going to do this for all include/user/ headers?


r~

