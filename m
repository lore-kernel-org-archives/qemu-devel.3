Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D8DC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 18:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoyv-0004SY-Du; Thu, 13 Jun 2024 14:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHoyt-0004SC-Hw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:15:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHoyr-0006bm-BV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:15:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f6f031549bso12931685ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718302524; x=1718907324; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Vz+vJcqyH15+r/HcCMxspfU+HohuVgxUBlnotDz2gQ=;
 b=l+1wgT6VJsqVI47AMJNx/qCEe49YPTpPwQaSSu6QteuUuMJsm9VwgN6mpitPjnLoKV
 vtcz/rE9BVeAa/nbEuqQoCaGghvySVaZ7aR7ipwykTE2LNGs4aoFbpODiOdRSV1o57Bt
 jPNfzU1U+d902BfMOBAEIOdq5JseGRGeh29Bbl/hnHEeKENANsHyXZMjMTpe+qYNvgCV
 TwSCv33MbrFKJ6cEV2JG3MqDdFbK4x36Q8U4pBAfl4tnw7NeY36rVeUAdjjW54ESWpV5
 QqDE/g9ZVesseJlM9QHSx+Adw9+6U0sy1o+J4ECixoXA3UVXsCLS5RDz4u/IsyQ6hj2W
 vloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718302524; x=1718907324;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Vz+vJcqyH15+r/HcCMxspfU+HohuVgxUBlnotDz2gQ=;
 b=pyrzv8FPTnionBuEeU0laRAOOGBBMoC7Zj4dC2SJxwq773aGk0Iq3SbshDPraeRmEo
 uwMuikaELOuC9hmeB9sk24aSxLlVdTCSr6TmAqsyeCzPSPB7dl3eS/Nbj6lOupn12gGy
 ZZ6v1ZVNRiOsCUL2901tUCoB/2ZBF9h9PiiJhuKT0yyLZ/6QLO+V8uRZZL8WQkOvIX00
 V2txAUVyVTctvAV4rkdQ0ppJnCg+za2xxh7mb8VG1EcqNFBgCRGvkv1raS/xXXWovvzc
 d9xP0M5yUehQMGz+CeMaIsM3ihxbrMwJvaK+1p79qmbMWNVWMoJ7fdiB2JfO0Q+U/d3A
 Ye7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2cwmMnJ7as3HrD/uTko/VkrBjZVCBa/Hia6biJGwxtM0urYb5VN5U4gEqgQJMrhcS8bF7oUDHlalR58eLXSEvlGk4KBk=
X-Gm-Message-State: AOJu0YxkNgz8SfwQF1B5JKE3C8mb3LxGeeruVDJNRV7s4oeis+JIDa5L
 XBwcY5XVaMQaDH6bea6K2nNeo+2xEPRG1X+oUFXZBQikRPSqUO8h10mpWaycR3s=
X-Google-Smtp-Source: AGHT+IFfm1p9LWnF25FNOCpKeznnTyhaipl+BT0RlYJQGd7utDFTCZIPF9J/VWm95sPnGnhOWrkEGA==
X-Received: by 2002:a17:902:e54e:b0:1f6:225e:67a1 with SMTP id
 d9443c01a7336-1f862a06038mr4810285ad.56.1718302523626; 
 Thu, 13 Jun 2024 11:15:23 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee847bsm16998965ad.168.2024.06.13.11.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 11:15:23 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-7-gustavo.romero@linaro.org>
 <20996ca9-9feb-42ee-8850-af265f77f72b@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <5a93c441-d1a4-6f60-1b35-a313dd9a1b62@linaro.org>
Date: Thu, 13 Jun 2024 15:15:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20996ca9-9feb-42ee-8850-af265f77f72b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.395,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 2:35 PM, Philippe Mathieu-Daudé wrote:
> On 13/6/24 19:21, Gustavo Romero wrote:
>> Factor out the code used for setting the MTE TCF0 field from the prctl
>> code into a convenient function. Other subsystems, like gdbstub, need to
>> set this field as well, so keep it as a separate function to avoid
>> duplication and ensure consistency in how this field is set across the
>> board.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   linux-user/aarch64/target_prctl.h | 22 ++-----------
>>   target/arm/mte.h                  | 53 +++++++++++++++++++++++++++++++
>>   2 files changed, 55 insertions(+), 20 deletions(-)
>>   create mode 100644 target/arm/mte.h
> 
> 
>> diff --git a/target/arm/mte.h b/target/arm/mte.h
>> new file mode 100644
>> index 0000000000..89712aad70
>> --- /dev/null
>> +++ b/target/arm/mte.h
>> @@ -0,0 +1,53 @@
>> +/*
>> + * ARM MemTag convenience functions.
>> + *
>> + * Copyright (c) 2024 Linaro, Ltd.
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef MTE_H
>> +#define MTE_H
>> +
>> +#ifdef CONFIG_TCG
>> +#ifdef CONFIG_USER_ONLY
>> +#include "sys/prctl.h"
>> +
>> +static void set_mte_tcf0(CPUArchState *env, abi_long value)
> 
> Either declare it inlined (otherwise we'll get multiple symbols
> declared if this header is included multiple times), or
> preferably only expose the prototype.
> 
> Also I'd use the 'arm_' prefix.

Thanks, I forgot to add the inline hint and was really wondering if
I should add the arm_ prefix.


>> +{
>> +    /*
>> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
>> +     *
>> +     * The kernel has a per-cpu configuration for the sysadmin,
>> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
>> +     * which qemu does not implement.
>> +     *
>> +     * Because there is no performance difference between the modes, and
>> +     * because SYNC is most useful for debugging MTE errors, choose SYNC
>> +     * as the preferred mode.  With this preference, and the way the API
>> +     * uses only two bits, there is no way for the program to select
>> +     * ASYMM mode.
>> +     */
>> +    unsigned tcf = 0;
>> +    if (value & PR_MTE_TCF_SYNC) {
>> +        tcf = 1;
>> +    } else if (value & PR_MTE_TCF_ASYNC) {
>> +        tcf = 2;
>> +    }
>> +    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
>> +}
>> +#endif /* CONFIG_USER_ONLY */
>> +#endif /* CONFIG_TCG */
>> +
>> +#endif /* MTE_H */
> 

