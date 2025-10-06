Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E2ECCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 20:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5rkJ-0006f8-9p; Mon, 06 Oct 2025 16:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1v5rkG-0006ef-Ph
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1v5rkF-0008Fi-AQ
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759782221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhzD7FAtaAw2QXvjxzYI48PwtcCuGtWVKtdJ1kDnUC8=;
 b=VRoD8UL0ezhpRIHoTpsUDRDA6/bHuosViNp4VBtPHmC6WSo21YUNm3vayFd8wCIH9Xxb5n
 sNuJdsPNHRlfj0VH1AT59TKGf3Bic00PrdlnUxAefE2eywK9mZvROfA/pbXTRxI1ORI2Qu
 DeNOjVMpztVOTNMItHNp378eE9OKMac=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-KaP7fEeMNhuUMHdq-I8qMw-1; Mon, 06 Oct 2025 16:23:37 -0400
X-MC-Unique: KaP7fEeMNhuUMHdq-I8qMw-1
X-Mimecast-MFC-AGG-ID: KaP7fEeMNhuUMHdq-I8qMw_1759782217
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4d6a41b5b66so140164401cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 13:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759782217; x=1760387017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MhzD7FAtaAw2QXvjxzYI48PwtcCuGtWVKtdJ1kDnUC8=;
 b=DlDlGD3dFKrr8KJ589H8+JQXRtY69kvubgF1EPQBzAW61Vk5fw1F6V7CfsHOA7XpWD
 dmmBdItMSIP7GgY64MBY5kQOA4r9icioDbVpubGH/Cem+Y6EG13lTppoc/atpNbzqzJl
 g6gICb+6xRznd/ScqwAaPXCDc0kVVA99Du85UweA35jmWr80jW33EbMvTzoKL1X+zeuB
 /QfQi80Vc+nmjAWs3o1sIdFsrKe38ifVumhzpQQmhORQ+NumgYoljTQHJhf4vdinL3ll
 v1ojkxIfDUZBUWweJZm/lbmS5Bsm3M3a8qX84fhbzgYKNQJ6afmCozrjtF92vhM2hAyE
 YQew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAt6z1T27Nmr0Z6f2RlzgwRcWrMa3PHSRsyMJwgIL142Pmz131P6UwogoyxGQFD21JBtOXs+WCxKWj@nongnu.org
X-Gm-Message-State: AOJu0YzUZ82y3VG2exGB6+nys/Fg3RMzM8EFoXC6ldxx9zYNJcqM4Bjo
 HTOzQnb1k7a0FKpaLqSlW9iwvxj0ni/5mA1cE/BdGwLJCfKNs21Mp5AYfwRyKXbQPyB/R5/jn/x
 CAY0ZpeSY25awQfStqegXZ3ecNkUujFsUS9Fbl+J4+j3gA++1S+aCKDmy
X-Gm-Gg: ASbGncvl4x25De1fnox6GL2GYAW6HV8WiibDaJmN3y4rxgDTtcMlmegRmNNqEnvvfNQ
 hO3myobM02bR11yVkVcCi5wVAZxaZOQgfOVUxGcO8jPUFeUXNmmpE66c3UGyXoNC/7aWOLWtg72
 HU0jwNNkiQTuaR+MzASSyqdf+FomeX1rik10Rmmn8wvwZmfl0jFneII3A3zOrUxlbBBARoxPdPM
 ZMOjlO1oB1WoTTAy9FAxUD9ehUepT/JirlhR+SjR55HwowkUUOxcfBrvRnGZS1w/Ixcm/HOX7xR
 MKN6G+B6g/RqejWxhBzFPU+sAYNC0Q36ywJMk/eljELY2w==
X-Received: by 2002:ac8:5793:0:b0:4d0:fbd5:4cd5 with SMTP id
 d75a77b69052e-4e576a45315mr191308281cf.11.1759782216802; 
 Mon, 06 Oct 2025 13:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIIGPUUUk2jVsxcHtl01Md60O1s+COY4irBcc9/YrXwgyitFQsVxLHRVhcsXvvoRNf4xTAFA==
X-Received: by 2002:ac8:5793:0:b0:4d0:fbd5:4cd5 with SMTP id
 d75a77b69052e-4e576a45315mr191307951cf.11.1759782216424; 
 Mon, 06 Oct 2025 13:23:36 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e5579d6f35sm128327781cf.0.2025.10.06.13.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 13:23:35 -0700 (PDT)
Message-ID: <0b8ce0de-83a6-437e-a4a6-e862fbb164ee@redhat.com>
Date: Mon, 6 Oct 2025 16:23:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/arm/virt: Document user-creatable SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, nicolinc@nvidia.com,
 nathanc@nvidia.com, mochs@nvidia.com, jonathan.cameron@huawei.com
References: <20251006182900.100580-1-skolothumtho@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20251006182900.100580-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/6/25 2:29 PM, Shameer Kolothum wrote:
> The virt machine now supports creating multiple SMMUv3 instances, each
> associated with a separate PCIe root complex.
> 
> Update the documentation with an example.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   docs/system/arm/virt.rst | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 10cbffc8a7..2e0e8196be 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -37,7 +37,19 @@ The virt board supports:
>   - An RTC
>   - The fw_cfg device that allows a guest to obtain data from QEMU
>   - A PL061 GPIO controller
> -- An optional SMMUv3 IOMMU
> +- An optional machine-wide SMMUv3 IOMMU
I suggest a '(see example below)' at the end of the above line.

> +- User-creatable SMMUv3 devices
> +
> +  Allows instantiating multiple SMMUv3 devices, each associated with
> +  a separate PCIe root complex. This is only allowed if the machine-wide
> +  SMMUv3(``iommu=smmuv3``) is not used.
> +
> +  Example::
> +
> +      -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
> +      ...
> +      -device pxb-pcie,id=pcie.1
> +      -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
I like the detail; and wish it was done for many more of the -<option> above it,
e.g., PCIe, MSI, etc.

>   - hotpluggable DIMMs
>   - hotpluggable NVDIMMs
>   - An MSI controller (GICv2M or ITS). GICv2M is selected by default along
> @@ -176,7 +188,8 @@ iommu
>     ``none``
>       Don't create an IOMMU (the default)
>     ``smmuv3``
> -    Create an SMMUv3
> +    Create a machine-wide SMMUv3. Alternatively, SMMUv3 devices can be
s/Alternatively, SMMUv3/Alternatively, non-machine-wide SMMUv3/
Add:
'Note: user-creatable SMMUv3 devices cannot be instantiated if a machine-wide SMMUv3 is instantiated.'

Or should this section be moved up and after the updated 'optional machine-wide SMMUv3 IOMMU' above?
So all-things SMMUv3 are in the same doc area, and not split up as they are now, and not worsen over time as
more things (accelerated SMMUv3 documentation) is added


> +    instantiated directly using the ``-device`` option (see example above).
>   
>   default-bus-bypass-iommu
>     Set ``on``/``off`` to enable/disable `bypass_iommu

Thanks for the added documentation; more is better!
- Don


