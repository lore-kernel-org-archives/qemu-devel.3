Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6F2C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WBg-00005K-5I; Mon, 28 Apr 2025 17:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WBd-0008Tz-ER
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:38:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WBb-0004N0-PF
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:38:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso5702671b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876326; x=1746481126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+Iq1N6on9ErzNaz7jJzAm3wbw1jKo4KxFviGK5Rf+M=;
 b=Ov8y7/5LSDef8KxgT7fVaCczVqK62VEVdLrfTc3QNr5Dk6vVeeuaZvNd/1nXa48FmI
 kxsHcRYlWGrWWwONzngehfF71HQcX/y0sTjI0PnIa4Q5B0whsZvwQVz5SpZHXi8C6qO2
 ayQAZoZMc897eL2S/AHqXFUZNhi46XYmr7W06lkBUoep87ZCOwmYWuiXFjGf5AugTrL/
 mCDQCpYN6Sm3qM0gNPM7gtwjrjf3km+mS/MuYA/IuliBJnLr0kaYgj7cygbkApTkTiaI
 021Qru38dejrvL3ZBNTshodyV9wADK896HOWqOUbuLWA3m7XTkpbR8LHn5GFwh8BvnT3
 idYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876326; x=1746481126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+Iq1N6on9ErzNaz7jJzAm3wbw1jKo4KxFviGK5Rf+M=;
 b=QpHxITWJdQdHluEVHFoj3bCxUbWVxFGV1h4T84zLn0IkGz9KyqxAPkqu3XELhhtQ0V
 L7zjuiEXDqxQLfVUk3lFxGaIVJBl9u0S7rblKZ5ulAnBjTRVJjAVWNGqRfVJhFya1qs/
 srjnZ3MGD1obf4Fy9LExHp+tZkY3xod1MtdlHBVDBImp6ZBF6yc/VOaUiQi4mUqbZ0Rq
 1AhWP0p7hp50b/4ay6x4KANBHU2suNGZhk3vFWcKwHmCW6HmNt+AnppNCLZIjeT9q+Wd
 MiVBTFJKnLBvl1pZoku7U8vyCnuH3m/EJfv350Z5Ak1bALHuSQIEfs0c9Pw3EsK+Iddw
 CZNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUndEKcl0nh6ZYOUtJqhiJO4w1mICObUbEVkGrIFTKOj7tPTyw2/g3tsoIZt13+bCSF3D5kIxPDOg5o@nongnu.org
X-Gm-Message-State: AOJu0YxW3jJ24mgPBCGPDVvoWdK4GOE8T24myZMZSNEnD64kli7RX0bj
 z8mE21rCWE3Sci8nvouzV7EtrbxOQlBWneeMnsACogs2TuJaHS1sLBnBnNWLmPM=
X-Gm-Gg: ASbGncswNtryD1/6LlIEFAIMmeI6woECz1DFINjHTXSvQPjzfUz6SUjiisN8zZhM6gG
 cNAa94dIziQU1q20vqF8Cpa5pv7MVzW/qRbwhgj3uG4FAJo4POUmPsUb4EzfsIsiM7wEX1MVc5o
 1bqUkkuIgoygEmOriu3V3eiMvtz6pb1vI4aPJXTXp5UkdvdRfeJT6rrNo3Dqr3r4fBNwmw67mMW
 oqlYVaz6fTmNejxNmStT2zrfHG4vUv9quFcHpUNCC88ZmJYyJuof5ID+lCVgpKr59Sn9Pg1P4VB
 ocXjyqml5+ooD2LRZ9lC2lEXPjXoV+dMclzocgj7hRj4KciiCIEuRA==
X-Google-Smtp-Source: AGHT+IH3zc3FhiCQuYxWyETCdZ9A+3gLizjHG8Bt1VkfRQENqqhPQ4JWiS5UER+5aVaLOvsFuiPiIA==
X-Received: by 2002:a05:6a00:218c:b0:736:5753:12fd with SMTP id
 d2e1a72fcca58-73ff72553c3mr15091207b3a.4.1745876326001; 
 Mon, 28 Apr 2025 14:38:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a17csm8521845b3a.111.2025.04.28.14.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:38:45 -0700 (PDT)
Message-ID: <2b411bc3-cb00-4e3e-8f63-325716da8e40@linaro.org>
Date: Mon, 28 Apr 2025 14:38:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> Initialize all instances with cpu_reset(), so that there
> is no functional change.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h | 2 ++
>   accel/tcg/cpu-exec.c        | 3 ++-
>   target/alpha/cpu.c          | 1 +
>   target/arm/cpu.c            | 1 +
>   target/arm/tcg/cpu-v7m.c    | 1 +
>   target/avr/cpu.c            | 1 +
>   target/hppa/cpu.c           | 1 +
>   target/i386/tcg/tcg-cpu.c   | 1 +
>   target/loongarch/cpu.c      | 1 +
>   target/m68k/cpu.c           | 1 +
>   target/microblaze/cpu.c     | 1 +
>   target/mips/cpu.c           | 1 +
>   target/openrisc/cpu.c       | 1 +
>   target/ppc/cpu_init.c       | 1 +
>   target/riscv/tcg/tcg-cpu.c  | 1 +
>   target/rx/cpu.c             | 1 +
>   target/s390x/cpu.c          | 1 +
>   target/sh4/cpu.c            | 1 +
>   target/sparc/cpu.c          | 1 +
>   target/tricore/cpu.c        | 1 +
>   target/xtensa/cpu.c         | 1 +
>   21 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


