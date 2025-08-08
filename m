Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BADC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTyD-0000Uj-E8; Fri, 08 Aug 2025 16:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTyA-0000Tr-Ef
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:45:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTy4-0003dI-1F
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:45:42 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4281fabee0so1789734a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685934; x=1755290734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4rHUI8tB617YILcHKcNvRwwm1YDzzu/wImnaDWUnf2s=;
 b=kzABMb0Xz7hqEv8aHHsnF57io0/PzCrR63Xlp21xC680DZ695eLDMqxDMo7mYQIXrS
 loXetN1CrPZeXQAp2Jp3ezBQ+IFwE2OLCIkUWqHMpJtW6BJD3qO2wJeta1ELPEuuVsDn
 YfBqhimUjY9drEPc2jE7SXJjeM46kKmFI1vCcC6ODwZ+Q7mK0QXGzYN/xek9ltIGHSGp
 Eu+J33H9XSdPHJpl/qkcl3enqSP+VBjrLBdb71E4Gm9H5Lo7CQP2rgKEJKLL9xfhXB0g
 gprQ9wuJWxdaWQlFreS21d1wW/Mm2aWdpMGweLzV6GhjzvNxVNZlQ5H1apVEdeF3Fjpt
 GZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685934; x=1755290734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4rHUI8tB617YILcHKcNvRwwm1YDzzu/wImnaDWUnf2s=;
 b=IXuaYxHgnXDcHBAQ2+xjZ1kyC4zkMV7ZErou5Hprd76Z2z8DsCaLq6Jq6J4fGRoDqX
 Q0W7elH5uYwShV8jYzhaLPWsOV7ugn2Os0VIq9E6z10wSlzLeey8alhoz8wMjMXuVb0R
 s2s+MKC9FxJ8QxVgHsWAxq0i/pa+p2dOSoacx34crapcqEokRpnsB9aN0xe03MCbq0dt
 xvUPpy5MjaibFtqIactM2SDHGt21juoe/Erj9C6uDM4Q6+1Y6IegytOEfeyr1ka4zh/B
 arQM9UBwSiCl/TiFAw1bmOtY5Jgzt9hB+6vFlXcyODpkJAcXge0KPwsgBr1jOQruqHIY
 DrjA==
X-Gm-Message-State: AOJu0YzMkQ8cpCS5zXYOhiEoleHcrYtR+1eqVaGYzAQTaI1cUjyUYhYZ
 h3eo1vY71Q9z9QnqY+4Aa65/m0Rym5PySMQIzOo9hFLMu89ryr5CQ1p6lLY04toljF2ERuNr3gX
 N+3AQdgHcag==
X-Gm-Gg: ASbGncsAwCbX59IL4id2Ub1IPwvk0X1xu7hDDI8zNCDnHjnWdMOqp74ooHc/NDVlcrH
 eMPRwMks3koj3azLlVOy7YJm++B/9umn5FuUY/IyPga7RJLtiQ3wdY+SldOYRNskl8wx++uN/34
 kudpWkdMJGDgIF0L/gPMymlTQ10bq+WnsV/sU4gsCkNTX1/+7ZUmUlf38doDiuXsQFuSn8ht9V2
 PKg2htQcxmesR49DnGMKKGzjIajviXD18mGQlp7teu5NQfCf8swaUIlWR6Ve7HDMg2zMv0XHdSQ
 UImjkPgHglE/NDMPVdczknipkk7jGGU6gl3QwQfRTmtCVq7+xcj9nJfgu7tR11UU6x/uQX4VzRU
 OtMCCCaOqjfg6p81QXkcXR7ZObcZ7/QFr1Gk=
X-Google-Smtp-Source: AGHT+IGKwEoLOn+kH4HyU1PFmEu192YTj0yYCOrzSRU/TzrTb11QUD8gJA7tan5Rg39DqVQS6+6BVQ==
X-Received: by 2002:a17:903:19e8:b0:240:8cb5:98b4 with SMTP id
 d9443c01a7336-242c205b7bamr57583555ad.23.1754685934339; 
 Fri, 08 Aug 2025 13:45:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef67aesm218011055ad.6.2025.08.08.13.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 13:45:33 -0700 (PDT)
Message-ID: <676bff82-0f56-4e86-bcb1-e0a3f57096b6@linaro.org>
Date: Fri, 8 Aug 2025 13:45:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] contrib/plugins: uftrace
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/7/25 7:06 PM, Pierrick Bouvier wrote:
> This plugin generates a binary trace compatible with the excellent uftrace:
> https://github.com/namhyung/uftrace
> 
> In short, it tracks all function calls performed during execution, based on
> frame pointer analysis. A big advantage over "uftrace record" is that it works
> in system mode, allowing to trace a full system execution, which was the
> original goal. It works as well in user mode, but uftrace itself already does
> this. It's implemented for aarch64 and x86_64.
> 
> Let's start with concrete examples of the result.
> 
> First, in system mode, booting a stack using TF-A + U-boot + Linux:
> - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
> https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
> - Stat and open syscalls in kernel
> https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
> - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
> https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
> You can download and open it on https://ui.perfetto.dev/ to explore it.
> 
> Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
> - Loading program and its interpreter
> https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
> - TB creation
> https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz
> 
> If you had curiosity and now you're ready to give some attention, most of the
> details you want to read are included in the documentation patch (final one).
> 
> Overhead is around x5-x15, and long traces can be directly filtered with uftrace
> if needed.
> 
> I hope this plugin can help people trying to understand what happens out of the
> user space, and get a better grasp of how firmwares, bootloader, and kernel
> interact behind the curtain.
> 
> v2
> --
> 
> - trace active stacks on exit
> - do not erase map generated in system_emulation
> - add documentation to generate restricted visual traces around specific events
>    of execution
> 
> v3
> --
> 
> - fix missing include unistd.h (build failed on MacOS only)
> 
> v4
> --
> 
> - add support for x64
> 
> v5
> --
> 
> - addressed Alex comments
> - split plugin implementation in several commits
> - removed instruction based timestamps (only use time based timestamps)
> - removed sampling implementation
> 
> Pierrick Bouvier (9):
>    contrib/plugins/uftrace: skeleton file
>    contrib/plugins/uftrace: define cpu operations and implement aarch64
>    contrib/plugins/uftrace: track callstack
>    contrib/plugins/uftrace: implement tracing
>    contrib/plugins/uftrace: implement privilege level tracing
>    contrib/plugins/uftrace: generate additional files for uftrace
>    contrib/plugins/uftrace: implement x64 support
>    contrib/plugins/uftrace_symbols.py
>    contrib/plugins/uftrace: add documentation
> 
>   docs/about/emulation.rst           | 197 +++++++
>   contrib/plugins/uftrace.c          | 871 +++++++++++++++++++++++++++++
>   contrib/plugins/meson.build        |   3 +-
>   contrib/plugins/uftrace_symbols.py | 152 +++++
>   4 files changed, 1222 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/uftrace.c
>   create mode 100755 contrib/plugins/uftrace_symbols.py
> 

Sent v6:
https://lore.kernel.org/qemu-devel/20250808204156.659715-1-pierrick.bouvier@linaro.org/

