Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B1EC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcsvh-0007bI-W6; Wed, 21 Feb 2024 15:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcsvS-0007X4-4G
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:10:47 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcsvP-0005oM-KP
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:10:41 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29a32815452so474868a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708546238; x=1709151038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oJxETZhAAwqHJ/cWk/f8wkdlcV+eZ+HAWxywPdOBY2E=;
 b=tnadip3ZB91kp+rt3qIkRklJoQyiJRnDjQqAMz489TvWevtfrBOfknf1YyKRysp/+p
 fmeCoyCCSVtVsspUMvht875MUMOtNjm5ap50FOXGdcks1t48p/CZQ+fInyZ08okVRJH9
 Dq2hSbYwTRqtppTyFIm3qadNxxsl3Qqg7iKLybuN8Tps+yENJHSRnszJXQutVxCwDyAm
 0e3QlM8rpjcDnSt03cqPdNACvup0PWkzXBcwE6RvLTKr6wGJkcpJd1YEr1eAtYcbKCe1
 XuuiDxI41d7mFvCptj8xotIgNZxrHR5dTJd7DvLXwhlhldDcBBx/mY/0K5QSZjsfSrHY
 qbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708546238; x=1709151038;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oJxETZhAAwqHJ/cWk/f8wkdlcV+eZ+HAWxywPdOBY2E=;
 b=L7Ee/wdwLkCly3mI8aHEDX5XTJ6vCslk1789p4JjwwNuKq1IAmWNwAiXlc7Zm08QJp
 HCmnpeCKa8+unxEeMqLmeUHS7pLLLTu796xXWOrZbXV+TTu2itxygdgrZHmXUVtO6Su6
 7IwRQF5hRtMy9NSw20ichtvzZw01EWqSgp7ImheCuRGD4K2Tj3PyRjkgfVUJUIl4yNPR
 qqCp0QCIdjuMEC9Vhud5/bvy0KCQEN+s6SRc5ZiS90EoK4lg7QweiYEP5CR8wPpIH9PO
 PB05JpTWOIquBVVL5jQqsPervfD7za+JHOOuT+nP5N8LquYNLL1vOvoexHtiFKU1jLGT
 FGQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrSv9C9nPDNy/DeYEUO7vl0oEd2Ep+cSJikXXp2otkDtvMQJ75raoZj8pwqwvaFbNjEh4CXfLXw2yPFSUngOXJ/e5AQaU=
X-Gm-Message-State: AOJu0YziSBmlZ+oG/6tcoeg76uWjtZvIfez4JYMcdeAt3DBDPi7J/6p+
 /s2y3nU16Tc10EvqcA2zZrh7PlasM+czibCWWuOAHkTuaUlw+owtyxCOAtidwwo=
X-Google-Smtp-Source: AGHT+IEjqoTIag/B4DIaG1ylNf3d3E9Axq9QboF+QMYYYmXfrpgoeTapX0CEnYPgIIsXhJrItiDTCg==
X-Received: by 2002:a17:90b:1017:b0:299:3236:734 with SMTP id
 gm23-20020a17090b101700b0029932360734mr15561639pjb.42.1708546237824; 
 Wed, 21 Feb 2024 12:10:37 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 e18-20020a170902f1d200b001dbcf96004fsm7857273plc.148.2024.02.21.12.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:10:37 -0800 (PST)
Message-ID: <c02228ea-4f24-46f9-b6b3-34cba3059d69@linaro.org>
Date: Wed, 21 Feb 2024 10:10:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/22] target/arm: Add support for NMI event state
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-8-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> The NMI exception state include whether the interrupt with super priority
> is IRQ or FIQ, so add a nmi_is_irq flag in CPUARMState to distinguish it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/cpu.h    | 2 ++
>   target/arm/helper.c | 9 +++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5257343bcb..051e589e19 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -603,6 +603,8 @@ typedef struct CPUArchState {
>       /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
>       uint32_t irq_line_state;
>   
> +    bool nmi_is_irq;

Why would you need to add this to CPUARMState?
This has the appearance of requiring only a local variable.
But it is hard to tell since you do not set it within this patch at all.


r~

