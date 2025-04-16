Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FBAC369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54x5-0005xK-JN; Wed, 16 Apr 2025 11:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u54x3-0005we-9U
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 11:45:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u54x1-00055q-5a
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 11:45:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c91576aso60734685ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744818321; x=1745423121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdKUFGYipxcPVhHUnZV79SsBGAiDApUOu57M99TRTeQ=;
 b=fsHCohzEKddZBszsdRdkgdnNJyloQI++hU66egTEA7OqvIOtjniWAFEiGGIbIbvTg6
 gBrF2cTIRdsKKOX6l5DCGdWw7so4CJmbullxP9MWBbIkuHXI3ZYC5Uj5KauL1YEqXycf
 O+g3ff77TPVrlRllDOPv7z2joYQxGiso6fpQ4reioeKt3xZMva74TEES2hOFHDkWYECs
 p6Kw19xPEa/gnIAVPYYt5xJS6vPL9ysDA9gosfKE+ro2TZJqS/NrfjJE4GCyaPx51NBQ
 7DoEv3e14oANU089DPSV2Cartv6vlOJSkhz7YxA/NpVf5e8dZAOkZUjGHL+KJvmi9VIY
 7vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744818321; x=1745423121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdKUFGYipxcPVhHUnZV79SsBGAiDApUOu57M99TRTeQ=;
 b=O+s5RYZH3t2bZhSDRBHei8JpBYgu1tkYiKScKZbv9ld+f2TQ10ytH+/DVUZdI6KfPM
 LhxHOZyl4x0P+9snTYKTLreOgYK5km762bG83viCe1SUUJ7NSJEoXzCcdECCjlpMQB1U
 Rtn3XUi5IR87rGZ5vGxmTsSpMvIE0jMQJm3kadR3koFqIjImYLjUMoZmLAv0sAqmFjXs
 5Tk26rkATUeQznNj6kWcDVrhoN07StV/QE+xOat9friCUIzMPFWKZ+lLCIFsw1BnaehZ
 bJtgyXFSx67sr+syHNgQFqAw9RVn/oA+zu8PHjWyavKJk2WtUv50ua6oIq8IHoBSWb0n
 KQww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0lDMsXBN8RD0zYTquX8lTkcvcwmQKB2th2bDliA//7CB01jYDAEQaBxp1WZb1c3i7ZiVboCNXOK6f@nongnu.org
X-Gm-Message-State: AOJu0YwvhkvvfXAKGC5aNfe7baXZh5wL6jTtVM1gfS/msRPIJ0XWCBig
 JVHVXg+9jLBgq5gFW2QhxtfL034RlehnfkW36963deNBuU+I4v/0KJCnpXurq3o=
X-Gm-Gg: ASbGncsQfrwLiHpiR0w1/m8a3/gxe4Z1OyOmbKmLn4R10YItiixYtS8lBZXx1hFCP4f
 0tK31rnGvgOfB+o5iVh3iKEKkTnL5JpapkNJIWnZ1aOwJnO6627WVwPY0opC4oPLG5SL4I2xkU7
 h4nFEUPihVm7N1Ybca05TCSmA4m2aHHVoLi2L+jjtXWKnAVP5ajAphgcSoHB7UxgK/h5QG5JmqW
 qAqRPJsAbS9eK+SVFO+bt/sFJUWi7WezYsoBFnviBuOyKdmTjABq/Y3SIaKDR4lPsIAjEYpT/ml
 KmQlw38IfOyl1cFTLo5ljgJ/dBbZuzcyW7cY9GfqdipOfXiiq9GjmigU7/AjYQ+ignr1Ppnbavj
 3gY2pRLY=
X-Google-Smtp-Source: AGHT+IEpkfA2g25XJVlLwR2yTZFXU0AkCNY4IJH0hKrbaNP9JisEw+9eTRdhjB6igQq4T319MTA3HA==
X-Received: by 2002:a17:902:f707:b0:21f:68ae:56e3 with SMTP id
 d9443c01a7336-22c3596bbb0mr41455195ad.39.1744818321189; 
 Wed, 16 Apr 2025 08:45:21 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d063sm15725585ad.65.2025.04.16.08.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 08:45:20 -0700 (PDT)
