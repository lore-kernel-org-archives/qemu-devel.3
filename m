Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1EFC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOkF-0003fn-7Y; Fri, 23 Feb 2024 01:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rdOkA-0003fR-EZ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:09:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rdOk8-0006Ke-Cn
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708668547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCMVUZ+45b/Z7/Qm3YQyYtcJYyWifBqUef0wO34Ua9w=;
 b=Jd66jqNwN6UwHdCZCu5fK1Sq4MGL2H5pI0U2eLmV/3JiUzNbF3XEVov8fsoDCUnuQHTQLn
 1mxHpHZ0WZsyUJbjPJszPtwuAzIuM8M6Ico3/fHC3D70yAVn2VyjuSARVbP8H9O1zaYwjy
 d5ZgTgH2TkZ0Z4/BGZ2RUJHWa5ruQp0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-QILXHr_ePn28tLcBLtvekA-1; Fri, 23 Feb 2024 01:09:05 -0500
X-MC-Unique: QILXHr_ePn28tLcBLtvekA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d230281e64so4123411fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708668544; x=1709273344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCMVUZ+45b/Z7/Qm3YQyYtcJYyWifBqUef0wO34Ua9w=;
 b=pUR3kzS5RZKbWFTp9j4TxMnz46LHEAGuujL3+3RD/1iJ5PCcNOAtwJ7M4FiVdk6WuV
 Z5HsTei1oxXa0ZmUFnyCw8/o5INVh9b2bliWZ4G8Q2OT6GtvxSZy2Vqj0ee8BW44pVKA
 5g7G1GY5VZ04wAajqz/KQ54EkrjXwOA3rnB3Li/ln9kn1wFy/TstkPjtl2MxZOxgjKOf
 R+yroegMVZqBRQLkJFmuTSmekponh5vkEqptIiu5ZFGVNr1ccj3P3ISv8rOdme0SlzTL
 zFSiQm3f9TTO5izr99VydDhk3gmmCxQpppnfZs/sfXtDz705E/pXubNeYyARRA1Ony02
 ozlQ==
X-Gm-Message-State: AOJu0YwSSJfl7G/aayIXBe75L/U3bWYAnvcGLiftYihgD/Ih6950XnQ0
 LHobikouGjp5yjzUhYwN1jUoqzc00uc5o0CEA0FpAd2pijfpXX6k7DwDdYEbhR1q9KhaRG2y9hB
 /t5gY5qf6ZjgO49tT0CScXks5uzsLqiGA1Z2oKk5Moff+BtOEs/5c
X-Received: by 2002:a2e:7219:0:b0:2d2:36e6:b76 with SMTP id
 n25-20020a2e7219000000b002d236e60b76mr638550ljc.49.1708668544049; 
 Thu, 22 Feb 2024 22:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXpCaU13jG9NxQVM7FU01MyOixul3P+Pjd3+9LdY9DAVQ6dO7xAg223Pt8BKHXLdXLRcJkKg==
X-Received: by 2002:a2e:7219:0:b0:2d2:36e6:b76 with SMTP id
 n25-20020a2e7219000000b002d236e60b76mr638533ljc.49.1708668543639; 
 Thu, 22 Feb 2024 22:09:03 -0800 (PST)
Received: from redhat.com ([147.235.213.72]) by smtp.gmail.com with ESMTPSA id
 b11-20020a5d634b000000b0033cf80ad6f5sm1451928wrw.60.2024.02.22.22.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 22:09:03 -0800 (PST)
Date: Fri, 23 Feb 2024 01:09:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, vattunuru@marvell.com,
 jerinj@marvell.com
Subject: Re: [PATCH v3] virtio-pci: correctly set virtio pci queue mem
 multiplier
Message-ID: <20240223010723-mutt-send-email-mst@kernel.org>
References: <20240223052617.1867132-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223052617.1867132-1-schalla@marvell.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Feb 23, 2024 at 10:56:17AM +0530, Srujana Challa wrote:
> Currently, virtio_pci_queue_mem_mult function always returns 4K
> when VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't
> work for vhost vdpa when host has page size other than 4K.
> This patch introduces a new property(host-page-per-vq) for vdpa
> use case to fix the same.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

Looks good. I'd like to fail realize if both 
   (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
and
   (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
so users do not start depending on this combination.



> ---
> v2->v3:
> - Modified property name, page-per-vdpa-vq to host-page-per-vq.
> 
> v1->v2:
> - Introduced a new property to get virtqueue mem multiplier for
>   vdpa use case.
> 
>  hw/virtio/virtio-pci.c         | 10 ++++++++--
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..f29e60830b 100644
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
> +    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
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
> +    DEFINE_PROP_BIT("host-page-per-vq", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 59d88018c1..81b6de4291 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -43,6 +43,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> +    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -89,6 +90,10 @@ enum {
>  #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
>    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
>  
> +/* page per vdpa vq flag to be used for vhost vdpa backends */
> +#define VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ \
> +    (1 << VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT)
> +
>  typedef struct {
>      MSIMessage msg;
>      int virq;
> -- 
> 2.25.1


