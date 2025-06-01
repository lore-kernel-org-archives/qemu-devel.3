Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18904C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLlil-0002B2-52; Sun, 01 Jun 2025 12:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLlid-0002AY-D9
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLlib-0002eD-Og
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748795967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i7IxUI6Jt3qi7uM1DRX2xoOFlZiSxSi2miZ3BLaRilo=;
 b=Onb6yKhDNoMAlMetJ2URIv6JSTKhSDTAAlFcAGrjSY8pwj11zNzmyiIW98TWAMOE5WfgJs
 wQOf75d+WyFXRJ/l9QUiFRg86SfNXymzxfkR3KxYCspKRno9S67/ygw8RumhzpuOVjaS7Q
 EOVXOItnpKKfUF5GBQgNkIC5UfrhTYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-loBJzS2fOdWOb3rkbnEDLw-1; Sun, 01 Jun 2025 12:39:26 -0400
X-MC-Unique: loBJzS2fOdWOb3rkbnEDLw-1
X-Mimecast-MFC-AGG-ID: loBJzS2fOdWOb3rkbnEDLw_1748795965
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so24123625e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 09:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748795965; x=1749400765;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7IxUI6Jt3qi7uM1DRX2xoOFlZiSxSi2miZ3BLaRilo=;
 b=rM7z9nrZh2THVaHSq3MlAaeIm4xNmF1lAA9tZIq4J3T2XgoIftR4+zckdzEJKoiAu0
 hFS+avku7tm8gSDc1EA9z6NCu1H21ga8AchsfEFsc9shWg0R8k9/Ou9urLVLKL7Gt5ik
 RDKe540ShJ1KU/LdwMrWbOWDdwapjegcV/HUMMUfAYBQnHzofooCz46Ivz7p1k4WWOUy
 08IrHHv1TBE5ynV/rAttig20Ln7BEt28b2nNwsidmnantYq6xaPQYDYOUZzGq1JHA2nw
 r2OWFYcPYTwMXX00KDByQyDmS91dDLma7C7UKUJ3nusq20bUP5TFxTxlCgzJCGZEW+5k
 kf9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JjRPiLgSs1d63aTQqItX3pd3X1uIITyiN3IfMMQQytdyPWpXLLlhLW4xLpUwS/LyFPifckHNFdy+@nongnu.org
X-Gm-Message-State: AOJu0YzYc/bsAEtjmeHQi3Q0zJKSU+XGAiM3uMzbaMilVBXIYg87hkLc
 400CUCb/lrjCB5FsGFRhXXVF1j95gQuUYUH7S5xRWoB5ZgRHJ9IXcyJyNrYMn7YCGeCWHkzjak8
 fRbTZnxP2X/hjFXFRdzDqcACUh1vXoGx+1x80AO3zXRvMdfn9p7QpNwLw
X-Gm-Gg: ASbGncuOLb0ZoG7BOZlmjOiQt7yjz2sAkGzuzzqXeLNFBd2upldWgihe1afcT1qKbpR
 wubqA7oieM5E/OzwfUZ/z/J6fEh2I6KnXkiAWviqwaXyn5g9IGqgwejqJ4pE4IkFaB2P5Ipzz7A
 KjSsomHzkNNs5y01Ey8hUaaft+Ym4n4Klv9hYH41Qah39KiyShRv2vnxwsY05U6tRk1i2Vr58V+
 JHkdZd2azK6x1CuN3etGpBORAo9LMW7pblAnlPBGxHj4paZMtGo/ha6eKAK4/aZRepkO2x1l04t
 UFn8bA3GyKNe+FB89mfZBM7FlAG0wyChIeo1tnGrQDGHzd1zjg==
X-Received: by 2002:a5d:4082:0:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3a4f8fa8a6bmr6242975f8f.18.1748795965309; 
 Sun, 01 Jun 2025 09:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT3GiL1vezAZlaf0x7le39vTXBupaB/SRe2rSbiZpGLS8rkkCWwou6j7VKmy1xia3+dTlagw==
X-Received: by 2002:a5d:4082:0:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3a4f8fa8a6bmr6242966f8f.18.1748795964929; 
 Sun, 01 Jun 2025 09:39:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc2725sm90441115e9.37.2025.06.01.09.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 09:39:24 -0700 (PDT)
Message-ID: <1c560f7e-5aa6-4184-8131-26efddb1fe08@redhat.com>
Date: Sun, 1 Jun 2025 18:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/43] vfio-pci: skip reset during cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-18-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-18-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/29/25 21:24, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR, and do not complain if the
> kernel's PCI config space changes for non-emulated bits between the
> vmstate save and load, which can happen due to ongoing interrupt activity.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-cpr.h |  2 ++
>   hw/vfio/cpr.c              | 31 +++++++++++++++++++++++++++++++
>   hw/vfio/pci.c              |  7 +++++++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 56ede04..8bf85b9 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -52,4 +52,6 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>   bool vfio_cpr_ram_discard_register_listener(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +extern const VMStateDescription vfio_cpr_pci_vmstate;
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 0e59612..fdbb58e 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -8,6 +8,8 @@
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-cpr.h"
> +#include "hw/vfio/pci.h"
> +#include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
>   
> @@ -37,3 +39,32 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>   {
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
> +
> +/*
> + * The kernel may change non-emulated config bits.  Exclude them from the
> + * changed-bits check in get_pci_config_device.
> + */
> +static int vfio_cpr_pci_pre_load(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int size = MIN(pci_config_size(pdev), vdev->config_size);
> +    int i;
> +
> +    for (i = 0; i < size; i++) {
> +        pdev->cmask[i] &= vdev->emulated_config_bits[i];
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vfio_cpr_pci_vmstate = {
> +    .name = "vfio-cpr-pci",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .pre_load = vfio_cpr_pci_pre_load,
> +    .needed = cpr_incoming_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 56e7fdd..840590c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -30,6 +30,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
>   #include "migration/vmstate.h"
> +#include "migration/cpr.h"
>   #include "qobject/qdict.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> @@ -3345,6 +3346,11 @@ static void vfio_pci_reset(DeviceState *dev)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
>   
> +    /* Do not reset the device during qemu_system_reset prior to cpr load */
> +    if (cpr_is_incoming()) {
> +        return;
> +    }
> +
>       trace_vfio_pci_reset(vdev->vbasedev.name);
>   
>       vfio_pci_pre_reset(vdev);
> @@ -3521,6 +3527,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>   #ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>   #endif
> +    dc->vmsd = &vfio_cpr_pci_vmstate;
>       dc->desc = "VFIO-based PCI device assignment";
>       pdc->realize = vfio_realize;
>   


