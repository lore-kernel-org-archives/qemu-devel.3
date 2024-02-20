Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81697C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKFv-00081n-TQ; Tue, 20 Feb 2024 02:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKFu-00080N-9C
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:09:30 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKFp-0007yc-RI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:09:29 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3ea7616097so200605566b.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708412964; x=1709017764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2ti6MU64ste7HF3pHVEAvtgCFlRo8bHIyKHvxSphvo=;
 b=zKLJJ626snowECQbCC/lwGUOUrUUq3a27AfDmJqrsJUl5m8EMY5A0zk1dMqvZl6em2
 qyvQJHjFjnTWkAa1bT1qLid6M8dQ81XMPyykWBOT81d9gik2igUbz/ZnRmIZwsJ5wMSr
 XIxhTlorFN6bOjYdlRGkGkzAdbY0QlVpsx65ygz4clZ9xiiedr66ncKIuvB8PbNkszMl
 nPGmJufUV+ZiSsA84n1tXTpAnw5bZiQKsjM1ARzNvV2hfHrmgIbZvvzPSn9d5t/CCoBQ
 xX1VSX+LtGiIwOwBEHBvWgYDCBPs9qdzr7MWKw4fmeOVHCbc4n+oQ/+ol5rx4SZGcwin
 iqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708412964; x=1709017764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A2ti6MU64ste7HF3pHVEAvtgCFlRo8bHIyKHvxSphvo=;
 b=oEgsPylDo/UyUT3LhfW5mVLkBZulYY0KQo2BSAwZeBipNQ79rQieJpW4XW3NyQNXfl
 S2jufqs/WwTD4UV+37QVEQkqxZNiCjC9IhFnpWMpCap6T46fcwRCiMbMp7RLCGPx0OMf
 XoMjmpVjAaUc1t1xhMDz65N5KtHnAs5V6qgTrPhZ44ghhklSEb4YPj/OjhFZob4mPAiF
 0sA963R90Em8JmFPNNyYr9GDPJ1jpXrFJJ6TPjPPBg+97H/iob1No9uQP4qUFaffEn1m
 snZ770uNk3h3364RXMZY3aiQTkUFNlRLmjomOwH/Mhg1SpYneDnfQkAHYXV5D2ooXRGW
 QQ2w==
X-Gm-Message-State: AOJu0YzDqpMMv7PpDZAUsTQ6wRwOD2nbdm37uq9lMybU6rOS7Q4Z8Xdm
 R35M4iOS1r5EaYJnC1zokMVQ1/AlJmZjLJLpFdH4MEdUKxQQ6XMTKXaL+e428DE=
X-Google-Smtp-Source: AGHT+IGZsoVfd+CQZp+MzSF0QWw06ZL275/DQLuJNvdn6cdf/Y3MgayB45QiMchgRpvrByf76yLRqg==
X-Received: by 2002:a17:906:b154:b0:a3e:cbba:fd86 with SMTP id
 bt20-20020a170906b15400b00a3ecbbafd86mr1969169ejb.11.1708412963799; 
 Mon, 19 Feb 2024 23:09:23 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 qw23-20020a170906fcb700b00a3e426149a1sm2878011ejb.50.2024.02.19.23.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 23:09:23 -0800 (PST)
Message-ID: <ef49ed81-fa4c-4f77-b5d8-53d62bae3524@linaro.org>
Date: Tue, 20 Feb 2024 08:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/acpi/ich9: Include missing headers
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240219141412.71418-1-philmd@linaro.org>
 <20240219141412.71418-4-philmd@linaro.org> <ZdQPhcB28MsDdFfu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZdQPhcB28MsDdFfu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 20/2/24 03:33, Zhao Liu wrote:
> Hi Philippe,
> 
> On Mon, Feb 19, 2024 at 03:14:09PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Mon, 19 Feb 2024 15:14:09 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH 3/5] hw/acpi/ich9: Include missing headers
>> X-Mailer: git-send-email 2.41.0
>>
>> The ICH9LPCPMRegs structure has MemoryRegion and
>> Notifier fields, so requires the "qemu/notify.h"
>> and "exec/memory.h" headers.
>>
>> However nothing from "hw/acpi/acpi_dev_interface.h"
>> is required, so reduce its inclusion to hw/acpi/ich9.c
>> source file where it is used.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/acpi/ich9.h | 3 ++-
>>   hw/acpi/ich9.c         | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)


>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>> index 573d032e8e..be375a8b9d 100644
>> --- a/hw/acpi/ich9.c
>> +++ b/hw/acpi/ich9.c
>> @@ -35,7 +35,7 @@
>>   #include "sysemu/runstate.h"
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/ich9_tco.h"
>> -
>> +#include "hw/acpi/acpi_dev_interface.h"
> 
> Do we have the requirement for included header ordering?

We don't. If headers were properly including requisites and
self-contained, order shouldn't matter, and we could sort them
alphabetically to enforce a common style.

> If so, it would be better to put it before "hw/acpi/ich9_tco.h".

Sure, no problem.

> 
> -Zhao
> 
>>   #include "hw/southbridge/ich9.h"
>>   #include "hw/mem/pc-dimm.h"
>>   #include "hw/mem/nvdimm.h"
>> -- 
>> 2.41.0
>>
>>


