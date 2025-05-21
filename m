Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D78EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 07:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHe3Q-0002OK-MU; Wed, 21 May 2025 03:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHe3L-0002M6-RE
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHe3J-0002St-Ad
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747813187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4qeV11GLUkCPmlL4u7pSnTmoH4Mca5rENRHX5EYM5Cw=;
 b=htIpE7ydcpbbEMmSlccjk4yo7+ni22nyDnfuXOomWecG0qIONKcCaL/WOoeMZrBjysY0Wi
 0oNgJUXrBoBdyNyX3DNqrW3SSunH53SNqtfx6PC7YKK1nRi/HyJ/hUFTJwmh40bIovX5gv
 F3j2qv/3gsSVRKtPhPRx2OLMAj13N28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-zYIgAJEdMvW6cH0yxt5xPg-1; Wed, 21 May 2025 03:39:45 -0400
X-MC-Unique: zYIgAJEdMvW6cH0yxt5xPg-1
X-Mimecast-MFC-AGG-ID: zYIgAJEdMvW6cH0yxt5xPg_1747813185
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442f4a3851fso55194285e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 00:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747813184; x=1748417984;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qeV11GLUkCPmlL4u7pSnTmoH4Mca5rENRHX5EYM5Cw=;
 b=b4zI17e9ufEJZFaTi3cotr7zNdVMT2gsNGRU1GDvSx6bU9KcVcfXGXAhgV9Gb+Y6t1
 CTpPQe+HBYhYHWTm9X3hE3c8NdzGXML0YQW1W6jh67zbS6r+KSQ/WhFf2VnNKXqFRRQY
 LmoWicKG+3vwSDU6sXKorBkNGaSWaQ3sYy+9ESNwbAS+FRVRJ2NBDFegpg2wcTRcDHRg
 cVcUC/+lnmFU0tIuiyCfRvbAMODjrUY4nmGZqDG+dqzalFnMVtDcOoN7zhQDYlR/lFhB
 4e4SJVjWvGn7NDujE7dUFfQhg+XEtKYibHfZsE0ynp4oSBSK3O2gbVK4mOzf2lrm2Li9
 ODdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzcX17pp+J99ISW1RbPYoNBqJ5Viji7N24OZkWahQZqpnjmIMLYJnnfo+8hlueacmLW/WIbNMVGAWB@nongnu.org
X-Gm-Message-State: AOJu0YzrzfFFnoldVS39dOcuZAK0rR6DC1fBr4WNmw+Dq6PMrBT7RFVn
 HoOewjSPnykMPQnjAaQdbkdPH1+mtGodbwJ0DEyxCyGg76z9o2pPh1Fw96oGGGqVzH29/BeM/3r
 aLRph8x7eGMREFl4hdQNHV6K9H6HGbryBg9BrVAb56WL89R/iU9ml2aLy
X-Gm-Gg: ASbGncu7Oh47txL2Axvu+qCWb/rW/NwvoE1TuXpTn3rnZztfT+F/j9agFjpHN9SUKHN
 31OdjzkPPS2mBSUt9j9dpb0FV1s3Q7pmPmnVhn+YSh8OPdmIo0Dr1l6nmg09opoRBm2N4uQ7Rqm
 LFTnzfnYQiHgpxbREqOUdkZ7PPyy0yU5Xb3q4woegfmGsH400ObiiF7FbCoROIO2klMjFQqoWmC
 dbi6Ge/YACzVkLu/CF1YF27m+1T96YIuWVbUg+cGH9ulUGsBWaUrZBsxRS8lTngmv/g16u2uul1
 SHglGHIs7BBIsd/eH0u8rly9UvDZthn0+Bsv7lbB71S0YfaOqw==
X-Received: by 2002:a05:600c:3d09:b0:442:f990:3ce7 with SMTP id
 5b1f17b1804b1-442feffb6e6mr208661895e9.16.1747813184539; 
 Wed, 21 May 2025 00:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpB+H37I1KB4pB2SaV9wnWjB2c5cnbBG030A+5Xhh3wEY1wh4Ou3Y5PBcoQYQlyFIFFiR/gQ==
