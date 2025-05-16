Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A7C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwHr-0007IM-Jv; Fri, 16 May 2025 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwHo-0007IA-U4
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:43:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwHm-0001kj-Qt
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:43:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso17775685e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747406621; x=1748011421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsYifqg2W3nQQyHmc9MVahFWG6m100Fl3H22xhmDURQ=;
 b=eSd7wO8A8MfJ5tYhzllu8o9hgEiZ1Cqj4MT63FzA0nzmuHn3T3gvl+WY7GG6fg7eUH
 yqTD9v8SNYNNKbD6j0p1Q14VlUyTmBSEUKR5SjBrr2Y+k6vgoydh0tRLNnCRPk0faJ2P
 v7OJKQczpQuQ9K+zWUq7RZOECHZTrovTQm+ubipSEQBcp1V7khI+puZFaxrDxop4m5So
 xrBPHmaim8O5vzSRcu2ZP6YRAlPtbAf3tP6hHolvTQfS0p+5VyxekDasLb8vIQLGmAVs
 LoAjmFWQv0+7Y7BGuPoTuwGptN5v7NeDXl0cjapTFWCLIeUoIwY3aCLOTLLa570NovUh
 GoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747406621; x=1748011421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jsYifqg2W3nQQyHmc9MVahFWG6m100Fl3H22xhmDURQ=;
 b=sQFtTchZUOb7UOEcfr5/xo2EK1iBzavZQWwI6Z0NdKHjt4o003Y9EarEypQ6LjjJhW
 dpA/ANxmo5DjKpaR3gbZM9fcvtW0wv0CkdV7yM59+7oH+cVzoDANURMqiiDpFONRenvn
 KcTjkdykcxS/aO8/ktTY+ZWzLj2C1ARTKp0ve513CbfVBSD7jlTO4botEXtclfH1ryaQ
 dHR2g+NKf9RIf7++WqoaCtBLejeOjff2I66r6o7jdmJxxyFTCdbtsE4pTD/MSOcNvozN
 Ozm3w8UjgdblSEK1/SQTfJOQyEGWQO3CQs04t/It/OH/vP4XMCcU2xxt2WCiw+Hyaci/
 Yxwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhtzhUgWMuxc8D/eEt1JvLwcoALiNOFsHJeGT9pU4fbwgWwr0dzodnLkutdjJjkvBJ0kMYwoFeQbiW@nongnu.org
X-Gm-Message-State: AOJu0Yz40fXY146RvqP4vgFnq/PBnjcTjXKLt4I57YzhNlxF0Yomepz0
 G6fWMl2dN8S17csZthDvMJrPBTQxSQ3lpOYNVocl/cxRxtXjkoEKy8WLN8nJxoY+AL0=
X-Gm-Gg: ASbGnct+5FrDBBWorlTiwyophnIgRHjIfbhj0R0J9XrvC/TUZQYX8Nf/783SCCN3mDp
 DtQEukmHyhKyE5dhraKF9UXup4hLTYlPhcZCIPONKufW0S2pXgR1mNrzdL3KQDeYJvuIsuQgY3t
 powFspfRnPAMy/gOyml3bL6o5BBO2aI7aGSc5f+7hbgrzSKWOzgTjsfoxkF77Kgh1IsykH8DOYS
 BxhyjqzVNjFBcEiEjrOe6AtBoeNgCuB2xwBmu9a4vm9RaBkgdZYvawNU9TIaHsBA6SVyVTdlzwQ
 MP5j9SC5MnYv1JLpHmiA8L0HquHGhcLz+7tdcsau5JzPHXJyFDshVOGelEOHDy/+6F19/XS2wns
 G/7O3EJj4+r7n
X-Google-Smtp-Source: AGHT+IHY5rcoxHG7SjsSH6wGO9MP3+gMc2vqaKSB6TFkWrSE0JT47AzpLl+5IIKhaoikSdgYeP0P8Q==
X-Received: by 2002:a05:600c:468a:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-442fefee29dmr24645665e9.11.1747406620612; 
 Fri, 16 May 2025 07:43:40 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-443000ee99csm21776755e9.31.2025.05.16.07.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 07:43:40 -0700 (PDT)
Message-ID: <68cedad7-3f97-4040-9262-1039ddc6bb07@linaro.org>
Date: Fri, 16 May 2025 15:43:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hw/i386/amd_iommu: Fix device setup failure when
 PT is on.
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, Vasant Hegde <vasant.hegde@amd.com>
References: <20250516100535.4980-1-sarunkod@amd.com>
 <20250516100535.4980-2-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250516100535.4980-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 16/5/25 12:05, Sairaj Kodilkar wrote:
> Commit c1f46999ef506 ("amd_iommu: Add support for pass though mode")
> introduces the support for "pt" flag by enabling nodma memory when
> "pt=off". This allowed VFIO devices to successfully register notifiers
> by using nodma region.
> 
> But, This also broke things when guest is booted with the iommu=nopt
> because, devices bypass the IOMMU and use untranslated addresses (IOVA) to
> perform DMA reads/writes to the nodma memory region, ultimately resulting in
> a failure to setup the devices in the guest.
> 
> Fix the above issue by always enabling the amdvi_dev_as->iommu memory region.
> But this will once again cause VFIO devices to fail while registering the
> notifiers with AMD IOMMU memory region.
> 
> Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   hw/i386/amd_iommu.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5f9b95279997..df8ba5d39ada 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>       AMDVIState *s = opaque;
>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>       int bus_num = pci_bus_num(bus);
> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
>       iommu_as = s->address_spaces[bus_num];
>   
> @@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>                                               AMDVI_INT_ADDR_FIRST,
>                                               &amdvi_dev_as->iommu_ir, 1);
>   
> -        if (!x86_iommu->pt_supported) {
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      true);
> -        } else {
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      false);
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
> -        }
> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);

I have no clue about this device but wonder what is the usefulness of
iommu_nodma now, isn't it dead code?

> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
>       }
>       return &iommu_as[devfn]->as;
>   }


