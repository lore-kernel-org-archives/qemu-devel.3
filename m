Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555A7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7oi-0002hk-AO; Fri, 28 Jun 2024 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN7og-0002hY-Gi
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:22:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN7oe-0007RA-N6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:22:50 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cdd893e5cso422653e87.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 02:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719566566; x=1720171366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/NlnKRYgzxj0ZFweSPW1uMicGo4UxLM9L4T9n0hNA0=;
 b=REKlh+wjJW+stadO0Oauy3Hmis72HDErkFHZaAqW8cUeiGcqGXS24E66ymLMKbNN7S
 w0P2K6KtUVVY8rP/klfNw4/QUrqy12Rk09Wcy6v5obK2RxixoBDIsdD7DE6vD92daf/B
 GLSaFzcQL8QBvVqbH7yLr4YCyMH7UO2/NjDcTutH4r0xcuQEN5siK2v/9G5BB4ePv5tV
 nRMEySxN2SKqWL8H+6Zagdl29W+SgDsOtRiq2hVo/Aza7dUgIC7509gyVJhEjTJEYKy2
 vWesapCGU/B996Vkb2JzN7HnEq3RMi1NdtWnzb9sGpbbRET+5the/M/F438WCU+hwG/2
 tHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719566566; x=1720171366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/NlnKRYgzxj0ZFweSPW1uMicGo4UxLM9L4T9n0hNA0=;
 b=oINukXgmg+BXBZNj7ZKVekIurK5nOfLACdnEO+vKc9Jmf1ZD1Tn6rGeiWzlTIHR90Z
 PeD8aHIw1QQa0+I+7GY+yyeMYIGvqQpHkehLreJEKbdO8s/VrCDbxi7/zwg1/ahPUZ4P
 w7FWdIEsQ+ZuO4obqoEqFX5uNEMuajrQtVU82UWk2SqcUon8m5MuKAhobslha+l3iC/8
 0+F5VvTHTBNIm79B3RDorjT8MK2JKcRpMtWhaAHBh3D/qqegMUxMBUIAsK/rc2BeWCz0
 0dWEjUyx6tePKnOCIlol027RUeOWW1IeqZ5CVot21/hdCXNBvtuyXLuhsKLDkhHw0GHp
 WMeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGzfx0PgT/G+v5i/XOKgrTZk5qfZYesqAjR9x2AQNlFfGEfQJ4mtnFjS3ifxnnzP4WCVtfQo9EiiTaASI7Dn9aJnNKy/c=
X-Gm-Message-State: AOJu0YzIyg73YCHQrSXmLzr95zJ09O7FmJyqlpDuNconE7Swt0iS/tou
 nnr54muMCGPQsLZNjRzC1wY1gGecjg1l7V3jnU/bJQoAjUYMcgJs38U66M1dvKk=
X-Google-Smtp-Source: AGHT+IFn/8RWHDCuiESiubMBB/gufpkS47gjb2IpZtVRvhsUN3peWssjrHqX5d+Tn/Edi57szg0I8Q==
X-Received: by 2002:ac2:5f8b:0:b0:52c:df2c:65fe with SMTP id
 2adb3069b0e04-52ce18350bemr11539015e87.15.1719566566466; 
 Fri, 28 Jun 2024 02:22:46 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f99sm25970865e9.41.2024.06.28.02.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 02:22:46 -0700 (PDT)
Message-ID: <ec6e89ee-1a8a-4900-b9d0-9d5769d855cc@linaro.org>
Date: Fri, 28 Jun 2024 11:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-7-gustavo.romero@linaro.org>
 <50ff9c9e-39a6-4be1-b6d5-42ff0dee7232@linaro.org>
 <8406f36b-0324-54c5-5949-0cad6193eca8@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8406f36b-0324-54c5-5949-0cad6193eca8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 28/6/24 07:20, Gustavo Romero wrote:
> Hi Phil,
> 
> On 6/27/24 3:05 AM, Philippe Mathieu-Daudé wrote:
>> On 27/6/24 06:13, Gustavo Romero wrote:
>>> Factor out the code used for setting the MTE TCF0 field from the prctl
>>> code into a convenient function. Other subsystems, like gdbstub, need to
>>> set this field as well, so keep it as a separate function to avoid
>>> duplication and ensure consistency in how this field is set across the
>>> board.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   linux-user/aarch64/meson.build       |  2 ++
>>>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>>>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>>>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>>>   4 files changed, 63 insertions(+), 20 deletions(-)
>>>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>>>   create mode 100644 linux-user/aarch64/mte_user_helper.h
>>
>>
>>> diff --git a/linux-user/aarch64/mte_user_helper.h 
>>> b/linux-user/aarch64/mte_user_helper.h
>>> new file mode 100644
>>> index 0000000000..ee3f6b190a
>>> --- /dev/null
>>> +++ b/linux-user/aarch64/mte_user_helper.h
>>> @@ -0,0 +1,25 @@
>>> +/*
>>> + * ARM MemTag convenience functions.
>>> + *
>>> + * This code is licensed under the GNU GPL v2 or later.
>>> + *
>>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>>> + */
>>> +
>>> +#ifndef AARCH64_MTE_USER_HELPER_H
>>> +#define AARCH64_MTE USER_HELPER_H
>>> +
>>> +#include "qemu/osdep.h"
>>
>> https://www.qemu.org/docs/master/devel/style.html#include-directives
>>
>>    Do not include “qemu/osdep.h” from header files since the .c file
>>    will have already included it.
>>
>>> +#include "qemu.h"
>>
>> "qemu.h" shouldn't be required neither.
> 
> If I remove qemu/osdep.h CPUArchState can't resolved. If I remove qemu.h
> then abi_long can't be resolved. I'm in a tight corner here.

Does it work with "exec/cpu-all.h"?


