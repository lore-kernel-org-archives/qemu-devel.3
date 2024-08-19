Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322CFC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 10:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfzx0-00049Y-UD; Mon, 19 Aug 2024 06:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sfzwz-000495-0V
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sfzwx-0008NP-8n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724064561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EgfJONKpzcfgLVFjRif8NLudl6loORGWbItqn0JZniQ=;
 b=XkSVlhho4SOK4UJoWUrTa90APbUehLZZWWjHmLu1BxM6hjrXEATArl8H2WAnXRwHVkzP6I
 MlaX8zla3sxlmaIqAySVPHgxHzOcRVcDerheJA/46AfFe6p+0Y1j9l5dubdB/4zCc0kosi
 r9t5EPHzgoPX00N46NjVIsqmM8+22uc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-ypQTxAozM_u3HvWrdgss8g-1; Mon, 19 Aug 2024 06:49:20 -0400
X-MC-Unique: ypQTxAozM_u3HvWrdgss8g-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3db13c4f5dbso4164711b6e.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 03:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724064560; x=1724669360;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgfJONKpzcfgLVFjRif8NLudl6loORGWbItqn0JZniQ=;
 b=wPU0QocOgqKUvErH5thY9fP209QgmoCLANybmxNAf/wtkC7M+Hi3BgAgO/ZfQHDVJ6
 GDVZu3TKkkwg2lmGG//QipuFtWr6QTsZY+qCYAqdJiY+npCTjf4A8IKMida4SYsZzpd2
 o8315Z0UQbJsqwh8VdbgzOH7Lw3+HjuZp53I2p+QRPgz+GX4SGgqQG0VMbUBFmkqNrDP
 JSPoWXFFrwidhDA7jHydjXcx5hOcxe6raUtDsPuaY0xFCYvSKbI1ZdfKtqmGxBDdGz5l
 Y0/QJYCeRvh0tlnNYfUUo8WAHvIxvd7lQ8HV62Gh6ZI0+pORQK7wJwFNM0KAmNMXGdBE
 pSOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeXcMOSWPFR0tWdguzXBWDSlaeq9lrDBbCEkPeeZe3Vcoz3Bjev0rznyJc4ejTCFoo5qXqWw+7Nr6dw2sJevsMyP2jSv8=
X-Gm-Message-State: AOJu0YxOPK/TLQWhdq7hMkWy6xnjjWwBT79Cz96/MDaWKKzKFbBzhuZw
 sPFK/BkMmDThJAzB8vw5Bx3Ws7fhCVfuAPy7xnO7smxepgdNFUWiyR5O9KqPClks+Rh9LZyv+Ej
 pzhqODBLxxdITg+mZVra/xWBGDdK6JQGePzQzKbcAIK8B5Q/8fwMC
X-Received: by 2002:a05:6358:b3d6:b0:1aa:b887:2386 with SMTP id
 e5c5f4694b2df-1b39319974bmr1301878855d.10.1724064559781; 
 Mon, 19 Aug 2024 03:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq/i1hvvU4T0FkRFdBmyFvfEzeMHOyIxEWDQjS9pMNHXFxRPbKPsucuqWjSB300vPlvnuDow==
X-Received: by 2002:a05:6358:b3d6:b0:1aa:b887:2386 with SMTP id
 e5c5f4694b2df-1b39319974bmr1301876455d.10.1724064559301; 
 Mon, 19 Aug 2024 03:49:19 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fdd9ad6sm41605636d6.17.2024.08.19.03.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 03:49:19 -0700 (PDT)
Message-ID: <d2391f16-0ea2-4297-b71c-394368071fb4@redhat.com>
Date: Mon, 19 Aug 2024 12:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2
 job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>
References: <20240816153747.319161-1-thuth@redhat.com>
 <8d07931c-444e-4030-ac7c-b81ad2d3bac4@linaro.org>
 <ac16ccfe-65fa-4de4-95a1-7b2d2379c893@redhat.com>
 <3abd50a8-6add-4406-ba21-ddd0c73965ed@linaro.org>
 <289cb3f1-765b-4d2d-8e31-57dd672fb765@redhat.com>
 <7a0fb1db-b3d8-43ef-9eb9-2a7982ec11f5@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7a0fb1db-b3d8-43ef-9eb9-2a7982ec11f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/08/2024 12.21, Philippe Mathieu-Daudé wrote:
> On 19/8/24 07:30, Thomas Huth wrote:
>> On 16/08/2024 19.18, Philippe Mathieu-Daudé wrote:
>>> On 16/8/24 18:40, Thomas Huth wrote:
>>>> On 16/08/2024 18.34, Philippe Mathieu-Daudé wrote:
>>>>> On 16/8/24 17:37, Thomas Huth wrote:
>>>>>> The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
>>>>>> likely due to some changes in the MSYS2 environment. So far nobody has
>>>>>> neither a clue what's going wrong here, nor an idea how to fix this
>>>>>> (in fact most QEMU developers even don't have a Windows environment
>>>>>> available for properly analyzing this problem), so let's disable the
>>>>>> qtests here again to get at least the test coverage for the compilation
>>>>>> and unit tests back to the CI.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>   .gitlab-ci.d/windows.yml | 2 ++
>>>>>>   1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
>>>>>> index a83f23a786..9f3112f010 100644
>>>>>> --- a/.gitlab-ci.d/windows.yml
>>>>>> +++ b/.gitlab-ci.d/windows.yml
>>>>>> @@ -23,6 +23,8 @@ msys2-64bit:
>>>>>>       # for this job, because otherwise the build could not complete 
>>>>>> within
>>>>>>       # the project timeout.
>>>>>>       CONFIGURE_ARGS:  --target-list=sparc-softmmu 
>>>>>> --without-default-devices -Ddebug=false -Doptimization=0
>>>>>> +    # The qtests are broken in the msys2 job on gitlab, so disable them:
>>>>>> +    TEST_ARGS: --no-suite qtest
>>>>>
>>>>> Then building system emulation is pointless, isn't it?
>>>>
>>>> We're still running the unit tests and some others.
>>>
>>> I tried to configure with '--disable-system' and the same tests
>>> are run
>>
>> ... but you lose *compile-testing* of all of the system files, so what's 
>> your point? ... sorry, I don't get it?
> 
> I'm wondering why wasting resources and time on our longest job
> if the produced binary doesn't run. Anyway, I'm not objecting to
> your patch.

Ah, ok, I missed that idea about one of the longest running jobs. Hmmm, 
considering that we compile test the code in the cross-win64-system test, 
too, we could indeed shorten the runtime here a little bit ... I'll give it 
a try and send a v2...

  Thomas


