Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DAFC48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrWF-0008Cd-NU; Tue, 13 Feb 2024 07:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZrVk-0006z8-RB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZrVj-0001My-0p
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707825817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Emp4hwnx/ajJ/o3k0+pEA0VlRkyqe3LQtwtBtOGRc4=;
 b=GVzA1rc5BJ5R8GxmpJqns7T5csUL4B9b1+1y7J4XHGFGiSCEJLgtWNPlhtdbsKdMDqzdur
 VoaPrP8ElykeI+XNAqhPboT+CyxlvkkARkpGxXKU9VvPw+B3rfAG0MHyZQIZkOdfY0Cz4X
 w9yqLNMNBp+v8/ybhUsu9bKxeWHFt54=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-3xusIzwwOfiXwvgMyeYUVg-1; Tue, 13 Feb 2024 07:03:36 -0500
X-MC-Unique: 3xusIzwwOfiXwvgMyeYUVg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d0908edbd0so38857801fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825814; x=1708430614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Emp4hwnx/ajJ/o3k0+pEA0VlRkyqe3LQtwtBtOGRc4=;
 b=l6+2rLzwRqpqN/k+BJ2FkxXidhZFMCnJ7unw7J7iuZgZ4oQq3Bgo7VvEzGTf/okmsM
 62Pm0ISRkT7VENjEIUrUyT5L5TWmnbidhoW1Twkp9G8erVvBg5nFfg5iRVoWBsvin9Z+
 l/dMLljAPLRXxd3qCTIQdpqDhInQUYMEkASyuKpfxTbgDEuuv8nCj/gaPN3fmoIAKBie
 yqtx5arh09vFcMpbwtbJs5bmMHYngRxxuGD+P9stEwJkZXihVParE2BqCOdkx04IJlGj
 /3RF024zGvwj8metLnPJy8A4fb0I4o5UgYRqxxEw0d1Tw9dZ+WYl73LleLprlC4m0Meq
 vZ2w==
X-Gm-Message-State: AOJu0Yz1sqrcJ+DoM4HOt4cCafBi2eri4cmt1Dg/X8VesdMMIh0QHsFF
 O7QMa53hHUwqKf08mR8jznoG8ksIffjJIUeswMa8PO5rPsov+AgEdwGU36EB36B3L6UlqUFNVh6
 ahA5daZmEuGBonMEExzQhrauGLWACE4U7j3lstszlP8Hn4eqOTunO1j33gXUQ
X-Received: by 2002:a2e:8682:0:b0:2d1:ca1:760b with SMTP id
 l2-20020a2e8682000000b002d10ca1760bmr975007lji.30.1707825814619; 
 Tue, 13 Feb 2024 04:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/7l8vz8s8vxGl21CFVQherpMsNOGKPQ1FbDzGCAKBfE35G7sSxTIPuUD3v0Vh0713T2QdSA==
X-Received: by 2002:a2e:8682:0:b0:2d1:ca1:760b with SMTP id
 l2-20020a2e8682000000b002d10ca1760bmr974987lji.30.1707825814274; 
 Tue, 13 Feb 2024 04:03:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXW6TsIVZeKrIyRq7m+utUF6eqKkb20mLsSc2Gc9YXeoieUzArz+omw9xdcaAyQ+HOi/n3k368Zo2gJBkPXQSFFpnsvyGVw3n7fLpEcfQgS0urfGGm11pZf2g==
Received: from redhat.com ([2a02:14f:17d:5d88:37b3:ce51:18b:36d9])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c204f00b0041044e130bfsm11364212wmg.33.2024.02.13.04.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 04:03:33 -0800 (PST)
Date: Tue, 13 Feb 2024 07:03:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Message-ID: <20240213070100-mutt-send-email-mst@kernel.org>
References: <20240212075233.1507612-1-schalla@marvell.com>
 <20240213054513-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A9931C4B4E8E8E866066A04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR18MB5368A9931C4B4E8E8E866066A04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

On Tue, Feb 13, 2024 at 11:50:34AM +0000, Srujana Challa wrote:
> > Subject: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
> > multiplier
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Mon, Feb 12, 2024 at 01:22:33PM +0530, Srujana Challa wrote:
> > > Currently, virtio_pci_queue_mem_mult function returns 4K when
> > > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct when host
> > > has page size as 64K.
> > > This patch fixes the same.
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > 
> > You can't tweak guest visible values like this without compat machinery. It's
> > also going to consume a ton more phys memory - can this break any configs?
> > Why is this a problem? Just with vdpa?
> 
> We are observing the issue with vdpa when host has page size of 64K. We haven't
> verified any other backends. I think, any backend that uses below API would fail
> if host has page size other than 4K right?
> And also as per VIRTIO_PCI_FLAG_PAGE_PER_VQ, it should be equal to
> page_size right?
> 
> static int virtio_pci_set_host_notifier_mr(DeviceState *d, int n,
>                                            MemoryRegion *mr, bool assign)
> {
>     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>     int offset;
> 
>     if (n >= VIRTIO_QUEUE_MAX || !virtio_pci_modern(proxy) ||
>         virtio_pci_queue_mem_mult(proxy) != memory_region_size(mr)) {
>         return -1;
>     }

Yes but not everyone uses that right? Plain virtio in software with
no tricks doesn't care?


> > 
> > > ---
> > >  hw/virtio/virtio-pci.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > > e433879542..028df99991 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -316,12 +316,10 @@ static bool
> > virtio_pci_ioeventfd_enabled(DeviceState *d)
> > >      return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;  }
> > >
> > > -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> > > -
> > >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > > *proxy)  {
> > >      return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > > +        qemu_real_host_page_size()  : 4;
> > >  }
> > >
> > >  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier
> > > *notifier,
> > > --
> > > 2.25.1


