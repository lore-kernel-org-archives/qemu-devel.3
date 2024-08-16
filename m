Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8ECC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sescL-00040I-Ju; Fri, 16 Aug 2024 04:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sesc9-0003xC-Dd
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:47:18 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sesc5-00078m-Cz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:47:16 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7c6b03c414fso620219a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723798031; x=1724402831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zmRDLynoo+GSor6j9VFmL+uTREFxdiRL6mTbZywzufI=;
 b=Znvr7wFkozS/Yz0NG9aW5EgP544j2h0/M2rRUUAzkfFFdL8oW6yNHmlcdMIobiN9sd
 vTQJ6V7jBbHblaxvpMtdBBTxVyxixkaFDxXs5mjXL8yzVwDEFoaQHw8C378btA+AaSNm
 y2PcHqCm3bIwTctZZeqznzgduCUIvEetujXtpHihSfOgcZn5aRp6ok2czizkGn1/I7ZY
 /P5iierZw/EcyWBsV51TomJVj7CPlXy8rftBd3mKXRdl0n25cjrk8AGLXmJTSqI5zll7
 TXpZgnz2Fcj56Z/ykLZ0LrTo3gknqyWydQoI5H2xu9OWxeV+CK0LIXXo3GVnFF/FbXQ+
 rH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723798031; x=1724402831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmRDLynoo+GSor6j9VFmL+uTREFxdiRL6mTbZywzufI=;
 b=Bu0Tx/bjq0eSFPx3dVg7ErUzILUTX9gU/pPtTlfr/x7UNQ+/gDFhWZ8WEy5MkGRGoY
 JI6G3JLTKhxFMHhIeqW16qyXBA06PZVkk8mksrc5b9DD7cllu5OApEWUNw3w/2gQBzny
 998I2F69DvkmbQHrIs2OaGNxLRE/gnUYiK7a0F/oMa9Sl8J3fi6vrLJNmsHpm5XLCkB2
 UZstPpv8iZAR50Lgux1yXzRp/UVDN/5998kn/tz1UUkWKVC0DAkwP3y8P/CK/ROT5gPz
 sipMu7OSTNxvjh6AD6RgqP9L5T0xaoGXl6OCv937m6PcVAAhsGq+9ToCR/yInC7zez29
 p2bQ==
X-Gm-Message-State: AOJu0Yz77dvelS8vD0I8L/cjut7enOmo44fGrfO30WUiCKNz46PzkYiA
 HHYMidzE20a1I2o5vr8u5EJ8V1ZBIDtsRZ4wDvklzLcNSOaSWDk/fNf54H+cgaA=
X-Google-Smtp-Source: AGHT+IHlTlkpji91VQQaxxhry1a8sJzINb3iS2exhQpdgvmyE3/GIo4fE4XSf+Iv7egi8l/d6hrm6w==
X-Received: by 2002:a05:6a20:9f89:b0:1c2:8bcc:bb09 with SMTP id
 adf61e73a8af0-1c904f6e09bmr2883485637.8.1723798030746; 
 Fri, 16 Aug 2024 01:47:10 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae13a80sm2203031b3a.86.2024.08.16.01.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:47:10 -0700 (PDT)
Message-ID: <cb7fd813-fb23-44aa-809c-68cfa2daaa40@linaro.org>
Date: Fri, 16 Aug 2024 18:46:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: Use -fno-sanitize=function when available
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240816-function-v3-1-32ff225e550e@daynix.com>
 <3d417232-ba66-4781-8278-a6a31987b54c@redhat.com>
 <337e647e-3edf-475c-8e37-de3d28b30340@daynix.com>
 <bfd436ad-f76d-4bc3-b92f-cf9aaca9c7f5@redhat.com>
 <6d1949bc-a0c2-487c-8b6c-21db12f6a0af@daynix.com>
 <a8ec0efa-0369-4f21-9234-e447b40c0973@redhat.com>
 <4b4dd3bc-8338-4452-a8b2-013405094e1b@daynix.com>
 <12206320-2647-448e-a206-685ff95be8c3@redhat.com>
 <28b9deb0-eb28-4c35-859d-f0230aedf10f@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <28b9deb0-eb28-4c35-859d-f0230aedf10f@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 8/16/24 18:27, Akihiko Odaki wrote:
