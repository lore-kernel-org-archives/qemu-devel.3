Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFEFC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7a7F-00007e-N9; Wed, 23 Apr 2025 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7a75-000054-4V
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7a72-0002YH-6z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745414761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=as9hkC6LzA4mqqBBNiSN9FyX1bB+48xTFifFHwppifA=;
 b=XOc40dhZFdlss4Hl8Bo77tP8mN+cnu30RhTGfOFA644uctk2Tx6Kq2hl5q3H69pnDuftOi
 U8p+ru6XcbY8Tz/RYZHa6/XE2xHvOP4B21OSTEu/29G/4N026+A5gkjzfmm3NIfKxR20LO
 vFRCbNTqxChkayKQrPdWfbmwFInPlu4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-mpyIGg8UOwCQGlt70W5U5Q-1; Wed, 23 Apr 2025 09:26:00 -0400
X-MC-Unique: mpyIGg8UOwCQGlt70W5U5Q-1
X-Mimecast-MFC-AGG-ID: mpyIGg8UOwCQGlt70W5U5Q_1745414758
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so3484436f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 06:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745414758; x=1746019558;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=as9hkC6LzA4mqqBBNiSN9FyX1bB+48xTFifFHwppifA=;
 b=GupK/Nh6DQ5GFB6HhKc2aaEL7LHrjWbZBbjuy4aSrHIBheAmba63pvlrtYbi0amqns
 cD/UrBX9+s6nFjTFsaiPhz4+5lAFiyq95vPCsOnJekibkkDfkOpI6qDExdDu5ty7ij8p
 DUsko2XkPbSBupgvOCVpOgczGxiutmL0MVvPWgCckVlpPxf7607loxgpzJsXoUHEVDUv
 SgQIgOsDOvbVesXvvMkw6r85nsI2HSqVYiaVOr7tEllqQsPVv/MSfyU4j1VMDXB75n/V
 bMvkYpeRxNPIbhmjjeDF5Pt3apf3pLTw0USL7iS3+FDGaoVjbC0dL5WJQa5hfAmU5VIE
 nbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfDSYlf8PhvtlqG5pWS6gpSavL//v4ljktA0EW4zZBP2GEl865WaTHQOgIIZQu8ftCyKLEMR++zJFR@nongnu.org
X-Gm-Message-State: AOJu0Yw4hbd8rMqZTRv1mYOMWZEhU9NFBPc5WnZAOlj2z0wp5wzR6AtM
 wSzC0yQjEZgVO6bRdQSKiF4LYqDwdfM3/GlFDZYlvSrDUQFnvvM+nvSx5Nnakt/fLV9/qQdGWX9
 xfh9BM0r9GWhkNrWR7Qidbdn+uoYHcA+RuhxoWjO7VZiLkzS1sR07
X-Gm-Gg: ASbGncv8z/kMLWxVUuDcrTkmf2DSQYY8eaw0PEr0OGsV2ZXI+InniJnBcNB96FNF7P7
 JPYWH6FS3IC2uddpgav+YYkbFq8opjSZdU4fjUEgtOxS0YOSrtiCuKNQRTgAx8Ibwq7gSX4HUtZ
 tN5ChcnYI39dRIJMredVLIXeD6uu61dTvM7bU1P1VlbAR91cSGGRuYJ2/ciSHGoQGQ7ghlOYhoz
 jzjHyEfaBUbivoTSfLx+8HHPd4ZhrBk37LEe8rHcClo60bOWEUFtZRzAk+iR5s3gbHEEagTbqcO
 0zscYIwmxzwYkQtuAeBh+iuS4yIa6JX9fJTLicvGuSb7EGk=
X-Received: by 2002:a5d:64ef:0:b0:39c:266c:12a5 with SMTP id
 ffacd0b85a97d-39efba3cadfmr16060071f8f.13.1745414758500; 
 Wed, 23 Apr 2025 06:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCTWnvrcFyZX1LUAOAKT26eE6OVtWKF5o3upYFqtnby66OhAaskkz8upQ5B5VJoJR/Mg8jng==
X-Received: by 2002:a5d:64ef:0:b0:39c:266c:12a5 with SMTP id
 ffacd0b85a97d-39efba3cadfmr16060044f8f.13.1745414758017; 
 Wed, 23 Apr 2025 06:25:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931c3sm18685860f8f.77.2025.04.23.06.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 06:25:57 -0700 (PDT)
Message-ID: <8b8e1335-e168-4d43-946a-2bcc12ca535c@redhat.com>
Date: Wed, 23 Apr 2025 15:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] vfio: add vfio_attach_device_by_iommu_type()
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
 <20250409134814.478903-5-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Same typo in Subject

On 4/9/25 15:48, John Levon wrote:
> Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
> vfio-user will use this later.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/device.c              | 24 ++++++++++++++++--------
>   include/hw/vfio/vfio-device.h |  3 +++
>   2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4d940ddb3a..f74b9c25ea 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -367,20 +367,17 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
>       }
>   }
>   
> -bool vfio_device_attach(char *name, VFIODevice *vbasedev,
> -                        AddressSpace *as, Error **errp)
> +bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
> +                                      VFIODevice *vbasedev, AddressSpace *as,
> +                                      Error **errp)
>   {
> -    const VFIOIOMMUClass *ops =
> -        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>       HostIOMMUDevice *hiod = NULL;
>   
> -    if (vbasedev->iommufd) {
> -        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> -    }
> +    const VFIOIOMMUClass *ops =
> +        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));


There are minor conflicts with Zhenzhong's series :

   https://lore.kernel.org/qemu-devel/20250423072824.3647952-1-zhenzhong.duan@intel.com/

which can be fixed easily.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

>       assert(ops);
>   
> -
>       if (!vbasedev->mdev) {
>           hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>           vbasedev->hiod = hiod;
> @@ -395,6 +392,17 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>       return true;
>   }
>   
> +bool vfio_device_attach(char *name, VFIODevice *vbasedev,
> +                        AddressSpace *as, Error **errp)
> +{
> +    const char *iommu_type = vbasedev->iommufd ?
> +                             TYPE_VFIO_IOMMU_IOMMUFD :
> +                             TYPE_VFIO_IOMMU_LEGACY;
> +
> +    return vfio_device_attach_by_iommu_type(iommu_type, name, vbasedev,
> +                                            as, errp);
> +}
> +
>   void vfio_device_detach(VFIODevice *vbasedev)
>   {
>       if (!vbasedev->bcontainer) {
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 1a2fe378d0..3563a82ede 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -126,6 +126,9 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev);
>   bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>   bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
> +bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
> +                                      VFIODevice *vbasedev, AddressSpace *as,
> +                                      Error **errp);
>   void vfio_device_detach(VFIODevice *vbasedev);
>   VFIODevice *vfio_get_vfio_device(Object *obj);
>   


