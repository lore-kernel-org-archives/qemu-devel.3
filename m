Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F6C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcY8-0000Kd-Ou; Fri, 23 Feb 2024 15:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbpa-0005bd-62
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:07:38 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbpV-0003wi-El
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:07:37 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29a64997159so984440a91.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708718852; x=1709323652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1XC3vl+LDj8wZs8FVuIheeyyKpaBBm/H85XNB+6cwM=;
 b=GJnbHMuxFbg/yPBCjx31GEstlZLHeHcbw1Hv0M3AHzVq9dre2WkTac65ZZRORchuFF
 y3Zm/sebMFCoGGYIlVw0niZB98//G6uELmZeq2QUEBEAQ+9QZOvwEaHsHADyyxniZZdK
 HHJ3tkZu5Rt5B+X2FfPflXoENrpFnNCtikgr895mcU1eoTK9Jb4w6LKX3zMeU8/infER
 pTXO5ZEm0WdlIuTYThJn7QczRVCGM7GYI3DAcjRolamMCj4a6t9OmLgZhtUA9SLfCuDJ
 mJVwMbD+7nQrXGGoEk7AmMghkedgKtZtZxqzLWIYMvYpaFmWweRUaKenNGRQbEgHcV2p
 Zxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708718852; x=1709323652;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1XC3vl+LDj8wZs8FVuIheeyyKpaBBm/H85XNB+6cwM=;
 b=ZUg7GN1pbg3NzpHj5Hl7IpjYXaGc7SK8GOpbpPpomGEOUuMHAx1CJVPZXulUACWBsQ
 CYWd2a+RVPpXz8K5UaG1i7MDabOLxlA1HdHmlKmK5KUbVzBvTc4iRcuDBhNg8yI0x1bM
 rD6wG303BTwboz0rM7RrAMI6HQQY7r2bAMdY2A9DmK7qoeNJRvs9Dt388RSJxDMNQgrP
 D8R+eGK/78zLUeyPgoUCup6t8WpsUHXhS2/6umE4+JvyhJ/X3iJPRrBgfHfonyNnOO9r
 vm38jk6+d4fgIL/n6sG45QTXN5L5Q5Idy+k2LhrEkiySw2mlaeAVbhyE3nlpiFicG/d3
 rsPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbUuw4kSxIQeqIeuVY8foMlgfWQDG7W6zvPbMg+HxC+lxJgBp1DJckoAkb9wZQ1GJ64uFflCRp3JiD3FA4u0mTcofHIE4=
X-Gm-Message-State: AOJu0YxG/uWv4Y0XR8Htx2DiEP02DQjnbZOTqTIpDmT8xSIyV2jrG9UZ
 eSD6UdtGZ1x9ee4Jdu6JmrwcuTr6z08SKCY3kK/uawewUx1ytlItlLihEVWMdM4=
X-Google-Smtp-Source: AGHT+IFVnDP7u1eXSkdSAHIyhXyGKLgCBwC4Mcr0ZqWl9MzEqp6up9vFJERmDn+vHNkHsUSD0T2uEg==
X-Received: by 2002:a17:90a:4683:b0:29a:4b13:786f with SMTP id
 z3-20020a17090a468300b0029a4b13786fmr912374pjf.36.1708718851936; 
 Fri, 23 Feb 2024 12:07:31 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lj10-20020a17090b344a00b00298ca46547fsm1885987pjb.36.2024.02.23.12.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 12:07:31 -0800 (PST)
Message-ID: <71f6caef-b9d8-41f7-ae09-def488d6d5c6@linaro.org>
Date: Fri, 23 Feb 2024 10:07:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/21] hw/intc/arm_gicv3: Add external IRQ lines
 for NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-12-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> Augment the GICv3's QOM device interface by adding one
> new set of sysbus IRQ line, to signal NMI to each CPU.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v3:
> - Add support for VNMI.
> ---
>   hw/intc/arm_gicv3_common.c         | 6 ++++++
>   include/hw/intc/arm_gic_common.h   | 2 ++
>   include/hw/intc/arm_gicv3_common.h | 2 ++
>   3 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

