Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesfu-0000QD-VB; Fri, 16 Aug 2024 04:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sesft-0000Pe-7D
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:51:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sesfp-0008I8-Pu
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:51:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71275436546so1556420b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723798264; x=1724403064;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6HrT6oeQWRgITIccY0xXwfsObHdpfsZCP9EAicd1qPQ=;
 b=bvj7PEKU7etWA5Bmh0Xq7FGJDmaYXg0EOOw02FzraFnSzqk+PJXcSu1KXQ1yCZnJFu
 Mcrcn1OnAl3LGz7dDy8jcBUT4r6e0+PcwcUSRAJ5E0vpO2TeNKe7x7wynrWaw7TJqyTx
 E5bwXwCAonBDEv/XwzK21cpZeZiwXDj9Yz6MqE39NrcCXMggMvGT8HgUvehEqIu20/VM
 mEiNW5r6G3Js4HJDNxZoUiLJyxJFAfHAD6epHgJQ6D8fcZPDfT+0IzUSXTnpfR6QSJTR
 +hJo3Oi8X7bBocnzgWY3uMANv4U8rFpwOzZ0lV6EPqc6ULucdr3zBtcuxM8kpiVAQi0r
 9xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723798264; x=1724403064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6HrT6oeQWRgITIccY0xXwfsObHdpfsZCP9EAicd1qPQ=;
 b=rnj4UqUeRgz5PKshNB6DJmXmZRGJj2qjVek0Uamp+jU04gWSBalFLnhgbTdt0mNYKU
 r0LUs8xz1AS0CBNNdsRAdUQEuhYH8Tc6OvXAAqN18MwDBaKqwvchrQdC+7i4xAP2ZuZj
 lY1IH7n3xL2SDVKfN1S5ViAW3gFsoh1qZWY6IPTAgwotSdTFBIzrdLyKytZw+/dzYQyV
 tFkp5qH7daaXGbAHWkjJc2qwbGxumARSnA+uPyR8+ytyuXSrEuxdTtEiO4W7sHCkgT0s
 kGxOrXAG1C4Wgry9HKlt+s15g74/lwIdJLs46ouFyLE6PrxYNF7OWz4Iwg21LjT9hkTc
 q2cA==
X-Gm-Message-State: AOJu0Yxs4/EfvsFaCtrBivlrv8EI697R3P98pyUwrLb4Y7TsbF1N2IO3
 wAM+sht4QNxz+F6nZaLRyEXpDggV5BjsqcYaHwip03n+uF/Lsx+5xjp0ZxKd7C4=
X-Google-Smtp-Source: AGHT+IFNCf5Mr0Ks6Nvv/cJo3XsdqZMD3Rnp/qdg3yCzRsk4NnICgPJL4cqCbAyLeBOoewPg3/+nlw==
X-Received: by 2002:a05:6a00:986:b0:70d:2af7:848b with SMTP id
 d2e1a72fcca58-713c4f2433dmr2648850b3a.21.1723798264142; 
 Fri, 16 Aug 2024 01:51:04 -0700 (PDT)
Received: from [157.82.207.214] ([157.82.207.214])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add6ae9sm2203389b3a.26.2024.08.16.01.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:51:03 -0700 (PDT)
Message-ID: <ebb351d3-c159-4790-ae8c-9278c4d03319@daynix.com>
Date: Fri, 16 Aug 2024 17:51:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: Use -fno-sanitize=function when available
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
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
 <cb7fd813-fb23-44aa-809c-68cfa2daaa40@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <cb7fd813-fb23-44aa-809c-68cfa2daaa40@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/08/16 17:46, Richard Henderson wrote:
