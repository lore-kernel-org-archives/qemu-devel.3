Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F03C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBv6d-00047W-Qm; Mon, 05 May 2025 08:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBv6X-000470-0b
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBv6T-0003qo-Hc
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746448763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UY6v7K5lIeCqqbykF6PuVozBa7tC/sJmt/y3MfEDTgo=;
 b=YVCBqE6MVFyAQQbc+x0ZNrm0owMqLWCPv7A9k4g8lrzS6ORY7XjIR9ltI0lRWxgk5fcowe
 zswCjjGkWBL5QINcPRqTUydbnIbVWhGJz6nBQdln2zSAD13/il2cKefxaBEUotGM95jogF
 CZaDDXv9jgALY4J8O+BmhhnhnL/mna8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-ifim4g8xPuuTufnEmUKR1w-1; Mon, 05 May 2025 08:39:22 -0400
X-MC-Unique: ifim4g8xPuuTufnEmUKR1w-1
X-Mimecast-MFC-AGG-ID: ifim4g8xPuuTufnEmUKR1w_1746448761
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d01024089so28524895e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746448761; x=1747053561;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UY6v7K5lIeCqqbykF6PuVozBa7tC/sJmt/y3MfEDTgo=;
 b=JoFG0890KL4QGb2/13ZFt8Qwl5cX4RmM4LCtf3R/ETqQF+fPGgV7yNzLpeujLHjPJO
 eI19cecqLQEK2l8J++6RSHALuChwXYgvI8mp9gKIr7C72ZPJXZUGt4kDfDCZpS6yZhL0
 S0d/4rIZINWp4fPA0vRfcvnTR5q56PNieYHLAFGZrFMas+/ixhu7RFBaVrklDYLB+cV4
 op+9vh8keJb/rosIewtIZeEbEesNpmXYztWGRSMf1tAZvwA1n8sLRl7Gh6/KgKX+4eNo
 uOS/vQbUCNRiDJeBO4YoS29pdebNrF5OHluz4PAjrvuC7wFOG8PA2u93cx3SFlyX0N7K
 3yZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuKjOvyxc4ththerTLdLoGLob+1WzMWRgsChVcem5a2AeF6oy/uEvOaLlxzp7vN/YrgVtqBF7Zd31w@nongnu.org
X-Gm-Message-State: AOJu0YxCtehvw/d2XWFsv5ABpZfCxOI7NLJODVHrvf7G9WUia+4QmJ+n
 28TzYKVrWJTPkZpV9WiDTIwuMcnPmbk4vEq+cZGREoCcNpiSL0jVpnJyNRQLCGfnxHQgZzpFREN
 uJFVG79h2AM64/yHAPbowmivb589uaL+/6s+uMiuZALmQ/2UdkPfm
X-Gm-Gg: ASbGncsc2ztfusLzVWL6GHkbLTxVlKRXUOg3ffA2c03gsqqf7YutI40Ee0Gt4IvXSvT
 LzCyD3LbE+uIovAMnLHk0D2Hoe981B2p6jCuYC0rr76b7t6oVCPe2m5f5ygqmFfC7sovwwoPYt5
 GvqK/AhBuikfU/+04v/Mpz/Knwh99It+sWBgdg/ibf6pvac9BzNl6nDjHu46Y3ZWBl4easFHsoV
 CRbViDJyBrvW2ilO2Sb6P8ELow3O9pTBYGEFEqsWvHJyK5HnhJjrgP64xBjoDLIHy/nw42qzn40
 ygmh5eMBrDTACTUzlCGSFHJx6pArN2IeTtlXTI2C3h/xZ0qHgg==
X-Received: by 2002:a05:600c:c85:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-441c48af1dcmr55863805e9.1.1746448761256; 
 Mon, 05 May 2025 05:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMFAWr/C6UkHhU9RrujOlVrBsK5aBR5A2XL6LYt+qsMbMpKgK7TCkyVMV4dKRzL98IpTqM7Q==
X-Received: by 2002:a05:600c:c85:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-441c48af1dcmr55863535e9.1.1746448760848; 
 Mon, 05 May 2025 05:39:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af306bsm180227355e9.21.2025.05.05.05.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:39:20 -0700 (PDT)
Message-ID: <b573f499-4083-4aac-9ee0-04e6028e4cf3@redhat.com>
Date: Mon, 5 May 2025 14:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] vfio: add read/write to device IO ops vector
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
 <20250430194003.2793823-13-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-13-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/30/25 21:40, John Levon wrote:
