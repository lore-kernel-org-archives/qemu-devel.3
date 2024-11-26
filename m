Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4393CD6554E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0a5-00061E-7L; Tue, 26 Nov 2024 13:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0Zz-0005u8-Dp
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:46:31 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0Zp-0007p8-6T
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:46:29 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-724f1004c79so2673252b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732646779; x=1733251579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOpd5qH5FKDNIIyv/+T3MFR9WErF9xtDaxWzlZNNZ5g=;
 b=UerqMojW265gx9j2MbMt78FlpHzkF/PFDmFAXl6QXLhsBvR29G4stkmC3U3PF8nOe2
 x585puZX2rNz/IogODIpJC5s/VvpaUSOeFDU1mdbe+UeaLUxNLFa1fCuUJQgjTryolFF
 GDQ8YkhYdj1CsOyadInxzsanY/q4fWZyppyMwBIhZhMn7F0R1j84cARbmKvMjKJtGiAh
 xIFHeo7TdULyZLufgJBNwUedtSRPyObrsNP3NchTR1lQ+e4h2UVUw7KOidfIeNAIneUL
 lvhXgfiQJzw0ZYRLkeYMXsCYpnx2dtxlBZrIS3szmGltZVp25iSW0yDTnfhOKqoHzSYf
 ob0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732646779; x=1733251579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOpd5qH5FKDNIIyv/+T3MFR9WErF9xtDaxWzlZNNZ5g=;
 b=blzmgOWKGbSBZqEVGzBsc5AnekBkpSgs8+VYvWM0qH6PVTLJq3PYWb+LBg4GNrUTxl
 KDzVD8E2HYLBfkeDLdzK2gA/3WAU6OsJwZPMrNxfeQKoxiKNNQhYJQPxCoWM6N+rgw87
 t7LegavY0DMdGIYBkJ11oMppT1qv7cBRNHo2rFds9MPH1giB018vb5DDiEmSQ5BOqTUL
 wAUnJIM8ND9sL8K9UknklK44qNvJRDogEQbxQESnZUqSUrnMeT6lMzrgC2SI1lPQ8stW
 lrEQwTfX4Xw1tqYydQEfPuDwiAawNoLQUGglQQBA+netApIYYpRT+tWD9cXCLFqLBiqv
 /sQg==
X-Gm-Message-State: AOJu0Yz1XCec74mYilC1yHP/KPz0gAd5VlHBXcKpwJt2y71NSq/NhgEJ
 Zlq4Jw5Vs3Ro/zZQL/aPQ+UXLavXpRMikQCdqI0uOxOXrksPPiEAsuRkdB2oAC0=
X-Gm-Gg: ASbGncsAk8bCJRjuD64cXRsk4sLxVg+NMjcKOBoPGqkrxj6FLBUzwSyzwF4kFQvJNZj
 NMW53Jfsr3NI/x/lAhTNElgdksMMJr/fH011Q56++MhTYe3sJbEMdVVXXHiKukhekoZ+xUiHZGV
 xLUh/H7iAfY0MlGutdKc2NYbstxpHvYbwb9H9nUqJKZmK1y0rmyV6lRqqd8/4cKTsDeADMXJVM1
 M67cu0oI4mOAMQbiF+YoIILpwD6/+RENtp9U2IhDMPbPmIMn1v+zztZ4XoFZMBZI1VR1WGwuiZS
 cVIj3p+wU0MmPlUCchhy0Q==
X-Google-Smtp-Source: AGHT+IEbmFnweVpN7jJs/qvwQ83rTa7DycOQ4BOpWX4LxHlFTSFZc15SeL547IIIUGbPtZ6r9volfg==
X-Received: by 2002:a05:6a00:889:b0:71d:fe64:e3fa with SMTP id
 d2e1a72fcca58-7253014c84amr208515b3a.19.1732646778002; 
 Tue, 26 Nov 2024 10:46:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de55b4c8sm8762893b3a.164.2024.11.26.10.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 10:46:17 -0800 (PST)
Message-ID: <561761eb-4068-4b09-84ce-56e98dd3d23d@linaro.org>
Date: Tue, 26 Nov 2024 10:46:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] docs/system/arm/virt: document missing properties
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-12-pierrick.bouvier@linaro.org>
 <CAFEAcA8BhxbGH7xD8rpwRq2yG-FCef2yiNc6DWVmPgTFXEbLKA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8BhxbGH7xD8rpwRq2yG-FCef2yiNc6DWVmPgTFXEbLKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/25/24 09:02, Peter Maydell wrote:
> On Fri, 22 Nov 2024 at 22:52, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   docs/bypass-iommu.txt    |  2 ++
>>   docs/system/arm/virt.rst | 15 +++++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
>> index e6677bddd32..62818e44ed9 100644
>> --- a/docs/bypass-iommu.txt
>> +++ b/docs/bypass-iommu.txt
>> @@ -1,3 +1,5 @@
>> +.. _bypass_iommu:
>> +
> 
> This is a .txt file -- adding rST markup to it won't do anything :-)
> 
> (It's one of the remaining legacy .txt files that we haven't
> yet converted to .rst and moved to the right place in the
> documentation. The .txt files in the /docs/ directory are
> mostly the awkward ones to convert because they are a mishmash
> of internal info about the implementation and stuff that is user
> facing, that needs to be pulled apart by somebody with some
> familiarity with the feature and moved into the right places,
> or in some cases simply deleted as unnecessary.)
> 

Oops.
I was very unlucky because it's the only place where I did the mistake 
to use an anonymous link >`_, instead of ref link, so I missed it.
Adding too many rst links is bad for your (mental) health :)

I'll update the bypass_iommu link to refer to the file (upstream) instead.

>>   BYPASS IOMMU PROPERTY
>>   =====================
>>
>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>> index 11ceb898264..d3d21499ff5 100644
>> --- a/docs/system/arm/virt.rst
>> +++ b/docs/system/arm/virt.rst
>> @@ -169,10 +169,17 @@ iommu
>>     ``smmuv3``
>>       Create an SMMUv3
>>
>> +default-bus-bypass-iommu
>> +  Set ``on``/``off`` to enable/disable `bypass_iommu <bypass_iommu>`_ for
>> +  default root bus.
>> +
>>   ras
>>     Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
>>     using ACPI and guest external abort exceptions. The default is off.
>>
>> +acpi
>> +  Set ``on``/``off``/``auto`` to enable/disable ACPI.
>> +
>>   dtb-randomness
>>     Set ``on``/``off`` to pass random seeds via the guest DTB
>>     rng-seed and kaslr-seed nodes (in both "/chosen" and
>> @@ -186,6 +193,14 @@ dtb-randomness
>>   dtb-kaslr-seed
>>     A deprecated synonym for dtb-randomness.
>>
>> +x-oem-id
>> +  Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
>> +  table header.
>> +
>> +x-oem-table-id
>> +  Set string (up to 8 bytes) to override the default value of field OEM Table ID
>> +  in ACPI table header.
> 
> Do we have a policy about whether we should explicitly note that
> x- options are not ABI-stable when we document them?
>

I noticed that x-rme was documented, so took it as an implicit yes.

 From the commit that introduce them [1], it seems to be more a 
workaround than proper experimental options, which is a bit debatable to 
be honest.

If you prefer to not include x-oem-* options, let me know.

[1] 
https://gitlab.com/qemu-project/qemu/-/commit/90a66f48471975fd46f1caab1574679f0a0ef74b

> thanks
> -- PMM


