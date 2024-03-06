Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6495FC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhufw-0004VQ-OD; Wed, 06 Mar 2024 12:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhufm-0004RQ-2A
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:03:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhufh-0001Y8-Ig
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:03:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412e96284b9so17527995e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709744591; x=1710349391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r2aSHjVP+Xu8BA7aiHVPv6ilPDdzaBKFNJurg14KCaA=;
 b=YS99oPaz82oiIDWR3Ig+XPdy6QBA9+8FCtM3dNutxAzPkc7jWlyn2pSzFbIzd29Km2
 4Hz41Sjtt0Ma4iiftFEyAEVrYKXrtA25wvb3SIHzFEnvODXLRlu8J9pNYGBltDq+BbE1
 AFQXwz21T6EDxEvDorvx11iI2OfkN9yCGvaU+BOZmH6xt4TDimSEDTEmP7QUooIagHCc
 v925ifC/bGIapVbxIIHcyExhL250XM52/Q8KAw7BLH9LbcRc9x/DkcPyOkeMduv0FXOF
 6ubTMiCADVmLleRmzn+lBT43ofYjyrKKSm6CuQMt92qCdJSdwK/ym26lcJ3VxDOj3T9p
 Cv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744591; x=1710349391;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r2aSHjVP+Xu8BA7aiHVPv6ilPDdzaBKFNJurg14KCaA=;
 b=dP4dZhuzRy3JB1CF5fPtJ7uauGAwONXmyir3rUmFSix48qr0OcxRNVW/qKN47wNDPt
 0BdNBdE41ceoIeaejq+u+xkzMWsN6eXHSxWhV/UtlIYuNRkoZKmXM/ejA21GBg9wQrOc
 dGHiuV8kURUamSfwKLT7gX+zz0WZ+MnWdQKI8Fk9RQ0+cts5WLTNmCuHflSgECNfbs/Q
 TeTJwxTymt/LdvxUNxh5nkSFPPOQ8J6ddrvc6t4nrqKxs0iG8W4Vo9PaMcXuaJgLkj/1
 G5KxxlDkgbH8hn731IRxjulKgZJf62lru+IKBSKtk5+iuL8nXgUZa15LguMf5UQHJy30
 608g==
X-Gm-Message-State: AOJu0Yyz2crf0zjPva/MpDmIb8gB9/cXK5Tl511+gDmDp1qlmc1BZTXU
 lxiSh8pMv4vDmtUfljQ13GIsJOeNM0NToP1Hv454v4thLwmKQ6erTIzMNvSzR4kx0z4iS+0J4wc
 i
X-Google-Smtp-Source: AGHT+IEsDTdAWujgDph7eInjSucsXEx2XwJLDZSG22OQUW1INRiZK92/ydMK1V2qWC2wu4aeYu1cUg==
X-Received: by 2002:a05:600c:1d9e:b0:412:ef25:aaa5 with SMTP id
 p30-20020a05600c1d9e00b00412ef25aaa5mr3453077wms.36.1709744590971; 
 Wed, 06 Mar 2024 09:03:10 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 u21-20020a7bc055000000b004129a1097e7sm24003609wmc.12.2024.03.06.09.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 09:03:10 -0800 (PST)
Message-ID: <fdb970ba-0b15-4a59-a5ed-f9df1430ddd8@linaro.org>
Date: Wed, 6 Mar 2024 18:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 0/9] hw/xen: Have ARM targets use common
 xen_memory_listener
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, xen-devel@lists.xenproject.org
References: <20231114163123.74888-1-philmd@linaro.org>
 <0064f684-793e-4954-90cf-d39c21385a43@linaro.org>
In-Reply-To: <0064f684-793e-4954-90cf-d39c21385a43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping ^ 2

On 13/12/23 18:00, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 14/11/23 17:31, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> While looking at Xen target-specific code, I noticed some
>> generic code used by x86 which is not implemented for ARM.
>>
>> Maybe ARM machines don't need it, I don't know. But I
>> wanted to see if I can get this common code target agnostic
>> and build it once, possibly bringing smth useful to ARM.
>>
>> The changes don't break CI testing and Avocado local tests.
>> If this xen_memory_listener feature isn't required for ARM,
>> I'll send follow up patch that keep this series with common
>> xen_memory_listener but with a runtime flag to disable.
>>
>> Patches do the usual "change target-specific API to a
>> target-agnostic one", in particular using "exec/target_page.h"
>> at runtime. Then non-x86 code is extracted, then merged to
>> the generic xen/xen-hvm-common.c.
>>
>> Thoughts?
>>
>> Regards,
>>
>> Phil.
>>
>> Based-on: <20231114143816.71079-1-philmd@linaro.org>
> 


