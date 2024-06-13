Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AE4C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 12:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHjXJ-00039x-AS; Thu, 13 Jun 2024 08:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHjXF-00039L-8b
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:26:33 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHjX5-0006xE-Gx
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:26:25 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e95a75a90eso9305871fa.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718281581; x=1718886381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=giCHOHNsy3BfGKL+Sh9AjXY1j8duQRjVND9kW7j4Nck=;
 b=mQ1vT6lRge5aJGU4sOZFox8hzsAwlE1oBQlU40HXLOXkpxpy0tiqzTdTlmAmENtB1A
 2EnPAQPjCSnhhdKU7vD6++P6oCn0uSWgVKMRfOYhPnEAQXL4K583M2iyhqY0umrB7ITm
 okhyS7/ttA0/UNOpRvCwTk+aGnkAFfU5E8skfB/5a/WHL5ukjGvhdwu2SXL7+geZGhVs
 pjvd/p9US+5XSMqCTmHZ/MA4gY4yUS8Ov7H7UqQahCkoEyvsWVO7iUhvTBVfHIwiKAEx
 /JPrWGbK7PO9fs9sm0OkOVpAgymOx/p/PbNKMZSM72/BloaHEeEtblkJ8fpnZAH8CpQE
 jnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718281581; x=1718886381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=giCHOHNsy3BfGKL+Sh9AjXY1j8duQRjVND9kW7j4Nck=;
 b=xD7mtWz7XkK4lJng76va92IXoLZNu4W2gvDGzbfSytLpZnI6jvQXHpc2B8HYrCrBfI
 HK+hPyA7bLaW+scrI8ibq8Ky0qbvAxOxR6joYZav3F4D6Jh81QnEAr1ZM88pOzaQkGmG
 rJnPt0IJmxtSONxRDKyADKub59nfLtiPvlgBz1xC24pUiMoCdIa3qweTuykyGB2DZCQg
 w/v+wlxzZgq6sb0Zn8TrUcA0Kis4H6FQIwRj0tOI5LBh06nVQyLHV6Ye5vt/2bLVSzQo
 /ikhkq2SfOtQb+0tCSFf1DSur/DjXT4YeWgr9ZQFHoNekLMZQIX4aMTXS+vz0CMBRUdp
 tKUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvXp/SiRWSyq5a7E3vV7ZTiRyRj8hqp0ruLEHwBRbJsfD2147riOamlDHqpsMididmJW6/YL6XjY1X7RSA/csSNb6U158=
X-Gm-Message-State: AOJu0Yy25AM/j4dDYcKFVn+NljP6V7PfJTqV5h8Z0AM15hufVJhVuuF/
 JlyDCJ6Gn3nLUnbudQYWJpkux+cS65x+niYvNAaqQ+ZNGQwA4t/UD7FYcSBBmxM=
X-Google-Smtp-Source: AGHT+IE9dJhFwlrzcCgiiKV+WujnCnD8SzSnkYBqSYmwXH78uT6dMac+8uVTFvugGE/cFbFnFXldjg==
X-Received: by 2002:a2e:bc0e:0:b0:2eb:ebc1:f20a with SMTP id
 38308e7fff4ca-2ebfc8d622amr36076441fa.20.1718281581150; 
 Thu, 13 Jun 2024 05:26:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f61277fesm24678805e9.21.2024.06.13.05.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 05:26:20 -0700 (PDT)
Message-ID: <9a8380ac-0b68-49b0-9da2-348873674131@linaro.org>
Date: Thu, 13 Jun 2024 14:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240610062105.49848-1-philmd@linaro.org>
 <cd48f836-3017-4559-b509-9945d041a327@kaod.org>
 <c44dcf6c-3e99-4a32-888d-3c7dfc305a01@linaro.org>
 <2e9ad035-06bb-41e4-bdce-1256e4c17d46@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2e9ad035-06bb-41e4-bdce-1256e4c17d46@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 13/6/24 12:29, Cédric Le Goater wrote:
