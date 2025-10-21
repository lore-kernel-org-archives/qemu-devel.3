Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14D2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAHZ-0004tz-8d; Tue, 21 Oct 2025 07:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBAHX-0004tP-Fq
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBAHU-0004m9-Do
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761045114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oJht/eNNUAhA/lC+GcZ6c54629ZYU2MlZRk8jY0MdY8=;
 b=HW2PNLVeyn/VY2RsOT9+UV7t6db6ZBY3zrw+T4D6Eo2aI2QBZqNTv23gnpRRWgQrVQbaU0
 IrE9M+o17jwTBUR2TgHKFo2CN3kLFYWPb9+axiw2EucbnixXE2b5zG4Xv3Za/jHUXkHCwE
 lw7X3dG6XPVSdjPB9ZsIVoMP516J3ls=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-LRhQEsa6P4Gxkzj0kJSNnQ-1; Tue, 21 Oct 2025 07:11:52 -0400
X-MC-Unique: LRhQEsa6P4Gxkzj0kJSNnQ-1
X-Mimecast-MFC-AGG-ID: LRhQEsa6P4Gxkzj0kJSNnQ_1761045112
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-891504015e5so54352685a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 04:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761045112; x=1761649912;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJht/eNNUAhA/lC+GcZ6c54629ZYU2MlZRk8jY0MdY8=;
 b=a5b2Wc+903mT79AZj8We0Xp2TU3OBN+0ULBgKgudthdfV0EMuSsqlL/Bjjo98bHfem
 2hkjb/Joc5J7k8J+PLer4kcGtN1gfgvICav8bFGrp/SGwNzsqwiVoKuZxuWK5Q0d76Fu
 yM4BY/oe99Nx5vEYnGnEvMbKqP2lHW4tIbbIzf0wpCtHU8FahjG1rZzK6UtnozsiMwaC
 sUo8ixEyzED1/e0RF+2nvaSrb9i2GTgHIknMQdvmBFI8skhVOQnm/hcZa1gZAGzdBFiY
 SGKnxFlSBBFAOpFFGan6rLeX4FRQdpWK93Vg/imF7VFpCJDOMaCk3AcXf4V7EXCWKJ8g
 XcQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHlD8l4v55QipmV+GoBrbYoQuqFJoXbsETG/ZpjicmVSV1x1SRkdFzZ7nzr/NdDhhtovcPz2yMuL32@nongnu.org
X-Gm-Message-State: AOJu0YygjPEP2M8h83jn3v0osE8yZPlqRaZ6pBCtrN3+xIReB71PAyZR
 0Q6aQxSKs0WtICG5eLyz0iEXInoMrhhiIwsc04bLgnlutF9GYT8TPeIsn3YJAav/T63s/tJ2wI1
 iaLCJ7d/r/Bu/i/+QxVeyH2th0Z4vv0a272h4p8zS3Gcjk81w9R/ZOIC1
X-Gm-Gg: ASbGncuDDcu3fob7+XLKtuYZxx4dKI7dGMizw4XLE1uhuD6uWHo8ul9hI1aeZXbPoSJ
 szviqs+gRnqFPicU3s3d4xKDFprtl+4oCHdLl5JDgBCRRnFHZT3jCqf3u7iQDAAJjxrsywMBl0Q
 /IOgSfJ9k0OKKRet1l+F0/WXvDB+HS+Az+UpLFUpyMeA1eWRa6iaKAlThjBypeWB9o6SVkhfvXU
 XVgOzltbcDc7d4lzEuhO2+tXe2mR0a4c2IKVbFmx6zqjIxy0XARveKt6oIcEcjqK2H5/+TVHy1Z
 5qUHCIZdl7gRyZTMFbg3qdhFX8wlVWjlHsJx8/XlFzCHVaZh+aAu0nuUOdRd0w7B6jG/y1tnKgf
 Ld1OTZdfggPPJULHkzKgBCz+5
X-Received: by 2002:a05:622a:1882:b0:4e8:993f:73bf with SMTP id
 d75a77b69052e-4e89d1dde7amr197596481cf.10.1761045111985; 
 Tue, 21 Oct 2025 04:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ulGW96XPj/JjucXkAOKkbCWimqoSDazNjEVMxAfiiIYiwfj2wr/rKXvLbwRNWeu2EhH95g==
X-Received: by 2002:a05:622a:1882:b0:4e8:993f:73bf with SMTP id
 d75a77b69052e-4e89d1dde7amr197596221cf.10.1761045111597; 
 Tue, 21 Oct 2025 04:11:51 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8ab0f3b1dsm71103601cf.32.2025.10.21.04.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 04:11:51 -0700 (PDT)
