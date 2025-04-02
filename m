Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578B4C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u01Kn-0007Ma-SH; Wed, 02 Apr 2025 12:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u01Km-0007M6-L9
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u01Kl-00057b-1v
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743612778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v80tdysQgO6x+Ej1+qrOWf+G7tdAWo1SbvDNa5JuPhc=;
 b=bsNCe4mF1EjkW0RpbDhY0yNMOcQUCEDmgbLSC9yRWcvTnoD+hqUMtBDcjTTS6cZuviyB5n
 60SMPwJ1d8QfhvyrQjN5gQJHTVoPXOSklLNYvZJkN//28LvCxJ0pIymlXkRALaUUG7L4/4
 j47xRjluLZDBgIZRDiZWK3sYW9gfo8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-5Ga5yB4DPdKGS498GKiSNA-1; Wed, 02 Apr 2025 12:52:57 -0400
X-MC-Unique: 5Ga5yB4DPdKGS498GKiSNA-1
X-Mimecast-MFC-AGG-ID: 5Ga5yB4DPdKGS498GKiSNA_1743612776
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso43387965e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743612776; x=1744217576;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v80tdysQgO6x+Ej1+qrOWf+G7tdAWo1SbvDNa5JuPhc=;
 b=LQdnju+UV67MVynZnaxWKM0N3aPpT5sx9F8I1/OHMzmwYkGsflyane/1mvbiGFED21
 AZy+m02eyhJATZzJmZPqBiOKsyilq6BT488Os74pwKgzrZqcgPlbJES/B8ygQL9FGFoW
 0fZnOR1O6ypceEGl66ORcpElhSQ9IhwMHHlS1TARJRtho7Fn0XInl4WiiCEM9w7AWsSA
 NtCxL3NPEazhzGOoUIUY11m/s2aB3wO3yEVBd6Xp4tJvSuoVJVDTXQKc1Onij6tIuZ9n
 YJlis4rsZ3bDu2/lt/k0oqecLZ+Crl+YlXrqVBESEBC2m0xTCjbea+IOIMoLAa5T7XG8
 riEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsC7Aib48PSiVUGocLVahSOHhZNLxZLguuoOf8wRGecT6O1tIOeWtj4tNSGQrZelFkiIIh4kdquW9h@nongnu.org
X-Gm-Message-State: AOJu0YyZCoZ3BYdXMGSRV3MRu9nEfYkToM9cgkwT5gLBtn0ankfkSzES
 un8EJ+3NBaKcOd1Yh4uhpR/dLD0m+3zqFdAEhi4HPi+tOmI+MJBLNq3ygYBxtn4FOnMuQ4ljUP4
 oU0zWEJ3xut6A18MxhQj/4z0LuAJqLuiaLqeh1CwZKEXx7g4lwEwn
X-Gm-Gg: ASbGncultUdoV3E69hh5Li+stljvMH1trfgl/BzUUsDPnV7D4qL3eKf0oJf+RZleliY
 hkJisi59xPhA/sghr+Ol7sw+EO/QYKgsmpsyAw5/OKmv1oB0CtV1HpnATxlOVurJBqJfV+VKou8
 vqIRhm4gFkALUQOcDW9fJ3EN6fyrBVGcGERndNHkBxzvQUqf0suAGOH4hFr6JPJK+y1o5Re8zQy
 pX3eW4M1PRqT70fZgSHj+4SMGzbPXcN3CEz5A6eS7J/JNgPbOpJsIP+rbJn8m02iWCsXYcv9T4v
 urlsFpP6KQx7Gt/4WTXDO9hUC3IZr3IugNoHV1YGYFnPVQP9eZcxhw==
X-Received: by 2002:a5d:588c:0:b0:397:8ef9:a143 with SMTP id
 ffacd0b85a97d-39c120e14c2mr15953719f8f.23.1743612775890; 
 Wed, 02 Apr 2025 09:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEBfkw0+h6yX2jRMwqMoxLgZ30aFewvJYXV4EyahttWNDtiCETVYyxfazXj6jWi+Bl8nGaHQ==
X-Received: by 2002:a5d:588c:0:b0:397:8ef9:a143 with SMTP id
 ffacd0b85a97d-39c120e14c2mr15953701f8f.23.1743612775536; 
 Wed, 02 Apr 2025 09:52:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e33asm17680262f8f.66.2025.04.02.09.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 09:52:55 -0700 (PDT)
Message-ID: <e74d5f1b-f275-4202-bf18-13f085dff263@redhat.com>
Date: Wed, 2 Apr 2025 18:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/28] vfio: add vfio_attach_device_by_iommu_type()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-5-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On 2/19/25 15:48, John Levon wrote:
> Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
> vfio-user will use this later.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/common.c              | 30 +++++++++++++++++++-----------
>   include/hw/vfio/vfio-common.h |  3 +++
>   2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b49aafc40c..eefd735bc6 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1569,25 +1569,20 @@ retry:
>       return info;
>   }
>   
> -bool vfio_attach_device(char *name, VFIODevice *vbasedev,
> -                        AddressSpace *as, Error **errp)
> +bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
> +                                      VFIODevice *vbasedev, AddressSpace *as,
> +                                      Error **errp)
>   {
> -    const VFIOIOMMUClass *ops =
> -        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>       HostIOMMUDevice *hiod = NULL;
> -
> -    if (vbasedev->iommufd) {
> -        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> -    }
> -
> -    assert(ops);
> -
> +    const VFIOIOMMUClass *ops =
> +        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
>   
>       if (!vbasedev->mdev) {
>           hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>           vbasedev->hiod = hiod;
>       }
>   
> +

please drop the extra line.

>       if (!ops->attach_device(name, vbasedev, as, errp)) {
>           object_unref(hiod);
>           vbasedev->hiod = NULL;
> @@ -1597,6 +1592,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>       return true;
>   }
>   
> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp)
> +{
> +    const char *iommu_type = TYPE_VFIO_IOMMU_LEGACY;
> +
> +    if (vbasedev->iommufd) {
> +        iommu_type = TYPE_VFIO_IOMMU_IOMMUFD;
> +    }

May be use a ternary operator.

> +    return vfio_attach_device_by_iommu_type(iommu_type, name, vbasedev,
> +                                            as, errp);
> +}
> +
>   void vfio_detach_device(VFIODevice *vbasedev)
>   {
>       if (!vbasedev->bcontainer) {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f4f08eb8a6..c40f8de6bc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -252,6 +252,9 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev);
>   bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
> +bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
> +                                      VFIODevice *vbasedev, AddressSpace *as,
> +                                      Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
>   VFIODevice *vfio_get_vfio_device(Object *obj);
>   


Looks OK. It will need a refresh because of the spring cleanup.


Thanks,

C.




