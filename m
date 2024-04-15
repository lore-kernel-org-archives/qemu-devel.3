Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0E8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwML1-0002UR-7v; Mon, 15 Apr 2024 09:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMKw-0002Tw-OH
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMKt-0002GF-HK
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713187526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92LeUCKCgyxXiSrBz4OZAo7KwvQycwWQSUjH4CN7/iM=;
 b=NCMSnRhZm6+tmx+EN7EoeAIX7CKXYqddp49U0rBzj2neUwVd8755fPeG0xs+YdsDdHo6OE
 t8yRbKE/AGqVqVXG1/ACSOGzcxcUUFMsc4NstY1Py64X2vPlmgn084+Vob1mNyU5xzTmTs
 vLuJeCoYyb6eYzoTy/BnmbWBFD7giyI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-8E1qm51HNX6Y_CNChuxWjQ-1; Mon, 15 Apr 2024 09:25:24 -0400
X-MC-Unique: 8E1qm51HNX6Y_CNChuxWjQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c704de25f1so2332586b6e.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713187524; x=1713792324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92LeUCKCgyxXiSrBz4OZAo7KwvQycwWQSUjH4CN7/iM=;
 b=SpomUu6drlJu/pIihRHI3B/IvNcsGLjqw0ROUkhXXh5kSalb/DXguVa7Pc91GiAAXa
 tYjwzlAUADOMj1fMYNKKY2Fd70VBFxjCy75u/Pyc6LGm2mSU3Bwj5upMzjw1ZJApp6vx
 dCsWyDYv4zWMJtk3Rg2bOiZcOPPioset4EGTbxF+hNo8M1gwG8izFoMKLQqBXB9JX7l0
 4E0+lhUQHyF9O4FBYuHq2MYgcSuRP65cboIa6WQRDYu8uRY1K1sJRXYh5BPWbUsqb6Sw
 /5vXIAYBjYlNzrAXIbZ3SlM95IND01RbhZZ5lvOgugoMWNqRvtGeNkLJlpNTUb/E0eL4
 v6WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkBN5WMFjDFw3Pruj7qCfLo3cJtiU+vi4tE29xwMlJ1iS0CpsIf7VxRlDikWCDNTxTaRdr9pCBkg8qqQMrNTXZug5GNBI=
X-Gm-Message-State: AOJu0YytNOHanA+MnCmu7cS9pYl/OL67hoyjbHkqmOxmktyn0q2QH0DK
 /QPbLkbBDOtWq7H2XrQWOaRhkhCL01T0Zz1IaVgQhCx/eSqba9qK9GUCS7m8FjV7uAkpuWd14VD
 z0K9sZSuDUHILWz9M16ShdVeXUuwS1I6IsBJiU0wTh2whNWqcCiYz
X-Received: by 2002:a05:6808:ab0:b0:3c7:a9b:74c5 with SMTP id
 r16-20020a0568080ab000b003c70a9b74c5mr4989462oij.9.1713187524194; 
 Mon, 15 Apr 2024 06:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGECGHiuFhG8LVrdL513aEwhx50hvnZP1jUZBiX/nKY9GCnhvK5PuBJhrrUrSa8omhBKPbR2Q==
X-Received: by 2002:a05:6808:ab0:b0:3c7:a9b:74c5 with SMTP id
 r16-20020a0568080ab000b003c70a9b74c5mr4989445oij.9.1713187523944; 
 Mon, 15 Apr 2024 06:25:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 kq1-20020ac86181000000b00434c31fa60csm5955618qtb.92.2024.04.15.06.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:25:23 -0700 (PDT)
Message-ID: <543294a6-5f04-46ac-af56-af8c1b5f436c@redhat.com>
Date: Mon, 15 Apr 2024 15:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] vfio: Create host IOMMU device instance
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-9-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> Create host IOMMU device instance and initialize it based on backend.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 1 +
>   hw/vfio/container.c           | 5 +++++
>   hw/vfio/iommufd.c             | 8 ++++++++
>   3 files changed, 14 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d382b12ec1..4fbba85018 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -126,6 +126,7 @@ typedef struct VFIODevice {
>       OnOffAuto pre_copy_dirty_page_tracking;
>       bool dirty_pages_supported;
>       bool dirty_tracking;
> +    HostIOMMUDevice *hiod;
>       int devid;
>       IOMMUFDBackend *iommufd;
>   } VFIODevice;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index ba0ad4a41b..fc0c027501 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -915,6 +915,7 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
>       VFIOContainerBase *bcontainer;
> +    HIODLegacyVFIO *hiod_vfio;

s/hiod_vfio/hiod/ please. Same below.


Thanks,

C.



>       int ret;
>   
>       if (groupid < 0) {
> @@ -945,6 +946,9 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       vbasedev->bcontainer = bcontainer;
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +    hiod_vfio = HIOD_LEGACY_VFIO(object_new(TYPE_HIOD_LEGACY_VFIO));
> +    hiod_vfio->vdev = vbasedev;
> +    vbasedev->hiod = HOST_IOMMU_DEVICE(hiod_vfio);
>   
>       return ret;
>   }
> @@ -959,6 +963,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);
> +    object_unref(vbasedev->hiod);
>   }
>   
>   static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 115b9f8e7f..b6d058339b 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -308,6 +308,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       VFIOIOMMUFDContainer *container;
>       VFIOAddressSpace *space;
>       struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
> +    HIODIOMMUFDVFIO *hiod_vfio;
>       int ret, devfd;
>       uint32_t ioas_id;
>       Error *err = NULL;
> @@ -431,6 +432,12 @@ found_container:
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>   
> +    hiod_vfio = HIOD_IOMMUFD_VFIO(object_new(TYPE_HIOD_IOMMUFD_VFIO));
> +    hiod_iommufd_init(HIOD_IOMMUFD(hiod_vfio), vbasedev->iommufd,
> +                      vbasedev->devid);
> +    hiod_vfio->vdev = vbasedev;
> +    vbasedev->hiod = HOST_IOMMU_DEVICE(hiod_vfio);
> +
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
>       return 0;
> @@ -468,6 +475,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>       iommufd_cdev_detach_container(vbasedev, container);
>       iommufd_cdev_container_destroy(container);
>       vfio_put_address_space(space);
> +    object_unref(vbasedev->hiod);
>   
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>       close(vbasedev->fd);


