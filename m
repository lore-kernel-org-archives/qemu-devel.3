Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A717AE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 12:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV8K9-0000Bl-Ia; Tue, 07 Jan 2025 07:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV8Jt-00005n-9N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV8JZ-0007F3-96
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736251440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LNQMn2wIZii4j2bqMBE6Moj3MRDBpdeutH+qPyUcNO8=;
 b=CKXXr2r5GqLaRvN9PlwrkYWrKPlWQ4s44J1sV8wvUl7ucfrqDljkmLpuY6avE6qysKOepD
 VYG05CLzrqOSKGbV32sUHpXe/x3Hwc5X3QY7snyd10ZnjurVMyTxNjdQW0TCgxHG71zrUv
 Yv1UmVpoCwxu4JxIH94Kzs7wdWnZVJA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-vvYhKfdJNdO6HPYYEe4veg-1; Tue, 07 Jan 2025 07:03:58 -0500
X-MC-Unique: vvYhKfdJNdO6HPYYEe4veg-1
X-Mimecast-MFC-AGG-ID: vvYhKfdJNdO6HPYYEe4veg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b9e433351dso2620570585a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 04:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736251438; x=1736856238;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNQMn2wIZii4j2bqMBE6Moj3MRDBpdeutH+qPyUcNO8=;
 b=ljrjQhwzPNihs1xglNGb9913ibu+2pj7YI+DkBIqPw3xHMNxHK3xU3MAdzkaZWzy/Y
 hrYeJbh2wDYaDjwbxIrFqOiM9rQ/9k7zGm+S9qOGOm8GHaXEHNiOnsHRwFrOMSIYWuHP
 eJH5XQSagn09Em2FcEO2GHOkqHQFd3B6e3P9+dGO0Xz35TsxX/Cm17UuwKo/nBCfgYB8
 lqYd5hQmvsBM8zyuMoYf1NNSw+2adgmigFZvd0YDzphEFGxEYzSgG1+9ed+F7B6N563i
 Vn+GH+B35CO4MBm33RxhJOG5XlM9sR2fkWJsfGYudNTFkxkj4BFa4Fz47BMXTgSyGu0B
 tBvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvASnZi/gn6fz762IqdGNr8HLTOdO8DwexBHziYlHBgos92Wy2lAYO4geLmTZmxBG6cxMG3KcF2qp3@nongnu.org
X-Gm-Message-State: AOJu0YwFlCOORspJXjY3Hknlwo9qtQNRwVaMP1hKjgbeUwGroObGpqzR
 4saifuYiLBreXVtHAJu3Mwg6WCipLoD/+yap6UXdt3CzyuH3JXAfytDGec/wVzHc4OMx+2Wv0tQ
 2vjEOZRhVxyaEOHyAvyuBeM3DHL2KUwBnx/qm7Yi+84965ODZ+VnA
X-Gm-Gg: ASbGncsi/nlAKr+IXELvIqnSthVaWbZJZfw1Tr/LlvvOj8rE1sxYCGt7wQheJ8D/qsA
 v5vEqHYg5oDxA0eD4QU5hUZrazYsTJ6Ovuvuzj8If7qNsi3F1KYxwVQEbypwfnxmTDaJC7KVXXx
 6brDWxltEwAA7+sbNOzAYkns1TEHYS2ysUEu68cmzfJtMoY7+p7bC6PSVYYEmZcg2dwUcBE7OA8
 x6O7wXqbwQa73+GVVB4t9COR3jRGLAwOIxyf+P6ECtQRceItK0tixKjh/4YedcGpX/BYy85vcsm
 0AMSDOsM/BpF
X-Received: by 2002:a05:620a:4452:b0:7ac:dfed:65ee with SMTP id
 af79cd13be357-7b9ba716874mr9275484485a.3.1736251438054; 
 Tue, 07 Jan 2025 04:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwmI/dtqps/dSWojUNe4Mbg9U/izSv44Vhz+slzcdZXKbFZzXMWPaiXsHUxQYh6IJOUfRNUg==
X-Received: by 2002:a05:620a:4452:b0:7ac:dfed:65ee with SMTP id
 af79cd13be357-7b9ba716874mr9275481885a.3.1736251437746; 
 Tue, 07 Jan 2025 04:03:57 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-182.web.vodafone.de.
 [109.42.49.182]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478d35sm1582614785a.90.2025.01.07.04.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 04:03:57 -0800 (PST)
Message-ID: <ab03dc76-14fe-4da3-97b9-b7da5bb154d0@redhat.com>
Date: Tue, 7 Jan 2025 13:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_x86_64_hotplug_cpu: Fix race
 condition during unplug
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250107115245.52755-1-thuth@redhat.com>
 <Z30WlysSx4-L-YSs@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z30WlysSx4-L-YSs@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/01/2025 12.57, Daniel P. Berrangé wrote:
> On Tue, Jan 07, 2025 at 12:52:45PM +0100, Thomas Huth wrote:
>> When unplugging the CPU, the test tries to check for a successful
>> unplug by changing to the /sys/devices/system/cpu/cpu1 directory
>> to see whether that fails. However, the "cd" could be faster than
>> the unplug operation in the kernel, so there is a race condition
>> and the test sometimes fails here.
>> Fix it by trying to change the directory in a loop until the the
>> CPU has really been unplugged.
>>
>> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/test_x86_64_hotplug_cpu.py | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/test_x86_64_hotplug_cpu.py
>> index b1d5156c72..7b9200ac2e 100755
>> --- a/tests/functional/test_x86_64_hotplug_cpu.py
>> +++ b/tests/functional/test_x86_64_hotplug_cpu.py
>> @@ -59,11 +59,13 @@ def test_hotplug(self):
>>                                             'cd /sys/devices/system/cpu/cpu1',
>>                                             'cpu1#')
>>   
>> +        exec_command_and_wait_for_pattern(self, 'cd ..', prompt)
> 
> Is this actually needed ? Are we keeping the CPU from being unplugged by
> being in that dir ? If so, why isn't it also needed in the while loop
> below ?

I added it to make the console output less confusing (otherwise it's still 
shown in the prompt after the CPU has been unplugged)... but I can also 
remove this line again if you prefer it?

  Thomas


