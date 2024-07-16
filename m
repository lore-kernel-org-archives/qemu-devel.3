Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C20C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjRp-0004JH-Ay; Tue, 16 Jul 2024 10:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTjRn-000457-LS
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:46:31 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTjRb-0003qc-Ly
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:46:22 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52e9a920e73so6363727e87.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721141178; x=1721745978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yqokjoCG55Te5jtEkDpVM9qgh4gKS4rDpXQ67Rl5yPw=;
 b=ZoTVsLbw9qL2q95gdQl23/P3TvE5wHCEMrC/YummDjXb1zvPqCYx73qgrjQfObwj6M
 EHFlT61W+KtmMn7qAtJ0lNN1J8yqEve/I8h+XkEIIhYrSVisJbBAkoex7iB4Db2QEyQT
 JLmw6WDR8irHwe11/3C6u7nrVzvBrTUYkAxl99mB8RdFfFQfpGBCB3r6kWNip1qoMFyC
 4dh+vG9SjidGpPJj01dmJTaD0bkfXygLjzuFxD7raSg67SBI0IeIUncgH2EIhvlYfTk3
 sx6EA8hJxtZ9Xf8Jp/onocb32zzsCCehhM2NMg46qDcZQg3YoYLMqpe2MV8hJduPPhue
 8Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141178; x=1721745978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yqokjoCG55Te5jtEkDpVM9qgh4gKS4rDpXQ67Rl5yPw=;
 b=HZ6o1kwr2EwQjRTwP17I65rV6yicmLDhfkjlLZQiccZmnCUCsnQJgj5iMm8z264tAn
 6MPruKb8CxP4FGdR8LJ/2QK8Lnznlt/RmAjrsLUAy9eLupaGkl4jTw9GZe8ZjnULsbsX
 lg8H0fUCqd4fRG4BmzAsAwMRF7IVg32B0kiTYDK9wE1X476DhGVzcPNKVk8D9DG6DyRX
 BvpnvO1z/CVIzF2yBRkieecy0Kk7cYahsTNh/Y3WJ7Zb6GmiuDwkNKeZ9kzmb9psM6fJ
 zkqNLOIHuJET17m7XBM4roEWcrboZQ9RrA+LO6nX5+HRqV9CUe3dIBPaubbw/vvGYuKO
 sWJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoGt+ME9LDcEsYlh8sbPojGMzNVAuxgLuEeCn8ylT9AKRQXua61Rj1U97whASjl3Om1pG6rplGnvV6+AlhyxP4zEW2R8o=
X-Gm-Message-State: AOJu0YwQiprak5mX1iIpH3tzP0qtBFT77CWYvHoh8YOOegdMuZO5aV6X
 zZu9skecfLdZFA3hlAUqcTg6/1agu9qCKFHK9mwQy1SJh/o45oWxkocQX4e/Wqs=
X-Google-Smtp-Source: AGHT+IEqNmJaYVXFyhUl+i6jrfksfR4ca2p8WzxmEuW9nYjNKrENPBs5SNRyW2MxDFx74GyK6+70hw==
X-Received: by 2002:a05:6512:4018:b0:52e:be50:9c55 with SMTP id
 2adb3069b0e04-52edf033f76mr1510967e87.52.1721141177639; 
 Tue, 16 Jul 2024 07:46:17 -0700 (PDT)
Received: from [192.168.1.172] ([185.87.38.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bb99a23dsm20287815e9.1.2024.07.16.07.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 07:46:17 -0700 (PDT)
Message-ID: <64d26790-5003-4da5-9cb2-eb9ea43112b3@linaro.org>
Date: Tue, 16 Jul 2024 16:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240716144006.6571-1-cleger@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240716144006.6571-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

Hi Clément,

On 16/7/24 16:39, Clément Léger wrote:
> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
> POSIX"), the maximum number of file descriptors that can be opened are
> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
> of 1073741816 file descriptors. Now, when forking to start
> qemu-bridge-helper, this actually calls close() on the full possible file
> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
> takes a considerable amount of time. In order to reduce that time,
> factorize existing code to close all open files descriptors in a new
> qemu_close_all_open_fd() function. This function uses various methods
> to close all the open file descriptors ranging from the most efficient
> one to the least one. It also accepts an ordered array of file
> descriptors that should not be closed since this is required by the
> callers that calls it after forking.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ----
> 
> v3:
>   - Use STD*_FILENO defines instead of raw values
>   - Fix indentation of close_all_fds_after_fork()
>   - Check for nksip in fallback code
>   - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
>   - Use unsigned for cur_skip
>   - Move ifdefs inside close_fds functions rather than redefining them
>   - Remove uneeded 'if(nskip)' test
>   - Add comments to close_range version
>   - Reduce range of skip fd as we find them in
>   - v2: https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/
> 
> v2:
>   - Factorize async_teardown.c close_fds implementation as well as tap.c ones
>   - Apply checkpatch
>   - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
> 
> ---
>   include/qemu/osdep.h    |   8 +++
>   net/tap.c               |  33 +++++-----
>   system/async-teardown.c |  37 +-----------
>   util/osdep.c            | 129 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 157 insertions(+), 50 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 191916f38e..43a035d756 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -757,6 +757,14 @@ static inline void qemu_reset_optind(void)
>   
>   int qemu_fdatasync(int fd);
>   
> +/**
> + * Close all open file descriptors except the ones supplied in the @skip array
> + *
> + * @skip: ordered array of distinct file descriptors that should not be closed
> + * @nskip: number of entries in the @skip array.
> + */

Can we mention @skip is optional, and @nskip can be 0?

Also I'd assert(skip != NULL || nskip == 0).

