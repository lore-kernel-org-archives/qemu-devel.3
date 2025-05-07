Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF8CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgRZ-0002FF-Ie; Wed, 07 May 2025 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgRW-0002Ex-Qd
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:12:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgRV-0003vw-0D
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:12:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso46251735e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746630735; x=1747235535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzBlYOX0IlXo8vZKk9efo8oA0oQLzBVW6Ko1lj2Feg0=;
 b=KWK9TKxVucS2voFkscNus2C3PLppsJcfZBnXg8G5a79EAU7LwHDYtZYh1SZTNfBw28
 qy4DWvrkB6M0FiBkEqW/V+96/t8JjqkgZ14iddQYIFNq4QgArHHdA0vojArJZvPJUf4q
 aB2Mn+0NlxGNlJ84CJ55HEB96D06abIruiRB/SZHwqTD1VuQ9Yan9P1wKYQsqVrDRJC+
 ulevCObfG0wp8ec8OyUhXwoHIlrDJy3vDG62coNCW8S+UFHc4S3HGMkU9Jz+/+UlhYWF
 B1/ozR4ohG6icPcgt/GEz1d+kCO52ScdXOKiw8eWhJHOeu4Avd3MQ4YDrxs2MZ+1jgQW
 vOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746630735; x=1747235535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SzBlYOX0IlXo8vZKk9efo8oA0oQLzBVW6Ko1lj2Feg0=;
 b=QZBOYqmi8dA/iQzpvKqt2LcQr7rSOj6W4RsP5yjMGy4ac9lRL38uYq2O31TbWKvibV
 tsPmaf+p2nvrFgzyFIFPjK2+dvDviQ8F/raoUv8HKgX3if18WHAc4nVIaTC2tZAixB5H
 krBD6xPJ/9EEBySx8d4W/+9LTcYavAystKDJ0bGCSwyeChCF/igDRj2jlO/mm+oCnfXJ
 x1INNw4jJRmpPDWIoXaZNYEiftl4aXCrtZdsVrwIU8FQjOZbA0ndrgQZZFnc2bMqeKtG
 aEf2IBE6n/Mrn8or/mgV+LqNQ7Tvh5wZjU5M4BGZgWEYMY48KBej8pR3oU6od9UOXS3W
 DhOw==
X-Gm-Message-State: AOJu0YyGPI3Jsg6F6I1o7pw7Y6UajCl0w93rQXXHnABzK72qfciVji9L
 eDT+pWWkVe8EA+ekJE8cfmR1WR10FauaW2wOS09G7pi40/P22q09RrXklXr1L6w=
X-Gm-Gg: ASbGncsPyrqoZzZ/tasa+Rn6976KaJir8XVU4wYsxa7VvAj1v6EG6UT4/AKNPAXNRGl
 tfXuyKRF41OfVOlCTPcDtKsQ1CXhflfpwTXXLS7phmWQHxnprcyvLQfsNjbXgIl7aJv7+eH/4HW
 jwQV1atc90AYt2C0radONsvTajOle8aeFRENM5aC32RNipRd9gZ76ZGznlWNMyuNTICK0mJX/o1
 +THTr/FeTgpFUWHRSPbV8T+XX4fIJDlsxwiXMWQ+8Fy1xcY7nI+X2Kh5+a0nmBtJlPvzF+Nx/dq
 B8TWVxfvxNVm6fta/e6AOUHdcTDCz7Z1mrIy5LaTBqf0yGHMMuGIXaLG/0+JJF4Ljzk9Xlkuu4R
 0Xi3gkJoykzE7C9uR9oipHlsDMa36ukw=
X-Google-Smtp-Source: AGHT+IFbM2xgPJTTNRnWkRuri7Hem5HdRrK0RXRctw0dmEXbwyDQaF8NC7RgyTFjmpPVNI1ciZZJ1A==
X-Received: by 2002:a05:600c:3d15:b0:43c:fded:9654 with SMTP id
 5b1f17b1804b1-441d44c7e76mr34256835e9.19.1746630735231; 
 Wed, 07 May 2025 08:12:15 -0700 (PDT)
Received: from [192.168.1.70] (lputeaux-658-1-173-28.w92-154.abo.wanadoo.fr.
 [92.154.108.28]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeca5sm4103135e9.26.2025.05.07.08.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 08:12:14 -0700 (PDT)
Message-ID: <f837e991-f752-4dcc-9a27-61fecb8f9c7d@linaro.org>
Date: Wed, 7 May 2025 17:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20250429100419.20427-1-philmd@linaro.org>
 <877c2sjxf3.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877c2sjxf3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 7/5/25 16:41, Markus Armbruster wrote:
> Cc: author and reviewer of the @deprecated-props feature
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> We'd like to have some unified QAPI schema. Having a structure field
>> conditional to a target being built in is not very practical.
>>
>> While @deprecated-props is only used by s390x target, it is generic
>> enough and could be used by other targets (assuming we expand
>> CpuModelExpansionType enum values).
>>
>> Let's always include this field, regardless of the target, but
>> make it optional.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qapi/machine-target.json | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 541f93eeb78..3b109b4af87 100644
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
>> +            '*deprecated-props' : { 'type': ['str'] } },
>>     'if': { 'any': [ 'TARGET_S390X',
>>                      'TARGET_I386',
>>                      'TARGET_ARM',
> 
> When I see "optional array", I wonder about the difference between
> "absent" and "present and empty".  The doc comment doesn't quite explain
> it.  I figure "present and empty" means empty, while "absent" means we
> don't know / not implemented.
> 
> Is the difference useful?
> 

I'm also happy to implement as "present but empty".

