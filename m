Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DAAD232F2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve80N-00047K-Un; Fri, 09 Jan 2026 03:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve80M-00046l-LA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:37:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve80L-0003ZK-3y
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:37:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a099233e8dso29938195ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767947875; x=1768552675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T2WjEmO+dGhdznKj7Cs0UfudPWwuc4Qw2p1frFQcUAE=;
 b=VvBDZrX7MiG3fZFvPZxb2mDAI6J2IhU5BHB6OWShshv8RgGk9ausD2fN1ywAghZwi9
 PIkEs0NrVtNnTbL9vPPwiGjtHqoP3o23/lJQUwTYczZEwVqL1v3nytGjzO1c/sswM+eR
 WgEhc3s3fx2+uWZKUOoKQxAkAEjBWow3Wjj0SxFn1M7Yh3LN72GLQMK7E7ras53cXsC2
 KK5LJy4AJIRdCzWPVu1nHT45kLFthM/LY3SFblZ57K8ozmEej/k/jgV0VbBykG1j5tG+
 SKvhoxgI2Qngii7k/B1xFnnsf8xtebdFuIeQqWxY36qdPR9RIIBNiFj6MH2DvVy+pfcD
 nXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767947875; x=1768552675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2WjEmO+dGhdznKj7Cs0UfudPWwuc4Qw2p1frFQcUAE=;
 b=C+DM8khpa+TJs22VnKlhV6gRxNfanW/G9L9dpqJCEhaspskDeO7tiVH3JkvLSK12Qi
 7m19rA0iPPOSAzDNYgdOpv0hEuymGPdECIajX9kxe+SJ+6jl1MoiZTRw9igxS19/x9wM
 wD4IWTvoE4d61nNtD2zKpgJLzRtDANDbTJtSrv/xPdJibmaPFf9ucxHV+Zgwo7hfnJfh
 Dj/EFaUK1cUeCAE96y2eXUAsVkmlaE4rB3yZAc187noXM+8mzgWZuokLNf9gbvO4xPOi
 GcCyLxJDIHOxsMWpUfk4EIR4XpWt/RrG4+E6a3Oo+UG2b0f0C41QB3pXVemV/zPL/Vfw
 CzFg==
X-Gm-Message-State: AOJu0YyeIal4cjpVfMI1c7Y8URmwQk89kJ6pwhCoXKqkWx15DPi1kfhR
 idu1tngVja9Y+F9XtcU2/J1M7AgelOCqUjH6RcSb85w7msjbHw1UjSaJJVLkoJ0TTn4NcGxpAqv
 hJnPv
X-Gm-Gg: AY/fxX4ALUEdnuZjqVqJn8xeqvxXCSllzabEudgcFlXkjugzB5CdVn4Q7Me8jM2WsFq
 bQaJ4qsvjF5xoljnVVFjDWB+GkNr1dgdsVOBubvUTNmKk07uW+9MkE8xzYgzO/BMFW7BfxcRJtL
 bGWGHR3P5sKetog8Q5qeIYj8M120j9PfOzgq1FTJ+j51/6WhvvkeelDU4ob/5ZDR0RGVOqLh0Gm
 kfL9xawPw1CSTS8KKN7b54MjknaOMUMqBmIB0+87j47Hk3DgaiWK/2xGGk1te1dUWJpwTAD4kye
 FuM+/PWCkDcUBT0AGrZbrvBajNmupaoVubhNVd9mRUU0JlWF1YvuLIhlLjCA1tMENLVhgxfH5MX
 54S4PIkIQ4TVALDqT7Z5iTx6f9bidBhQMy3NTyIw+bjpB4C4XgpG7gpyYYjm64bH0hwDMSL4HW1
 wTTmuBsOTvAFdbJCQICUMorRjDSGyx3ndb3puv6DljXZcCpbojPcZCgg3w
X-Google-Smtp-Source: AGHT+IGOgMgg1q0/SOL+t59qHmk5GbVFsYeLteK6JUEPEgu7LssvXFrTq/u41Wj5vTSObkL05urlOw==
X-Received: by 2002:a17:902:f685:b0:2a0:8be7:e3d0 with SMTP id
 d9443c01a7336-2a3ee41d127mr77596695ad.10.1767947875127; 
 Fri, 09 Jan 2026 00:37:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c39fefsm100121645ad.17.2026.01.09.00.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:37:54 -0800 (PST)
Message-ID: <bf2275a1-4eae-417b-b4a8-b0e66881df28@linaro.org>
Date: Fri, 9 Jan 2026 00:37:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260108163601.18676-1-philmd@linaro.org>
 <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
 <341da906-68c9-44e9-929b-30760883178e@linaro.org>
 <0e4437cd-0e4d-4e5b-9aac-c882ef1e9214@linaro.org>
 <d8792a35-340b-4a5b-8349-42ee3d050b2a@linaro.org>
 <87ldi7mc6c.fsf@pond.sub.org>
 <9678ac55-13f7-497c-92c1-3035593251f5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9678ac55-13f7-497c-92c1-3035593251f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/9/26 12:32 AM, Philippe Mathieu-Daudé wrote:
> On 9/1/26 09:18, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> On 9/1/26 07:58, Pierrick Bouvier wrote:
>>
>> [...]
>>
>>>> See my previous answer on v1, -Wswitch is used:
>>>> Reading the thread above, the only mention I find is the 3rd commit that
>>>> precisely change definition because -Wswitch is enabled with clang.
>>>> And it's not only a clang thing, gcc has it in Wall also [1].
>>>
>>> Yes I read that, I'd really like we use -Wswitch but IIUC we can not,
>>> so with that in mind I don't understand your request. Is that for the
>>> hypothetical case we can use -Wswitch in the future? Sorry I'm not
>>> trying to be picky here, I just fail to see the problem you raised :(
>>
>> We *are* using -Wswitch.
> 
> Oh... I guess I meant -Wswitch-enum then (which forces to handle the
> -- meaningless in that case -- QAPI foo__MAX enum values).
> 

Yes :)

> Anyway time to stop bikeshedding and call it a day (originally I just
> wanted to remove the duplicated qemu_arch_available symbol :) ).
>

I agree, and sorry for the discussion that has been triggered.

My original point was that a switch allows to catch missing cases, but 
*ONLY* if it does not include a default:.
So either stick to the array, or change the switch to remove the default 
case. Even though I prefer the switch (without default), I don't mind if 
you prefer the array at this point. You had my review on first version 
anyway.

>> To see that, delete the default: case in to_json()'s outer switch (patch
>> appended), and compile:
>>
>>       ../qobject/qjson.c: In function ‘to_json’:
>>       ../qobject/qjson.c:154:5: warning: enumeration value ‘QTYPE_NONE’ not handled in switch [-Wswitch]
>>         154 |     switch (qobject_type(obj)) {
>>             |     ^~~~~~
>>       ../qobject/qjson.c:154:5: warning: enumeration value ‘QTYPE__MAX’ not handled in switch [-Wswitch]
>>
>> We run gcc -Wall, which implies -Wswitch.
>>

Thanks Markus, that was my point indeed.

>> [...]
>>
>>
>> diff --git a/qobject/qjson.c b/qobject/qjson.c
>> index c858dafb5e..6287c93c67 100644
>> --- a/qobject/qjson.c
>> +++ b/qobject/qjson.c
>> @@ -213,8 +213,6 @@ static void to_json(JSONWriter *writer, const char *name,
>>            json_writer_bool(writer, name, qbool_get_bool(val));
>>            break;
>>        }
>> -    default:
>> -        abort();
>>        }
>>    }
>>    
>>
> 