> On 2024/08/16 17:24, Thomas Huth wrote:
>> On 16/08/2024 10.21, Akihiko Odaki wrote:
>>> On 2024/08/16 17:03, Thomas Huth wrote:
>>>> On 16/08/2024 09.30, Akihiko Odaki wrote:
>>>>> On 2024/08/16 16:27, Thomas Huth wrote:
>>>>>> On 16/08/2024 09.12, Akihiko Odaki wrote:
>>>>>>> On 2024/08/16 16:03, Thomas Huth wrote:
>>>>>>>> On 16/08/2024 08.22, Akihiko Odaki wrote:
>>>>>>>>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>>>>>>>>> -fno-sanitize=function in the clang-system job") adds
>>>>>>>>> -fno-sanitize=function for the CI but doesn't add the flag in the
>>>>>>>>> other context. Add it to meson.build for such. It is not removed from
>>>>>>>>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
>>>>>>>>> does not affect --extra-cflags due to argument ordering.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>> ---
>>>>>>>>> Changes in v3:
>>>>>>>>> - I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
>>>>>>>>>    but only updated the message. v3 fixes this. (Thomas Huth)
>>>>>>>>> - Link to v2: https://lore.kernel.org/r/20240729-function- 
>>>>>>>>> v2-1-2401ab18b30b@daynix.com
>>>>>>>>>
>>>>>>>>> Changes in v2:
>>>>>>>>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>>>>>>>>> - Link to v1: https://lore.kernel.org/r/20240714-function-v1-1- 
>>>>>>>>> cc2acb4171ba@daynix.com
>>>>>>>>> ---
>>>>>>>>>   meson.build | 1 +
>>>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/meson.build b/meson.build
>>>>>>>>> index 5613b62a4f42..a4169c572ba9 100644
>>>>>>>>> --- a/meson.build
>>>>>>>>> +++ b/meson.build
>>>>>>>>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>>>>>>>>   endif
>>>>>>>>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>>>>>>>>> +qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
>>>>>>>>
>>>>>>>> As I mentioned in my last mail: I think it would make sense to move this at the 
>>>>>>>> end of the "if get_option('tsan')" block in meson.build, since this apparently 
>>>>>>>> only fixes the use of "--enable-sanitizers", and cannot fix the "--extra-cflags" 
>>>>>>>> that a user might have specified?
>>>>>>>
>>>>>>> Sorry, I missed it. It cannot fix --extra-cflags, but it should be able to fix 
>>>>>>> compiler flags specified by compiler distributor.
>>>>>>
>>>>>> Oh, you mean that there are distros that enable -fsanitize=function by default? Can 
>>>>>> you name one? If so, I think that information should go into the patch description...?
>>>>>
>>>>> No, it is just a precaution.
>>>>
>>>> Ok. I don't think any normal distro will enable this by default since this impacts 
>>>> performance of the programs, so it's either the user specifying --enable-sanitizers or 
>>>> the user specifying --extra-cflags="-fsanitize=...". In the latter case, your patch 
>>>> does not help. In the former case, I think this setting should go into the same code 
>>>> block as where we set -fsanitize=undefined in our meson.build file, so that it is 
>>>> clear where it belongs to.
>>>
>>> It does not look like -fno-sanitize=function belongs to the code block to me. Putting - 
>>> fno-sanitize=function in the code block will make it seem to say that we should disable 
>>> function sanitizer because the user requests to enable sanitizers, which makes little 
>>> sense.
>>
>> As far as I understood, -fsanitize=undefine turns on -fsanitize=function, too, or did I 
>> get that wrong?
>> If not, how did you run into this problem? How did you enable the function sanitizer if 
>> not using --enable-sanitizers ?
> 
> The point is we don't care who enables sanitizers, and unconditonally setting -fno- 
> sanitize=function will clarify that.
> 

Argument ordering is important.  You cannot just drop this in the middle of meson.build 
and expect anything reasonable to happen.


r~