> Now we have the region info cache, add ->region_read/write device I/O
> operations instead of explicit pread()/pwrite() system calls.
> ---
>   hw/vfio/device.c              | 38 +++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c                 | 28 +++++++++++++-------------
>   hw/vfio/region.c              | 17 ++++++++++------
>   include/hw/vfio/vfio-device.h | 18 +++++++++++++++++
>   4 files changed, 81 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d08c0ab536..ceb7bbebda 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -510,9 +510,47 @@ static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
>       return ret < 0 ? -errno : ret;
>   }
>   
> +static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
> +                                      off_t off, uint32_t size, void *data)
> +{
> +    struct vfio_region_info *info = vbasedev->reginfo[index];

Why not rely on vfio_device_get_region_info() to fill the cache and
return the cached struct vfio_region_info ?

> +    int ret;
> +
> +    if (info == NULL) {
> +        ret = vfio_device_get_region_info(vbasedev, index, &info);
> +        if (ret != 0) {
> +            return ret;
> +        }
> +    }
> +
> +    ret = pread(vbasedev->fd, data, size, info->offset + off);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
> +                                       off_t off, uint32_t size, void *data)
> +{
> +    struct vfio_region_info *info = vbasedev->reginfo[index];

same here.

The rest looks good.


Thanks,

C.



> +    int ret;
> +
> +    if (info == NULL) {
> +        ret = vfio_device_get_region_info(vbasedev, index, &info);
> +        if (ret != 0) {
> +            return ret;
> +        }
> +    }
> +
> +    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
>   static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .device_feature = vfio_device_io_device_feature,
>       .get_region_info = vfio_device_io_get_region_info,
>       .get_irq_info = vfio_device_io_get_irq_info,
>       .set_irqs = vfio_device_io_set_irqs,
> +    .region_read = vfio_device_io_region_read,
> +    .region_write = vfio_device_io_region_write,
>   };
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1aeb4d91d2..5e811d5d6a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -918,18 +918,22 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       memset(vdev->rom, 0xff, size);
>   
>       while (size) {
> -        bytes = pread(vbasedev->fd, vdev->rom + off,
> -                      size, vdev->rom_offset + off);
> +        bytes = vbasedev->io_ops->region_read(vbasedev,
> +                                              VFIO_PCI_ROM_REGION_INDEX,
> +                                              off, size, vdev->rom + off);
> +
>           if (bytes == 0) {
>               break;
>           } else if (bytes > 0) {
>               off += bytes;
>               size -= bytes;
>           } else {
> -            if (errno == EINTR || errno == EAGAIN) {
> +            if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %m");
> +            error_report("vfio: Error reading device ROM: %s",
> +                         strreaderror(bytes));
> +
>               break;
>           }
>       }
> @@ -969,22 +973,18 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
>                                         uint32_t size, void *data)
>   {
> -    ssize_t ret;
> -
> -    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> -
> -    return ret < 0 ? -errno : (int)ret;
> +    return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
> +                                              VFIO_PCI_CONFIG_REGION_INDEX,
> +                                              offset, size, data);
>   }
>   
>   /* "Raw" write of underlying config space. */
>   static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
>                                          uint32_t size, void *data)
>   {
> -    ssize_t ret;
> -
> -    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> -
> -    return ret < 0 ? -errno : (int)ret;
> +    return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
> +                                               VFIO_PCI_CONFIG_REGION_INDEX,
> +                                               offset, size, data);
>   }
>   
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ef2630cac3..34752c3f65 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -45,6 +45,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           uint32_t dword;
>           uint64_t qword;
>       } buf;
> +    int ret;
>   
>       switch (size) {
>       case 1:
> @@ -64,11 +65,13 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           break;
>       }
>   
> -    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
> +    ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
> +                                         addr, size, &buf);
> +    if (ret != size) {
>           error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
> -                     ",%d) failed: %m",
> +                     ",%d) failed: %s",
>                        __func__, vbasedev->name, region->nr,
> -                     addr, data, size);
> +                     addr, data, size, strwriteerror(ret));
>       }
>   
>       trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> @@ -96,11 +99,13 @@ uint64_t vfio_region_read(void *opaque,
>           uint64_t qword;
>       } buf;
>       uint64_t data = 0;
> +    int ret;
>   
> -    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
> -        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
> +    ret = vbasedev->io_ops->region_read(vbasedev, region->nr, addr, size, &buf);
> +    if (ret != size) {
> +        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
>                        __func__, vbasedev->name, region->nr,
> -                     addr, size);
> +                     addr, size, strreaderror(ret));
>           return (uint64_t)-1;
>       }
>       switch (size) {
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index b4a28c2a54..d3ab13ca6a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -178,6 +178,24 @@ struct VFIODeviceIOOps {
>        * Configure IRQs as defined by @irqs.
>        */
>       int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
> +
> +    /**
> +     * @region_read
> +     *
> +     * Read @size bytes from the region @nr at offset @off into the buffer
> +     * @data.
> +     */
> +    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> +                       void *data);
> +
> +    /**
> +     * @region_write
> +     *
> +     * Write @size bytes to the region @nr at offset @off from the buffer
> +     * @data.
> +     */
> +    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> +                        void *data);
>   };
>   
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,


