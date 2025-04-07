Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C245EC3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 11:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1kVg-0008WN-2e; Mon, 07 Apr 2025 07:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1kVW-0008VB-SK
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1kVS-0000W8-O1
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744024748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YoMFiYtXYSJcfxmEuDATcS2rKgNE7tGmDtkqW67gQBo=;
 b=FLwhi1TSdrvYfmD9Q0i/zEegPRu+Nix7KpcMtxlbugx/XFNZY3cFN9x5PgzavyWO8xmsMO
 b/1kZmppoDHHG95xwFNqfmyCfvrE4+YG3NedB7MqbsT7zUopsOgEeJoVDDA3zCLyCBAk7T
 9SlSrt4gpYJ70B2gz5WMChFh7Mgxbuw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-tTH7WgBUMXeumBj8lQAgbQ-1; Mon, 07 Apr 2025 07:19:07 -0400
X-MC-Unique: tTH7WgBUMXeumBj8lQAgbQ-1
X-Mimecast-MFC-AGG-ID: tTH7WgBUMXeumBj8lQAgbQ_1744024746
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d01024089so36250925e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 04:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744024746; x=1744629546;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoMFiYtXYSJcfxmEuDATcS2rKgNE7tGmDtkqW67gQBo=;
 b=rOq86GQaLUeewFRhOt1FIsfh1qCFc83F+KChHSlxqQcRBoGT0L3SYW+SBdokX243yA
 HcaFjk5M9Oker1wnPBKMtE9k9WbYFDy6K35s1PWcdTTte0o2E1Qx67xo7qRQQdWQIb4A
 nVH31b8dgWyfXqkEx5cMOlyHejmNUJkHn6CpsiA+o+CkPE5Wo4+fb7XMjNeEM5O3JzRl
 ulBbIfdOeqcAWyjX3P+Wf8POghTcSqoeEOxegNLJGPMc8LFX3tm0KdNa0SUvHf9Fb1ek
 mRfiPNiBfbiwP+ds2PoDxeu4mBjOXQ+E89vQzEFSPzV3ngIpb8tnyqqHo0mUQqgj7L8a
 AdVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtgAvK+mnPFzqgFP2ZYnvD3Mcfv6kyEMHIlsuIscVLUkZ4vHWHZu4dMw+po/SYRK73nkZOXkoUrH7j@nongnu.org
X-Gm-Message-State: AOJu0YzvmKxSojFBJzAfNxLntAf5NKMDikE1cdHe8OMnJP15cMrwMXc5
 R6tAt5c+p+51vUVQp8+qm1+AVdlRpuq2X+LGVHdQiMWGZigOxNBdQg8wAzw8VMJGpXta28HQvSP
 kJ8KFz1M7cnu6YAHO8p4O0KUsNgOBeosZ4poxmH5UJ84OCvvTbPK8
X-Gm-Gg: ASbGncsCbuJN3dEirxEp0XTrcBQveC44f2QT7vvZNBcUxylN4L3Pb2P1HNp+JYjYC4o
 rjs/FPgzEjiTfLIMMJjCLMUByNByIm95X9PQ5HeeX/e8PMEu4AQOXKtqrf1+Wcd425tkF9j0RoB
 YpQvJ+Z/OHOj0ecGPJsYw+12wXg4krRU48+9IXOBzzCctwZldLX70CjJV3nyCH2mGMaFdZtXqy6
 EM1HvVRxaUPXj+o/6eDWKZhYF/PuQ6yW4PG4GJmKgH/kJ4aO9ZibZApPwp5Kp4zXKE06e6XPN/h
 RGSK7QD78DfJPLn3IaWw3iiPNVCykdov9uZBx/VRpA/SyWAoNiB2Zw==
X-Received: by 2002:a05:600c:8119:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-43ecfa19076mr93433655e9.27.1744024746192; 
 Mon, 07 Apr 2025 04:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx48sPfGk/vS4mDL3vfVrH3v1vOkqpMGwgckZBoNKIpYhfnEpEvfmMEsZdS/mnJurcj10KpQ==
X-Received: by 2002:a05:600c:8119:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-43ecfa19076mr93433385e9.27.1744024745814; 
 Mon, 07 Apr 2025 04:19:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16f1a73sm130154135e9.24.2025.04.07.04.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 04:19:05 -0700 (PDT)
Message-ID: <084cbb65-f3c3-4f18-ae3a-88f20480d2ff@redhat.com>
Date: Mon, 7 Apr 2025 13:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219082228.3303163-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/25 09:22, Zhenzhong Duan wrote:
> Currently we have realize() callback which is called before attachment.
> But there are still some elements e.g., hwpt_id is not ready before
> attachment. So we need a realize_late() callback to further initialize
> them.

The relation between objects HostIOMMUDevice and VFIOIOMMU is starting
to look too complex for me.

I think it makes sense to realize HostIOMMUDevice after the device
is attached. Can't we move :

         hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
         vbasedev->hiod = hiod;

under ->attach_device() and also the call :

     if (!vfio_device_hiod_realize(vbasedev, errp)) {

later in the ->attach_device() patch ?

hiod_legacy_vfio_realize() doesn't do much. We might need to rework
hiod_iommufd_vfio_realize() which queries the iommufd hw caps, later
used by intel-iommu.

Anyway, it is good time to cleanup our interfaces before adding more.

Thanks,

C.



     
> Currently, this callback is only useful for iommufd backend. For legacy
> backend nothing needs to be initialized after attachment.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/host_iommu_device.h | 17 +++++++++++++++++
>   hw/vfio/common.c                   | 17 ++++++++++++++---
>   2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 809cced4ba..df782598f2 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -66,6 +66,23 @@ struct HostIOMMUDeviceClass {
>        * Returns: true on success, false on failure.
>        */
>       bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
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
>       /**
>        * @get_cap: check if a host IOMMU device capability is supported.
>        *
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index abbdc56b6d..e198b1e5a2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1550,6 +1550,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>       const VFIOIOMMUClass *ops =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>       HostIOMMUDevice *hiod = NULL;
> +    HostIOMMUDeviceClass *hiod_ops = NULL;
>   
>       if (vbasedev->iommufd) {
>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1560,16 +1561,26 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>   
>       if (!vbasedev->mdev) {
>           hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +        hiod_ops = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>           vbasedev->hiod = hiod;
>       }
>   
>       if (!ops->attach_device(name, vbasedev, as, errp)) {
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
>       }
>   
>       return true;
> +
> +err_attach:
> +    object_unref(hiod);
> +    vbasedev->hiod = NULL;
> +    return false;
>   }
>   
>   void vfio_detach_device(VFIODevice *vbasedev)


