Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479DCC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 14:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5mIh-0006Nz-CS; Fri, 18 Apr 2025 10:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5mIb-0006M9-RU
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:02:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5mIR-0005RQ-N0
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:02:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1173859f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744984932; x=1745589732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FfgZmhPZmXUXa+NlkWNx4ezzsBssUFnC9b5WmjsqYZs=;
 b=p0eWzJSBZNCpEJpLaXy7wrbT77Nrv41NY/UsB5lnIlBHQf+gFWvBExqViRUtf933wC
 RRWrbmjif2/0Dxx3/ri/zpjqN9JQITkZBSP5fcLexEG+zgGHf9w1b08CDgVkx/um/LHP
 esxV5Odjg2eHRRRbhDcu1yMKDqPOsoGMorY9QYnXIKiKSH8alSaYX/D7tLcGeAYtWpgq
 MKU/CiFZjLrSPZgy4DPBHFPub2GCY8ucolcYU8a9wmx939Uff7uqff0BmRH1S9pG3HqC
 HWZHeDyZF9cW98roYBYZ25SqjohcLy0fuu36PYbCD6s6ZhLbdlburLVqcQ3PIvbQMu4Z
 lNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744984932; x=1745589732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FfgZmhPZmXUXa+NlkWNx4ezzsBssUFnC9b5WmjsqYZs=;
 b=WUHdneWPb1Xmbkwkudvs0lIT41KjKpgquI8UJ/jbRzO/6sGoLxfNyKF9tIwENwzIvk
 YWYohkr19o/tQyInwAN/JKAaPUM87jpFrgZFtFUbezL2UtDCAeCFIMn2YXpa754kDOs8
 1+p8SZXmRutpBJeURyhupehb/niUiRFPrU5T90Y8paIRqaTokIX7EMRFffuIHS4hp7O0
 2yZQ05eDEyGfgI/cvov5oNr/YYARpdLk/RCQHvntxLMwR8ID0UaQdtruk40q/kszMYsT
 zO8Yet32yRmxp/eXw/0A54rBs0MU/4lIqMoxH4lQsgzLt5HZYstOVBEnsi7DGkNexP3c
 92jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3uKE6ToAUPZyUzxTmLPWEQeTXxdRnHjNbkA+9YkTVU0FbNcsRk1ss+4zMi/AQj6jlBWprq7jxdLJS@nongnu.org
X-Gm-Message-State: AOJu0YzgaBjEThgPNDM2FSLL8oWSQ7q9/sLiyU8Rvc1tJWqMdwMI249k
 av0GDPmrEpQYQqSvftELnJeAFDFQgy2UIVbbjkxjfAN7t+vG7FvP7+PKqzCDXN8=
X-Gm-Gg: ASbGncv01red8GhPrKcaagA7YkY4My66wV3MJ6mf4lUCuQBgPMhFR3CiJ2kLJ9JvBNN
 zMqNZuvZqaAtgW8LKMU2RPzK8dPYSg6TwK1XdAPtrA1Sl3LFlbvfxJ/LntTt/jeI8hue1pzaxZA
 FssyLBOwR8A0sOEIrf4qMFd48iJ4vlAqz09/N0w/0BhrbdSEz7jlBu8ZX2YZCrT0jbVo6qivhzQ
 RKpo/6hHN4NMZNXljZKXFxj6RblH9JQMHHKwPO/hEuJgCq9do+xjpWuASzKN78PCNIIOACKc59r
 2+zKZp+AcS+uXOKXCRT1ov1TkMOaWRE7+uUXpusXktDrrrloTGqrHEhi41Mgaa+n78OcQR01aGX
 8P4RjY+w5
X-Google-Smtp-Source: AGHT+IFRRHdneRSeRZZfoteyTYUSQq+sarGiSl3hSuEjYoqZZQTiBkAyhUNboI4vrVc5u7FSULLosg==
X-Received: by 2002:a05:6000:438a:b0:39e:cbd2:9ad2 with SMTP id
 ffacd0b85a97d-39efba2aa44mr1941243f8f.4.1744984931559; 
 Fri, 18 Apr 2025 07:02:11 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43bef1sm2806079f8f.49.2025.04.18.07.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 07:02:11 -0700 (PDT)
Message-ID: <3fc281a5-3a6b-47d6-bead-3a93f331a258@linaro.org>
Date: Fri, 18 Apr 2025 16:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/11] qemu: Convert target_name() to TargetInfo API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-3-philmd@linaro.org>
 <cff3276a-0a17-406d-a7d2-0c932d1fb1f4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cff3276a-0a17-406d-a7d2-0c932d1fb1f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/4/25 05:01, Pierrick Bouvier wrote:
> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>> Have target_name() be a target-agnostic method, dispatching
>> to a per-target TargetInfo singleton structure.
>> By default a stub singleton is used. No logical change
>> expected.
>>
>> Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   meson.build                     |  3 +++
>>   include/hw/core/cpu.h           |  2 --
>>   include/qemu/target_info-impl.h | 23 +++++++++++++++++++++++
>>   include/qemu/target_info.h      | 19 +++++++++++++++++++
>>   cpu-target.c                    |  5 -----
>>   hw/core/machine-qmp-cmds.c      |  1 +
>>   plugins/loader.c                |  2 +-
>>   system/vl.c                     |  2 +-
>>   target_info-stub.c              | 19 +++++++++++++++++++
>>   target_info.c                   | 16 ++++++++++++++++
>>   10 files changed, 83 insertions(+), 9 deletions(-)
>>   create mode 100644 include/qemu/target_info-impl.h
>>   create mode 100644 include/qemu/target_info.h
>>   create mode 100644 target_info-stub.c
>>   create mode 100644 target_info.c


>> diff --git a/target_info-stub.c b/target_info-stub.c
>> new file mode 100644
>> index 00000000000..1e44bb6f6fb
>> --- /dev/null
>> +++ b/target_info-stub.c
>> @@ -0,0 +1,19 @@
>> +/*
>> + * QEMU target info stubs
>> + *
>> + *  Copyright (c) Linaro
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/target_info-impl.h"
>> +
>> +static const TargetInfo target_info_stub = {
>> +    .name = TARGET_NAME,
>> +};
>> +
>> +const TargetInfo *target_info(void)
>> +{
>> +    return &target_info_stub;
>> +}
>> diff --git a/target_info.c b/target_info.c
>> new file mode 100644
>> index 00000000000..877a6a15014
>> --- /dev/null
>> +++ b/target_info.c
>> @@ -0,0 +1,16 @@
>> +/*
>> + * QEMU binary/target helpers
>> + *
>> + *  Copyright (c) Linaro
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/target_info-impl.h"
>> +#include "qemu/target_info.h"
>> +
>> +const char *target_name(void)
>> +{
>> +    return target_info()->name;
>> +}
> 
> What is the benefit to have two different files (common and specific)?
> target_name() can be inline in the same header, returning the matching 
> field in existing target_info, which does not need any specialization 
> per target.

common interface exposed target-agnostic, dispatching to target-specific
implementation (providing a stub we'll remove once all targets converted).

What would you suggest?

