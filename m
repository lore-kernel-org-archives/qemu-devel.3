Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025CFD29C28
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhpmx-0001i1-Ny; Mon, 19 Jan 2026 08:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhpmo-0001We-FN
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhpmm-000519-Nv
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768831150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yw0RG/NghKbwEG67RRRsVMs/xtwoknsN3+p1LWHz6kQ=;
 b=TgeabY7Hn3IBUNx3q2QMaKKpFMBUI6GgVsTFi4M6f1+ZkRMInawIAIpGezgL29ySRJAHvA
 iV5+Rt+cPEGlcBLOkUzZRzUlhQddaIu/1yhtToamqS2H37+X5X2SnIsqyCwaqKa60HUk2Z
 822ZBTnt7olt2gOJGeiR/PKmPsaul1Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-__rx0nb_PO6DVAOYjrwRpw-1; Mon, 19 Jan 2026 08:59:09 -0500
X-MC-Unique: __rx0nb_PO6DVAOYjrwRpw-1
X-Mimecast-MFC-AGG-ID: __rx0nb_PO6DVAOYjrwRpw_1768831148
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so2778310f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 05:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768831148; x=1769435948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw0RG/NghKbwEG67RRRsVMs/xtwoknsN3+p1LWHz6kQ=;
 b=GrvL4ASu67yz2gYfmk/qOD1xpH/UoeyrofxibHznKo3NGsraq6kfuDGuSCWGhJy/BQ
 dd1VSmK92n5+UBdym+rCbKwiyXHRVwiqrF0xG3Wlyx9l7DjI/OSwMLN1TtqiLphkgCdv
 khi7oAKP5C1Vc2IiNVVLQfHASv2NtBXs6qByeRX84CZcoSKRi/wnskbeI69hNjmyZRE+
 /vCRc3SsOn+W7TJn2U81yKqRMHU5emxZh0LYB+GT15x/jVJeGGC5370/ouEYYntzGBGa
 9TQfgIFA6AZtGAV1qE2SHXdWFr59pL6y91pf82KSIrndz009+myRwStzbs/Se3LPedgE
 9nUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNiDnTWcYdfzD0VzJP3wy2etljHmukxGcMvYSJmZLBBw9RIFYfgEuYXwbo5InV1ndFF53pirpMXWco@nongnu.org
X-Gm-Message-State: AOJu0YzYFelv2fAoSPrJvVMkQlwnw8uJvn6z4d9HTuLPqmjqA93j2O5/
 HF8v/3QagyHQrUmLuwaLiBQxFQ947QdLr+3kZm72xq4TrPC0dSisfQZ5vpvcQFqSEaFpijMzP4b
 ZqUHOfq5Wob+OVN5ukiNBY0ofXEJ8WmookT7kpvVil62jqz6dbvnu0WsI
X-Gm-Gg: AZuq6aLlkYWCCqXkbbIG3NK49908M2iWlQqqGkxyPwwEQZd8u9jO/KXyYX4VV3hGSNI
 IHA4spwftdvXJU1SYkHsjtIdPGtaTzGom/pnhGmRh1Zjw7w7sxDUFz2Lt8cMQQi0wPleeXmZtaP
 S6rkxEw5sQzUt8XV2T6areoawz8bBykWMVOMGILutU3QrE3e83zor49Di7TLscR5VyXOg6C11im
 dM14Zr38rW5gDe1/eXyai6Stv7cz6LQrFLvSwUYYOZJ12Jhjz6PQrLxAmn3rT0zheLhsIE8rsOD
 Rt3JsZdAYHoPOlGrV8yM1G5ojckX/mDx6DVRAWpdhFc1bBIfqqFeawGtRIuilUd+8upGCgh7I4N
 8iploGhOcuOPjU60xEjoVcmlhg9+Nc5wqszWwefZGb8o4URjiSu9OXx0MXw==
X-Received: by 2002:a05:6000:4387:b0:431:9f1:e4c8 with SMTP id
 ffacd0b85a97d-4356998ad34mr13226336f8f.17.1768831147957; 
 Mon, 19 Jan 2026 05:59:07 -0800 (PST)
X-Received: by 2002:a05:6000:4387:b0:431:9f1:e4c8 with SMTP id
 ffacd0b85a97d-4356998ad34mr13226294f8f.17.1768831147446; 
 Mon, 19 Jan 2026 05:59:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999824csm23185633f8f.39.2026.01.19.05.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 05:59:06 -0800 (PST)
Message-ID: <0bb600f2-f47c-4b2d-832a-f19ed4f3fe7b@redhat.com>
Date: Mon, 19 Jan 2026 14:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/36] hw/arm/smmuv3-accel: Implement
 get_msi_direct_gpa callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-17-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260111195508.106943-17-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 1/11/26 8:53 PM, Shameer Kolothum wrote:
> Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
> translation (guest Stage-1, host Stage-2). In this mode, the guest Stage-1
> tables are programmed directly into hardware, and QEMU must not attempt to
> walk them for translation, as doing so is not reliably safe. For vfio-pci
> endpoints behind such a vSMMU, the only translation QEMU needs to perform
> is for the MSI doorbell used during KVM MSI setup.
>
> Implement the callback so that kvm_arch_fixup_msi_route() can retrieve the
> MSI doorbell GPA directly, instead of attempting a software walk of the
> guest translation tables.
>
> Also introduce an SMMUv3 device property to carry the MSI doorbell GPA.
> This property will be set by the virt machine in a subsequent patch.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c   | 10 ++++++++++
>  hw/arm/smmuv3.c         |  2 ++
>  include/hw/arm/smmuv3.h |  1 +
>  3 files changed, 13 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c125974d12..c6ee123cdf 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -393,6 +393,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +
> +    g_assert(s->msi_gpa);
> +    return s->msi_gpa;
> +}
> +
>  /*
>   * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
>   * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
> @@ -497,6 +506,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>      .set_iommu_device = smmuv3_accel_set_iommu_device,
>      .unset_iommu_device = smmuv3_accel_unset_iommu_device,
> +    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>  };
>  
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7a32afd800..6ed9914b1e 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    /* GPA of MSI doorbell, for SMMUv3 accel use. */
> +    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index e54ece2d38..5616a8a2be 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -67,6 +67,7 @@ struct SMMUv3State {
>      /* SMMU has HW accelerator support for nested S1 + s2 */
>      bool accel;
>      struct SMMUv3AccelState *s_accel;
> +    uint64_t msi_gpa;
>  };
>  
>  typedef enum {


