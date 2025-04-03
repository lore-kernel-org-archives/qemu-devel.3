Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E140C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 06:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0E3S-0003LG-0k; Thu, 03 Apr 2025 02:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0E3P-0003KZ-Vy
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 02:27:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0E3O-0007OO-7e
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 02:27:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227b828de00so5609365ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743661673; x=1744266473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t9XCw/hGZx53ePP4u3QzEuyWB3/JZzErX8wnWHAT89s=;
 b=fZSXSPTAAhz3hH7jxGJb8w7G/xXoFkukPC9eIuXRvZViXDTVyHt2lXcVbS5dHHA63y
 TIe+zwPZXSoVucAiRJfwnFbD/LmwsYGLmp+OycCd5dtyHUcIKA8DuZmmJMydEyJCLrTH
 MVeVBJ8G24I9Sqs3yFUyoCxbTUd1iUDCFZfqMAthQxjaktPRy5Q64+GL3AEgBvz9il+W
 H3Sos7cL5n8V0kPVEn+xfGlilxO83wn59jWvqQtc3IXGykuRUNR5o9V9TIs+yvb5gDE7
 tlMmsIEMn7KufldDdif4nTX2o7XclvEqTNw1BQsfe0pEng8rS5+wM4YJO3ORr5L8WoYf
 /iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743661673; x=1744266473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t9XCw/hGZx53ePP4u3QzEuyWB3/JZzErX8wnWHAT89s=;
 b=fs/Ac94rzZ6C0AkHxAfC6B/ut1n9RqK3vDsjSIakAUL+/OqupHWEJiFdnFLlUhq54g
 nXEWSgP1IVHyCiaWKdUbJQnzkPqlPZX/2P5rmGkQNmPh4iGsFCABnH+ldUH7FK+VFj8D
 N1jrR5nnsidqDWH/nlrCza7myNA2adOQijqiaM1L8sAiYUoARSs61yj5Xw/0eTteBOhA
 9LOvoOoSVlfo3P2jokAkegNgqTRPEJfc2m0cYSLGu4FXsQy0eRLsHftnEoYALJDJZzuk
 UZTKKbago060TVnk+OyORJlzy7VuL2m3kEAgiLIhAhlphHAOUTwb57fq24ueoeZh0NLD
 Tk1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeok11I8/ZhTMDV9UTLPnYjpj5UP1VetP6wlAMwOKfg7vqDkwVhY+CKRvORNPMNzTBvglPnIW+4LIl@nongnu.org
X-Gm-Message-State: AOJu0YzQDR1cVXOMu7UZD1MRPo44UmY6y0v6D3SsF0zk5VQa0L8asaot
 M71wCZpsEDm53bDV70M7AnoJTABjn7evTCcIf0268VBdZS2yAvIJC1vxotCwxmM=
X-Gm-Gg: ASbGncuHm7X0HqF83nvi5n4cuAf+smGKaenPCd0GtaKuwfxZ/AYOs5V9HHLtAmff4oU
 kN+pnRZj9azoySEh9AUSgq/cT4h47IeUJMTIatGJxlNcnt65VGqMGuchWsJovoGajsomRs9ABOQ
 ZICdwrCyU/IgRO0iOkF4wvuKataiT+NtP518q3SBcQMhZdj0K+1u79yI8w2CgzsUJ3AEK5EQFxi
 0zV3PKJ+zOvKIN344lsto7G+WRq2gNdWurrU0w91xYJ7dTkyMhVjdMlD66IhwV+s4nh8esb3rJo
 sB9SXmll3On9DArzynQQKYdK0XL4g6vLG6HnHhDOqXhmTLMqynAe2B/M
X-Google-Smtp-Source: AGHT+IETkOi5fNsC7HaX11W8yM+4/X7f3h1d17E6ybMJ5n4W5KhOakj1Innft7pjTllVZr4Q0oTiEg==
X-Received: by 2002:a17:902:e746:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-2296c829906mr82948745ad.38.1743661672596; 
 Wed, 02 Apr 2025 23:27:52 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785bfffasm6716315ad.61.2025.04.02.23.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 23:27:52 -0700 (PDT)
Message-ID: <5eb3e23f-2d82-48b1-abd8-68dbfc1f5b6b@linaro.org>
Date: Thu, 3 Apr 2025 03:27:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 2/5] qtest/bios-tables-test: Whitelist
 aarch64/virt/APIC.its_off blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-3-philmd@linaro.org>
 <957f0d3e-0c25-4d88-b935-ddfe7cc75776@linaro.org>
 <dffb0578-e449-4984-9a86-d675eff93485@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <dffb0578-e449-4984-9a86-d675eff93485@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Hi Phil,

On 4/2/25 07:31, Philippe Mathieu-Daudé wrote:
> On 2/4/25 08:43, Gustavo Romero wrote:
>> Hi Phil,
>>
>> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>>> Prepare for ACPI table change in aarch64/virt/APIC.its_off.
>>
>> The comment could be smth like:
>>
>> Ignore APIC.its_off expected table (blob) for now until
>> we update it later, after fixing the code that generates
>> this table correctly.
>>
>> ?
>>
>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/ qtest/bios-tables-test-allowed-diff.h
>>> index dfb8523c8bf..bfc4d601243 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1 +1,2 @@
>>>   /* List of comma-separated changed AML files to ignore */
>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>
>> I think this patch should be merged into 1/2, accordingly to my
>> comment in 1/5. FACP and IORT .its_off files should be added to the
>> list as well.
> 
> No, otherwise the test added in previous patch fails.

I can't see how adding the tests to the list in
tests/qtest/bios-tables-test-allowed-diff.h can cause any failure.
The list in this header file works as a "ignore list", so even if
the .its_off blobs in 1/5 were empty (for instance) the test would
pass if they are in this list.

That said, as per my comments in 1/5, this preparation is correct
to me: the fix will cause changes to APIC table so the current
expected blob (committed) needs to be ignored until it gets updated
later, in 5/5.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