Message-ID: <6dd2f652-5b20-4472-9c9c-0ab451ecffea@redhat.com>
Date: Tue, 21 Oct 2025 13:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-6-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020162023.3649165-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Enable virt-queue PCI configuration and add routines for virtio-blk-pci devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 1c1017a0db..4e4a7280b6 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -259,6 +259,7 @@ struct VDev {
>       uint8_t scsi_dev_heads;
>       bool scsi_device_selected;
>       ScsiDevice selected_scsi_device;
> +    uint32_t pci_fh;
>       uint32_t max_transfer;
>       uint32_t guest_features[2];
>   };
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 7299b8911f..69e7d39862 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -15,8 +15,10 @@
>   #include "s390-arch.h"
>   #include "s390-ccw.h"
>   #include "cio.h"
> +#include "clp.h"
>   #include "virtio.h"
>   #include "virtio-scsi.h"
> +#include "virtio-pci.h"
>   #include "dasd-ipl.h"
>   
>   SubChannelId blk_schid = { .one = 1 };
> @@ -150,6 +152,20 @@ static bool find_subch(int dev_no)
>       return false;
>   }
>   
> +static bool find_fid(uint32_t fid) {

Put the curly bracket into the next line, please.

> +    ClpFhListEntry entry;
> +    VDev *vdev = virtio_get_device();
> +
> +    if (find_pci_function(fid, &entry)) {
> +        return false;
> +    }
> +
> +    vdev->pci_fh = entry.fh;
> +    virtio_pci_id2type(vdev, entry.device_id);
> +
> +    return (vdev->type != 0);

You could drop the braces here.

> +}
> +
...
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> new file mode 100644
> index 0000000000..b6cb4a661a
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -0,0 +1,357 @@
> +/*
> + * Functionality for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include "helper.h"
> +#include "s390-ccw.h"
> +#include "virtio.h"
> +#include "bswap.h"
> +#include "virtio-pci.h"
> +#include "s390-time.h"
> +#include <stdio.h>
> +
> +/* Variable offsets used for reads/writes to modern memory region BAR 4 */
> +uint32_t common_offset;
> +uint32_t device_offset;
> +uint32_t notify_offset;
> +uint32_t notify_mult;
> +uint16_t q_notify_offset;
> +
> +static int virtio_pci_set_status(VDev *vdev, uint8_t status)
> +{
> +    uint64_t status64 = status;
> +
> +    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_STATUS, status64, 1);
> +}
> +
> +static int virtio_pci_get_status(VDev *vdev, uint8_t *status)
> +{
> +    uint64_t status64;
> +    int rc;
> +
> +    rc = pci_read(vdev->pci_fh, VPCI_C_OFFSET_STATUS, 4, &status64, 1);
> +    if (rc) {
> +        puts("Failed to read virtio-pci status");
> +        return rc;
> +    }
> +
> +    *status = (uint8_t) status64;

Ok, so after reading this code, I realized that pci_read is definitely only 
supposed to work on 64-bit values.

Could you please change the "buf" parameter of pci_read() from "void *" to 
"uint64_t *", otherwise this is super-confusing.

> +    return 0;
> +}
> +
> +static int virtio_pci_get_hfeatures(VDev *vdev, uint64_t *features)
> +{
> +    uint64_t feat0, feat1;
> +    uint32_t selector;
> +    int rc;
> +
> +    selector = bswap32(0);
> +    rc = pci_write(vdev->pci_fh, VPCI_C_OFFSET_DFSELECT, selector, 4);
> +    rc |= pci_read(vdev->pci_fh, VPCI_C_OFFSET_DF, 4, &feat0, 4);
> +    feat0 = bswap32(feat0);
 > +> +    selector = bswap32(1);
> +    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_DFSELECT, selector, 4);
> +    rc |= pci_read(vdev->pci_fh, VPCI_C_OFFSET_DF, 4, &feat1, 4);
> +    feat1 = bswap32(feat1);
> +> +    *features = feat1 << 32;
> +    *features |= feat0;
> +
> +    return rc;
> +}
> +
> +static int virtio_pci_set_gfeatures(VDev *vdev)
> +{
> +    uint64_t feats;
> +    uint32_t selector;
> +    int rc;
> +
> +    selector = bswap32(0);
> +    rc = pci_write(vdev->pci_fh, VPCI_C_OFFSET_GFSELECT, selector, 4);
> +
> +    feats = bswap32((uint64_t)vdev->guest_features[1]);

The cast to 64-bit does not make sense here.

> +    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_GF, feats, 4);
> +
> +    selector = bswap32(1);
> +    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_GFSELECT, selector, 4);
> +
> +    feats = bswap32((uint64_t)vdev->guest_features[0]);

