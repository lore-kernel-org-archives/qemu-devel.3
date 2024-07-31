Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470CFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZHJa-0006k9-75; Wed, 31 Jul 2024 17:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHJZ-0006jN-7g
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:56:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHJX-0006s1-2e
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:56:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d19c525b5so4417993b3a.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722463013; x=1723067813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4U0nCguInBLDwPgKbHbYIEF60NC3A7lwOm8TFXu11e4=;
 b=oGL3ccgfqfSvF1CFYlrkElHbTgPT2O8plx71GqPcCtiU1sofC/xJxX+zWl3hR7Ufe1
 5agv22xvT4OoOD06cHD6BCjTdXJl5dF4lHLQnXehLlTQC1+KGzncK9CI32R/qNk5whr9
 OEAkn/NHA0BFcEchT4oMU8jsDp9gPhWJs37NQMF3juHRr6LER7NZWlieZtLS//JqfFL7
 vtKxzQ9V45+75uvHvH54VILxcvcEkxkozU1gHenI/DlZbb5bSDY2+FTn0A7aNfm4Uts6
 lUVb3e2D230qXl0M+Y0hxll0aXmQl71JJXmZ9CZ6fF1YAFv3TXnB6XEUsizV8BN0ETOV
 jwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722463013; x=1723067813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4U0nCguInBLDwPgKbHbYIEF60NC3A7lwOm8TFXu11e4=;
 b=HV38HFhI20/y51N8Bbe6f0A8ZT5PtH1u5HBS63Mb1eWxKsDKka3h47WO5bYJnFt2sV
 iSwEgyt0tjTHlOkai8bl65KAPgvi9ytJ0Pizrjd4nMkRVTErt7I+SU/UYqjMnsgrRl6Q
 AzbEBCLASEFVSN8tg3gW5l88+GM0Wr/+M18xoeIFFCnLExIbEA5rlmWS4ehkUBbnkh4K
 DBRTTYQiCzXXWHi7UDxT96fZTVj4hOWUp5qhqLeXBzYnrRwiRriV/74rRXGhqCWpEE5d
 +LjDzvaMLq+howLOFpeVjtORhvTSL/3exZkhgGkfZ7wHpKHB70X0Fxik7uATEXYmirnS
 tg9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKEzX++whNmSqyQRCaAsN+2CKUHtlXGuDN2Oes1MhjlS1s6T0n5wV26u7V9cpI+KyBOoWtpXIhFv5V/wPJgJPhKbo/FTA=
X-Gm-Message-State: AOJu0YxJk8Iew0TN+uxMEnG9fIR3nKjyncG9DHFAMPYEjpUEAJ773JzT
 YlIxYZiG6EYf4HuHWpKHbJgPdpMBIsrdr8liBimOXnsEEoKXgiiXd+AQiRji9mI=
X-Google-Smtp-Source: AGHT+IHb1LvaU7zuBa8+bt8YWSpNrTlS2KCbAJuzdQVVSJfIOQS1dYqZW5a49smX1ssJLH7LAHSMjg==
X-Received: by 2002:a05:6a00:997:b0:70d:2583:7227 with SMTP id
 d2e1a72fcca58-7105d6a74c2mr633910b3a.6.1722463013147; 
 Wed, 31 Jul 2024 14:56:53 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1a2asm10315226b3a.23.2024.07.31.14.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:56:52 -0700 (PDT)
Message-ID: <5d6d52f3-7ce4-4b6b-a9d9-e0a5118b3a8f@linaro.org>
Date: Thu, 1 Aug 2024 07:56:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
 <20240731084832.1829291-5-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240731084832.1829291-5-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/31/24 18:48, Clément Léger wrote:
> @@ -823,8 +824,34 @@ static bool qemu_close_all_open_fd_proc(void)
>       dfd = dirfd(dir);
>   
>       for (de = readdir(dir); de; de = readdir(dir)) {
> +        bool close_fd = true;
> +
> +        if (de->d_name[0] == '.') {
> +            continue;
> +        }
>           fd = atoi(de->d_name);
> -        if (fd != dfd) {
> +        if (fd == dfd) {
> +            close_fd = false;
> +            continue;
> +        }

Assignment to close_fd not used here.

> +
> +        for (unsigned int i = skip_start; i < skip_end; i++) {
> +            if (fd < skip[i]) {
> +                /* We are below the next skipped fd, break */
> +                break;
> +            } else if (fd == skip[i]) {
> +                close_fd = false;
> +                /* Restrict the range as we found fds matching start/end */
> +                if (i == skip_start) {
> +                    skip_start++;
> +                } else if (i == skip_end) {
> +                    skip_end--;
> +                }
> +                break;
> +            }
> +        }
> +
> +        if (close_fd) {
>               close(fd);
>           }
>       }
> @@ -833,24 +860,68 @@ static bool qemu_close_all_open_fd_proc(void)
>       return true;
>   }
>   
> -static bool qemu_close_all_open_fd_close_range(void)
> +static bool qemu_close_all_open_fd_close_range(const int *skip,
> +                                               unsigned int nskip,
> +                                               int open_max)
>   {
>   #ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return true;
> -    }
> -#endif
> +    int first = 0, last = open_max;

If this were really _SC_OPEN_MAX, this would be off-by-one.

> -static void qemu_close_all_open_fd_fallback(void)
> +static void qemu_close_all_open_fd_fallback(const int *skip, unsigned int nskip,
> +                                            int open_max)
>   {
> -    int open_max = sysconf(_SC_OPEN_MAX), i;
> +    unsigned int cur_skip = 0;
>   
>       /* Fallback */
> -    for (i = 0; i < open_max; i++) {
> +    for (int i = 0; i < open_max; i++) {

Because this isn't really _SC_OPEN_MAX, this *is* off-by-one.

> -void qemu_close_all_open_fd(void)
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>   {
> -    if (!qemu_close_all_open_fd_close_range() &&
> -        !qemu_close_all_open_fd_proc()) {
> -        qemu_close_all_open_fd_fallback();
> +    int open_max = sysconf(_SC_OPEN_MAX) - 1;

Better to move the -1 into qemu_close_all_open_fd_close_range where it's actually needed.


r~

