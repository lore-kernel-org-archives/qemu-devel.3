Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F46CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvkN-0001A9-N6; Mon, 04 May 2026 12:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJvjS-0000mN-ME
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJvjR-0008AS-6L
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777910476;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJZ+j+/C1nuMP3Jo9t7IR0Qkle0T7gUt1LCimRZnXgY=;
 b=Gyxu53wvBZmnxKP+6ShH4FjyJmJDhPgIdEOQqxGNZiDwY5XVscFa0q207nwuGXO4Ip6Xuy
 EOYgG8M6E33pavME0DnYvgavSJY2ZGJTV+AIsdnYsJyTWHWll10tPlzgWB0j93aFTwjmPa
 1pi/Mch1EAATRRuwYBNB5E38lzvJZo8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ZNZMhzgFOC6qAt3TWeMsiw-1; Mon, 04 May 2026 12:01:12 -0400
X-MC-Unique: ZNZMhzgFOC6qAt3TWeMsiw-1
X-Mimecast-MFC-AGG-ID: ZNZMhzgFOC6qAt3TWeMsiw_1777910471
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488ba2f4094so30592775e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777910471; x=1778515271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJZ+j+/C1nuMP3Jo9t7IR0Qkle0T7gUt1LCimRZnXgY=;
 b=obavZcZ5yZ4p09DEdC5zEVYklCmEqmw9mnMrIPYMO19Hr9CWRVr77t1/euzUQpAURk
 4cFkzgIH521ppApnYZcP3FAFvIXHo3F+Mt3au+3pVjXuJPZVkyvZJamL6qrUrIHfLVuD
 Clu5hFQK1MgF9uuxCHEjaDwQxnVF8PrDISHH5u1sn2kP670NafXQb2pTOhe8KB7RmlLs
 00SVi0D1hGxEcfbh7SorKtDo1B29m5fMG/r3X8axpqrNT2lboSk47BI3Od/Oa3gWkTMa
 QEZCAZLvxW/jvUOUinSrSkujr4iXNRJaVr0S4jeYF2sAMBwBFwQTmO9QNHQ9Sxv27lNM
 HKaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SJOB3yGMKIX7SDpAv51+6hj5fP65roj/e+e0QE0ioWPiXEJGidNYK9G9FX434chHXpxhxBSeFfiZT@nongnu.org
X-Gm-Message-State: AOJu0YyWwwtkr9O0mnZbspd6NjAED/I38FM4DEg4qu0xmY+EY17uZXPR
 8FESPNcUQKcg/g04aiVj1UVmFMPxapLDAtLTD8RPPtf5lV4V9v1Y4PNIv/+ThHh6HdG5C2HSMIN
 cGBvL04vI7L2+S5NYvEQrh93e0pEqycRlnrWek1hMsEyr2efey49ReKoo
X-Gm-Gg: AeBDiet+oqwQsq/ThZtZ1oXtRMqyiaj107t141l30BEM5oOlW1thNM3vOqOfkspqxQP
 t1UUP4930sPwePdyBTy+q9hErPZ8WLuepBpfygXzpTq3qRV2ZHKt4lV2GIfCRTdzh4Ijhrj3fzN
 UnePpAeu/FzKVFhKw/gNp3e5tMNCOV1xt4n9cH6YasMRSj8G+dP41lG6orNQmk4Fzr580IIfDty
 MOYf23lm3n5qkUaqDu4Z+L1vmiZpxdssK9pb/3Qej0GIJeS0mMgesl927VLbTb3qwHzbiKvZ7HE
 AhHru5p4l4AjHkYVvlXiF3woZTkS24unEwbZsVWPOvFIxf0214kmrO02tfMxILYvkpm9cebfjwq
 41u2iwX3oVurooFz9dh+B9AVen45ZJdoI6IcuMtp1229OzwCqFPnoPKkXP2hRsSoiVJs0iXNpUa
 /Mlo6+
X-Received: by 2002:a05:600c:8b0e:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-48a9852d122mr161545275e9.5.1777910471201; 
 Mon, 04 May 2026 09:01:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0e:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-48a9852d122mr161544265e9.5.1777910470482; 
 Mon, 04 May 2026 09:01:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebc4201sm451562435e9.15.2026.05.04.09.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 09:01:09 -0700 (PDT)
Message-ID: <e1a3cb59-1faf-428e-8e85-f3f4059ee1cf@redhat.com>
Date: Mon, 4 May 2026 18:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/31] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-14-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-14-skolothumtho@nvidia.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Replace the stub implementation with real vIOMMU allocation for
> Tegra241 CMDQV.
>
> Allocate a matching vEVENTQ together with the vIOMMU, since it is
> specific to the Tegra241 CMDQV vIOMMU and used to receive CMDQV
> events.
>
> Free both objects on teardown.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/tegra241-cmdqv.h |  1 +
>  hw/arm/tegra241-cmdqv.c | 46 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 2a34a4b6b4..fa0aa3ab04 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -30,6 +30,7 @@ typedef struct Tegra241CMDQV {
>      SMMUv3AccelState *s_accel;
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
> +    IOMMUFDVeventq *veventq;
>  } Tegra241CMDQV;
>  
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index ccd3c6d275..2f1084b55f 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -25,13 +25,57 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>  
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>  {
> +    SMMUv3AccelState *accel = s->s_accel;
> +    IOMMUFDViommu *viommu = accel->viommu;
> +    Tegra241CMDQV *cmdqv = accel->cmdqv;
> +    IOMMUFDVeventq *veventq = cmdqv->veventq;
> +
> +    if (!viommu) {
> +        return;
> +    }
> +    if (veventq) {
> +        close(veventq->veventq_fd);
> +        iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
> +        g_free(veventq);
> +        cmdqv->veventq = NULL;
> +    }
> +    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
>  }
>  
>  static bool
>  tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                              uint32_t *out_viommu_id, Error **errp)
>  {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
> +    uint32_t viommu_id, veventq_id, veventq_fd;
> +    IOMMUFDVeventq *veventq;
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +                                      idev->hwpt_id, &cmdqv->cmdqv_data,
> +                                      sizeof(cmdqv->cmdqv_data), &viommu_id,
> +                                      errp)) {
> +        return false;
> +    }
> +
> +    if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
> +                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> +                                       1 << 16, &veventq_id, &veventq_fd,
> +                                       errp)) {
> +        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
> +        goto free_viommu;
> +    }
> +
> +    veventq = g_new(IOMMUFDVeventq, 1);
> +    veventq->veventq_id = veventq_id;
> +    veventq->veventq_fd = veventq_fd;
> +    cmdqv->veventq = veventq;
> +
> +    *out_viommu_id = viommu_id;
> +    return true;
> +
> +free_viommu:
> +    iommufd_backend_free_id(idev->iommufd, viommu_id);
>      return false;
>  }
>  


