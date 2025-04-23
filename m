Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04E2C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZU9-0000da-LO; Wed, 23 Apr 2025 08:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7ZU5-0000cV-TZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7ZU4-0005Lo-8p
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745412346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qt4t7R903M8pTFxWcTGbNl1/jjURfA1ZAK9is/VcAWc=;
 b=A88HFEp4mN6ptB+fEX1I4LQkDhzl9ojGH6x+bscDbFo6pivSkY9gClwQ8hd1KInygveJvt
 /xjAecymcfBdEWLnLyTvQI2NzCGsHKEkXcnJ/K2AmIts4bqvQeg2i6OuZ4WYxvzmBE34G+
 GE6wntZAHuEpfXJCvrmAXb9So5ULPak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-76DZub28P0-JMglgOVowDw-1; Wed, 23 Apr 2025 08:45:44 -0400
X-MC-Unique: 76DZub28P0-JMglgOVowDw-1
X-Mimecast-MFC-AGG-ID: 76DZub28P0-JMglgOVowDw_1745412344
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so3130342f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745412344; x=1746017144;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qt4t7R903M8pTFxWcTGbNl1/jjURfA1ZAK9is/VcAWc=;
 b=L2fSDoI14DuNE8jN5dwA2LPz8TtHhV7QLf7Rui+XJw9x33W3BtvtZa4NFTm5RFpkZ2
 qdnX1EW/Ii0sQeVHKBwZWJQUUkd6X8VXl/HiWlekpSDDXR+lrusJmBL0vaymLlgwwePs
 7knI8y78fHuMQGozMwNlFePA46qom9S8wt5fOMhrNy1zT9afdGJeawKkSicUWRsa+9rc
 F7A/FxF6EGysbNGZyNOJ6ENqxTcKk8hSj/Z7SaLOcoGCp3/hxCHgVyYLFKt0zkYHjrcc
 YHwKqQCd5VPJfVP53oen4bYOOo+QQuHSgf7sAbWn02J7NL5eH86UQ+aK9c0CQRhHpJaB
 eoSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaua23isTktxc+U4IvbkLBfanymZY2elEOsZrabosm5f/+FSwIEZV9YZIJvdwru5BtAYA3FnBmHC4l@nongnu.org
X-Gm-Message-State: AOJu0Yzt3q2ckXGd4gLxfWXXt/OyfwGVmjbEdY59YtLdg2RK5SlybQvB
 CHHGtje0C2nx4CefAUpsVVBr05D1RVzlMA75cS9rViiJG0cBwEMXZ/HvVUspaT4tD+cB2YnDgP3
 qmJb89U7qUrgMSsL5q+FY6PJXfZa8wsGx+3Sl/6OCXO7o4zdYYbmL
X-Gm-Gg: ASbGncsLZeIGhsNGVIpeClsd4lfU9fluzvGi1zhurlHjEOR3dKFJ5YEU87AYUkwFabr
 fi8MTL723q9uYhs3aNDSAhpq32rnKQ1rugC9XZDeIEAFPnljNLjAK47ECkHu1KzGAVNlTZSiLjH
 hHRvdDBR4nf+EJzFB5eU+LN5vMrwWTIs8D+ypq49iT8GzpORkECINd7l/4zUAkTkkx9DVRKso9j
 vNDk73egAvZOYU04vif2GDiFuIlzZZEonN/IsKwqLYjclAtg14SpdCMS4WwCAQBc3P/0MJdWESX
 WFNEgOqhQ+7WQeLqviwi7CCY1/zI+8IUYjFH1N2K4/+kbRg=
X-Received: by 2002:a5d:47cb:0:b0:391:4282:f60e with SMTP id
 ffacd0b85a97d-39efba5ca88mr14622646f8f.32.1745412343710; 
 Wed, 23 Apr 2025 05:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEZcYbL0EyUbHy9R7ZgLbW+6IJLM30E6X4blxvAp1mviJMC+/KBv5+rHzdcv0Eb3i2nfQSA==
X-Received: by 2002:a5d:47cb:0:b0:391:4282:f60e with SMTP id
 ffacd0b85a97d-39efba5ca88mr14622616f8f.32.1745412343282; 
 Wed, 23 Apr 2025 05:45:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207d0sm18977951f8f.11.2025.04.23.05.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 05:45:42 -0700 (PDT)
Message-ID: <599c9722-0fa1-4f37-aa1e-d801986ec6e9@redhat.com>
Date: Wed, 23 Apr 2025 14:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] vfio: add vfio_prepare_device()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-4-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

Subject needs fix.

On 4/9/25 15:48, John Levon wrote:
> Commonize some initialization code shared by the legacy and iommufd vfio
> implementations.
>

May be vfio_device_set_info() would be a better name ? Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> Signed-off-by: John Levon <john.levon@nutanix.com>> ---
>   hw/vfio/container.c           | 14 ++------------
>   hw/vfio/device.c              | 14 ++++++++++++++
>   hw/vfio/iommufd.c             |  9 +--------
>   include/hw/vfio/vfio-device.h |  3 +++
>   4 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 23a3373470..4fc181d33b 100644
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
>           return false;
>       }
>   
> -    bcontainer = &group->container->bcontainer;
> -    vbasedev->bcontainer = bcontainer;
> -    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> -    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> -
>       return true;
>   }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4de6948cf4..4d940ddb3a 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -403,3 +403,17 @@ void vfio_device_detach(VFIODevice *vbasedev)
>       object_unref(vbasedev->hiod);
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
> index 48db105422..1874185fcf 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -587,14 +587,7 @@ found_container:
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
> index 66797b4c92..1a2fe378d0 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -129,6 +129,9 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>   void vfio_device_detach(VFIODevice *vbasedev);
>   VFIODevice *vfio_get_vfio_device(Object *obj);
>   
> +void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> +                         struct vfio_device_info *info);
> +
>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   


