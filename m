Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC83CC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbPqL-0002QU-FQ; Tue, 06 Aug 2024 15:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbPq5-0002Od-EF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:27:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbPq2-0006B0-Ua
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:27:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso7128025e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722972437; x=1723577237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vrc+zi0ziRwPOBhP9AUlUNaD7G3Gwwzt97+a5Kmq/oU=;
 b=cVvGxTXyA8s7V5Vymucbirec2+MEMKRbT3jCUYPNqYi3HKC6FiCcfT/c/LQlWiLdTs
 +cHe5QytJ2DELoZI9uN1VZzoy6TS13rlLqKyovx/1U/3eYPyoH13YM4BxZHT49imFVOJ
 qZaS0RTPsIHdGTZG+pYYGR8TrOWj/KbNLJUFUl8r7CLHJv9KZY+9xUC+7btrkAMnJEog
 F6pzvS/a34Q0rZ2WMcKYcLicJTwXvc8aHJP6utshz4iuY3QFGMuB3vz7lf3zh3oYZh9O
 zxlCoqWW0cbtHrtHzZdfAlY9w3DK0r3YwVLkknr7UZSz5Uvl9fjKAppqStuF+eTzgZAL
 C66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722972437; x=1723577237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrc+zi0ziRwPOBhP9AUlUNaD7G3Gwwzt97+a5Kmq/oU=;
 b=gJ+wBZ1PrNzX4MA6GrExEB3Gm8XzK6wTS81EY4aWDZtl4v0kE5l0DdsF4xT5Ls/VKK
 Hvv/YALONi/o4ZQUPu+3mr0ntgqR/aCZIsoaolt1Ho7qdGz7MgnrotbahQpct1s5NrP8
 g1b8CB6kn/L5vyFAmjFt1snuk12/4TBHNvyKcIGm52PnFgD3NdMc1v4nQcJffeZ6+qLJ
 8LScrXL+3kBDXE49xUWgYYti6V6VAH+Agz6cMiffgiuKJrU8ZVFezvb0TESAd4kpqstS
 HL24Vfpw/eTLAO9CoS4CQYq2CM3zcAAOBrJuA6Hx23ng+IwI8ASBFeEuLZUOmANBiG7b
 lU5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2V4ybhxN8X4Wj3H43fLNqi7ODSjXI3gi9NpIC159da5bpcbbNJ+rSKa/Fuk7ACCxFIQbSZ8O8lNFpPUTdE7KeW1sHifY=
X-Gm-Message-State: AOJu0Yyn0Vkx3I4ePQcXO1V4z26TInSF9xBlQ4GCMZRLrZ5z3oUebu1f
 sgA7scCcSbeDtxGK+wUTpWfbGMzQXOftrm1XVW0BKKLQffbXaxy89T/pHMVOnlI=
X-Google-Smtp-Source: AGHT+IEoOe9USr/ZchT9KQX0EH+1KHtpml1Eosj/ugoW/5WxVtA6rY1te/VAfUF0L7HyR80fmUjYpg==
X-Received: by 2002:a05:600c:46d5:b0:428:e820:37ae with SMTP id
 5b1f17b1804b1-428e8203c23mr109476355e9.1.1722972436808; 
 Tue, 06 Aug 2024 12:27:16 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-141.dsl.sta.abo.bbox.fr.
 [176.184.43.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd059e60sm13920147f8f.82.2024.08.06.12.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 12:27:16 -0700 (PDT)
Message-ID: <4ed90c17-03ab-4e3d-889a-42a986b625bd@linaro.org>
Date: Tue, 6 Aug 2024 21:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] system/vl.c: Expand OpenGL related errors
To: Antonio Caggiano <quic_acaggian@quicinc.com>, qemu-devel@nongnu.org
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-3-peter.maydell@linaro.org>
 <871q31sr90.fsf@draig.linaro.org>
 <137030be-f5b0-45e4-97d5-0d17aa8d6347@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <137030be-f5b0-45e4-97d5-0d17aa8d6347@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/8/24 17:20, Antonio Caggiano wrote:
> Hi
> 
> On 06/08/2024 15:41, Alex Bennée wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Expand the OpenGL related error messages we produce for various
>>> "OpenGL not present/not supported" cases, to hopefully guide the
>>> user towards how to fix things.
>>>
>>> Now if the user tries to enable GL on a backend that doesn't
>>> support it the error message is a bit more precise:
>>>
>>> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display 
>>> curses,gl=on
>>> qemu-system-aarch64: OpenGL is not supported by display backend 'curses'
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>   system/vl.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/vl.c b/system/vl.c
>>> index 9e8f16f1551..213ee6a6a92 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -1973,9 +1973,10 @@ static void qemu_create_early_backends(void)
>>>       if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && 
>>> display_opengl == 0) {
>>>   #if defined(CONFIG_OPENGL)
>>> -        error_report("OpenGL is not supported by the display");
>>> +        error_report("OpenGL is not supported by display backend '%s'",
>>> +                     DisplayType_str(dpy.type));
>>>   #else
>>> -        error_report("OpenGL support is disabled");
>>> +        error_report("OpenGL support was disabled when QEMU was
>>>       compiled");
>>
>> Maybe "OpenGL support was not enabled in this build of QEMU"?
> 
> To stay aligned with the other changes, this can provide even more 
> details with another hint.
> 
> "OpenGL support was disabled at QEMU configuration time."
> "It can be enabled by running `./configure --enable-opengl` before 
> compilation"
> 
> 
> BTW, whole series:
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>

Thanks Antonio. I already posted the pull request and it is
being tested. I'll include your R-b tag if there is an issue
and I need to repost it.

> 
> Cheers,
> Antonio
> 
>>
>> Anyway:
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>
>>
>>
>>>   #endif
>>>           exit(1);
>>>       }
>>
> 


