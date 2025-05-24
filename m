Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE67C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 13:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIpAg-0005ZJ-QM; Sat, 24 May 2025 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIpAf-0005ZA-3P
 for qemu-devel@nongnu.org; Sat, 24 May 2025 09:44:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIpAd-0002G0-5S
 for qemu-devel@nongnu.org; Sat, 24 May 2025 09:44:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so10305885e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748094253; x=1748699053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kEWOUDA3q06GZ5GkbSQHmEZI1g8mcQKpm5PdVrCbWmY=;
 b=a5eCQZvQlrQlbibodpX4LGIbtug83A38QfipYaYKC7KEq19eRfbktkpRbHzfQw2E8d
 h5tcMjcJJU9l2CyJhdDnfaaykTL/69hWpDSvMPZHbyHdid3Be6W54XVDRQLrT8gPN+pZ
 RQGcIL2QUTDciMteC1pTSn1ZJ7ZjDDgCMKT09J1ukSvlQtkV7W8qvV6afOWMyHOy96+5
 HXtq3pTmd8py4XR565L7NJqZqkVddU9AFHAjjRYu6wY58vHunamUQkhtt3fr0Fi5TaqI
 PG7PuOdYR3lBvoOjElteYg96w1tL02NeUE1Xvi/wHJIlvCl2GHGsNWYghVF+dw9uyOu4
 9LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748094253; x=1748699053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEWOUDA3q06GZ5GkbSQHmEZI1g8mcQKpm5PdVrCbWmY=;
 b=OYHvwSWzkssUhzezBeIA4mxaxZgXzWLxxVK4QBDhllAQTPqg6FGijchg775NcoZC5J
 med5EjdC7dm6tb5OspdvJdztisDWyFW71/fxuNGpXqzupWE778yeCa7N96dC2UKtl4WQ
 WgZTPvtklFFSj8k0vBslTWV12xiBsntpu8gfbwjm4jeF88FNJIC4SzrBWX4eiYTPN4a3
 3r5/24k2QilT9n6y5xrg+lyiDBnbCEgn7CkxhMprJxGss6pURntnY0RooMfH9HgJlHti
 w2pAMphvq7c77mLsOo4XMd1J6p/ZJWWx2phOa+p1C8H7pPQvdCacoNaBkKkA8Jn/7USM
 3wgg==
X-Gm-Message-State: AOJu0YxVP5tWtanp0mfF7w+nVQAf83hYoFLM0rwcp0JMRrI8P3jnqvL5
 PFguntkwaTyMfq6U8FVZnO25Cc+M1M6FxUZ87IMdi6JGzLsEqdJ4pEnXQFYkn5w73GWJHxun8Ne
 GKlrTiOexVg==
X-Gm-Gg: ASbGnctlSVW+CiLSClH0jgCmMIpVwuxZvyigR1aQitjzTU1huWYV3MTz8KPpOxjEpBw
 vqpvRJI+D5eKHUP8CBlaXbS373piPsKpwmZjboKi2MlILDcR2mpdSnpFVxHnTIoIQvQiQeBO5KN
 MANtb5N6tJQZ6MYXP4f6UShD3an6SP6WfD7iDOWVc/u6oAunxqLWAL/LCIWBGDiOiXVO2dfcijJ
 FLOFP8rHZhzOat8ktxjcrZfPG80o4CXfdqCLlRJYc722ghzEypka5WEprJSIvjlphk1eRL5b77q
 QRdTLH3Gh5RnBwVxk1GDKyWJNYO4qVjG8VxpJz+dIQ9JV8H0yf0TIj34mwMDjKfBSwX9jIIA+n0
 L
X-Google-Smtp-Source: AGHT+IG8nuvUzqvRHOCOvlXwPajE5IPbwCI1iNZtFSupGqH43uJIFMigwBKG3XXp+Yo4xfBlEhCAnA==
X-Received: by 2002:a05:600c:c8e:b0:442:d9fb:d9a5 with SMTP id
 5b1f17b1804b1-44c7ad31701mr24689535e9.9.1748094252701; 
 Sat, 24 May 2025 06:44:12 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44804e89c42sm185509185e9.21.2025.05.24.06.44.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 06:44:11 -0700 (PDT)
Message-ID: <b5c020e9-fa79-4d07-bd39-9f45ad1fe329@linaro.org>
Date: Sat, 24 May 2025 14:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: implement pgid field of /proc/self/stat
To: qemu-devel@nongnu.org
References: <mvmfrgzcr4m.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmfrgzcr4m.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 5/20/25 15:07, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8820ca4dfd..5536e364dc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8235,6 +8235,9 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
>           } else if (i == 3) {
>               /* ppid */
>               g_string_printf(buf, FMT_pid " ", getppid());
> +        } else if (i == 4) {
> +            /* pgid */
> +            g_string_printf(buf, FMT_pid " ", getpgrp());
>           } else if (i == 19) {
>               /* num_threads */
>               int cpus = 0;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

