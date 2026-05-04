Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD7CCD3439
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJumy-00087E-QR; Mon, 04 May 2026 11:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJumx-00086e-8T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJumv-000621-2P
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777906847;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgyG+JgynYWmUZNnLcW6/ZFDoGgc9nqUJcjRlVtM2MI=;
 b=ZayhJ4JuZSm4U988hXu/GCIH7aBPPtSY7wC2P3y5MYnqyCtwChH5WMrMKhsTS8z1QTqU9C
 EcSkwoaa0Pn3uj0+QgDOsBFH00qNlApuUZpjwA5hW2nUlFxfRmR+zWaRTSGwcfX7w17JHj
 LjMA5ksJS6gFvR44Ipn+KYHeAO7pRRY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-hKnRt8HuOOelqn1ofID4pA-1; Mon, 04 May 2026 11:00:44 -0400
X-MC-Unique: hKnRt8HuOOelqn1ofID4pA-1
X-Mimecast-MFC-AGG-ID: hKnRt8HuOOelqn1ofID4pA_1777906843
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a5adc141cso21608805e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777906843; x=1778511643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgyG+JgynYWmUZNnLcW6/ZFDoGgc9nqUJcjRlVtM2MI=;
 b=UDn5E5QPlyNY5+79+NxYY+s065UOKvSMizIgmxpVoSJ6fV2L33gDw4+09RojTcFdnq
 0cuGzHHHLMcBPJyK8rvnObDyqnkD21y6Gm9mTbD05Izk9gPBffkMk6lBDHtTh5Z3gXOV
 QLJCWSetQELSHVRWPZoN16ym2+3XPlBAaf51cATzLRQ8o2LuM4lKxcr47x342SPZlvoe
 JaN2Gyzup9O05GCMnAmG9SdtDBfefxvKnRTxR3/5IXvyVnHcWvlmBjCi59G2bWY3wZS9
 sDAeen4RditD3+wmwSRKLArEMgyyPgbpjfuqFK/kMGZAAuHp59khFfMk6YlYTbsyyVcB
 wdgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IKAkd1B2wIeC1CY/lWY/Xg5eItifOGjYBlLZdsaU1SYkMd4ODcPwhh/brBF15r07HovpjPyLrNsAi@nongnu.org
X-Gm-Message-State: AOJu0Yxt+5EVbwv1AzXjYBcBFDF5mFdC5z7URQ8j7k7vp2IKkRM/gV5y
 SOgJuhTlBLOqO/mnpy7a9PoJ+cNgbGUE0oRaSccYUc1mEZzI40RQV+BD50M+OH/txw2JUQlf5NW
 ewPrFZsfYq9pQK+LfnU7jLk7VoDYho3FpUXrSrho8/swwt8lej8IDswYQ
X-Gm-Gg: AeBDiesuVf2gT8gvWS/190zYXGNWTsSUFX2ly1B0EZSd1A/LG7/Pk6u3vOp1urufnmz
 yXRuFGcZn0rHMviIWGEm5TmueuVMXY7ezMZR7uD8I/739C8xHthr+2NUZNUrLJt8lmQdmHH92D4
 w4XeaUCsDKi+s8aje3RUk0FtvKSq8TOGN9VicvTqBBxZyGaU8hL3dJym4gyH9QtsioGKV+59D3A
 Iy7P3exy8w0ujpyRe6DYjyZCtXXwFqSpqY83sh2ec0+EEsUbLcLddnHVi3zaFf6mfWJToa4tEWj
 ylnTBRkwiq8fuWiiMFVqxfJflmFNTY/fHo+O30G10yS2Rg1d9rt1cg+pAdblp3Jn55IhLqZJnay
 EF3561pKxKVF4dCyJmRSOFYFFGrCiOTp1mtLjYUupInL/90UJjYHiu4MV7NyC4m3Xb1K8m7cgqJ
 LZyq7D
X-Received: by 2002:a05:600c:83ce:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48a970eae79mr139778415e9.10.1777906842952; 
 Mon, 04 May 2026 08:00:42 -0700 (PDT)
X-Received: by 2002:a05:600c:83ce:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48a970eae79mr139776985e9.10.1777906841427; 
 Mon, 04 May 2026 08:00:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed69fasm394745785e9.3.2026.05.04.08.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:00:40 -0700 (PDT)
Message-ID: <17a85707-d4df-4f5f-879c-8e351f7cdbe7@redhat.com>
Date: Mon, 4 May 2026 17:00:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/31] system/iommufd: Remove unused viommu pointer
 from IOMMUFDVeventq
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> The viommu field is assigned but never used. Callers freeing the
> veventq already have access to the IOMMUFDViommu object through other
> references, so this field is redundant.
>
> Removing it also simplifies upcoming changes where veventq is
> allocated based on the viommu id before the IOMMUFDViommu object is
> created (e.g. vendor CMDQV-based veventq allocation).
>
> No functional change.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/system/iommufd.h | 1 -
>  hw/arm/smmuv3-accel.c    | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 38cfceca84..b6599521b8 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -58,7 +58,6 @@ typedef struct IOMMUFDVdev {
>  
>  /* Virtual event queue interface for a vIOMMU */
>  typedef struct IOMMUFDVeventq {
> -    IOMMUFDViommu *viommu;
>      uint32_t veventq_id;
>      uint32_t veventq_fd;
>      uint32_t last_event_seq; /* Sequence number of last processed event */
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c356ff9708..f65e654adf 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -549,7 +549,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>      veventq = g_new0(IOMMUFDVeventq, 1);
>      veventq->veventq_id = veventq_id;
>      veventq->veventq_fd = veventq_fd;
> -    veventq->viommu = accel->viommu;
>      accel->veventq = veventq;
>  
>      /* Set up event handler for veventq fd */


