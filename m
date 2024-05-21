Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3663EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OrH-0001I1-PN; Tue, 21 May 2024 08:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OrC-0001Gv-38
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9Or5-0004C7-OZ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716295474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JsCz2OoZqOZCvf4HbzHKmtER8lpNGn5k6VVquiqZRg=;
 b=gaTnvaYrP9TANY9CTQGQI6WL5UcT7LTNllqPJLIzw9gQMD/bbfxBrjwJXs/3P4x5KU8qvl
 +7+rIIC8/T7J1nJqjcIfQmNF3niwN/leYeZ3KzQ+pmtc/ULACmA80pEGItATlBCWe9LFja
 9Z5SJNUBaAS6JJQNXgvxeSjvCImBThQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-1WGG0VcdOAuCnYm-c9OFgA-1; Tue, 21 May 2024 08:44:27 -0400
X-MC-Unique: 1WGG0VcdOAuCnYm-c9OFgA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-574f687a77eso29163a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295466; x=1716900266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5JsCz2OoZqOZCvf4HbzHKmtER8lpNGn5k6VVquiqZRg=;
 b=CKgynDw2hoP9AvpGq01NxMgf2qiWWM4GJBTBcMWSiogWQJiYCo9AR3hBufEUiQx8ST
 BwQ5942U3iwlDGDHjfF8GA9aLjg0SWxJlPm46WUoz2QpLNXwWRtdDK/tLX3Qnrl9WysK
 C1gkVbqxfATGhZe8HpcKTNQlvDf42n9F7iCm992OVtUauahifzcYR5NWf5N2PFk78FI6
 Y2ADrXixd3DxvfW0DgNC7hi3xPS1zFTcjzIVMpN0+WcXS3csP8PL+PFxLk8p/rYm/qUE
 CD3QqcWDMHBUoEW3VJhW47p6PX0On/nS5aj3big7Usu9ZjheHpshxwhxn+1L2S7X+8i2
 0y8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ByoS9k1EtXYnCYJoaDBjIhVdAJtuZnBct2pQXi9Bwqp2tu6AaAlwasOAjDaW06hd/9/8fDOW5FSV+lAacdEbg6Tj2Y4=
X-Gm-Message-State: AOJu0YxS0JKx2tdwFGl33PAo/6yfY1WOMWiOt1QrUhZMpnb3KmR31nk7
 USwwLn9oLPjh3Lu0ODpO1PLmivB27vcUgFvPhXxkKJTkkLQCjBj1ruA6OMp2OaERJKTS0TcTLE5
 ON59m8lLfAbXVuIbs2fdFt3XVai48xKxmmA/ulEeVq3dV0QGp98Tj
X-Received: by 2002:a50:9e6d:0:b0:572:8aab:441c with SMTP id
 4fb4d7f45d1cf-5734d6ed908mr20608511a12.26.1716295465862; 
 Tue, 21 May 2024 05:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEv1QMxxuwkkcoN6V8p/sO7Kmw8vIe4mFszSpPNa/vlVFXYPbSg69qituZIQQBmYRjCY0jMg==
X-Received: by 2002:a50:9e6d:0:b0:572:8aab:441c with SMTP id
 4fb4d7f45d1cf-5734d6ed908mr20608499a12.26.1716295465543; 
 Tue, 21 May 2024 05:44:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bed72bbsm16534352a12.57.2024.05.21.05.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:44:25 -0700 (PDT)
Message-ID: <483fe0bf-702f-4d6d-8d61-cc9c5a94fb71@redhat.com>
Date: Tue, 21 May 2024 14:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] vfio/pci: Make vfio_populate_vga() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-13-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-13-zhenzhong.duan@intel.com>
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
>   hw/vfio/pci.h |  2 +-
>   hw/vfio/igd.c |  2 +-
>   hw/vfio/pci.c | 11 +++++------
>   3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a5ac9efd4b..7914f019d5 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -225,7 +225,7 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
>   int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>                                       struct vfio_pci_hot_reset_info **info_p);
>   
> -int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
> +bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>   
>   int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                  struct vfio_region_info *info,
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index b31ee79c60..ffe57c5954 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -478,7 +478,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>        * try to enable it.  Probably shouldn't be using legacy mode without VGA,
>        * but also no point in us enabling VGA if disabled in hardware.
>        */
> -    if (!(gmch & 0x2) && !vdev->vga && vfio_populate_vga(vdev, &err)) {
> +    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           error_report("IGD device %s failed to enable VGA access, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e2ca4507f8..1922593253 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2670,7 +2670,7 @@ static VFIODeviceOps vfio_pci_ops = {
>       .vfio_load_config = vfio_pci_load_config,
>   };
>   
> -int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info;
> @@ -2681,7 +2681,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>           error_setg_errno(errp, -ret,
>                            "failed getting region info for VGA region index %d",
>                            VFIO_PCI_VGA_REGION_INDEX);
> -        return ret;
> +        return false;
>       }
>   
>       if (!(reg_info->flags & VFIO_REGION_INFO_FLAG_READ) ||
> @@ -2691,7 +2691,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>                      (unsigned long)reg_info->flags,
>                      (unsigned long)reg_info->size);
>           g_free(reg_info);
> -        return -EINVAL;
> +        return false;
>       }
>   
>       vdev->vga = g_new0(VFIOVGA, 1);
> @@ -2735,7 +2735,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>                        &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
>                        &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
>   
> -    return 0;
> +    return true;
>   }
>   
>   static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> @@ -2798,8 +2798,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       g_free(reg_info);
>   
>       if (vdev->features & VFIO_FEATURE_ENABLE_VGA) {
> -        ret = vfio_populate_vga(vdev, errp);
> -        if (ret) {
> +        if (!vfio_populate_vga(vdev, errp)) {
>               error_append_hint(errp, "device does not support "
>                                 "requested feature x-vga\n");
>               return false;


