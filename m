Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9075EE77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdQL-0005xe-FK; Fri, 03 Jan 2025 03:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTdQJ-0005xJ-8P
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:52:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTdQH-0001ty-In
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:52:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38634c35129so9162923f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735894367; x=1736499167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1489eH6ZtTDrohEG27SfKw7XbNOyzr5CphOqfqf5hQQ=;
 b=zDzWKEynJQPxkNWRITsxPfNDfrcjiIk/UMrn0O0kfLPtJ3Ou1+IPrwEqfYj1lNy9EG
 rRGlJGM/jw/PiKeM35q00mpVi/vLONRQts9eU2eHnLM7KYResMLBx75ySOBayady2SMV
 ssYIvYUWgwmhQ0Dvk8nBUSaj5QrB6UfhMC/hlWt13EdVgrmryjW0AivT5OcaVA09NHsd
 Y8PFCmvqJaHsMFhyop0/EjAB7kV4KaAtN9ZjkRKgSomnx83dfb5I9O5cblNrn6+ImRlA
 5pzeiPQivK0rt9uzDTyZ5L/bWjwhBY7+okwNK/cbucC3uLj3hgAk1ug1kGDeNxjFJdsx
 NNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735894367; x=1736499167;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1489eH6ZtTDrohEG27SfKw7XbNOyzr5CphOqfqf5hQQ=;
 b=JgIvZja9NElac/KDR8qAFbvNOiplKuyf87SD9fC/V45kgQYsg5ViXmDUvvk2PXfhsU
 dsKrwwp/QbcACtaGsoZSGAbo9y6XuIvWYScKd3Q2/ZEiFq0LScHHkXjKblZAz6JVPU9j
 AgMTuVWu1shsgRRi7kaw2w4Z5ynSH94/lV7S0xNW9euTTJG3kB0SMqzHp29VCwMUwGd6
 gEpaoxzIv/GDn+qZWs/0H9YJPqBf4AUcWmhvyY5MGs4uhDwEeuOwHy80eFUcmIpUFanV
 ada4va0IQ76tJvfLLzIJODig3yVZCv2SbSV6qW/ugIHNZ04D2YBdmohHxUFfe20lotQg
 BllA==
X-Gm-Message-State: AOJu0YwjOBDAPMhAbedpK9f4Jf4Ac15L/i+Cbx0KuzmU4aAFZ/FjnJOj
 R8H3PqqIlnRzwpns2u2kwkXJKJXsU6cYrKLPYSxMOyZrZskuxGLS+cYtld7DsTKttjn6nnu85np
 N+T1dlA==
X-Gm-Gg: ASbGncsRjY5qWhN7COBe3C8tEQP+FfWnBx8FVmGV9atb9Dh5RtLwsd/yf9R1e6pYJK+
 QZqRXjU4WTcMXJ7BT4+4Lym9rG3BumEPErqykMBaYG2iPvghxjUhToKVrfFndEEVP/XGcMSfNWI
 cP0rhpZTNqPNqxllem7GJTnDEjoqKt4BFvvtppVIkCdwdpTdPPxrNIjnmSt8cKkg7cud3BBuagO
 oQBqO3DUR8feExQh22Oj0UWxJnTZBR4cStDwMw4t6Lk/oE0o4lONiGN+4pewPxwVSq/Rw+nPrGo
 J7+z7GqyIZhf5DSKyC64SfPW
X-Google-Smtp-Source: AGHT+IGdkuA40Gjfpe1FZ10aSEXZmIaDUJkrIQOUD+WH26Ke8f9Uwbhgfeyr6uCoL7VfC/Yg0Ppa7w==
X-Received: by 2002:a05:6000:470a:b0:385:f092:df2 with SMTP id
 ffacd0b85a97d-38a221faae4mr35580980f8f.34.1735894366824; 
 Fri, 03 Jan 2025 00:52:46 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e74sm39637018f8f.30.2025.01.03.00.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 00:52:46 -0800 (PST)
Message-ID: <902568a2-8160-4265-9e2c-c4465eaa62d4@linaro.org>
Date: Fri, 3 Jan 2025 09:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup
 value of MSR_CORE_THREAD_COUNT
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-2-xiaoyao.li@intel.com>
 <018cfbde-96be-4d95-bb29-95cdf708187e@linaro.org>
Content-Language: en-US
In-Reply-To: <018cfbde-96be-4d95-bb29-95cdf708187e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 28/12/24 18:37, Philippe Mathieu-Daudé wrote:
> On 19/12/24 12:01, Xiaoyao Li wrote:
>> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
>> Extract a common function for it.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v2:
>> - move the implementation of cpu_x86_get_msr_core_thread_count() to
>>    target/i386/cpu-sysemu.c;
>> ---
>>   target/i386/cpu-sysemu.c             | 11 +++++++++++
>>   target/i386/cpu.h                    |  2 ++
>>   target/i386/hvf/x86_emu.c            |  3 +--
>>   target/i386/kvm/kvm.c                |  5 +----
>>   target/i386/tcg/sysemu/misc_helper.c |  3 +--
>>   5 files changed, 16 insertions(+), 8 deletions(-)
> 
> 
>> +uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
>> +{
>> +    CPUState *cs = CPU(cpu);
>> +    uint64_t val;
>> +
>> +    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
>> +    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
>> +
>> +    return val;
> 
> Alternatively:
> 
>         return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
>                          cs->nr_cores);
> 
>> +}
> 

Typo "function" in patch subject.

