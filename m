Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24016CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eto-0002Jq-GH; Tue, 14 Oct 2025 09:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8etm-0002JW-2j
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8etf-0006nZ-2O
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760447812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3HrIC7I3GfEuTd1Ag8IismJItkypjSYcNZs5Gg3ZU9U=;
 b=PXa/rSIWbsH74mAnlEYI8CJE9KdsYH+0b6ShTiTax136cWmEn8OzkHHlK660tlDvHkEn9T
 9DLK+59cSyOaGfogRrb2xoGGCIYKxfS+Eump9hXSekz7V1r282nZAofcToMl7qc+3elAAB
 7+X97jKWTJd9Bh4kuWDe3KihTnWPcAA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-vDKEJf4iMlq-iXWGWjN3fA-1; Tue, 14 Oct 2025 09:16:51 -0400
X-MC-Unique: vDKEJf4iMlq-iXWGWjN3fA-1
X-Mimecast-MFC-AGG-ID: vDKEJf4iMlq-iXWGWjN3fA_1760447810
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so3909043f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760447809; x=1761052609;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HrIC7I3GfEuTd1Ag8IismJItkypjSYcNZs5Gg3ZU9U=;
 b=ZsgdqwHnFyZsAqICoQ9lynt0ZeP3kwUCDP75VDdHvK2liOUaJN7hM0YMJPPzF8SARb
 /nax8rh8owMldIzmtxbakqcdcU2XqNI5r2VCxBBPNcbqdwoczS/r9eOSUUmK7ytrpLca
 sejX1vpW5wlPGHTAk8yB7XzdioQWqWuEH/gp2YdhB3S53AvCS0Qnk3mgMdIZtzsN7Qbm
 joeVGnSh4iXgdQDzc6GYpssnj2BN0llI1bN+6zZnK195z82xTIN7uUhxEBCUeWpH0wr8
 b109GEE83ydl1yxtXTqQn3Jsa8+dKyWMaxtSX56GgKA1b8zMMpI2C2FM/+Y9uBGqFHua
 YsTQ==
X-Gm-Message-State: AOJu0YwybxCp4wpc2U1zszJCwpTe7VeXeVSa+BvdpP0c5O7SHf95Nuxc
 mfK+Z0c0gckvQE9KJp2MYagcT/n+6DfoYXmprrY+al+YeHc29rp6HCYsycLGAnFlGXcCTJUFu1g
 mHqQM+SiJ+6JQny1fw+ByaB6dm8hTBquFx7il6fqOkDb+kGFmo2IAwLvQRDae0hLjF544HUl8/j
 /DmHcGSh96ulcNlDSrrutDjzeRfSD0C/Oi3w==
X-Gm-Gg: ASbGncuEm0xFZgqOtQZk6y4Io+a4lTUgboItd1xTLZ2zrigXumNSP0nNsHDPo0KqAEQ
 GivIQGo7g8+WRlFvBgDfVrC3DTpT4BQhK5xjypRZh+gpTV4Mv91EYF+wXUF8+7zP2qwh1k/VVfD
 x2J4nCAmUV48dlMACBdwOAIU0ZUVr/OxbpdMLgNLTrdt2BW5hty+0+sAeeKQ+oZC1F495sS6208
 bafjRHSBceUt1VH2Z5jOQcY652lcMdz+sUZCbm0vbybipg3WGN9s3/pDJYW/yDKG3DD2Z8X0w5/
 QkJ0isM+WD554xI/QBa4zu1piwUzDXXvzGQQEXobrFrTwMoDWiDzwYxXPVMZSlAxFQCR8W64g/I
 gCNk=
X-Received: by 2002:a05:600c:46d1:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-46fa9a98e73mr151228345e9.10.1760447809359; 
 Tue, 14 Oct 2025 06:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENsP1hvc0imHx36z9XFbWnlWUhZWgjkSYt17ZKLenr8d4F77mRGbMOcd1BdVzkH1jpRKJDiA==
