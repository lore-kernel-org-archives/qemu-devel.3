Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA92C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHeXt-0001E1-53; Wed, 21 May 2025 04:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeXq-0001DQ-Sr
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeXj-0007Be-Rx
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2x7Zardb1nGF48lNRbcJKx2bgn4sBg1pr4dkri7hTCs=;
 b=DdnvnlOojVh2n8JwScEQIb9OfHNEdxeWF/Q9zOVlj1u+Z0ENu5ucncRI32ymsYjdmoEqaw
 xlbJl44GXrebiCoLMc+LKj3FK98ExNG/HzKLQ0OjjJElXPnpVZMcfhgw74Oo2tMwVbsOuZ
 djzpo3In0DeJdubuhxTukuyaBpVpcVI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-P9tJ0TjGOjGA8NrdtDA4Nw-1; Wed, 21 May 2025 04:11:10 -0400
X-MC-Unique: P9tJ0TjGOjGA8NrdtDA4Nw-1
X-Mimecast-MFC-AGG-ID: P9tJ0TjGOjGA8NrdtDA4Nw_1747815069
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a36d041d06so1502934f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815069; x=1748419869;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x7Zardb1nGF48lNRbcJKx2bgn4sBg1pr4dkri7hTCs=;
 b=YMKuolI26ROY/hxSx5MSFzui8iqvr5FhYq1sFqPJv5F0REpmsQBdTyOfw7S1nuvpJh
 +AhUapCNknE3rCdDYpC6+lLW9pqTfVbJJbx/mrMbt6AmqZFysjEWX5eS1SetxDLdMB5v
 uqDTnp6Re/B6QQZeJ7NHPgzzBir2Tlw0yabFmXc9LchpA0eR4l5oLzlrXozZX/CMqSvK
 Waj29ZOKQSKZKth8vpsTyqAboBuLy1Xmwkend6fuWQ7FX/WZD5IHCO+k8zHCEoLA4u2G
 RcCjek5G0zbeNb0lNImR0V7tuW6lb0oA1N5thjBeeC2ygRepLrLKOc2tDW4jUJahmstF
 iwzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/3eVBQBvAYg8IHz1JSWH7IabD4JRmcxhvO4bMXc5glVtICt60DfrQLE8n+9pvXGX6OcOkhrCNKpk6@nongnu.org
X-Gm-Message-State: AOJu0YyYwAbpxf2njOi5O7uQ6AXVb8KtHhgtXVfVL/lPnyDKlGqHtUfr
 omEvG00ufuzAcBKMfJdRjN1VmyLAl+3VCx1D1gJYGv+s0uM587TvaUo/KlZyyd24lwDXAACuc3y
 FA7G3Bj+RuHuWQk5YZv+d28mFqP0SFbGyYjTcLCsiiu8xmiv3sYOJT0dt
X-Gm-Gg: ASbGncscIgB3mFa7Az0KB4hMaf4g9mUOsTWoLysfvAAoVjm8UlJGDr4hkxIAMUGp2Pv
 juMusZRcw9QGLrGYeKbicoGYhTIFnJx57v8seVBOcJGD/p5+5ey+ENq7njkSk0n6dolOve7kHGM
 ffktkVCFgtNs1iAmXWrNgLGwMODOYKVosLiAfJUxfQ8EGxy0B8Z1dyqsvyOeoXzaxvgHR2eUtSl
 gAs5tff76VjSkeq9cxRPfysA+PVvWJtiuGsaBoQEFu6VEKdy01s/P9lwDiX+XzHgUlWov0nUo0R
 KLqRa4cEDMSaKDIkTcaj8xOxz1321+lEhdlxZEiZVNHyEMJ55g==
X-Received: by 2002:a5d:5f46:0:b0:3a0:b816:5a44 with SMTP id
 ffacd0b85a97d-3a35fe964dcmr16350270f8f.35.1747815068674; 
 Wed, 21 May 2025 01:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWAP2poxJgFHBIpOGQpJJuNhuIClr2hpBsXAeiZkpqYOS2i8Z3dCTSzthrrLXx5wj2ZrskKA==
X-Received: by 2002:a5d:5f46:0:b0:3a0:b816:5a44 with SMTP id
 ffacd0b85a97d-3a35fe964dcmr16350243f8f.35.1747815068284; 
 Wed, 21 May 2025 01:11:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm4561342f8f.100.2025.05.21.01.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 01:11:07 -0700 (PDT)
