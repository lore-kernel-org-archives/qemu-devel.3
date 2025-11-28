Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89691D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 08:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOu7F-0006uJ-2t; Fri, 28 Nov 2025 03:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOu7D-0006tI-9m
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:46:07 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOu7B-0000Sw-LU
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:46:06 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso2690328b3a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764319564; x=1764924364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dHu/4BZM5t/lfeBp58Qt6Jb1ByM+rDntoM9F3Y5P54k=;
 b=mN0X4g5B4H27KEAmWy2cizsl0S9WGiv2+j+2uFBUa8F8KLOoo5YhAkOSyEKNVeli8T
 /kRaJNN+5wyRRhmS5luDKaybvpu1/QK1YR3A9afAgyUn7+nOwdNmYxfEkSOH8xy4u01D
 WkjXY79DU3PCWbqj7+QiaebRz7W4ISABkmqeRh2I5ywJClrBVbX148Q8ppdhW/CmDiN9
 G2Q/Zi12OfDFVsOcv2Jh+2oAxXtDzjN2jgZoKiLpaduF1C+yF+WMKrvn6+KhUQs1rNY7
 F0OeglIAoZfSVmP69Rq5ERVBTmxmGdklEF9+O6b5G+2uyTe65+ggFMl6oxq9Xs47mtUF
 Z0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764319564; x=1764924364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHu/4BZM5t/lfeBp58Qt6Jb1ByM+rDntoM9F3Y5P54k=;
 b=bQpYN3wP5hpeahl2BSoxpLSSQqnwLOivnBjAZII7qqJZpA1WIS6K/ziTED/pTS6qAf
 yyauj3mTB2AT0hh2kb8IfKKq1pX8hcz9D745hWNqVuU01p/Iu7a1/gwv5zwwCXbUZl65
 umOi40vN9TudRXodjYVSmEEn3ObOHRoQFqjAGXUGNNVGYERoQtLpmZpeAmvMm9bbM6Nf
 YX0pZl+9EQJC4y//2U8jf8GKT5CnzpaWfJnGmAxpmJ4izMi2bm3UarwGDKPS7vgYzMd7
 x00GprUXxxsQINJlYooYkNg6d7o6S8yvg6gz2s7plrbRMKdR1OFMIoAKtyd/70bb2kER
 uQrw==
X-Gm-Message-State: AOJu0YwIIYWX14EOokx4cMsMdPsA6c9g6HOGxoCYbgpVeEYPkrfxgG6d
 6bO/P7Syi1pu5sRF03SdmTewF5fGuLJyXzb/OSDxflfCM6py/BdZdtzI
X-Gm-Gg: ASbGncswa4TYQqPg7Jwq13jJM+yLco/TxtmwynYJ7qk0PAwDFY1uszAEfyMEb8DYQYO
 snOmToKxoXwvOQ31R83Ks+N79CjcNTGqPb+wCBGO36zZuluSRSJjb/8nD+ymSnQptJHolSixs6n
 8D7X6UtMGGFx6grEqecggEUFWQ5UMKwG8AI8Fjcdlsn6/S44AdYBDvgu8ZG3CNrLwfQUlBWr9sl
 TIrGnFdL5FZhRXfnh6EeqL9r9pSgxUVm+ZkiW4rJl8mOmH75Nd5u5lGKQYbvDdBVuIJpH9NA9qT
 AXwy25C/U5mIhPQgUfdXyB4Uxhnv2xIx0MXX30TCo4QmrqjxWZFMNURWsVlRRELgllXDuHUU5ic
 Zl7W9kJwP6RPrjCA6+Q5NFt8le8YLkAe8Oa/CSkspWtPURP5r852OdW6rPkF/CewHyaRWYeTzbT
 OUrLHmi+vWckru/qp96D5Otivxp7nsmgXOMtq9
X-Google-Smtp-Source: AGHT+IEBDCW4HOIJbMRFrWu20bNIRAjbdL/QdwcjrQ/u3I84UJu8V6SpCWxKZTshQoAalFMeZ1up2A==
X-Received: by 2002:a05:6a00:2e28:b0:7b8:16af:3bbc with SMTP id
 d2e1a72fcca58-7ca8a139483mr16090277b3a.31.1764319563661; 
 Fri, 28 Nov 2025 00:46:03 -0800 (PST)
Received: from [10.22.76.11] ([122.11.166.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15f177559sm4207533b3a.48.2025.11.28.00.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 00:46:03 -0800 (PST)
Message-ID: <66f442e9-87d9-4a62-b7ca-d29a1e1b9dc0@gmail.com>
Date: Fri, 28 Nov 2025 16:46:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix i386 HVF compilation failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
References: <20251126094601.56403-1-phind.uet@gmail.com>
 <8f6eb2ec-d6a7-49dd-b425-ee771d2f9be3@linaro.org>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <8f6eb2ec-d6a7-49dd-b425-ee771d2f9be3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=phind.uet@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 26/11/25 9:39 pm, Philippe Mathieu-Daudé wrote:
> On 26/11/25 10:46, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Recent changes introduced build errors in the i386 HVF backend:
>>
>> - ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 
>> 'guest_debug_enabled' in 'struct AccelCPUState'
>>    163 |     cpu->accel->guest_debug_enabled = false;
>>
>> - ../accel/hvf/hvf-accel-ops.c:151:51
>>    error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'
>>
>> - ../target/i386/hvf/hvf.c:736:5
>>    error: use of undeclared identifier 'rip'
>>
>> - ../target/i386/hvf/hvf.c:737:5
>>    error: use of undeclared identifier 'env'
>>
>> This patch corrects the field usage and move identifier to correct
>> function ensuring successful compilation of the i386 HVF backend.
>>
>> These issues were caused by:
>>
>> Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of 
>> AccelCPUState”)
>> Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)
> 
> Oops.
> 
>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>   accel/hvf/hvf-accel-ops.c | 5 +++--
>>   target/i386/hvf/hvf.c     | 6 ++----
>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
>> index 3e5feecd8a..e2cb8f202b 100644
>> --- a/accel/hvf/hvf-accel-ops.c
>> +++ b/accel/hvf/hvf-accel-ops.c
>> @@ -148,19 +148,20 @@ static int hvf_init_vcpu(CPUState *cpu)
>>       sigact.sa_handler = dummy_signal;
>>       sigaction(SIG_IPI, &sigact, NULL);
>> +#ifdef __aarch64__
>>       pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
>>       sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
>> -#ifdef __aarch64__
>>       r = hv_vcpu_create(&cpu->accel->fd,
>>                          (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
>>   #else
>>       r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
>>   #endif
>>       assert_hvf_ok(r);
>> +#ifdef __aarch64__
>>       cpu->vcpu_dirty = true;
> 
> Don't we want the ifdef *after* this line?
Oops, that was acutally that I meant to do, I think I made mistake when 
formatting the code. I will send a new version to move the #ifdef line. 
Somehow the vm still work normally on my intel Macbook.

Thanks,
Phi

