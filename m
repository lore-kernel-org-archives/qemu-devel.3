Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AACCCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgt4-0002d9-O6; Thu, 28 May 2026 15:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgt2-0002cg-S5
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:59:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgt1-0003KU-0B
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:59:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so604117f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998361; x=1780603161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35ZIK+RqQMFZhBbuaSVeKgHe7hxSXLxyc9A4qk60P4k=;
 b=aiKUPuFNT9MP/7UoQVq2v7/cvSENTDhwRN1DF4F2CoMeJEVb2sSGvyvXyKbF06AnU6
 1gkWYXTN7Uvg1a9l0ddUeVHt0Xezm61GwUbVlSZerzjquAghN8gn14AnJpPJ76YQfJ+3
 YmwowqVApmfXPaOi3+CMx7fu6WUyMVwgEjXoTujbhvLm/pZi79K/WcYJyfFf9nqGlbeK
 Z7GoecLBULkFpQ1JEzJlxEZHMpLDyA1K5pSuWGIW9aUM10wRZHWcvuYqtRuWLsdlskmr
 yw9eMQOeAg3W9ejl6SrdcdMd3+sl3kY5GCJ8GOfHxS61idMx2bSVQqn41ZjbRRbnr0Du
 tHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998361; x=1780603161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35ZIK+RqQMFZhBbuaSVeKgHe7hxSXLxyc9A4qk60P4k=;
 b=dlm+gCA//801EygiUx4/6Vpo7IJ/EuOh8AB9GqPUbpSiTsSgfEuKMINwty6zRI31c+
 yGs3hYCmnODFMumSnDnXrtO5XKO1+/w/Danh2y7qmqGSUHUrdoxk8KWi+NfSQfJhNpiq
 eesCSJiynbvMjdPlfJ9vrYDJAtYtoZOAE/ljo3bxxqRTQulnanGUeoXzG8weFOMiwY/4
 QNQ4ptqnjsd7Jjk+f5ZdB+/2vvtEqx7HHFsxM4dIVEKA8NYWFesd4EpjAgVbPfr3C17D
 EPE52HHmIpFUFImehqwLjQ1yxEU2oi5o7KUgQveOjzwmIEYpnrm3GZgtLtn05X7XxCGc
 sEqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DVWmj25L0Kc4yS6Eejbo9uIOFtdkgSOhBD67AFl5icFSssYiloBJEls7QERWJAynhpv6ovHtM1/gq@nongnu.org
X-Gm-Message-State: AOJu0YxVvVWehLcm+QOCVZedl41hP4TuDnUjSZB6to0fptULiAQkMVJc
 FP1DUWg08NZd2o5GheZQWVl9RoRLUhAkUCxh9Ms4oqWRoxEn9dHvk++aLJ1KFo819cY=
X-Gm-Gg: Acq92OGxS2DNuMGdo9KdS8etaOOyRMzcFKLRWhlxWIvoKc/g6B/9IqZePzcovggaNqB
 RPun3XGV48asEO8VC2h5xR6Dgkbe3rY1DisLwDdIK3W3U6Gs77ajPPH4zlqbrfx483Cvjl/NQHW
 UPHcgYSkKDdmjKlxrQwm0I++1k6vfwvumE8JweTpQ17p1LRKoPRsl5iTNVXP3HXPhQiROKwe0re
 ZxZ8xXLUBQEA1tTDNLS0gpLmvOOw+80h2lTYSeZrBELYx8PHkpYYVSj2dfB6Y5EYB/SRRoI/nGh
 sRqkV/i782ZdWpbYwoeC2S4Eqi9jVKgzb67QIMg9iS6SoM8DXFOb6nvJ6rd92EwRCOn4ShC16F3
 NYUPv1gKNx2pnsSTfLHij8ILBwGPKKRMIHEDhNAWHUiAqE+yWgjFfUZ7PFwMiPa6geAxor/BEMJ
 B0VjIgPKGBADsjrcjm0IPCALsqqHj2g7UAmYOv7Gu+XfJm28m6KrFmsbiaVp0QflD5SAdFvLXXE
 ZnO
X-Received: by 2002:adf:e008:0:10b0:43d:1bf6:30f7 with SMTP id
 ffacd0b85a97d-45ef04d9350mr667316f8f.18.1779998360603; 
 Thu, 28 May 2026 12:59:20 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eec5eba06sm4321566f8f.22.2026.05.28.12.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:59:19 -0700 (PDT)
