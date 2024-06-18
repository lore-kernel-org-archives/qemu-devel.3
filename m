Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D2C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJaBk-000488-Jg; Tue, 18 Jun 2024 10:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJaBj-00047G-Ap
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:51:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJaBh-0003HX-6v
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:51:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4217a96de38so40230795e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718722316; x=1719327116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxgvLOx7YJKBqNY7kF1pTfUqHbVy758/LU10hQiT3oY=;
 b=Htot8V/dv1T4Yw2H+9ymDLJtCywXmb10BgVEJnIKAgBIBb53/1Ka5g1itAMlwdGX7k
 F/aSGIAwQkAeC63j4Vca58MRV941FXj5XQw4aOcpqiNSIL0g5WcQliMHyAvPfZLaiJXI
 MC+4gfAco3zo73LhZ+QMPPdvXpPLiEkOfiCRKcDRFduOkeedOqCBIjSujn3YUqdXWYQ0
 tKnJZiHNf44c5PeFK1MI6UWnh03XB+ElLXvteb5I4GTF7+UO+T2BNdkALkJat88c1rdp
 x4MeuLt0uHxvYjaKKKl3d/nImNizEMvqSSYiQ5F6Sfi/gh2h9ducI+vp7jb24uR/j4oZ
 BfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722316; x=1719327116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxgvLOx7YJKBqNY7kF1pTfUqHbVy758/LU10hQiT3oY=;
 b=aT+8Y2POEPML1+4gWu1CnnZ3M344OQkitjLPuyUeP/xfAysMIX9f/3a7d3LlY+ZG3b
 AGluGJOtMkrvoB6pt3nFejtwZ583+eVhlpWT1FBRc5I8TYgirtNPl5YLMhF0WBIOS936
 g0/JKl/lorlF/6Hi+Uwxuc5pKxCiplo+1N4qsXD+sX0CHkZyYnjo0iOiphIQq0VN294+
 mzCv/Hlm60vF5fu1zhGM0ZZVvvGwnjDheCPUQ5vRB3sCt5DHHYAucFsECyL9TTbjWr67
 u4dEtpskdcecNV/lfoo/4ueUAoULPk7plBOsAVJoJ50OW1kkATNneB/RUmP8j+r/PHlK
 dn+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcrH6z1sJ76oUGIWDTD60Ya4Ad9nhJ+mvO46bB+g04BV1r2zFYzN0dSOnUlSZcKhOjq0O28mFECGNwP6E8iyF4CU1tot4=
X-Gm-Message-State: AOJu0YzR073dqDr7pzDkMHQF0fdxtBY+TZkKW3xViykzWJE4Dv1ostRm
 WzVLgF82MKzqGYVZA7+l9IIv+SfZMuVPIJaCFKyFnLVj8FyG+9BgRdcTLwwZXtk=
X-Google-Smtp-Source: AGHT+IHK6aYESWc5GfKxqFUvjipmL6m4/rykMxavHF/7S8dRQDnfd+vvhBGHii61L79tNp8iQ91IGw==
X-Received: by 2002:a05:600c:2d8c:b0:422:140:f440 with SMTP id
 5b1f17b1804b1-4230484adc9mr103961615e9.36.1718722315768; 
 Tue, 18 Jun 2024 07:51:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33c2dsm191327735e9.10.2024.06.18.07.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 07:51:55 -0700 (PDT)
Message-ID: <47a6e9d2-27f6-4e45-9de3-c4766bdf2566@linaro.org>
Date: Tue, 18 Jun 2024 16:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20240618144009.3137806-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618144009.3137806-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 18/6/24 16:40, Zheyu Ma wrote:
> This commit updates the a9_gtimer_get_current_cpu() function to handle
> cases where QTest is enabled. When QTest is used, it returns 0 instead
> of dereferencing the current_cpu, which can be NULL. This prevents the
> program from crashing during QTest runs.
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine npcm750-evb -qtest stdio
> writel 0xf03fe20c 0x26d7468c
> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/timer/a9gtimer.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
> index a2ac5bdfb9..64d80cdf6a 100644
> --- a/hw/timer/a9gtimer.c
> +++ b/hw/timer/a9gtimer.c
> @@ -32,6 +32,7 @@
>   #include "qemu/log.h"
>   #include "qemu/module.h"
>   #include "hw/core/cpu.h"
> +#include "sysemu/qtest.h"
>   
>   #ifndef A9_GTIMER_ERR_DEBUG
>   #define A9_GTIMER_ERR_DEBUG 0
> @@ -48,6 +49,10 @@
>   
>   static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
>   {
> +    if (qtest_enabled()) {
> +        return 0;

Indeed this is how we fixed hw/intc/arm_gic in commit 09bbdb89bc,
so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    }
> +
>       if (current_cpu->cpu_index >= s->num_cpu) {

That said, such accesses of @current_cpu from hw/ are dubious.

>           hw_error("a9gtimer: num-cpu %d but this cpu is %d!\n",
>                    s->num_cpu, current_cpu->cpu_index);


