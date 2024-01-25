Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FB9C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 04:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSrkR-0005r8-P1; Wed, 24 Jan 2024 23:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrkQ-0005qz-LQ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:53:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrkO-0000Kd-Qa
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:53:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso73898555e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 20:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706158431; x=1706763231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r3a4oUdmIFuOpwtDNDmo7XjUJiyp+NopVlxi/RgGbxs=;
 b=CHqi30QsWIis5WBlN/AbOYqmh9oUMONnTcoY3kMPW6SCgOmiOt01c10KM7vF7LgRwJ
 M21cl6QMHQ+Zep+tpVF4LRyVuWHOkNBqGg9DzBpHjKZzLDlHJylIXcZzktYjzHBjgCIo
 6ppAQbcKseUNdG77rfz2h6dniV3rPdJBaaiYYAS/Vb+Eo3t88gRDLbIZ3HEct1E9vQqy
 0vYQTbN7YW02b8T/Gg7wbZgqy73x9TJ1DhE6E01+R66JCvkuSJSNcNj3onM0qOJdVHW2
 8cwIDGV4NWv1RPk4dkU91ghk+BS7s18ueNp8H6LBWJYytQZJD76JqTxvPyXKWUgbvhzK
 4+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706158431; x=1706763231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r3a4oUdmIFuOpwtDNDmo7XjUJiyp+NopVlxi/RgGbxs=;
 b=IrvKMjkCr2GOb9QmZxYM2rs2V6qwJV1VkWKaO7h/MfOg57k62pxtws7oyk4A7l0t06
 bZh7cHnKBWeSwKwNpuJwt/e1rDvdpBT7oyxRD6pBZclSuzMFsSC+31meJHKJ8+faWycB
 G2TzVNygIxar5jlCkbA9uaSpfp+Ka4euoEFJ5jLY6yIqShDq3tGDztY7Tw5uL9yvrM41
 XTICBAOltrEGBeqJGjYuQn1k4cwGB9RflvqT/1uZQWiDMcayjJy8qCO+NXhIfg8UFhV9
 cgDX4oK7Mocdhq9PxaJfDCuHkoepytIPmPXPDdNaSBAVTcYlnDJo8TkCnKuIKy+o2QRQ
 XMmQ==
X-Gm-Message-State: AOJu0Yx4DdE/Kqrc+GmGoBa/y74lPn7bANPfMjcAq0jEAETILnXpW+7F
 y6WqQO0q0jwfiUXeKTt90NCgKWi0FTWlbadsSbvK+tlw36a3zeWcx6ceZr+3Fbk=
X-Google-Smtp-Source: AGHT+IHB7KYbBqhPb6vwBkaKGC/jy8An+lwmVxzJsPSOoyFhaIVPRRQCT2R8d7RDIk1tZz3zKcvr/Q==
X-Received: by 2002:a05:600c:30d2:b0:40e:88d4:4479 with SMTP id
 h18-20020a05600c30d200b0040e88d44479mr91461wmn.221.1706158430971; 
 Wed, 24 Jan 2024 20:53:50 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c459400b0040e527602c8sm1108581wmo.9.2024.01.24.20.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 20:53:50 -0800 (PST)
Message-ID: <f9cf4786-45d8-49d7-a7d8-44d177a11bf0@linaro.org>
Date: Thu, 25 Jan 2024 05:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240124075609.14756-1-philmd@linaro.org>
 <20240124075609.14756-5-philmd@linaro.org>
 <3aad97e2-7a2d-4629-bca2-0e5a0f439082@linaro.org>
 <3e32f06d1f4b35c3b5c67434593f466995a38c87.camel@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3e32f06d1f4b35c3b5c67434593f466995a38c87.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/1/24 04:04, Ilya Leoshkevich wrote:
> On Thu, 2024-01-25 at 07:11 +1000, Richard Henderson wrote:
>> On 1/24/24 17:56, Philippe Mathieu-Daudé wrote:
>>> From: Ilya Leoshkevich <iii@linux.ibm.com>
>>>
>>> tcg/ should not depend on accel/tcg/, but perf and debuginfo
>>> support provided by the latter are being used by tcg/tcg.c.
>>>
>>> Since that's the only user, move both to tcg/.
>>>
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Message-ID: <20231208003754.3688038-5-iii@linux.ibm.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    {accel/tcg => tcg}/debuginfo.h | 4 ++--
>>>    {accel/tcg => tcg}/perf.h      | 4 ++--
>>
>> Headers should be in include/tcg/.
>>
>>> --- a/accel/tcg/translate-all.c
>>> +++ b/accel/tcg/translate-all.c
>>> @@ -63,7 +63,7 @@
>>>    #include "tb-context.h"
>>>    #include "internal-common.h"
>>>    #include "internal-target.h"
>>> -#include "perf.h"
>>> +#include "tcg/perf.h"
>>
>> Since it is used from accel/tcg/,
>>
>>>    #include "tcg/insn-start-words.h"
>>>    
>>>    TBContext tb_ctx;
>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>> index e7a9b3775b..b8e52f3fb0 100644
>>> --- a/hw/core/loader.c
>>> +++ b/hw/core/loader.c
>>> @@ -62,7 +62,7 @@
>>>    #include "hw/boards.h"
>>>    #include "qemu/cutils.h"
>>>    #include "sysemu/runstate.h"
>>> -#include "accel/tcg/debuginfo.h"
>>> +#include "tcg/debuginfo.h"
>>
>> ... and hw/core/.
>>
>> Otherwise,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> r~
> 
> Can it be that this is the rebased v3?
> v4 seems to have these issues fixed:
> 
> https://patchew.org/QEMU/20231212003837.64090-1-iii@linux.ibm.com/

Indeed 🤦‍♂️ v6 on the way...

