Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718A5F55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 17:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyvi0-0003u0-QU; Sat, 07 Mar 2026 12:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyvhz-0003tY-K8
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 12:44:59 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyvhy-00016b-0f
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 12:44:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso86212375e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 09:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772905495; x=1773510295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OFsxOl6zIWrNsamLDFr3F2cFhvCsYX3I0jV0QKwgKQ0=;
 b=XbGU6ayBQQR3+u1da61eh+/Oq1vkHmJ1Me+kiZol9nD5tgDEIXKWxuB08+uby2bZAb
 zroieJXPN6txo2xc+7tsOBacJ4x0xpSJdjXSEXqDvraNxIYqR9ZV0w31LYMvvTqFi9oR
 fJoCaqnZOMcRVv/3B9fI7oBvO2CD92zExI5fhmEpT3HzAWiEDoZ0vF5LbYnkMh2Qz/Id
 6tj20IbBvtWfMU0hlCbXcI9siZYVMwMaD6H96I365WqpSFsFFW7uMiJ0W+IfOZClKQGc
 gnpwRVmy1NPPNayWAF7Wr1h2NX5O86itUdsRciZFxgwHkxGzrF5tStW4KHuVQIwk7q0S
 OLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772905495; x=1773510295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OFsxOl6zIWrNsamLDFr3F2cFhvCsYX3I0jV0QKwgKQ0=;
 b=J4gMnc5bnxhq0AfDyLVX3SPs4MhqMNabKwx0ALwzhMefJTx4J00zXzvlGDPCQkeT0W
 tQEvQdhs05TBC4Ucel3Hf78x+fZS01QO+DW8UeB2CIZ2fds3rYYgLfvROQnZJnFzP56R
 KhdzuzjccnnHQHcc/NucS3Fk4vo8p3OAqXvXGGD6GKi5q8Z6M3jZ/ympbmrLMc94fgnp
 njkOCMB/i11Nriy5zabBtv9J4AbDf5dRXcXQd+NTAWEvGJzHj8GG8HY+wssHiNtAqwMD
 QfCIsxsiWv6EHJM7Vqa43Uad6kn7FXZIcIQev+T1O/RH52X8/sfC4AZIGnKMMPfCX7J6
 0Wsg==
X-Gm-Message-State: AOJu0Yx80OX07bUbC623dsohjrbuSgIE6YdkLmbV1u+wwMaTtSuwHcfs
 VLer8u34/kbC2aSI/Z/pkl1ooMU5pNqpMfM6lvjP3h/a+bKCSUuqJTC8ErDP3fMoiNs=
X-Gm-Gg: ATEYQzy6NLvME7Q5hhlAqqsHx7pfU7I9tt7vHDRPhASxBHEhzJ1Y2cT3HdC16VuWKZb
 3nwVEnNPXbc4mBI4Y7Y4SA06Q4nNb9pSnL+bnwr3uBkQp1qX46uzNZLfSii0mOA+jKovYDzd8km
 ZWlH7WNPn4szAs1u5wRY9zmksMIG5ss8QE9LNy4Gh9Bpzhcvcjos0DFWycAr7/ACoYkSv9dkQtO
 3A+P9/W+WhBQUsBpg0D1biqt1kcbcwEOQ0N8i3JplNGKvXIaZOsSGcfbO7bU6v4C0w6EC10S6sh
 zZo7BcT/3rnsqpE8pRDqWXTYDEnf/0Bug0KV/CrHsGl5VWx4ftoZvjyEyHp2ukkinLFw1NJMy//
 07xUZtrNzM2JUPR1yHsAdTGKU4npTqigTImubeLs5FQLUHVgw/vUISGxwjgbR72NjqoMDvlOlfR
 GxdHzDlRyO04cufhQYgjBCVAW6XA4G9GG4LO/rqvOnedg1nvmIsAcAvXw1e7qSi2A5SQhIMMTwY
 qX4
X-Received: by 2002:a05:600c:870e:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-48526951415mr107613225e9.19.1772905495062; 
 Sat, 07 Mar 2026 09:44:55 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853044d849sm75773485e9.11.2026.03.07.09.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 09:44:54 -0800 (PST)
