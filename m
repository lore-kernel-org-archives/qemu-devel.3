Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D560C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVNr-0004El-Ku; Fri, 08 Mar 2024 03:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVNn-00046E-UX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:15:13 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVNk-0006Vx-Kg
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:15:11 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d29111272eso25559201fa.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709885706; x=1710490506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYEjACDvaJVMBxWhkiNT7nooHtpHgZTsBxUBkP0wlRo=;
 b=qeB96ySqP9YVSdpDo9F1fDl9cceTNNaKgANTvl5/fO1S+k8RSrxuT+8rRZ4smXUcUO
 cnb8CWqHXmXkIBiERzdXW2MjNiEuFpyykawGaWK/gK4zVgnt3qErXfzqpPbIu7GwFmu8
 MZMH7/KX3i7zhq3wDyyumEDimqLq5rCeFVSMwxcQ2f33ewsP4vjL2/4KlUfLuRXcte57
 ZQhqq5h4Y+mV6/wRMRXNHQNxXfp5/3oln587R998cN68O33qnknMtEOfjoJtGvggm/q5
 d4OvHxzi3Ck0VbBIxxi5rNKFOPhHA4GN9IPncb5GJA7NHgsq4RlyGYrKcThUc99WH4n4
 df6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885706; x=1710490506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYEjACDvaJVMBxWhkiNT7nooHtpHgZTsBxUBkP0wlRo=;
 b=HJNkbwKaWYokzzIo5bSJoSjhjSA/0T55j5TQ9loSZHyC00tHf2fASH0zSL/RM2uNCs
 HeVx6/kFIV+JoYpBx5+CryglQei3M5TEj5QIgwlGZVzJ/l1NZobWvI7I9W2L1h9FRQU6
 TMDwMgUYRmgG+3WP17HbrhrVCFY6vGW4IyT5KppRdATsCF45uX+70OSC2zfxtiuebmOc
 VytqHz4J1TC8YOH3R0p+nE9UdvXTzHug0arKh7/av/sD95yjYokfietDJLsBkw4Ck/ex
 44ua8BLDtVu8siLLpYlx7krJp8or9el3qIacKiCLeUS70xQfr0NIJ2Q7wTRY0asVgiJI
 J5mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbA7z9MQyyvVNdO0yvwOBrJifXjtAKLeb4vgbSyZ339GEBsOYdIosNDVN4ByRHzswal4BLGvZZd8i+JNMXkV4HRARtEVw=
X-Gm-Message-State: AOJu0YxxguK0YMk2DayER7hX7kEiXzkni+W9A94OdY7Y9JV0dDGI9y/6
 TuPhmOs7/QYIlFf3UvvX0nHBHaH/9jSc3VCNh8y3YH6j3AuFkbIh0hzQ/NgK6QQ=
X-Google-Smtp-Source: AGHT+IHfITfmmyagLbmwGXQOQUIMFyK+RNC0MZHyr9gk1cBP7vFcNKohAEwYjZoHgoFYUm9VG0qx0g==
X-Received: by 2002:a05:651c:2120:b0:2d3:827f:5db8 with SMTP id
 a32-20020a05651c212000b002d3827f5db8mr3433007ljq.8.1709885706230; 
 Fri, 08 Mar 2024 00:15:06 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 z11-20020a05600c0a0b00b00412f428aedasm5163173wmp.46.2024.03.08.00.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:15:05 -0800 (PST)
Message-ID: <48f316f0-f16a-43b6-af81-215fa5a127b6@linaro.org>
Date: Fri, 8 Mar 2024 09:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/apic: fix memory leak
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: minhquangbui99@gmail.com
References: <20240304224133.267640-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240304224133.267640-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 4/3/24 23:41, Paolo Bonzini wrote:
> deliver_bitmask is allocated on the heap in apic_deliver(), but there
> are many paths in the function that return before the corresponding
> g_free() is reached.  Fix this by switching to g_autofree and, while at
> it, also switch to g_new.  Do the same in apic_deliver_irq() as well
> for consistency.
> 
> Fixes: b5ee0468e9d ("apic: add support for x2APIC mode", 2024-02-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/intc/apic.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Thanks, patch queued.

