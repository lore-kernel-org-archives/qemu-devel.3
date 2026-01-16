Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B07C982EB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgobe-00064X-2s; Fri, 16 Jan 2026 13:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoba-000648-TW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:31:31 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgobX-00049z-Ub
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:31:29 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81f42a49437so1280651b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768588286; x=1769193086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdHt7SoOqeSf6EuPzfZQmw9NKG9K2gmahIg1H78ghwU=;
 b=c/XZyb+0oFtxKs40VEp43aTri35gavlWkAIh14cfSbVrYlJSV5z4tCYIyx+33CEIIC
 ZW+jWuBURm5fDM4vZCDVDB6sRuGQk09AnxlnH6oeA/5YR87FoqTnm7m5Lvs7nWmD3fHz
 kyvNgYygkoh3aPnuUwRisWC8ncd3Kltb6N//+/jWvFkc0XMu8XVPAaLExXYD4sSR59BN
 hdZByhvQvxGy6d0kz+xpdcUcQi76WhrH4hycqmvQL6ZVTyKasVdJaXcjtYdoGPpdk4Vv
 sfNWQfkFDCE/l4V0San6270Kttm9mwet4/iiAKUxSSEnvLTHx11pWOWKk9PoJC1cm1m6
 +Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768588286; x=1769193086;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdHt7SoOqeSf6EuPzfZQmw9NKG9K2gmahIg1H78ghwU=;
 b=Hg9LoCla13HqwhnQoMkXz2nMi/fZ4XemvXf7h97k3dWBp+vBPdkitVbw8/+p53QHCp
 KAHwTEltkoXCKilIferEkCo+2oTUXLTLNb5VDWuO9su6qJEQHtoNJOVlTKvZ/uhEcd/D
 6h2fz8LONm6imTHP3ilYZ8vxYIGQogF71DRxQ7AeFVHFzoLsFzxaYcIauksV/4LIs6fQ
 jzr7IldLYV4VUk5LJkOvRfYVpnHdyPZC1ZkGRkNx7DLBL0yflYn6q5Oot5F665yvS1Q8
 NXaeUIO70cLywIMZf3qO1/SKICEnAuDJhmlmEHm/7a77eRLH8i70Bk0ZQW/edIeiZA5d
 5vKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOhcpn9W/ZwYqoYC45xgZm8etyGmcbsXVyZHlCBKzRNZLZAB+8FeVnJlWJXhmMxUu+FC1hSxbeidYH@nongnu.org
X-Gm-Message-State: AOJu0YyxQkjYpgLRy84s4uU9lUoI8BRS9O07V7fXdlk+OMfGkIbsYvH6
 hPncZ2yi5/HN+TuXVn4RfjDIlR2w+edQrlyjSkTLppc/BlNk6XbUfbkd6C3gb/y7MtM=
X-Gm-Gg: AY/fxX4PffMNHVUf3FWnw8oIVEJ0eb8ez5aEfKCVrlcWFRZihY9YdRIHBwO5FeUOflG
 z+Pd7Ep35L8vPgyaD82KYc4oK8TyNvTGF9CM710ub8mYGTyIWx1CUfKjHucxdPbvsca+8vbOD7Q
 MF6vRPXITVdTvzer6aGlDNQ9ypmwaaj1pBnqRx9lCmNAntdrnSPIhYBKpo0lqooE+fpYw+lnnVr
 MSJakJuzZfyRYUEfJ54MorfTHHJvJgYQPBJAUipqjns8PzYD/5RZQ4jJOROEnuO0vELGI0FjP9k
 SxUgkL4py3x0Bpu5+AmPDSgJCrVkf32StQaBnGL98jYxXSobOc/IF/9/whkNygVBRwaN05S1UtO
 wbFFxdTpJEaf5Sj7DgZDxB0MM3EW/QullbLBbwrhnZoOcbAUfZIM/GgRG9FEGrvbnuEAOX0qdAZ
 wk6KFuEZdWxq2iIGpFFH0puqoKvvO//bI4qxHYQAKb/vfS3ZyLBRprfR3W
X-Received: by 2002:a05:6a00:3a25:b0:7ff:ecbb:1c28 with SMTP id
 d2e1a72fcca58-81f9f6a9419mr4455636b3a.16.1768588285992; 
 Fri, 16 Jan 2026 10:31:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10bcf66sm2638942b3a.18.2026.01.16.10.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:31:25 -0800 (PST)
Message-ID: <467c2bca-af39-4e00-b8ea-9e38c1f16e54@linaro.org>
Date: Fri, 16 Jan 2026 10:31:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
 <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/15/26 11:17 PM, Thomas Huth wrote:
> On 15/01/2026 21.35, Pierrick Bouvier wrote:
>> I would like to help maintaining qemu documentation and I've been
>> invited by Alex to apply as maintainer.
>>
>> Files in docs/ that are already maintained will continue to be under
>> their respective maintainer. The goal here is to have someone that can
>> help on all other files that don't have an official maintainer.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    MAINTAINERS | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4ddbfba9f01..786f3b3a456 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4505,6 +4505,11 @@ Incompatible changes
>>    R: devel@lists.libvirt.org
>>    F: docs/about/deprecated.rst
>>    
>> +General Documentation
>> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> +S: Maintained
>> +F: docs/
> 
> You might trigger a lot of traffic to your inbox that way ... but if you
> don't mind:
>
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Reading about your answer, I was thinking it would be nice one day to 
organize a BoF about everyone personal email workflow.
I feel like every dev has a different way to deal with this, and even 
though it seems basic ("Who would seriously ask advice about how to deal 
with emails?"), it's much more complex than what you can expect in the 
beginning.

Hopefully, my workflow and my email client are ready to take it now.