X-Received: by 2002:a05:600c:46d1:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-46fa9a98e73mr151228005e9.10.1760447808712; 
 Tue, 14 Oct 2025 06:16:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab524f92sm149778015e9.7.2025.10.14.06.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 06:16:47 -0700 (PDT)
Message-ID: <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
Date: Tue, 14 Oct 2025 15:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/28] vfio: add region info cache
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>, John Johnson
 <john.g.johnson@oracle.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250509131317.164235-26-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello John,


On 5/9/25 15:13, Cédric Le Goater wrote:
> From: John Levon <john.levon@nutanix.com>
> 
> Instead of requesting region information on demand with
> VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
> necessary for performance for vfio-user, where this call becomes a
> message over the control socket, so is of higher overhead than the
> traditional path.
> 
> We will also need it to generalize region accesses, as that means we
> can't use ->config_offset for configuration space accesses, but must
> look up the region offset (if relevant) each time.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-12-john.levon@nutanix.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/vfio/ccw.c                 |  5 -----
>   hw/vfio/device.c              | 25 +++++++++++++++++++++----
>   hw/vfio/igd.c                 | 10 +++++-----
>   hw/vfio/pci.c                 |  6 +++---
>   hw/vfio/region.c              |  2 +-
>   6 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 7e1e81e76bd2b484108282f7147ff7a0793360cf..4fff3dcee3b4a2a3c8a4bd6fa017cf822a16668e 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -83,6 +83,7 @@ typedef struct VFIODevice {
>       IOMMUFDBackend *iommufd;
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
> +    struct vfio_region_info **reginfo;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index ab3fabf991c35abb6c40d925f526c2a2d8955aef..cea9d6e00562c241832184cafe862005fcdc992b 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -504,7 +504,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>   
>       vcdev->io_region_offset = info->offset;
>       vcdev->io_region = g_malloc0(info->size);
> -    g_free(info);
>   
>       /* check for the optional async command region */
>       ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
> @@ -517,7 +516,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->async_cmd_region_offset = info->offset;
>           vcdev->async_cmd_region = g_malloc0(info->size);
> -        g_free(info);
>       }
>   
>       ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
> @@ -530,7 +528,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->schib_region_offset = info->offset;
>           vcdev->schib_region = g_malloc(info->size);
> -        g_free(info);
>       }
>   
>       ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
> @@ -544,7 +541,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->crw_region_offset = info->offset;
>           vcdev->crw_region = g_malloc(info->size);
> -        g_free(info);
>       }
>   
>       return true;
> @@ -554,7 +550,6 @@ out_err:
>       g_free(vcdev->schib_region);
>       g_free(vcdev->async_cmd_region);
>       g_free(vcdev->io_region);
> -    g_free(info);
>       return false;
>   }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 40a196bfb9a86656610863d4f064db383c7072e0..77b0675abe7b4f4155ea79cf3fd0e3ab4b21f8ea 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -202,6 +202,12 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>       size_t argsz = sizeof(struct vfio_region_info);
>       int ret;
>   
> +    /* check cache */

It would be good to add an assert to check the index value. More important
we need to fix an ugly "index out-of-bounds" bug that can occur when booting
a VM with a vGPU :

   -device vfio-pci-nohotplug,host=0000:27:00.4,display=on,ramfb=true ...

The interesting part is :

   Thread 1 (Thread 0x7ffff6891ec0 (LWP 11372) "qemu-kvm"):
   #0  0x000055555581b83d in vfio_region_setup (obj=0x5555588c0b70, vbasedev=0x5555588c1630, region=0x555558a9c040, index=9, name=0x555555de94ba <str.68.llvm> "display") at ../hw/vfio/region.c:199
   #1  0x00005555558208a4 in vfio_display_region_update (opaque=<optimized out>) at ../hw/vfio/display.c:449
   #2  0x00005555556bdd6c in graphic_hw_update (con=0x555558acf830) at ../ui/console.c:143
   #3  vnc_refresh (dcl=0x7fffec048050) at ../ui/vnc.c:3262
   #4  0x00005555556a15cb in dpy_refresh (s=0x555558acf980) at ../ui/console.c:880
   #5  gui_update (opaque=0x555558acf980) at ../ui/console.c:90
   (gdb) p vbasedev->num_regions
   $9 = 9

