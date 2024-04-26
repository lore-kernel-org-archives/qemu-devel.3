Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D815C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JRM-0000Nd-Qv; Fri, 26 Apr 2024 07:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0JRJ-0000NR-GD
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:08:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0JRG-000256-6Q
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:08:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so8067755e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714129700; x=1714734500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s9QLLQUUQ/djfo7WcGic6emUCaiSTlhLyfZJ82BKEpE=;
 b=iK8IsiZlpBLV9qa6oml8IzxGwPhohWuK409rl++4f9AIcC+9IGRsihAIXFQ1QW1hPX
 BMTlJG1Gy4clEkDJyfkzP7goKHltPjeI5CG50Xa3h0pgzMET3wZgunzvEYB/eVEYjwKi
 NqVyxVjQalGRHT9ofjTLU2gKZmQZ4Uk4Cezjft1ZJ9iEyi5qBkr67bV+9Iyrwhu9p/E0
 8XZbdTFyeiFQT035sC7izJ1ocvctIz+V2L7lIHdlsC4Wzhmkj4mRMqu3yyIAqvZqsnob
 /tBD+XcTSJPADC8y4F3Iw6rZ0zkpKkmqtG8yCJ29ePWQrCD0Ev1zUX/FYdmMHblilfMj
 VR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714129700; x=1714734500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9QLLQUUQ/djfo7WcGic6emUCaiSTlhLyfZJ82BKEpE=;
 b=V2BSXu/cx3K4N/VelmP6NZ05dFyoeZ+A7HtD4HH6fs/8CIn0urzjsHP6Rsm8MP0cUG
 TqEHrQI7qswxME0VJ0X7uipMusDrVYwPEHc4/+0PPRiREqBgV7G8YLyejLhUQprI0Otj
 xu2aaILE9U/Y3YiuujuMZXaz3J7IWxvGLE4ttPZ9JwB8MfGbTpHpiiPPkplJvLpoVXiK
 N45Q119pbe+LvYi/Mx8cg/yj4pukJBHfinjInFeqicpF0TYMxJsR9SyoM9UtDLb1EaPf
 Cm+buWtjsLC6TmYqBe+vRtgpjOzDaF51zRUaZnwiFmGHdaM0xBwhR6ZvoO3kl8BoNh4c
 /nWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ISesxUZjazl3qIwfoe18lsIn3T8T6DPXaxRArCtF88mFdxo7RYDSxZAu3zBozgjfW6QXa01YV6u1he+OBNMpr8UvNBE=
X-Gm-Message-State: AOJu0YzDs7m3tsv6opArCgIEzCGeqeVIJ06B/gEtZz/Uy6OWTQzCb98v
 +QRLx/0zZn3stv+2py4l9Jp7SD6WVGz+429UPa4IZGiHZwuchPJZ02fwM6k3TPQ=
X-Google-Smtp-Source: AGHT+IHyli7ozBqLKs8Z3MYNUfN+VRv6U9zaL8NcS0+wf50FnY5+o2f5JFZNyXKGNS2hwT77Wec3lA==
X-Received: by 2002:a05:6000:18c5:b0:347:2b42:a397 with SMTP id
 w5-20020a05600018c500b003472b42a397mr2208439wrq.4.1714129700224; 
 Fri, 26 Apr 2024 04:08:20 -0700 (PDT)
Received: from [10.79.37.249] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a0560001b0900b003456c693fa4sm21943125wrz.93.2024.04.26.04.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 04:08:19 -0700 (PDT)
Message-ID: <3fb94fa3-a20c-4eda-b7a5-44e99baa48d4@linaro.org>
Date: Fri, 26 Apr 2024 13:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stubs: Add missing qga stubs
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240425110414.36977-1-kkostiuk@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425110414.36977-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 25/4/24 13:04, Konstantin Kostiuk wrote:
> Compilation QGA without system and user fails
> ./configure --disable-system --disable-user --enable-guest-agent

So this config isn't tested on CI.

Maybe worth enabling QGA in the build-tools-and-docs-debian job?


Please include the link failure:

   /usr/bin/ld: libqemuutil.a.p/util_main-loop.c.o: in function 
`os_host_main_loop_wait':
   ../util/main-loop.c:303: undefined reference to `replay_mutex_unlock'
   /usr/bin/ld: ../util/main-loop.c:307: undefined reference to 
`replay_mutex_lock'
   /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function 
`error_printf':
   ../util/error-report.c:38: undefined reference to `error_vprintf'
   /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function 
`vreport':
   ../util/error-report.c:225: undefined reference to `error_vprintf'
   /usr/bin/ld: libqemuutil.a.p/util_qemu-timer.c.o: in function 
`timerlist_run_timers':
   ../util/qemu-timer.c:562: undefined reference to `replay_checkpoint'
   /usr/bin/ld: ../util/qemu-timer.c:530: undefined reference to 
`replay_checkpoint'
   /usr/bin/ld: ../util/qemu-timer.c:525: undefined reference to 
`replay_checkpoint'
   ninja: build stopped: subcommand failed.

> Fixes: 3a15604900c4f433c970cc6294520a98f201287e

Fixes: 3a15604900 ("stubs: include stubs only if needed")

> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   stubs/meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 8ee1fd5753..3b9d42023c 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -21,12 +21,12 @@ if have_block
>     stub_ss.add(files('migr-blocker.c'))
>     stub_ss.add(files('physmem.c'))
>     stub_ss.add(files('ram-block.c'))
> -  stub_ss.add(files('replay-tools.c'))
>     stub_ss.add(files('runstate-check.c'))
>     stub_ss.add(files('uuid.c'))
>   endif
>   
>   if have_block or have_ga
> +  stub_ss.add(files('replay-tools.c'))
>     # stubs for hooks in util/main-loop.c, util/async.c etc.
>     stub_ss.add(files('cpus-get-virtual-clock.c'))
>     stub_ss.add(files('icount.c'))
> @@ -45,6 +45,10 @@ if have_block or have_ga
>     stub_ss.add(files('qmp-quit.c'))
>   endif
>   
> +if have_ga
> +  stub_ss.add(files('error-printf.c'))

So now included twice, not a big deal.

> +endif
> +
>   if have_block or have_user
>     stub_ss.add(files('qtest.c'))
>     stub_ss.add(files('vm-stop.c'))

       # more symbols provided by the monitor
       stub_ss.add(files('error-printf.c'))
   endif

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

With updated description:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


