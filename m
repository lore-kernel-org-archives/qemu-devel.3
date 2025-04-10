Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E658C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ufT-0007NE-Jv; Thu, 10 Apr 2025 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u2ufQ-0007Kl-4i
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:22:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u2ufO-00055j-38
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:22:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1931607b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744302131; x=1744906931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/t/zE7tz7oNJ0G7xkwZxsIaDEUKu53O69xjhAFfo1as=;
 b=eiuBB3QPTU/psx7V5pT9tTakY6gDudYFP/3WqK6C5wVsFwZqAaEcKbGxLtUC75/sMg
 rGQfQPeinJJAtLUxghgjiL/qQcbxEpXgQd9sHIHv447Cw6yd/g3rjlR8WEialUKcYhfu
 +IABvzf+Be4ZvJ4gJ8jBmrsIbHPwel3M7VUOypdiBJROWKnVb/a/3W9yx55LEQ10u/nO
 NNNVyhN6EhArHmBgTrBJ4EbIXmm/fd/h8v+qMfzVvuaBtzTnCq0xasf3wGpbqE0tNFnp
 6peq0V+Lp5c12lf26+WcCkgXHu691Kj4jVPonYSVD3x1Y6pfCNnC0xgv+2nFiLfK20QS
 yeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744302131; x=1744906931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/t/zE7tz7oNJ0G7xkwZxsIaDEUKu53O69xjhAFfo1as=;
 b=oPIAYTUuvVNCwGi4gTVMF7tMiVALBfgN078gbI4QONva10FGn5UFh+vxX4VFZRb6gf
 N8lvpR2LXAOKY83qmuzacJ1Y9M1C2FcJMHse2/mhFDxcNW1/F7AbmVxswSoe8sKs2CvQ
 iI58YO7/cP6uF/4ecXznl9Lo98D1q2Sf8KGzPVRiXv7Y1gSC92BxYm462Up3eH+Xv22T
 1gMmQA3jlpAGFWebGcZhGG3y0bFc9NFVgEbuOYEwjbczsZjbEvyTcFyv8dn6jpczg3Gm
 tDK/yJpwGzS00bTHv6AJf/7hIGzWmCysRPT0RF41Vg6QZFQX82cNvPKQaYTDm8n6MMHz
 ZPpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXw1uXBNPyIXYvQwfqjtXOSyUA2AK729f0b63VG40KjENPc3+EyWd4fQaWLzcmexxfmMdyuCcu2JBn@nongnu.org
X-Gm-Message-State: AOJu0YxKC9yukcIsvBJ+zHZ8YZEk19NcP3FBX/8MOIQBufaqhNYAo/00
 dXmp7lW4nk1NH2I8/070fT9A1hSKIvLDj+ATnvw6oAWezmreR8EWyOlwDdoPx3Cp7qeYJ67m2ZM
 3
X-Gm-Gg: ASbGncv5XshvfiCF1q3XfBcJ+KkfLIDuGpVh/nqVRHJXy8t/9aVk7MEYmcThDt9NtUL
 1uQXY8FVhGpIJStAmzrZalWtqoIFXlM8S7otXXJWb3Eltdp8MSZIoPdbNtYoq7a8pr/WQXrTeAs
 GOJFW6MQvdHBm20y3ORNXikEoETgL0Lp2mXJ9VLdAHlScsWvW1vtT/m1fiDw8ubohoxzJ2sm0pH
 VQpHS6OPlm5ircQoWU4AqMm2v7AHLh4CcjOxrZekj9DmCl9CYdcMho3JBcSSCB5oVHb3C2eCN12
 8u6GXzUDtYjkSvHbBPBk6decypNnQmNCNUFRVcgKyQzKqg0qJryo
X-Google-Smtp-Source: AGHT+IEfExYtqW55wAPTke0HUDqx0JPkstK9uVbVx/cXpb7V6qOpbTfb276SnWQ7Jm2yLNBzHirUgA==
X-Received: by 2002:a05:6a21:b82:b0:1fe:61a4:7210 with SMTP id
 adf61e73a8af0-2016a177367mr5163674637.2.1744302131511; 
 Thu, 10 Apr 2025 09:22:11 -0700 (PDT)
