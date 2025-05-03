Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C34C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 20:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBJMG-0003iK-HO; Sat, 03 May 2025 16:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBJME-0003hI-6o
 for qemu-devel@nongnu.org; Sat, 03 May 2025 16:21:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBJMB-0006aF-KX
 for qemu-devel@nongnu.org; Sat, 03 May 2025 16:21:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2683013b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746303665; x=1746908465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jmVMK7MsDggFqHT4C2n6JgtZqKKjYHrqZgFHYDrdBMI=;
 b=CrVvK8xtMM7SJj9kXCw88gtIqNMcMO4DedkE1Q9zZGEk5SuawwnEIHENqAw3UgHdmS
 vLmsXq536x3F81Kyc9+CFqG1818rsAEtKEwbkmGE3za/JLrNARLDY56zpzlaulHL65Zu
 dhGSJqHVroNWVfEuC6aR2sCw+vcmHg67uOAyOvW6qIwGxjJKtnKyViDMEst17S2NIdcJ
 GrYg8t7vvv2nAGpzA1Hip3uKa9ZqLwFR/0uIrGcyPFIihzkzQRGmBms/FV+jdu26xXOC
 zwS1v9zoEHKDyxtzgYg+Tq01+VFrMWMAcCt7R3IPrKI/vczjmOm1NrgCG8SWBMSkG7t/
 x4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746303665; x=1746908465;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmVMK7MsDggFqHT4C2n6JgtZqKKjYHrqZgFHYDrdBMI=;
 b=LkjRJj9RPNaBjZ2YNNjNyZE30hSh4qVD0iW+/J1rQqa0F5IEBJ7W2cTzVr7z1mW/BQ
 ZLfN/MVeYZ7P9OxrLpqqUNotkhlvph9jyTafZvBHkkiwwPLU9nIEA6yWTbpBeFYXLQjo
 h5O3/SQ1+vl0WCNb6K98x0uuyhQuskAy89ODtn3I8PeKVWKB5zYfumun0Qj7qA6Wrz4H
 82qjvvF6dDwZ9VjXBjb5y+DtVHEMCMs8rfZ3+AFM1WrOfOUogt1EynS17MuLrJEg/h39
 oyXC6ekvKJkRwbsuA2/S34KcAZkS8pl6WW2MXY4b7WVlGxEzKDsLlNG4EW5sb5/L//jN
 EpeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtbPhTJQISdZbMC1AC1W/t6/CpgTkBtzyoQjnmTpqD04A2z7jMngW1JyPE81TPYzITvmAtj3TKyPch@nongnu.org
X-Gm-Message-State: AOJu0YyJOjsH4lYUyXaMNKPVEPNUILXnP4c0C1hKAqNY6pxX3OJj1fJZ
 IvRNWr1rGqyDwvxyXBP5ce2bsFHSX7WOA7OsVHCJj/bU5rbbYGaSoHcb2FRRcFb3yzp071TCruz
 MXqE=
X-Gm-Gg: ASbGncvbV4CoDOyvTZKNzBf9vZEQotvt/gJcLpXZ6uvE7kmoS7V7+9DztOGd6Wo/OpQ
 oAIg1PbeJ5oHKaopTJlCkNd/lm/DZvUu5lEexKNRsV2hkGD00cHKZnAGLGj7N/7YQjx2f3ZkBsS
 4Umls0lj3KocEFAJzzy1AmqSoGvRDHhuyntdAefxAEky8T9zCQUxGTpRuEprN67WtXZL5B+a96M
 wWFlEaRd4E2dgdRx0y+8O6yePCscCDoLvz434PIbfA1rAhvZaWk4GxFFCUUElXqHA3slt07kCbA
 elcR3gofoqpWqqI0XiRqQRKo4bagaRQ7WfTefh6kPScoTQdfwHdMcQ==
X-Google-Smtp-Source: AGHT+IFfVvGsHiu1Rt2DUgBBHcC25+jIYFYAbnrNosioAxaCloewRv8bv4/c9YBasBhL8kZo9JoWkA==
X-Received: by 2002:aa7:90d7:0:b0:740:6f69:8d94 with SMTP id
 d2e1a72fcca58-7406f698f7dmr2252928b3a.0.1746303665298; 
 Sat, 03 May 2025 13:21:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405905d0desm3856846b3a.137.2025.05.03.13.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 13:21:04 -0700 (PDT)
Message-ID: <668a380c-0246-4ee8-8d2e-23d6a891125c@linaro.org>
Date: Sat, 3 May 2025 13:21:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
 <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
 <aBJJqtzQaTH_xcKK@redhat.com>
 <efbaccd1-9ef2-4aed-88ed-d6a2bcb7902b@linaro.org>
 <aBJP-_KJudesY_Pk@redhat.com>
 <f8ca0b3f-5a9a-4182-b0e0-352a90bd9374@linaro.org>
 <aBJSX6kcYQVM2hp7@redhat.com>
 <CAFEAcA-G7exikg_qa7USDvfo0+ZTLUiymfDiqK6wLTZmebv4kQ@mail.gmail.com>
 <90c34e5a-c98b-4ee1-a176-d747c47b853b@linaro.org>
In-Reply-To: <90c34e5a-c98b-4ee1-a176-d747c47b853b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/1/25 2:26 PM, Pierrick Bouvier wrote:
> On 5/1/25 10:56 AM, Peter Maydell wrote:
>> On Wed, 30 Apr 2025 at 17:41, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>> FWIW, if you want to run a specific test, personally don't use meson
>>> or make, as you can just invoke the file directly:
>>>
>>>    $ QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64 \
>>>      PYTHONPATH=./python \
>>>      ./tests/functional/test_x86_cpu_model_versions.py
>>
>> The rune in docs/devel says you also need to:
>>    * put tests/functional on the PYTHONPATH too
>>    * run from the build tree, not the source tree
>>    * run using the python binary in pyvenv/
>>
>> So you can do this, but it's pretty clunky; I have to
>> look up the runes every time. It would be nice if there
>> was a wrapper to do this for you.
>>
> 
> I think that meson test command is pretty easy and "standard" (once
> learned, you can apply this to any other project using meson test
> infrastructure), so maybe it's the wrapper we could be interested to
> promote.
> 
> If we go this way, two things would be interesting to change:
> - enable setup thorough by default, so all tests are visible by default
> (instead of having to dive into tests/meson.build, and understand which
> setup does what). make check-functional can still restrict the setup,
> it's not a problem.

Sent a series for this:
https://lore.kernel.org/qemu-devel/20250503201806.3045723-1-pierrick.bouvier@linaro.org

> - abort gracefully (without needing an extra env var) when an asset is
> missing and can't be downloaded, with a different error than 404.
> 

Not easy to do, as asset.fetch() is not aware of current test, so it 
can't called skipTest, and it would be cumbersome to have to pass the 
self TestCase as a parameter.

> With those two changes, "meson test" does all we need, including the
> build, in an intuitive and standard way.
> 
>> (Also it doesn't work if the thing you're trying to test
>> is "does this test pass within the meson test timeout" :-))
>>
>> IIRC there is also a rune for "run a single test within make/meson",
>> but I forget what it is and docs/devel/testing/functional.rst
>> doesn't mention it.
>>
> 
> I agree with you that even though it's possible, it's something you need
> to check in the documentation everytime, which is not convenient.
> 
>> thanks
>> -- PMM
> 


