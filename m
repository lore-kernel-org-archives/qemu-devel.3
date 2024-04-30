Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569CBC19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rRQ-0006p1-Nv; Tue, 30 Apr 2024 13:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1rRL-0006oE-8q
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:38:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1rRJ-0000vf-G5
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:38:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so5546638b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714498726; x=1715103526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVyv5hRg6B037RfNy6Jiaqghy84UvaDe+kTUw/jD0qU=;
 b=AJirJJ+NrIqwZ4Tv3vVabXnqBI98d7jW5889ZqBY9ck9WWxI2z2z4cpB/DuXLY0T3n
 zbZxYOmrAMN2QhP0Qjb9W6qDCEv/CHSmyDr761+IVwfuKxTlGtQGOci2M9a5ClANnIun
 vhh32eA8ZVZFZ7nEtQteyfUlZ9Z78qnF2GR+DEykbSS2sG5t5vnnfGHvVkFFVn5wjE/A
 3sRFOd7kqRqBYByM9oV9k+nt5nRU9P4tXq6zYpwbmozCTEeN3m5jUiapSep8V225YqIm
 jwXdgbyY0iaBaKMdQksvHTk5+X/FhN3GKgw6IAQtlE3J0Q+8a9KNsh5XZnoF6lqBRolF
 MEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714498726; x=1715103526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVyv5hRg6B037RfNy6Jiaqghy84UvaDe+kTUw/jD0qU=;
 b=WShedbYqsgCxH8Qps0GCvRMOVLv6QvZYDvxbxnRzr/RUlVOW8Z7pXyIAOz9W+qG6Sg
 NtExEBrF/lAWDqMImeITb1fRJPzuUZE4F7G5YwjTdmDB/vM4CICSM7F57n1o7mykj6pP
 yZII3sOugWpHZQuNdKbcALsI2Ke84t9ceMECbZRSJeX9ZBwaxI9rUEaorrZYObJCPNO0
 EBkfn6X5UcP7/TkDGTIEH9EGi3LZS2A3wir+Xki370dYbtfEUgA10Mwaogv0f0URHDNi
 NM5dwcMREwbBrddGv0SaFM4evi89v5MSKfY4wKgxZIjjG0DHAbhnwucD76nYe5KKbJ0T
 iVBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtm7o/jj1joWcRO4YDmEOypNxr2u1vmZ+Yc1LrjT3vtkC533x/n01Jv9DQ1oLGen18eKXh445IU+xDCTDaGDDpyKVnUNU=
X-Gm-Message-State: AOJu0YzLl7bS6m8J1Ay11ImS15fX63toruLzQf8hxSqsn7HlGYpM5IwB
 +23Qn4xS7R5iZ7OX+VnKJ6mDk3dLAzy653ifQVhoafVojHajmLthRy4eQAaUO88=
X-Google-Smtp-Source: AGHT+IHSKYG4Dav9MCEd9I5UUO+08nmgNKNY0vsk3if9XqqC2/0/9W1cFI4K+ocZGmAuivchjOaKxw==
X-Received: by 2002:a05:6a21:9204:b0:1aa:282e:8dac with SMTP id
 tl4-20020a056a21920400b001aa282e8dacmr779203pzb.0.1714498726640; 
 Tue, 30 Apr 2024 10:38:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n66-20020a632745000000b0060fc94219b0sm6304555pgn.45.2024.04.30.10.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 10:38:46 -0700 (PDT)
Message-ID: <38c57237-665d-4016-a6c6-ba8ceb04b24d@linaro.org>
Date: Tue, 30 Apr 2024 10:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool
 for whether to halt
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240430140035.3889879-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/30/24 07:00, Peter Maydell wrote:
> The TCGCPUOps::cpu_exec_halt method is called from cpu_handle_halt()
> when the CPU is halted, so that a target CPU emulation can do
> anything target-specific it needs to do.  (At the moment we only use
> this on i386.)
> 
> The current specification of the method doesn't allow the target
> specific code to do something different if the CPU is about to come
> out of the halt state, because cpu_handle_halt() only determines this
> after the method has returned.  (If the method called cpu_has_work()
> itself this would introduce a potential race if an interrupt arrived
> between the target's method implementation checking and
> cpu_handle_halt() repeating the check.)
> 
> Change the definition of the method so that it returns a bool to
> tell cpu_handle_halt() whether to stay in halt or not.
> 
> We will want this for the Arm target, where FEAT_WFxT wants to do
> some work only for the case where the CPU is in halt but about to
> leave it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h       | 11 +++++++++--
>   target/i386/tcg/helper-tcg.h        |  2 +-
>   accel/tcg/cpu-exec.c                |  7 +++++--
>   target/i386/tcg/sysemu/seg_helper.c |  3 ++-
>   4 files changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I like Alex's suggested rename.

> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -669,11 +669,14 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->halted) {
>           const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> +        bool leave_halt;
>   
>           if (tcg_ops->cpu_exec_halt) {
> -            tcg_ops->cpu_exec_halt(cpu);
> +            leave_halt = tcg_ops->cpu_exec_halt(cpu);
> +        } else {
> +            leave_halt = cpu_has_work(cpu);
>           }
> -        if (!cpu_has_work(cpu)) {
> +        if (!leave_halt) {
>               return true;
>           }

As a followup, I would also suggest making implementation of the hook mandatory.
We already require the has_work hook to be set; it would simply be a matter of copying the 
function pointer to the second slot.

Also, the assert in cpu_has_work could be moved to startup, as Phil has started to do with 
some of the other hooks.


r~


