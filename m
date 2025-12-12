Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BD1D59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU75u-0002i6-M9; Fri, 12 Dec 2025 12:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU75s-0002h2-9a
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:38:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU75q-0006PG-6f
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:38:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29ba9249e9dso20219045ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765561092; x=1766165892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8jlOYjjEsoETYeyFILku4+um3f3qmux/EedRko5/VAI=;
 b=eBxFe5p1i0jq7r8Nxqo++ERZUCbq24fbUuJvkeXdo2pOqlFe8U9cqlmrmhyfBD5oku
 6pv6SfKYWOq5FPoe+GqasIGaVHAIkYFJqo4iyaxD51XVH8tutIaNpse3Lo7hj8roj1hI
 pwfLTcollCl7OfE0B2nyHw07sjPNOQNz1Q24fxUmjhG1v3EBHdYqt8avKCcB0dx2EzMt
 qvaBp9FcSkLDBTJqRs+2baVqjAV4tArTm0WjTnQC0yqt6Hfk/p+6z2L8rw3qcBMNAE3B
 P/05V06zyUX+Qky9soQGQ6gr9AUrvyPlqwLZxRvaX6thlAELiygxQbka+CgDR1K7pIBz
 sXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765561092; x=1766165892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jlOYjjEsoETYeyFILku4+um3f3qmux/EedRko5/VAI=;
 b=TJfLOKOQnBdZNhagnq0g6mRhkzmS8CqSw0D3lvqgXiYIKGfsw6ELzd1W9HUbIasuo8
 LmJmayxnIe71MwRfdfawXDuK2Ar0/2IvSzDWNvJy/EbBpAE6aDKFD8WRnbcXknUyNpRt
 PhxeRPSNf5Lpl0EXr1WbiIQ4nqFoUNyRIoDc0P4aIR1Syrj04exLJaJF68flefCwNi8s
 La7Mdc5HU7ZqGn9a5l3kvWeyQ/kbflFKdArlDgyaP+OQvTY3b3zgFX3h98Q45NHD3pKU
 kzfo72qG+/D3T8kUuxolPOTzL949xLiQKcDrg66Joe5eFA3w37n77fYZEDOCLkoTuzNE
 mPyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLHURmyOud17x2L4GEMRpHpJWveRElH691nIEV7wQLsKfrhSVYNp5QD4v7taWvBWy2KQWjRYCKIU/G@nongnu.org
X-Gm-Message-State: AOJu0YxeYOpvlMKirnFhdOJRUY1PEf7le2hgZHXSQ/2Bj7ZEBnN1gcl/
 0CQp1Ws0N4bBjSwa9nCym6o0xjGH4AcVnM5u3myMQXT+8FFqph1cRO04lIIqsyzaoRc=
X-Gm-Gg: AY/fxX7yIyOzcQDpAmBSvYYHKzErgVetBHl+K3wbiewwcnZqViKhHPEx+u4T0HAdcOk
 ep2LPhqTlGuIhAfC/xljGPftfInzutO3PhJukpM68OT5DqVz4MOhyJwDoG2eWFv7hGpCxCEPzyg
 j8HyVPj9UEbxRjLGXlRmh8MMfHno5KqHxpJkSwsUdTNo1RVWsh1KRFnOaF8eSqeYQVFR1z8zUyr
 /SvPvRIpdqA/MxTx8GEtcXfFQ1amI7kNQQ2VAUEjCEvRvEK4IjM0MUfmJKDOQIwUin9ryn6ATIV
 y2/pjIGr2U92K3/KP1RY9KwHemvo9sQCP9QMNYJZBSZCwQqg6VDFccUl4UGkrr6t88/HcjuAnii
 2/kdfsWLuFD4zbHy+vDeVlXHS149nZEeeo4fUvmTxxbG24wbtTNccCrcqfl8wiQ6fn9u+VIOvXp
 BwkPaYaQSpDC5hWUE7tbFHoCb/yTbXsKIySxuk5aTws1vlErVvjvGhkMY=
X-Google-Smtp-Source: AGHT+IE+9Y0m3KWr5u+YalCxd9MQceMIGgOmhaaQ+vIXP9sdYgsKyBMPaJnKfMx7BKHKXK22OfYiPA==
X-Received: by 2002:a17:903:2cc:b0:295:888e:9fff with SMTP id
 d9443c01a7336-29f23b5f44dmr25800245ad.20.1765561092402; 
 Fri, 12 Dec 2025 09:38:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea03fa19sm60386475ad.67.2025.12.12.09.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:38:12 -0800 (PST)
Message-ID: <30c78af7-9848-4e83-a3e3-d3234170445b@linaro.org>
Date: Fri, 12 Dec 2025 09:38:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Move ARMSecuritySpace to a common header
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20251211234426.2403792-1-pierrick.bouvier@linaro.org>
 <20251211234426.2403792-2-pierrick.bouvier@linaro.org>
 <a40ca4c4-b34b-4315-8e6e-46812dfd5432@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a40ca4c4-b34b-4315-8e6e-46812dfd5432@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/12/25 6:56 AM, Richard Henderson wrote:
> On 12/11/25 17:44, Pierrick Bouvier wrote:
>> From: Tao Tang <tangtao1634@phytium.com.cn>
>>
>> The ARMSecuritySpace enum and its related helpers were defined in the
>> target-specific header target/arm/cpu.h. This prevented common,
>> target-agnostic code like the SMMU model from using these definitions
>> without triggering "cpu.h included from common code" errors.
>>
>> To resolve this, this commit introduces a new, lightweight header,
>> include/hw/arm/arm-security.h, which is safe for inclusion by common
>> code.
>>
>> The following change was made:
>>
>> - The ARMSecuritySpace enum and the arm_space_is_secure() and
>> arm_secure_to_space() helpers have been moved from target/arm/cpu.h
>> to the new hw/arm/arm-security.h header.
>>
>> This refactoring decouples the security state definitions from the core
>> CPU implementation, allowing common hardware models to correctly handle
>> security states without pulling in heavyweight, target-specific headers.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01288.html
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/hw/arm/arm-security.h | 54 +++++++++++++++++++++++++++++++++++
>>    target/arm/cpu.h              | 25 +---------------
>>    2 files changed, 55 insertions(+), 24 deletions(-)
>>    create mode 100644 include/hw/arm/arm-security.h
>>
>> diff --git a/include/hw/arm/arm-security.h b/include/hw/arm/arm-security.h
>> new file mode 100644
>> index 00000000000..9664c0f95e9
>> --- /dev/null
>> +++ b/include/hw/arm/arm-security.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + * ARM security space helpers
>> + *
>> + * Provide ARMSecuritySpace and helpers for code that is not tied to CPU.
>> + *
>> + *  Copyright (c) 2003 Fabrice Bellard
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + */
> 
> Don't add the boilerplate to new files, just SPDX-License-Identifier.
> This should have tripped a checkpatch error.
> 
>> +
>> +#ifndef HW_ARM_ARM_SECURITY_H
>> +#define HW_ARM_ARM_SECURITY_H
>> +
>> +#include <stdbool.h>
> 
> Already included by osdep.h.
> 
>> +#endif /* HW_ARM_ARM_SECURITY_H */
>> +
>> +
> 
> Watch the extra newlines.
> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

I'll fix the nits you reported, just included this patch from Tao's series.

