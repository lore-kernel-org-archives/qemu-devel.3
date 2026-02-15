Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711EEF585D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 02:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrRQl-0005Ey-9c; Sat, 14 Feb 2026 21:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRQh-0005Ej-Mw
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:00:13 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRQf-0007hK-VG
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:00:11 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so1536761f8f.0
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 18:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771120807; x=1771725607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BsmVxuE/W4qCpde3E03C28mDlV5yQZXBLfX1QrOf3bg=;
 b=R+gmih0VwHxAOhwbaHpAgqNEpOg3vGQ63RGlQIUowaQ70hTTbIZKvm2cvbEE7al4i5
 dWkvZO1plGpiID2FNSutu6XLX9rIJpX6oKbR3Y6B9ToGhvMXUDneVf9gCjPV0Xh856Sk
 TETEaK1L4qXsf6tsjU6Pyre50l5MmgqIWvVcQeCCKxRMRvytWQrefq87D8zwGRFgHqyu
 BhuCdf/0lzo89X/YHpSSSiBstRxAp6QN9vSAvJ03WrxFM2yAlLm/pw3/gIVfbtDvElxc
 rMaYkKmN+y/th5xvepVFJyob9V2J+j/Lz4nj1tayyZ9kYkbiiiVYloRMNAG/rQzcmXuT
 eqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771120807; x=1771725607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsmVxuE/W4qCpde3E03C28mDlV5yQZXBLfX1QrOf3bg=;
 b=UoHZAXCLXlORzwuacxzOvDdGLuqTlTqFaa7k+qGoVU+SHpGtBJv6yko7AZZk5lrwGl
 M1elbMIwyNkb7MHXrsiDdf+O2d8Q3J6UjrbBQAqAi/qjSkB1C/N75QRc6AytTfiKPoCC
 YAAG5v/X/cHb5Yq3y5Bq8KYngcQUOelnSLyN6BtfP27yuFbuqWV4DUzcZAhVyGLTqHbX
 hA7O/IkgrE4ZaGo0B4QxF7cg/s2GvE4wB6BeqG0qsk9/k+vYqbldM/MYY+UAxaP2c6gK
 FimadNgtqT/CogwcyBCJ+cwxbiMFCM4aAZN1unhm20qMV01+ZrcPqGu1TJ+emOvT52zJ
 SayQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvmUMk3scaORcvS9U+4Uw6MqwVQh2ZWc90qMgNv/5d5y6SLKwnl4T+YalyO2oICXr/l/uHmnhSYoQj@nongnu.org
X-Gm-Message-State: AOJu0Yx4fdFrAfNAo3aSNxmcvTmlIT6W9p3WlnvT0brTcnou149J2V8Y
 WIMA3vF54N2wiuij3QLdcAIcTuxVpyUb8+60kYiRT94uXSgYuSPRgFU/mH831Yio3UY=
X-Gm-Gg: AZuq6aLFrtCgy9nxrp6Iv/vIMEJ/2zsLtnTnJXGPR+xWmj6o7UId5Isjkm2maLc1s9r
 IEdQCXgh2ljmr76q4GHFULpmAQ42bZNs6u0qRpoFy/SMe4tvHoyy0I1/iTShrlH3K10zeiXtHb8
 QYFZhxMPF57eVxFan8humzubIK/HEyZwd0Zoxw+B1vyOLlZxAQmU9fFQhszbdOiaKUt7wcCZmSw
 H+iSWZ2R8hbA2VU1o1IVF9LFt+37YiG1oA0J46Re03d1e8dc6ItmePvDK+3RKLq2rbNw7YWeAci
 nCj35kXIbOVIjemYYHSi6YQgp/F+1nf/MDHc7gWxl4shek7RBTQ8xUu23H2vhQGFbXKwMToFyDA
 X48KXk7OqAV9LGt1OZxLTTJ5nXU9V9s9WKfrocLyRM69ShKIJSHMElRRCfI0VG6CbB0dGAL043s
 Egz+o1QuE5RK41FPD7BoVB85QHqUro42sjtrK6FDuc4rlWWSiIWaX7/itUfyexfJWg2A==
X-Received: by 2002:a05:6000:1a8e:b0:435:8f88:7235 with SMTP id
 ffacd0b85a97d-4379790e98amr12401147f8f.33.1771120806594; 
 Sat, 14 Feb 2026 18:00:06 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm14932913f8f.37.2026.02.14.18.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 18:00:05 -0800 (PST)
Message-ID: <d19ccce3-8582-4b26-a2c1-ce1d56098fa1@linaro.org>
Date: Sun, 15 Feb 2026 03:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cpp: use __has_include
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, jsnow@redhat.com
References: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
 <47a7d557-c864-4b43-a178-9adfa12bba9f@linaro.org>
 <4814fdb5-97bc-43ff-96ff-49b84300100f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4814fdb5-97bc-43ff-96ff-49b84300100f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 14/2/26 20:40, Pierrick Bouvier wrote:
> On 2/14/26 3:46 AM, Philippe Mathieu-Daudé wrote:
>> On 14/2/26 07:10, Pierrick Bouvier wrote:
>>> This make sure we can include all possible headers without breaking
>>> build for environments missing them. It fixes compilation on openbsd.
>>>
>>> We don't want to pollute configure script, as it's really a special case
>>> here to make sure we don't have a compilation regression with
>>> qemu-plugins header.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    contrib/plugins/cpp.cpp | 261 ++++++++++++++++++++++++++++++++++++ 
>>> +++-
>>>    1 file changed, 259 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
>>> index 1ff54896d97..0673c4f074d 100644
>>> --- a/contrib/plugins/cpp.cpp
>>> +++ b/contrib/plugins/cpp.cpp
>>> @@ -6,103 +6,360 @@
>>>    #include <qemu-plugin.h>
>>> -/* https://en.cppreference.com/w/cpp/headers.html */
>>> +/*
>>> + * We include all C++ standard headers (without deprecated ones),
>>> + * taken from: https://en.cppreference.com/w/cpp/headers.html
>>> + *
>>> + * To update, copy page text, and then:
>>> + * grep '^<' |
>>> + * sort -u |
>>> + * grep -v strstream |
>>> + * grep -v codecvt |
>>> + * sed -e 's/\(.*\)/#if __has_include(\1)\n#include \1\n#endif/'
>>> + */
>>> +
>>> +#if __has_include(<algorithm>)
>>>    #include <algorithm>
>>> +#endif
>>
>> Should we test __has_include is defined, as the GCC documentation
>> recommends?
>>
>>     [...] the recommended use of the operators is as follows:
>>
>>     #if defined __has_include
>>     #  if __has_include (<stdatomic.h>)
>>     #    include <stdatomic.h>
>>     #  endif
>>     #endif
>>
> 
> It's not needed, as it's part of C++17 standard, and it's now set to C+ 
> +23, so we know it's always available. If C++23 was not available, we 
> would have an error message directly from configure.

Sure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> https://en.cppreference.com/w/cpp/preprocessor/include
> 
>> https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005finclude.html
> 


