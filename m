Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1043AC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrIb-0005pW-Nv; Mon, 05 May 2025 04:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrIV-0005os-Gc
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrIT-0001ND-Lz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746434131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zX6C0F4CH99oFQbRvdXTnbdWJLbSIb0kt1DAHT3KjBE=;
 b=QcKsQ8C6CNepNjDc8NAMPfzJNlw4XY/ATvIc92H798j3xzxRES1gxE4qvzLb6S7MD27ag5
 7kdwCZEa+zGEcOn9y1BwoBIg8Vj126w+9Fe+zfYbbcSD/fWicqDpup89XSbdr+HmBJh3QS
 b93dBsBd1DhMglXNbnAdjHXp+ueTVEs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-kPPnLr_uOISRBvirJUZ1dQ-1; Mon, 05 May 2025 04:35:30 -0400
X-MC-Unique: kPPnLr_uOISRBvirJUZ1dQ-1
X-Mimecast-MFC-AGG-ID: kPPnLr_uOISRBvirJUZ1dQ_1746434129
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so1031627f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746434129; x=1747038929;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX6C0F4CH99oFQbRvdXTnbdWJLbSIb0kt1DAHT3KjBE=;
 b=sNI0HW/ogwg8lP63++KE7l6udt+wYASayMDDR7TrpH6Sq9fd9r5kFMoeFy1UxpoerM
 BYvgmCnfoIHC5hF15Hni2WYVx5Pk77K4JKfyAD7zk+bfSE2iCjX1qzVXT79RWNqWjUjA
 WDf3GPOSCM2OnekVkoF1QInNBKSKfjGw7fIM5b2ScHxPciNP+ESY6suK8SOSWtKDKOAA
 QUTxFwqdZnqq1DZ2TWC/8uD7EfJ/eP++PWSDfStCfWmxy64Cuvd4QUCGtKXuKbtHVR6s
 gk6nvF4t+gRAfAREwGy2GI6IKs2Ssqxe3tIqha+e8oFd3+29hW8lebrcRBcz5CoHnIp7
 prNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi5h5g8pGFyeYw1oOqUj+cSqGoordT5FCvNJ+rSjyxSiW0f+jR9Qel3a1YAuzo/VTBCxzySsAVSg8U@nongnu.org
X-Gm-Message-State: AOJu0Yxe06J5SpbnNHQ9TGHSROsZiiNwlzjqlECn5ShLqmwQk01NA/5I
 3PDpt0HptCoJ0Ye1BsQ5pQxjvNI78SaPLFfAn/Qhaat22R/uOhVo81K6+xriK4MfSgHHvDGCtlF
 KJI4K31cgNxbHzwk7+eqWGuWUDl3qEyCT6BJHQfJwgayhqhALZlM2
X-Gm-Gg: ASbGncs4bXiait51Bym7IswtBjxuC+ePGUcDLI7+iS0uGOgGf9XbTsBfpO8oM660Lkg
 5bBruDFSWXMJqRC05VRc4cB7AP8Mabw+lqblQISfLLo0jP7y9MHLCDz9d/CII2eIU7fUuo5A0UN
 oEum3SocGUKzRaCC27weuaPpMQqtiAB7CJe5m6jegaQQ8r2HqzllS7Fuhx4mDtCt9G96TbvlEL+
 mwKnGO2IXKmeSzCLZt3L0zKN7xdcU9i9hAEmNpeTlqnPEPTvuZmbGJkWBM7KCOvXPbBgyDUc2pP
 yEepnoyZ5LT2btH6byXbHfZHKyd+nSTc5rcld1zA6/5xIO8BYw==
X-Received: by 2002:a05:6000:1785:b0:39c:1f11:ead with SMTP id
 ffacd0b85a97d-3a09fd87a2cmr4185334f8f.26.1746434128827; 
 Mon, 05 May 2025 01:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCyyp19+hkqZJgawe9errPsiPlIBJa+lnA777YOOwTHwmWAiEFLNJz1kLZGYK645tW21BEFA==
X-Received: by 2002:a05:6000:1785:b0:39c:1f11:ead with SMTP id
 ffacd0b85a97d-3a09fd87a2cmr4185313f8f.26.1746434128444; 
 Mon, 05 May 2025 01:35:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0feb3sm9707451f8f.67.2025.05.05.01.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 01:35:27 -0700 (PDT)
Message-ID: <c0996139-034d-41f5-b4a9-fc8c3f9a2508@redhat.com>
Date: Mon, 5 May 2025 10:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] vfio: add vfio_prepare_device()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-2-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John,

On 4/30/25 21:39, John Levon wrote:
> Commonize some initialization code shared by the legacy and iommufd vfio
> implementations.
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/container.c           | 14 ++------------
>   hw/vfio/device.c              | 14 ++++++++++++++
>   hw/vfio/iommufd.c             |  9 +--------
>   include/hw/vfio/vfio-device.h |  3 +++
>   4 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77ff56b43f..aa9d5b731b 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -811,18 +811,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>           }
>       }
>   
> +    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
> +
>       vbasedev->fd = fd;
>       vbasedev->group = group;
>       QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>   
> -    vbasedev->num_irqs = info->num_irqs;
> -    vbasedev->num_regions = info->num_regions;
> -    vbasedev->flags = info->flags;
> -
>       trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
>   
> -    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
> -
>       return true;
>   }
>   
> @@ -875,7 +871,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       int groupid = vfio_device_get_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
> -    VFIOContainerBase *bcontainer;
>   
>       if (groupid < 0) {
>           return false;
> @@ -904,11 +899,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>           goto device_put_exit;
>       }
>   
> -    bcontainer = &group->container->bcontainer;
> -    vbasedev->bcontainer = bcontainer;
> -    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> -    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> -
>       return true;
>   
>   device_put_exit:
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d625a7c4db..f3b9902d21 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -398,3 +398,17 @@ void vfio_device_detach(VFIODevice *vbasedev)
>       }
>       VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
>   }
> +
> +void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> +                         struct vfio_device_info *info)
> +{
> +    vbasedev->num_irqs = info->num_irqs;
> +    vbasedev->num_regions = info->num_regions;
> +    vbasedev->flags = info->flags;
> +    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
> +
> +    vbasedev->bcontainer = bcontainer;
> +    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> +
> +    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 232c06dd15..83033c352a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -588,14 +588,7 @@ found_container:
>           iommufd_cdev_ram_block_discard_disable(false);
>       }
>   
> -    vbasedev->group = 0;
> -    vbasedev->num_irqs = dev_info.num_irqs;
> -    vbasedev->num_regions = dev_info.num_regions;
> -    vbasedev->flags = dev_info.flags;
> -    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
> -    vbasedev->bcontainer = bcontainer;
> -    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> -    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +    vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 81c95bb51e..9cb5671ab5 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -130,6 +130,9 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>   void vfio_device_detach(VFIODevice *vbasedev);
>   VFIODevice *vfio_get_vfio_device(Object *obj);
>   
> +void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> +                         struct vfio_device_info *info);
> +
>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   

Please add to your .git/config file :

[diff]
	orderFile = /path/to/qemu/scripts/git.orderfile

Thanks,

C.




