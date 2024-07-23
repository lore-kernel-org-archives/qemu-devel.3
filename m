Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFF0C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWA6k-0003rs-Q5; Tue, 23 Jul 2024 03:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWA6h-0003rG-Rc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWA6d-0008PB-5t
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721720319;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT/at+EcxqmGvkIGdPjpvQ/ZABlBW/DPIDkuEp8qNLE=;
 b=cH5rKg00xVmUg3sB1jOP0DSu3E6sG8IFK9bUK9hk2I4M+eGxMgj0mNVb1++B7wg/rbr01F
 KrvXpIqsv8BB7qfTs3v846a3PT1iGyDf9LoXMN5QlwqLAvW5jYoJ5Fy61vMQv7uw+gcY/7
 Cf6tpk1p7dgJoal//KjFfWS5QYby3cU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Bt-NeEUFPve1hn5aZfQoFA-1; Tue, 23 Jul 2024 03:38:38 -0400
X-MC-Unique: Bt-NeEUFPve1hn5aZfQoFA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e087a57edcaso6459884276.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721720318; x=1722325118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XT/at+EcxqmGvkIGdPjpvQ/ZABlBW/DPIDkuEp8qNLE=;
 b=NfI5tC7lNr4DxYkdL3NZqqRbE++V76bNQWKdDaen/7jTFaxlpLYYHMJvkJO5zmOVG9
 JuZXW9vB4l1uLs1mKEKfJ55r70DovSMBriUyzmT7XUdOHEbr9JdB+yG69Fs9QP4eXUfz
 BY3fE2vFWBcjpKYDxYfYs0AVbPp21eKJ+G9+/PiY8BVdvD6gI11vYANxWCSnWGspiu7H
 lzbMS4E8Co5bH+f5gFAFd0TooqqxvDvFrNzGZpB1OyBvqJ5yW/kVcD3qGM5X7fJ3misu
 SA+fkHzkcPHAYWWJeXghaO03sW2FLCRc6ox6V5c6DiFVi8pREzPjNTEiUHuMJNb1I3mf
 TZOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJJYRrn3/prI20uVe8oZfRUwFzPpWNL8JEAJ+icsBGvMyf+WsxppLcwEwguLQDGT5Wx5AiLsOzNNQrzXc65I58Yr6mdQs=
X-Gm-Message-State: AOJu0Yy8QDpTaJPeq2/6lGyJ+m1fOq7Cu0yqoGSz27qLgAD8iwYvJ8Bz
 jE1ppzhmbyT+0wpokrVyFml+h7fN9TVrA3BEw7ROGqu3eG8K2M9bgz8Mz/h7aWOQZQXF4kAPDaK
 p4JgIzmNypJdBqyuOS7P8MqESLI7aBzJBVbudWmuZd3zbxBbTrQuz
X-Received: by 2002:a05:6902:1545:b0:e08:59af:c9fe with SMTP id
 3f1490d57ef6-e08702b71d8mr11457927276.34.1721720317888; 
 Tue, 23 Jul 2024 00:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHpNBJjq6oTt3m0dhqW1ciC0xCbRfEN6ro/t3GlD2YU5NP3l6NLY9kwVNukVtSjjPjdWe/GA==
X-Received: by 2002:a05:6902:1545:b0:e08:59af:c9fe with SMTP id
 3f1490d57ef6-e08702b71d8mr11457910276.34.1721720317521; 
 Tue, 23 Jul 2024 00:38:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7d9a2dsm44514976d6.30.2024.07.23.00.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:38:36 -0700 (PDT)
Message-ID: <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
Date: Tue, 23 Jul 2024 09:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Joao,

On 7/22/24 23:13, Joao Martins wrote:
> Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
> before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
> behind the device supports dirty tracking.
>
> Note: The HostIOMMUDevice data from legacy backend is static and doesn't
> need any information from the (type1-iommu) backend to be initialized.
> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
> iommufd FD to be connected and having a devid to be able to successfully
Nit: maybe this comment shall be also added in iommufd.c before the call
to vfio_device_hiod_realize() to avoid someone else to move that call
earlier at some point
> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
> different places within the backend .attach_device() implementation.
>
> Suggested-by: Cédric Le Goater <clg@redhat.cm>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/common.c              | 16 ++++++----------
>  hw/vfio/container.c           |  4 ++++
>  hw/vfio/helpers.c             | 11 +++++++++++
>  hw/vfio/iommufd.c             |  4 ++++
>  5 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1a96678f8c38..4e44b26d3c45 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>  void vfio_reset_handler(void *opaque);
>  struct vfio_device_info *vfio_get_device_info(int fd);
>  bool vfio_device_is_mdev(VFIODevice *vbasedev);
> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>  bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                          AddressSpace *as, Error **errp);
>  void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 784e266e6aab..da12cbd56408 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  {
>      const VFIOIOMMUClass *ops =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
> -    HostIOMMUDevice *hiod;
> +    HostIOMMUDevice *hiod = NULL;
>  
>      if (vbasedev->iommufd) {
>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  
>      assert(ops);
>  
> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
> -        return false;
> -    }
>  
> -    if (vbasedev->mdev) {
> -        return true;
> +    if (!vbasedev->mdev) {
> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +        vbasedev->hiod = hiod;
>      }
>  
> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>          object_unref(hiod);
> -        ops->detach_device(vbasedev);
> +        vbasedev->hiod = NULL;
>          return false;
>      }
> -    vbasedev->hiod = hiod;
>  
>      return true;
>  }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 10cb4b4320ac..9ccdb639ac84 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>  
>      trace_vfio_attach_device(vbasedev->name, groupid);
>  
> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> +        return false;
don't you want to go to err_alloc_ioas instead?
> +    }
> +
>      group = vfio_get_group(groupid, as, errp);
>      if (!group) {
>          return false;
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 7e23e9080c9d..ea15c79db0a3 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>      subsys = realpath(tmp, NULL);
>      return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>  }
> +
> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
> +{
> +    HostIOMMUDevice *hiod = vbasedev->hiod;
> +
> +    if (!hiod) {
> +        return true;
> +    }
> +
> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 5e2fc1ce089d..2324bf892c56 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>  
>      space = vfio_get_address_space(as);
>  
> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> +        return false;
> +    }
> +
>      /* try to attach to an existing container in this space */
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
Eric