Message-ID: <4bda77c4-6e51-42d5-b0bf-072daffd0b76@linaro.org>
Date: Wed, 16 Apr 2025 08:45:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
 <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/16/25 02:33, Philippe Mathieu-Daudé wrote:
> On 16/4/25 11:00, Philippe Mathieu-Daudé wrote:
>> On 16/4/25 10:14, Kohei Tokunaga wrote:
>>> emscripten exposes copy_file_range declaration but doesn't provide the
>>> implementation in the final link. Define the emscripten-specific stub
>>> function to avoid type conflict with the emscripten's header.
>>>
>>> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
>>> ---
>>>   block/file-posix.c |  6 ++++++
>>>   stubs/emscripten.c | 13 +++++++++++++
>>>   2 files changed, 19 insertions(+)
>>>   create mode 100644 stubs/emscripten.c
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index 56d1972d15..22e0ed5069 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -110,6 +110,10 @@
>>>   #include <sys/diskslice.h>
>>>   #endif
>>> +#ifdef EMSCRIPTEN
>>> +#include <sys/ioctl.h>
>>> +#endif
>>> +
>>>   /* OS X does not have O_DSYNC */
>>>   #ifndef O_DSYNC
>>>   #ifdef O_SYNC
>>> @@ -2010,6 +2014,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>>>       return handle_aiocb_write_zeroes(aiocb);
>>>   }
>>> +#ifndef EMSCRIPTEN
>>>   #ifndef HAVE_COPY_FILE_RANGE
>>>   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>>>                                off_t *out_off, size_t len, unsigned int flags)
>>> @@ -2023,6 +2028,7 @@ static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>>>   #endif
>>>   }
>>>   #endif
>>> +#endif
>>>   /*
>>>    * parse_zone - Fill a zone descriptor
>>> diff --git a/stubs/emscripten.c b/stubs/emscripten.c
>>> new file mode 100644
>>> index 0000000000..2157d6349b
>>> --- /dev/null
>>> +++ b/stubs/emscripten.c
>>> @@ -0,0 +1,13 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +#include "qemu/osdep.h"
>>> +/*
>>> + * emscripten exposes copy_file_range declaration but doesn't provide the
>>> + * implementation in the final link. Define the stub here but avoid type
>>> + * conflict with the emscripten's header.
>>> + */
>>> +ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>>> +                             off_t *out_off, size_t len, unsigned int flags)
>>> +{
>>> +    errno = ENOSYS;
>>> +    return -1;
>>> +}
>>
>> I'd include in this patch this hunk from patch 17:
>>
>> -- >8 --
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index 63392f5e78..4fd4d362f9 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -89,3 +89,7 @@ if have_system or have_user
>>     stub_ss.add(files('hotplug-stubs.c'))
>>     stub_ss.add(files('sysbus.c'))
>>   endif
>> +
>> +if host_os == 'emscripten'
>> +  stub_ss.add(files('emscripten.c'))
>> +endif
>> ---
> 
> Actually what about checking the symbol presence in meson?
> Something like (untested):
> 
> -- >8 --
> diff --git a/meson.build b/meson.build
> index b18c46d16a2..33185fdf315 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2654,3 +2654,2 @@ config_host_data.set('CONFIG_TIMERFD', 
> cc.has_function('timerfd_create'))
>   config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
> -config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
>   config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
> @@ -2756,2 +2755,6 @@ config_host_data.set('HAVE_UTMPX',
> 
> +config_host_data.set('HAVE_COPY_FILE_RANGE', cc.links(gnu_source_prefix + '''
> +  #include <unistd.h>
> +  int main(void) { return copy_file_range(-1, NULL, -1, NULL, 0, 0); }'''))
>   config_host_data.set('CONFIG_EVENTFD', cc.links('''
> ---

Yes indeed.  We should be making sure HAVE_COPY_FILE_RANGE is unset, not providing stubs.


r~

