Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525D2C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiJH-0001ul-Al; Fri, 17 Jan 2025 04:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiJF-0001ts-G0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiJC-0000XM-WD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lVApERT39wl0qD/0OqshEgsuSHUoeIxyApF+WoO6CIM=;
 b=HoBaZSbZbk9EGNzeiQYErn8OYD/LgW5dq3PzETp2pj7YcgtMVV510Irtj8Iya2qukREn3m
 4TllTt9IbcqXw2EkKUorOPkvr+ngz/mv86miLK2IIewrS/HlWN+DWA46AqGkFj22mXf5Kx
 uk0qzzgEe9B+4aZRttxZZeyy5fNlotI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-Xi2NjsddNc2ZQV4MMH4aQw-1; Fri, 17 Jan 2025 04:06:25 -0500
X-MC-Unique: Xi2NjsddNc2ZQV4MMH4aQw-1
X-Mimecast-MFC-AGG-ID: Xi2NjsddNc2ZQV4MMH4aQw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so8955245e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104784; x=1737709584;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVApERT39wl0qD/0OqshEgsuSHUoeIxyApF+WoO6CIM=;
 b=NVLk9kasyozFTPY/asqXpB3AbW8cK3FleZv03OH6jMMkX8/SrOGOSbImems00kOHvf
 4iEIxGO1j3EwdmZP1ILpwh+dh/KPZbMe/DY/mjjxz0LEkqtbHjje8p8C9/R/IXN6EZgd
 vt9qUbKY3hfwFElMHRebQMzH91AgkvhpLYSn+lOS0Pd6PQys7/di1VmEPFkip4JXWvW0
 N9bZVgXkF8QGL1hjY+TMhLN36+B5NVcC10tzrBz31PgsAnYih3fBQ097fsspUZGhsUt2
 famATipp67E2rbn0Bp85w3PkPvsh9pUsG5eZMp/JYGBYgLi84ua+JgnsQQzmy0div7zt
 mppQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBZI17xjsSG4GkpH+4Irsaz6TGLRdSYQFqcQEYPksGYnkptvjxfcZmqPqANsw1x/9rezjq9qDAZOwo@nongnu.org
X-Gm-Message-State: AOJu0Yzu+Hk8uRhn4IB8ItdYnNKV/DD+mtAOUuJSMWN+3hyHxIikjPbJ
 N3MaA0UV1P+UULJkIc1S+F2AG+D9fbONc+2P5ZW5lZBvr5AhQSAihz0XdLUZDKFJwK2bP7NQarh
 kEw/qsVoGDwF3Ce4e7w0r9sG1PkbBKVq9/EXMQwJI8MwbdpB2nujj
X-Gm-Gg: ASbGnctUoPF0vFkK26IrNLk2sPp8PPqvvaqRH37s6wsuRg+9itFvMrMEc8e59Va1vPA
 D+LuKMUT8wYOFIHpfgdu3b53+IGWs3Gx3X2IV6VoiJmDmcpMm9lJd0rtaATwQsYj+ioxhS5V8Rq
 TYWOA/yVLvqT5A9gdrFR2+L7APCkRsPvBDQqFiRL8Tpfi8KoRNmiKvRy5+ZdRWc1+4KXSAEClxR
 +rlk4gR1nBD9ieLiSuxsdE/nYTl1No7S1Mcr192J62kJtVPo/IWx9CK1tc6p1O7wO4C3PDVTxEL
 WUBiiur6+G5H
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr19803595e9.0.1737104784288; 
 Fri, 17 Jan 2025 01:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMNPC8xFm6gdUYYFR9zvZDGAmss8xYO8I0hGiZcLTUJVBk69m9QEqvC70WcInEQ87f4Ufjqg==
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr19803155e9.0.1737104783916; 
 Fri, 17 Jan 2025 01:06:23 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f603sm26525325e9.21.2025.01.17.01.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:06:23 -0800 (PST)
Message-ID: <1f4f420a-0f29-4eae-88e5-0bb100536d63@redhat.com>
Date: Fri, 17 Jan 2025 10:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-10-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> VIRTIO_PCI_FLAG_MIGRATE_EXTRA was only used by the
> hw_compat_2_4[] array, via the 'migrate-extra=true'
> property. We removed all machines using that array,
> lets remove all the code around VIRTIO_PCI_FLAG_MIGRATE_EXTRA.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-pci.h |  4 ----
>   hw/virtio/virtio-pci.c         | 10 ----------
>   2 files changed, 14 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 971c5fabd44..dd6eb9a4fc7 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -32,7 +32,6 @@ DECLARE_OBJ_CHECKERS(VirtioPCIBusState, VirtioPCIBusClass,
>   enum {
>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
> -    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT,
>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>       VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
>       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
> @@ -57,9 +56,6 @@ enum {
>   /* virtio version flags */
>   #define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
>   
> -/* migrate extra state */
> -#define VIRTIO_PCI_FLAG_MIGRATE_EXTRA (1 << VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT)
> -
>   /* have pio notification for modern device ? */
>   #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
>       (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c773a9130c7..8dca3ae73e6 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -144,13 +144,6 @@ static const VMStateDescription vmstate_virtio_pci = {
>       }
>   };
>   
> -static bool virtio_pci_has_extra_state(DeviceState *d)
> -{
> -    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> -
> -    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
> -}
> -
>   static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
>   {
>       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> @@ -2352,8 +2345,6 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
>   static const Property virtio_pci_properties[] = {
>       DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
> -    DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
> -                    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
>       DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
>       DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
> @@ -2601,7 +2592,6 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>       k->load_queue = virtio_pci_load_queue;
>       k->save_extra_state = virtio_pci_save_extra_state;
>       k->load_extra_state = virtio_pci_load_extra_state;
> -    k->has_extra_state = virtio_pci_has_extra_state;

Did you test your patches? Looking at the calling site:

static bool virtio_extra_state_needed(void *opaque)
{
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);

     return k->has_extra_state &&
         k->has_extra_state(qbus->parent);
}

... this will return now false instead of true, so I think your patch here 
is wrong?

  Thomas