> On 6/13/24 11:48 AM, Philippe Mathieu-Daudé wrote:
>> On 10/6/24 10:19, Cédric Le Goater wrote:
>>> On 6/10/24 8:20 AM, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> This series remove uses of Monitor in hw/ppc/,
>>>> replacing by the more generic HumanReadableText.
>>>> Care is taken to keep the commit bisectables by
>>>> updating functions one by one, also easing review.
>>>
>>> Did you do any testing ? POWER[8-10] CPUs on pseries and powernv 
>>> machines
>>> should be checked. A bit tedious I agree but not that long.
>>
>> I ran these smoke tests comparing monitor output with baseline:
>>
>> $ ./qemu-system-ppc64 -M powernv8 -S -monitor stdio
>> QEMU 9.0.50 monitor - type 'help' for more information
>> (qemu) info pic
>> CPU 0 XIRR=00000000 (0x0) PP=ff MFRR=ff
>> ICS 1000..1005 0x14c03d9c0
>>    1000 LSI ff 00
>>    1001 LSI ff 00
>>    1002 LSI ff 00
>>    1003 LSI ff 00
>>    1004 LSI ff 00
>>    1005 LSI ff 00
>> ICS    0.. 7ff 0x14c0e93e8
>> ICS    0..   7 0x14c0e9328
>>       0 LSI ff 00
>>       1 LSI ff 00
>>       2 LSI ff 00
>>       3 LSI ff 00
>>       4 LSI ff 00
>>       5 LSI ff 00
>>       6 LSI ff 00
>>       7 LSI ff 00
>> ICS    0.. 7ff 0x14c16ffe8
>> ICS    0..   7 0x14c16ff28
>>       0 LSI ff 00
>>       1 LSI ff 00
>>       2 LSI ff 00
>>       3 LSI ff 00
>>       4 LSI ff 00
>>       5 LSI ff 00
>>       6 LSI ff 00
>>       7 LSI ff 00
>> ICS    0.. 7ff 0x14c2177e8
>> ICS    0..   7 0x14c217728
>>       0 LSI ff 00
>>       1 LSI ff 00
>>       2 LSI ff 00
>>       3 LSI ff 00
>>       4 LSI ff 00
>>       5 LSI ff 00
>>       6 LSI ff 00
>>       7 LSI ff 00
>> Interrupt controller information not available for 
>> power8_v2.0-powerpc64-cpu.
> 
> This is only checking the older interrupt controller. Please try powernv10.
> 
>> (qemu) q
>>
>> $ ./qemu-system-ppc64 -M pseries -cpu power10 -S -monitor stdio
>> QEMU 9.0.50 monitor - type 'help' for more information
>> qemu-system-ppc64: warning: TCG doesn't support requested feature, 
>> cap-cfpc=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature, 
>> cap-sbbc=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature, 
>> cap-ibs=workaround
>> qemu-system-ppc64: warning: TCG doesn't support requested feature, 
>> cap-ccf-assist=on
>> (qemu) info pic
>> CPU 0 XIRR=00000000 (0x0) PP=ff MFRR=ff
>> ICS 1000..1fff 0x600003b05b00
>>    1000 MSI ff 00
>>    1001 MSI ff 00
>>    1100 MSI ff 00
>>    1101 MSI ff 00
>>    1102 MSI ff 00
>>    1103 MSI ff 00
>>    1200 LSI ff 00
>>    1201 LSI ff 00
>>    1202 LSI ff 00
>>    1203 LSI ff 00
>> irqchip: emulated
>> Interrupt controller information not available for 
>> power10_v2.0-powerpc64-cpu.
>> (qemu) q
> 
> 
> This is only checking the old interrupt controller. Please try :
> 
>    qemu-system-ppc64 -M pseries,ic-mode=xive -cpu power10 -S -monitor stdio
> 
> and we should be fine.

No change in output:

$ ./qemu-system-ppc64 -M pseries,ic-mode=xive -cpu power10 -S -monitor 
stdio
QEMU 9.0.50 monitor - type 'help' for more information
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-ibs=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-ccf-assist=on
(qemu) info pic
CPU[0000]:   QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2
CPU[0000]: USER    00   00  00    00   00  00  00   00  00000000
CPU[0000]:   OS    00   00  00    ff   ff  00  ff   ff  80000400
CPU[0000]: POOL    00   00  00    00   00  00  00   00  00000000
CPU[0000]: PHYS    00   00  00    00   00  00  00   ff  00000000
   LISN         PQ    EISN     CPU/PRIO EQ
   00000000 MSI -Q  M 00000000
   00001000 MSI -Q  M 00000000
   00001001 MSI -Q  M 00000000
   00001100 MSI -Q  M 00000000
   00001101 MSI -Q  M 00000000
   00001102 MSI -Q  M 00000000
   00001103 MSI -Q  M 00000000
   00001200 LSI -Q  M 00000000
   00001201 LSI -Q  M 00000000
   00001202 LSI -Q  M 00000000
   00001203 LSI -Q  M 00000000
irqchip: emulated
Interrupt controller information not available for 
power10_v2.0-powerpc64-cpu.
(qemu)