Message-ID: <dc1b9965-4ac3-4157-91e3-edb9d93556cf@linaro.org>
Date: Thu, 28 May 2026 21:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/common: Remove last bit of target-specific code
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260528140857.44130-1-philmd@linaro.org>
 <b2a58b62-b061-4bdf-b459-9953b7f373fe@oss.qualcomm.com>
 <5b693f87-2f9a-4564-9efb-83c815bcb20e@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5b693f87-2f9a-4564-9efb-83c815bcb20e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/5/26 20:47, Pierrick Bouvier wrote:
> On 5/28/2026 11:47 AM, Pierrick Bouvier wrote:
>> On 5/28/2026 7:08 AM, Philippe Mathieu-Daudé wrote:
>>> Initialize the TypeInfo structure at runtime using the TargetInfo
>>> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
>>> target_cpu_type(). Since the code is no more target-specific, move
>>> it to accel-common.c, removing the need for accel-target.c.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>
>>> Pierrick, this is an alternative for both
>>> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
>>> and
>>> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
>>> for your "single-binary: fix compilation/execution for {arm,
>>> aarch32, microblaze}" series. WDYT?
>>> ---
>>>   accel/accel-common.c | 15 +++++++++++++++
>>>   accel/accel-target.c | 41 -----------------------------------------
>>>   accel/meson.build    |  1 -
>>>   3 files changed, 15 insertions(+), 42 deletions(-)
>>>   delete mode 100644 accel/accel-target.c
>>>
>>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>>> index 9c5b4111c8d..62590a7d9a6 100644
>>> --- a/accel/accel-common.c
>>> +++ b/accel/accel-common.c
>>> @@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
>>>   };
>>>   
>>>   DEFINE_TYPES(accel_types)
>>> +
>>> +static void register_accel_target_type(void)
>>> +{
>>> +    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
>>> +    const TypeInfo accel_cpu_type = {
>>> +        .name = name,
>>> +        .parent = TYPE_OBJECT,
>>> +        .abstract = true,
>>> +        .class_size = sizeof(AccelCPUClass),
>>> +    };
>>> +
>>> +    type_register_static(&accel_cpu_type);
>>> +}
>>> +
>>> +type_init(register_accel_target_type);
>>> diff --git a/accel/accel-target.c b/accel/accel-target.c
>>> deleted file mode 100644
>>> index 7fd392fbc4a..00000000000
>>> --- a/accel/accel-target.c
>>> +++ /dev/null
>>> @@ -1,41 +0,0 @@
>>> -/*
>>> - * QEMU accel class, components common to system emulation and user mode
>>> - *
>>> - * Copyright (c) 2003-2008 Fabrice Bellard
>>> - * Copyright (c) 2014 Red Hat Inc.
>>> - *
>>> - * Permission is hereby granted, free of charge, to any person obtaining a copy
>>> - * of this software and associated documentation files (the "Software"), to deal
>>> - * in the Software without restriction, including without limitation the rights
>>> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>>> - * copies of the Software, and to permit persons to whom the Software is
>>> - * furnished to do so, subject to the following conditions:
>>> - *
>>> - * The above copyright notice and this permission notice shall be included in
>>> - * all copies or substantial portions of the Software.
>>> - *
>>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>> - * THE SOFTWARE.
>>> - */
>>> -
>>> -#include "qemu/osdep.h"
>>> -#include "accel/accel-cpu-target.h"
>>> -
>>> -static const TypeInfo accel_cpu_type = {
>>> -    .name = TYPE_ACCEL_CPU,
>>> -    .parent = TYPE_OBJECT,
>>> -    .abstract = true,
>>> -    .class_size = sizeof(AccelCPUClass),
>>> -};
>>> -
>>> -static void register_accel_types(void)
>>> -{
>>> -    type_register_static(&accel_cpu_type);
>>> -}
>>> -
>>> -type_init(register_accel_types);
>>> diff --git a/accel/meson.build b/accel/meson.build
>>> index 7da12b9741f..1b5b37e3097 100644
>>> --- a/accel/meson.build
>>> +++ b/accel/meson.build
>>> @@ -1,5 +1,4 @@
>>>   common_ss.add(files('accel-common.c'))
>>> -specific_ss.add(files('accel-target.c'))
>>>   system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
>>>   user_ss.add(files('accel-user.c'))
>>>   
>>
>> I'm open to follow this approach first .
>> The only downside is that it limits to a single accelerator parent type,
>> which will be a problem as soon as we have two arch using this framework
>> for tcg. Nothing we can't solve later though.

Good point. I'll see how to handle that (as a following up patch).

>>
>> Regards,
>> Pierrick
> 
> Forgot :)
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


