Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F53C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8Aq-0002i6-54; Tue, 09 Apr 2024 05:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru8Ao-0002hS-0b
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:53:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru8Am-0000SP-AI
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:53:49 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51a1c8d931so478110866b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712656426; x=1713261226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7/ovNRajK0lnrAKtAxfGldepyF0LEL+IN7nUNnQ/is=;
 b=dAtY4QCA08KNF8e88Ja4zUSt5KOpoNDYVRFPzZlEH1eydpKypUw05GSm6TXQS8gGXo
 b4lDSeXFXZsRaeGhobUT9ZMTK9MNicrTaEoBDx3Ry/ARVe1Rux4nR/psLJQ8tUa5vVnl
 ZHQHpvVbP6jlYA0bQSsU0NlAdj6MkDnQbaEWEjidOexV6NTwg9oT5U9pXxhT+mWHcuZS
 mbCuFi75hPGumVl2FCAalMwg7eKKgihHXhvUC1zAgm8HrgjY8QD1hHU7xPLygvOjG4oX
 0s91Xx+K+qkAODYYepAwQZbR67fxlCbJUrqq9sZ4UKl5EQNkbVb2bxPbmSgGF1ZgV0gZ
 E7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712656426; x=1713261226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7/ovNRajK0lnrAKtAxfGldepyF0LEL+IN7nUNnQ/is=;
 b=oiy65ivEZY37m3eyP1jl4ZG1I6Oqm/RyUgY+eCuNG5z7FueBWS2o6+KETkNw/ytHR/
 EtOwWzXCD1V01kUMzoI7s9sFHnBqGqd6I+FeU6MnuE0oyu8p7fYNYi7Ketm/FmpkCoOU
 gFWO7t3oOHMM4iuKUSA8Fdp+Vu+doePtAmBwK6l2IY8RiKd9Nyjsvum54iea3xNjGF6s
 JnbcyaboeukgWqrAWGWzulQVLKHDYRdDeYXU8fSOON6m7TloazSDIymOx0gAWQgg5fk2
 Bo5MSEiWh5Mq7O6oBOHpVws/DhASN5ubdYSnNOJsGQYn5WtrxscpgidjLwwDLG/Yk0SD
 TZIg==
X-Gm-Message-State: AOJu0Yy9d7tTZqGmlKD0xqFtlwV/0ZLwaW03xQBXyDfg9t5GUVjfhj/i
 nD3z1XZiJd43E3RSrwwuEIem7jkL7iURGcRsYbamAJYU1gVlOlWLo6eDheFQ8co=
X-Google-Smtp-Source: AGHT+IFwtRAyb9rLBw73RGgZOVvPQvAHNEuLNIYD/5dT/Ki5Sy8aKkYG+6HnkSYWbdkt+QJch2IyJA==
X-Received: by 2002:a17:906:ac7:b0:a51:7d3e:d09f with SMTP id
 z7-20020a1709060ac700b00a517d3ed09fmr7151613ejf.43.1712656426664; 
 Tue, 09 Apr 2024 02:53:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 lr12-20020a170906fb8c00b00a4e32ea1c3asm5535081ejb.146.2024.04.09.02.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 02:53:46 -0700 (PDT)
Message-ID: <9d9c52ca-8ac9-45fa-980c-8240477cca2b@linaro.org>
Date: Tue, 9 Apr 2024 11:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/35] misc patch queue
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240408174929.862917-1-richard.henderson@linaro.org>
 <CAFEAcA-qn-zP2-OkeW1fLW2OPZbfk35jKZ0YUHXQ5Xf4Rma1Ow@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-qn-zP2-OkeW1fLW2OPZbfk35jKZ0YUHXQ5Xf4Rma1Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 9/4/24 10:50, Peter Maydell wrote:
> On Mon, 8 Apr 2024 at 18:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This started out to be tcg and linux-user only, but then added
>> a few target bug fixes, and the trolled back through my inbox
>> and picked up some other safe patch sets that got lost.
>>
>>
>> r~
>>
>>
>> The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:
>>
>>    Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240408
>>
>> for you to fetch changes up to 50dbeda88ab71f9d426b7f4b126c79c44860e475:
>>
>>    util/bufferiszero: Simplify test_buffer_is_zero_next_accel (2024-04-08 06:27:58 -1000)
>>
>> ----------------------------------------------------------------

> This pullreq alone is more patches than have been committed
> in the entirety of the rc2-to-rc3 cycle so far. Are they
> really all important enough to put into rc3 on the day
> we tag it?

My 2 cents, I'd keep these for 9.0:

 >> target/m68k: Fix fp accrued exception reporting
 >> target/hppa: Fix IIAOQ, IIASQ for pa2.0
 >> target/sh4: Fixes to mac.l and mac.w saturation
 >> target/sh4: Fixes to illegal delay slot reporting
 >> linux-user: Fix waitid return of siginfo_t and rusage
 >> tcg/optimize: Do not attempt to constant fold neg_vec
 >> accel/tcg: Improve can_do_io management, mmio bug fix

Postponing these for 9.1:

 >> util/bufferiszero: Optimizations and cleanups, esp code removal
 >> target/m68k: Semihosting for non-coldfire cpus
 >> linux-user: Cleanups for do_setsockopt
 >> linux-user: Add FITRIM ioctl

> thanks
> -- PMM
> 


