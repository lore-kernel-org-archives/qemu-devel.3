Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CDFC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ucO-000467-Vf; Tue, 14 May 2024 12:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6ucF-00042u-P9
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uc5-0007Fk-QA
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715702565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oVkPOsDD9WBol0EAOg1WOjwigz/6nzY+2y8iScW/Tc=;
 b=S6hNEQ7QqJQF2W/wF0ebR+VEurr2gc8nOvOrmh2VEG4K/esx5FFx4l52pOZhRczwghUdDj
 0EvvwDp3vONaCeveqb1KUrrwAXGa+Iq6P/md8i5v5OaLlD0OJ29FFmviY/gVt1ZCTWAQi/
 lsQwmd595EOf4x6G7wy0+vnnZlri+Zw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Ph2-U44KNqaLjY6KSJo4jg-1; Tue, 14 May 2024 12:02:33 -0400
X-MC-Unique: Ph2-U44KNqaLjY6KSJo4jg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792c3d2b6beso746673085a.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702553; x=1716307353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oVkPOsDD9WBol0EAOg1WOjwigz/6nzY+2y8iScW/Tc=;
 b=P/TwE+4CZptOsmz6skCoq3VpA1a416gPvJg80nn1puHVSiGh/NomREAqXDTc4bt6nc
 a+niYxQiXuw5TllaVqG1spgXBJpHUKfIM1IswppJ2KtcoKNXbtQBjgfy+1G6lv7RqbQv
 Re5hCM0q9QDHxWQsoB3ZHYquqX6bUaoIIRLuePH7tqKWVB0zDX5mG3Ad5TJe0vJI5e2g
 IxMT64eym+eMV/njdVVYSviFH1yoMJ1v4/ouZRgOHGNUT/MlfVScEcKSMPg4FeZa908Z
 ZH6e4IP3EnGfU/JejIOm7kxBA4/HcT/YO8wUcYNzWYQop2XTBDT8GmqfUyH4LqUSW4TP
 hSuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8MRZz1LnYVUUmQy9HhbRO1xQQq7DwDTzAxAUKZoOHAHfx1K47o2tDsg0qYVJqciO+4cHSnZ2LqjaNs5Uod2XzyH57SZk=
X-Gm-Message-State: AOJu0YwIX7TRCoFRN6F1b1Ua8oloPZtTVjU4KZP7lB41UVMTV9DjAYzl
 mWlMo3RA3XEBgyylA3d99r+gFKoQP3ePv6W5lngEL6b6X5QBVOBtfs83uzcOyTn3ZgCz1XH3BKc
 /CKJyXlDpX5H/GuM4XGvXsFhiCJSkqmZ00NIJFyNLtpjI4nedM3RE
X-Received: by 2002:a05:620a:5dd9:b0:792:bc86:2d21 with SMTP id
 af79cd13be357-792c75f0fbemr1503033285a.57.1715702553029; 
 Tue, 14 May 2024 09:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPyBGO2651MH+weno1tbZdE4zXQd+XyaK3IvgrAaVVmrUz8b8uDPekG/8MRcwrZD8iIFb3uA==
X-Received: by 2002:a05:620a:5dd9:b0:792:bc86:2d21 with SMTP id
 af79cd13be357-792c75f0fbemr1503029585a.57.1715702552514; 
 Tue, 14 May 2024 09:02:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27f992sm578181385a.36.2024.05.14.09.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 09:02:31 -0700 (PDT)
