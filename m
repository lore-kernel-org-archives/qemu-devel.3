Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7E5C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKlJ-0003kP-Us; Tue, 20 Feb 2024 02:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcKlI-0003kF-Dj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcKlG-0004SW-SZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708414913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibYKFBIPB3VJtsqJQyuTKiJngI9WySv131o02CQwbNw=;
 b=PzVA4QvoNNX3D7sRxjQIbDERbiOz3mTkUw27rzrAjaE0jCgWJraqdEsUonsRNhQ4cBgrck
 ou83NIHkHwgeBomIZVs8X4V0kiMDJkjXCnO02hQwrQ0csUwP82ylFyLLTKFOATQ9UJ1txL
 /ZkSoqw3zyLR25vG5Ur+IoMqjnksIas=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-nl5NYYdsOj2qdo0yWuZaTA-1; Tue, 20 Feb 2024 02:41:49 -0500
X-MC-Unique: nl5NYYdsOj2qdo0yWuZaTA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d10bd57d7so1582837f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708414908; x=1709019708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibYKFBIPB3VJtsqJQyuTKiJngI9WySv131o02CQwbNw=;
 b=sFbVwamc74xPUGtPRL4783wCrPvyVyNEWKElS0W3qlENLuP+MYS+koPG/FEu3J/WA8
 A8ZTbHv78U4CaTUmQoh3jOqMEBpRiSdAVNkVV3vKXqZ7XBm4IikKW8NN64lr2Vqkha2M
 taOgtX1Zcop30wxfOeGfhnYThqacI+p1x5z25+0X39r5iBJu15CShsqfZNs5lKN+0Vyl
 1ZYU4kJU9WmMWChm/096QjVm8W6GE8t0e9D8hk7NPTA30VvC7JG/LyzbrJojzZhh2QzR
 4dxmi3cw85FONM+lrdi+vezNRnJnL3k6/WDRAVO7n00KVb1ROHjbh0apI0DCNz7rdQ4V
 /AIg==
X-Gm-Message-State: AOJu0Yyr6HB2ZYK/ETpOd+SA2614SdBBcbAlphOd9wZD26vyFzfyeHty
 /fG/4Z/ufqiH+e2Iz3u0Y0FZ8yfxDnu/jPKqHtptBnusZXLEULqqJy9RYO1Uqa5I0U3BLFtOev6
 qlB4IoHhhNoAM8ngqwH4wU5XnxSzCwg9aFBpdTcChZQJBl0Y+Zk/R
X-Received: by 2002:a5d:68d1:0:b0:33d:2065:c6ca with SMTP id
 p17-20020a5d68d1000000b0033d2065c6camr6797262wrw.7.1708414908184; 
 Mon, 19 Feb 2024 23:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHhm+aAQSN7RXLzJe3ZIhaGU4ZeYoHzFRkvVcwZF6ajg7lY56N1V6rT5l+JRiJ1U9BBekDTQ==
X-Received: by 2002:a5d:68d1:0:b0:33d:2065:c6ca with SMTP id
 p17-20020a5d68d1000000b0033d2065c6camr6797250wrw.7.1708414907814; 
 Mon, 19 Feb 2024 23:41:47 -0800 (PST)
Received: from redhat.com ([2.52.25.217]) by smtp.gmail.com with ESMTPSA id
 s8-20020adf9788000000b0033ae7d768b2sm12613046wrb.117.2024.02.19.23.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 23:41:47 -0800 (PST)
Date: Tue, 20 Feb 2024 02:41:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: qemu-devel@nongnu.org, vattunuru@marvell.com, jerinj@marvell.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] virtio-pci: correctly set virtio pci queue mem
 multiplier
Message-ID: <20240220024043-mutt-send-email-mst@kernel.org>
References: <20240220070935.1617570-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220070935.1617570-1-schalla@marvell.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 12:39:35PM +0530, Srujana Challa wrote:
> Currently, virtio_pci_queue_mem_mult function always returns 4K
> when VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't
> work for vhost vdpa when host has page size other than 4K.
> This patch introduces a new property(page-per-vdpa-vq) for vdpa
> use case to fix the same.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
> v1->v2:
> - Introduced a new property to get virtqueue mem multiplier for
>   vdpa use case.


OK, I would maybe call it host-page-per-vq?

Jason?

>  hw/virtio/virtio-pci.c         | 10 ++++++++--
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..28dd6ab8b5 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -320,8 +320,12 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
>  
>  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
>  {
> -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> +    else if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ)
> +        return qemu_real_host_page_size();
> +    else
> +        return 4;
>  }
>  
>  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
> @@ -2301,6 +2305,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_AER_BIT, false),
> +    DEFINE_PROP_BIT("page-per-vdpa-vq", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 59d88018c1..10a30c26a2 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -43,6 +43,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> +    VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -89,6 +90,10 @@ enum {
>  #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
>    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
>  
> +/* page per vdpa vq flag to be used for vhost vdpa backends */
> +#define VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ \
> +    (1 << VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT)
> +
>  typedef struct {
>      MSIMessage msg;
>      int virq;
> -- 
> 2.25.1


