Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D4C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OOP-0004iT-9a; Tue, 21 May 2024 08:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OON-0004hn-Li
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OOL-00077L-Oe
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716293692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMUHiNDlR6bU+8H17tY8OCCXcva0xxBQldjl2rsa0+c=;
 b=dKLJlT77FNcIK7/RNwmh4PSHQ2A4bd5woyoqLrbTBsBxq/cHX6Okb46RCspMOakyoKsTRJ
 bOYYm/6P+GtKMZNdpncdDwjRnwnFhnDetfqLratjQ2TeWsGNk6vy3gnWCqdgl4dpVY8Ayn
 EPTmd5tnJMgvfXS049fAOn9ZdcJAnmo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-DxPbSTLiOP-ixA-GDlv_gw-1; Tue, 21 May 2024 08:14:51 -0400
X-MC-Unique: DxPbSTLiOP-ixA-GDlv_gw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c9ac6d3bf6so6856412b6e.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716293690; x=1716898490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMUHiNDlR6bU+8H17tY8OCCXcva0xxBQldjl2rsa0+c=;
 b=Jqul7+IYORwEum+bJqCWHRflcGNPpq2jNZpFzoF4jKZ+C3bcfmZ3Ms/kfM5fR/kuF+
 sSBUvfLAabuSWRUArnrQ04aWIk/Dhpk5v9BnBgvgKq8kNr95HfvMY4bP81b13P8n93Fw
 UHmNs/ITpRIEM1r6n5AdkblMiOoLtWNDzxl1e7BbU7AaIcfOJdbbTc/s+Gqv1dLEfXts
 64L6/2IsNVFzE8lbtuucy4y9+JeqXiWjPhHyWxrpc5xfNtjhksa6dQ1NinoLfg5ibRZu
 rH2YzVnquC7FG+ZKpKePQnb0fSd0cTXF4RpblA+bErvucFwSGB3035t4RZws7Z0J5GR8
 tdtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeMWACXGdumlDxyUyftltE7vDxKXhD91WfCa6Iav4WI/GOjGjqU8R2kppJCkxX2DNGXyUPIh2l75xkIOdgFfSoCYCp7cw=
X-Gm-Message-State: AOJu0Yw1cLpuN+XFVb9gc6ZEKy9QBn75EJAvJd2GXRdv7VKRo0f7QnY5
 tUXZ2BOP0XAp5klXOz0z37DaUAhTbewis6DPggm/YC7ihSbTf30e7ibSyGSthwfrog4VD60DHq1
 09K4Q8+0JC4PdSIMcq3TRWQ+xTU84KELH9VfrSQqkamwmMiUw0Ahz
X-Received: by 2002:aca:1b16:0:b0:3c7:3af4:6081 with SMTP id
 5614622812f47-3c997048826mr30233540b6e.16.1716293689848; 
 Tue, 21 May 2024 05:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWqNNyyz+738m9IhhI78Gi832spSxTWkkzUXNDv5lU1yA3C1nIhDYi2Teb6/r3G200av96jg==
X-Received: by 2002:aca:1b16:0:b0:3c7:3af4:6081 with SMTP id
 5614622812f47-3c997048826mr30233504b6e.16.1716293689101; 
 Tue, 21 May 2024 05:14:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf3116b0sm1277168685a.113.2024.05.21.05.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:14:48 -0700 (PDT)
Message-ID: <94735f57-d329-4444-80a7-09ab1182a6b1@redhat.com>
Date: Tue, 21 May 2024 14:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] vfio/display: Make vfio_display_*() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-3-zhenzhong.duan@intel.com>
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

One comment below,

> ---
>   hw/vfio/pci.h     |  2 +-
>   hw/vfio/display.c | 20 ++++++++++----------
>   hw/vfio/pci.c     |  3 +--
>   3 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 92cd62d115..a5ac9efd4b 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -232,7 +232,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                  Error **errp);
>   
>   void vfio_display_reset(VFIOPCIDevice *vdev);
> -int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> +bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>   
>   extern const VMStateDescription vfio_display_vmstate;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 57c5ae0b2a..b562f4be74 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -346,11 +346,11 @@ static const GraphicHwOps vfio_display_dmabuf_ops = {
>       .ui_info    = vfio_display_edid_ui_info,
>   };
>   
> -static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>   {
>       if (!display_opengl) {
>           error_setg(errp, "vfio-display-dmabuf: opengl not available");
> -        return -1;
> +        return false;
>       }
>   
>       vdev->dpy = g_new0(VFIODisplay, 1);
> @@ -360,11 +360,11 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>       if (vdev->enable_ramfb) {
>           vdev->dpy->ramfb = ramfb_setup(errp);
>           if (!vdev->dpy->ramfb) {
> -            return -EINVAL;
> +            return false;
>           }
>       }
>       vfio_display_edid_init(vdev);

vfio_display_edid_init() can fail for many reasons and does it silently.
It would be good to report the error in a future patch.

Thanks,

C.



> -    return 0;
> +    return true;
>   }
>   
>   static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
> @@ -481,7 +481,7 @@ static const GraphicHwOps vfio_display_region_ops = {
>       .gfx_update = vfio_display_region_update,
>   };
>   
> -static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>   {
>       vdev->dpy = g_new0(VFIODisplay, 1);
>       vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
> @@ -490,10 +490,10 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>       if (vdev->enable_ramfb) {
>           vdev->dpy->ramfb = ramfb_setup(errp);
>           if (!vdev->dpy->ramfb) {
> -            return -EINVAL;
> +            return false;
>           }
>       }
> -    return 0;
> +    return true;
>   }
>   
>   static void vfio_display_region_exit(VFIODisplay *dpy)
> @@ -508,7 +508,7 @@ static void vfio_display_region_exit(VFIODisplay *dpy)
>   
>   /* ---------------------------------------------------------------------- */
>   
> -int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
>   {
>       struct vfio_device_gfx_plane_info probe;
>       int ret;
> @@ -531,11 +531,11 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
>   
>       if (vdev->display == ON_OFF_AUTO_AUTO) {
>           /* not an error in automatic mode */
> -        return 0;
> +        return true;
>       }
>   
>       error_setg(errp, "vfio: device doesn't support any (known) display method");
> -    return -1;
> +    return false;
>   }
>   
>   void vfio_display_finalize(VFIOPCIDevice *vdev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c1adef5cf8..a447013a1d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3200,8 +3200,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       }
>   
>       if (vdev->display != ON_OFF_AUTO_OFF) {
> -        ret = vfio_display_probe(vdev, errp);
> -        if (ret) {
> +        if (!vfio_display_probe(vdev, errp)) {
>               goto out_deregister;
>           }
>       }


