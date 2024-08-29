Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF1DC7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjTGV-0004j8-1w; Wed, 28 Aug 2024 20:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjTGT-0004id-FS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:43:53 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjTGR-00085A-V5
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:43:53 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7093472356dso83029a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724892230; x=1725497030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AW7YQ23cYmz+qIami6y+HmOJfYBM8AZbZgfu6+hDRb4=;
 b=DcI3JVq4/noAhoqIok7Y5WofXvNmFh6ekmqIIz9BXFSX379VoShFwHmm06naqeZalq
 51X8jdDx42OswU0Bd8R12m1wj9khnFv0NCDDaiLQNwNjzysFHV3zw3IzEmm2UYbkoH32
 tKmBuLIYB9AMqDawxjtnIVlSIoRR3P+hXqoGVYGhNYBHw0MchmUeh/8CuZvOuGLzkdaZ
 BVq0y7yeBKoAfmJUqjB2GVmCa+BFf+5p5/D2oonu0BNBONpIOmcnsILwTNWXrE+xAGP1
 wPJ8ws0BKhethgI7uuAphTEYaa0+DY64fZGFA/6pgkIWltLs5EIJY09ZiBNX3URKCAHN
 RUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724892230; x=1725497030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AW7YQ23cYmz+qIami6y+HmOJfYBM8AZbZgfu6+hDRb4=;
 b=lMg6/ji+aNu35mMtSTr4H5gxt74lim650ms4qo9i1gTjwfQHXJqtZQ3uPzOtz8ON3G
 psJOX4JaBIHaYfNtVeN/NyRZGX+fneYIq/kKaW7cOllad0zVlE8FSDWc5R1NmqMrs/E0
 TEqRADw5/ywbuIgfkiZJ6rloXalyaegOmQCPNtSJLM1dL7XejexYm+Oo035zVw4UIA6H
 zLC5dCucqbse2zg+CLoWgcWOgr0AIbG5m+LT84dh6Y2VwEWY1Sp4L1a+CFUAyApUnyjS
 PG1Qy/gCSX8VFXnoBQuUqopmt8XOLG2YyF5JDW3RQ9rpYGpiv/6xjKyFuVvg/OH+KCMk
 mpaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxbDUd7x8VWMnGxvSYUgS4QrUK3cRRDn4HExXuMeUT47F/Z8lv7WxQwy3U7//SDRB9X2op7pit1DF0@nongnu.org
X-Gm-Message-State: AOJu0YxJgPnZNuA30OJiN9clzxTos5aoALsojDQHnIsbrquUaX5vb1tA
 QTjwqTgJN5m77Uzo93lbasY/y1xCZqgQz7ejus9c5vgAao9Bc8PpPHxKISntIfo=
X-Google-Smtp-Source: AGHT+IHr/PTZLfXc441EZPG2ZtS9XGvNZmguKYoFOnnCAIoyy65EXZzJdeQadLrXHhbqUbP08Vqdrw==
X-Received: by 2002:a05:6830:6dc5:b0:707:8b7d:b924 with SMTP id
 46e09a7af769-70f5c367333mr1641210a34.10.1724892230076; 
 Wed, 28 Aug 2024 17:43:50 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f60d56f80sm10040a34.76.2024.08.28.17.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 17:43:49 -0700 (PDT)
Message-ID: <65e4c975-83f9-4d9b-a8aa-37d9543afac7@linaro.org>
Date: Thu, 29 Aug 2024 10:43:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
 <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
 <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
 <2c2813aa-5671-7705-7170-d3e8e25d2f7b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2c2813aa-5671-7705-7170-d3e8e25d2f7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 8/28/24 04:01, Gustavo Romero wrote:
>   SECTIONS
>   {
> -    /* virt machine, RAM starts at 1gb */
> +    /* Skip first 1 GiB on virt machine: RAM starts at 1 GiB. */
>       . = (1 << 30);

Better is to use

MEMORY {
   RAM (rwx) : ORIGIN = 1 << 30, LENGTH = 16M
}

(or whatever minimum length seems reasonable).

Since there is only one memory region, it will be used by default and no further markup is 
required.

> +    /* Align text to first 2 MiB. */
> +    . = ALIGN(0 * 2M);

This is pointless, of course: ALIGN(0) does nothing.

> @@ -19,12 +21,12 @@ SECTIONS
>           *(.bss)
>       }
>       /*
> -     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
> -     * starting from 1gb) by setting the address for symbol 'mte_page', which is
> -     * used in boot.S to setup the PTE and in the mte.S test as the address that
> -     * the MTE instructions operate on.
> +     * Align the MTE page to the next 2 MiB boundary (i.e., the third 2 MiB
> +     * chunk starting from 1 GiB) by setting the address for symbol 'mte_page',
> +     * which is used in boot.S to setup the PTE and in the mte.S test as the
> +     * address that the MTE instructions operate on.
>        */
> -    mte_page = ALIGN(1 << 22);
> +    mte_page = ALIGN(2 * 2M);

This does not do what you think it does.
It aligns to the next 4M boundary, not the next 2M boundary.


r~

