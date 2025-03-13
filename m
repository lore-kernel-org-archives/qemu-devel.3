Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2B6C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsf3H-0000uq-D7; Thu, 13 Mar 2025 05:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsf3B-0000u9-8s
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:40:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsf38-0005Ly-EX
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:40:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so6457335e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741858820; x=1742463620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nt72gAthci0gEvd9M4Z790irKl0DEGt7+eS5+Dyzs+A=;
 b=D1uwI5DVClaO36bs2uy6RRFxWeMEIwUxIL48xRUCkCXf+8WOr7JVsYGJumQA0sh10l
 mp/+UvNA9GaX333ipg7ypVLZrZi8OjwZbdpaSibPcicKQsLPXWolzi7aKXHbomQWTEgu
 yZnV3ht8xhuF8vCVci0Wshznbsg9ZyQ0ocCeIzGf2nMXP2gXEfnyX3wpxv5nrPF2KAsw
 mKWxA6BJDDH6TlPYstzjYmbMzOWqAxJZuBtBdMtJNA+s3WeakJ3vZOo4njieNhsVomen
 LeAUTbACB+N82plwusyJvnOOO97emDxaQH2TP1+a3M3LcAuxz0YEKLPYKLXUzv9pzc/Y
 twnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741858820; x=1742463620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nt72gAthci0gEvd9M4Z790irKl0DEGt7+eS5+Dyzs+A=;
 b=dpDwdCHF7kzHtxECZPQ0/H6PRwLowX2jDJZlTLsZlCiIXXMhZ2sz6Rw7ieVHDEQjly
 axQYCtLrbRDQiz8diETEJ/+5PD1k/ZYcySZ8MUd0nsPABheYoUdYzh9eUCqhcWdUImKY
 lQXrANyuCSk4cAAX+9L39JRGmHuj5wwQkkcUS6D7AaBu/+lfeXg1vK8DkHfqOU8Xf/t6
 KdLFBo93y0X1mCHHPvEcFtQWqeuUkAtxTcHSfcykyQm1DgDJTqV0trrxUyf8T6dhZAJB
 8ifgTj6qQmF0k0jTbFcLnhlqfdV/ureAAWDFmNgpgId/1pkG+uf3Pr4A/RiNVtG4EGd+
 XnQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Xbyd2+PGDT1H+LXS4vWMi1PzfbS+Xe3jriC1HzR0VjVsRqI08XYug2oVdn5u0KjDI2ZG9dS+EpmE@nongnu.org
X-Gm-Message-State: AOJu0Yyj+NiDZ+aQZUNwMq1bgE8Aoh0tVoaQO++DWIeXT6hLT8ARqwsR
 eWM/KgEHYKXIcfFvzpOMUTeKlhA/8s7YAOF93OCgcjPFU8r25wlQ1aDRyRcGcYQ=
X-Gm-Gg: ASbGncvryOfdiZ5x1mpMHCIFHNPP00F54QF1sQ2UJ4Q0VpTOfNfs/ixmlUTV8yFIpmQ
 ARNBgwUhoBM4aA+65RtgxP5XV6RYfvWekJxctHpz6gbRlnYbrWm/UbcKA7f7qFjtqfXJpbKQbdy
 eiV/SXQExKeW7XXOVrTpRuSB58+7zf8rukQ/xLOy6Rxrfzp8Poij0+buUe4gYv5Hn+sug1ez6dL
 4m2CdKIo4xfvqpP4Sy/HEMHaTrc0BLVYcOvyVpXNiI5YtsR19DcdrTQOjGEZHMV6E1xwx9lQPSv
 qXwwV0SKHRXaa+BMJYJ3HWxLSOuCFY0JXKtuZDitj8fiJFNBUv69AXalg2KkX61owywvrGynHU7
 c4mgQqNBJFw==
X-Google-Smtp-Source: AGHT+IEaQIw0CkHMoH6dksKyT0TudY7xpv6RTfpkpbvYfgrhihAEa2UnIyhixQzrsDLjWrCWdM9lww==
X-Received: by 2002:a05:600c:46d3:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-43c602223f0mr251296045e9.30.1741858819963; 
 Thu, 13 Mar 2025 02:40:19 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b34sm1539273f8f.55.2025.03.13.02.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:40:19 -0700 (PDT)
Message-ID: <e4733078-9563-4667-9923-682434836a5d@linaro.org>
Date: Thu, 13 Mar 2025 10:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] hw/xen/hvm: Fix Aarch64 typo
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-2-philmd@linaro.org>
 <52163f0e-380a-429c-9fb2-449b384d7536@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52163f0e-380a-429c-9fb2-449b384d7536@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/3/25 09:10, Michael Tokarev wrote:
> 05.03.2025 18:39, Philippe Mathieu-Daudé wrote:
>> There is no TARGET_ARM_64 definition. Luckily enough,
>> when TARGET_AARCH64 is defined, TARGET_ARM also is.
>>
>> Fixes: 733766cd373 ("hw/arm: introduce xenpvh machine")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/xen/arch_hvm.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
>> index c7c515220d2..df39c819c8f 100644
>> --- a/include/hw/xen/arch_hvm.h
>> +++ b/include/hw/xen/arch_hvm.h
>> @@ -1,5 +1,5 @@
>>   #if defined(TARGET_I386) || defined(TARGET_X86_64)
>>   #include "hw/i386/xen_arch_hvm.h"
>> -#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
>> +#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
>>   #include "hw/arm/xen_arch_hvm.h"
>>   #endif
> 
> This is a no-difference change, but I'm picking this up for
> qemu-stable - just to remove a wrong code example for possible
> copy-paste errors :)

Good idea, thank you!

