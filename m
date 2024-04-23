Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E667C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 08:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzBN9-00022V-S4; Tue, 23 Apr 2024 04:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzBN8-00022L-Di
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:19:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzBN6-0004zL-IR
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:19:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so3914469f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713860363; x=1714465163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9A0wjJZBfJQ6e2lDQJBykvps6Q3yhpxzhLCGF7sfiO0=;
 b=rnYH3DSaeqDE/CJoAFT6Vls5r7UFCSnPRWlDehtsL1Hs88ejZd3dlN18wRiryXnP1u
 7u1sGJph513feQeI5NogRhqCO9JZILscPmC/zWOq5tUV9hzGfXGQrzNM0+ddtiYqxn4r
 433Ndors7c4ziYgDxNgCoJkI8o2ecE29GZR183WlYcPpN+8QECcA9TS0W2QQGOtw0yHS
 XqjHGZ6nqVYQtvFepB4hJ9QGwdUJUh9prTdhhA+TO6U7Vordms07S+p/Zw/PCX6FmkEM
 jFkGy6EyJ16+iyuBpps8B/p3ElnJhetiaUGrMvL0CslDhc+QFQzpdZKLHE9BmtB5Ky7y
 hNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713860363; x=1714465163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9A0wjJZBfJQ6e2lDQJBykvps6Q3yhpxzhLCGF7sfiO0=;
 b=gTBy0md4W65NNh24w7bHiaSaYAd3Uvx0iNehTuh2/ao5A9H1mZFb4q+ma+y9FP7SBp
 Rm6gYUA01FVT6Uawo8gdQGCbzZmi9RE1yunI2Y+AU4Zxg1JCFfVdb1F4uTqurOO4p/pI
 KDWmX8Il/6mh8BaZcM4uoFTFcLh74UfkFAIwhvXAjGFSC4kLUudBHaqCjlaQ0xsSKtt/
 6XOPgRzKAk104TnBB9W/NqX2Gs6rziyU2p1hC/QUsV/HpJ8L/u/qBBFf8aD6tPCNwtpF
 vUQnbwGiF2Fxb92i/qJDFM3Nm0sFKnZuvF+vewwL9JNFMO6VxvXIi6nMkg1VcunEh6Mr
 JT/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrUf1kf/SohHghurfgSXNKJlrdjur5F9s6IMa9dO9nxuEhvXmLvCIaRjYO0GbUfVZR6LBsseQ4cwRRZaZzQK8ov1wSVWI=
X-Gm-Message-State: AOJu0YyfD3UQ4GhWP3aRG7huNA3/I6qsN7/hTR9IW4xZypIg136IzjJN
 jDQr/05D8CegvRl7HJYLBM6Y/HmkMawrXIsyqiomAPEWUuC87Gp0E2OSjt09o71rw2FTJ6odmOl
 F
X-Google-Smtp-Source: AGHT+IHYV5muvtKLL7ZD83Oc3KsEj7qeK710tYO3s39O1fkhQQLlo4UNQ3V1/5G/jNk+eOv5sf6VHA==
X-Received: by 2002:a05:6000:2a3:b0:346:37ac:2037 with SMTP id
 l3-20020a05600002a300b0034637ac2037mr9314001wry.58.1713860361732; 
 Tue, 23 Apr 2024 01:19:21 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 x5-20020a5d6b45000000b003472489d26fsm13993154wrw.19.2024.04.23.01.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 01:19:21 -0700 (PDT)
Message-ID: <dca95e8b-7d5d-4ab7-9e5d-ad0d9269818f@linaro.org>
Date: Tue, 23 Apr 2024 10:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH intel_iommu 3/7] intel_iommu: make types match
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240422155236.129179-4-clement.mathieu--drif@eviden.com>
 <5acf21ec-216b-4d11-a7c1-ecf9a8ddf76f@linaro.org>
 <2537c79d-60d8-4504-a612-ad5a75e1bd20@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2537c79d-60d8-4504-a612-ad5a75e1bd20@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 23/4/24 07:05, CLEMENT MATHIEU--DRIF wrote:
> 
> On 22/04/2024 19:03, Philippe Mathieu-Daudé wrote:
>> On 22/4/24 17:52, CLEMENT MATHIEU--DRIF wrote:
>>> The 'level' field in vtd_iotlb_key is an uint8_t.
>>> We don't need to store level as an int in vtd_lookup_iotlb
>>>
>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 6f1364b3fd..ba545590b1 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -333,7 +333,7 @@ static VTDIOTLBEntry
>>> *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>>>    {
>>>        struct vtd_iotlb_key key;
>>>        VTDIOTLBEntry *entry;
>>> -    int level;
>>> +    uint8_t level;
>>
>> Or simply 'unsigned' up to vtd_slpt_level_shift()?
> vtd_iotlb_key.level is an uint8_t, just avoiding a warning here

What warning?

