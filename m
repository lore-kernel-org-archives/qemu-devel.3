Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274CFCA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2fp-0004IZ-TX; Mon, 01 Sep 2025 07:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2fo-00047c-BD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2fk-0006a6-Fy
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tTsvtj5J1mlXFlgIjqBYd7ZJTboivNB2+ePzohNvUMA=;
 b=fdpfKCTvjWv4hhCYWqasnPdnuKeU9W/6Lpq+BSV49W4CMUOaHj9HiSfhtzldFPEfY4G5FC
 YJoVs7rO6Gc/3F9rebvkduM8vSxvjvCCq0L8eG8wt6Woy1tDG/8zgV1/A6H/mbFuWWwzU0
 BWsKD/jwyU7k2Zbr7KV2kJcwtmuNd2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-veiWmFWSPUGT3WbQdP9lvQ-1; Mon, 01 Sep 2025 07:25:59 -0400
X-MC-Unique: veiWmFWSPUGT3WbQdP9lvQ-1
X-Mimecast-MFC-AGG-ID: veiWmFWSPUGT3WbQdP9lvQ_1756725958
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b87bc6795so10410095e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725958; x=1757330758;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tTsvtj5J1mlXFlgIjqBYd7ZJTboivNB2+ePzohNvUMA=;
 b=HdvITrpQhFLWKXKLLHODFScp2h6aCI8Ke1hzxmsJMzSGU0zz5DXKhN47su9nbcuRkj
 WY5/pKKEFGud2bZrAuV2olf0iSQ9n3VHZx2UocVge1+1sb7ecXn6BCH9EPDSQP2uf0fO
 J61vzPrl6pq+ChdhkwqeUBJVWk6o7bIYNs6MerqRTec8/qxZ6cuLux9RnEkmJGztNd+v
 1Ow51o1syvQiygzhmHu1yG7yLIoe/LknVS4gVhkd+ucM2ayaEMoUfv2/80uQMxFWqDqH
 lbl719fLGADlQJ1C3ntPo5tjS2oBtA1f7UDDTCheGfbfFHgS3OJ2aD+40OpUMeoCGP4d
 3oWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ6KkZdzBhOiTcBWCPzjf6usoIVAgKdcTw1Hk3cL0PsEASDN4kowREJse5wcryOJ/ocXtI8dbjOTOO@nongnu.org
X-Gm-Message-State: AOJu0Yzo8Enn44nfho5IYyy2srTYpqnsMVd1th4kiQ6S8WcEPxsAb2Bg
 wbFOR1uu290VDO8gakfgBzdY2YXrH4jDtwxttrJO3tKjicqujhFUu40Nvv8CW6EHzeHqhRU0wvA
 XOC0ZVfRKJkI6cwQlnHZgo2B00eusU69coNx+JbtRIjtBQHUCHr1G/HRu
X-Gm-Gg: ASbGncv7nw/YtIw6ukjjo6qmvtYPKpNWIAGI8RxWuyQ61bcJD+zSDyHoFXILMp2p+wJ
 iVH6Frr/Xu217GlsksHiaBe8q3TicGyXBp6Q6cts+pq3MZO6+YuWXkn90SBWWfdnZtg/DgGHEeL
 3YAUCuhaBr/BsbblhQRmCDb5Jx8VNpIZzJG8Mfb7o0wICqq6t2kYVbS9KwGhlzK2Ivtk0pX4hEN
 NzHipoBy1ppu4hykF1mPEBxYRjqjW+HdhIOjvp+Z5bSmgOx/R9W+pat0frIXndTOSNlb7q7mrG5
 //xP7NHIAOaIdKPWnGqYv4IAvvp0JbaPrDbO0rLzAeYtpDXMuJ61kAptEoi90GKwEw0kO5hlLuq
 lsrk=
X-Received: by 2002:a05:600c:1c04:b0:45b:8cee:581d with SMTP id
 5b1f17b1804b1-45b8cee5b4cmr20939945e9.22.1756725957946; 
 Mon, 01 Sep 2025 04:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1VocoAtk/XZa9cdD6GoVF4x8Ediro7NYS9aqJJ2uaCUnapd/4nezIqQoTiSg3vkJGUKf4DQ==
X-Received: by 2002:a05:600c:1c04:b0:45b:8cee:581d with SMTP id
 5b1f17b1804b1-45b8cee5b4cmr20939745e9.22.1756725957500; 
 Mon, 01 Sep 2025 04:25:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fbb3ccsm15069000f8f.51.2025.09.01.04.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:25:56 -0700 (PDT)
