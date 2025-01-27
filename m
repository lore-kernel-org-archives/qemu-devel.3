Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F68C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcR2w-00006E-12; Mon, 27 Jan 2025 10:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcR2o-0008Ve-Io
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcR2l-0004Ln-J4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737991734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZsVJJ3XAoGKJpfbgFQnJKFr1P5VSiqqKzanllfn5w7g=;
 b=gc+FFMzZTLUB10CmWXf425M09YIasQjYfTBkMCMSPLAsHh0YPFMkIwu3bpe5Ll6m3n/3Mw
 +87L/11zhwpOqd7pGHDa09EnvZDvTzsHED80ZvMQ7vAKlmZdb+OIxRqyOeLfVNruCZ06Ce
 7kyPfxKfsgxKUSBJ6yBEtWdPzWs5vhY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-7riAfJMzNW-N19KOC3DdDA-1; Mon, 27 Jan 2025 10:28:51 -0500
X-MC-Unique: 7riAfJMzNW-N19KOC3DdDA-1
X-Mimecast-MFC-AGG-ID: 7riAfJMzNW-N19KOC3DdDA
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa67855b3deso399221766b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 07:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991730; x=1738596530;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZsVJJ3XAoGKJpfbgFQnJKFr1P5VSiqqKzanllfn5w7g=;
 b=rna2AyfEiYmhbhPi7yKTluEsTehy3Kdb+E1Z3v2Mjbq2x7OOpAl408XEYtLrycA5S6
 VK7xwgCsnL0aqSOy7WnOXyaJc222illteiVrw1MpKCvoPILsiQ+gW/TFm32Y3JnsWrmb
 ptpjry22npvW6tE849WHTm96/LCuqKjFUmN2VB71TXjnMWP0kPNSzpG/7CJiYeshGPJM
 Yt1k6Dopr43MuW2VFqMIRXe1b6oe3nlULIskAy/fmBcFQiI8Xs1iZov7vNVv96v3Lgr6
 UFn47tVINJBloEG0JLuXrpxfl372PDA75oUSUiXiJr5zZgJQEzXE5sOQ9GTTL41u4IUE
 WYUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4nXbMU1qhueesBIKIpnckIaT0Zq4AYfH/QailWgPvaE1kyNWwo5nPRzMTDEBXT7vmLz0JfGU0HVni@nongnu.org
X-Gm-Message-State: AOJu0YwGF1FyAxpIwsdB/FjcnfTlShJJND0XhFxJkeLBgaKZDx6s7UAn
 XqhI+EgYzJmVGa+/LNnrD1A+Qb0hErF7kQ5vtLBUrr17cpNjXwh5cP7pqotaUmHU/jHiJ4aT0Xx
 q/OWpU2C6Ol1MINdiD8D2ksNJMIaYnKlbD8112xzIlmoyfqkvjEXV
X-Gm-Gg: ASbGncs4cmloZEeKxCpC0F9OpgtxMub+jtsY81yRFGothX9oaXhIZm5Z9aHJlRMX1Gz
 W0F5OBFX3tQT5Yyj/mE/6GQC1Y7ip6rWfblTfGf8zBOhk0p5eTxfNCcfsqhwqzmRddtXxvuPU1u
 s2A9rUst+nK1BPfp/RrSnvMZq0mt9CX/pUlbTx67mIRoKHN0ewBr7YmwH6jVtQ8GpLZufCs8k+u
 vSBqLiW/MV7zBgZKZsgyHZntOlZk+N4hcMTW6U/TQbZEkaSjJeU7hLsgA0scIilpq0++vNG08+S
 5enw5UQ6Ul6GF//7Xxi3YeAa6GxrIf06ehkO
X-Received: by 2002:a17:907:969f:b0:aa6:6885:e2f0 with SMTP id
 a640c23a62f3a-ab38b44d488mr3998752066b.46.1737991729893; 
 Mon, 27 Jan 2025 07:28:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWUwtPp4/AMFox6YhE12xKPSH/ABqWK2/YU8SJvtf7EsFVzR/O4Wh1SFZeJ4gXlnV/hT8vLQ==
X-Received: by 2002:a17:907:969f:b0:aa6:6885:e2f0 with SMTP id
 a640c23a62f3a-ab38b44d488mr3998748966b.46.1737991729487; 
 Mon, 27 Jan 2025 07:28:49 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-134.web.vodafone.de.
 [109.42.48.134]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab675e64e9bsm595862666b.46.2025.01.27.07.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 07:28:49 -0800 (PST)
Message-ID: <688893cb-6ebd-4fec-b1a8-2d54d8f9225f@redhat.com>
Date: Mon, 27 Jan 2025 16:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] virtio-mem-pci: Allow setting nvectors, so we can
 use MSI-X
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <20250127142824.494644-1-david@redhat.com>
 <20250127142824.494644-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250127142824.494644-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/01/2025 15.28, David Hildenbrand wrote:
> Let's do it similar as virtio-balloon-pci. With this change, we can
> use virtio-mem-pci on s390x, although plugging will still fail until
> properly wired up in the machine.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/core/machine.c          |  3 +++
>   hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 8f396ef803..5e1d9e12ef 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,9 @@ GlobalProperty hw_compat_9_2[] = {
>       { "virtio-balloon-pci", "vectors", "0" },
>       { "virtio-balloon-pci-transitional", "vectors", "0" },
>       { "virtio-balloon-pci-non-transitional", "vectors", "0" },
> +    { "virtio-mem-pci", "vectors", "0" },
> +    { "virtio-mem-pci-transitional", "vectors", "0" },
> +    { "virtio-mem-pci-non-transitional", "vectors", "0" },

  Hi!

Do we need the entries fo the -transitional and -non-transitional devices? 
Since virtio-mem is rather new, I would expect that those should not exist 
here? E.g. virtio-balloon-pci.c has:

     .transitional_name     = "virtio-balloon-pci-transitional",
     .non_transitional_name = "virtio-balloon-pci-non-transitional",

but there are no such entries in virtio-mem-pci.c ... ?

  Thomas


>   };
>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>   
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> index 1b4e9a3284..6cc5f0fd3b 100644
> --- a/hw/virtio/virtio-mem-pci.c
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -22,6 +22,10 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>       VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
>       DeviceState *vdev = DEVICE(&mem_pci->vdev);
>   
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = 2;
> +    }
> +
>       virtio_pci_force_virtio_1(vpci_dev);
>       qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>   }
> @@ -152,6 +156,13 @@ static void virtio_mem_pci_set_requested_size(Object *obj, Visitor *v,
>       object_property_set(OBJECT(&pci_mem->vdev), name, v, errp);
>   }
>   
> +static const Property virtio_mem_pci_class_properties[] = {
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +};
> +
>   static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -164,6 +175,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
>       pcidev_k->class_id = PCI_CLASS_OTHERS;
> +    device_class_set_props(dc, virtio_mem_pci_class_properties);
>   
>       mdc->get_addr = virtio_mem_pci_get_addr;
>       mdc->set_addr = virtio_mem_pci_set_addr;


