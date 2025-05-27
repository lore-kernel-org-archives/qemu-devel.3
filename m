Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F62FC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxjT-00068q-Nu; Tue, 27 May 2025 13:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxjQ-00064p-PF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxjJ-0006iu-Hb
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-232059c0b50so30806015ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748365483; x=1748970283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FU2mLH5N4KnCmJozne3wBdtV5SuuOW0C90vlX9UqDxk=;
 b=bDLoraVKReKvjxoQ4B2qY56OGLyDORNO63+5dFHmOHhZzExxYsSBUTo6Q9W10j/zxE
 fSc0pNb0QdjOTMPT6Kfx5D9S3DtV8eNAQlCZGcUp+pnmZpBBR4simO7Lfj2cZFKttLOE
 cY3F2eR+EOTdZopOHrxd13uVB9V6SzM2xKT+NU2Hr6+s+qFQzcIhxzfaGYrIHF893bJl
 nm6xMzcA+Z7T/45W7ygPNL63ZgZYt1CgQs/L1bYklr8aQXM0S94zFudRr+NO0pYNK9as
 wvxfUZZGI+PihZ8DtQM5D0u57YzUNvRQZ+Hr0iwbtXS1ZiqmuzDKC7+TgLCgdDVNB+Z8
 O3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365483; x=1748970283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FU2mLH5N4KnCmJozne3wBdtV5SuuOW0C90vlX9UqDxk=;
 b=mI6cHjsR4nbTWC+7eM235iRQFFBQWm41xnVNea+tyFTccqsoOGejIGSE/fgpJP+M6e
 8bW8EbzAC5i8dol4VVaUwSK4y03rZhrK+A/7zCa/+NPnQc2Wqj3lWQQ1osFcOeVAW5A+
 Sq1LR8QO1Tc5EKze4SZbXtEyUyxwrs6Ejg5EhsgA0P5skaV3+colqIQ5+Wqkc/bMjv+p
 ykv8DS01tHvon7PW9mi+Ecz9/NKdkox1sVcBesPfHkV82ouGzD6wxCD1qUnuesC6dwJq
 EGQZXsvUo4sSWg/VaayLYG13CIZ1c5vxpRcSpOuOTCVMK+5LIZjugwccICti5bDRdIoC
 9yWQ==
X-Gm-Message-State: AOJu0YwpEWhFj8tysDAfRPtDtf6M33ILg647nD9fT23VsgS5PTpQjOoj
 t8RoWiyRtmV1nas8hY4f8zZZnvFopcwaa6E5iPg3Qtp0qkyWn8ffEDF8OvDwnWHoEZw=
X-Gm-Gg: ASbGncsVJ+qxa8GJsfTbFnN0Y/QrxDoZGwSSH4s6FFqNZZgLUVdT/FJbiB7VEVxykuk
 WXbXpA/BTz2XjHJefN9VGqXXnRD7QNmrnbB6RgTVL9benaBoekKuXLbWfOYZ64CyMBecKxqsLS2
 +pHPgj09I/XPde+hGBevb7rfpN1KGrI8w3/84pO2l6TOoE6o/HTLr2MgifB8ebpE7QLnDBwubiV
 7vHb+W1hUa6oPSlJFPsg1sTjooh0HTiwi8ZYysBYseJCAcnF5dbpMWkR3Vz6XXA24VEVm7hxU9E
 UWmNxtjWZJK0rBV+SiauPKRXL+VbfDYBmpyX8d4cURQ5kyIu6eC7TLY4F2uMJYdGLYCI/8aeuJ0
 =
X-Google-Smtp-Source: AGHT+IHmi9YSCZfXyK0b6mH15UcOyRDtVZSixgBOYRIS8Q+dwAL4AHtCBghROKYKTM6YmtoJtEthEg==
X-Received: by 2002:a17:903:2402:b0:234:986c:66e0 with SMTP id
 d9443c01a7336-234986c6c8dmr44473415ad.4.1748365483253; 
 Tue, 27 May 2025 10:04:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23446fb5338sm45488955ad.224.2025.05.27.10.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 10:04:42 -0700 (PDT)
Message-ID: <a856a963-4bd5-4cb0-9ac5-6e18316f3279@linaro.org>
Date: Tue, 27 May 2025 10:04:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] qapi: Make
 CpuModelExpansionInfo::deprecated-props optional and generic
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-9-pierrick.bouvier@linaro.org>
 <87bjreqofz.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87bjreqofz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 5/27/25 4:32 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> We'd like to have some unified QAPI schema. Having a structure field
>> conditional to a target being built in is not very practical.
>>
>> While @deprecated-props is only used by s390x target, it is generic
>> enough and could be used by other targets (assuming we expand
>> CpuModelExpansionType enum values).
>>
>> Let's always include this field, regardless of the target, but make it
>> optional. This is not a compatibility break only because the field
>> remains present always on S390x.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   qapi/machine-target.json | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 426ce4ee82d..d8dbda4b508 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -244,19 +244,18 @@
>>   #
>>   # @model: the expanded CpuModelInfo.
>>   #
>> -# @deprecated-props: a list of properties that are flagged as
>> +# @deprecated-props: an optional list of properties that are flagged as
>>   #     deprecated by the CPU vendor.  The list depends on the
>>   #     CpuModelExpansionType: "static" properties are a subset of the
>>   #     enabled-properties for the expanded model; "full" properties are
>>   #     a set of properties that are deprecated across all models for
>> -#     the architecture.  (since: 9.1).
>> +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
>>   #
>>   # Since: 2.8
>>   ##
>>   { 'struct': 'CpuModelExpansionInfo',
>>     'data': { 'model': 'CpuModelInfo',
>> -            'deprecated-props' : { 'type': ['str'],
>> -                                   'if': 'TARGET_S390X' } },
>> +            '*deprecated-props' : ['str'] },
>>     'if': { 'any': [ 'TARGET_S390X',
>>                      'TARGET_I386',
>>                      'TARGET_ARM',
> 
> [Copied from review of prior posts]
> 
> When I see "optional array", I wonder about the difference between
> "absent" and "present and empty".  The doc comment doesn't quite explain
> it.  I figure "present and empty" means empty, while "absent" means we
> don't know / not implemented.
> 
> Is the difference useful?
> 
> Daniel doubts it is.
> 
> [end of copy]
> 
> Let's take with this patch as is.  If we prefer to remove the
> difference, we can do so on top.
> 

I didn't answer to this question because I have no opinion on it.
If I have to pick an answer, following Daniel, I doubt the difference is 
useful also, as it's not changing anything for s390, which is the only 
producer for this entry.

Thanks,
Pierrick