Message-ID: <24333a79-2a49-4abb-8bb7-8e5b30a0d58b@redhat.com>
Date: Mon, 1 Sep 2025 13:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-4-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250825212434.2255-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/25/25 23:24, Farhan Ali wrote:
> Add an s390x specific callback for vfio error handling. For s390x pci devices,
> we have platform specific error information. We need to retrieve this error
> information for passthrough devices. This is done via a memory region which
> exposes that information.
> 
> Once this error information is retrieved we can then inject an error into
> the guest, and let the guest drive the recovery.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          |  5 +++
>   hw/s390x/s390-pci-vfio.c         | 76 ++++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-pci-bus.h  |  1 +
>   include/hw/s390x/s390-pci-vfio.h |  2 +
>   4 files changed, 84 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index f87d2748b6..af42eb9938 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -158,6 +158,8 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>   {
>       HotplugHandler *hotplug_ctrl;
>   
> +    qemu_mutex_destroy(&pbdev->err_handler_lock);
> +
>       if (pbdev->pft == ZPCI_PFT_ISM) {
>           notifier_remove(&pbdev->shutdown_notifier);
>       }
> @@ -1140,6 +1142,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           pbdev->iommu->pbdev = pbdev;
>           pbdev->state = ZPCI_FS_DISABLED;
>           set_pbdev_info(pbdev);
> +        qemu_mutex_init(&pbdev->err_handler_lock);
>   
>           if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>               /*
> @@ -1164,6 +1167,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>               pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
>               /* Fill in CLP information passed via the vfio region */
>               s390_pci_get_clp_info(pbdev);
> +            /* Setup error handler for error recovery */
> +            s390_pci_setup_err_handler(pbdev);

This can fail. Please add an 'Error **' parameter and change the returned
value to bool.


>               if (!pbdev->interp) {
>                   /* Do vfio passthrough but intercept for I/O */
>                   pbdev->fh |= FH_SHM_VFIO;
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index aaf91319b4..87ecd06a81 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
> @@ -103,6 +104,60 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>       }
>   }
>   
> +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
> +                                    struct vfio_device_feature_zpci_err *err)

Please add an 'Error **' parameter and change the returned value to bool.

> +{
> +    int ret;
> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> +                              sizeof(struct vfio_device_feature_zpci_err),
> +                              sizeof(uint64_t))] = {};
> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +
> +    feature->argsz = sizeof(buf);
> +    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
> +    ret = vfio_pci->vbasedev.io_ops->device_feature(&vfio_pci->vbasedev,
> +                                                     feature);


Please introduce vfio helpers to hide the internal indirection :

   ->vbasedev.io_ops->device_feature(...)


> +
> +    if (ret) {
> +        error_report("Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
> +                    " (rc=%d)", ret);
> +        return ret;
> +    }
> +
> +    memcpy(err, (struct vfio_device_feature_zpci_err *) feature->data,
> +           sizeof(struct vfio_device_feature_zpci_err));
> +    return 0;
> +}
> +
> +static void s390_pci_err_handler(VFIOPCIDevice *vfio_pci)
> +{
> +    S390PCIBusDevice *pbdev;
> +    struct vfio_device_feature_zpci_err err;
> +    int ret;
> +
> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
> +                                        DEVICE(&vfio_pci->pdev)->id);
> +
> +    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
> +
> +    ret = s390_pci_get_feature_err(vfio_pci, &err);
> +    if (ret) {
> +        return;
> +    }
> +
> +    pbdev->state = ZPCI_FS_ERROR;
> +    s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 0);
> +
> +    while (err.pending_errors) {
> +        ret = s390_pci_get_feature_err(vfio_pci, &err);
> +        if (ret) {
> +            return;
> +        }
> +        s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 0);
> +    }
> +    return;
> +}
> +
>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>                                  struct vfio_device_info *info)
>   {
> @@ -369,3 +424,24 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>       s390_pci_read_util(pbdev, info);
>       s390_pci_read_pfip(pbdev, info);
>   }
> +
> +void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev)
> +{
> +    int ret;
> +    VFIOPCIDevice *vfio_pci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
> +                              sizeof(uint64_t))] = {};
> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +
> +    feature->argsz = sizeof(buf);
> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
> +
> +    ret = vfio_pci->vbasedev.io_ops->device_feature(&vfio_pci->vbasedev,
> +                                                     feature);

Please introduce vfio helpers to hide the internal indirection :

   ->vbasedev.io_ops->device_feature(...)

> +
> +    if (ret) {

Shouldn't we test the return value to decide if the error is
an unimplemented feature or an unexpected error ?

Thanks,

C.



> +        info_report("Automated error recovery not available for passthrough device");
> +        return;
> +    }
> +    vfio_pci->arch_err_handler = s390_pci_err_handler;
> +}
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 04944d4fed..3795e0bbfc 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -364,6 +364,7 @@ struct S390PCIBusDevice {
>       bool forwarding_assist;
>       bool aif;
>       bool rtr_avail;
> +    QemuMutex err_handler_lock;
>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>   };
>   
> diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
> index ae1b126ff7..66b274293c 100644
> --- a/include/hw/s390x/s390-pci-vfio.h
> +++ b/include/hw/s390x/s390-pci-vfio.h
> @@ -22,6 +22,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>   void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
> +void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev);
>   #else
>   static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
>   {
> @@ -39,6 +40,7 @@ static inline bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>       return false;
>   }
>   static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
> +static inline void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev) { }
>   #endif
>   
>   #endif


