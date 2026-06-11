Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C97CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXh2h-0005zQ-9j; Thu, 11 Jun 2026 11:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXh2f-0005yt-In
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXh2d-0007Ff-UG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781190599;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwoMDHKyixROezYf5MQBAnBHtD5tsWXd1Xniqee45l4=;
 b=fbg1lA0I4tBF081sShOz+4BMF8pTjOyqDaItc3HUj1sUYFKWXzb4B5xXUDglEyF8f2ZRia
 WBQgVmJW1OZ2Lid9MBhYUB18HDUgQJNTNGS2XHeLk2HUboA6wkoFAMM6z13fDPYiXYBsRz
 GoOQXGIeMkxxjlq1CyCGyiBZq/bjgno=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-t_SWMfd3OH-Q1A4VTGXjDA-1; Thu, 11 Jun 2026 11:09:57 -0400
X-MC-Unique: t_SWMfd3OH-Q1A4VTGXjDA-1
X-Mimecast-MFC-AGG-ID: t_SWMfd3OH-Q1A4VTGXjDA_1781190596
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46010392f89so7281096f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781190596; x=1781795396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwoMDHKyixROezYf5MQBAnBHtD5tsWXd1Xniqee45l4=;
 b=imsq0dgYlH2CUFzJOz5xCMWW2xVYFavHKcSB8pqcT5Omw+1JAekegX6IHHk5n+VZdj
 8k0XEOGc0I2A2BLJSzXzOSakWXuyVsWhxiMccfIE5B+SdAPO/noPICswquZCubLyYvqV
 HXxOGn+coP4fTn0dmFfmF4A0sY48AuDCkeE0OlfKyvbGtZ9iIrLDO69YRX3ud/+dDeax
 yZCKRMpdUr8ZOdSCpogCQ10DGMXUVxPnqZc0onkoRLwalQ4Agz7HDyqr2zdt7p/VdgDL
 xw4u5Rm0HTztwetl/fC5GGzp0WxRbIKMiGYf2HQkqaVVuTz5q/V9XOmLakhDV++jYesL
 alHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WSlkVXHnHkZQNCyeXd0mHjpI76zwFyiG8ANvpuWReAOjORyu9GZiVZpSLd0FMQt1CrmTxh2xJtaic@nongnu.org
X-Gm-Message-State: AOJu0YwaqgPRgsdx7FSUwwnwEYFR1O/v34CKZNmiIgYct3rNLsNQNsDu
 BFRQvAndsQaod+S6XjtNZDK41FQSCnoU67H1QSQodobwslRO60V00+/H1K8qQ8bPzqxPb76aQc2
 S4iHmSOSJUuBL5+Z8BmX3fxNrGxHX649afm49a+mZ526sj7qKptoDh0fE
X-Gm-Gg: Acq92OFHWykrC9GGpMeBXSs9iSYB7TZL4P+TVfhqK5KHI64y2d3no1TuXCcLLfK9k36
 hnSr6IWRogjRAlNviSQC9toFPL9K7XxrLik4RDa8aswjyzOSwxgc2Mbeo4Ow7VxaEe165qpGKnz
 8BJD2ZhYOqvMFy2L4ylavRPZnrIqyszODG9b0czQBretQh/QyRcC6UpP+Ry/Pbspqg/xtbfuaqI
 Zm3JwfI87KuDr48IHoFX2VhpAQCm81J/u1YyqwLUM9iFZ2WlrfSmX1g/TtufzOQylowvUiPyJ61
 wfwapuFujEXsGGkYL7/kRkx7JHPnJcgElM4CkUJiwmCgGM3/zZfolAvZmfNe0BXMgfsG+1Qddcx
 DghYFBia/4q8l+7kBJ7SqDPqABrbCBcyBVVIZnWaKjXT0iTHOsSAu7FdmXpZOsDVUMWBEAyUETd
 S9Ou1d
X-Received: by 2002:adf:e007:0:20b0:45d:b14b:23fb with SMTP id
 ffacd0b85a97d-46067475934mr4139543f8f.11.1781190596191; 
 Thu, 11 Jun 2026 08:09:56 -0700 (PDT)
X-Received: by 2002:adf:e007:0:20b0:45d:b14b:23fb with SMTP id
 ffacd0b85a97d-46067475934mr4139492f8f.11.1781190595795; 
 Thu, 11 Jun 2026 08:09:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm76396194f8f.8.2026.06.11.08.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 08:09:55 -0700 (PDT)
Message-ID: <cd93c431-888d-40a6-b373-960d5498d2a5@redhat.com>
Date: Thu, 11 Jun 2026 17:09:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/31] hw/arm/tegra241-cmdqv: mmap host VINTF Page0 for
 CMDQV
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <20260609112552.378999-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260609112552.378999-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 6/9/26 1:25 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> The kernel currently exposes a single VINTF per emulated SMMUv3
> instance. IOMMU_VIOMMU_ALLOC returns an mmap offset for the host
> VINTF Page0 allocated for this SMMU. However, VCMDQs only become
> bound to that VINTF after IOMMU_HW_QUEUE_ALLOC, so until then the
> mapped Page0 does not back any real VCMDQ state.
>
> mmap the host VINTF Page0 right after IOMMU_VIOMMU_ALLOC, as the host
> VINTF is already enabled at that point, and unmap it when the vIOMMU is
> freed. The mapping shares the vIOMMU's lifetime. This prepares the VINTF
> mapping in advance of subsequent patches that add VCMDQ allocation.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/tegra241-cmdqv.h |  3 +++
>  hw/arm/tegra241-cmdqv.c | 16 +++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 9fc720e96c..00c83b6186 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -25,6 +25,8 @@
>   */
>  #define TEGRA241_CMDQV_IO_LEN 0x50000
>  
> +#define VINTF_PAGE_SIZE 0x10000
> +
>  struct iommu_viommu_tegra241_cmdqv;
>  
>  typedef struct Tegra241CMDQV {
> @@ -33,6 +35,7 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      IOMMUFDVeventq *veventq;
> +    void *vintf_page0;
>  } Tegra241CMDQV;
>  
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index c1351c8519..3eec6073a4 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -41,6 +41,10 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>          g_free(veventq);
>          cmdqv->veventq = NULL;
>      }
> +    if (cmdqv->vintf_page0) {
> +        munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
> +        cmdqv->vintf_page0 = NULL;
> +    }
>      iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
>  }
>  
> @@ -60,13 +64,20 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          return false;
>      }
>  
> +    if (!iommufd_backend_viommu_mmap(idev->iommufd, viommu_id, VINTF_PAGE_SIZE,
> +                                     cmdqv->cmdqv_data->out_vintf_mmap_offset,
> +                                     &cmdqv->vintf_page0, errp)) {
> +        error_append_hint(errp, "Tegra241 CMDQV: failed to mmap VINTF page0");
> +        goto free_viommu;
> +    }
> +
>      if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
>                                         IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
>                                         1 << SMMU_EVENTQS, &veventq_id,
>                                         &veventq_fd,
>                                         errp)) {
>          error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
> -        goto free_viommu;
> +        goto munmap_page0;
>      }
>  
>      veventq = g_new(IOMMUFDVeventq, 1);
> @@ -77,6 +88,9 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>      *out_viommu_id = viommu_id;
>      return true;
>  
> +munmap_page0:
> +    munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
> +    cmdqv->vintf_page0 = NULL;
>  free_viommu:
>      iommufd_backend_free_id(idev->iommufd, viommu_id);
>      return false;


