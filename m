Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED9C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6If-0008ET-Sc; Mon, 17 Jun 2024 02:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ6Ia-0008CF-AV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:57:05 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ6IY-0008OF-H9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:57:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso3130846b3a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718607421; x=1719212221; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oSzzRtmibOTAjW8e8G/wFWymG86NFQ4+/wMtDlQBjw=;
 b=xRN035ylC/5/xBS9A4/L5h7ZqAz1nnYEqZXWb5+fVtCLeBjo9v6cgIu2h6r6o+olCK
 1EVZhtvozi0fTGz6Di/zP3ZijiQqwgXZtuq8QSaXJ5yIUh3PfHDyXGvY217P6anYYmj/
 /7kqiLYY3ReVa1joDcutGNqVChPiRg03s2OWVmz5AIxTDFQ1VZ2XAyQ3xuWs8d0h/ghR
 mHeE3rJvO9/z8elh6zsRqKj0E/9DEXupc3BLqOB8YMKV8EXfaLVHwMXD0aTFHWY2m+0o
 7hrbC/hKYxuXNsf997AhGDecskFLgN7DebbQysjwlNpuhYEde1MkT3tpEfUmY89y7xtl
 jmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718607421; x=1719212221;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oSzzRtmibOTAjW8e8G/wFWymG86NFQ4+/wMtDlQBjw=;
 b=H84nrOPsXuYy0B9YY3gj5V10iW21GsFb4kDeJ495d8p0SA9bt0zG501oHNmNzipONJ
 rhhf+02tMNUSVvi1ofVSZhpA9LQ5Jx9QgfVAbSVRPMhUxWxCB8QIXPS9MeXtMN0mIxm3
 c7VP+tQQCzdC37wI0lZIRVJukECg0ZAFSVhQ5CMSVeGsDX22YkqszekZ+of3eWzzr0+f
 OpuPiTPegQA6/p/KYnXWCJ5yEodvaITnfqC/lQGlTrwDlYLmfTvOlfFkIW7Gcun+yMva
 U2M8P8UOEv+n3+gH1WT/qzwX5KqlEEYdwLGdwmj+sR7z6Hm/2JDymuvjEBxxWgUdaAst
 /41Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzERoc05XyUZOlaJJns4oDmSz5EoUr4Z5hdmVL9gA7Y4xDQcfLUgsKchUPiqKeoKLloF5oidmPiKxzvhc55t2QUBomeK0=
X-Gm-Message-State: AOJu0YzrC/d/HvDTF0ufDYFJeX8MBZLozUumVJ8z1lb99LxoeCtESc4Y
 kMawgkZ82FHDxHx/pIJA+n0gMvND8LHZYI6w4Ni2V0JJCOrOIgNKxCKYeEMda+w=
X-Google-Smtp-Source: AGHT+IE0i//ZbjbneZHCh+sHL24Cl3kN/y4lnvyIEdK2oAIKMtxnyuyhD62lvCnIlZDtjsudnOPJTw==
X-Received: by 2002:a05:6a21:7891:b0:1b5:1feb:b3f9 with SMTP id
 adf61e73a8af0-1bae7d84036mr12608828637.9.1718607420900; 
 Sun, 16 Jun 2024 23:57:00 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f0b705sm73467085ad.213.2024.06.16.23.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 23:57:00 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-7-gustavo.romero@linaro.org>
 <20996ca9-9feb-42ee-8850-af265f77f72b@linaro.org>
 <5a93c441-d1a4-6f60-1b35-a313dd9a1b62@linaro.org>
 <472f46eb-6a3b-4eac-918f-63997989bcfc@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <53a1829a-a129-1ad1-d746-d25fd0c6a707@linaro.org>
Date: Mon, 17 Jun 2024 03:56:56 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <472f46eb-6a3b-4eac-918f-63997989bcfc@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.677,
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

Hi Phil,

On 6/14/24 6:02 AM, Philippe Mathieu-Daudé wrote:
> On 13/6/24 20:15, Gustavo Romero wrote:
>> Hi Phil,
>>
>> On 6/13/24 2:35 PM, Philippe Mathieu-Daudé wrote:
>>> On 13/6/24 19:21, Gustavo Romero wrote:
>>>> Factor out the code used for setting the MTE TCF0 field from the prctl
>>>> code into a convenient function. Other subsystems, like gdbstub, need to
>>>> set this field as well, so keep it as a separate function to avoid
>>>> duplication and ensure consistency in how this field is set across the
>>>> board.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> ---
>>>>   linux-user/aarch64/target_prctl.h | 22 ++-----------
>>>>   target/arm/mte.h                  | 53 +++++++++++++++++++++++++++++++
>>>>   2 files changed, 55 insertions(+), 20 deletions(-)
>>>>   create mode 100644 target/arm/mte.h
>>>
>>>
>>>> diff --git a/target/arm/mte.h b/target/arm/mte.h
>>>> new file mode 100644
>>>> index 0000000000..89712aad70
>>>> --- /dev/null
>>>> +++ b/target/arm/mte.h
>>>> @@ -0,0 +1,53 @@
>>>> +/*
>>>> + * ARM MemTag convenience functions.
>>>> + *
>>>> + * Copyright (c) 2024 Linaro, Ltd.
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>>>> + */
>>>> +
>>>> +#ifndef MTE_H
>>>> +#define MTE_H
>>>> +
>>>> +#ifdef CONFIG_TCG
>>>> +#ifdef CONFIG_USER_ONLY
>>>> +#include "sys/prctl.h"
>>>> +
>>>> +static void set_mte_tcf0(CPUArchState *env, abi_long value)
>>>
>>> Either declare it inlined (otherwise we'll get multiple symbols
>>> declared if this header is included multiple times), or
>>> preferably only expose the prototype.
>>>
>>> Also I'd use the 'arm_' prefix.
>>
>> Thanks, I forgot to add the inline hint and was really wondering if
>> I should add the arm_ prefix.
> 
> If you expose the prototype, it can be used elsewhere. Here it
> will be used by linux-user code. Althought it will be used by ARM
> specific code, from this other subsystem PoV it will be clearer
> that this method is ARM specific if the prefix is used. But I'm
> being picky and it isn't a requirement.

That's alright :) I think that using the prefix is the right thing
to do. I added it in v3.

  
> However the question about why do we want this method inlined remains
> (usually all inlined functions need a justification).

I can't see how using 'static' would cause multiple symbols declared
if the header is included multiple times. If multiple .c files include
such a header each one would get its own independent copy of the function,
so the function would be local to each translation unit. Just like defining
a function of the same name in different .c but marking them as static, so
keeping them local to the translation unit.

That said, I agree it should be 'inline'. That's a tiny function and it
seems really simple to be inlined by the compiler.

This function can't be just marked as 'inline' because deposit() is 'static',
hence in v3 it's marked as 'static inline', just like many other cases in .h
we have.


Cheers,
Gustavo

