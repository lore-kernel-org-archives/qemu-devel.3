Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D11C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4Jl-000171-05; Mon, 04 Aug 2025 19:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj4Jh-0000wz-B4
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:10:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj4Jf-0003nY-Ky
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:10:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76aea119891so5419471b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754349001; x=1754953801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6V4vtIAJUGkVz2NDjj+4q+393KbmH3gkt7cZX/an5X4=;
 b=RJhywLe3Hnaw8JSu/ZVRhVSzGCApHBSYLBzo4ywR5QWwkUIp7sL00krlfERf44yooS
 Nh1w7LoDw9d8DTd3Qt9gbynid7gPXMYAP+kmmnPjI32uHxJUeNMlawui+BTh/7DqGmxn
 VTTgLU3iwdgkqIC4jka7bn2tR+qvt2deqTFR2RpHrMM42YjBIyn7Wc2dFc6V0pUrNCYn
 LAQGZXCxxCzMAM7jL7+9C/jP7VNiJYxdFM1IuU4fCHBhur9kc7sR7Phs/onuk/2QQTWI
 KejdXQ6+i5HL2N/KZZQKzyvm33uWzH3TVf2wu1H5uwA/8QeBZpMN58Ii0WJZXYr9EsSV
 aAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754349001; x=1754953801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6V4vtIAJUGkVz2NDjj+4q+393KbmH3gkt7cZX/an5X4=;
 b=LnRP//gAKV8UvCO8aLhe4sb1/3S5Wf0jmRYbnMCE/qn7cpSEH7i5x2ZI+gKVe7cp7U
 4B1JzgKEBmYgZikC/KOGUcjadDag6QyaombpkyiwcI5NJBvq3H1krh9SJxLlotWzxctn
 IM8krJqksyJ94Rv/msTq7P2BqOm7nebMH2MQCnakORfSybZX3v15ey7IkZRZKZfybhLE
 T83hP2QFiEu5HhYnHgx+1hfOCIvaIz20nlHKHFcTmuzpJ762hUtEFK0jfxSjWdwzkUHu
 c//QNFb8gU3QMCo5Ikog98Inprq/l1wztjd5Dp6uq2jrfap5rk68bP/h6tnalS7lXnR4
 LfZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX01Jc6W3JkE8JhdeVStgxlJg3fZZSJKYnOtr/dmw6cswjkAJuqKdMfzFvc8SJEaXZVaham4Cm5Hjs/@nongnu.org
X-Gm-Message-State: AOJu0Yy4tbOlFJvLcVMGfi4HtVk3yw/MFP7p/d+6s4mSRzcNmFRHXTJg
 bpq/dQCEsrt0UCmkrHqB4rWDj+4lNElN70joXqZW0QIXvOQI9pfCCTYrIiR0bx3xa9c=
X-Gm-Gg: ASbGncv4ft9RjV/jWOGvjrYaJrXGqHzRNFtTxL1UCQinJRmh4RFzggMVeazSKfgD5EC
 6ub7m2kZK8HaIWHUNwoUw6pwN1pBrBz49Dipzqa5qonxhI55oiOrB2D/f8/AD9zJIp/jygC6rc7
 eNOAQz3HX/jBJ8ZboEXYvaZKFB5cUxWgWkUK9mY3e36WQra3AwzuUCjB1uowt+IS8slWtBMVchg
 7WT4LJK4NbooBAWWf9pjnMw4QlCYAQAzmftZSN0Uqy1Z2ggSpNq/GBIWmJsPRkh7pBMHBy8y1Jf
 ODkWGTpLatkFY+H0LrMizwCCnANEikTpKMxIkhXyZNn+Xv8ILYqv2RGQj7DNCI3Rt5Pn8xApgmC
 gqYOfHUUJBlVPJ3gBvNGxaG0KEwuTjWxGbLzkaDpANBzR7A==
X-Google-Smtp-Source: AGHT+IEcUGx7deBhZe/fAE1U6ip0i0HO9ktQMN91h4SHP7F4dFgQIq1WLdnZ0oF+DBudiz7jp1jYwA==
X-Received: by 2002:a17:902:d4c1:b0:23f:b94d:7da7 with SMTP id
 d9443c01a7336-24288ddfb38mr16816215ad.14.1754349001521; 
 Mon, 04 Aug 2025 16:10:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b785696sm9502773a12.9.2025.08.04.16.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 16:10:01 -0700 (PDT)
Message-ID: <0973c013-72c5-443f-bcb4-69bb3707974f@linaro.org>
Date: Mon, 4 Aug 2025 16:10:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] hw/arm, accel/hvf, whpx: unify
 get_physical_address_range between WHPX and HVF
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-15-mohamed@unpredictable.fr>
 <e5bfbc26-de3d-4f4c-b15d-6c7ea1b29e49@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e5bfbc26-de3d-4f4c-b15d-6c7ea1b29e49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/4/25 4:03 PM, Philippe Mathieu-Daudé wrote:
> On 4/8/25 16:23, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>    accel/hvf/hvf-all.c        |  7 +++++--
>>    hw/arm/virt.c              | 41 ++++----------------------------------
>>    include/hw/boards.h        |  4 ++--
>>    include/system/hvf_int.h   |  2 ++
>>    target/arm/hvf-stub.c      | 20 -------------------
>>    target/arm/hvf/hvf.c       |  6 +++---
>>    target/arm/hvf_arm.h       |  3 ---
>>    target/arm/meson.build     |  1 -
>>    target/arm/whpx/whpx-all.c |  5 +++--
>>    target/i386/hvf/hvf.c      | 10 ++++++++++
>>    10 files changed, 29 insertions(+), 70 deletions(-)
>>    delete mode 100644 target/arm/hvf-stub.c
> 
> 
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index 818b50419f..fa06e3b815 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -225,6 +225,16 @@ int hvf_arch_init(void)
>>        return 0;
>>    }
>>    
>> +uint32_t hvf_arch_get_default_ipa_bit_size(void)
>> +{
>> +    return 48;
>> +}
>> +
>> +uint32_t hvf_arch_get_max_ipa_bit_size(void)
>> +{
>> +    return 48;
> 
> These don't make much sense on x86...
> 

Common path in accel/hvf/hvf-all.c makes use of it, so it's not a bad 
idea to have an architecture agnostic function for it, instead of:
if (arm_function) {...}.

It happens that on x64, VA space is 48 bits.

>> +}
> 
> 


