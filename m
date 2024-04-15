Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FDAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIZ7-0003Ej-Og; Mon, 15 Apr 2024 05:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIZ5-0003Db-U0
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:23:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIZ4-0001Lt-6J
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:23:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34641b7c49aso2306251f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713173028; x=1713777828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sh52fWPmuVvljHP9tjTMGT8PFSFV4f9Aob3B/cEJbrU=;
 b=T0D1uZDxjgvBLa90AdFzZtCsL64UC4VCB4n6dZPCSYHciqC8vF5E+PMDTz1Gre033r
 j62ndpysBuwGdwGEXXBOUSxmZwO+QatfKAl+YT0qMy37prtQX/EyuU6D5/1TjNRxUXut
 KuZyCQnx0vZ2OSMlHB58pqR54Kf5D8TnPNXeLWSYlwvrQyusCqbreDEJ6xZd2c6C1SWi
 3JWrXah9hQ6RlyN2vWoZxIv57yE6K5dRzwA4qAlg4H7g/YCEmBUUEcVGBxbeQGEo/idi
 PkURC/ynuKXqC0daKdj73MNI25lB4+cbCk5qwGdxxxXXhTbHre19K0ETujrDtHz+J76N
 2gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173028; x=1713777828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sh52fWPmuVvljHP9tjTMGT8PFSFV4f9Aob3B/cEJbrU=;
 b=L8jYogZvRusAzvnpMyWM0bhAGUlBjV1MMJWp8uX1taItwav7jXwOySbDnUaUo9dxKw
 mtu1SiddSTOwvfI4iU6l6o1vEeXFRRQV2d6LhAf0LQdhPa9H/fk0jRmuiqfQ/B3EMWhs
 b33gYapXTU/MfYx0SSwYtATm9Eh4Bxl4W9tWRPyCSC2VTYSmrIIBS8vP4RYRMUCyB6Oe
 jnSLI3oPZp1Ku2mxwq3hS/1RIANNo0aSKxfiAbxAfATGdrKsKicwySr+g6v5Va22SuKI
 /FfMjm9dSOYzwPrdUCZzIhjJ761dTFhQ+oUIJdSLZvDy3lwxwHnDHanYOIMMJWxm2MQ0
 1nNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrJDn1UJ3m0iNHK/KEtWTeoG41ppHIEETqFhHbxRzwXL9dGpBJDmUtabIZqx0W9i1W6bU6XtoFNCE4VDGZrMFbtPP86GQ=
X-Gm-Message-State: AOJu0YyN7AXrVDi6Yt3/U2sFJ6s6HNRaTkMfZOKMrujmeR9wDHMif/Q1
 3kQOh5waNmSGAXKlr1MUeGhy2bfbdX43diglRNsTUQjt1rnkD5HrY7D6T37Ld90=
X-Google-Smtp-Source: AGHT+IH++h8PF2wwn26EkID+nzE4hbfdUnRB6TAHhWA/Aan9yU7Gd2Wb1VSsDjCYzivEeOXf99u0JA==
X-Received: by 2002:a5d:584a:0:b0:341:aec7:c583 with SMTP id
 i10-20020a5d584a000000b00341aec7c583mr7212380wrf.53.1713173028183; 
 Mon, 15 Apr 2024 02:23:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a5d6842000000b00343c9ce4b50sm11552878wrw.53.2024.04.15.02.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:23:47 -0700 (PDT)
Message-ID: <133af310-c3ea-4b2f-b4d9-846cc0684710@linaro.org>
Date: Mon, 15 Apr 2024 11:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] virtio-pci: Fix the crash that the vector was used
 after released.
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Cindy Lu <lulu@redhat.com>, qemu-stable@nongnu.org,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <a3612104baa9fe72d9e3182e3d108bff96a9ddf4.1713172726.git.mst@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a3612104baa9fe72d9e3182e3d108bff96a9ddf4.1713172726.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/4/24 11:19, Michael S. Tsirkin wrote:
> From: Cindy Lu <lulu@redhat.com>
> 
> During the booting process of the non-standard image, the behavior of the
> called function in qemu is as follows:
> 
> 1. vhost_net_stop() was triggered by guest image. This will call the function
> virtio_pci_set_guest_notifiers() with assgin= false,
> virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0
> 
> 2. virtio_reset() was triggered, this will set configure vector to VIRTIO_NO_VECTOR
> 
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() with
> assgin=true, so the irqfd for vector 0 is still not "init" during this process
> 
> 4. The system continues to boot and sets the vector back to 0. After that
> msix_fire_vector_notifier() was triggered to unmask the vector 0 and  meet the crash
> 
> To fix the issue, we need to support changing the vector after VIRTIO_CONFIG_S_DRIVER_OK is set.


> MST: coding style and typo fixups
> 
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> To expedite fixed lots of style issues myself.
> Completely untested - guys can you pls test and ack?
> 
> 
>   hw/virtio/virtio-pci.c | 41 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb6940fc0e..e9edd57339 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1424,6 +1424,34 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>       return offset;
>   }
>   
> +static void virtio_pci_set_and_change_vector(VirtIODevice *vdev,
> +                                             VirtIOPCIProxy *proxy,
> +                                             int queue_no, uint16_t old_vector,
> +                                             uint16_t new_vector)
> +{

Alternatively:

        if (new_vector == old_vector) {
            return;
        }

> +    bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +
> +    /*
> +     * If the device uses irqfd and the vector changes after DRIVER_OK is
> +     * set, we need to release the old vector and set up the new one.
> +     * Otherwise just need to set the new vector on the device.
> +     */
> +    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> +    }
> +    /* Set the new vector on the device. */
> +    if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
> +        vdev->config_vector = new_vector;
> +    } else {
> +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> +    }
> +    /* If the new vector changed need to set it up. */
> +    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> +    }
> +}
> +
>   int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>                              uint8_t bar, uint64_t offset, uint64_t length,
>                              uint8_t id)
> @@ -1570,7 +1598,12 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>           } else {
>               val = VIRTIO_NO_VECTOR;
>           }
> -        vdev->config_vector = val;
> +        vector = vdev->config_vector;
> +        /* Check if we need to change the vector. */
> +        if (val != vector) {
> +            virtio_pci_set_and_change_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> +                                             vector, val);
> +        }
>           break;


