Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B28C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 17:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlAfE-0000KV-Hz; Thu, 20 Feb 2025 12:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlAf0-0000JE-S5
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlAey-0007LE-KK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740073705;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XFk24EWQv9bcb48KR7T1uVR4FxFhoNVizOw23vrpNo=;
 b=TiSHhzlg/+xyayWdxHcDL2bk4IGk8Qf7D5+qfx4A0Lw1pu1BsZnE/Gv245A8TToEJHWLL1
 2CnVJHJcG9PXNrG5nSgNJrOQwQ3N0FaewJCpoadwjXtp3JAH0jdnl9uLcL98WjLLGt4ex8
 XOATgiCQv/Erj9yXhX7a0eE4thKKarI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-_U0E_FVoPUiMTdxKEhERaw-1; Thu, 20 Feb 2025 12:48:20 -0500
X-MC-Unique: _U0E_FVoPUiMTdxKEhERaw-1
X-Mimecast-MFC-AGG-ID: _U0E_FVoPUiMTdxKEhERaw_1740073698
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-439a5c4dfb2so5610185e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 09:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740073698; x=1740678498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XFk24EWQv9bcb48KR7T1uVR4FxFhoNVizOw23vrpNo=;
 b=GbbGoPrgAKmSWc5tHZxuvS8urUzZZCzJUdEgYfr0yrCIVeC7kN1r9HveWWt0wgtfrC
 mP/OU1A0CC8RNXnj5AUuCimu+gu70F/JuUvBjnq2bqjGr2Fc8fALsaUIIQe9kQIeMwtO
 WeS945jIvP0gqYWNJzOMZq1dDTjVR6xpJ/dRQwyIPsECnuD+63q5XONZm+jx9keFvfGy
 srAaa5OiQLmG4oSnYJTHZiiQXVtOPYCR1VvvOHhPNGf9z5tD100yQTc1aeUCYRf/QJ09
 b5RqDlRouUwAGlSPikot9iOdblIBdEDwxpx22GLvVj8lhl+GBSCJcmy36aeE8XeLi49m
 N8nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXztMiigWnRXQ/pArrsuAcaV/gJDdnlofo9WV9RxSeqWnfpzfspbJMMljBYYFHC/6jCFl7i169p/I3N@nongnu.org
X-Gm-Message-State: AOJu0YwMe8wQ4REL7HZ9/F/KWA5X/X1Z9Y1bLWuOVqspuANWyX8CCp/k
 5mcV9ijJllbiNVHEHuJiNGmyu6IdKQCHwhYy63eNSiZ/zm3B1QPlV4VUaHA96l+0UTp6pbViuo1
 NmowFIZvuPwLU50Whkc7jm1C4MevDoSjA+7qbWHQAaNL1+w/KpYSN
X-Gm-Gg: ASbGncvzYE2SM57WE/9q/+hCSU12+JfuLdQ9zog6JIG4FLQg3QyFmPDmC1vE3hR5Y46
 F0I0iqCzKeEuLHhEfMzh/0z82YexTGhN9IKtwvjvPPbbotBA5HAzySz0spxpamaJO0de4iSzR9D
 hllSrHEvzyp2sPnKXB2cZFkqiaRxehluxa2N3RqCOY/a9G9g/RjcNDvUUhLEJlL0Leut+nYAiBE
 qBASMelfZMOAmgLGYnQ/C8zES1GDoQsdb/1f1tsVTpz0idqvg+R2R2wQm8j2heF5nVRl7mpnY2Z
 Re1RoryArsZiUDgND09Lnr/nmNIi4xWZksKuyycpG/jW0kdhL0Rs
X-Received: by 2002:a05:600c:1c12:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-439ae1e5c25mr1505815e9.7.1740073697889; 
 Thu, 20 Feb 2025 09:48:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Ft/c9HzZV0KWRldlAEqbrETYEc1h5oJogrhwDJLqdQ0l5WA1J/fZiqY3Lvb6SePAblCHMQ==
X-Received: by 2002:a05:600c:1c12:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-439ae1e5c25mr1505425e9.7.1740073697525; 
 Thu, 20 Feb 2025 09:48:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43996aa820dsm82733355e9.5.2025.02.20.09.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 09:48:16 -0800 (PST)
Message-ID: <5322a196-017e-46c1-98d9-bf2f30d148e9@redhat.com>
Date: Thu, 20 Feb 2025 18:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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




On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> Currently we have realize() callback which is called before attachment.
> But there are still some elements e.g., hwpt_id is not ready before
> attachment. So we need a realize_late() callback to further initialize
> them.
from the description it is not obvious why the realize() could not have
been called after the attach. Could you remind the reader what is the
reason?

Thanks

Eric
>
> Currently, this callback is only useful for iommufd backend. For legacy
> backend nothing needs to be initialized after attachment.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/host_iommu_device.h | 17 +++++++++++++++++
>  hw/vfio/common.c                   | 17 ++++++++++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 809cced4ba..df782598f2 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -66,6 +66,23 @@ struct HostIOMMUDeviceClass {
>       * Returns: true on success, false on failure.
>       */
>      bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
> +    /**
> +     * @realize_late: initialize host IOMMU device instance after attachment,
> +     *                some elements e.g., ioas are ready only after attachment.
> +     *                This callback initialize them.
> +     *
> +     * Optional callback.
> +     *
> +     * @hiod: pointer to a host IOMMU device instance.
> +     *
> +     * @opaque: pointer to agent device of this host IOMMU device,
> +     *          e.g., VFIO base device or VDPA device.
> +     *
> +     * @errp: pass an Error out when realize fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*realize_late)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
>      /**
>       * @get_cap: check if a host IOMMU device capability is supported.
>       *
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index abbdc56b6d..e198b1e5a2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1550,6 +1550,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>      const VFIOIOMMUClass *ops =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>      HostIOMMUDevice *hiod = NULL;
> +    HostIOMMUDeviceClass *hiod_ops = NULL;
>  
>      if (vbasedev->iommufd) {
>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1560,16 +1561,26 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  
>      if (!vbasedev->mdev) {
>          hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +        hiod_ops = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>          vbasedev->hiod = hiod;
>      }
>  
>      if (!ops->attach_device(name, vbasedev, as, errp)) {
> -        object_unref(hiod);
> -        vbasedev->hiod = NULL;
> -        return false;
> +        goto err_attach;
> +    }
> +
> +    if (hiod_ops && hiod_ops->realize_late &&
> +        !hiod_ops->realize_late(hiod, vbasedev, errp)) {
> +        ops->detach_device(vbasedev);
> +        goto err_attach;
>      }
>  
>      return true;
> +
> +err_attach:
> +    object_unref(hiod);
> +    vbasedev->hiod = NULL;
> +    return false;
>  }
>  
>  void vfio_detach_device(VFIODevice *vbasedev)


