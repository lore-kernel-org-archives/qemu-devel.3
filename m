Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92378EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqHH-0000uq-3N; Wed, 04 Mar 2026 12:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxqHB-0000uV-Ul
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:44:50 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxqHA-00060U-97
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:44:49 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8297310ce0aso538586b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772646286; x=1773251086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CaKm5LTeedHr6ap72scGgGDw+lkhf4XyHHd8LVqk1Gs=;
 b=qPLzXp+ORPIDYT0bPi5BDRXCOvtT7vlJgXr98K7ic/+yWBYZ01KhG1G65ue3I9TdUD
 Hs+EnmshkJOZ9hfb8WJ5tKNXPWPUVU16ihUD83ms6JclqYY4v6ZQl/CgC8H7I8/RnpAS
 ZfklV3+aChBKvDEwBoSXayTCKUXF5uZAYk/gDY+5HEqsGATwtxhfGHFNahhj7hoNlaD4
 eynGq+5plub5D2LNwyumaQCUSnTtkrrKUoK1ZoPXtD8kAxRxSuEsZbUlBqPIrGLhA+2V
 JnRmj80D3wol6jNSf0AK/6XcQXYBlP9+JYVSo/l4Jo6HH6qSOzyFSrxQVMizCK9xWoIf
 wTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772646286; x=1773251086;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CaKm5LTeedHr6ap72scGgGDw+lkhf4XyHHd8LVqk1Gs=;
 b=ccmsx22anBwNtz40VLF60qdudxWWWsr+fg0lt6t8KhORX/IWaqP3o4/l84NheZcQLI
 E/msjzUJsJhz4rplF0vdC3py+AP/WCrPEcmMqA9IZwPHImCY0SLz9rwbXDtH0CfP23yT
 cOmZzjcsR9dmxSTBOfEj7BhyIF2MRVxfzcPvJ7kVtD4NcaoZ5IoYx6RRN09sZKf0V1rm
 Vwq3vflpbsYyWvNWUHBAwSXHmHOG1U0grqPJb3xVy2HETO+zHB7B+bm2DPoI0B/qJBMo
 5h1IFYu6QX4NC1AUjrDCzX8rAk4AkcuIOZWfAxa7u5rr2ueINwiRDvaNUYOSOs9BOyZk
 RVpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOANCTpCHJje46hQECC7wQuKnoHW/ZhNx1noM5wUfHheAv8iFWUY5jPq8cfA0jM/+IKaZj2orljQzb@nongnu.org
X-Gm-Message-State: AOJu0Yx+z8eH8M3VXnIVpUHkvKs4n5MJUhUk8irMOQ+PO2hYgbiHH4bt
 nyLS0aZNa8iepgkmW08rPg0raK6cfuuT+4hbdA1RbszjnD5KABT4kXE2ojJ23HIfDp8=
X-Gm-Gg: ATEYQzy/CY52nhn2bUDKiyiNw/p64vs1MRewz0SG+zKjEEyuypvbatFzWqmKdY1ATj4
 HW6eAuaNV+NXTnOgUU91klbriA5o0GuR3dy3624kjWnkWowS/MzYhPM82Vaa3CIAumd4277/2Kg
 Uu77JI9n/betEAKe3VZRoNfeo1bRWA0LLVbjFyrKR+tBXhiGTbuWz5ufvmhUqiJyXgAFylKIzP4
 yvI95rGJDQP7cumLfCY6Ud39Ab5X42OJdeodNrbmFRrs+ER0YAdREJc7+JYslJDyIZZmGzkAIZf
 AHvCQ//DnvX8CVRHNUAvIm/aAotc0s0cEIy1Qmy17M0e0Fu/am2Wid/TJuszdq0Zz2KD43Q96wr
 1vfdI0AQTrFGTAwAiOu8RoEHNAnXtTf6vcy0gCzeJIaCX1kCk1H3sBLfOWTUfPLxxnchllVWnsm
 BpKtdAavDF5goKJ4v19kNszUVNp/SXTbNHcdaGtRL8Q83rnBkQ2vWNLEcNO1Lx4/tmmzjQ
X-Received: by 2002:a05:6300:220d:b0:392:e5eb:f0b with SMTP id
 adf61e73a8af0-3982e268f01mr2709296637.64.1772646285995; 
 Wed, 04 Mar 2026 09:44:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70fa8479aasm17745798a12.31.2026.03.04.09.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 09:44:45 -0800 (PST)
Message-ID: <5e000e7a-d2ee-4a77-ba07-4545f42b6e01@linaro.org>
Date: Wed, 4 Mar 2026 09:44:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
 <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
 <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 3/4/26 7:35 AM, Florian Hofhammer wrote:
> On 03/03/2026 20:46, Pierrick Bouvier wrote:
>> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>>> The test plugin intercepts execution in different contexts. Without the
>>> plugin, any of the implemented test functions would trigger an assert
>>> and fail. With the plugin, control flow is redirected to skip the assert
>>> and return cleanly via the qemu_plugin_set_pc() API.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>    MAINTAINERS                                        |   1 +
>>>    tests/tcg/arm/Makefile.target                      |   6 +
>>>    tests/tcg/multiarch/Makefile.target                |  17 ++-
>>>    .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>>>    .../{ => plugin}/test-plugin-mem-access.c          |   0
>>>    tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++++++
>>>    tests/tcg/plugins/meson.build                      |   1 +
>>>    tests/tcg/plugins/setpc.c                          | 120 ++++++++++++++++++
>>>    8 files changed, 282 insertions(+), 3 deletions(-)
>>>

...

>>
>> As mentioned on v4, you can simply use an external function for failing the test, which won't be tainted with noreturn attribute.
>> This way, you don't need any guard at all or assert(0), and resulting code is linear and easier to read.
>> It test completes, it all worked. If it crashes, something was wrong.
>>
>> void panic(void)
>> {
>>       g_assert_not_reached();
>> }
>>
>> void test_...() {
>> ...
>> on_panic:
>>       panic();
>> after_panic:
>>       printf("Hello World\n");
>> }
> 
> I've reworked it to look similar to this (without g_assert_not_reached()
> though, because glib is not available in the test itself). Still
> required some shuffling of stuff to make sure the compiler doesn't
> optimize things away then :) Especially on hexagon, which is the only
> target (by default) built with clang instead of gcc. Clang/LLVM seems to
> be way more aggressive even at -O0 to do deadcode elimination and
> inlining, so I had to add extra CFLAGS for the hexagon target.
>
You're right, I forgot glib is not available there.
assert(0), exit for abort works instead of g_assert_not_reached().

Sounds good for hexagon target.
We can always update the test later if needed, and at least it stays 
simple. Thanks for doing this extra step.

Regards,
Pierrick

