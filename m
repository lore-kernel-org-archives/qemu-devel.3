Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90602C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 13:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7bEH-0001IT-8O; Thu, 16 May 2024 09:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7bEF-0001IJ-CK
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:33:03 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7bEA-0007rJ-HC
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:33:03 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so3367058a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715866376; x=1716471176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VHCSeImx75FWyBGS+IfbAKi6W9tbuEelFzVtn7xHxCA=;
 b=mKYmqGyTZEwBqLHYP5lqeTmIWao69sKoCIJUKuJPDELwqX0KJJsNJPYo9UVNn3ncyN
 GLe7whTfWSrmcfS/iuiGyM9ZNk8Y/weTZAHrT4fjM1hnbI/HV3uwBo1jIkYCCKk7BW+v
 LvsnoEH3tXqIMNy86oPy9pxxNV0+nBQqo5+Yk2gI78D1FYKc5XCYnzmdvMr24dmC2MSb
 iwKekIfYeT2pM2+9zBIa4au3FKJIGL5+sofYpV2tIP8Zh+sUpppBgrfuCoVT30oaKiGA
 g2/A6/li6DES9xp/UHkVDvQI59T24WZpRemACA5MBT58e1gRDaKHLmjuS7AwBxia546X
 P8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715866376; x=1716471176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHCSeImx75FWyBGS+IfbAKi6W9tbuEelFzVtn7xHxCA=;
 b=d2GoNkbyGuGzXjc5UWI0Pqgu5OPCG7VcBhIgRVEHO6G1F6M19xnEN8BmuRI5VF0S2v
 QNZa54cvwEYg7HNR/y1AjspP6AqAIkQiY70nQJOBb0I3PXF0H5geV14grTFyPr0lrg2i
 zSt2HyL9ZqWURROQPowU++guwLzX+ikiILP1moc1epfzZjaISruREBTH7eoblTDJseu7
 MYjM3jq075LZIB2L4A7pQFrDlBLrD5UeEgLz1UxSy75V55ijKNhyTrM4CKPWfSqeMJE3
 nDcTbTBWZ0e+BTbO8imcBeQdY6EMN+3MJkcYpJ100WaB72JpmT4wqqosDnIa1wP+GY2L
 Mvig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmiBO9U7AtFMA8TaaxXM52AW85UXGLPXUY7NKCUadiiYwQAoLssKaVYv68W03CvN0aXNEKWkFM2FXY/xkpEGhtX7xBMRk=
X-Gm-Message-State: AOJu0YzuQKnelV3jGnXel5bQ/yqTqCRLIKHF0+X8CKXzcjo0vtYbdX53
 yFp7HwomWDQwHFa3etOlOWVxaEPmgUvAPyImftP2rqlAwdN/EYTjk7oPgLUxeLaccZYYPSAqMX+
 t
X-Google-Smtp-Source: AGHT+IEjXC0VlP9HgbVBbgzdJFFnrqp36WDR5N2c/d01YG041Gu7dr5yzVuT9pNQ8v1uyD2JmFK1cA==
X-Received: by 2002:a50:9993:0:b0:571:bed1:3a36 with SMTP id
 4fb4d7f45d1cf-5734d707663mr19265792a12.38.1715866376483; 
 Thu, 16 May 2024 06:32:56 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea651asm10414493a12.11.2024.05.16.06.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 06:32:56 -0700 (PDT)
Message-ID: <beacd542-9f82-4470-9bbb-75d5773e4820@linaro.org>
Date: Thu, 16 May 2024 15:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] ppc64: Fix <sys/user.h> include order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-2-richard.henderson@linaro.org>
 <e24b2563-b2cf-407e-a4b3-e0c5ef847ef4@linaro.org>
 <7af9d602-8252-4e94-b34b-a194f1f5e9ae@linaro.org>
 <cd4fff5b-809a-46dd-85b5-5b4d6b5b7573@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cd4fff5b-809a-46dd-85b5-5b4d6b5b7573@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

On 5/15/24 18:55, Philippe Mathieu-Daudé wrote:
> On 15/5/24 15:53, Richard Henderson wrote:
>> On 5/15/24 15:11, Philippe Mathieu-Daudé wrote:
>>> Hi Richard,
>>>
>>> On 11/5/24 13:53, Richard Henderson wrote:
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   risu_ppc64.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/risu_ppc64.c b/risu_ppc64.c
>>>> index 9df8d58..62cf6aa 100644
>>>> --- a/risu_ppc64.c
>>>> +++ b/risu_ppc64.c
>>>> @@ -11,9 +11,8 @@
>>>>    *     based on Peter Maydell's risu_arm.c
>>>> *****************************************************************************/
>>>> -#include <sys/user.h>
>>>> -
>>>>   #include "risu.h"
>>>> +#include <sys/user.h>
>>>
>>> What is fixed exactly?
>>
>> I don't remember (patch dated in 2022).
>> It is probably a #define namespace issue with cfarm hosts running Centos 7.9?
>> I suppose I should investigate, and drop it if irrelevant.
> 
> It was just out of curiosity (I had a quick look at the headers
> and couldn't see anything obvious, and other headers also include
> system headers before "risu.h").

Root cause: <sys/user.h> is not self-contained on centos 7.7:

In file included from risu_ppc64.c:14:
/usr/include/sys/user.h:27:9: error: unknown type name ‘size_t’
    27 |         size_t          u_tsize;                /* text size (pages) */
       |         ^~~~~~

I'll update the commit message.


r~


