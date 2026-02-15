Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C91BEF585F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 02:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrRe7-0007vr-Bi; Sat, 14 Feb 2026 21:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRe5-0007vh-Rt
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:14:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRe4-000307-AC
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:14:01 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-436356740e6so2435634f8f.2
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 18:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771121639; x=1771726439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qeDYONQPYFgRyDRDNx2o0aUP2ozGsCglr6sBEql0pxE=;
 b=GyURtcdHmiIF9zGbg6Ndf8oL4gNfWhCDuEIuFzwLuVw5zMpwIJr3foLs2TwZCbP8Xp
 RrGUBdynKcmG3awi4QR0trexc/P81PwLfC2AZmKW8VvmLJXRMq3mF+Ei3UiACzp5ZiF4
 T9XmVovPqM2NYJgLTKRkniN60eF9H0IUXWdqJN8GEMtw7xmioLm1zddflQKCGXtdPw+s
 O5OeojKyLfbdfsyyoUwUsZ2CBgakh+17Msa313O4HLgymKquZl4id7TtGdOW1/jdE/sD
 kJLjS+MRdm7A+biAeCy6JHOdBcf4rL/Oc3cm09ECmG4/HaaIqDlo7CcgTypYi74mktyg
 fsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771121639; x=1771726439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qeDYONQPYFgRyDRDNx2o0aUP2ozGsCglr6sBEql0pxE=;
 b=rJ82oHiW9ghft5Qjsbca9W7f9mJKAST5awFlY99MicCH2A8ze9Xv+XZgjux/7YtZRF
 7cJojHy5SmqOOSEvEiKm3ovYQTKK4LCFbeVr6ODAB76SLq2BxtBciVUMWD/NbnxgJMN6
 nwQaVRWM5gHH1ZZIa4PAaY0ZypcFwcGaMgwvLj7CoDTccD6WlJTkTMP624WFjQiKTunZ
 KZX3g4HADOH5HHmRHoo6T/ZuyV0qqzdyDlwaGZ+m8E9/O1ZkrOPdpZ+2bOvh3CidyWln
 OvYlotrNAQZdpFcO56CSM1K+2lJs2vsUEcR0LqQAPgMeWYvwzg83sLwHboFEIHN43+9I
 5C6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6/OMUkd9ZN2MWQ8dAD4aLX9/4xjs4Z7FE9sZqYliu0QkQTE4LrsePWB5XxoXS+hGNZhaLCXnI87Y+@nongnu.org
X-Gm-Message-State: AOJu0YyNQG1Mex17kkLxsw882oUBBtmgLOxlvVbB5QShX4kPg08xqyhh
 ghECceQrkRWIjKafEsJG+z354JgJHr10Du4WvZ8V+DScKz/5zZ1sueK+R6EggLydx3I=
X-Gm-Gg: AZuq6aLKg4LFtG/rLsu7YqGh8u1ogjrkh39vgBihq3AQGeAWw+c27B9mqsEmhvKUFpn
 vDZDz6aye2L0MJHe8Gu6WsPzs7bk3itH/9hoJGtXSPs0+fBPEhFd+aOyErgyH81BTflzSrYzKXH
 T5qAZid0Ot+fcvnSPzucFHJO48ovER2SSNttn9MU0tYv5I53I9gf1DfyygDl0R3N3WDmjm8pnLz
 dfUSmz6qaIwa/aULdAbcc7zDZPRPeQPZdVB7Srb3kspb0Q3z6fwg5br/wYCf66BV+bKhqfEk3PH
 6uho/DugLU9EmsAJg+FAaPJG7SXRocJgOllEyJIR1+yTUaZlmlNAd3qfcQKpTTsAeJKkWIrPRvh
 /rqz+55ca9deJVOhfyq+N8D9WIDwWoVjxwzIBK9txgznFFBTq0R9c8HS/aYO7Bk1I4f+kReCB9b
 AgUZ1IvyrR5SkrXwK7xTHxmclAv+U8sg3Ua2ieU3UCjvESsU+sgNH9M3ewv0PkbRWm8w==
X-Received: by 2002:a05:6000:2508:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-4379dbad82fmr7981436f8f.53.1771121638701; 
 Sat, 14 Feb 2026 18:13:58 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abe3b3sm19694411f8f.18.2026.02.14.18.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 18:13:57 -0800 (PST)
Message-ID: <c5abc190-0fc4-4c86-b273-1d2d45802a40@linaro.org>
Date: Sun, 15 Feb 2026 03:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386/hvf/x86_mmu: Fix compiler warning
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260214131659.31378-1-shentey@gmail.com>
 <20260214131659.31378-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260214131659.31378-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/2/26 14:16, Bernhard Beschow wrote:
> When reusing the code in WHPX, GCC emits the following warning when compiling
> for i386-softmmu under MSYS2:
> 
>    In file included from ../src/target/i386/emulate/x86_mmu.c:20:
>    ../src/target/i386/emulate/x86_mmu.c: In function 'vmx_write_mem':
>    ../src/target/i386/emulate/x86_mmu.c:251:25: error: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'target_ulong' {aka 'unsigned int'} [-Werror=format=]
>      251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~            ~~~
>          |                                                                       |
>          |                                                                       target_ulong {aka unsigned int}
>    ../src/target/i386/emulate/panic.h:34:12: note: in definition of macro 'VM_PANIC_EX'
>       34 |     printf(__VA_ARGS__); \
>          |            ^~~~~~~~~~~
>    ../src/target/i386/emulate/x86_mmu.c:251:48: note: format string is defined here
>      251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
>          |                                             ~~~^
>          |                                                |
>          |                                                long long unsigned int
>          |                                             %x
> 
> Fix the warning by reusing the target-specific macro TARGET_FMT_lx which exists
> for this exact purpose.
> 
> Fixes: c97d6d2cdf97 ("i386: hvf: add code base from Google's QEMU repository")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   target/i386/hvf/x86_mmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

