Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD27C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uLO-0003mR-G5; Tue, 14 May 2024 11:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uLF-0003f7-5u
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uLA-0003ud-O5
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715701519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Xp1p+d3x60xDM42VRNuPjdDBZLXixKHhBwuUmQo9rE=;
 b=ZBZpBF+zv/C+6GAsgr72/w+EnyS+1f1YKNcxo1cjHpAdGempIiJcDBNbVrY1qIxoBDw5UF
 jUhjkiJfw5VQ2zS50LaSh9OYBwDWx0lWfnZ9OAGf5umK1Cx680s72SXL2ecwNner2DMhyp
 NaVn5mMFLSCV97u9IL18qNOt4F7asrE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-ZPni2cJBOTGPwHHkuHhN-A-1; Tue, 14 May 2024 11:45:17 -0400
X-MC-Unique: ZPni2cJBOTGPwHHkuHhN-A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43e0e94fa82so40996021cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715701517; x=1716306317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Xp1p+d3x60xDM42VRNuPjdDBZLXixKHhBwuUmQo9rE=;
 b=KDAJx8UcYYxui15RDRHZsU2PGVG9ShfmincVwGFPcXVuIGOa8Q/4Ze8C2Dq6LOnPoH
 wJ3tbZpbYt23egIM+DhbtUKKSKHSUjTcYeSvFmpTFVkGGymSpeaJi+1SK0zLLcpFrYPR
 mHqwucSrDrCXcoHRVknVDyNRkctHIzgvMsjBODpnAqwwNgphswCU7ZDTDUj+cimrpLrM
 +PhOAQLbjUiU7VpTGBw1l7ctU12cpIBYYi8yxeB0S8oO2UfhMq5NB8KUpfVTmZJFK16M
 I79tIzLBpFehQC04gdZB5kzsKD0moNEhVxXSSfqpXKaxhGKZBAenupE/s/B3iieRRelF
 SlbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEgYqJHTdxRgK1DKqAgGnNMkJXU7tKbkkJfCnA1KJjF1GxTdzqBbyq8D3sjI2B5fsJBPrOKIUYHO0w0DeoDFcQLcs6/jE=
X-Gm-Message-State: AOJu0YyzQTw34Mn+v5Q2+9C98qbQ3KuF+26saPIyl7t6rGJs1RYlwAIO
 6baqEVZ0hJy1/a9BPYzlpbj/GcBlddyHlqtP231c7hEtaFnFgMvCD1MhfAE3wCa8sybXZfqw6T0
 FZRule3ndhB09KHSeLHjpL6OhXsKVn7A2kOaBouxERRkljlvgC7Dc
X-Received: by 2002:a05:622a:148c:b0:43d:ed80:2dbb with SMTP id
 d75a77b69052e-43dfdba9beemr159755761cf.61.1715701516766; 
 Tue, 14 May 2024 08:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsX/EEy22XzfthZd5CbasKW/gVmdzYVGU68iEkbwL2goII7SgUme3eOkqNk+AVVJ/c+eLZWQ==
X-Received: by 2002:a05:622a:148c:b0:43d:ed80:2dbb with SMTP id
 d75a77b69052e-43dfdba9beemr159755491cf.61.1715701516219; 
 Tue, 14 May 2024 08:45:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e25735ceesm13789971cf.11.2024.05.14.08.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 08:45:15 -0700 (PDT)
Message-ID: <aafefffb-0024-4739-9e3e-6664e5df6a4a@redhat.com>
Date: Tue, 14 May 2024 17:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] vfio/pci: Use g_autofree in
 iommufd_cdev_get_info_iova_range()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/7/24 08:42, Zhenzhong Duan wrote:
> Local pointer info is freed before return from
> iommufd_cdev_get_info_iova_range().
> 
> Use 'g_autofree' to avoid the g_free() calls.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/iommufd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8827ffe636..c644127972 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -258,7 +258,7 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>                                               uint32_t ioas_id, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> -    struct iommu_ioas_iova_ranges *info;
> +    g_autofree struct iommu_ioas_iova_ranges *info = NULL;
>       struct iommu_iova_range *iova_ranges;
>       int ret, sz, fd = container->be->fd;
>   
> @@ -291,12 +291,10 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>       }
>       bcontainer->pgsizes = info->out_iova_alignment;
>   
> -    g_free(info);
>       return 0;
>   
>   error:
>       ret = -errno;
> -    g_free(info);
>       error_setg_errno(errp, errno, "Cannot get IOVA ranges");
>       return ret;
>   }