Message-ID: <eb4166f0-41c2-4493-9a8b-24e1889dbf05@linaro.org>
Date: Sat, 7 Mar 2026 18:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 05/13] hw/arm, target/arm: nested virtualisation on HVF
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
 <20260307153143.76893-6-mohamed@unpredictable.fr>
 <d2bd5f90-a0f7-490e-b735-43442f41c679@linaro.org>
 <E8185464-F6BB-4A50-BE57-EFB2A7F777F1@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <E8185464-F6BB-4A50-BE57-EFB2A7F777F1@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/3/26 17:21, Mohamed Mediouni wrote:
> 
> 
>> On 7. Mar 2026, at 16:48, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 7/3/26 16:31, Mohamed Mediouni wrote:
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   accel/hvf/hvf-all.c    |  1 +
>>>   accel/stubs/hvf-stub.c |  1 +
>>>   hw/arm/virt.c          |  5 +++++
>>>   include/system/hvf.h   |  5 +++++
>>>   target/arm/hvf/hvf.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
>>>   5 files changed, 52 insertions(+), 2 deletions(-)
>>
>>
>>> diff --git a/include/system/hvf.h b/include/system/hvf.h
>>> index dc8da85979..0f0632f7ae 100644
>>> --- a/include/system/hvf.h
>>> +++ b/include/system/hvf.h
>>> @@ -28,9 +28,14 @@ extern bool hvf_allowed;
>>>   #define hvf_enabled() (hvf_allowed)
>>>   extern bool hvf_kernel_irqchip;
>>>   #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
>>> +extern bool hvf_nested_virt;
>>> +#define hvf_nested_virt_enabled()  (hvf_nested_virt)
>>> +#define hvf_nested_virt_enable(enable) hvf_nested_virt = enable
>>
>> Unsafe macro. Better expose the method and add a stub.
>>
> Does this look saner? If so can send a rev with it…

LGTM!

> 
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 1c1437b467..66c3b48608 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -26,6 +26,10 @@ bool hvf_allowed;
>   bool hvf_kernel_irqchip;
>   bool hvf_nested_virt;
>   
> +void hvf_nested_virt_enable(bool nested_virt) {
> +    hvf_nested_virt = nested_virt;
> +}
> +
>   const char *hvf_return_string(hv_return_t ret)
>   {
>       switch (ret) {
> diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
> index cec1cbb056..dc365c5307 100644
> --- a/accel/stubs/hvf-stub.c
> +++ b/accel/stubs/hvf-stub.c
> @@ -12,3 +12,12 @@
>   bool hvf_allowed;
>   bool hvf_kernel_irqchip;
>   bool hvf_nested_virt;
> +
> +void hvf_nested_virt_enable(bool nested_virt) {
> +    /*
> +     * This is called unconditionally from hw/arm/virt.c
> +     * because we don't know if HVF is going to be used
> +     * as that step of initialisation happens later.
> +     * As such, do nothing here instead of marking as unreachable.
> +     */
> +}
> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index 0f0632f7ae..a961df8b95 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -30,14 +30,14 @@ extern bool hvf_kernel_irqchip;
>   #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
>   extern bool hvf_nested_virt;
>   #define hvf_nested_virt_enabled()  (hvf_nested_virt)
> -#define hvf_nested_virt_enable(enable) hvf_nested_virt = enable
>   #else /* !CONFIG_HVF_IS_POSSIBLE */
>   #define hvf_enabled() 0
>   #define hvf_irqchip_in_kernel() 0
>   #define hvf_nested_virt_enabled() 0
> -#define hvf_nested_virt_enable(enable) 0
>   #endif /* !CONFIG_HVF_IS_POSSIBLE */
>   
> +void hvf_nested_virt_enable(bool nested_virt);
> +
>   #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>   
>   typedef struct HVFState HVFState;
> 
>>>   #else /* !CONFIG_HVF_IS_POSSIBLE */
>>>   #define hvf_enabled() 0
>>>   #define hvf_irqchip_in_kernel() 0
>>> +#define hvf_nested_virt_enabled() 0
>>> +#define hvf_nested_virt_enable(enable) 0
>>>   #endif /* !CONFIG_HVF_IS_POSSIBLE */
>>
>>
> 


