Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BF9E6E7FA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDwK-0003fK-Me; Tue, 03 Feb 2026 05:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDwI-0003df-QW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:47:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDwH-0003YS-5F
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:47:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48069a48629so56588735e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770115639; x=1770720439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1rWNHiQhFa1U8/wYSnzkuJj/Wf5C4ryoJooSa3hsAk=;
 b=q9v+W+q/0NM0uNzV3MIyp2zw7QrJkKyvUXdzJtlgTELOiBgZICRL9l1PYvkOrLom8/
 51fZxazcl66U0b1CBgTC2QY8Z6EZs9KCv2YqZLdKrqN4SWhvdukdK53Y3SfBNRu040mm
 SYnLuPtZmPTP5YxtFpbWamtoeNMpsc7+HShU64KjcSxcYpUDEIPb0so2BBOZ2Us4TZgu
 jWcU+/Hxp6qcVMOZ+RuWGPvOeYGzC76FltVacsx7uImw1+D4kwRa4QQcwBbDSIoiO25R
 odrygte1euBLA3G3s7HLy2UVlI0pPPRspIN587314471LXtZWxkdexyAJh4DQD6flwjf
 vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770115639; x=1770720439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w1rWNHiQhFa1U8/wYSnzkuJj/Wf5C4ryoJooSa3hsAk=;
 b=UBZOuzOK+qC6RihWcJr0ihuSoDdo0rUuNjA4C9sDAb9Oe6kKyNm0nIxhUKIRY8ruQX
 4uBt7MWFpT2KMRp5DQamEChNcmkoMRR3hwyoAjL1oaUXApUh2ChUc9SAssERKjVo2bSW
 KJA+c3cT+bpeo9Asn9pqa8rfe2fvKxHiMwAIiNPXGHjb9sagl0wnz81hUK+dZ4sV1xNu
 AI4LWt2S+247+VEtANQkfNo1zlQx21E6+lI3CVkeLQ7YcLU/3J13y27YfFZeUah3CqIm
 JTQ4w1q7CHMeuazn+WnWYTJozX0uSuigXSdkr/PbR1LRV5+n879/8FoCvhvB47bph5Db
 6a+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcWgv6IukeUdY1dgIrabwQu6W8oiEeHZC/dTxwD1jdvR4uH0CN3lH15IkK12jAA+tthbm1TktAMgvM@nongnu.org
X-Gm-Message-State: AOJu0Yxi43CYmk/zY1woNmAAwfiCoGHT7D1qhPHZM+Ih/LPgadxMMA9M
 yY+qX3XLFcF9gyih4t0RpJSa7+T2V2zbIKFuk3yqdxuTPdx+tnY6ZHsoFcCFzPTi+6A=
X-Gm-Gg: AZuq6aIDn4ClzkfLJQrwQ+3CvxVdJAavGjkwa9aj4sljg/kOQlxJqNR/TL2A20dSD0g
 zv3EPm22Tt1R0IWCHh1/IiV03enycfgUfjgYMEA3EHgjz12I6d9bdEll83PqGEPtzJovlATsYPu
 nTl6ZAL9F1zXtsPXSa8vO3/BPfo5w1vrGY+BhcEaUzFxlN5CSIPd0DWde+Hdt3qUrE23AHVXZUJ
 PeHXmAQKj4Ov9E0zTalulNhJcNv5vHMDoogRE1ACHmQnkNv3GqEcM7X7z+uX3vPwB0awxlTj18F
 qehVRvw++sVhA37SmJyD65DyHPa22QbBj91R71m9aS8GaeSWl/2AqkyowrbBq5qDrHzO66Xq+n+
 kEk5EBg/KgMAasWAyjW3JCZyYS/JnY+PkpSN4FYju4VSdFsPwZfaVnYnLdu2+iEr+MaWRfTC8yn
 buKgQr7vZxU6GwDv3W4ZixAlKLMkPjVTEYaXYEKKa1BsGOOI2wsEHnqg==
X-Received: by 2002:a05:600c:c0cd:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-482db623c40mr129148815e9.23.1770115639512; 
 Tue, 03 Feb 2026 02:47:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm49396852f8f.8.2026.02.03.02.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 02:47:18 -0800 (PST)
Message-ID: <28846f01-a97e-4034-8f56-7bef90417f69@linaro.org>
Date: Tue, 3 Feb 2026 11:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-2-jim.shu@sifive.com>
 <7b65cfff-3255-4fc7-b151-80ab284dbc1e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7b65cfff-3255-4fc7-b151-80ab284dbc1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/2/26 02:15, Richard Henderson wrote:
> On 1/29/26 01:23, Jim Shu wrote:
>> To let io_prepare() function use the multiple members in
>> CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
>> member as the argument.
>>
>> It is the preliminary patch of next commit.
>>
>> Signed-off-by: Jim Shu <jim.shu@sifive.com>
>> ---
>>   accel/tcg/cputlb.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)


>>   static MemoryRegionSection *
>> -io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
>> +io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
>>              MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
>>   {
>>       MemoryRegionSection *section;
>>       hwaddr mr_offset;
>> -    section = iotlb_to_section(cpu, xlat, attrs);
>> -    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
>> +    section = iotlb_to_section(cpu, full->xlat_section, attrs);
>> +    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
> 
> attrs is also present in CPUTLBEntryFull; you can also drop that parameter.

Jim, now that this patch got merged (commit 94c6e9cf044), do you mind
sending a cleanup patch?

Thanks,

Phil.