Message-ID: <340d64a0-b85c-422a-ac81-4de6b10c8228@redhat.com>
Date: Wed, 21 May 2025 10:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] vfio: add per-region fd support
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-8-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250520150419.2172078-8-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On 5/20/25 17:03, John Levon wrote:
> For vfio-user, each region has its own fd rather than sharing
> vbasedev's. Add the necessary plumbing to support this. For vfio
> backends with a shared fd, initialize region->fd to the shared one.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-device.h |  7 +++++--
>   include/hw/vfio/vfio-region.h |  1 +
>   hw/vfio/device.c              | 28 ++++++++++++++++++++++++++--
>   hw/vfio/region.c              |  7 ++++++-
>   4 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 923f9cd116..5cb817fd6a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -66,6 +66,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
> +    bool use_region_fds;
>       VFIODeviceOps *ops;
>       VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
>       struct vfio_region_info **reginfo;
> +    int *region_fds;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> @@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
>       /**
>        * @get_region_info
>        *
> -     * Fill in @info with information on the region given by @info->index.
> +     * Fill in @info (and optionally @fd) with information on the region given
> +     * by @info->index.

The whole VFIODeviceIOOps struct needs better documentation. The arguments
are missing.

>        */
>       int (*get_region_info)(VFIODevice *vdev,
> -                           struct vfio_region_info *info);
> +                           struct vfio_region_info *info, int *fd);
>   
>       /**
>        * @get_irq_info
> diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
> index cbffb26962..80e83b23fd 100644
> --- a/include/hw/vfio/vfio-region.h
> +++ b/include/hw/vfio/vfio-region.h
> @@ -29,6 +29,7 @@ typedef struct VFIORegion {
>       uint32_t nr_mmaps;
>       VFIOMmap *mmaps;
>       uint8_t nr; /* cache the region number for debug */
> +    int fd; /* fd to mmap() region */

Could you split this change ? I am not sure it is needed.


>   } VFIORegion;
>   
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d0068086ae..41db403992 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int fd = -1;
>       int ret;
>   
>       /* check cache */
> @@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
> +    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
>       if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> @@ -251,11 +252,19 @@ retry:
>           argsz = (*info)->argsz;
>           *info = g_realloc(*info, argsz);
>   
> +        if (fd != -1) {
> +            close(fd);
> +            fd = -1;
> +        }
> +
>           goto retry;
>       }
>   
>       /* fill cache */
>       vbasedev->reginfo[index] = *info;
> +    if (vbasedev->region_fds != NULL) {
> +        vbasedev->region_fds[index] = fd;
> +    }
>   
>       return 0;
>   }
> @@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>       vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
> +    vbasedev->use_region_fds = false;

I wish we could avoid this bool. I have no idea yet.


>   
>       vbasedev->ram_block_discard_allowed = ram_discard;
>   }
> @@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>   
>       vbasedev->reginfo = g_new0(struct vfio_region_info *,
>                                  vbasedev->num_regions);
> +    if (vbasedev->use_region_fds) {
> +        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> +    }
>   }
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev)
> @@ -478,9 +491,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>   
>       for (i = 0; i < vbasedev->num_regions; i++) {
>           g_free(vbasedev->reginfo[i]);
> +        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
> +            close(vbasedev->region_fds[i]);
> +        }
> +
>       }
>       g_free(vbasedev->reginfo);
>       vbasedev->reginfo = NULL;
> +    if (vbasedev->region_fds != NULL) {

g_free is NULL safe. No need to test for it. g_clear_pointer() is a nice
helper too.

> +        g_free(vbasedev->region_fds);
> +        vbasedev->region_fds = NULL;
> +    }
>   
>       QLIST_REMOVE(vbasedev, container_next);
>       QLIST_REMOVE(vbasedev, global_next);
> @@ -502,10 +523,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
>   }
>   
>   static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
> -                                          struct vfio_region_info *info)
> +                                          struct vfio_region_info *info,
> +                                          int *fd)
>   {
>       int ret;
>   
> +    *fd = -1;
> +
>       ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>   
>       return ret < 0 ? -errno : ret;
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 34752c3f65..3c93da91d8 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -200,6 +200,11 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>       region->size = info->size;
>       region->fd_offset = info->offset;
>       region->nr = index;
> +    if (vbasedev->region_fds != NULL) {
> +        region->fd = vbasedev->region_fds[index];
> +    } else {
> +        region->fd = vbasedev->fd;
> +    }
>   
>       if (region->size) {
>           region->mem = g_new0(MemoryRegion, 1);
> @@ -278,7 +283,7 @@ int vfio_region_mmap(VFIORegion *region)
>   
>           region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
>                                        MAP_SHARED | MAP_FIXED,
> -                                     region->vbasedev->fd,
> +                                     region->fd,

Would this work ?

		vbasedev->region_fds ? vbasedev->region_fds[region->nr] : vbasedev->fd,


Thanks,

C.


>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {


