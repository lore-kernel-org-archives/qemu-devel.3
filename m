Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56604C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OYt-0008F4-7T; Tue, 21 May 2024 08:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OYp-00085r-Gy
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OYk-0000WS-NI
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716294337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWeIvYlFI0ieEY/OG1YrFhjZyrwHus+Aay6KRQebZgI=;
 b=IutIycJD9g6RXOQYDGuR/PKvbiQlPvr7WTDgBgT1f7iKHyHK6XuCKwYIL2Ut6UDe9daj01
 NDgEibIUqIXQvLfxNHRbfPHl7+Sw6+GZ6aHsahFVUdh6j1pgsu7tU9Ld04aaiWtssovJPp
 6gN0ZFreRK1EJHfNa7lbMSDeuk/sHKc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-5T1vi7IpOAme2-ufiWQREg-1; Tue, 21 May 2024 08:25:36 -0400
X-MC-Unique: 5T1vi7IpOAme2-ufiWQREg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43e0980c2b7so138047581cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294335; x=1716899135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWeIvYlFI0ieEY/OG1YrFhjZyrwHus+Aay6KRQebZgI=;
 b=p5PuQxdW5kvn8Zc/7+15iEqtI/83s0cOmSs376vFdWn8556otuiMDeGYHoG0kre9kn
 6ZOSrcD30monM8bS2PpWm8g1eABfx3Xoaa3kI308R/Gm67iust3gZtehP7CW1+Agso9J
 o26UNVptiVtyl6Te2mdEbT0ZmuaFkYjNJEdsrf39SasWm1ea6J0OBi9TgBo+T+ZKvc6g
 WCB/SDshDUk2hvmGyytOUJA+YxajlNaU9CMUupVdTpDtWe6NMgjfTipESFXUCbC3KOV1
 sKXiLfEsq5b07MEPPrhtDQz0oi6gicNcxj6FN+TeYY3JcrBn5nax0RCqlPplJs07j5/F
 q3Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYZGrj01OS7AdhoGIZSgroDTXuBzT5m20o/1gGUEgGOzH8RaJkOUCj3TRzxkrHgr1MmY5i0eKoEg18YVVL62AVJ50jqxE=
X-Gm-Message-State: AOJu0Yy3sL/tcwue7Nsp4yqHwpzHlbccZRt2EC3WvRf6ClIbWI98krt6
 aAIyTL5mHjI8s/4x8xLVXBKMD5MLbVZUYwzUGNsLFevc/sdPNS5PaQ5DiG3TMWHvKcsRRPh9I2/
 y5dwpmXoMKSP1HTwBgpdhi7iT4azUfJ2tFRqUCihPtNeNTo8I99J4
X-Received: by 2002:a05:622a:260e:b0:43a:f577:ea0e with SMTP id
 d75a77b69052e-43dfdcd6da3mr430702361cf.47.1716294334786; 
 Tue, 21 May 2024 05:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUF+8mWqgPzYqsnc8YmSLSurr0on4AmyhMu9XsM1WNQzCgHsKD+n5dbFw52ztXbLMGR6brsA==
X-Received: by 2002:a05:622a:260e:b0:43a:f577:ea0e with SMTP id
 d75a77b69052e-43dfdcd6da3mr430702061cf.47.1716294334309; 
 Tue, 21 May 2024 05:25:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54d59f4sm156979341cf.21.2024.05.21.05.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:25:33 -0700 (PDT)
Message-ID: <35150854-6774-4151-8aea-547e30503075@redhat.com>
Date: Tue, 21 May 2024 14:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] vfio/helpers: Make vfio_device_get_name() return
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-6-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> This is to follow the coding standand in qapi/error.h to return bool
> for bool-valued functions.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/ap.c                  | 2 +-
>   hw/vfio/ccw.c                 | 2 +-
>   hw/vfio/helpers.c             | 8 ++++----
>   hw/vfio/pci.c                 | 2 +-
>   hw/vfio/platform.c            | 5 ++---
>   6 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fdce13f0f2..d9891c796f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -280,7 +280,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>   
>   /* Returns 0 on success, or a negative errno. */
> -int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> +bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard);
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index d8a9615fee..c12531a788 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -158,7 +158,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> -    if (vfio_device_get_name(vbasedev, errp) < 0) {
> +    if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1f578a3c75..8850ca17c8 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -588,7 +588,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    if (vfio_device_get_name(vbasedev, errp) < 0) {
> +    if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
>   
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 93e6fef6de..a69b4411e5 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -605,7 +605,7 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>       return ret;
>   }
>   
> -int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
> +bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>   {
>       ERRP_GUARD();
>       struct stat st;
> @@ -614,7 +614,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>           if (stat(vbasedev->sysfsdev, &st) < 0) {
>               error_setg_errno(errp, errno, "no such host device");
>               error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
> -            return -errno;
> +            return false;
>           }
>           /* User may specify a name, e.g: VFIO platform device */
>           if (!vbasedev->name) {
> @@ -623,7 +623,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>       } else {
>           if (!vbasedev->iommufd) {
>               error_setg(errp, "Use FD passing only with iommufd backend");
> -            return -EINVAL;
> +            return false;
>           }
>           /*
>            * Give a name with fd so any function printing out vbasedev->name
> @@ -634,7 +634,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>           }
>       }
>   
> -    return 0;
> +    return true;
>   }
>   
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 358da4497b..aad012c348 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2999,7 +2999,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                               vdev->host.slot, vdev->host.function);
>       }
>   
> -    if (vfio_device_get_name(vbasedev, errp) < 0) {
> +    if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 3233ca8691..e1a32863d9 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -545,9 +545,8 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>                                                vbasedev->name);
>       }
>   
> -    ret = vfio_device_get_name(vbasedev, errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_device_get_name(vbasedev, errp)) {
> +        return -EINVAL;
>       }
>   
>       if (!vfio_attach_device(vbasedev->name, vbasedev,


