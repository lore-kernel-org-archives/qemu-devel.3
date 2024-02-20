Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F5CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKOR-00054z-0l; Tue, 20 Feb 2024 02:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKOO-00053f-SB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:18:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKON-0000j7-AN
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:18:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4126dd40a54so3609175e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708413493; x=1709018293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ommEHBrmlQfSpSXN2k868MSNzg+rE7yK5rCTU10i3U=;
 b=j/J85w5bndxyS+flnShYe3gtkSaOJCJdrXcELJHrVE5OdfJQJ6OsVrH2Y5bOgXtRiE
 7wWqwJ2GxjfMKhwWe4Z5HTYsWQk0huWVdISa8PQRroeYV8DtIosacO5y5PVETnGpn9I3
 yl3ObW0S/LvhXP8afqpeovoA/tLH2t90WQQ4JDp6kJgJkjW05O5KDQno7R6t7muDL3XP
 fK/aihLvj5+mnhldAA7uPy45j0E+WVusXMSOlH9iMaqakRbGo+0OtfP8YH6uoozMQaSf
 XB1/SaGuNGAO6ZJIsSh0VyGjfULRdJXBb6Gii3RJWeNlVUWRU9k9VBbK1G/vLPEqdEpO
 nW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708413493; x=1709018293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ommEHBrmlQfSpSXN2k868MSNzg+rE7yK5rCTU10i3U=;
 b=asCGDBxkggkzilvAFGijSE8ur7IrVbSdWfnuK9/gxYg1JaNhNUBY30Jgqv4wFv9C9v
 k7nJBP5SNBbuYyGR1I9nmUSAc9/xauKzdOD+6i4c1U0EmhU6yKx8IgzEz8Bh8jFGif8c
 ha8X6Gjwuzd90NMd68OMbSaNCaX/F5A/WxVqt0VwXx7SpM4iWeyyyXG+YryKC/MOJVdt
 YhP8FkVRZ1tcay7q8L3BJGd82o84tXCHaBwVMTsC9qjuWHfVa3SY/jXfIpRMAfQ+Asl9
 rhU9c3Wz+0ha+vtckICYN5O+180r8IQZ09c61jun0coA5J5aYNgmypE2EJpEKNE9MpEr
 cKvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPXfXwnf4gbRYoY1l7HJQ2HgN9CmPlqOXP28Xt2y1Nqde00w7JBJHfEc8mKU+g0E/Iz76mXHUP//1+QXO7MEvGusM/q68=
X-Gm-Message-State: AOJu0YyxZCdoF+l+LB4U1HV6u+tnpUsqroBZaTBotOKhrGNstUd2avO+
 x0+pSgKzFwyFrhSRtUUCNS8anu7PnqazNqhVbNSiWC/HjBEoAGuOOpVLEAvd5Aw=
X-Google-Smtp-Source: AGHT+IFefGAiLw2JRR3hv5SG+AxKmGYeRNmjzzs2M5hz4n+3LS4+jQqFP6X6C3r2bwauVZjXbRFYRA==
X-Received: by 2002:a5d:5487:0:b0:33d:3ee3:cc0b with SMTP id
 h7-20020a5d5487000000b0033d3ee3cc0bmr5810637wrv.49.1708413493455; 
 Mon, 19 Feb 2024 23:18:13 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 x11-20020adff64b000000b0033d157bb26esm12504553wrp.32.2024.02.19.23.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 23:18:13 -0800 (PST)
Message-ID: <b17649cb-c124-49de-b391-4d3bd88bcb54@linaro.org>
Date: Tue, 20 Feb 2024 08:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/ide: Move IDE device related definitions to
 ide-dev.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240219104912.378211-1-thuth@redhat.com>
 <20240219104912.378211-4-thuth@redhat.com>
 <f89c3710-5bb5-4060-93f0-84024ffd5038@linaro.org>
 <f1ca2012-c01f-48e0-9d3e-e9a7faa8736e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f1ca2012-c01f-48e0-9d3e-e9a7faa8736e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 19/2/24 20:17, Thomas Huth wrote:
> On 19/02/2024 12.32, Philippe Mathieu-Daudé wrote:
>> On 19/2/24 11:49, Thomas Huth wrote:
>>> Let's start to unentangle internal.h by moving public IDE device
>>> related definitions to ide-dev.h.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   include/hw/ide/ide-dev.h  | 145 +++++++++++++++++++++++++++++++++++++-
>>>   include/hw/ide/internal.h | 145 +-------------------------------------
>>>   hw/ide/ide-dev.c          |   1 +
>>>   3 files changed, 146 insertions(+), 145 deletions(-)
>>>
>>> diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
>>> index 7e9663cda9..de88784a25 100644
>>> --- a/include/hw/ide/ide-dev.h
>>> +++ b/include/hw/ide/ide-dev.h
>>> @@ -20,9 +20,152 @@
>>>   #ifndef IDE_DEV_H
>>>   #define IDE_DEV_H
>>> +#include "sysemu/dma.h"
>>
>> Not required.
> 
> It's required for QEMUSGList that is used in struct IDEState.

Oh, OK.

>>>   #include "hw/qdev-properties.h"
>>>   #include "hw/block/block.h"
>>> -#include "hw/ide/internal.h"
>>> +
>>> +typedef struct IDEDevice IDEDevice;
>>> +typedef struct IDEState IDEState;
>>
>>> +typedef struct IDEDMA IDEDMA;
>>> +typedef struct IDEDMAOps IDEDMAOps;
>>> +typedef struct IDEBus IDEBus;
>>
>> Looking at next patches, better forward-declare IDEBus and
>> IDEDMA in "qemu/typedefs.h".
> 
> I really dislike using qemu/typedefs.h for things that are not really 
> part of the core framework, since it's a 
> touch-it-once-and-everything-gets-recompiled header. So IMHO the 
> typedefs here are the lesser evil.

OK then.

>> IDEDMAOps and "sysemu/dma.h" belong to "hw/ide/ide-dma.h.
> 
> Ok, I can move the typedef for IDEDMAOps to ide-dma.h instead.
> 
>   Thomas
> 
> 


