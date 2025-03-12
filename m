Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF77C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOh6-0005Kh-KG; Wed, 12 Mar 2025 12:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOgp-0005Ic-Kv
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOgn-0000Pz-Nw
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741795931;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNI+Vf2IaG7FEwoAQmbTMxEbb9D+xyxcHf70UzDQj0A=;
 b=DOKjZBOW1xmUelCx3DNOS+dltJcbGNvLJx4wuSofN4fZf+1s+OF/Jfn2YpZEooNC289lC+
 hlc2FRaltooBQFUGsYABg38AYj+houJJoHtMXibhanqEJhR3/bmoqiqQEFC2bdo8i/Qnmm
 tERa+qCUSVctBFiDxNVUroWJa4trDFU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-8eW2Nh7wOAm37y5-73-Nfg-1; Wed, 12 Mar 2025 12:12:07 -0400
X-MC-Unique: 8eW2Nh7wOAm37y5-73-Nfg-1
X-Mimecast-MFC-AGG-ID: 8eW2Nh7wOAm37y5-73-Nfg_1741795926
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c3c03b6990so1307597985a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741795926; x=1742400726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iNI+Vf2IaG7FEwoAQmbTMxEbb9D+xyxcHf70UzDQj0A=;
 b=FcZgMRfYTuAPETKM5BEciRxCWg+x9QiXaG2gyCEL/oFEtiQjF7geJSBjr3UbsoKsAW
 JTinS6bFf2ot5/cWXHekp4YY59oGGlGMm8VboQCgup8l/V5pU1l0Uf9hIxd16MVhfEQc
 i+KbGM1sPG2W1j5uPGkVlXyog+HSYIkSHoSqNSrw3LinAb/sz3ia7V9Egc0U4xLUkwUA
 Wf8wcmcNwtdFJDPwP61RmspJH3hp3kYS0X8AfKtQ4mDbL+KgbuTxXPKN39Wx45xPXDP6
 w1Ic5EfRAf1jEOPljeYfrggq7FVSbx4IJiYbcDZRdKqhx6Iv8cth2iOVB1xPcdAx7HnD
 WQvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9r8WAhjdSoA0dhM1n7yLxctSa9S3U+1bvHD5/wdQX2fdl2VAGjjjjTDaV2yhqVn65uG9qJFjYXBLs@nongnu.org
X-Gm-Message-State: AOJu0Yx2+1NRS2aPTBK/KyG+NuvNP03SP8w5d6pcXPAUzhE92z2I0DH3
 TqydHTRPK91M0/n6MoKDNC/Cl1PfYUFrk6C/KKffQCvuX6F8EhWGhY20WT7LpnIDVD5brCjdDNd
 xFHszaaE14uov2n9SjgVlWHPuGopdj3Dq1xbVUDYcTat6RdxUNJYz
X-Gm-Gg: ASbGnctLru9GFbJUfGr05RuAk6UkEy1/5+eTY6VNX4dw/2us9g8nfRHjijW5NfIK7te
 V5ymG8pV99Qa4PwzGELj3VbvDq1Dv5Zsf862QqU/vFZIV6R/e0bc5dh6+NjQ/x9A8c4pVyrdN02
 QVoKSem/vwQdTZyFkAIOpt5Ba/jliJ/PYsXetAuPmGkC6O8aR3obVVJ+7CewnpYjTPPsr8ZMvAI
 6tsMrIwxXGUEgfpf+U7daKJyE0JSV5vYyTqbO+2S/RQmeBfdekMQW2cxxx2Y8rhsWS59mXT1g98
 OxoWcnOad4DO9WG/IeQVxssXqPAPshkLvP4ZxdnBZqQMVfFp5lDqYSESPjK0iLk=
X-Received: by 2002:a05:620a:260a:b0:7c5:5cc4:ca5a with SMTP id
 af79cd13be357-7c55cc4cc68mr1528320085a.4.1741795926508; 
 Wed, 12 Mar 2025 09:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXoyIUNnWlqSZVWW+YJXN0n0X6Zi2HM6KDw0rAK6PYilJ5fuoMUkbz1Ke9NcEzM3evT8lfQQ==
X-Received: by 2002:a05:620a:260a:b0:7c5:5cc4:ca5a with SMTP id
 af79cd13be357-7c55cc4cc68mr1528316885a.4.1741795926207; 
 Wed, 12 Mar 2025 09:12:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c55f112215sm285720085a.109.2025.03.12.09.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:12:05 -0700 (PDT)
Message-ID: <0ac24089-9a5e-48e8-bcdd-60e63aa3f34f@redhat.com>
Date: Wed, 12 Mar 2025 17:12:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/20] hw/arm/smmu-common: Factor out common helper
 functions and export
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-7-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Subsequent patches for smmuv3-accel will make use of this
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c         | 48 ++++++++++++++++++++++--------------
>  include/hw/arm/smmu-common.h |  6 +++++
>  2 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index f5caf1665c..83c0693f5a 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -826,12 +826,28 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
>      return NULL;
>  }
>  
> -static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
> +void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev,
> +                    PCIBus *bus, int devfn)
>  {
> -    SMMUState *s = opaque;
> -    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
> -    SMMUDevice *sdev;
>      static unsigned int index;
> +    char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
> +
> +    sdev->smmu = s;
> +    sdev->bus = bus;
> +    sdev->devfn = devfn;
> +
> +    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
> +                             s->mrtypename,
> +                             OBJECT(s), name, UINT64_MAX);
> +    address_space_init(&sdev->as,
> +                       MEMORY_REGION(&sdev->iommu), name);
> +    trace_smmu_add_mr(name);
> +    g_free(name);
> +}
> +
> +SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
> +{
> +    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
>  
>      if (!sbus) {
>          sbus = g_malloc0(sizeof(SMMUPciBus) +
> @@ -840,23 +856,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>          g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
>      }
>  
> +    return sbus;
> +}
> +
> +static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUDevice *sdev;
> +    SMMUState *s = opaque;
> +    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
> +
>      sdev = sbus->pbdev[devfn];
>      if (!sdev) {
> -        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
> -
>          sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
> -
> -        sdev->smmu = s;
> -        sdev->bus = bus;
> -        sdev->devfn = devfn;
> -
> -        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
> -                                 s->mrtypename,
> -                                 OBJECT(s), name, UINT64_MAX);
> -        address_space_init(&sdev->as,
> -                           MEMORY_REGION(&sdev->iommu), name);
> -        trace_smmu_add_mr(name);
> -        g_free(name);
> +        smmu_init_sdev(s, sdev, bus, devfn);
>      }
>  
>      return &sdev->as;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index b5c63cfd5d..80ff2ef6aa 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -178,6 +178,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
>  /* Return the SMMUPciBus handle associated to a PCI bus number */
>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>  
> +/* Return the SMMUPciBus handle associated to a PCI bus */
> +SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
> +
> +/* Initialize SMMUDevice handle associated to a SMMUPCIBus */
> +void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
> +
>  /* Return the stream ID of an SMMU device */
>  static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>  {


