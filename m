Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B55AC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 03:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSTB-0003VJ-La; Tue, 23 Jul 2024 23:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWST9-0003UY-5d
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:15:11 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWST3-0007As-64
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:15:10 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-396db51d140so25979475ab.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 20:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721790903; x=1722395703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dltiC3OUiAjOYgzf0qYPrSt+GBhiKyY416unGLV2rVc=;
 b=i3X3Q/Lt8Y/wtFbz8ucCvyKYZjqIb9lyvMClIsY38xr2dSQ0zYEF52mT7meE7EYNCp
 kbq1SXF9G3FSJDPUz0RKhK/IsbLR+K+j9CsSfpyV/ztDxnYzEjD5heX+wLM+4OnFP2Hi
 8yyDq85DwYnWirGX265n8I36uMLG+K+2QX+ji/jJcI/GvcPew8DfAcROEAjOEiYB8Jwe
 tvOf1S31fbX1NSjhxFYtIf/kAi/lbhD4HtQQR/MX27VEow/ujyJsvphFmzHOBGdyuE4q
 Toh6ezRmkL+0BFmIsevrADbhQ0or1BWC4X1eYyAiVhPu7TCkbkkNmQjO36wxzA0jCPEZ
 Tk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721790903; x=1722395703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dltiC3OUiAjOYgzf0qYPrSt+GBhiKyY416unGLV2rVc=;
 b=tlgro5Zh1KEznN7xwa29Yf2I8OmxLa6/EuMgddFeqoSUGgF8Z58erNTdKnw/A1IpfE
 xmOJIwUeSYxqG0qOulU4tPHx7VYWXKm6XJ8u4j88ilOWYqanLsN63/NjbSgTkRv8noHB
 SpdR8SvGc13R1gbyulR+TqNpKOIAjkGib+gNr5MX5tXMxWGvRfAN2NBIqmErFDk0A9dY
 yYo0f0b3QY1wwBmgdv4eoz7Nm0xrm9WZoG8/LQd4qrYSbWcPdVCmkQjIb8T8CUu0dFhZ
 fBKf4Di1/Wfb2MH8JlndyCrxLwQA1jHlEDbeCHfDLRV9GEVhEP0W3ATdolTRghkU9Px/
 7uFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQGphpwB9RP4xf5+mc/z/8UranYVeZECG5DyLwmCjhKnk0scKTwIohvWsOCkysNPw503GtiEWIX3Brsybp63YhMCC8QAE=
X-Gm-Message-State: AOJu0YyT03uBbTO0698ealLLfV2z9GWqdamu2FPYfQ7fxH/KLQWe93UA
 aWY4fA8RWfvqLopVSGyy8qZaZupAU/DMGoFZFRmFrnM/6M7XbKnNP42QFV63Y2s=
X-Google-Smtp-Source: AGHT+IFughL6qsJBoK7Uc6hmvlRUgq0hiD7tjTfy3xJ+T634h4oujXDyDns8hhdnF92VN5fJlZIS1w==
X-Received: by 2002:a92:d2cb:0:b0:377:14a7:fc99 with SMTP id
 e9e14a558f8ab-39a16d486c4mr15377635ab.24.1721790902895; 
 Tue, 23 Jul 2024 20:15:02 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d27fa2b30sm4094484b3a.38.2024.07.23.20.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 20:15:02 -0700 (PDT)
Message-ID: <7708addb-1c74-4d9b-acda-a46c5f15509f@linaro.org>
Date: Wed, 24 Jul 2024 13:14:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] Code motion: expose some TCG definitions for page
 table walk consolidation.
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org, berrange@redhat.com
References: <20240723010545.3648706-1-porter@cs.unc.edu>
 <20240723010545.3648706-2-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723010545.3648706-2-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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

On 7/23/24 11:05, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   include/hw/core/sysemu-cpu-ops.h     |  6 +++++
>   target/i386/cpu.h                    |  5 ++--
>   target/i386/helper.c                 | 36 +++++++++++++++++++++++++++
>   target/i386/tcg/helper-tcg.h         | 32 ++++++++++++++++++++++++
>   target/i386/tcg/seg_helper.c         | 36 ---------------------------
>   target/i386/tcg/sysemu/excp_helper.c | 37 +---------------------------
>   6 files changed, 77 insertions(+), 75 deletions(-)
> 
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 24d003fe04..4c94e51267 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -12,6 +12,12 @@
>   
>   #include "hw/core/cpu.h"
>   
> +typedef enum TranslateFaultStage2 {
> +    S2_NONE,
> +    S2_GPA,
> +    S2_GPT,
> +} TranslateFaultStage2;

No, you can't move an x86-specific item like this into common code.
You're doing something wrong in the abstraction.


r~

