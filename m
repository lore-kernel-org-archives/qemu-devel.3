Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E103CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrez-0007lg-6C; Wed, 21 Feb 2024 13:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrex-0007lC-Gi
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:49:35 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrei-0007iP-KV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:49:35 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4cb26623dc1so1101277e0c.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708541359; x=1709146159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kOcMGExMW1vcux9Gf3eZVPIP6XqBWuIIEYyKwaDkOk=;
 b=IVKtkFxJIfPnB9GmaFQkP+LPGo2MiV8Gx47bWVkJc1702C5kA4YiEZ9dQM1OF4Astn
 2hvlftnnXu6y0sR2C1pjBeaiydulK6lC9JE5nXc7AZvtE9GvUU6RgM5yz4l8UfRqku3e
 4kYdBdNLJ+feMLue5BMJApUQqz/DMcxLJC2RGH0z+x5wDntIK3dJ4j6qXoeBSrAxFcZF
 rwDgzaeOtWZkG429RhZZRb5TA9DkQSmsykPdebzknVg8Guaou8GxhTYUEMWn4ituT9IN
 Rfn0RZtI/LCghlygp15Unwudr8HzaRE795Eu/AB6zq/Fi/RcWZkLlzCZ/oGjISTwImoT
 92uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708541359; x=1709146159;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kOcMGExMW1vcux9Gf3eZVPIP6XqBWuIIEYyKwaDkOk=;
 b=bmFWzC+S+Ks/XjWWrLkZkFvgc9LAD+G7GpAOF9A5obSZ+daMj0iGW1jgfnO/KiPWx9
 cHlWlOAklW+llTK2SOvpJiNqFnRqz8fec8PFlMDOfoBLF6y2zPrn1nUHlCaloMWgVcfJ
 GiqYNzy042h2HdH03j6CcPFXu9cNOkhHns65qjw4Jmy8EACRrLsD+dXQjHQvR9dT8EfF
 LXt81V9pFqaBaVxZnFO5jDX8mZpAazsPSkWvMb/3oCgDfOoqJUOtuSwz+C277TVcT0NF
 zwhdhBddE3aQl1LliJUZ+G+6KMlWIF1FijB5YrYe/ZyhcOns1f1ntX9pVxDeb1Syyqqu
 FbjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcu6wnBcbu9eOuVXUa8BkqDHkPBsUVa6//vVLC8PjTTGZs/uUXgx9f++KZy1DOHlMVKfyNjVWkwtT1Gm+porMwfEZ7+6M=
X-Gm-Message-State: AOJu0YwxYqdGnBMXiz12slDvInfSpzokPDqEoodMA/eQzOInpt+XQ+Gq
 q6mfVDqzXo6WflujmvvQcSWLdvcrcZKZ6G8H2babZXVZxOLsFKwGzAyx8LelsSI=
X-Google-Smtp-Source: AGHT+IFtGsUG1KSyW0kDXOgQ9Ip0F3RPXNe2b/RiZbA3zU9uYvywmn4AfsLWfF6mAHUZoSaAyoFrFw==
X-Received: by 2002:a1f:d847:0:b0:4c0:683a:d114 with SMTP id
 p68-20020a1fd847000000b004c0683ad114mr16283351vkg.15.1708541359369; 
 Wed, 21 Feb 2024 10:49:19 -0800 (PST)
Received: from [192.168.221.175] ([93.23.14.172])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a0cb68a000000b0068f785b1cfbsm3274445qvd.64.2024.02.21.10.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:49:18 -0800 (PST)
Message-ID: <1ed3ee21-20ff-4503-98ea-de00c490b83a@linaro.org>
Date: Wed, 21 Feb 2024 19:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240221180751.190489-1-thuth@redhat.com>
 <99813a8e-45ec-460e-a944-c696eb853b75@linaro.org>
In-Reply-To: <99813a8e-45ec-460e-a944-c696eb853b75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=philmd@linaro.org; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 21/2/24 19:47, Philippe Mathieu-Daudé wrote:
> On 21/2/24 19:07, Thomas Huth wrote:
>> leon3.c currently fails to compile with some compilers when the -Wvla
>> option has been enabled:
>>
>>   ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
>>   ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length array
>>    ‘offset_must_be_zero’ [-Werror=vla]
>>     153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData, 
>> info[id], info);
>>         |     ^~~~~~~~~
>>   cc1: all warnings being treated as errors
>>
>> Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
>> here: DO_UPCAST is supposed to check that the second parameter is the
>> first entry of the struct that the first parameter indicates, but since
>> we use and index into the info[] array, this of course cannot work.
>>
>> The intention here was likely rather to use the container_of() macro
>> instead, so switch the code accordingly.

Fixes: d65aba8286 ("hw/sparc/leon3: implement multiprocessor")

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/sparc/leon3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


