Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A7FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN42F-0003A5-B2; Fri, 28 Jun 2024 01:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN427-00039P-1o
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:20:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN425-00082J-6D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:20:26 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so132792a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552021; x=1720156821; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqd06UQmvSd0gwEDzhtzEyijaShVTu/Kd+PyC4SoPdE=;
 b=k62/KzDUohRW8YE1uQJBMOhgBLa4Pjmjgn0353ZygZViNx5pNQ6fBq3D75nHeMOudU
 CXpBo98M+8B2KLfA0TpIVfKkhTlcZ0qD6kzHkNTSSo3jPv3NK4fbPykXIZCtdx/qorRZ
 Wd8ZKRYp86fC8xdidMzhA6Vtya1rjTOMZFBjJS6S6sI/mhXiKVjv3IFU1zfB4NIt7FhW
 0Gum1KgUHaDPsXsHzr4NwIJw61s6k6jzHdHOnsiXxIxiUZdY9oyuUDdFq+3B0Wd5XBX6
 SSvaluHTDwpbbaBUYSDqQsoFGmSapbIghKOFfNCy6KD4x7Qv8jTmz5G3ErPmhpgeiJ5i
 ZPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552021; x=1720156821;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gqd06UQmvSd0gwEDzhtzEyijaShVTu/Kd+PyC4SoPdE=;
 b=YHQXhRkYi8UiI8TcqGJCgok6WIbLXWotAHbOvz3dXlrdHRdP/cotpSloOOo7xRNMVX
 JM5zNQ4UFzMFgq5TwCYXKJAHfESCK4dc7ALgZM+4QGwnXc5G1YGgSuwDGAg/lQNql4Sr
 JWp1ghY3pbUhNCTVNfh0fwP+iyatM0VultRHOCOGXYTbe1zm5526t47O/oUPZUASN2bc
 M1puBbE3hOOU5ZUuJU5ZSgV3Qknn2XJNRsRWch+gjTjoemFzszyfhJlRhZxi+wpWrdv/
 NkrrEZe+jUaehKqqjntwQQRcFiexrTemZ2N4KFr0sxrdbkl92BKU/H1Qaoejn8H0iggj
 5Mzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuyLl1ErLRdPoHCP3aMUG44X7pobNu9F3Q3ZiOFRkzYfZrJyt0d27IAS45bDS6CVTY6Q9F/PlMud/0PfXDqLB8F3KjdO0=
X-Gm-Message-State: AOJu0YzNWpCA0X7SykKXICh3CLzCCFE25VeQFjmzDW+MAQSRD3n+nmue
 Ny5msj60dkpkqm0Gg8WsBePqWzCFuEDrsr3n0rpL5O19PKKPVwpLV45uYbOqTnU=
X-Google-Smtp-Source: AGHT+IETS5TY5cMtB9+0ZLWCTAd2CfsGk3AUoacUrkaiWt4zc3BOLlkS4B/1m5k0s+gHN//n5ssQiA==
X-Received: by 2002:a17:90a:e2d5:b0:2c3:2da1:c8bc with SMTP id
 98e67ed59e1d1-2c8612a9b2amr12932870a91.15.1719552021196; 
 Thu, 27 Jun 2024 22:20:21 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8125sm695356a91.48.2024.06.27.22.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 22:20:20 -0700 (PDT)
Subject: Re: [PATCH v5 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-7-gustavo.romero@linaro.org>
 <50ff9c9e-39a6-4be1-b6d5-42ff0dee7232@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <8406f36b-0324-54c5-5949-0cad6193eca8@linaro.org>
Date: Fri, 28 Jun 2024 02:20:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <50ff9c9e-39a6-4be1-b6d5-42ff0dee7232@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.174,
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

Hi Phil,

On 6/27/24 3:05 AM, Philippe Mathieu-Daudé wrote:
> On 27/6/24 06:13, Gustavo Romero wrote:
>> Factor out the code used for setting the MTE TCF0 field from the prctl
>> code into a convenient function. Other subsystems, like gdbstub, need to
>> set this field as well, so keep it as a separate function to avoid
>> duplication and ensure consistency in how this field is set across the
>> board.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   linux-user/aarch64/meson.build       |  2 ++
>>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>>   4 files changed, 63 insertions(+), 20 deletions(-)
>>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>>   create mode 100644 linux-user/aarch64/mte_user_helper.h
> 
> 
>> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
>> new file mode 100644
>> index 0000000000..ee3f6b190a
>> --- /dev/null
>> +++ b/linux-user/aarch64/mte_user_helper.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * ARM MemTag convenience functions.
>> + *
>> + * This code is licensed under the GNU GPL v2 or later.
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +
>> +#ifndef AARCH64_MTE_USER_HELPER_H
>> +#define AARCH64_MTE USER_HELPER_H
>> +
>> +#include "qemu/osdep.h"
> 
> https://www.qemu.org/docs/master/devel/style.html#include-directives
> 
>    Do not include “qemu/osdep.h” from header files since the .c file
>    will have already included it.
> 
>> +#include "qemu.h"
> 
> "qemu.h" shouldn't be required neither.

If I remove qemu/osdep.h CPUArchState can't resolved. If I remove qemu.h
then abi_long can't be resolved. I'm in a tight corner here.


Cheers,
Gustavo

> Conditional to removing both lines:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

