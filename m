Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A17D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34HQ-0003OS-Mx; Mon, 21 Oct 2024 22:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34HK-0003Ne-VX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:05:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34HI-0000jZ-Qs
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:05:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso3927810b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729562743; x=1730167543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kp9Fb0fN/ZE4y7VIcuj6RCVrocG6dAHCaO6bc3O9m1s=;
 b=o1Ot6T6WC2Xe/OpWdd2JwroJA9T7l/AaEox9vClWZ3GQOPYolzG4UCBx8AtyyP/Dfh
 or0u7eQyfI10gPJ7NxPz2IfZgs6daGiJ3Sc83MnR2jWTaw7DJT4ixp6AK5nXIjK24BG7
 BFn5k8KuHOouO4rZPBU4ua47uqnuI5u9mKSiqEnMZIZ8611PcCKsoGKHegeQICTF1pLk
 0+90QaqkWKtmgxJSP3uK9PbEwvA6BvtOAFcBlF8FNqo8h/EjNIzL5Happe4oI0OTnlVh
 IexBhFKJFppGVklb80tPuCongJcwBFNXXukJ63DmLzi3nXeLZ79a7C8RiRKrTjIqLH2o
 BcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729562743; x=1730167543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kp9Fb0fN/ZE4y7VIcuj6RCVrocG6dAHCaO6bc3O9m1s=;
 b=UruO70/0pt0JvcpzD0E31gCNMxBFFwY21vhyAxOIHiCGmTmpDEYV7dsc1PxlqPu6eO
 uYTc8y4EBRGRyjowgxq5h0WI1KC/8Xi0GTLP1AF54yeVr/CdOi3tj/9okrI4W06POO4O
 aNR0k42sslY+47+EeHlIwnwAh5gPYOpuHbh8twix8c8m5n55xupfwBRk14MVfNF5wUeO
 nsZ1HrtweyjlQ1mh/qMsPWYeu07grJQpWf+5oItC5XzCD+AZhKm/Xmiq9UkH7/u5s4pu
 1Js1L7TzK8DNDGdnVW3vguZ5tnkuvwi54M9UQg/O1r/VpfWOKM7ZMBWjSOY1zYH0cEsD
 RC1w==
X-Gm-Message-State: AOJu0Yz0925FxVqhbOzNmlWUOwsVKDRh4fddLqK+UyJbHEgHrZG5Vh3r
 5zLQMUyG4bNMIjeQmoBekwAlCSQjj4calCttYJyDGlPKXE0VXY+yBWYBlsPJPrw=
X-Google-Smtp-Source: AGHT+IFifxgiqJvmtC1hn3VJMIx04E9kZbK68atEsfjUpulLpUJP0T7YN3ToEBjQ5oZvBLGZJ49wCQ==
X-Received: by 2002:a05:6a00:2d29:b0:71e:692e:7afb with SMTP id
 d2e1a72fcca58-71ea31172cemr16521934b3a.5.1729562742731; 
 Mon, 21 Oct 2024 19:05:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d74e5sm3581882b3a.125.2024.10.21.19.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 19:05:42 -0700 (PDT)
Message-ID: <3394cdfd-16e0-4ee5-bafc-92f8e328449f@linaro.org>
Date: Mon, 21 Oct 2024 19:05:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg: Test that sigreturn() does not corrupt the
 signal mask
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241017125811.447961-1-iii@linux.ibm.com>
 <20241017125811.447961-3-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017125811.447961-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/17/24 05:54, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c


Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/tcg/multiarch/sigreturn-sigmask.c b/tests/tcg/multiarch/sigreturn-sigmask.c
> new file mode 100644
> index 00000000000..e6cc904898d
> --- /dev/null
> +++ b/tests/tcg/multiarch/sigreturn-sigmask.c
> @@ -0,0 +1,51 @@
> +/*
> + * Test that sigreturn() does not corrupt the signal mask.
> + * Block SIGUSR2 and handle SIGUSR1.
> + * Then sigwait() SIGUSR2, which relies on it remaining blocked.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <pthread.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +int seen_sig = -1;
> +
> +static void signal_func(int sig)
> +{
> +    seen_sig = sig;
> +}
> +
> +static void *thread_func(void *arg)
> +{
> +    kill(getpid(), SIGUSR2);
> +    return NULL;
> +}
> +
> +int main(void)
> +{
> +    struct sigaction act = {
> +        .sa_handler = signal_func,
> +    };
> +    pthread_t thread;
> +    sigset_t set;
> +    int sig;
> +
> +    assert(sigaction(SIGUSR1, &act, NULL) == 0);
> +
> +    assert(sigemptyset(&set) == 0);
> +    assert(sigaddset(&set, SIGUSR2) == 0);
> +    assert(sigprocmask(SIG_BLOCK, &set, NULL) == 0);
> +
> +    kill(getpid(), SIGUSR1);
> +    assert(seen_sig == SIGUSR1);
> +
> +    assert(pthread_create(&thread, NULL, thread_func, NULL) == 0);
> +    assert(sigwait(&set, &sig) == 0);
> +    assert(sig == SIGUSR2);
> +    assert(pthread_join(thread, NULL) == 0);
> +
> +    return EXIT_SUCCESS;
> +}


