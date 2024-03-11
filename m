Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D64DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkLv-0008Mz-Sr; Mon, 11 Mar 2024 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjkLr-0008Cv-21
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:26:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjkLo-0008Sv-Tc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:26:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e92b3b5c9so1740825f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710181574; x=1710786374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kB6aU45OMO1SedRbUf1U8+DKRJvtswJ1XF4gExKfQ2I=;
 b=SwvWMUCSGQMmrW8yXFEb/3tEvgzvtG1GIzTT2nweJGaHUY0ug2LvJ9aJhQU8gCoyez
 +Sp0vhVrNndPrRvuZNqSFOUi+1lu+XbyKy/zQrJ5J787Q4ps0VNDtUCLOkA5TNdsO+0H
 e7TMYHzJzuk3vZhBEmkSRDqsXZaG/j08orMpk1frAut1nIxxqvTgJsc4HqWwyyCdDeTR
 owt7PsiKVLwJGhqAGx3hGqKremJF/LLGMInhSSvc0FxpeSOtmvDOnAONuBvWpgEednTY
 XJAAjvt7AU0XQYqS/Q0X5BmbPDahyqpT7j3KqUiubDb71lRF+frXUzH0xxRLUyQoRvpp
 rLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710181574; x=1710786374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kB6aU45OMO1SedRbUf1U8+DKRJvtswJ1XF4gExKfQ2I=;
 b=jtaToD30OAq9yrQN6NkTq432DetU9jgIPy94xyWbSRtzTOwIAX5LIUD6TDdnV5VNXr
 Nl4V3ETFGRVASbg8Ay5j0DRfHi7NLKD4X2eZhhKkVd2He+pkYb/QFmuJ17lChdoNLWmd
 XHUvOxaXUDXCiIPPorWuf+B/SIQhrvpYU3DlA/wWSceXQ0iRchZdkqZ8FuKOfmzcEYF5
 PyVCyM9Gay7AuTEM6mQ96z5OczKQfGoiHeiTZpQRfg5iZHnA3X4Qm748upDK8JZimEM0
 AA3Y/N69U/f/KZAx5Z+FsS1eaZXCmYUfAYSagk9120l+Ve3u9NIwIWdkfpAyiAeJN9B1
 LMXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwKc5kI3/1UKV1RJYkiBpoRbKdHdNJir1aZl/KobkJOLXe5s2pJIH3szug5LV/lqqbCMPsc0Vzan+aspyuSRJfOU4G7qA=
X-Gm-Message-State: AOJu0YxCJvibRCNwZOi+Ikw7N/lIBkD7Nr+DAlMSf3aDzJdZxYBIyio4
 0pBphXcgUxL19v/K24P3wQpBptlPKk3WbPvQOQGRPkGnmp3FFlFEZ6N0lvEwhTg=
X-Google-Smtp-Source: AGHT+IHaUkxq0dZi7FzFhl5GYJiLgnVRA7XrpGtD5W3jCzatoyKrjoAhfIxbdeLa+ZCCr93kMQQoPw==
X-Received: by 2002:adf:ee91:0:b0:33e:6833:8f9a with SMTP id
 b17-20020adfee91000000b0033e68338f9amr5038291wro.48.1710181574525; 
 Mon, 11 Mar 2024 11:26:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 h3-20020adf9cc3000000b0033e73c58678sm7054063wre.15.2024.03.11.11.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 11:26:13 -0700 (PDT)
Message-ID: <0297cf9b-4591-4622-96b0-83dae349dc1f@linaro.org>
Date: Mon, 11 Mar 2024 19:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
 cpu-common.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
 <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
 <Ze8m4YvRQrWFlFpN@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Ze8m4YvRQrWFlFpN@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/3/24 16:44, Zhao Liu wrote:
> Hi Philippe,
> 
> On Mon, Mar 11, 2024 at 12:40:23PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Mon, 11 Mar 2024 12:40:23 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
>>   cpu-common.c
>>
>> On 11/3/24 08:56, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Remove unused headers in cpu-common.c:
>>> * qemu/notify.h
>>> * exec/cpu-common.h
>>> * qemu/error-report.h
>>> * qemu/qemu-print.h
>>>
>>> Tested by "./configure" and then "make".
>>
>> This isn't often enough. The safest way to catch implicit
>> includes is to add #error in them and compile the source.
>>
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>    hw/core/cpu-common.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>>> index 0108fb11dbc8..4bd9c70a83f1 100644
>>> --- a/hw/core/cpu-common.c
>>> +++ b/hw/core/cpu-common.c
>>> @@ -22,14 +22,10 @@
>>>    #include "qapi/error.h"
>>>    #include "hw/core/cpu.h"
>>>    #include "sysemu/hw_accel.h"
>>> -#include "qemu/notify.h"
>>>    #include "qemu/log.h"
>>>    #include "qemu/main-loop.h"
>>>    #include "exec/log.h"
>>> -#include "exec/cpu-common.h"
>>
>> Watch out, "exec/cpu-common.h" is implicitly included:
>>
>> $ git diff -U0
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 6346df17ce..27961bacc6 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -2,0 +3 @@
>> +#error
>>
>> $ ninja libcommon.fa.p/hw_core_cpu-common.c.o
>> In file included from ../../hw/core/cpu-common.c:34:
>> In file included from include/hw/boards.h:6:
>> In file included from include/exec/memory.h:19:
>> include/exec/cpu-common.h:3:2: error:
>> #error
> 
> Thanks for helpping me verify this!!
> 
> EMM, but I'm still not understanding how this approach distinguishes
> whether hw/core/cpu-common.c needs the header (include/exec/cpu-common.h)
> directly or just include/exec/memory.h needs that header? For the latter,
> the header needn't be included in .c file.

Yes, you are right, it might not be necessary.

For all other headers in your series I checked that no function /
definition is used in the source, but "exec/cpu-common.h" is too
big to do that manually. I mostly skipped it because it is odd to
have cpu-common.c not including the header with the same name...
Also, in another series I split / reworked "exec/cpu-common.h" and
IIRC a part of it will be included here. Bah, I'll stop writing
and take your patch unmodified.