Received: from [192.168.0.102] ([152.250.123.8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a0817e08sm3238732a12.12.2025.04.10.09.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 09:22:11 -0700 (PDT)
Message-ID: <ec5cec94-4d02-442e-94e6-c0c2e79f3684@linaro.org>
Date: Thu, 10 Apr 2025 13:22:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
 <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
 <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
 <20250410085042.6aa5593d@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250410085042.6aa5593d@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Hi Igor,

On 4/10/25 03:50, Igor Mammedov wrote:
> On Wed, 9 Apr 2025 12:49:36 -0300
> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> 
>> Hi Igor,
>>
>> On 4/9/25 11:05, Igor Mammedov wrote:
>>> On Fri, 4 Apr 2025 00:01:22 -0300
>>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>    
>>>> Hi Phil,
>>>>
>>>> On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
>>>>> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
>>>>> test. In preparation, copy the ACPI tables which will be
>>>>> altered as 'its_off' variants, and whitelist them.
>>>>>
>>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>     tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
>>>>>     tests/qtest/bios-tables-test.c              |   1 +
>>>>>     tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
>>>>>     tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
>>>>>     tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
>>>>>     5 files changed, 4 insertions(+)
>>>>>     create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>>>>>     create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>>>>>     create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>>>>>
>>>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>>>>> index dfb8523c8bf..3421dd5adf3 100644
>>>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>>>> @@ -1 +1,4 @@
>>>>>     /* List of comma-separated changed AML files to ignore */
>>>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>>>> +"tests/data/acpi/aarch64/virt/FACP.its_off",
>>>>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
>>>>
>>>> I think your first approach is the correct one: you add the blobs
>>>> when adding the new test, so they would go into patch 5/9 in this series,
>>>> making the test pass without adding anything to bios-tables-test-allowed-diff.h.
>>>> Then in this patch only add the APIC.its_off table to the bios-tables-test-allowed-diff.h
>>>> since that's the table that changes when the fix is in place, as you did in:
>>>
>>> if APIC.its_off is the only one that's changing, but FACP/IORT blobs are the same
>>> as suffix-less blobs, one can omit copying FACP/IORT as test harness will fallback
>>> to suffix-less blob if the one with suffix isn't found.
>>
>> OK. Just clarifying and for the records, this is not the case for this series
>>
>>
>>> if blobs are different from defaults then create empty blobs and whitelist them in the same patch
>>> then do your changes and then update blobs & wipeout withe list.
>>
>> Thanks for confirming it. That's what I suggested to Phil in my first review and what
>> I understood from the prescription in bios-tables-test.c.
>>
>> However, on second thoughts, for this particular series, isn't it better to have the following commit sequence instead:
>>
>> 1) Add the new test and the new blobs that make the test pass, i.e. APIC.suffix, FACP.suffix, and IORT.suffix (they are different than the default suffix-less blobs)
> 
> blobs should be a separate commit (that way it's easier for maintainer to rebase them,
> if they clash during merge with some other change.

I see. What is a bit confusing here is that the series consists in
one blob addition act (for the new test) and one blob update/removal act (after the fix).


>> 2) Whitelist only the APIC.suffix since that's the table that will change with the fix
>> 3) Add the fix (which changes the APIC table so a new APIC.suffix blob is needed and also stops generating the IORT table, so no more IORT.suffix blob is necessary)
>> 4) Finally, update only the APIC.suffix blob and remove the IORT.suffix blob and wipe out the whitelist
>>
>> This way:
>>
>> A) It's clear that only ACPI blob changed with the fix, because there is no addition of a FACP.suffix blob in 4) (it remains the same)
>> B) It's clear that the IORT table is removed with the fix and is not relevant anymore for the test
> 
> I'd just mention it in commit log so  that later no one would wonder why we are adding and then removing tables
> 
> As for the rest of suggestions, it looks fine to me.

Well, 2) won't make sense anymore since APIC.suffix would be already in the
whitelist in the previous patch that added the empty blobs. Since there won't
be a commit that adds _only_ the APIC.suffix to the whitelist, in preparation
for the fix, this info is "lost" in the series, even tho it's possible to
mention in the commit message.

Hence, what I think is not ideal from a maintainer's/reviewer's perspective,
is that in one commit all the blobs are updated/removed at once, which is
confusing because the fix did not touch the FACP table (for instance) and
this table is updated with APIC and with the removal of IORT, altogether,
in the last commit.

So, for this series, which adds new blobs and _also_ updates and removes some
of them, how about the following organization:

- Patch 1     : Add the new test, add the empty blobs *.suffix files, whitelist such a blobs
- Patch 2     : Update the blobs in Patch 1 with the ones that make the new test pass and remove them from the whitelist

- Patch 3     : Add the APIC.suffix blob to the whitelist (the table that changes due to the fix)
- Patch 4 - n : Fix(es)
- Patch (n+1) : Update the APIC.suffix blob, remove IORT.suffix blob, and remove the APIC.suffix blob from the whitelist
               * Add the APIC diff to the commit log
               * Mention in the commit log that IORT.suffix is removed because IORT table is no long generated after the fix

This way: a) no commit fails the test and b) blobs are added/updated/removed in separate commits

What do you think?


Cheers,
Gustavo

