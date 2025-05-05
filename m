Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EE6C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrzS-0006Os-9t; Mon, 05 May 2025 05:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrzE-0006IO-J1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrzB-00008g-2J
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9yIQtagZ4edPR8j+5qKazsFjcYXA+B5BhIo8uxpk01A=;
 b=QLJd64MFX3kEtlGQ7tl5w1VbOGg4rnvRD8DRSe9X4dnDIyyJsNh7lSqF6X44A3yUuCrwCY
 xeEoC5lhr2U6xH58m2loLfuBewDZhqgZRncopUtgJaWTzRQdZJDQAi2eM6WblIn+zS0l9D
 7UGxvB+Wk9K5DnpyXFc6ZRKbIYWpqxg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-C-44RzjUPDSln072MiF_tQ-1; Mon, 05 May 2025 05:19:33 -0400
X-MC-Unique: C-44RzjUPDSln072MiF_tQ-1
X-Mimecast-MFC-AGG-ID: C-44RzjUPDSln072MiF_tQ_1746436772
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so1287834f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746436772; x=1747041572;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yIQtagZ4edPR8j+5qKazsFjcYXA+B5BhIo8uxpk01A=;
 b=TI8b5/LDAb5v9obvdJtbZaXKrCg1hSP6zEIziQIs2vA26B4zmgDTrk0ZoOCDRdDVKb
 TlTAhGhBgMnf1ultO+ym8Q+pLQmSSaaCKsjLicCVwyqAnn/9GlBPAnso8CGjmPn2ccgk
 hG8EraT43qk4mp+FE27z7HE2CA0KRd7w4ptRnSz5O6Y6MBXNZwm7yGPds/Zp5XzdkFNg
 EYpJwsU3eWu/NlT6mVEtyEzUaQqeeIsGHNt0wszghQVZaE06aYr6QkuRJpQUfBtqMg2s
 Xd/pw2l0WMIX2DDR/m3Jl6lwCsOCblamYm7TFJ3bw9iEpX1ZsTzYBVYZ/8cyIQZlwecU
 37AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfKCHdRl9Zvm6xzVAC6/Ylr0RXZp+eU4akThD3nLbp+1G114ZYD+xOKOSktpmd6WwS4R5qpwpfOH/S@nongnu.org
X-Gm-Message-State: AOJu0YwSkybn0JoNVp3paAo5xPYBMYTYEGW7brk7d5t9HkZK5Zmka4H4
 aSBEPJUYaIi2I7wfNuOFbr6RxPZJe2o+lK2f7ZHqTwr2muyfNa6bOwablFVA01fOgpjSNhjJml0
 ly1S6TlCV+BQ7rEYG+61ctR6YxxJ/WrIviAMPu+Ud1oovceW86qli
X-Gm-Gg: ASbGnctMu0AF3c+wQzP8Jg0MJ9MCuOeklq5bJDii18TVgljF6Iz//4OiZm+8jypR5w1
 ecvTfD0HsanRgwogtZy6Ab+lwlmJGbT1ozOAtVQS+GIXMT2LUAHuR8XC5en9bNJBOTuADzjwjLh
 tX4dWKAPJ9/RceD9J8NQrbuGoomeB51YLBM0hX/g0XjVVF6l/1tagV4igIjI3xybLVrll/ADQwa
 TdJiQGJEwNxjrkEFfri9VE600VkOOg/b15QpiPGMy+PQvi242o2HJ/VBb81W4mvI/tk0QAw7gcG
 A924qYXm0DbH885/tS4qhEeO//Wy4ej/Ff8evH9MCgoTXOSpcQ==
X-Received: by 2002:a5d:64e6:0:b0:391:3cb7:d441 with SMTP id
 ffacd0b85a97d-3a09fd7c5afmr5110413f8f.25.1746436771902; 
 Mon, 05 May 2025 02:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBrheYt4c7e4TmuPaRBu1SnOBLUE11rTPeNZWjn1GhzWxo6ZNxYNpKuTaXsRTODyCnLRjnsg==
X-Received: by 2002:a5d:64e6:0:b0:391:3cb7:d441 with SMTP id
 ffacd0b85a97d-3a09fd7c5afmr5110390f8f.25.1746436771416; 
 Mon, 05 May 2025 02:19:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7b09sm9651058f8f.48.2025.05.05.02.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:19:30 -0700 (PDT)
