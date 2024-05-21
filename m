Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E649C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Oad-0001Km-8I; Tue, 21 May 2024 08:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9Oab-0001JQ-Pr
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OaW-0000wo-BJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716294446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uyPc4lfuJfwPecB10TMWP9/BvEr1DTSMW1QjgXvFbM=;
 b=Hd9zR4Zxa36Hskf3fzKGQ5qMe7X6/u1HbxOOLUMcYHxZ5Hxv4ZW7ZBcBCy+ZmK9DA9XrJ7
 u3oOc6uV5Fs8wxVDkXRXHtBq2rzdsuxsAW9YHrUBs7IPl6zD/GlCEDOeEqkVE6JOzBoOMp
 LNWvWSpF89uWiEqNwr4NaHSqm4SmG4U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-iKhP0fJbM2uViA0qoBkEkg-1; Tue, 21 May 2024 08:27:24 -0400
X-MC-Unique: iKhP0fJbM2uViA0qoBkEkg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6aa12fc1fafso26972476d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294444; x=1716899244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3uyPc4lfuJfwPecB10TMWP9/BvEr1DTSMW1QjgXvFbM=;
 b=wSTxufdfL1JU2oUTuFg1kXpCnQSQ6esjmvN0mL9McAnlNhE2Fw3sXeH4QOS/0oYhXT
 RN6X9YvXPru+RUxvRjiGTm60risHoEOQnKGSCN83x33S5faYtJ06ycGOLmxL/oBaZXWE
 6DXoqfjYewBKdfHjgCl1C1ka7M0Y1Mr3UkKwsbRAmEnzd2yg6Y1J2MSJTEor+bZ0tgDI
 EZzguvGrXBxbt4u4WIYckWiiNzgzZa2BiEaOdlrCnIRH2oJdoryHlfyn1gcQvJWW363U
 3GtFBTgA4Et2SPMrCrY3n753XMJ1dKlqrUQjDzcQbyLzPc02uEqlGm/m2XyEiwWtX0qD
 qsSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYLyG5zNkOULI2f3rHBfq1Luvp0qy2E5rQupeblgEdrvKyl+n0gYwYYMWXMPMQ2FQrq/qG//6VFruUOpYaNIn2pGcaCXU=
X-Gm-Message-State: AOJu0YzrrkA3AE2WNer1cV3008UZYgPByZCIjrPo4/1LP4txWbHvpiYC
 7/tuyjx5rCkOatFNQLuRVs2PjY9FbI1Sno76Hhxr1i6l8+7JiRgCoWL5yeD1tcsPYKWKx2WteGk
 SWEh2Ju8fVSqNZLMs2LIijzsDYZ+VEZaq3Mpu0uQ9bqKn/+qfKMbT
X-Received: by 2002:a05:6214:4c0d:b0:6aa:5749:44f8 with SMTP id
 6a1803df08f44-6aa57494a47mr44006606d6.58.1716294444322; 
 Tue, 21 May 2024 05:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVd8cWDWW6+Csc7w2ytRd7m78mU5W5iwEaSmLxapB/OK/XON9cTfcJwzelCEibgyHuJj95Pg==
X-Received: by 2002:a05:6214:4c0d:b0:6aa:5749:44f8 with SMTP id
 6a1803df08f44-6aa57494a47mr44006466d6.58.1716294443899; 
 Tue, 21 May 2024 05:27:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1797c8sm122241086d6.22.2024.05.21.05.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:27:23 -0700 (PDT)
Message-ID: <b27ee071-2bab-488e-a800-34d5f992a937@redhat.com>
Date: Tue, 21 May 2024 14:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] vfio/platform: Make vfio_populate_device() and
 vfio_base_device_init() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-7-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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
>   hw/vfio/platform.c | 40 +++++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index e1a32863d9..a85c199c76 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -441,7 +441,7 @@ static int vfio_platform_hot_reset_multi(VFIODevice *vbasedev)
>    * @errp: error object
>    *
>    */
> -static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
> +static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
>   {
>       VFIOINTp *intp, *tmp;
>       int i, ret = -1;
> @@ -450,7 +450,7 @@ static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
>   
>       if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PLATFORM)) {
>           error_setg(errp, "this isn't a platform device");
> -        return ret;
> +        return false;
>       }
>   
>       vdev->regions = g_new0(VFIORegion *, vbasedev->num_regions);
> @@ -487,12 +487,11 @@ static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
>                                                       irq.flags);
>               intp = vfio_init_intp(vbasedev, irq, errp);
>               if (!intp) {
> -                ret = -1;
>                   goto irq_err;
>               }
>           }
>       }
> -    return 0;
> +    return true;
>   irq_err:
>       timer_del(vdev->mmap_timer);
>       QLIST_FOREACH_SAFE(intp, &vdev->intp_list, next, tmp) {
> @@ -507,7 +506,7 @@ reg_error:
>           g_free(vdev->regions[i]);
>       }
>       g_free(vdev->regions);
> -    return ret;
> +    return false;
>   }
>   
>   /* specialized functions for VFIO Platform devices */
> @@ -527,10 +526,8 @@ static VFIODeviceOps vfio_platform_ops = {
>    * fd retrieval, resource query.
>    * Precondition: the device name must be initialized
>    */
> -static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
> +static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret;
> -
>       /* @fd takes precedence over @sysfsdev which takes precedence over @host */
>       if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
>           g_free(vbasedev->name);
> @@ -538,7 +535,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>       } else if (vbasedev->fd < 0) {
>           if (!vbasedev->name || strchr(vbasedev->name, '/')) {
>               error_setg(errp, "wrong host device name");
> -            return -EINVAL;
> +            return false;
>           }
>   
>           vbasedev->sysfsdev = g_strdup_printf("/sys/bus/platform/devices/%s",
> @@ -546,20 +543,20 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>       }
>   
>       if (!vfio_device_get_name(vbasedev, errp)) {
> -        return -EINVAL;
> +        return false;
>       }
>   
>       if (!vfio_attach_device(vbasedev->name, vbasedev,
>                               &address_space_memory, errp)) {
> -        return -EINVAL;
> +        return false;
>       }
>   
> -    ret = vfio_populate_device(vbasedev, errp);
> -    if (ret) {
> -        vfio_detach_device(vbasedev);
> +    if (vfio_populate_device(vbasedev, errp)) {
> +        return true;
>       }
>   
> -    return ret;
> +    vfio_detach_device(vbasedev);
> +    return false;
>   }
>   
>   /**
> @@ -576,7 +573,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
>       VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
>       SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    int i, ret;
> +    int i;
>   
>       qemu_mutex_init(&vdev->intp_mutex);
>   
> @@ -584,9 +581,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
>                                   vbasedev->sysfsdev : vbasedev->name,
>                                   vdev->compat);
>   
> -    ret = vfio_base_device_init(vbasedev, errp);
> -    if (ret) {
> -        goto out;
> +    if (!vfio_base_device_init(vbasedev, errp)) {
> +        goto init_err;
>       }
>   
>       if (!vdev->compat) {
> @@ -618,11 +614,9 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
>           }
>           sysbus_init_mmio(sbdev, vdev->regions[i]->mem);
>       }
> -out:
> -    if (!ret) {
> -        return;
> -    }
> +    return;
>   
> +init_err:
>       if (vdev->vbasedev.name) {
>           error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       } else {


