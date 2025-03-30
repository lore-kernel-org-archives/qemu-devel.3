Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFC2C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 08:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tynzE-0002z3-0L; Sun, 30 Mar 2025 04:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tynzC-0002yc-TS
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:25:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tynzB-0004DD-7g
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:25:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso34109485e9.1
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743323139; x=1743927939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AcYIndhl14cmw23q+DOBnpn4QIlK83HGn3hyGxMylyc=;
 b=UWEEtY2ZppKhxde1OdjkeQeO7guBVpKEhRI5fsCDv7/EqjLcV1eeZGGCPLr2Gd58jH
 +cfBCdwlSkcz7QhRZhavWuviKSyEItNV4nBjGW49LhJdE8VKI2ChtiK9R3wkWMxTsY96
 sNILmQsHmXmZDfZT6bXxbNjq0yZPCVgT4V/JLr7kYjdJO+ft1OisAu6KaunzmTEbBK2U
 RNkXrAHQRCoTwUGXztSAcL8qs5f4NbuQtKS9bg9cLbKl1YYudR3khUAjEYy8J5FQW+nK
 JHJD3khiPxfTN+lizJxUoWY9wTIfA7QjRrykTu+7FRpyjTtpJ+riodRZyvm/KNL6sakz
 AAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743323139; x=1743927939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AcYIndhl14cmw23q+DOBnpn4QIlK83HGn3hyGxMylyc=;
 b=qqOIG1hBSY5Ca/YK0nFiFAjEdS2PcsqC2noc20GYxQJtKLjGBmwhaBilMjeM55pi62
 zV1mPtEcVLGWLfDR8RfZkoD4xfUCjmRGDAa9PRbi4dIez4XqRjsMsFaFF2MPC5Gu4rD5
 HwemMemFxU5s9eo7GR3eQYU99W2H798QhIL4oEJMaDApO03/xnqS9+Urz4w9FNJBDinK
 GDz6CTZswFcvdUHvQywb8t9WkoRyWsJEn63ZbLFP8pczNgweL4lctO+nM3tbUcf4fUFy
 u86DtstM0J3io02vFCAi5S5VMWUo5Y4rBQ/b8nB4TWsFfAM6249wpHtfUXXurpvxQiBq
 C51Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbF6T4lrJMNDqm5fM3TABnX2UilmtqjQ8d/uQTtmOJ/Cy88hHBPrGdttLnKUVKQ288SQd69E5u9SFX@nongnu.org
X-Gm-Message-State: AOJu0Yy1ESkL656Mk1LhtBVefay3Iu8nfKyX/iJu2s61aSWYAT0gWlcI
 9+CQWJWC1aq209wvNCvgdMCVAFq+FxsGe8X+3lpCUcfVNZa7+weA91+14zXVtos=
X-Gm-Gg: ASbGncvICi+I6RR89FQ+NAfnNpoC4wTdR8iqaDJizT3Sb+4n2y1JwJ8fEOSTS/Co2bq
 r1okSi8ESBLLoq8xYZmV7gxWoQA+VxARUnZ80onxm9IsdBrcbufexGbFpXtfUbEBzJ590qmHF2s
 WrbgGru7e89NXt//zO1hLr3MyG+6VJ30av9mgOT6OAwSmJuusbWlhxj7dnmK6/pg52GtJgTukW7
 LrCV32OrBvQlLJqNgrnjKVJ1f1rMObxCqa/4OqnUHgMHLh7SSFh+y/qyebqzuPyJBUsf1jCHorU
 gmJotVJIDLdjEN8s5ueGtloA6ulMaXW+OvM9Z9r6zqUL/OMXdtIisJ2eImIecDzSr0kB9azdjKy
 tFT8=
X-Google-Smtp-Source: AGHT+IHe+y3Ztuy4v1H86YIezz8B5wo87c+zBoOHzm36A/SO3bUdFHDTysx/YSidoK0yEQ5XOBZ8bQ==
X-Received: by 2002:a05:600c:16c4:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-43ddccbfe45mr32952945e9.12.1743323139476; 
 Sun, 30 Mar 2025 01:25:39 -0700 (PDT)
Received: from [10.155.70.213] (63.170.88.92.rev.sfr.net. [92.88.170.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000a09sm84312955e9.35.2025.03.30.01.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 01:25:38 -0700 (PDT)
Message-ID: <eec76ce0-c3ca-48ed-befe-e0930d4a39d9@linaro.org>
Date: Sun, 30 Mar 2025 10:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] include/exec: fix assert in size_memop
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-2-alex.bennee@linaro.org>
 <4fbe53ce-047e-4efc-a0a6-f59342e1f3ea@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4fbe53ce-047e-4efc-a0a6-f59342e1f3ea@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 29/3/25 08:51, Akihiko Odaki wrote:
> On 2025/03/24 19:21, Alex Bennée wrote:
>> We can handle larger sized memops now, expand the range of the assert.
>>
>> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>    - instead of 128 use 1 << MO_SIZE for future proofing
>> ---
>>   include/exec/memop.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/exec/memop.h b/include/exec/memop.h
>> index 407a47d82c..6afe50a7d0 100644
>> --- a/include/exec/memop.h
>> +++ b/include/exec/memop.h
>> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>>   static inline MemOp size_memop(unsigned size)
>>   {
>>   #ifdef CONFIG_DEBUG_TCG
>> -    /* Power of 2 up to 8.  */
>> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
>> +    /* Power of 2 up to 128.  */
> 
> It may be better to avoid writing the literal number (128) in the 
> comment too.
> 
> Perhaps it is easier to simply remove the comment instead of updating it 
> to explain the assertion without the literal number.
> (size & (size - 1)) == 0 looks cryptic, but it can be replaced with 
> is_power_of_2(), which is more obvious and will not need an explanation.

+1 for is_power_of_2()

> 
> Regards,
> Akihiko Odaki
> 
>> +    assert((size & (size - 1)) == 0 && size >= 1 && size <= (1 << 
>> MO_SIZE));
>>   #endif
>>       return (MemOp)ctz32(size);
>>   }
> 


