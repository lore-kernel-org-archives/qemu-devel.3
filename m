Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAD8C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 17:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZD1L-0006d5-Ux; Wed, 31 Jul 2024 13:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZD1I-0006bT-Us
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:21:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZD1H-0005WW-8R
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:21:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d2d7e692eso4925344b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722446504; x=1723051304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RCtWkp2h4+ZqzyNCHoeT7jWpnNpXfSOyTIR15sX5mrM=;
 b=VpUSSEr6Q8n1iDRZ8YBJVYxfbdj4dQeo9C0b2XYgzUebZBrO9FDgcwgsBo4R8HT4T4
 WmFghaEJ7huDyKabaNcHklHapwj9mHZ56PH8BNGIF6vHy980CufKFpLjvniU97gtXhdf
 BroWgydsCx5XT2rlW7+b6r2+bF/QkY4dAknEWO/cUjkZ9HpCuc8Dlv9NdQ7S+6A11J6d
 T73acI8jm6wMKuVEZnbryRqCXYid0CN9i0DSQbYqJq3g8x3j1iuHd33bbjOqli255p3K
 Z9EEeXR4j/IQF78kcHR+0Y9PzKS0mFo4iP3l0gQ/+hJAOXJMwWe8FlS5ORKREoHingdV
 29BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446504; x=1723051304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RCtWkp2h4+ZqzyNCHoeT7jWpnNpXfSOyTIR15sX5mrM=;
 b=xQ7TdxJceR7MqYrbao2jHICBfkWqXwVIiSKQJpuOie95S0jiRb2PrsahxcPPrSCWyJ
 XXQE1QWd6WcTC44ImfTyvOu0rWC6AKj1j+AjCz0V6amSRgk3tTLQ/va6+YmgpEdR6oic
 IblhOONfmQXgnQjyQZVogNOXEoNyEU8kTSh5ed6cWjc7VjnzrS9SOPFukwa2rqp2HGA5
 OFLeexroIOIcKZD0n9cs4vMn6N1H1r2arqZgErgmYeub5ie8KFYZkPjCetokcta2YptU
 GzZE6inNl6z5QqPH3ynqRMlKQi9NjlEHii1bGz5lj4gzVKqeRTi16l9fBcj7+V5O+TgJ
 L7ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhrO0qJwJs8643oVlhWsflYPUF4wIMUEcRM1pScOV6jIzBc17V3DgbFeq5OQz4zwNgDNJ1iFhZftkEGOkNO1FMQ1Ip2/o=
X-Gm-Message-State: AOJu0YwwIIfMx/4WvuhCwKpuFMpj1MC0Qb6HALyNMo/nNdFmQ4v0voBk
 7I06YFVnDT+ako8KtZeGgldVpqF2b0E10zbtVCgSFEWZqiwbMvSjWjw6+Q2JQAcJV57So7ZtJQH
 3
X-Google-Smtp-Source: AGHT+IGMhlTWOMok+0cc0b6AMeUzCTX9Wp4mPqO4drG+RVvGIS3uw0CJ+vneLSLAoqGoHuPUAFupsQ==
X-Received: by 2002:a05:6a00:9a6:b0:70d:1b17:3c5e with SMTP id
 d2e1a72fcca58-70ece9fadc5mr13539351b3a.6.1722446504381; 
 Wed, 31 Jul 2024 10:21:44 -0700 (PDT)
Received: from [192.168.68.110] ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead712e1csm10220331b3a.78.2024.07.31.10.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 10:21:43 -0700 (PDT)
Message-ID: <5b2cc922-892f-4c51-92cf-d33e79d85829@ventanamicro.com>
Date: Wed, 31 Jul 2024 14:21:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-12-dbarboza@ventanamicro.com>
 <8e54f48e-379b-42b8-8017-886ead154415@sifive.com>
 <49fe48d5-42d0-46fc-899e-50960941c3a2@ventanamicro.com>
 <20240731-30c03698cd1c889a4485e2b0@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240731-30c03698cd1c889a4485e2b0@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 7/31/24 1:50 PM, Andrew Jones wrote:
> On Wed, Jul 31, 2024 at 01:27:09PM GMT, Daniel Henrique Barboza wrote:
>> Hi Jason,
>>
>>
>> On 7/23/24 12:25 PM, Jason Chien wrote:
>>> Hi Daniel,
>>>
>>> On 2024/7/9 上午 01:34, Daniel Henrique Barboza wrote:
>>>> From: Andrew Jones <ajones@ventanamicro.com>
>>>>
>>>> And add mrif notification trace.
>>>>
>>>> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
>>>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> Reviewed-by: Frank Chang <frank.chang@sifive.com>
>>>> ---
>>>>    hw/riscv/riscv-iommu-pci.c | 2 +-
>>>>    hw/riscv/riscv-iommu.c     | 1 +
>>>>    hw/riscv/trace-events      | 1 +
>>>>    3 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
>>>> index 7b82ce0645..d7e5f20885 100644
>>>> --- a/hw/riscv/riscv-iommu-pci.c
>>>> +++ b/hw/riscv/riscv-iommu-pci.c
>>>> @@ -81,7 +81,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
>>>>        pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>>>>                         PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
>>>> -    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
>>>> +    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT + 1,
>>> The new interrupt is not marked as used with msix_vector_use().
>>
>> I took at look at what this patch is actually doing and, at least in the MRIF setup
>> I have, it's not doing much because we're not hitting the MRIF path inside the
>> emulation. So we're not hitting the trace and this extra MSI isn't being used.
>>
>> Drew is taking a look into it in the kernel side. Until we get a better idea on what's
>> happening I'll remove this patch from the series. We can re-introduce it again later
>> in this series or in the follow-up.
> 
> I recommend adding the trace to whatever patch introduces the MRIF path in
> this series since we'll want the trace for testing regardless. If we need
> another fix to this series for MRIFs then I'll post that separately on
> top.

I'll add the trace in patch 3 (or 9).


Daniel


> 
> Thanks,
> drew

