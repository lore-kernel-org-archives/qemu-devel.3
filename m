Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513DFC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 21:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPqjV-00079r-0H; Fri, 05 Jul 2024 17:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPqjT-00079I-8F
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:44:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPqjR-0003MQ-KY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:44:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426526d31a3so5870635e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720215880; x=1720820680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmMguUuvinPCPU7WQXG5jWn/+aZ22Fyg2tEU+UTesOs=;
 b=onitYDcVPbCSBdccAbDML+7oQo76//pAeal1lZxLvizFwbpVH1HrX8xxP56rH+7fzD
 eyTZMPlgQXXNvURJa4ZXIwI5bwSG4AEL/zkgePmL/Rzf7mjPqKl/DWyRlzH4O8IgZkld
 OIsyoLafYj2WQQ9fKfY2xiLSZ1Ox9xBaiWEHo9On4vTJNNrJp2xxV7IFlDUNTYdkOLqG
 ASecVrh/qIqYfgjLClFhXyUiNGqE5M+gSdV3XgHrFPziNVgKZYAAn7jv27EZ/z8o6fub
 x3ndeaCVbOxe6TPO+K8PM8HqtvTFzdvsnwqD7NfUdA84idsnfkeOqrfVG4fRsMMn2Mka
 bmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720215880; x=1720820680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmMguUuvinPCPU7WQXG5jWn/+aZ22Fyg2tEU+UTesOs=;
 b=juKMil6tjrby3TD62i8am/h6aXTibayV3m7SXmoaEij60OFlOV4nBzkiBsEdpfrijN
 ql3/8MmaHXVzJVwInBYrZ2EBHhVYPF4ijvQQ/jPYhaFdRxB0EFHyo+9SxLel3/o54xds
 0P0GloTXzE8SOEECZGqFsfb8F1I03khQ/viquuuBveer68pbWHXonDmoEU+JAWGj/xo7
 J1CZV+PHSpklWx3vnQBQ69TxuxHKsePcXu4fX8BWdIvjofrfnZ5gtYVfZwAYKyuzMYWd
 ozT4O/uAQqLCu735rtl6F0B+qg0GrGkFIytTjayHeKDavLrPRDsv/PX2KXIe7RTj0VBG
 wlnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtrE752bhLm7DEnedN8TgKeicdhFC0etAXN/DLXZToN7VpPp8E7upst73yp/DVeqRxjCz2IDJpKJaq6tWDeWjFNTOObww=
X-Gm-Message-State: AOJu0YwFpgrPKy0qgb1/7ug7Qxpok1VJnTVePCE7G38xea3tWxlo5RgY
 tSZId8+h3BS92/4GYlNtDxF1tGTeSXgkBcfQq6c0valqxms22VOBwpfEc/NTTeU=
X-Google-Smtp-Source: AGHT+IHDzAb6ryJHXJeNFQWFcHSZbnDG/ppl4K+087u4JJX6oM5L5km14hJfgv3Whd8D5BeGIhP4/g==
X-Received: by 2002:a05:600c:331b:b0:426:5fbc:f319 with SMTP id
 5b1f17b1804b1-4265fbcf850mr75635e9.33.1720215879384; 
 Fri, 05 Jul 2024 14:44:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678eb6593bsm9034405f8f.93.2024.07.05.14.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 14:44:38 -0700 (PDT)
Message-ID: <15191eac-49f4-47bc-b450-1385b3d7fe18@linaro.org>
Date: Fri, 5 Jul 2024 23:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/40] gitlab: don't bother with KVM for TCI builds
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Mads Ynddal <mads@ynddal.dk>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-21-alex.bennee@linaro.org>
 <07195265-2a54-4396-9724-2a63c98e45fb@linaro.org>
 <5d3be228-1dbb-4e4a-8e20-fb76e4c90134@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5d3be228-1dbb-4e4a-8e20-fb76e4c90134@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/7/24 18:49, Thomas Huth wrote:
> On 05/07/2024 18.34, Philippe Mathieu-Daudé wrote:
>> On 5/7/24 10:40, Alex Bennée wrote:
>>> In fact any other accelerator would be pointless as the point is to
>>> exercise the TCI accelerator anyway.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   .gitlab-ci.d/buildtest.yml   | 2 +-
>>>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>> index 425fc6479b..e3a0758bd9 100644
>>> --- a/.gitlab-ci.d/buildtest.yml
>>> +++ b/.gitlab-ci.d/buildtest.yml
>>> @@ -635,7 +635,7 @@ build-tci:
>>>       - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
>>>       - mkdir build
>>>       - cd build
>>> -    - ../configure --enable-tcg-interpreter --disable-docs 
>>> --disable-gtk --disable-vnc
>>> +    - ../configure --enable-tcg-interpreter --disable-kvm 
>>> --disable-docs --disable-gtk --disable-vnc
>>
>> Shouldn't we also disable the other accelerators for completeness?
> 
> No, this is a Linux machine, and there's only TCG and KVM available for 
> Linux. No need to bother with the other accelerators here.

I noticed this is Linux. If for some reason the Xen libs get installed,
Xen accel will be enabled. Explicit would be:

--enable-tcg --enable-tcg-interpreter --disable-kvm --disable-xen

But I won't insist. Anyhow Alex sent his pull request.

Regards,

Phil.

