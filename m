Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9BBD1715E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t369u-0001dp-D9; Tue, 22 Oct 2024 00:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t369r-0001dJ-Nb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:06:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t369p-0003wy-1r
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:06:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-207115e3056so42503265ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729569965; x=1730174765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBMJnUUo5JuIBZA0KbpAj4Ll93ycVrgDh9PHSJSqF8c=;
 b=ep9bHIybVOcTO4VIELMlWrf0EFdm84RvgO1Bj++HyHcwffPCgsMeFcciTy9v56AIt/
 isz8tFy/uxCnfwXgstMlLBVIppTaXEJDjZmjAmigoFcMYsva7+7YGOeQ92B6RHGYTwvK
 asZzxr5uAlObTJoc4bhj+VKqF5FGlvE6GXm8gi/YEvf7d6DwpMWQLuR8gL+jaWK2Dy3i
 HQqzhPe05si7w66YSzseoaSem6PbsXvj5xjT9nm0A1a7Vav5Vfck/9QQNMr1vqIjk7Ng
 oi13Gsx98mUegTtJFYAkssl84Cq4IDqhbxcqZBFons0yuX+t/oFaV7W1PluZrl3X7pU5
 FVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729569965; x=1730174765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IBMJnUUo5JuIBZA0KbpAj4Ll93ycVrgDh9PHSJSqF8c=;
 b=tIN/605Ox5SEFQoULgStbZwH2muNr2pGI90g64ECA4cCiCQ97g6JsSlCjlJwTNS8P9
 8pFMeug0g4PIEk2nuQSVaD97UKABaWTodt7N31WsDKY8VipPjPYjQo3sj+rJvtl8KpiA
 FpfJLk0F2a6R+4JdhfC+T+khuuKO6qiI89AcC70ffT5rmMGBONACyjp4PT28lFSkERfo
 n6ec1ZmldUxrs4D6MbouiDrUe09AB9h+IHi4ooC1U8VINWi9He47dfteIRvPrMks2F5p
 59wVFNqJAslhTS8fQ6XLAcA34fr7x7+H7auqHK6XRMPyb2KfF32Ue+Z9B2/SqV9CGy+U
 MW7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCSDppxa0XeUD0En6S8RYxDncS30FA5+kRnOllAXSmlJg/EfxydKRNZf4rOrvRMZdt5nKn4wnBiDZ@nongnu.org
X-Gm-Message-State: AOJu0Yw4ZZ54XkSXM6K2UuYN1Shr+MBhA+E1sbQQoudkT78s30hufNgt
 FWre+raWXXCIuOj9wgeuAEuUCs65KUPebmV+oNDjLqI0gxGY0zvr9KizzKGviMjNyfgXMr6Fmab
 T
X-Google-Smtp-Source: AGHT+IFlmebdM7Y9HsOey65p8PhtoKr/CVYELfo5QdeW6wOJyoG1xeZDZn5gcNtE5KGmavEfFc6Bow==
X-Received: by 2002:a17:902:ce85:b0:20c:c1bc:2253 with SMTP id
 d9443c01a7336-20e5a8a101dmr176602285ad.32.1729569965504; 
 Mon, 21 Oct 2024 21:06:05 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f65c0sm33517315ad.289.2024.10.21.21.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:06:05 -0700 (PDT)
Message-ID: <f2f8b18e-043d-4c21-8d91-946465fd1941@linaro.org>
Date: Tue, 22 Oct 2024 01:06:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Introduce ase_3d_available() helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241021145832.34920-1-philmd@linaro.org>
 <7eb739af-c39e-4d5d-a439-99abceca7f00@linaro.org>
 <6ee8e20f-a48a-4f4e-a3ea-29bf29a9d630@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6ee8e20f-a48a-4f4e-a3ea-29bf29a9d630@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 21/10/24 14:24, Richard Henderson wrote:
> On 10/21/24 08:02, Philippe Mathieu-Daudé wrote:
>> On 21/10/24 11:58, Philippe Mathieu-Daudé wrote:
>>> Determine if the MIPS-3D ASE is implemented by checking
>>> the state of the 3D bit in the FIR CP1 control register.
>>> Remove the then unused ASE_MIPS3D definition.
>>
>> I forgot to mention:
>>
>>   "Note, this allows using MIPS-3D on the 20Kc model."
> 
> Did you mean mips64dspr2?

Yes... Nice catch.

> The 20Kc model has ASE_MIPS3D.
> 
> If so,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


