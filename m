Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E04C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 00:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvQaq-00048G-8N; Thu, 20 Mar 2025 20:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvQaU-00040i-KJ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:50:16 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvQaS-0007VN-JM
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:50:14 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso1877831a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 17:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742518211; x=1743123011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WlpucwqrWLhmkeVrq5z9j4pA1n+K9Rp52DNyUDkh7kg=;
 b=kiy/JfJj4g6cVTExj12VecGIq+/e47LqvY/CWX1X3xrxS/MFaMEGHBx4ZNlTaNeYD2
 +JGSWr26wlM7KVAT2yClIj4bnDoIC9XNoJMv51dRDZl3XGIxqhEbbkKvjZ5AKwtLZJvZ
 4TLgSV1Ql/r86hRWjtU20h7BXMUkq/mvLJR5HOZ7bsPpqOuplDl5jjC8JKD0nOnRT0w5
 p8qL+b7z64ypp0FtASbMVd4aFMayd4JxbnT1qWlI0AIeAE7r2RrZt/H9PJg6tiLGSCOY
 5FmUgLHzYao4pxB9lX9gIFmpyXKcxOTfbzDAjbtz5ctVD7JiZV952WExW/eYj5TMEvvp
 ccdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742518211; x=1743123011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WlpucwqrWLhmkeVrq5z9j4pA1n+K9Rp52DNyUDkh7kg=;
 b=QGFV+cLNbNOsoVJROk53MFpvJBBOrDYUlqG6C9FxXkJP4GOe1qFQ5eVgRRGy+Qa5Zx
 aCoaiqQ32VO7lkXtzNqqxSrHYD1Dvxoi+3wtGruRPJJfRZaaS9kPwCoHbhcpqiAsMsAH
 a5pvuvTHmfdMHoNAHQu0AAkIXadmwaMbR+k1mJr8efZA9/7rYCCQQfZM+3qR/9fXvuqn
 qm0ScPV2aiYw04kfNLARpaYXiFhDmIRpytVBEAIGJsS0189Tzel4WfSSAEkqjfgZR5V1
 u53AgKPx3qaAoWcLMNPzeLY1995ukT6490Q7vNtBpWAmX5lDI9VGLKtTGvnX6U+DURSy
 y+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR2Nv6N5UuFW22FBXdll9k+JaLRlIMU4NqLDhPQRs1FeOsG8dDfksBr2ZlphQlAULqczNOp/fGNF+S@nongnu.org
X-Gm-Message-State: AOJu0YwMsYnsroGkNWmi68h8JfIu+M8rE7/US9jQ+KDLJ651ou7Vk/6C
 zJ0DGs9YV5qlxUKCCDuXOwKubyalu/iozH/qkxQ5vGQ5nsKaETfD1u/uX7dXs4E=
X-Gm-Gg: ASbGncspMY1B3Czqvi/JoE2svEt579lZ6Lqb/2jJ4YkPN64NAqR5eb3Zt4727DLdlAM
 cGXvXX03zwihdWnyhV3WfgAGFzfqod7p3KzK1TbcI4e/ceYcx/xIy0Qk82wfAW7gsPDkRnYTubc
 lSu9w4pvrOdB7x6etoJRDs7M6ad0BnevI5QYQQ3JLjHNCZJt9nHkF5rJluDs/pGyIXcl0voTvlh
 TmTdqKeypOjm2IAe2J2286JX/qvbE8Dp/Kt+PhNGkNPOR7wvgKICKScY8o9Zkn35NMjj3Vh9zJ9
 Xe/7cerRZ4CzxopBazx9jpHgB7TrqyOdFODYbd5jcwJNjq0/js8sGzZ8a5WzZlpL/MNB+F0p0Fd
 Ri2g4yveB
X-Google-Smtp-Source: AGHT+IHDcaFbTBT2zgwH36BimJVgUxz4fIKVLX6wM6NL/cr4XXsZikSbRGijqrReIgIwaYUZccWraw==
X-Received: by 2002:a17:90b:582d:b0:2ff:7cb8:6eca with SMTP id
 98e67ed59e1d1-3030fef41e2mr2087310a91.24.1742518210765; 
 Thu, 20 Mar 2025 17:50:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf576c65sm4656680a91.10.2025.03.20.17.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 17:50:10 -0700 (PDT)
Message-ID: <9a94450f-15b8-49d1-bb41-a298dd22473b@linaro.org>
Date: Thu, 20 Mar 2025 17:50:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/42] semihosting: Move user-only implementation
 out-of-line
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-27-richard.henderson@linaro.org>
 <e788d7b9-d115-4252-aa91-187c4df096cc@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e788d7b9-d115-4252-aa91-187c4df096cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 3/19/25 00:16, Philippe Mathieu-Daudé wrote:
> On 18/3/25 22:31, Richard Henderson wrote:
>> Avoid testing CONFIG_USER_ONLY in semihost.h.
>> The only function that's required is semihosting_enabled.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/semihosting/semihost.h | 29 ++---------------------------
>>   semihosting/user.c             | 15 +++++++++++++++
>>   semihosting/meson.build        |  2 ++
>>   3 files changed, 19 insertions(+), 27 deletions(-)
>>   create mode 100644 semihosting/user.c
> 
> 
>> diff --git a/semihosting/user.c b/semihosting/user.c
>> new file mode 100644
>> index 0000000000..9473729beb
>> --- /dev/null
>> +++ b/semihosting/user.c
>> @@ -0,0 +1,15 @@
>> +/*
>> + * Semihosting for user emulation
>> + *
>> + * Copyright (c) 2019 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "semihosting/semihost.h"
>> +
>> +bool semihosting_enabled(bool is_user)
>> +{
> 
> While moving this code, we could also add:
> 
>         assert(is_user);

I have added this as a separate patch.


r~

