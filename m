Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43363C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 00:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIFw1-0005ib-Io; Thu, 22 May 2025 20:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uIFvy-0005iF-1s
 for qemu-devel@nongnu.org; Thu, 22 May 2025 20:06:47 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uIFvs-00020p-8S
 for qemu-devel@nongnu.org; Thu, 22 May 2025 20:06:45 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5259327a93bso2738596e0c.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747958798; x=1748563598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2zz/8/7tVZgigVNSQ08sp7XbyvwaMr2RCxggftn1uA=;
 b=r8PhJKjO0jkrlc4XKxMKXFG7GcqbbIORt+NjSIZVqL2DL6DLq4Mo2z110SSN1Z2Vwt
 d2nRDjbN1FDm6j5DPH+d1bnlQRgqfXA+XddDLQg5I8Y1ZZwaQcylYBwTqYcLB13fm3nn
 a6hXqz3t7Nuoy8usS8ZXD9x6fbekPgGz4cFOWiGcvkb1dkB86A3X3QSt8ybOVT/qJAGs
 3af/JM4AlvsoIrAUNLgFAAJJG/ei7swywsloeKjYjyMJiq9UeegVbuJn/0yr+MYJ1qAr
 SXzcMKeBzigy/7cbIXmPcO2tjB2GsPt+/f9jk/xCsrL71XaEKiJzP6TwV3mq15NcKZHz
 Y2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747958798; x=1748563598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2zz/8/7tVZgigVNSQ08sp7XbyvwaMr2RCxggftn1uA=;
 b=iQCnqcwhracZ9aYm2hdw4ud6AP2E0PCoT2QVd6U1V3hcsnoIq98v6nGA69Phq6iMZH
 ZqTatvU2zGWHLYNeijH1rn8qbFRqLwbhSgx8WjpPSrobpikT4+8seiOcfI+J3JDagDGo
 gCBNpzQ2UAK1jqdzaB1BH/DQ4yVG4NPj9AJZrszFSDnxUTf5w6j6Wc12r/u5TnVBeHUB
 JKOMHtzXyNmjqWiQ9+kxzkAd6Qqpun6lzF59Y5BDVnd/VPDV6YyF2ltmsXcCO81GJLHw
 TY6rEsMrrXkmy8XGKjkkPK3jRyt3cFncZHe5m7YScAg+j2a9Fth6MF2eJ+shL+sqHwm2
 z5pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvUoJIQ6pK4CQ2CnaNIbNCDslCi++tLLe6x+qJj/1SDM2gGfqRq3M77AnG5bMWVQEwgK/7huIQ+YMm@nongnu.org
X-Gm-Message-State: AOJu0Yz9n+0ZXxNTJBykH9Ldh2CZQS3qik7gydc1S6pcU2/20grzf0Yw
 FXM0eGUcM11cGkBhBN5Se5XlR4qaevbGNyBFc23wz4EF87lfTDqAiYEss2GNjhshGuE=
X-Gm-Gg: ASbGncsjrwRsKjw68uHCxnXV5Wzfh0NBd3IWosJULVDhF3slimAIr+F8oBVd0ESEulo
 YHr6ztULxKrUiFrFA53vt5USDy57m9ntjMx+z+RaIp5s5zwEgcdWQ3CPpxhuS2eRiudEnMPYbaE
 9FZ4UTS72kugQoIPLcqOQHjzrEFNu0x4vtDCFathsfaHZwkljSb7j7sKBEYxwm1faeLfYZIxhvf
 xrOS8kgUWdd34mNNr9COPXLKjzRzYv89C9xdnSafE6exMlnsoBOxJMMtgNdig2w6MwJqxaz7gSQ
 OE406nY7KsrNtnhTMqHhcXMn0unTwc/Pat89N7lMiaJaPjAv3QBYHd+GJKDqhna2Na8Yv8s6+Lg
 ccXjxaZQQiqJiFWN/mCEhh4gNslRQ5A==
X-Google-Smtp-Source: AGHT+IEuZbJXx5LHF7iXES5roCJQKIJXSsk60o+wXFm2yywDwNnF1pvcLabAIh8jIc80wPcRv1eCzg==
X-Received: by 2002:a05:6122:d9e:b0:526:720:704 with SMTP id
 71dfb90a1353d-52f1fe2ea7bmr976090e0c.7.1747958798003; 
 Thu, 22 May 2025 17:06:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:59c4:f305:3d77:f678?
 ([2804:7f0:b402:6ba2:59c4:f305:3d77:f678])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4dfa682e3c5sm11846118137.19.2025.05.22.17.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 17:06:37 -0700 (PDT)
Message-ID: <dd52d28f-dde9-4506-a850-dd1222a4c903@linaro.org>
Date: Thu, 22 May 2025 21:06:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Ignore SCTLR_EL2.EnSCXT when !ELIsInHost()
To: Oliver Upton <oliver.upton@linux.dev>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250521190228.3921172-1-oliver.upton@linux.dev>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250521190228.3921172-1-oliver.upton@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa32.google.com
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

Hi Oliver,

Thanks for patch.

On 5/21/25 16:02, Oliver Upton wrote:
> Using an EL2 that enables SCXTNUM_ELx for guests while disabling the
> feature for the host generates erroneous traps to EL2 when running under
> TCG.
> 
> Fix the issue by only evaluating SCTLR_EL2.EnSCXT when ELIsInHost().
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   target/arm/helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7631210287..83d4236417 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7389,16 +7389,16 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
>   {
>       uint64_t hcr = arm_hcr_el2_eff(env);
>       int el = arm_current_el(env);
> +    uint64_t sctlr;
>   
> -    if (el == 0 && !((hcr & HCR_E2H) && (hcr & HCR_TGE))) {
> -        if (env->cp15.sctlr_el[1] & SCTLR_TSCXT) {
> -            if (hcr & HCR_TGE) {
> -                return CP_ACCESS_TRAP_EL2;
> -            }
> -            return CP_ACCESS_TRAP_EL1;
> +    sctlr = el_is_in_host(env, el) ? env->cp15.sctlr_el[2] :
> +            env->cp15.sctlr_el[1];
> +
> +    if (el == 0 && (sctlr & SCTLR_TSCXT)) {
> +        if (hcr & HCR_TGE) {
> +            return CP_ACCESS_TRAP_EL2;
>           }
> -    } else if (el < 2 && (env->cp15.sctlr_el[2] & SCTLR_TSCXT)) {
> -        return CP_ACCESS_TRAP_EL2;
> +        return CP_ACCESS_TRAP_EL1;
>       }
>       if (el < 2 && arm_is_el2_enabled(env) && !(hcr & HCR_ENSCXT)) {
>           return CP_ACCESS_TRAP_EL2;

Do you mind providing a bit more of context when these erroneous traps happen?

Do we have an issue in QEMU's gitlab about it? What are the QEMU options for a
VM where this issue can be reproduced and, is there an easy way we can reproduce it?


Thanks,
Gustavo

