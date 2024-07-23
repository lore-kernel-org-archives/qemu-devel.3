Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84723C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHOb-0000xR-C0; Tue, 23 Jul 2024 11:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sWHOY-0000tN-0E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:25:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sWHOW-0004Dd-1R
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:25:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so5166245ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721748338; x=1722353138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aJkAx4EHIeHmpUCYkvujTomFkcKCvo5v1MjjhWkEhRU=;
 b=BsCz6XPVz9GvzmyLx51DAxlOGeVbfqPv3tmtsr0JWSGap7Fs6hT3oQo3Idbmw19OjN
 /8QqGXeOE2PRrd7b2ZjlB4I6irClnnEVyGxkC9gyhplkPIFdh0W9ZTZHO+fCQBxaHDcS
 nna6OMCZKL+fcAPwfk5oK65Qpwri+DHkvBfH4pHjFqjbc0v6JuBfNtmejLbYrW8Kp5/B
 vbXMLq1oVGaYb4Ymy83UXb4mZ7IS4rpaty3E4MAtchQoUm3MiXaA6uUz6Cvlffr9LVKA
 9LuTff9D5a3RYuMuwbwNo/WvQ9psBeJXBpM5zIamI166YsL7OiyOwdkD0wZIaVxG01qC
 e7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721748338; x=1722353138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aJkAx4EHIeHmpUCYkvujTomFkcKCvo5v1MjjhWkEhRU=;
 b=T9iGWCqvfZr43BU7MXqePsUQC/vL4rkkgpjGVswvQ0/n10sBIM1Tenn3qHbY+jb6Kz
 wRrsxFZ9R3vLN/9M46DHzzfAWGysYUaS17E3RqXTp6SP6epT5+uU/izuiP2Sm0L7nlvS
 yFJXn+/svmhFyC5ncGhgseKC9/fGpswajoZpwciJ1qvj6aoqctyNqZUGNVsVV609rbPB
 WmKTPjaRAOf3JAzprVtlERJsF6tdylkJEKmfxroXEiKcJNTgZwf7jH0Q3y4HH0IMvk7G
 oj5M7jdo/XDOT56qR8b/8ddQKyLyF+oqvuUJJqPIapT7DS9N6i9CT7u6rFf+WxzTbzXc
 JLjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW6pwrnvXRN6K4E3BQIU05arQQSY21lhnuD4zHWFqJ/plCCUU0aVIoqRVQhAN1DJL33L5pcmrsba5svsa97c5f/Gx8p+Q=
X-Gm-Message-State: AOJu0YwZPKGjc3EMziEYu9kjf9y9Ew5T+vezNzd5R3KycjK1/Kb2xdCO
 N1Rzy74A63sowU+ltkSsf7+YlFQ4Bhkk0iT3bRbtHIizNnxzqVi8R+DHcozf7hPQYrSe0L9eqjW
 w
X-Google-Smtp-Source: AGHT+IErtpyfkU5cwJvNyt7SRiFAiSi74NNRi4IybkN9L06j/ObceUmcXf4rxLmJGPINu3Mv1UHkfw==
X-Received: by 2002:a17:903:230a:b0:1fd:6529:744c with SMTP id
 d9443c01a7336-1fdd20f8dd7mr999895ad.1.1721748338122; 
 Tue, 23 Jul 2024 08:25:38 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f318462sm75921135ad.140.2024.07.23.08.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:25:37 -0700 (PDT)
Message-ID: <8e54f48e-379b-42b8-8017-886ead154415@sifive.com>
Date: Tue, 23 Jul 2024 23:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-12-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240708173501.426225-12-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x632.google.com
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

Hi Daniel,

On 2024/7/9 上午 01:34, Daniel Henrique Barboza wrote:
> From: Andrew Jones <ajones@ventanamicro.com>
>
> And add mrif notification trace.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/riscv/riscv-iommu-pci.c | 2 +-
>   hw/riscv/riscv-iommu.c     | 1 +
>   hw/riscv/trace-events      | 1 +
>   3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 7b82ce0645..d7e5f20885 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -81,7 +81,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
>       pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                        PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
>   
> -    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
> +    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT + 1,
The new interrupt is not marked as used with msix_vector_use().
>                           &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
>                           &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
>   
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 2985a49e53..c9ac3d348b 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -621,6 +621,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>           cause = RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
>           goto err;
>       }
> +    trace_riscv_iommu_mrif_notification(s->parent_obj.id, n190, addr);
>   
>       return MEMTX_OK;
>   
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index 4b486b6420..d69719a27a 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -6,6 +6,7 @@ riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t rea
>   riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>   riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>   riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
> +riscv_iommu_mrif_notification(const char *id, uint32_t nid, uint64_t phys) "%s: sent MRIF notification 0x%x to 0x%"PRIx64
>   riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>   riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>   riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"

