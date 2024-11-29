Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFA4D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3HQ-0004KJ-Ee; Fri, 29 Nov 2024 10:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3HO-0004Jz-P1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:51:38 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3HN-0004JQ-7H
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:51:38 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa549f2fa32so285836466b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732895495; x=1733500295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l6GbRsi4xYGNJmdLMTpuhoNW1mMD7LaCmhGSt+KTelE=;
 b=FqCCkr9b/f84/V2jYA94nAr4jdmWgD1oii/KBSvqfl5JZIBgxZVgUzqaJIZmv++aC1
 eRpf5CgKSJY+dt/zLt68spat+1m4tgCQzhTTvE/k9/ByTvNGmFNsmdh8G63NKUkbvOzx
 1a098UdRMOBIeOu16B1gN0gjN4gz3F5PW0RKjrLZPPipm81Ub0KCv5K8VlvSnpjVg6ST
 6R+xaMQ6hItqN3uuHJbB2+c4uLcc2Gic2cY93zNz4JTzVh3gR9wPhIODn6JNM/Dq4ErJ
 M7zHe0BQmNN/XVMwz6JYb8tokJfpftLk5Laj6iSYRuZMsdLdpu1qljakdSnIAyVbfIsO
 ppsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732895495; x=1733500295;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6GbRsi4xYGNJmdLMTpuhoNW1mMD7LaCmhGSt+KTelE=;
 b=I8hVfReBb5/YcIxUlmHL5mvNepSqXZZqczH57tU+X2Bk8FhWKclPOVNV+lrLSOfmoC
 1vSuvCCbDFErqNRH4rzTRT7MMmprgr1sRoz1mofTp8JM1oA+CB/BgehSvzcHVoVO4OH4
 K7q6t5ZQwj4OVXpX5ORC9x7ZNZnOYqs3IHYyINM1uUGtuGF0hgujjPdzZov2E/rXxrrM
 obf+Gn+9lLCfljGb4HjG9ciWM5X5/tnsm2AhMO9dh4xhWqEMg12Nx+vgfYYWIxGzWFxY
 w1SPMw+plJ+8K5Pq58y0Ic0X1C15wgjTCijB8WLfhEsP31BKPCcCyKgYNtEBhAupbmkP
 X3Qw==
X-Gm-Message-State: AOJu0YwVJ9h0KDtgyP+Wp2FHVA7J9mKfDLZ7B+aaWzurD5d0AQ8eHVHq
 KuFT3fwMDL2BYkiP9MU2mz8OLhxZposryqJiRlrKc1gqkkjFlohH+ml8waRJA9FTVRvpOvX4x1v
 h
X-Gm-Gg: ASbGnct4IK2ItYR4jtUMF+E5jOw+01YYFOXieWuhpqJ7zu30JrbzLLpvFoL/xriRHpE
 iGk1IZg1JrtOxwgW9/nuWvxN1zoXLagczEH2z+MAD25f7+OVZHkag2RCZ9PgDv03VkGdRFVPv1m
 ATN7wsQdpzufVJ6vT4nOSVQOWWu1BIuTg/54nbxfnqiaFg/Te7lgJxwnW5ut++gLsVjoJZMOiCC
 QAG3XOmEgMdt+IoBOztq2VAC1Aoh7OF6Rsb6Ke+aD4X1Cw6t8t8Xgcs5PgwQNopbw==
X-Google-Smtp-Source: AGHT+IGb6DdKxCcK3jr8EA7tfEke8N96AF8bg1xRlDTeiUcxKMJLjk8IwjfCF3/qvwRjIZ94hNE9jQ==
X-Received: by 2002:a17:906:1bb1:b0:aa5:14b3:a042 with SMTP id
 a640c23a62f3a-aa580ef3726mr985278166b.5.1732895495197; 
 Fri, 29 Nov 2024 07:51:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.147.124])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e6a4csm187631366b.106.2024.11.29.07.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 07:51:34 -0800 (PST)
Message-ID: <330ffec8-84c5-4161-9342-3cbd898dc831@linaro.org>
Date: Fri, 29 Nov 2024 16:51:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: Fix kvm_enable_x2apic link error with clang in
 non-KVM builds
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Sairaj Kodilkar <sarunkod@amd.com>, Suravee.Suthikulpanit@amd.com,
 Vasant.Hegde@amd.com, Santosh Shukla <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20241114114509.15350-1-sarunkod@amd.com>
 <11a21260-cf71-495e-94bf-461fc0f39686@linaro.org>
Content-Language: en-US
In-Reply-To: <11a21260-cf71-495e-94bf-461fc0f39686@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 29/11/24 11:29, Philippe Mathieu-Daudé wrote:
> On 14/11/24 12:45, Sairaj Kodilkar wrote:
>> Commit b12cb3819 (amd_iommu: Check APIC ID > 255 for XTSup) throws
>> linking error for the `kvm_enable_x2apic` when kvm is disabled
>> and Clang is used for compilation.
>>
>> This issue comes up because Clang does not remove the function callsite
>> (kvm_enable_x2apic in this case) during optimization when if condition
>> have variable. Intel IOMMU driver solves this issue by creating separate
>> if condition for checking variables, which causes call site being
>> optimized away by virtue of `kvm_irqchip_is_split()` being defined as 0.
>> Implement same solution for the AMD driver.
>>
>> Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> ---
>>   hw/i386/amd_iommu.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> And queued, thanks.

Already merged by Paolo as commit 0266aef8cd6. Noticing that
earlier would have saved me some time.

