Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57348C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 16:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt82M-0003US-Bf; Fri, 14 Mar 2025 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tt82L-0003UF-0V
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:37:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tt82J-0001BF-9y
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:37:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223a7065ff8so64370695ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741970244; x=1742575044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d66fnYWtIlocNzPnt9W8FJ0gwEYCu1jy520RKLdewqY=;
 b=aWcv/M6ziBxRNR4bhIjzSZKhSj6bwe2tHfoSDBxvRfZiwS6RhEZ/mSY8bzvwrlKtWz
 OGrx0w2tbeR0CAmaaV1bpd7OO4JwicLHRafv/KfxOGBRzcQKLgQvmNICZGN60BTnGpS/
 5MyhaTjpDy5zE6vmCIWduH9i1Xf06M7LKGmYL6jYmelS3HTFKdBIjb687BN8zuSP7oJi
 Zz/KwqGwnwfJon9S+gcQMOt3BdsgVkihBCH905F8GRsyCaSmNJ2cDee14FqTKP+2jXpj
 jkknV/zBBxkSabIsX4RMdnsap9M48MSd4Gfx4TK/eydOBrRDQt3AUbc4ROXv3JJLuyxt
 weNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741970244; x=1742575044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d66fnYWtIlocNzPnt9W8FJ0gwEYCu1jy520RKLdewqY=;
 b=r1NKWH/7W4MiO+77XLJ8mhNpdDxSFhR+m0eJJmoaOdC7iPWY3yyxPCfaujxYxKRF66
 DAh+k0Uj+kL0C2kamdW4zozZ13VF67IEYU3V0tH2x64BMmYJPGqUByVkhbOSW8MN+m8T
 W0vfgzjUOZpMYeaqGH8I3WQFnY3WLqqFRUt4qEpqvWIBiKDKukj0qy+hIGiPbYOrtmDV
 N2D/EBBxw1TCnFL/N8dLd7mw9x8AIM+csew48J21c3lzwAW+Ilpp9MmkKzFRrzApiZju
 hsDa+gG2o8o/VZy/k8/yoFOqMlutez2vCek6qR5oZNndvEYPdqskGA2I9g9HXEargVQA
 GG7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjE3GpW2saVKnAEQJdIs9okWRqSgZLOFGgujKUB4mN0OzsmPDi5asdwZaR1BEEhd3mSVNdUMN3+FvL@nongnu.org
X-Gm-Message-State: AOJu0YxeWGF+3LBdLmNuM4AWgpgAF2g5JF4BDoVDYQ0vlsThRCnWUi0w
 xR1tiRH9nFPBRjlhL/gZe/VL5jS5AaOvc9JSut2TOfeJg+eon7d1VNmyytOahZw=
X-Gm-Gg: ASbGncs9MTxH+//zbhBNRlE7JY49e+lIOUiMIoCMJkV0LGuMSBRhmw7BBcAYJW6mTzZ
 MBdPVIHg9H7CeJltNJjMpcLQPe73QQK8O15dKktirAsdDzYRWHjeWSHF59CB3pinguJ/5XDPQek
 5isNH6lNQUzT37yCwnjZmLt8xssO5V7MtZ4SxrBssqzMsKLHdTOUyLsZPu/1hqyvyHufDzX4X6W
 Ka3xt/I901SByUyN8UktrdSrbw5of8GKkQ/W+3nayF1/+0deQHKv3krg26FQfdf73AV4wrGrQMh
 Z3mHHqkdOuwiPTW16pxabgqBBtEKVOISw0dA50gzFNFCduWrH9/p4ASeVeHSKCFYVTE7r0cGPjJ
 nlnj2hx+2
X-Google-Smtp-Source: AGHT+IGs1RoqVtgGdML3JflkrSI5WW7kA9f/aIY5RhO/hzcdvqitfx3VeNERyRMKsFmhCPdQSkatxA==
X-Received: by 2002:a17:902:e784:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-225e0b48377mr40764525ad.43.1741970243575; 
 Fri, 14 Mar 2025 09:37:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7bd0csm2915876a12.47.2025.03.14.09.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 09:37:23 -0700 (PDT)
Message-ID: <27446562-38b0-46a1-8975-1c4ce24cf4c3@linaro.org>
Date: Fri, 14 Mar 2025 09:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] common-user: Split out watchpoint-stub.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-26-richard.henderson@linaro.org>
 <36f7e651-4df6-457d-a7ef-df7a7c4b2570@linaro.org>
 <00d707e4-5e60-43fc-b372-72336d7af293@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <00d707e4-5e60-43fc-b372-72336d7af293@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/13/25 03:39, Philippe Mathieu-Daudé wrote:
>>> --- /dev/null
>>> +++ b/common-user/watchpoint-stub.c
>>> @@ -0,0 +1,28 @@
>>> +/*
>>> + * CPU watchpoint stubs
>>> + *
>>> + * Copyright (c) 2003 Fabrice Bellard
>>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/core/cpu.h"
>>> +
>>> +int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>>> +                          int flags, CPUWatchpoint **watchpoint)
>>> +{
>>> +    return -ENOSYS;
>>> +}
>>> +
>>> +int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len, int flags)
>>> +{
>>> +    return -ENOSYS;
>>> +}
>>> +
>>> +void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
>>> +{
>>
>> Again, can this be elide? Otherwise better use g_assert_not_reached().
> 
> We can, including:
> 
> -- >8 --
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index dba1b3ffef..54d3879c56 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7545,4 +7545,6 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>       env->dr[7] = DR7_FIXED_1;
> +#ifndef CONFIG_USER_ONLY
>       cpu_breakpoint_remove_all(cs, BP_CPU);
>       cpu_watchpoint_remove_all(cs, BP_CPU);
> +#endif

But do we really want to add all those ifdefs?


r~

