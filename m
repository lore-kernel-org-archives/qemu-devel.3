Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A75C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0p5k-000472-Ln; Fri, 04 Apr 2025 18:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0p5h-00046e-ID
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:00:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0p5e-0003Sd-0F
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:00:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2199234f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743804039; x=1744408839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xzm3/8ZpAtTlG40S8NkHD0BockTRLfkI0eLPKSIs8sY=;
 b=BMA8mINhpJTpRJEPZMXfphn8eL4zwN93HO/ag3Si8wq7NtkOEATl7Iy4PSQjUM/tVD
 FK1e+k6fdd97hOMbH3GO4epSgnfCoHmXaRF+SfqgyKhXDJvdnumfqeeu+N2RAqiq+4zf
 H4grII7eNHPDdO773iV5gYi5Ec6kQkHBBQ+DcCHlUQ+pyHVr+UvpIL8QeDdm/VbH4hcT
 rIyXfCFATOXX76rO9oZ88NBqSuoOGeNxLgrj6Hwf6GuZIIMh8RVsw5w9u302YT2b9TP5
 pP1pynBpmnQ5YfhfIoxrCtK+GLAR0fyf5RFHuaaANbhxYO2fzG/pwmjUniuz0nd8UnDl
 XYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743804039; x=1744408839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xzm3/8ZpAtTlG40S8NkHD0BockTRLfkI0eLPKSIs8sY=;
 b=roEPQj+GSzj6cQJZbk/wxG0eltdqt+zCa5sCucNyF0Jpn1RXbGzcafjgQMQX6Dyvqx
 1vnghXaftMUN9nWfckwqxLaHPjY5iqqoq+H4e1zOplI3mia3zoNGk0OmrSXbu/dS7FnO
 GWiZVuK+Hr8m0TbZCR7KHFqgI/tDd2OLOGtYBw9yKhzxkccT3MbLAugZH/s2SmiMldIL
 fj5Anw5xeiTrdDkPzYhD/HinxYrH/mazXW/+eurf0wpCX28/oeM5jlJKVo3Na5BJMWtf
 iLOmUnHTulHQ9futVK669j5FPLneofsMB6jskqfYyU5T16iq5+hg2im7KSobe9KlYfXp
 xOKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5rSGMYKPV9F3OcInf8XDK4JPOiQcPgeea7aBk+Tvg7wCnGKEA34qtqYSaZ2dOZtVPC3aF8uyTpyRH@nongnu.org
X-Gm-Message-State: AOJu0YxF+IG1VASFZiLL4+vK3gwv0A8YUypNMSJciNm6w1A7QbjJr4/A
 3VXofXcq+l3GzN4Ocq4y0a5kn3XdX7NVFz2nC6aHtSBPxWo9+i02u6gFxL5czPM=
X-Gm-Gg: ASbGnct1aezGgOCRohYV0BwaeLbXMvBoUXEewhVgNhnCeUCl50li0BCeSeWIajMu1kM
 fw79WfllQldS5rGbZvqTg3n3BdB8D/hSgg9CLtNF4LKpjtfra+ockWQCRSRELu5dJFJBWynwJC/
 xTTM1Jk741mIQhhSVEahwajUwjA5X43KIO3XyUOxR/9AudzUlMkBHyNwSVoWYCx9hr7MHVIfofR
 MZGuHlAsAMIGXJBjS+SSq5qLp30wcMd+08tgbLzO0sdjCy0eKfMpXfJxhHdadOAIL3cSLmKPxN1
 3gsbEwP1mLYCw/3k2NYaPDSa4pzDEYtVc2ChNQ0aFCNX/A278tPzx+1kIBYdcwMP88Ge4iIj9cY
 w0nHYjAEddnN44a4kwkIoiQjAB1Q1
X-Google-Smtp-Source: AGHT+IGwMDM0AZz/tRfsym+w7WzNFceArR6ZVWXt42S2kVk2ijNUlVWWz3hQey1cmeYQ9i5Bc+CT1Q==
X-Received: by 2002:a05:6000:270e:b0:39b:fa24:9519 with SMTP id
 ffacd0b85a97d-39d0de2d383mr2921100f8f.35.1743804038994; 
 Fri, 04 Apr 2025 15:00:38 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d1673dsm93931075e9.0.2025.04.04.15.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 15:00:38 -0700 (PDT)
Message-ID: <d7d8590c-424f-43fd-918b-68603720b3dd@linaro.org>
Date: Sat, 5 Apr 2025 00:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 28/39] exec: Do not poison hardware
 accelerators
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-29-philmd@linaro.org>
 <c1418cb6-1c92-4f7d-a4f8-85099fc2f6dc@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c1418cb6-1c92-4f7d-a4f8-85099fc2f6dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

+Paolo

On 4/4/25 20:25, Pierrick Bouvier wrote:
> On 4/3/25 16:58, Philippe Mathieu-Daudé wrote:
>> Hardware accelerators depends on the host, not the guest.
>>
> 
> While this is true, no we can't unpoison those define.
> They are applied per target, and not in config-host. So unpoisoining 
> them opens the possibility to miss something.
> 
> I would stick to clean up those ifdef instead, by exposing interface to 
> all code, and link appropriate stubs depending on the variant built.

OK, so IIUC this is the same reasoning than previous patch comment,
always declare kvm_enabled() so code elision isn't possible anymore,
then remove all CONFIG_KVM #ifdef'ry?

> 
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/poison.h         | 4 ----
>>   scripts/make-config-p    oison.sh | 4 ++++
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/exec/poison.h b/include/exec/poison.h
>> index 00aedc41d82..0574d683f6a 100644
>> --- a/include/exec/poison.h
>> +++ b/include/exec/poison.h
>> @@ -62,11 +62,7 @@
>>   #pragma GCC poison CONFIG_SPARC_DIS
>>   #pragma GCC poison CONFIG_XTENSA_DIS
>> -#pragma GCC poison CONFIG_HVF
>>   #pragma GCC poison CONFIG_LINUX_USER
>> -#pragma GCC poison CONFIG_KVM
>> -#pragma GCC poison CONFIG_WHPX
>> -#pragma GCC poison CONFIG_XEN
>>   #ifndef COMPILING_SYSTEM_VS_USER
>>   #pragma GCC poison CONFIG_USER_ONLY
>> diff --git a/scripts/make-config-poison.sh b/scripts/make-config- 
>> poison.sh
>> index 2b36907e239..09d2384745f 100755
>> --- a/scripts/make-config-poison.sh
>> +++ b/scripts/make-config-poison.sh
>> @@ -8,6 +8,10 @@ fi
>>   # but filter out several which are handled manually.
>>   exec sed -n \
>>     -e' /CONFIG_TCG/d' \
>> +  -e' /CONFIG_HVF/d' \
>> +  -e' /CONFIG_KVM/d' \
>> +  -e' /CONFIG_WHPX/d' \
>> +  -e' /CONFIG_XEN/d' \
>>     -e '/CONFIG_USER_ONLY/d' \
>>     -e '/CONFIG_SOFTMMU/d' \
>>     -e '/^#define / {' \
> 


