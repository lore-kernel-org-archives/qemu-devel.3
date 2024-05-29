Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F925C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIRL-0003tN-Sc; Wed, 29 May 2024 08:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCIRI-0003sk-P3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:29:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCIRF-0004NM-Pu
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:29:55 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45eso1882641a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716985790; x=1717590590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+ZyOymg1yaJtv/cPSk++IvY/aukPP015bEQDxdALtY=;
 b=lq58nkktu0mcJ2wCsXEX1HOOW6zqdRkujbI1h9OAMRYRGHZFWHsyMMY3i6p3DR5z/5
 OZiRfy25LzhGgBTnS3q/FQVtgy5zU0OXCC8a/NW2ymT24MfQXQVVTuHiy5vAJGWcc8g2
 vJ+HmPCCxVvw6x+q7nZgJw53e+byBHOsuC5LbDDPRXg/Lp1/sl82ykZE0ZijDNGwQzLj
 qEZWTTWegw2jePoq8CqRwUUffjCKfq5teAIwWEvQTJld/lXMmCNDp6yAyyECwtE+l9qB
 A1ESlTe143QMkeTkiW7uO10VKuQ/SnfMDheHFGxPm/IpDOn4VZq/jyszaY0MtJVUua+q
 E8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716985790; x=1717590590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+ZyOymg1yaJtv/cPSk++IvY/aukPP015bEQDxdALtY=;
 b=Xz6NmZnG5HtI1dqW3WjBSnpWBQ0qzjyrplfh72lPx/EDgDGW+AEi7KDHtIFaPgdrcJ
 TMWRUxW1wN5DAzn2+VGRXYvUab5OZi3zONDko+lMza6Inlq2pHWSKsjyl/Qio/oO68Uv
 z7YIRjSyFA+t0ldFyIg3lN/ILfa1VlvscFWjHG0w8p9kWbODAETLflikNUXyzjG4284C
 dYug4I4t3lhpQLkaUvJSImH+ZksJPUKsyY6A8tRgpp6VgiTKIgHWiX4bPA3dItAHpOto
 69PJce4lM7AiWVo6GZdS4TS0KOIlPAHQ0CCIzoUicvcRjzEWa+REDJ0HVoM/1DP5L7Ml
 s6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrOSqUWB9sS9lR1+fGm0QDDaM0tC5UUzJbk1zaA7C/8iKrCbDBiZd8HmZs6x7Wt+lrbUlEWCjYLylvlaeMAxqgFGzTBkU=
X-Gm-Message-State: AOJu0YwF2xmyplyf+m36jRrq8hxF7LJvF07MX5tY92JnZLDYs0A3m59c
 vy+ZuxhF3BZBJmHmMeY12XGx4HPKUPKXfw9VTr/Qg6P4JM2bAq+ObF7979xJeUY=
X-Google-Smtp-Source: AGHT+IF4mZ5PDXvp25+vzptp2ppEjfXoLPPvGbQ8DdQfmnp/jlzVZgxtKRzNm4LGdx0mEvfVlNqivA==
X-Received: by 2002:a17:906:66c7:b0:a59:ba2b:5915 with SMTP id
 a640c23a62f3a-a6265119463mr1828286366b.50.1716985789940; 
 Wed, 29 May 2024 05:29:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc514d9sm713542566b.109.2024.05.29.05.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 05:29:49 -0700 (PDT)
Message-ID: <c5caf29e-33a3-4d63-ad45-c0622675d74e@linaro.org>
Date: Wed, 29 May 2024 14:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sysemu: add set_virtual_time to accel ops
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 17/5/24 00:20, Pierrick Bouvier wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> We are about to remove direct calls to individual accelerators for
> this information and will need a central point for plugins to hook
> into time changes.
> 
> From: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/accel-ops.h                     | 18 +++++++++++++++++-
>   include/sysemu/cpu-timers.h                    |  3 ++-
>   ...et-virtual-clock.c => cpus-virtual-clock.c} |  5 +++++
>   system/cpus.c                                  | 11 +++++++++++
>   stubs/meson.build                              |  6 +++++-
>   5 files changed, 40 insertions(+), 3 deletions(-)


> diff --git a/stubs/meson.build b/stubs/meson.build
> index 3b9d42023cb..672213b7482 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -3,6 +3,11 @@
>   # below, so that it is clear who needs the stubbed functionality.
>   
>   stub_ss.add(files('cpu-get-clock.c'))
> +stub_ss.add(files('cpus-virtual-clock.c'))

Are these lines <...

> +stub_ss.add(files('qemu-timer-notify-cb.c'))
> +stub_ss.add(files('icount.c'))
> +stub_ss.add(files('dump.c'))
> +stub_ss.add(files('error-printf.c'))

...> due to a failed git-rebase?

>   stub_ss.add(files('fdset.c'))
>   stub_ss.add(files('iothread-lock.c'))
>   stub_ss.add(files('is-daemonized.c'))
> @@ -28,7 +33,6 @@ endif
>   if have_block or have_ga
>     stub_ss.add(files('replay-tools.c'))
>     # stubs for hooks in util/main-loop.c, util/async.c etc.
> -  stub_ss.add(files('cpus-get-virtual-clock.c'))
>     stub_ss.add(files('icount.c'))
>     stub_ss.add(files('graph-lock.c'))
>     if linux_io_uring.found()


