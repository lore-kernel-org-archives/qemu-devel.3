Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC139C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuJG-0007AJ-HB; Wed, 01 Jul 2026 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1weuJF-0007A8-4X
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:44:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1weuJC-0005YU-E2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:44:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38060005f1cso908608a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782909892; x=1783514692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2NqrJXIRHddtkDH7D79FJR/M5LoDmIZclrzAOMj5n94=;
 b=pXLMwVHEE9awss/j7gP7GmxGQmq5GVi2nYJaT8P7KaYb5bWSTzRXiv4WhSWhhLYOr7
 TvQXF3d0cclCp+xS1mn1O7knTRUsZNaP1TfxpTFV5J6lFGt3ygaIrGwy1vbtxvButTTN
 ZtMTzmcxA8aE8XFMr5zarte0IeOvdI6dMdqq6YAb/u0KwFtXpPJFpjFfZ8yr5ztS6q53
 yDC6ClU5HXfuHBjBn1cKklh9/C/pDxhlNxexHzz+pO8h+Z9FTG6sHg0Jtx8BJyYYDlDZ
 X4EQE2bDYpA+LcoB8X9YZqDWx4s8QybTi2iRFnYxxpww51bdlY7g+vp4z/8QVkVWhnFx
 ooSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782909892; x=1783514692;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2NqrJXIRHddtkDH7D79FJR/M5LoDmIZclrzAOMj5n94=;
 b=Y9N9EEAo4EUiTam5t9wzQ843LRpVy2zbAfdUiAbN0DGKJxjCiT+7KPuJUSCe/msePt
 hUrXdPLdekuCc3ksibvCuLKq3T3oRuYZD2CM9Slu3QK6+I6jR/9/zYo8H8tu6hGY5/7R
 2nDWkhSIuGGhBEi1w/+wJZO3nGsi9/BeJG61qR8++VOnM9f6Nfnx/Ytcs5GXst5OL/OS
 wXcVj5SIeX9Dc8m2AYxn7UCH1PuAsn14LDUwXSgnkUra78rMC8hE4Zu10HfNnQJ9cRo6
 7ML2377mEn5oI+0SQGVKdusJ4QyCKgnL/B2RI0Du4hSw7Ix/6++TNfkIJ/jfjJM1EgkH
 RA7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2WeTLii2b+o/ux9RKHZho5Kh1lZkQTinpzLXw+E31z/Ku4rBvTjWIgujqI40PSFrZDg/P4IqnqCoQ@nongnu.org
X-Gm-Message-State: AOJu0Yxl4aQUTBvL132dNVU3gcInVfcEZ7Vl5n2O8Z9Gbi9TzntactSm
 4ypTNG1+bhMg83c19sJUoSWUFBcS/DTLNmeHtRIlncVQYlBnn3sSn8EkKOxdLdOlpSM=
X-Gm-Gg: AfdE7ckpHvxRYUGdkeWywAdyRuuZwHuIt7s8G5WW6wucjjzrRizYCP808ZP+7gWDIvh
 4hzkfx89C89bQAIgsnKyEgaVHYxYYSBXgd45Ihg0SsZOjVZUGQG/D0RXdDIagnWcruNCo/OZVwg
 YFSpsvxNsazDghYBsp+V/mFlCOB0Mi2v/SM1mlX9tatYhUgUK/HUOKTnEKaBx7jNKGW88FobWK0
 4VVYF3hu7ZZqK6bpCOdbMxfBsr242RRzu4iRBUeO1izwr/OA017NaWr10iSEHAUgd2wJ6F5rY1j
 TC64MunYgHGw1ULMT2gwMQADivV7G/IHlC3iG+HWFFkY194gyjQQs4iCFiq8tf+6P3s872iJHSg
 y3EK+2C2hEhgklQaTEk+NpN6R/1OuSK1pmH9wytaeqnvqA0gtWhHI0TSlgg5vsLzTZDVvX679tb
 1Rdjjm7V6W4vfndPEzuTVgAZqFYBcpgD7HSxNkRYewADl8hs1Vtv9FbhuP0qkwyRrszadS
X-Received: by 2002:a17:90b:562c:b0:36b:769c:c037 with SMTP id
 98e67ed59e1d1-380aa0b53afmr1211764a91.5.1782909892341; 
 Wed, 01 Jul 2026 05:44:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095e83b6csm1893033a91.8.2026.07.01.05.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 05:44:51 -0700 (PDT)
Message-ID: <3d06dbe0-9e1d-4862-8d6d-75d0085cd626@linaro.org>
Date: Wed, 1 Jul 2026 05:44:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] exec/breakpoint: Move BP declarations from
 hw/core/cpu.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-5-richard.henderson@linaro.org>
 <bf05f5e5-737d-44ca-8fd5-abd97c6513d4@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <bf05f5e5-737d-44ca-8fd5-abd97c6513d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 23:11, Philippe Mathieu-Daudé wrote:
> On 1/7/26 05:04, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/breakpoint.h | 21 +++++++++++++++++++++
>>   include/hw/core/cpu.h     | 21 ---------------------
>>   2 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
>> index 95f0482e6d..4013d9a07c 100644
>> --- a/include/exec/breakpoint.h
>> +++ b/include/exec/breakpoint.h
>> @@ -12,6 +12,20 @@
>>   #include "exec/vaddr.h"
>>   #include "exec/memattrs.h"
>> +/* Breakpoint/watchpoint flags */
>> +#define BP_MEM_READ           0x01
>> +#define BP_MEM_WRITE          0x02
>> +#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
>> +#define BP_STOP_BEFORE_ACCESS 0x04
>> +/* 0x08 currently unused */
>> +#define BP_GDB                0x10
>> +#define BP_CPU                0x20
>> +#define BP_ANY                (BP_GDB | BP_CPU)
>> +#define BP_HIT_SHIFT          6
>> +#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
>> +#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
>> +#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
> 
> See https://lore.kernel.org/qemu-devel/20260630220100.1289-18-philmd@oss.qualcomm.com/ ;)

I noticed your series just after I posted mine.  :-)
I'll have a look through and probably rebase on yours.


r~

