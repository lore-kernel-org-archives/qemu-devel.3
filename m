Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88564107BCC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15EQ-00007q-EQ; Fri, 13 Mar 2026 12:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15EB-0008VO-GB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:19:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15E9-0006QA-OB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:19:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2adff872068so11493835ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773418744; x=1774023544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=laxrdpzGTqF+BI1Z2wob3JakeKMSzQ/hqaMxAtt03T0=;
 b=sxQuAEF84jkfF3yMVtwpdqkEGet8jQ4gSHeLVgJqexy731E2d2sALI9tI2TEQzSEUR
 mqVOxBnr8OmQQAGMxk9bXDZEjVQyzO0oS36FudFpKdmGsozgkiFkT1L3OQAQLvnuUyPz
 PPYUMn6eaE9VAebtv/BDsUPXX97Z7egTgmfNeSdu0hHkCFW12Xk3Et2ij6SEpf3Lhp0A
 TyhgMl4ehb5qQrf0otvrV5Ich7CoDrgkcMu9kZmaQwu/F+5R3YeYQ5FgsDWWu3dgRquN
 qAirXJqgNCuQKGIoruyUQW7mhKt71QtpYzsjwXqaXD1A5rVoJ3w0ObqDTuNuK7DSoGJI
 hubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773418744; x=1774023544;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=laxrdpzGTqF+BI1Z2wob3JakeKMSzQ/hqaMxAtt03T0=;
 b=NacGgovSI2c7JBBAe/3jepYAmBEMWIgQgQAz6wEqpcbY5+tV05O4fFiQPlS0R+o1v5
 EzwoKKtrZZUB8eZtKLyvovJHV+X2krkeBVLO9Q9UwmCWYnI94LNBZABbioeZy7vbKZcL
 gNTkI9RzQfckBjT69xHBA6oJxG+JKcF+/upkN4LOT3DOb+0hulrNGWfvTu7O8L7Hqrv5
 LBJuwWPqnEqahFnCAkp6RxGHUJ6Uu9hmkZxf/3tFP6rb0Z7WrM4+65UD/g2zwhyqb8wv
 BX4sLe37M6yrZNzDq1C2jgug0OuGntlzjsrnovqSpEwtuHbA28cHjegcnPudQNp5Dm00
 HEHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm8cwlVKwBqJcd6DwLtR7pTUK3YifJV4nq9pRcpopBFJu4ryId3JlJw2So/u1Nupoa9lwh3xWkFIcn@nongnu.org
X-Gm-Message-State: AOJu0Yw0ERtaCwxS/OMDaECTnt/TQ3wBNZNwfejooIigacC8pBhush9j
 nGxpNwnlPrjImAYEQwe8Y6N3Zkv5gu/X/tFRUX4o9uZBDWwfrsCCsUXu4uG4Em6XMSw=
X-Gm-Gg: ATEYQzzosvrHTdKPpUEmI+qzx+W2Gg3YqDe+Lsz+JOJWUdefCSUb0RuEcdjhAtcjzYH
 EQ3jQDwQUSNHEHZInc8o+PNNHOADukQttu7XgXzxVJk6UeGHEN//O68M3j5U22yqMDvzuY34wj6
 PbIJJJSmvCzvbd0nSDlRjLaD98jiCRvYHbB1SW2dfcb+aqB9FnLuOzxQeUTEhxGdgq2a+8GTdXF
 JTqkVHqJXpMZmPWYrfHnTe1FY9SXdtrz9qH+YjUGo9Nqhh+iENuGiDGD+9PeDLgu0wCyJ+LoW58
 DLayi5QiQMKj+5RDV4qU4TkMt6A9+KTboff1tXrmJ5QKPs9e+9GGyhvz+uLJ1h+mz5dpNkDLSTH
 FQQ395G3DxQ2I8XMnx6IeVWFy26Z4qcI5xkzsUUtoEJkW2GrkqUd1ZZyohfsw1arGKu/Jp/nfR3
 5f//tA31BSr1/9LHsSi9xpcKe92Qhn330YPx/lqS9c4EwuYXjUUxCsmqSO3WqFn3g1E7ni
X-Received: by 2002:a17:903:1249:b0:2ae:a928:f544 with SMTP id
 d9443c01a7336-2aecaab004cmr38108725ad.45.1773418743971; 
 Fri, 13 Mar 2026 09:19:03 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece56cde9sm32171455ad.15.2026.03.13.09.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:19:03 -0700 (PDT)
Message-ID: <ffbf35fd-6da2-4f12-a85c-62257e3ba10d@linaro.org>
Date: Fri, 13 Mar 2026 09:19:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-6-pierrick.bouvier@linaro.org>
 <19aa7756-f142-48aa-bb12-15bf6893c58b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <19aa7756-f142-48aa-bb12-15bf6893c58b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 8:24 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:44, Pierrick Bouvier wrote:
>> We just need to add kvm_enabled() guard on concerned functions, but no
>> need to extract those kvm functions since they are not using any kvm
>> specific types that would not be visible at compilation time.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/vfio/pci.c | 26 +++++++++++++-------------
>>    1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index df617f1fe46..62c52407cf9 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -152,7 +152,10 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>>    
>>    static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>    {
>> -#ifdef CONFIG_KVM
>> +    if (!kvm_enabled()) {
> 
> I'd rather this check done in callers, and here assert on entry:
> 
>          assert(kvm_enabled());
> 
> (Applies to other changes in this patch).
> 
> But this "call KVM-specific helper even if KVM isn't used" pattern
> is pre-existing, so can be done later:
>

Indeed, I followed the existing convention.
But over all, it's safer, and would allow to implement the stubs as 
g_assert_not_reached(), so I'll do the change.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +        return true;
>> +    }
> 