X-Received: by 2002:a05:600c:3d09:b0:442:f990:3ce7 with SMTP id
 5b1f17b1804b1-442feffb6e6mr208661545e9.16.1747813184087; 
 Wed, 21 May 2025 00:39:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447eee9d8desm61853685e9.0.2025.05.21.00.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 00:39:43 -0700 (PDT)
Message-ID: <71d44d9c-63f2-4f71-a0bd-366762d816d1@redhat.com>
Date: Wed, 21 May 2025 09:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] vfio: export PCI helpers needed for vfio-user
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
 <20250520150419.2172078-6-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250520150419.2172078-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> The vfio-user code will need to re-use various parts of the vfio PCI
> code. Export them in hw/vfio/pci.h, and rename them to the vfio_pci_*
> namespace.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/pci.h        | 14 ++++++++++++
>   hw/vfio/pci.c        | 54 ++++++++++++++++++++++----------------------
>   hw/vfio/trace-events |  6 ++---
>   3 files changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ce0fb916f..61fa385ddb 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -248,4 +248,18 @@ void vfio_display_finalize(VFIOPCIDevice *vdev);
>   
>   extern const VMStateDescription vfio_display_vmstate;
>   
> +void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
> +bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
> +bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
> +Object *vfio_pci_get_object(VFIODevice *vbasedev);
> +bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_intx_eoi(VFIODevice *vbasedev);
> +int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
> +void vfio_pci_put_device(VFIOPCIDevice *vdev);
> +bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
> +void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
> +int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
> +void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
> +

The rename is a good thing. There are more to be done.

One comment,

These routines :

   Object *vfio_pci_get_object(VFIODevice *vbasedev);
   void vfio_pci_intx_eoi(VFIODevice *vbasedev);
   int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
   int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);

