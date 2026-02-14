Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7455CEF5851
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 19:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrLUw-0007Q2-QY; Sat, 14 Feb 2026 14:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vrLUu-0007Ps-KH
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 14:40:08 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vrLUs-0004wb-C4
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 14:40:08 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-824af5e5c81so1846977b3a.0
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 11:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771098004; x=1771702804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=r0eqHBxKVDkzo16lO+tTLwpKuwUQgMZJ1oUtqUOYBZ0=;
 b=OEv1vUUsoFGuHi2ct52bJEu7ELo2GUEC2pswlhRDW9OAFBEzfXVBmAWd49JDhfhUHQ
 6zoEFbM+1lE+Yth7iFQEUlipeaVO4JkCyeJtZb7aJA2jgFwvhWVwKyHEVcLDGvO2v7AL
 h9qq7U9qBIZUthwp9Io/vayGkL+Bu8tDihRgWO/VwuM0I3qrrAbZhdHawF0X8Dj/kyJJ
 e9T2zzWocmfx6UBRMi+Oo210J0GiO+4TZ/4JkhXZF7QkZ2bKz8pzWoivqBZVcNo/w7Gb
 TBWasVcjsIIH/cY39lH2LmKLKqbkYaYFaNO0bCgF1gvGvS4fr/FUGTx1hQL0ozKG3Nxi
 XruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771098004; x=1771702804;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0eqHBxKVDkzo16lO+tTLwpKuwUQgMZJ1oUtqUOYBZ0=;
 b=BDU1do/FWTyMw19wrazKkDcu+9HUC8iNiXG5kIhUHnBXlUWmxxNoxyqim+Auvl5gGJ
 NA+CuP9bPJDggM4twM+Y70dsaqUwSB/qKiLrt1XVnTf8ouKsvcBaFm3X4PNMXLPVhxNr
 aRfdc3Z4NCRADSVUU5ALzOKHHlxag1gm7pGaKq3ySQipgu3ynqTq6o1EmlI7cxwZzbZs
 wLVrplNGHV4Jntfc+9SQ/D3V3/LT16D34bCIZi3/M7ynaGqAbB5fCzwWK21cXqVj8ffZ
 GLR/voaLDAnb09EdNFoBeITHhL7lMgkKmlkqdcMRTR3QEsBWlwSyF0RUSEmH/0mKylJy
 NYGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMfOa6chej4c1VrgyiA5UWm7VF09nY8Z9UZo+XXEwLLzDsi04kM72S6RDrsBCgXXThBPODmJ7I6SHD@nongnu.org
X-Gm-Message-State: AOJu0YzRd1EGHz/ld2ZR0kQUXa8GP2gdMJEBBCInDUx4ICoTIMUeEoEc
 smhI3B/PopkMUUIkjjcyZinzc+3trI6vx+vRBRct9cHQNOkwIY8Iw9Y9FowUe85iucM=
X-Gm-Gg: AZuq6aLoOeKNEf2W5PjPPri84xNM6D8TTYrhVGjaM4th8mGYuwaF/uhODUU95h2+csL
 F5Liu1Q1/eL89ebCBrm86FqO8L1tUY/dR1c6TVVj/xRmGhH3YCpvWHRYtVoiBBkkFMbwHJ7ToDB
 yXQtVjT61goSY3tAcaF7NFxWIrdsd998Gpt9V2L9JZDIb//3wh519LWkj+NvhntTXkOmd8f6nW/
 zrGvVSms8yVW8S7E8lMTWWPce1GnHJG7fFIHvPMsYc3UvHwW2/iorwzsRhAXKlTYnjkd+exxCnS
 hqFWOQ2OzLo3TYmLipaC0lkJ8v8zJyivMosfypYDc7n4SGkEKJncYZskwAptVDnbzCFudAtpIZp
 MeJq/OG9jKFXf646+GSnA0glgElTgodNO1YkBrW/7wDDQ2yOKLSmApNM0nXGUb6omd1jqFyd6F7
 M650VK0yvh3wXkTxCwOPeCtRDsemfMx2lji7kAzk/rd7kNopz8B9RSokHz57Uh9CiCoMUv
X-Received: by 2002:a05:6a00:3a02:b0:81f:9b23:3d1c with SMTP id
 d2e1a72fcca58-824c5f11872mr5622294b3a.23.1771098003878; 
 Sat, 14 Feb 2026 11:40:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6bb55adsm6051265b3a.62.2026.02.14.11.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 11:40:03 -0800 (PST)
Message-ID: <4814fdb5-97bc-43ff-96ff-49b84300100f@linaro.org>
Date: Sat, 14 Feb 2026 11:40:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cpp: use __has_include
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, jsnow@redhat.com
References: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
 <47a7d557-c864-4b43-a178-9adfa12bba9f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <47a7d557-c864-4b43-a178-9adfa12bba9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/14/26 3:46 AM, Philippe Mathieu-Daudé wrote:
> On 14/2/26 07:10, Pierrick Bouvier wrote:
>> This make sure we can include all possible headers without breaking
>> build for environments missing them. It fixes compilation on openbsd.
>>
>> We don't want to pollute configure script, as it's really a special case
>> here to make sure we don't have a compilation regression with
>> qemu-plugins header.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    contrib/plugins/cpp.cpp | 261 +++++++++++++++++++++++++++++++++++++++-
>>    1 file changed, 259 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
>> index 1ff54896d97..0673c4f074d 100644
>> --- a/contrib/plugins/cpp.cpp
>> +++ b/contrib/plugins/cpp.cpp
>> @@ -6,103 +6,360 @@
>>    
>>    #include <qemu-plugin.h>
>>    
>> -/* https://en.cppreference.com/w/cpp/headers.html */
>> +/*
>> + * We include all C++ standard headers (without deprecated ones),
>> + * taken from: https://en.cppreference.com/w/cpp/headers.html
>> + *
>> + * To update, copy page text, and then:
>> + * grep '^<' |
>> + * sort -u |
>> + * grep -v strstream |
>> + * grep -v codecvt |
>> + * sed -e 's/\(.*\)/#if __has_include(\1)\n#include \1\n#endif/'
>> + */
>> +
>> +#if __has_include(<algorithm>)
>>    #include <algorithm>
>> +#endif
> 
> Should we test __has_include is defined, as the GCC documentation
> recommends?
> 
>     [...] the recommended use of the operators is as follows:
> 
>     #if defined __has_include
>     #  if __has_include (<stdatomic.h>)
>     #    include <stdatomic.h>
>     #  endif
>     #endif
>

It's not needed, as it's part of C++17 standard, and it's now set to 
C++23, so we know it's always available. If C++23 was not available, we 
would have an error message directly from configure.
https://en.cppreference.com/w/cpp/preprocessor/include

> https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005finclude.html