Message-ID: <265ebaf3-bc59-4907-b336-9ca1aa6aabca@redhat.com>
Date: Tue, 14 May 2024 18:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] vfio/iommufd: Make iommufd_cdev_*() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-10-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> The changed functions include:
> 
> iommufd_cdev_kvm_device_add
> iommufd_cdev_connect_and_bind
> iommufd_cdev_attach_ioas_hwpt
> iommufd_cdev_detach_ioas_hwpt
> iommufd_cdev_attach_container
> iommufd_cdev_get_info_iova_range
> 
> After the change, all functions in hw/vfio/iommufd.c follows the
> standand.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/iommufd.c | 88 +++++++++++++++++++++--------------------------
>   1 file changed, 39 insertions(+), 49 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 4c6992fca1..84c86b970e 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -49,9 +49,9 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                                        container->ioas_id, iova, size);
>   }
>   
> -static int iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
> +static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
>   {
> -    return vfio_kvm_device_add_fd(vbasedev->fd, errp);
> +    return !vfio_kvm_device_add_fd(vbasedev->fd, errp);
>   }
>   
>   static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
> @@ -63,18 +63,16 @@ static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
>       }
>   }
>   
> -static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
> +static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>   {
>       IOMMUFDBackend *iommufd = vbasedev->iommufd;
>       struct vfio_device_bind_iommufd bind = {
>           .argsz = sizeof(bind),
>           .flags = 0,
>       };
> -    int ret;
>   
> -    ret = iommufd_backend_connect(iommufd, errp);
> -    if (ret) {
> -        return ret;
> +    if (iommufd_backend_connect(iommufd, errp)) {
> +        return false;
>       }
>   
>       /*
> @@ -82,15 +80,13 @@ static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>        * in KVM. Especially for some emulated devices, it requires
>        * to have kvm information in the device open.
>        */
> -    ret = iommufd_cdev_kvm_device_add(vbasedev, errp);
> -    if (ret) {
> +    if (!iommufd_cdev_kvm_device_add(vbasedev, errp)) {
>           goto err_kvm_device_add;
>       }
>   
>       /* Bind device to iommufd */
>       bind.iommufd = iommufd->fd;
> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> -    if (ret) {
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>           error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
>                            vbasedev->fd, bind.iommufd);
>           goto err_bind;
> @@ -99,12 +95,12 @@ static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>       vbasedev->devid = bind.out_devid;
>       trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
>                                           vbasedev->fd, vbasedev->devid);
> -    return ret;
> +    return true;
>   err_bind:
>       iommufd_cdev_kvm_device_del(vbasedev);
>   err_kvm_device_add:
>       iommufd_backend_disconnect(iommufd);
> -    return ret;
> +    return false;
>   }
>   
>   static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
> @@ -176,10 +172,10 @@ out:
>       return ret;
>   }
>   
> -static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> +static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>                                            Error **errp)
>   {
> -    int ret, iommufd = vbasedev->iommufd->fd;
> +    int iommufd = vbasedev->iommufd->fd;
>       struct vfio_device_attach_iommufd_pt attach_data = {
>           .argsz = sizeof(attach_data),
>           .flags = 0,
> @@ -187,38 +183,38 @@ static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>       };
>   
>       /* Attach device to an IOAS or hwpt within iommufd */
> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> -    if (ret) {
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
>           error_setg_errno(errp, errno,
>                            "[iommufd=%d] error attach %s (%d) to id=%d",
>                            iommufd, vbasedev->name, vbasedev->fd, id);
> -    } else {
> -        trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> -                                            vbasedev->fd, id);
> +        return false;
>       }
> -    return ret;
> +
> +    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> +                                        vbasedev->fd, id);
> +    return true;
>   }
>   
> -static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> +static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret, iommufd = vbasedev->iommufd->fd;
> +    int iommufd = vbasedev->iommufd->fd;
>       struct vfio_device_detach_iommufd_pt detach_data = {
>           .argsz = sizeof(detach_data),
>           .flags = 0,
>       };
>   
> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
> -    if (ret) {
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
>           error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
> -    } else {
> -        trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
> +        return false;
>       }
> -    return ret;
> +
> +    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
> +    return true;
>   }
>   
> -static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
> -                                         VFIOIOMMUFDContainer *container,
> -                                         Error **errp)
> +static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
> +                                          VFIOIOMMUFDContainer *container,
> +                                          Error **errp)
>   {
>       return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>   }
> @@ -228,7 +224,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>   {
>       Error *err = NULL;
>   
> -    if (iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
> +    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>           error_report_err(err);
>       }
>   }
> @@ -254,20 +250,19 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
>       return ram_block_uncoordinated_discard_disable(state);
>   }
>   
> -static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> -                                            uint32_t ioas_id, Error **errp)
> +static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                             uint32_t ioas_id, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
>       g_autofree struct iommu_ioas_iova_ranges *info = NULL;
>       struct iommu_iova_range *iova_ranges;
> -    int ret, sz, fd = container->be->fd;
> +    int sz, fd = container->be->fd;
>   
>       info = g_malloc0(sizeof(*info));
>       info->size = sizeof(*info);
>       info->ioas_id = ioas_id;
>   
> -    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
> -    if (ret && errno != EMSGSIZE) {
> +    if (ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info) && errno != EMSGSIZE) {
>           goto error;
>       }
>   
> @@ -275,8 +270,7 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>       info = g_realloc(info, sizeof(*info) + sz);
>       info->allowed_iovas = (uintptr_t)(info + 1);
>   
> -    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
> -    if (ret) {
> +    if (ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info)) {
>           goto error;
>       }
>   
> @@ -291,12 +285,11 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>       }
>       bcontainer->pgsizes = info->out_iova_alignment;
>   
> -    return 0;
> +    return true;
>   
>   error:
> -    ret = -errno;
>       error_setg_errno(errp, errno, "Cannot get IOVA ranges");
> -    return ret;
> +    return false;
>   }
>   
>   static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
> @@ -322,8 +315,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           devfd = vbasedev->fd;
>       }
>   
> -    ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
> -    if (ret) {
> +    if (!iommufd_cdev_connect_and_bind(vbasedev, errp)) {
>           goto err_connect_bind;
>       }
>   
> @@ -336,7 +328,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>               vbasedev->iommufd != container->be) {
>               continue;
>           }
> -        if (iommufd_cdev_attach_container(vbasedev, container, &err)) {
> +        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
>               const char *msg = error_get_pretty(err);
>   
>               trace_iommufd_cdev_fail_attach_existing_container(msg);
> @@ -369,8 +361,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       vfio_container_init(bcontainer, space, iommufd_vioc);
>       QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>   
> -    ret = iommufd_cdev_attach_container(vbasedev, container, errp);
> -    if (ret) {
> +    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>           goto err_attach_container;
>       }
>   
> @@ -379,8 +370,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_discard_disable;
>       }
>   
> -    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
> -    if (ret) {
> +    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
>           error_append_hint(&err,
>                      "Fallback to default 64bit IOVA range and 4K page size\n");
>           warn_report_err(err);


