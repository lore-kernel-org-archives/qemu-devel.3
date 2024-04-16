Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E61C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 11:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwglT-0006V2-Ky; Tue, 16 Apr 2024 07:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwglQ-0006UG-Q3
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:14:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwglH-0003wJ-Kv
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:14:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so3416043a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713266041; x=1713870841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AZOGFdgRZOC1Pr2vakghfyPj0cm3QvLf9Bvtml3l8p4=;
 b=R9z8L+6GXPfDnVgk+MKwwZK5o+ke9g6hvE31c+skAkRcMjdXGFlOG+SGcGJJcfvEKh
 JFyTCTLy1J1TSOX3FVeQF84mf9HGKnHupilSi4W+4a+EotSfFUXK2VHPYqm1qKxk7wzE
 mDZFzVX89jew1kzSmHK66ED/SaGJJIltb2a18D33o0hz3H5bsoWib6YUiaf1J3t407c5
 AX95+l6rRTMs1SUzJU+gbpNbOUINSIBrfZkPGGqwbdD1DsD0pFzCsT+N7sgR6zq/QpTG
 bmVZc3uhNAyjA8xPUpkZDS7NTCNlzZiDFmsKfr0ZvxRdio5fAqX/5Iaf0o1RtlJYMNi9
 usHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713266041; x=1713870841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AZOGFdgRZOC1Pr2vakghfyPj0cm3QvLf9Bvtml3l8p4=;
 b=Ygf8J0iuFssw/KKNyRqdvgcEUgQ1Hm7zmCSymA1HvlnjaIrZPxURP3SeTW9LsPXnyw
 KS5b8SvEPGEnpGRWCSvKtj3eE4T2al+BaCGei9pAdXscyrw+h2RNaLg7xlEPsnaRO+vH
 Ls3mCjUTbPb/haX6SOk1d6cS0ohzu65Z+qyWDE1+DIi/tCZpp1cKjfTdBZEVlvqBrPbt
 7zkRPVg//zz5c2+KIM7Z6yULu9llIF2TjV1HoqcJaetvoV/oXdM6Kn98zHNq2URkbY6B
 98dToZvFG2qBHrWLV5VF/y2NewAmcB4L48fYUeQA0adrfW8+1pjAjmXmZSdPtdrJRlBx
 OZfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvYrbUMn+1lE9Q5HSXH4QUzqBYb4vwIzBaMocpElrGFg2QtJ165g/Z7E160usV+sXYaeVfkYETvEyXvrsN8Rh5HQniAs8=
X-Gm-Message-State: AOJu0Yz1W6xiX5c1kD1kpvXaeECLJB/SWMmwuWtdU0UfNhA8mABLLzYI
 9RA892AjC9KKZtfaUbj+qc3iQOYhvFgWinclZi1WdRVUawBZlkp4vKZ5E5g+9Tw=
X-Google-Smtp-Source: AGHT+IE6ydb+klzGU7dZsqc4yrgdWRcCEuUfGuIG2l9wb1RB9Ce/c5SQ9I7RKOPdTGKlSoncJtCVzQ==
X-Received: by 2002:a50:9e0b:0:b0:570:d50:e7d8 with SMTP id
 z11-20020a509e0b000000b005700d50e7d8mr6165282ede.22.1713266041428; 
 Tue, 16 Apr 2024 04:14:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 em8-20020a056402364800b00570439141a0sm732273edb.3.2024.04.16.04.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 04:14:01 -0700 (PDT)
Message-ID: <9c5666a3-e4ae-4be0-bf1f-be7d36fa80a6@linaro.org>
Date: Tue, 16 Apr 2024 13:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: Deprecate "-runas" and introduce "-run-with
 user=..." instead
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240415183942.195781-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240415183942.195781-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 15/4/24 20:39, Thomas Huth wrote:
> The old "-runas" option has the disadvantage that it is not visible
> in the QAPI schema, so it is not available via the normal introspection
> mechanisms. We've recently introduced the "-run-with" option for exactly
> this purpose, which is meant to handle the options that affect the
> runtime behavior. Thus let's introduce a "user=..." parameter here now
> and deprecate the old "-runas" option.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst |  6 ++++++
>   system/vl.c               | 15 +++++++++++++++
>   qemu-options.hx           | 11 +++++++++--
>   3 files changed, 30 insertions(+), 2 deletions(-)


> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ce85d4559..50912c7dab 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4824,7 +4824,8 @@ DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
>   SRST
>   ``-runas user``
>       Immediately before starting guest execution, drop root privileges,
> -    switching to the specified user.
> +    switching to the specified user. This option is deprecated, use
> +    ``-run-with user=...`` instead.
>   ERST
>   
>   DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
> @@ -4993,7 +4994,9 @@ DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
>       "-run-with [async-teardown=on|off][,chroot=dir]\n"

"-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"

>       "                Set miscellaneous QEMU process lifecycle options:\n"
>       "                async-teardown=on enables asynchronous teardown (Linux only)\n"
> -    "                chroot=dir chroot to dir just before starting the VM\n",
> +    "                chroot=dir chroot to dir just before starting the VM\n"
> +    "                user=username switch to the specified user before starting the VM\n"
> +    "                user=uid:gid dito, but use specified user-ID and group-ID instead\n",
>       QEMU_ARCH_ALL)
>   SRST
>   ``-run-with [async-teardown=on|off][,chroot=dir]``

Ditto.

> @@ -5013,6 +5016,10 @@ SRST
>       ``chroot=dir`` can be used for doing a chroot to the specified directory
>       immediately before starting the guest execution. This is especially useful
>       in combination with -runas.
> +
> +    ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
> +    by switching to the specified user (via username) or user and group
> +    (via uid:gid) immediately before starting guest execution.
>   ERST
>   #endif
>   


