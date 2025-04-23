Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ACAC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 20:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7gQk-0006DF-QV; Wed, 23 Apr 2025 16:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7gQi-0006AF-Rd
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:10:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7gQg-0006GG-Uh
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:10:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso2865235ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745439045; x=1746043845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GsBZsCm15OTl3aSIzfnAH4eJem3+KOInakLOd+f/fUM=;
 b=ZdoFDtS2X2c+vYkHRFaxZZZXYbIKacAGBo+YQdH79w00iO/WSsf6anE90/CHCI1A+Z
 Sog2Sj517Rw6Wg33Quw9p0mPjFJdae/wRFvShHHN3ZJsu5HBXChccGASFE7Kudc0A69W
 9edFjP7SQWln3dakT3AU3W8Kp7z93KATvSWmQAoFADG17lSR9idxmhFXk8kgy3BiKP8v
 oZNC5bfpiHCmsnnRvY+p5FtWRelgDWuZi56VTtWQORpVfuHRDr2MDCB7pLQKDR+ueMFz
 shsySHOplH8FC3BWQleBworFxsprbiWuCDE55A4o5AC1lVWrL0LgrFr13sMGHWR9Jjof
 70uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745439045; x=1746043845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GsBZsCm15OTl3aSIzfnAH4eJem3+KOInakLOd+f/fUM=;
 b=sNTniay3u8oBVBV76JLpmcMKk46bT7HAlcs420SLrYnwtRgGECqzI/E+DbItd16oIA
 OkEWY0tI+FTHvlhhL/Wjzz4PVKE06QlqP/m2TZJnim+stqip2eFSlst1o2XsiBTC3zwo
 ff51o/9zrKXgqj4KdFqxMFYORSJWgg7ikEtWu63Cd2RmT+ChPL2rvWC6uT+egy+VC5ZJ
 L13I7LzeNQgfeDWJYIoZO15eD75/n/1SOJRaY22hI0PzkkHt9jdba8/nHoaknZtYCj8X
 KoRWelnHFWUYqmRGvPdWWppzRZCsNP8QviDUR3Xfe/a/+MrJxoeKUzTcN3dKJDWU2u0j
 9ZpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDHZezMCjIa7+O3EyiGtnL3I3mik8UZ9fQJgu9EEDVIeQtaF2lzKL/GSLJnMoPv9YxSO5wmGBlOlrH@nongnu.org
X-Gm-Message-State: AOJu0Yw/X6FqTWsGCD5rtbTmmq0fGAbflcI7mpUWj1lksSoainvZbDEM
 zc7Q09ekE9fAgRUw3I6wroshqL4rVpqYx7Y2OYhJxHqiJLhioTzPAiIkm/Q8U/Y=
X-Gm-Gg: ASbGncu2Zc2BnkEn+aFOytUCVDiRXNR/DfJ3OeSnLQ+wwKgvIDpaQ42qktNlIbPn4wH
 l1z8ejNxAEN3d7U+DomgFxGDY8vdhTMNCyD25kPf9OTYwp62mvw3k1aSIs1jiJ4UcIXG1/630pY
 eeuoz5+O3rBj5UtcB0vRQfEsHbcRjaF8x3+uqEWZzy8WbSF7JjlKdsMH80oJo38aR+UpUpzSiR1
 dGSI0dEJtDVto39uuyAPuQENF4YWq1IrIy/PdjdCc1PeQlwY5ZW7bA0aMdziTUraRhSyQRwCSNj
 4Tnu7av1Gb1s+pIuGY63yV+l66zXTf8+2y/SVfn6YWY0ktWpT6nmNA==
X-Google-Smtp-Source: AGHT+IGhPOeh6jXgRsnBXTnzfQAQIJ1LSOVYO2emTRNG83K5vKZi8o33tr+HR8zN1bWS3M4zV28odg==
X-Received: by 2002:a17:903:3d0e:b0:215:bc30:c952 with SMTP id
 d9443c01a7336-22db1a65cb8mr9081045ad.6.1745439044794; 
 Wed, 23 Apr 2025 13:10:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bde206sm109001295ad.14.2025.04.23.13.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 13:10:44 -0700 (PDT)
Message-ID: <b181a62c-c9cf-4d33-b694-b5099069ee79@linaro.org>
Date: Wed, 23 Apr 2025 13:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
 <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
 <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
 <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
 <ee9d6b5e-0a38-4237-aa4e-2aebbe9785d8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ee9d6b5e-0a38-4237-aa4e-2aebbe9785d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/23/25 12:53, Philippe Mathieu-Daudé wrote:
> On 23/4/25 21:33, Pierrick Bouvier wrote:
>> On 4/23/25 12:12, Richard Henderson wrote:
>>>> @Richard:
>>>> Is it a concern regarding code maintenance, or potential impact
>>>> on .data?
>>>
>>> I was thinking of impact on .data, especially with so many.
>>>
>>
>> du qemu-system-aarch64 optimized and stripped (in kB):
>> 31880    upstream
>> 31896    upstream + this series
> 
> FYI same tag as a branch with InterfaceInfo constified:
> https://gitlab.com/philmd/qemu/-/tree/single-binary-hw-arm-rfc-v4-const
> 

Maybe I missed something, but machine interfaces are not const on this 
branch.

>> So we have +16kB which is a size increase of +0.0005%.
>> Even if we project something similar on other architectures (let's say
>> x10), the final impact on binary size should be < 0.005%.
>>
>> Maybe it's a reasonable impact considering the trade off on coherency
>> and readability through the codebase?
>> Else, in case we make this array const, can we expect the linker to
>> deduplicate it? I'm not familiar with how final .data section is assembled.
> 


