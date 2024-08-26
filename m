Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE1EC5472D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siSwE-0001Jt-Fd; Mon, 26 Aug 2024 02:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siSwC-0001JA-G5
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:10:48 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siSwA-0005KF-BK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:10:47 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a869332c2c2so574170566b.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724652644; x=1725257444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pS8kEzdqXfV62t1UVzdfNSkHWSAZrnHabTcndmWkSBo=;
 b=sVn12oBQqJ+H8dsgsZyoP8XlsO3UoK4c/G71AK3uZZxhrk6r2Rcq3krRrL1qGZ6dww
 jhFi16avPTeHvOQm8bhD3qLgnjdSsbDmIYStDzmJ5BbTeg74VTed/7CSS/EOe31EgyD3
 x8ITfBKGAEZe5t3OZz6zgO44RemZCLrvygYVF5N0EsCTVQPCsXlY2ou78kmHCuKxfag3
 VXrX3f47OZeLHfrwn5S56eK5gPgKaGoDEFCT1NyZy31W3HEZbxdMN9R0rvKemfR2Jxup
 d3Sy64rMOsGo2nEk15+IDgpwmPq6tqQYl0K657sZKTM4RnYxIl8PWM/RkcL9bAEz2jzr
 meng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724652644; x=1725257444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pS8kEzdqXfV62t1UVzdfNSkHWSAZrnHabTcndmWkSBo=;
 b=qOW+MUSCjLzFuJ8kjt6JBwGErezbjsYNC7az1hSQSsN2Fn23NWbw0tOQav/kFoe2zW
 TMcqLcF7877mdAZl6XnVoamx6CPUZ2B7sZvVDCD3FmiMPV/GTCuSeBSCcIf9kG11iyup
 6FW/0fkWapkF5WKn7M3+Wln6l8q83hRXMoZ2Rg5gMnRpccoj6NTuPMLy9rFOrJbDNOFK
 0FX01UfeWxGb8di3EI5uiPgkbdfmlSUFRFHDkSLrze+irYxOzpcv/f94WE9X7rk1g/2d
 lYcOasFOf/orUfCevR9yJbCor9MP/3Iz70Mb+w0nW8GNAwkrqXOYOQgKwX3L9SHJ4IZ6
 pSZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJwyqghmLCO55VoWd08Tmmr5jvPagWTTzRHeRFOpYNpz0U9oh/WUNmkPs/Z9QQzxJCoUNNtPwY0Uw@nongnu.org
X-Gm-Message-State: AOJu0Ywkxuy1bwjhLu8LYomQ/8Llm7KtWNiLCIyFlcPyke8ay3gOPAxV
 jGzp2YJYScXEvPCjNNkH7eLSl/RnlD/XP3Lie3eKLYGvW4SmWaCjLK/pEjb42Z8=
X-Google-Smtp-Source: AGHT+IFRB5jQXMkGLO58XK7nHtAiayr+QdGJOeQguWeRu+jMVcEwsZoW2qhCWqWzFnxElEXYFcIwYA==
X-Received: by 2002:a17:907:3e04:b0:a80:f616:5cf9 with SMTP id
 a640c23a62f3a-a868a0b0ed0mr1372394066b.0.1724652643591; 
 Sun, 25 Aug 2024 23:10:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f29a568sm619435566b.53.2024.08.25.23.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 23:10:43 -0700 (PDT)
Message-ID: <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
Date: Mon, 26 Aug 2024 08:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240825145208.46774-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Gustavo,

On 25/8/24 16:52, Gustavo Romero wrote:
> Extend MTE gdbstub tests to also run in system mode (share tests between
> user mode and system mode). The tests will only run if a version of GDB
> that supports MTE on baremetal is available in the test environment and
> if available compiler supports the 'memtag' flag
> (-march=armv8.5-a+memtag).
> 
> For the tests running in system mode, a page that supports MTE ops. is
> necessary. Therefore, an MTE-enabled page is made available (mapped) in
> the third 2 MB chunk of the second 1 GB space in the flat mapping set in
> boot.S. A new binary, mte.S, is also introduced for the tests. It links
> against boot.S and is executed by QEMU in system mode.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   configure                                 |   5 +
>   tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
>   tests/tcg/aarch64/Makefile.target         |   3 +-
>   tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
>   tests/tcg/aarch64/system/boot.S           |  11 +++
>   tests/tcg/aarch64/system/kernel.ld        |   7 ++
>   tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
>   7 files changed, 227 insertions(+), 28 deletions(-)
>   create mode 100644 tests/tcg/aarch64/system/mte.S


> diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
> index 7b3a76dcbf..46f1092522 100644
> --- a/tests/tcg/aarch64/system/kernel.ld
> +++ b/tests/tcg/aarch64/system/kernel.ld
> @@ -18,6 +18,13 @@ SECTIONS
>       .bss : {
>           *(.bss)
>       }
> +    /*
> +     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
> +     * starting from 1gb) by setting the address for symbol 'mte_page', which is
> +     * used in boot.S to setup the PTE and in the mte.S test as the address that
> +     * the MTE instructions operate on.
> +     */
> +    mte_page = ALIGN(1 << 22);

Comment says 2MiB but you use 4MiB.
Matter of taste, 2MiB is easier to review as:

       mte_page = ALIGN(2 << 20);

>       /DISCARD/ : {
>           *(.ARM.attributes)
>       }