Message-ID: <21e7accb-f5e3-4f8c-aa76-e9e2f2094fb6@redhat.com>
Date: Mon, 5 May 2025 11:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] vfio: add vfio_device_get_irq_info() helper
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-5-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 21:39, John Levon wrote:
> Add a helper similar to vfio_device_get_region_info() and use it
> everywhere.
> 
> Replace a couple of needless allocations with stack variables.
> 
> As a side-effect, this fixes a minor error reporting issue in the call
> from vfio_msix_early_setup().
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/ap.c                  | 19 ++++++++++---------
>   hw/vfio/ccw.c                 | 20 +++++++++++---------
>   hw/vfio/device.c              | 15 +++++++++++++++
>   hw/vfio/pci.c                 | 23 +++++++++++------------
>   hw/vfio/platform.c            |  6 +++---
>   include/hw/vfio/vfio-device.h |  3 +++
>   6 files changed, 53 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 4f88f80c54..4f97260dac 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -139,10 +139,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
>       int fd;
> -    size_t argsz;
> +    int ret;
>       IOHandler *fd_read;
>       EventNotifier *notifier;
> -    g_autofree struct vfio_irq_info *irq_info = NULL;
> +    struct vfio_irq_info irq_info;
>       VFIODevice *vdev = &vapdev->vdev;
>   
>       switch (irq) {
> @@ -165,14 +165,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           return false;
>       }
>   
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = irq;
> -    irq_info->argsz = argsz;
> +    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
> +        return false;
> +    }
>   
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +    if (irq_info.count < 1) {
> +        error_setg(errp, "vfio: Error getting irq info, count=0");
>           return false;
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index fde0c3fbef..ab3fabf991 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>                                              Error **errp)
>   {
>       VFIODevice *vdev = &vcdev->vdev;
> -    g_autofree struct vfio_irq_info *irq_info = NULL;
> -    size_t argsz;
> +    struct vfio_irq_info irq_info;
> +    int ret;
>       int fd;
>       EventNotifier *notifier;
>       IOHandler *fd_read;
> @@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>           return false;
>       }
>   
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = irq;
> -    irq_info->argsz = argsz;
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
> +        return false;
> +    }
> +
> +    if (irq_info.count < 1) {
> +        error_setg(errp, "vfio: Error getting irq info, count=0");
>           return false;
>       }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 9673b0717e..5d837092cb 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       return false;
>   }
>   
> +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> +                             struct vfio_irq_info *info)
> +{
> +    int ret;
> +
> +    memset(info, 0, sizeof(*info));
> +
> +    info->argsz = sizeof(*info);
> +    info->index = index;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6908bcc0d3..407cf43387 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       uint16_t ctrl;
>       uint32_t table, pba;
>       int ret, fd = vdev->vbasedev.fd;
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
> +    struct vfio_irq_info irq_info;
>       VFIOMSIXInfo *msix;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
> @@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>       msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                   &irq_info);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
>           g_free(msix);
> @@ -2736,7 +2736,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       g_autofree struct vfio_region_info *reg_info = NULL;
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
> +    struct vfio_irq_info irq_info;
>       int i, ret = -1;
>   
>       /* Sanity check device */
> @@ -2797,12 +2797,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           }
>       }
>   
> -    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
> -
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
> +        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
>       } else if (irq_info.count == 1) {
>           vdev->pci_aer = true;
>       } else {
> @@ -2911,17 +2909,18 @@ static void vfio_req_notifier_handler(void *opaque)
>   
>   static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>   {
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
> +    struct vfio_irq_info irq_info;
>       Error *err = NULL;
>       int32_t fd;
> +    int ret;
>   
>       if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
>           return;
>       }
>   
> -    if (ioctl(vdev->vbasedev.fd,
> -              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> +    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
> +                                   &irq_info);
> +    if (ret < 0 || irq_info.count < 1) {
>           return;
>       }
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ffb3681607..9a21f2e50a 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -474,10 +474,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
>       QSIMPLEQ_INIT(&vdev->pending_intp_queue);
>   
>       for (i = 0; i < vbasedev->num_irqs; i++) {
> -        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
> +        struct vfio_irq_info irq;
> +
> +        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
>   
> -        irq.index = i;
> -        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
>           if (ret) {
>               error_setg_errno(errp, -ret, "failed to get device irq info");
>               goto irq_err;
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 666a0b50b4..5b833868c9 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -146,6 +146,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>                                        uint32_t subtype, struct vfio_region_info **info);
>   bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
> +
> +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> +                                struct vfio_irq_info *info);

This is breaking the windows build.


Thanks,

C.



>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */


