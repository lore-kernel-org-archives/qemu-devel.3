Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C8D42BAF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuOO-0007Q7-AV; Tue, 12 Nov 2024 12:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuOG-0007DF-FE
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:09:21 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuOE-0002I8-1e
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:09:20 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa1f1f2d508so14356066b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731431350; x=1732036150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DXASbETSb82QL2+dQcsQo12SIa2OEz+NYoPmnWeJwtA=;
 b=fH/6aTKMvxWMJh7O0olNz9b4jKG+49XDXJ0pIkJh23f9a+acFrvi4otxOD6nfq/zM0
 1QBtNJmfZOituLsVYTw3gGORy4mIJRlhYYZt0p7JBfS8JaBHTomrUj0qOC2/8jOBFNHJ
 4DKEgXJaPydQGdN7E38M6wo1buFN3u8e5pMYvyONvnKePocBgKvxWyLir567F0XNMQDY
 ILh+juBxlwb2490DTzNAI5xpyU9bcfegBxiHWoWdGOnkRIPlKS5o+xGdDGZ+51g+zkfo
 bpQLqUQfpiOAQ8mDzITj5HOz7vxgB+vf0VZWhZucF95ktJ8r342s/mqm96G/ysh0iIvA
 khmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731431350; x=1732036150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DXASbETSb82QL2+dQcsQo12SIa2OEz+NYoPmnWeJwtA=;
 b=lp3YMFULuKLnnNicdEng4BW1zERamUWHQJPEFpttdSavunuB1nwjDqb2fG+SxaIN7q
 R5qyeu9XIetLiBTDlZhbzovJ9Dx7RgweAGogr0qOGK0g+FCF9Urowqmi3J+Rd+Nqq+8G
 szNZ3c8VqW3qH0FbOms5kkMhi6XM87dKpSW4Xcphmq0esv4Oga09mLxQKWGvHo9h6KJP
 mUCQ9YOzrZx1bJrx4i0+gPY1MhfjNBqLjN7H4FHlWhxqaKmwbFZIm/tox4LrSLPc2mah
 bBjDKDcvIA3QHzHkxiHbM3I/rmMgQyWJKKa7F9UC8vO+YILzLmqdPqH3lIShtfj4yZXG
 ZdpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrakdrplM0w0ySnVHpZwDDZOh7ht/fKoTokS/yX5qR6YSrCEbRWpV9GDRfDz9sdxm+p8tWFqFp7Ofd@nongnu.org
X-Gm-Message-State: AOJu0YwQUHK7LW6XY0E7kct2sERRmkjpZz0/LRyKL7bIRp2Crz5iG9Ly
 WZS7GwwjyKDRRuWFfocV1CcreruBGmfob33AkRgcjr2l4p6lQVL4QFaPfNCSnAM=
X-Google-Smtp-Source: AGHT+IGqmpJQSvxaMMj41OZzFx9Bfw3xyy8QBi5MK8GJ9CsUg7PAkEy6Tle+C+6nJ52VW7XIpfAvKQ==
X-Received: by 2002:a17:907:2d11:b0:a9a:161:8da4 with SMTP id
 a640c23a62f3a-a9ef004b241mr1770655566b.55.1731431349700; 
 Tue, 12 Nov 2024 09:09:09 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr.
 [176.184.27.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0abe369sm736216366b.83.2024.11.12.09.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 09:09:09 -0800 (PST)
Message-ID: <ac2bd629-4d3c-4f8f-9315-a16161b4b2c2@linaro.org>
Date: Tue, 12 Nov 2024 18:09:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/mips: Convert nanoMIPS LSA opcode to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
References: <20241111224452.61276-1-philmd@linaro.org>
 <20241111224452.61276-3-philmd@linaro.org>
 <a014d0a3-6692-41b1-84e0-6da07ed1e58b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a014d0a3-6692-41b1-84e0-6da07ed1e58b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 12/11/24 14:30, Richard Henderson wrote:
> On 11/11/24 14:44, Philippe Mathieu-Daudé wrote:
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Simply call the generic gen_lsa() helper, taking care
>> to substract 1 to the shift field.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/nanomips32.decode        |  8 ++++++++
>>   target/mips/tcg/nanomips_translate.c     | 12 ++++++++++++
>>   target/mips/tcg/nanomips_translate.c.inc |  9 ---------
>>   3 files changed, 20 insertions(+), 9 deletions(-)


>> diff --git a/target/mips/tcg/nanomips_translate.c 
>> b/target/mips/tcg/nanomips_translate.c
>> index c148c13ed9..9a6db4a828 100644
>> --- a/target/mips/tcg/nanomips_translate.c
>> +++ b/target/mips/tcg/nanomips_translate.c
>> @@ -9,6 +9,18 @@
>>   #include "qemu/osdep.h"
>>   #include "translate.h"
>> +static inline int minus_1(DisasContext *ctx, int x)
>> +{
>> +    return x - 1;
>> +}
>> +
>>   /* Include the auto-generated decoders.  */
>>   #include "decode-nanomips16.c.inc"
>>   #include "decode-nanomips32.c.inc"
>> +
>> +static bool trans_LSA(DisasContext *ctx, arg_r *a)
>> +{
>> +    gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
> 
> I think decoding shift-amount - 1 is misleading.

Yeah I thought the same while rebasing ...

> Surely it would be better for other callers to pass extract(...) + 1?

... but was too lazy to do the changes :p

> 
> 
> r~
> 