dito

> +    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_GF, feats, 4);
> +
> +    return rc;
> +}
> +
> +static int virtio_pci_get_blk_config(VDev *vdev)
> +{
> +    return pci_read(vdev->pci_fh, device_offset, 4, (uint64_t *)&vdev->config.blk,
> +                    sizeof(VirtioBlkConfig));
> +

Please remove the empty line.

> +}
> +
> +int virtio_pci_set_selected_vq(VDev *vdev, uint16_t queue_num)
> +{
> +    uint16_t le_queue_num;
> +
> +    le_queue_num = bswap16(queue_num);
> +    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_Q_SELECT, (uint64_t)le_queue_num, 2);

The "(uint64_t)" is not required here, I think.

> +}
> +
> +int virtio_pci_set_queue_size(VDev *vdev, uint16_t queue_size)
> +{
> +    uint16_t le_queue_size;
> +
> +    le_queue_size = bswap16(queue_size);
> +    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_Q_SIZE, (uint64_t)le_queue_size, 2);

dito

> +}
> +
> +static int virtio_pci_set_queue_enable(VDev *vdev, uint16_t enabled)
> +{
> +    uint16_t le_enabled;
> +
> +    le_enabled = bswap16(enabled);
> +    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_Q_ENABLE, (uint64_t)le_enabled, 2);

dito

> +}
> +
> +static int set_pci_vq_addr(VDev *vdev, void* addr, uint64_t config_offset_lo)
> +{
> +    uint32_t le_lo, le_hi;
> +    uint32_t tmp;
> +    int rc;
> +
> +    tmp = (uint32_t)(((uint64_t)addr) >> 32);
> +    le_hi = bswap32(tmp);
> +
> +    tmp = (uint32_t)((uint64_t)addr & 0xFFFFFFFF);
> +    le_lo = bswap32(tmp);
> +
> +    rc =  pci_write(vdev->pci_fh, config_offset_lo, (uint64_t)le_lo, 4);
> +    rc |=  pci_write(vdev->pci_fh, config_offset_lo + 4, (uint64_t)le_hi, 4);

Wouldn't it be possible bswap64() the value and write all 8 bytes at once?

> +    return rc;
> +}
> +
> +/* virtio spec v1.1 para 4.1.2.1 */
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
> +{
> +    switch(device_id) {
> +    case 0x1001:
> +        vdev->type = VIRTIO_ID_BLOCK;
> +        break;
> +    case 0x1000: /* Other valid but currently unsupported virtio device types */
> +    case 0x1004:
> +    default:
> +        vdev->type = 0;
> +    }
> +}
> +
> +/*
> + * Read PCI configuration space to find the offset of the Common, Device, and
> + * Notification memory regions within the modern memory space.
> + * Returns 0 if success, 1 if a capability could not be located, or a
> + * negative RC if the configuration read failed.
> + */
> +static int virtio_pci_read_pci_cap_config(VDev *vdev)
> +{
> +    uint8_t pos;
> +    uint64_t data;
> +
> +    /* Common cabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_COMMON_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI common configuration");
> +        return 1;
> +    }
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    common_offset = bswap32(data);
> +
> +    /* Device cabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_DEVICE_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI device configuration");
> +        return 1;
> +    }
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    device_offset = bswap32(data);
> +
> +    /* Notification cabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_NOTIFY_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI notification configuration");
> +        return 1;
> +    }
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    notify_offset = bswap32(data);
> +
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_NOTIFY_CAP_MULT, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    notify_mult = bswap32(data);
> +
> +    if (pci_read(vdev->pci_fh, device_offset + VPCI_C_OFFSET_Q_NOFF, 4, &data, 2)) {
> +        return -EIO;
> +    }
> +    q_notify_offset = bswap16(data);

After reading all this code, I wonder whether it would make sense to have 
proper pci_read16(), pci_read32() and pci_read64() functions that do also 
the byte-swapping for you and operate on the right size of variable size?

> +    return 0;
> +}
> +
> +int virtio_pci_reset(VDev *vdev)
> +{
> +    int rc;
> +    uint8_t status = VPCI_S_RESET;
> +
> +    rc = virtio_pci_set_status(vdev, status);
> +    rc |= virtio_pci_get_status(vdev, &status);
> +
> +    if (rc || status) {
> +        puts("Failed to reset virtio-pci device");
> +        return 1;

Maybe nicer to return a negative error code (-1 if nothing else fits)?

> +    }
> +
> +    return 0;
> +}


  Thomas