Index 9 is beyond the maximum valid index of the reginfo array :/

We didn't take into account the ioctl VFIO_DEVICE_QUERY_GFX_PLANE
which can return region index 9 which is beyond the maximum valid
index of the reginfo array :/

I didn't expect that. Sometimes the best way to learn how something
works is to break it ... Ideas welcome.

Thanks,

C.



> +    if (vbasedev->reginfo[index] != NULL) {
> +        *info = vbasedev->reginfo[index];
> +        return 0;
> +    }
> +
>       *info = g_malloc0(argsz);
>   
>       (*info)->index = index;
> @@ -222,6 +228,9 @@ retry:
>           goto retry;
>       }
>   
> +    /* fill cache */
> +    vbasedev->reginfo[index] = *info;
> +
>       return 0;
>   }
>   
> @@ -240,7 +249,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   
>           hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
>           if (!hdr) {
> -            g_free(*info);
>               continue;
>           }
>   
> @@ -252,8 +260,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>           if (cap_type->type == type && cap_type->subtype == subtype) {
>               return 0;
>           }
> -
> -        g_free(*info);
>       }
>   
>       *info = NULL;
> @@ -262,7 +268,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   
>   bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       bool ret = false;
>   
>       if (!vfio_device_get_region_info(vbasedev, region, &info)) {
> @@ -435,10 +441,21 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>   
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +
> +    vbasedev->reginfo = g_new0(struct vfio_region_info *,
> +                               vbasedev->num_regions);
>   }
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev)
>   {
> +    int i;
> +
> +    for (i = 0; i < vbasedev->num_regions; i++) {
> +        g_free(vbasedev->reginfo[i]);
> +    }
> +    g_free(vbasedev->reginfo);
> +    vbasedev->reginfo = NULL;
> +
>       QLIST_REMOVE(vbasedev, container_next);
>       QLIST_REMOVE(vbasedev, global_next);
>       vbasedev->bcontainer = NULL;
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 3ee1a73b57c57563f661a246e6dd7e505231be91..e7952d15a014f28fe302cab312ab8e60a414c679 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -349,8 +349,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>   
>   static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *host = NULL;
> -    g_autofree struct vfio_region_info *lpc = NULL;
> +    struct vfio_region_info *host = NULL;
> +    struct vfio_region_info *lpc = NULL;
>       PCIDevice *lpc_bridge;
>       int ret;
>   
> @@ -510,7 +510,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>   
>   static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *opregion = NULL;
> +    struct vfio_region_info *opregion = NULL;
>       int ret, gen;
>       uint64_t gms_size = 0;
>       uint64_t *bdsm_size;
> @@ -551,7 +551,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>            * - OpRegion
>            * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>            */
> -        g_autofree struct vfio_region_info *rom = NULL;
> +        struct vfio_region_info *rom = NULL;
>   
>           legacy_mode_enabled = true;
>           info_report("IGD legacy mode enabled, "
> @@ -681,7 +681,7 @@ error:
>    */
>   static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *opregion = NULL;
> +    struct vfio_region_info *opregion = NULL;
>       int gen;
>   
>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index da2ffc9bf36778fb61a7decf345391caee528b2a..9136cf52c82711939db01c09a8a1277327bc484f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -883,8 +883,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
> -    g_autofree struct vfio_region_info *reg_info = NULL;
>       VFIODevice *vbasedev = &vdev->vbasedev;
> +    struct vfio_region_info *reg_info = NULL;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> @@ -2710,7 +2710,7 @@ static VFIODeviceOps vfio_pci_ops = {
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       int ret;
>   
>       ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
> @@ -2775,7 +2775,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       struct vfio_irq_info irq_info;
>       int i, ret = -1;
>   
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 04bf9eb0987c0ac460e0a1c3ba5abdf4a87f7499..ef2630cac3924fef200b2ece1be0dbad219dd67d 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -182,7 +182,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       int ret;
>   
>       ret = vfio_device_get_region_info(vbasedev, index, &info);


