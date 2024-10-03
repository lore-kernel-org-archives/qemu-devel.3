Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE31CF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTZ6-0002gP-Sr; Thu, 03 Oct 2024 17:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTZ4-0002g3-IC
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:40:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTZ0-0000UL-U7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:40:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so18595425e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991645; x=1728596445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0JkjeW+iwNR/9umx1xyK0/ZhR/7AWfTopD/a4EHWsg=;
 b=oWa6f2OPIBf0rjIH/ocM4SujptdzABtQ3NKgQL/bRRbkBQTG+qdPW/c9j9KtX8k/XO
 qGh/NNR3mphfFxc5/YrDUeVSMCHz0fAGvQOnIBv+jGupw4t8nCzMZSh0ZIOOezOWTa19
 YSKy9bwpqjQSymV/FWk1AbyphVhTGoXiclK4YbSIL8fvVONYWQeAzIld2d4f8yP3/fTI
 oTakQ2ukvUEMh8vOxUlIQT3b0cy4rFh4IkIzNZ8BS8g15TCsK4Eco7UHpY8rJg33mP9t
 yhtcssYWna2nFtmFH2E3T13npLHIxbFrqr9DG9n6lPZG/iALiL2fQYA/vLzu1/7Gyv2q
 1N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991645; x=1728596445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0JkjeW+iwNR/9umx1xyK0/ZhR/7AWfTopD/a4EHWsg=;
 b=uL4hGrVi8eS3aVveY9v7VQgIjrw69ee9Qd6iLJO5nzGxYdZVkYo5a4xwzxV/6fMNut
 lHZ9eMGQckkztli89MSJNz+oMmzwwjPpDJyIjCZiHQpPU/4MApUrYNuVRYGVNvmLCnhp
 vAFcEDQkKSdzPTCfAOXbCmwZbmefgPnxG0sI62coy5BSfIYirwSH1hg7vBC6J8YNEgNp
 01OPuYH0XaurwQii12wOoPTwQIGMNkN4FHIqGmThjfVFWgaRjrmofXbbABP9xJsysMg6
 XP2NO25adEjspdcPTvVTRWxZZ3ggqffRYIczFneP2A2t/YP/iWTKgQmSBvYrQfj8p5Af
 afww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4BvD6BVsb560Kz/cxdGc6UzmVV+IRGRXSIkHYZx+R27NsXQTSmBKnnraJidQhZJAonfAacnQuHajp@nongnu.org
X-Gm-Message-State: AOJu0YzdP7sf3eixYF099AM2lzTErfqOLRk83mpKTc4PEfBAfudO+AEH
 AR9jNkigciXbI7BHqupo2kmrKs8NEiz5Gy0iP7XvWAsDXPDlOSrW+6/h3n3jVpA=
X-Google-Smtp-Source: AGHT+IFmxK7ExvMGjbeooa/S2st3bhrbhsOrS0Cr6n9lWkHr+3z60Xtz+EUrbhIlcwudW09hcQbgvw==
X-Received: by 2002:a05:600c:1f96:b0:42c:bbd5:727b with SMTP id
 5b1f17b1804b1-42f85ae974emr3461645e9.25.1727991644750; 
 Thu, 03 Oct 2024 14:40:44 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f80255ee9sm24163045e9.8.2024.10.03.14.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:40:44 -0700 (PDT)
Message-ID: <a1a67f7c-553c-42d4-b852-2cc26e7181a0@linaro.org>
Date: Thu, 3 Oct 2024 23:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
 <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
 <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
 <aeb88605-989b-4c26-9371-15fbe44a9e3a@linaro.org>
 <46ea20fd-c6bc-411a-b8e2-ab7179c00185@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <46ea20fd-c6bc-411a-b8e2-ab7179c00185@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/10/24 23:34, Pierrick Bouvier wrote:
> On 10/3/24 14:31, Pierrick Bouvier wrote:
>> On 10/3/24 13:48, Philippe Mathieu-Daudé wrote:
>>> On 3/10/24 18:04, Pierrick Bouvier wrote:
>>>> On 10/3/24 09:02, Philippe Mathieu-Daudé wrote:
>>>>> On 30/9/24 16:32, Thomas Huth wrote:
>>>>>> On 30/09/2024 09.34, Philippe Mathieu-Daudé wrote:
>>>>>>> Replace a pair of memcpy() + tswap32() by stl_endian_p(),
>>>>>>> which also swap the value using target endianness.
>>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>> ---
>>>>>>>      hw/xtensa/xtfpga.c | 6 ++----
>>>>>>>      1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>>>>>>> index 228f00b045..521fe84b01 100644
>>>>>>> --- a/hw/xtensa/xtfpga.c
>>>>>>> +++ b/hw/xtensa/xtfpga.c
>>>>>>> @@ -438,11 +438,9 @@ static void xtfpga_init(const XtfpgaBoardDesc
>>>>>>> *board, MachineState *machine)
>>>>>>>                  const size_t boot_sz = TARGET_BIG_ENDIAN ?
>>>>>>> sizeof(boot_be)
>>>>>>>                                                           :
>>>>>>> sizeof(boot_le);
>>>>>>>                  uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : 
>>>>>>> boot_le;
>>>>>>> -            uint32_t entry_pc = tswap32(entry_point);
>>>>>>> -            uint32_t entry_a2 = tswap32(tagptr);
>>>>>>> -            memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
>>>>>>> -            memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
>>>>>>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 4, entry_point);
>>>>>>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 8, tagptr);
>>>>>>
>>>>>> Why don't you simply use stl_p() here?
>>>>>
>>>>> We want to remove the tswap32() calls...
>>>>>
>>>>
>>>> I think is point is that you could directly use stl_be_p, instead of
>>>> stl_endian_p(TARGET_BIT_ENDIAN, ...).
>>>
>>> TARGET_BIG_ENDIAN is defined as 0 on little endian, and 1 on big one.
>>>
>>> The following change isn't worth it:
>>>
>>>      if (TARGET_BIG_ENDIAN) {
>>>        stl_be_p(boot + 8, tagptr);
>>>      } else {
>>>        stl_le_p(boot + 8, tagptr);
>>>      }
>>>
>>> Maybe I'm missing Thomas point, as the xtfpga machines are available
>>> for both xtensa-softmmu (LE) and xtensaeb-softmmu (BE).
>>>
>>>> I don't know if your intent is to make be/le variant "private" and
>>>> relies only on endian_p though.
>>>
>>> My intent is to enforce endian agnostic API uses when possible, and
>>> use LE/BE specific variant when it is known at build time.
>>
>> Oh ok, it's me who missed your point then.
>> For some reason, I thought we were always calling big endian variant.
>>
>> Thus, your implementation makes totally sense.
>>
>> Let's see if Thomas meant something different.
>> Else,
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Looking more closely,
> stl_p is already correctly defined when you know at compile time your 
> target endianness. So Thomas was referring to this.
> 
> https://gitlab.com/qemu-project/qemu/-/blame/master/include/exec/cpu-all.h?ref_type=heads#L49

OK I guess I'm seeing Thomas point now; this series cover was not clear
enough. The goal is to remove TARGET_BIG_ENDIAN so we can build half
objects and do a little step toward the single binary.

Maybe I need to kill the stl_p & Co functions first, or do it while
suggesting this target agnostic replacement API.