> On 8/16/24 18:27, Akihiko Odaki wrote:
>> On 2024/08/16 17:24, Thomas Huth wrote:
>>> On 16/08/2024 10.21, Akihiko Odaki wrote:
>>>> On 2024/08/16 17:03, Thomas Huth wrote:
>>>>> On 16/08/2024 09.30, Akihiko Odaki wrote:
>>>>>> On 2024/08/16 16:27, Thomas Huth wrote:
>>>>>>> On 16/08/2024 09.12, Akihiko Odaki wrote:
>>>>>>>> On 2024/08/16 16:03, Thomas Huth wrote:
>>>>>>>>> On 16/08/2024 08.22, Akihiko Odaki wrote:
>>>>>>>>>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>>>>>>>>>> -fno-sanitize=function in the clang-system job") adds
>>>>>>>>>> -fno-sanitize=function for the CI but doesn't add the flag in the
>>>>>>>>>> other context. Add it to meson.build for such. It is not 
>>>>>>>>>> removed from
>>>>>>>>>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in 
>>>>>>>>>> meson.build
>>>>>>>>>> does not affect --extra-cflags due to argument ordering.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>> ---
>>>>>>>>>> Changes in v3:
>>>>>>>>>> - I was not properly dropping the change of 
>>>>>>>>>> .gitlab-ci.d/buildtest.yml
>>>>>>>>>>    but only updated the message. v3 fixes this. (Thomas Huth)
>>>>>>>>>> - Link to v2: https://lore.kernel.org/r/20240729-function- 
>>>>>>>>>> v2-1-2401ab18b30b@daynix.com
>>>>>>>>>>
>>>>>>>>>> Changes in v2:
>>>>>>>>>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>>>>>>>>>> - Link to v1: 
>>>>>>>>>> https://lore.kernel.org/r/20240714-function-v1-1- 
>>>>>>>>>> cc2acb4171ba@daynix.com
>>>>>>>>>> ---
>>>>>>>>>>   meson.build | 1 +
>>>>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/meson.build b/meson.build
>>>>>>>>>> index 5613b62a4f42..a4169c572ba9 100644
>>>>>>>>>> --- a/meson.build
>>>>>>>>>> +++ b/meson.build
>>>>>>>>>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>>>>>>>>>   endif
>>>>>>>>>>   qemu_common_flags += 
>>>>>>>>>> cc.get_supported_arguments(hardening_flags)
>>>>>>>>>> +qemu_common_flags += 
>>>>>>>>>> cc.get_supported_arguments('-fno-sanitize=function')
>>>>>>>>>
>>>>>>>>> As I mentioned in my last mail: I think it would make sense to 
>>>>>>>>> move this at the end of the "if get_option('tsan')" block in 
>>>>>>>>> meson.build, since this apparently only fixes the use of 
>>>>>>>>> "--enable-sanitizers", and cannot fix the "--extra-cflags" that 
>>>>>>>>> a user might have specified?
>>>>>>>>
>>>>>>>> Sorry, I missed it. It cannot fix --extra-cflags, but it should 
>>>>>>>> be able to fix compiler flags specified by compiler distributor.
>>>>>>>
>>>>>>> Oh, you mean that there are distros that enable 
>>>>>>> -fsanitize=function by default? Can you name one? If so, I think 
>>>>>>> that information should go into the patch description...?
>>>>>>
>>>>>> No, it is just a precaution.
>>>>>
>>>>> Ok. I don't think any normal distro will enable this by default 
>>>>> since this impacts performance of the programs, so it's either the 
>>>>> user specifying --enable-sanitizers or the user specifying 
>>>>> --extra-cflags="-fsanitize=...". In the latter case, your patch 
>>>>> does not help. In the former case, I think this setting should go 
>>>>> into the same code block as where we set -fsanitize=undefined in 
>>>>> our meson.build file, so that it is clear where it belongs to.
>>>>
>>>> It does not look like -fno-sanitize=function belongs to the code 
>>>> block to me. Putting - fno-sanitize=function in the code block will 
>>>> make it seem to say that we should disable function sanitizer 
>>>> because the user requests to enable sanitizers, which makes little 
>>>> sense.
>>>
>>> As far as I understood, -fsanitize=undefine turns on 
>>> -fsanitize=function, too, or did I get that wrong?
>>> If not, how did you run into this problem? How did you enable the 
>>> function sanitizer if not using --enable-sanitizers ?
>>
>> The point is we don't care who enables sanitizers, and unconditonally 
>> setting -fno- sanitize=function will clarify that.
>>
> 
> Argument ordering is important.  You cannot just drop this in the middle 
> of meson.build and expect anything reasonable to happen.

That is a good point. We should add -fno-sanitize=function immediately 
after -fsanitize=undefined; I will submit v4 with that change.

Regards,
Akihiko Odaki

