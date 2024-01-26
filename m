Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA0DC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 17:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTPbC-00028Z-Kr; Fri, 26 Jan 2024 12:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTPb8-0001yK-Bs
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 12:02:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTPb6-0001ev-C6
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 12:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706288550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=msrEboZ+7bRlCCSPb41xhxmS+xPCzGvU3ZZ9wEj1mKE=;
 b=IsCVT1VOe3AdEiLRlG6VU3Lz/1dZ/eYZXHoAlqR44DTQRD5teMVvb8Mq7Z5wERsY/d/Lk3
 Vkqe6Z/zA4e3iQcL7nBwPhEp0H8pmOtTw/YdEVo8hbN4bn0+TxjW/Ke2Y9iMypr9KUVmyi
 xuzhOKuqKV6hmFgydQbX7rKyI9cXbl0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-0QYTgfIAPnSYP8tZa1dENw-1; Fri, 26 Jan 2024 12:02:28 -0500
X-MC-Unique: 0QYTgfIAPnSYP8tZa1dENw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6800a9505ddso8707596d6.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 09:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706288548; x=1706893348;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msrEboZ+7bRlCCSPb41xhxmS+xPCzGvU3ZZ9wEj1mKE=;
 b=R3iVxR/zZkQZnMFLal8BIK10ijQ/3MX31mBSW+eaq6IgdQodTr8sD6gnj25bkitECu
 xWrzKBbaZ+sJ0nTW4Ls583suFj+38qWPNEVjA5kUhuKrOGLpzGU+Lp9znyUxl56VR/KP
 TaxKDzFCefbEDxVZbjJdWbQ7NdB51In6+cIM+rRB56e4lBBJLW/59mq4eqYw1pmZthvH
 JBEs4086vnrTNmFQG7TZV3xTnAFnL+fQ+TcXoTdIBAO1IXL+N8WESD+dfp/SB+Jbp402
 tx0W/HyWvdn1od+dG2qLnEbgAFCekK37z/Vjf87ZTSLfKxtSr+ps38WI0Yoas51HRV26
 PxYQ==
X-Gm-Message-State: AOJu0YwDkzIUdD72Pl3BuCcMaZi+MqXOTJYY1Eosk0pysQ1or4f0f3BW
 uH+6NcTjIil7ZgkL9JAhOvkamN8ZbfXY603J5mWuphOS7ohgxDt1swX2uj789ydMzLhm+ZrAkgf
 EZOK0wwEYz7K/Y6wV9ecx0bylzaP8IB07CXRhriw9C8vcdWRP7DWGXpVjcojQ
X-Received: by 2002:ad4:5f0b:0:b0:686:aba6:5f03 with SMTP id
 fo11-20020ad45f0b000000b00686aba65f03mr173055qvb.20.1706288546191; 
 Fri, 26 Jan 2024 09:02:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERZegVFdKtaO/uxqpopIIEYM/WNnUdXzGWjyQcLayT4zcBKR/wdlfcK137nsSYdk3cIXfTDw==
X-Received: by 2002:ad4:5f0b:0:b0:686:aba6:5f03 with SMTP id
 fo11-20020ad45f0b000000b00686aba65f03mr172971qvb.20.1706288544334; 
 Fri, 26 Jan 2024 09:02:24 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 oo29-20020a056214451d00b0068c373857edsm200931qvb.73.2024.01.26.09.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 09:02:23 -0800 (PST)
Message-ID: <d20632bb-54f7-4f9a-afc4-535bea6f5da2@redhat.com>
Date: Fri, 26 Jan 2024 18:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Move v7m-related code from cpu32.c into a
 separate file
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
References: <20240126084001.879548-1-thuth@redhat.com>
 <20240126084001.879548-2-thuth@redhat.com>
 <17455043-25cf-4978-afdd-147e689a1abd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <17455043-25cf-4978-afdd-147e689a1abd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/01/2024 11.44, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 26/1/24 09:39, Thomas Huth wrote:
>> Move the code to a separate file so that we do not have to compile
>> it anymore if CONFIG_ARM_V7M is not set.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/arm/tcg/cpu-v7m.c   | 292 +++++++++++++++++++++++++++++++++++++
>>   target/arm/tcg/cpu32.c     | 261 ---------------------------------
>>   target/arm/tcg/meson.build |   4 +
>>   3 files changed, 296 insertions(+), 261 deletions(-)
>>   create mode 100644 target/arm/tcg/cpu-v7m.c
>>
>> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
>> new file mode 100644
>> index 0000000000..d61873ab6d
>> --- /dev/null
>> +++ b/target/arm/tcg/cpu-v7m.c
>> @@ -0,0 +1,292 @@
>> +/*
>> + * QEMU ARM V7 TCG-only CPUs.
> 
> s/V7/v7M/

ok

>> + *
>> + * Copyright (c) 2012 SUSE LINUX Products GmbH
>> + *
>> + * This code is licensed under the GNU GPL v2 or later.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "hw/core/tcg-cpu-ops.h"
>> +#include "internals.h"
>> +#include "hw/intc/armv7m_nvic.h"
>> +
>> +/* CPU models. These are not needed for the AArch64 linux-user build. */
>> +#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> 
> Could we do that in meson instead?

I don't think so... (see below)

>> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
>> index 6fca38f2cc..8c7f6b43f3 100644
>> --- a/target/arm/tcg/meson.build
>> +++ b/target/arm/tcg/meson.build
>> @@ -52,6 +52,10 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>>     'sve_helper.c',
>>   ))
>> +arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files(
> 
> -> arm_system_ss

Don't we still need the code for the 32-bit qemu-arm binary? See:

$ ./qemu-arm -cpu help | grep cortex-m
   cortex-m0
   cortex-m3
   cortex-m33
   cortex-m4
   cortex-m55
   cortex-m7

So I don't think we should add this to arm_system_ss only, should we?

  Thomas


>> +  'cpu-v7m.c'
>> +))
> 


