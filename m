Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35585D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej2b-0003Fs-Kw; Sat, 10 Jan 2026 19:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej2P-00038z-IU
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:10:37 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej2L-000858-I4
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:10:31 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81ef4b87291so525069b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090226; x=1768695026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=okYbRr/A+n4TD1UgFnCrWf3pqEju1Mq3RiJfxa8mfT0=;
 b=ilF2Ja3Q51m+v7ibZt/OmpGOMaIPc/3WdI5V0HaI2wF+j/sXuUswH9gnrpq/iKER45
 Pjsw8sJ84LYLw7RlrKK6/KwoWKwOlibZXVbMjYJ1foW1jEhGjwNHBbl5P2I8SrhOru9I
 u6a7JBGM54+YS/qVOC5zd0O2mYoA99bKPEZzf67HBviuHzmwLZ6+GNjOnNPoZ8YT7j9y
 hFDCXt5xIADh2uDEStPoN0dHCUVH9qpJ+G5ElX+1jnQBMZ32mBqGWZXSEBivX6MkA3qu
 E6S92YMMfcOorPBYyRHxQNJNovtjYs+tN+YelplxPTYRMYI6YVDqM+sXvwfDYKRDeR0L
 Kz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090226; x=1768695026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okYbRr/A+n4TD1UgFnCrWf3pqEju1Mq3RiJfxa8mfT0=;
 b=WtXt6WAr9/d5EXaLBKw+G6hSXjHAXmVQ0HGVHMJ0r0R7EQ2sxDi+TYNP2xHdWg5Ddm
 24PHX7u6ftH20iFZrdW4G0ZCBKAmV/7rr2lgHEV7VZKnOxS+rzNp/CLO5fyklIkaiEBx
 IszseqFFJ61sHNxQHVAJt8wZzvziuYJ/k6w/B2cMwYCHiniOftHLBKP45keHCI7OcrV+
 zc+Sq8aVuJf/IUOMIeW8eAef+wN08m08HEYSepC3ZF3+7ZdD3voS28bDcHCz+aE+JAoA
 TcpaOnsp56p4+VTBBQESAniuujjDy17PHgICWBXDrn+hSf3cwT3eyHkHf+wNkY6FXGo4
 lX1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwNCVHFs8piA4SqcHAx+5DvU0TiCd2gskdh+UJ2HSlMkT1DnseBWmoC7xRjUFmDqA07YYrDIV7CHiJ@nongnu.org
X-Gm-Message-State: AOJu0Yy95Y0KTW+XG7X+eg4XaPqVDPAZwGekQZmB3yLSds2UAF4Tq7pG
 /bK5SFZdJeia0syfc7Ed7QzG4SeIXamA8AGT6n2jbXpej85Uk6HE4W1UBbb6CYRvCe4=
X-Gm-Gg: AY/fxX7T9V82Gsv1kp3SCmLkXy9KjeQAuCuQ1RisCBZs6luLYT0MZlsxXGhzeda8iAA
 E/285oeAUK4CND6ZwoXLmh4lemxLP84vCVbWBAeGcGizNm/LpxFtwy6X/+DSj7AHAPcGC6LllfW
 Ja+L3zOrx6PNlI5xTWaE7k+S4eONqo1OmSJPOfckn/Fyt5zKqwBNMROrzFikvzOQKEmOAuuTP05
 gl+pPIsZgUQJ45uE9xBVDWj8w01GkJdj+7D/lisyzLqdRO2KImBxh5ukq/nO6Zr44s72hhVuujk
 5gy5YEb+b6moK3Sn7ipuMUxZLmBEJu2233TgPivuvh8KGpVoQ8g3KkdesHNinWJaFJOV9yutrwa
 ILUZr7kKUzLocPrlPj5iVJjaRELkQNhNuScRwmjM0gFd1HbSDtu9uyYSDYB3gASpziGrqxRjgc9
 95bkvOZQ4yQVaBI0slblm398xizw==
X-Google-Smtp-Source: AGHT+IEZL551nDiXhj7N1f8lEjEXDw0PiuHv8jH4xilWNaTEgM5AQunYJU5RZrC9lrOqX9WRi+72qQ==
X-Received: by 2002:a05:6a00:4398:b0:81f:4abd:f15c with SMTP id
 d2e1a72fcca58-81f4abdf5bbmr1052075b3a.70.1768090225598; 
 Sat, 10 Jan 2026 16:10:25 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e6772688asm5112867b3a.45.2026.01.10.16.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:10:25 -0800 (PST)
Message-ID: <e7db64eb-9d74-4034-9e22-9d4d49ee5094@linaro.org>
Date: Sun, 11 Jan 2026 11:10:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/openrisc: Avoid target-specific migration
 headers in machine.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/8/26 07:06, Philippe Mathieu-Daudé wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum header requiered:
> "migration/qemu-file-types.h" and "migration/vmstate.h", which
> are not target-specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