are exported to simply define the VFIODeviceOps vfio_user_pci_ops struct
(and they don't take a VFIOPCIDevice as first argument). I wonder if we
could find a way to keep them private.

Also, does vfio-user support migration ? if not then, we only need to
export vfio_pci_intx_eoi()


Thanks,

C.




>   #endif /* HW_VFIO_VFIO_PCI_H */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b1250d85bf..5159198bdb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
>       }
>   }
>   
> -static void vfio_intx_eoi(VFIODevice *vbasedev)
> +void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>   
> @@ -111,7 +111,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>           return;
>       }
>   
> -    trace_vfio_intx_eoi(vbasedev->name);
> +    trace_vfio_pci_intx_eoi(vbasedev->name);
>   
>       vdev->intx.pending = false;
>       pci_irq_deassert(&vdev->pdev);
> @@ -236,7 +236,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>       }
>   
>       /* Re-enable the interrupt in cased we missed an EOI */
> -    vfio_intx_eoi(&vdev->vbasedev);
> +    vfio_pci_intx_eoi(&vdev->vbasedev);
>   }
>   
>   static void vfio_intx_routing_notifier(PCIDevice *pdev)
> @@ -1743,7 +1743,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       return true;
>   }
>   
> -static void vfio_teardown_msi(VFIOPCIDevice *vdev)
> +void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
>   {
>       msi_uninit(&vdev->pdev);
>   
> @@ -1839,7 +1839,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static void vfio_bars_exit(VFIOPCIDevice *vdev)
> +void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
>   {
>       int i;
>   
> @@ -2430,7 +2430,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>       g_free(config);
>   }
>   
> -static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>   
> @@ -2599,7 +2599,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
>       }
>   }
>   
> -static Object *vfio_pci_get_object(VFIODevice *vbasedev)
> +Object *vfio_pci_get_object(VFIODevice *vbasedev)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>   
> @@ -2655,7 +2655,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
>       }
>   };
>   
> -static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
> +int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>   
> @@ -2663,7 +2663,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>                                          errp);
>   }
>   
> -static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> +int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>       PCIDevice *pdev = &vdev->pdev;
> @@ -2706,7 +2706,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>   static VFIODeviceOps vfio_pci_ops = {
>       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
> -    .vfio_eoi = vfio_intx_eoi,
> +    .vfio_eoi = vfio_pci_intx_eoi,
>       .vfio_get_object = vfio_pci_get_object,
>       .vfio_save_config = vfio_pci_save_config,
>       .vfio_load_config = vfio_pci_load_config,
> @@ -2777,7 +2777,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -2823,7 +2823,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    trace_vfio_populate_device_config(vdev->vbasedev.name,
> +    trace_vfio_pci_populate_device_config(vdev->vbasedev.name,
>                                         (unsigned long)reg_info->size,
>                                         (unsigned long)reg_info->offset,
>                                         (unsigned long)reg_info->flags);
> @@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
> +        trace_vfio_pci_populate_device_get_irq_info_failure(strerror(-ret));
>       } else if (irq_info.count == 1) {
>           vdev->pci_aer = true;
>       } else {
> @@ -2857,7 +2857,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static void vfio_pci_put_device(VFIOPCIDevice *vdev)
> +void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   {
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> @@ -2905,7 +2905,7 @@ static void vfio_err_notifier_handler(void *opaque)
>    * and continue after disabling error recovery support for the
>    * device.
>    */
> -static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
> +void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
>   {
>       Error *err = NULL;
>       int32_t fd;
> @@ -2964,7 +2964,7 @@ static void vfio_req_notifier_handler(void *opaque)
>       }
>   }
>   
> -static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
> +void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
>   {
>       struct vfio_irq_info irq_info;
>       Error *err = NULL;
> @@ -3018,7 +3018,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>       vdev->req_enabled = false;
>   }
>   
> -static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>       VFIODevice *vbasedev = &vdev->vbasedev;
> @@ -3124,7 +3124,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>   
> @@ -3214,7 +3214,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> -    if (!vfio_populate_device(vdev, errp)) {
> +    if (!vfio_pci_populate_device(vdev, errp)) {
>           goto error;
>       }
>   
> @@ -3228,7 +3228,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           goto out_teardown;
>       }
>   
> -    if (!vfio_add_capabilities(vdev, errp)) {
> +    if (!vfio_pci_add_capabilities(vdev, errp)) {
>           goto out_unset_idev;
>       }
>   
> @@ -3244,7 +3244,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           vfio_bar_quirk_setup(vdev, i);
>       }
>   
> -    if (!vfio_interrupt_setup(vdev, errp)) {
> +    if (!vfio_pci_interrupt_setup(vdev, errp)) {
>           goto out_unset_idev;
>       }
>   
> @@ -3288,8 +3288,8 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           }
>       }
>   
> -    vfio_register_err_notifier(vdev);
> -    vfio_register_req_notifier(vdev);
> +    vfio_pci_register_err_notifier(vdev);
> +    vfio_pci_register_req_notifier(vdev);
>       vfio_setup_resetfn_quirk(vdev);
>   
>       return;
> @@ -3310,8 +3310,8 @@ out_unset_idev:
>           pci_device_unset_iommu_device(pdev);
>       }
>   out_teardown:
> -    vfio_teardown_msi(vdev);
> -    vfio_bars_exit(vdev);
> +    vfio_pci_teardown_msi(vdev);
> +    vfio_pci_bars_exit(vdev);
>   error:
>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>   }
> @@ -3338,9 +3338,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>       if (vdev->intx.mmap_timer) {
>           timer_free(vdev->intx.mmap_timer);
>       }
> -    vfio_teardown_msi(vdev);
> +    vfio_pci_teardown_msi(vdev);
>       vfio_pci_disable_rp_atomics(vdev);
> -    vfio_bars_exit(vdev);
> +    vfio_pci_bars_exit(vdev);
>       vfio_migration_exit(vbasedev);
>       if (!vbasedev->mdev) {
>           pci_device_unset_iommu_device(pdev);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e90ec9bff8..f06236f37b 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -2,7 +2,7 @@
>   
>   # pci.c
>   vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
> -vfio_intx_eoi(const char *name) " (%s) EOI"
> +vfio_pci_intx_eoi(const char *name) " (%s) EOI"
>   vfio_intx_enable_kvm(const char *name) " (%s) KVM INTx accel enabled"
>   vfio_intx_disable_kvm(const char *name) " (%s) KVM INTx accel disabled"
>   vfio_intx_update(const char *name, int new_irq, int target_irq) " (%s) IRQ moved %d -> %d"
> @@ -35,8 +35,8 @@ vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
>   vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
>   vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
>   vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
> -vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
> -vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> +vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
> +vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
>   vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>   vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
>   vfio_pci_reset(const char *name) " (%s)"


