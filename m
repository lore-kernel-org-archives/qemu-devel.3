Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AD8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 02:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYygm-0002Wk-LN; Tue, 30 Jul 2024 22:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYygl-0002WD-Me
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:03:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYygk-0003MM-0h
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:03:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fda7fa60a9so47424415ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722391416; x=1722996216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6VeR7hLNton4hRiIE/lSuamlsmdHEez3BqbtA9VyGc=;
 b=LfPWb8jLMTgjV7hMHu1YoxdABmreLvRKNHWtvsuH3roix1/QJp3qznAXU5X7Q5yK1H
 I0X8617RHV+bq9UCW+SBMcNhLR0g/2StLzZvkKMpF1r2dgP3puqZ87BrxvsIwTTfPCFn
 1pR/DDa4HmUR4P5dLW/dKdePrdU1qwlU2fdaNqTo0C4VjfTQiPMYsoW5Yd1bz6tWQStA
 yf4iQppKWCcKZzIx0O+ZIKIzfFWHXsGSGCIusv+KQHiXhZl3Hdrp4g8wYRB5b1uH217D
 Em7iWQxD/P+yme9umzesfzSsq3b6JnW8Izs+R9RyMEs5zH8nDvtNmj/gXt2EyTBWodr8
 RLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722391416; x=1722996216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6VeR7hLNton4hRiIE/lSuamlsmdHEez3BqbtA9VyGc=;
 b=YRUr/xie0Q3tEqtlzo01YrwE3cD7R9En5cy4zw+qHCmflL735+1vX6BPt+OQiNLz0a
 4wXpmwAGfCNApzx/Esl1qhtUzctq1qfwqzEYwqF8ERSrcQoc3ugLeCUC9UO5JBf/kUoj
 +8BWKN1smoyYCyQale1Ef06RngR3yRWlz50LBkXWIB/QBa0OIJi4Yw0UfH3j2sXcnHG1
 PtO2/SfnggW6Vg+bAhmVvJU75JkTFjt/u6kOl0633r/nfiwYeywz+PsvLbpqv/ezCtEw
 +fqFH8NY2P00wGZKJCkO+beZTNDgH2g29Vo+p/i0eIYkBTo/gg2crzxMnIM4U5WGS4cH
 11mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXuv9UbYod/2xcuDirRYAUvXGyy+xWM6RjiQ4NaKqlxpvMG3VOLDu4/sI11tZQat2ABl1DBBWfKayp+/uerQrZETezqW4=
X-Gm-Message-State: AOJu0Yw3dh1dH1NjlwKzi5GBaa/edZeATS7hPI8dp7kg0JUr+4Cw1Ow4
 7llMZQ1fMssoo0xnejEq81K7WLn8aUYHt6djXZwTUHVTJpEOwO7iwLktxTVEL6g=
X-Google-Smtp-Source: AGHT+IE5WPrsUuVI76krCECkssomzkGgAwDjZrE6HwaiwN7Nf9z5HzwZDPWMYHX1yPBekqAEz0RgwQ==
X-Received: by 2002:a17:902:dace:b0:1fc:3daf:8a0f with SMTP id
 d9443c01a7336-1ff047ddf32mr183252725ad.7.1722391416097; 
 Tue, 30 Jul 2024 19:03:36 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7edd90dsm109049795ad.161.2024.07.30.19.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 19:03:35 -0700 (PDT)
Message-ID: <57ea8275-fbbe-4ac6-bf5f-f96a7d523c9e@linaro.org>
Date: Wed, 31 Jul 2024 12:03:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-5-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730122437.1749603-5-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/30/24 22:24, Clément Léger wrote:
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index a6749d9f9b..e7bffaea16 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -808,11 +808,14 @@ int qemu_msync(void *addr, size_t length, int fd)
>       return msync(addr, length, MS_SYNC);
>   }
>   
> -static bool qemu_close_all_open_fd_proc(void)
> +
> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)

Extra whitespace.

>   {
>       struct dirent *de;
>       int fd, dfd;
> +    bool close_fd;
>       DIR *dir;
> +    unsigned int i, skip_start = 0, skip_end = nskip;

You can narrow the scope of close_fd and i.

> @@ -823,8 +826,31 @@ static bool qemu_close_all_open_fd_proc(void)
>       dfd = dirfd(dir);
>   
>       for (de = readdir(dir); de; de = readdir(dir)) {

     bool close_fd = true;

> +        if (de->d_name[0] == '.') {
> +            continue;
> +        }
>           fd = atoi(de->d_name);
> -        if (fd != dfd) {
> +        close_fd = true;
> +        if (fd == dfd) {
> +            close_fd = false;

continue, which avoids

> +        } else {

the else and the subsequent indentation.

> +            for (i = skip_start; i < skip_end; i++) {

for (unsigned int i = ...)

> +                if (fd < skip[i]) {
> +                    /* We are below the next skipped fd, break */
> +                    break;
> +                } else if (fd == skip[i]) {
> +                    close_fd = false;
> +                    /* Restrict the range as we found fds matching start/end */
> +                    if (i == skip_start) {
> +                        skip_start++;
> +                    } else if (i == skip_end) {
> +                        skip_end--;
> +                    }
> +                    break;
> +                }
> +            }
> +        }
> +        if (close_fd) {
>               close(fd);
>           }
>       }
> @@ -833,36 +859,79 @@ static bool qemu_close_all_open_fd_proc(void)
>       return true;
>   }
>   
> -static bool qemu_close_all_open_fd_close_range(void)
> +static bool qemu_close_all_open_fd_close_range(const int *skip,
> +                                               unsigned int nskip)

Pass in open_max, so that you don't compute it a second time...

>   {
>   #ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return true;
> -    }
> -#endif
> +    int max_fd = sysconf(_SC_OPEN_MAX) - 1;

... here

> -void qemu_close_all_open_fd(void)
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>   {
>       int open_max = sysconf(_SC_OPEN_MAX);
> +    unsigned int cur_skip = 0;
>       int i;
>   
> -    if (qemu_close_all_open_fd_close_range()) {
> +    assert(skip != NULL || nskip == 0);
> +
> +    if (qemu_close_all_open_fd_close_range(skip, nskip)) {
>           return;
>       }
>   
> -    if (qemu_close_all_open_fd_proc()) {
> +    if (qemu_close_all_open_fd_proc(skip, nskip)) {
>           return;
>       }
>   
>       /* Fallback */
>       for (i = 0; i < open_max; i++) {
> +        if (cur_skip < nskip && i == skip[cur_skip]) {
> +            cur_skip++;
> +            continue;
> +        }
>           close(i);

And pass open_max to qemu_close_all_open_fd_fallback as well.


r~

