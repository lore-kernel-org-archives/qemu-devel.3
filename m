Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C94DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFweN-00083U-SB; Fri, 16 May 2025 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFweJ-0007tw-5T
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFweH-0004Tx-3C
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747408012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZlA5taBcWuTUlcTHbDZ2brEjJ3OT39Tk/E56+EU50j4=;
 b=ex3THqLC6iSjWZW0xaFKyae7P7Qjyb59/1XgrbZJouH/fpKtFqLBEOyeCT49qCOLftILua
 i5FpSG6Ul7IUIpLH553mI2pT7OIfF+OkwOd9G78Cbj2bMiVFWUJB8GRMiKJ1+mMdNoDmhN
 QFPVWV7mTD+i1HGJSVL6u94urvi1J9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-PC4eTX-ZOMuB2H4nuVa9BA-1; Fri, 16 May 2025 11:06:51 -0400
X-MC-Unique: PC4eTX-ZOMuB2H4nuVa9BA-1
X-Mimecast-MFC-AGG-ID: PC4eTX-ZOMuB2H4nuVa9BA_1747408010
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so16004195e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747408010; x=1748012810;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlA5taBcWuTUlcTHbDZ2brEjJ3OT39Tk/E56+EU50j4=;
 b=fvt90YOOR5UKlZ0u8pyHkWLeE0lV35+YLZ1y6OoZWFJRAIKwUlw7HpbOOu/rMpbw1J
 u6H/Z6U0eZYItcdF+9O0n00KK3G/kEVzogxQDIuM5LvEJY1lEBRYXhjO4RbJTH+lLCRb
 7I5dP3gmk7Xu5sUd4zNHD4iUGrsS2AdsFfTcb1jYLy1kbU36xCfHRxCdTI8bKVLMcDMB
 oEj9dMlm47iY7BYvcarDdoN1vRLnFI//KyN+bEHcDaoP91dKi1O1Q3mnkQhDxUEyupcU
 Mt1pQ0M8vnb+79qnKTNDzC15+KgqMA6srb7DF/jUjU4mQd2UvB8PnHvIwtkWXvxUyACk
 nHUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd6vKGVCwid9dLtPsI5DWPBTCinF/MzusVsOd7SvdhsUhVyWylHyYZNdMUDwV4ckolneZQ8I7r7MLZ@nongnu.org
X-Gm-Message-State: AOJu0YyszF+iHDAvkh2cKjSFN8+oBb67KUSgY39Ok1U3fwxnR1wY972o
 IOdsIs429AXvdWJCh9pTUCALUWdzDhsJf6Ew1MTeLKyw2/cF0nUE30q4SF36/YEjHe31OeQtXxp
 mC9ohm5oV7g8ekmv+tb3WntmfkE+UMvIv5MlNHmomJ4yLFUBoa8nJuffJ
X-Gm-Gg: ASbGncs5vjlEyxc7MnQ4z6NT8/tsKj9NrHVh6xloB823SKAlg8j6QJB8GISNy0e3SXc
 C73+UMLG3eBe59lrCpNypsiQ5BF9X85VzkFVGkY2nP4c/WR8glcdKLXY+mcuihtPGVIw0AfoC7H
 GhD7dxe1TZXU1Dkh7JLmoapHR26nv9bZ9Ihg9Og9P2Iire+ayfKf71rZiA//vX7XkkijIeVQMPB
 XPXFHAhiLaerYSGB5MY5qaoXdkxR509Ar4J85uqP1TxjQLwtoCZp1PVk85cknbvUbV0uPnJFcz+
 7Ua/qAzdpUM4gfxD/lSyppzKF2qkvMtuxUUeyfJeEDU=
X-Received: by 2002:a05:600c:a0b:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-442ff03c666mr24280905e9.33.1747408009201; 
 Fri, 16 May 2025 08:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ12dEAl6PPp44ZpxS3OcdlNiM9UYoOtTtdWlfqc+oKfqnA4k3dCVcdp4RSq9369185grevQ==
X-Received: by 2002:a05:600c:a0b:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-442ff03c666mr24279655e9.33.1747408008178; 
 Fri, 16 May 2025 08:06:48 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59704esm36662495e9.36.2025.05.16.08.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 08:06:47 -0700 (PDT)
Message-ID: <9b75c7a1-b9c1-47cf-b421-0779fad23e5a@redhat.com>
Date: Fri, 16 May 2025 17:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of
 ml605 and xlnx-zynqmp-pmu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-4-thuth@redhat.com>
 <d5dbb421-83bc-4ac9-9a88-953ec0f97735@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d5dbb421-83bc-4ac9-9a88-953ec0f97735@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/05/2025 17.00, Philippe Mathieu-Daudé wrote:
> On 15/5/25 15:20, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Both machines were added with little-endian in mind only (the
>> "endianness" CPU property was hard-wired to "true", see commits
>> 133d23b3ad1 and a88bbb006a52), so the variants that showed up
>> on the big endian target likely never worked. We deprecated these
>> non-working machine variants two releases ago, and so far nobody
>> complained, so it should be fine now to disable them. Hard-wire
>> the machines to little endian now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/about/deprecated.rst           |  6 ------
>>   docs/about/removed-features.rst     |  9 +++++++++
>>   hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
>>   hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
>>   4 files changed, 14 insertions(+), 23 deletions(-)
> 
> \o/
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

> I won't be able to look at the rest of this series until in 10 days,
> feel free to merge if necessary.

Maybe you could at least provide a quick comment on the idea of controlling 
the endianness of the s3adsp1800 machine via a machine property? (since your 
original idea was to do it via different machine names instead ... does the 
property sound acceptable to you?)

  Thomas


