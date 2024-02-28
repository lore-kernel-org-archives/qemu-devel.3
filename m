Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A626CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 06:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfDnv-0007AF-M2; Wed, 28 Feb 2024 01:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rfDns-00079m-1q
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rfDnq-0001vC-2E
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709103148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xm3ot581Uo0tRp7ZqZLG2BwkAv9iQ7CJsrwWBa6NLfM=;
 b=Le4BEhfzFiPMbkI7EFdqycq+Hv41AwYmhXZDDz1mjs0KNzJfvaSuTgCTT5Ri+9lgmvQmXb
 ynXIbm/+SwVYs4J4GHKUMOOLxsZHgW8m376hnfwAzdIssq/naZjpnDpZV4XUQRGfE+9/1u
 itzLPvnU5RKbcnNcMXDk3WBD/syxVu8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-2p16gW89OVutBuqKVUfrZw-1; Wed, 28 Feb 2024 01:52:27 -0500
X-MC-Unique: 2p16gW89OVutBuqKVUfrZw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e40126031so27526335e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 22:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709103146; x=1709707946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xm3ot581Uo0tRp7ZqZLG2BwkAv9iQ7CJsrwWBa6NLfM=;
 b=Xmx1Bd33n3d41nedv9cxTS/Ed/5ah/E8lFCzq6pmHnk6/QriKN86nYp77rw2E3TYcJ
 A9EVFhZeZA+KdRfkXbAWZ1RaFeYAssNQVJU6iQU+HZvjDzJCPWKAdd0Wv5RC9RzcFBud
 7NIAwyakC8BY8SFJS31IIOCQtt9ZPHCdefL8ewN97ed950lTwUAJxSKoNpTe9eKF4Yzb
 2OG7e0O/gCJBU20F67tgt0rM/PydxDC1XSSZPSgID+1Foq8tyZ30xWEUOnPm68oPxVO4
 S3/tnkbCocHVXPIAwt5LXSCuzbAutJpGL3NaQ4ZHXzwJtaOX5Tn3VWqHKwcAm54WiAhk
 u3Fw==
X-Gm-Message-State: AOJu0YxBH4iBQ58jJ8rGChJr4wdKQx2XF+jKjnSZjWqBKpGXLUfwC2/A
 vjtd1n/MP6Hv9dn6FwEyYTN2csMyekd213DVDKuxnGkVwAy2xIM8m0ou41vY06wMjFG0sj8B7Ze
 y4YKoSJNDe/Moo/6rjqKYyFVHvBy1tbGcl1erw1VhLM0iqKfyLmNo
X-Received: by 2002:a05:600c:a44:b0:412:9654:b951 with SMTP id
 c4-20020a05600c0a4400b004129654b951mr8470403wmq.36.1709103146006; 
 Tue, 27 Feb 2024 22:52:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE81e3HD7HyONJ2RRa3/5XBxdWKwT25v7ABXI8zr6I4i7eVl5gG6N0M3Ur9F7gv/36cNkl7XA==
X-Received: by 2002:a05:600c:a44:b0:412:9654:b951 with SMTP id
 c4-20020a05600c0a4400b004129654b951mr8470396wmq.36.1709103145640; 
 Tue, 27 Feb 2024 22:52:25 -0800 (PST)
Received: from redhat.com ([109.253.193.52]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b00412a9a60f83sm1066399wmo.3.2024.02.27.22.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 22:52:25 -0800 (PST)
Date: Wed, 28 Feb 2024 01:52:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue
 mem multiplier
Message-ID: <20240228015016-mutt-send-email-mst@kernel.org>
References: <20240223052617.1867132-1-schalla@marvell.com>
 <20240223010723-mutt-send-email-mst@kernel.org>
 <DS0PR18MB53685A6DFD1E1184C2A60BF9A0582@DS0PR18MB5368.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR18MB53685A6DFD1E1184C2A60BF9A0582@DS0PR18MB5368.namprd18.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 06:13:03AM +0000, Srujana Challa wrote:
> > Subject: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue mem
> > multiplier
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Fri, Feb 23, 2024 at 10:56:17AM +0530, Srujana Challa wrote:
> > > Currently, virtio_pci_queue_mem_mult function always returns 4K when
> > > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't work for vhost vdpa
> > > when host has page size other than 4K.
> > > This patch introduces a new property(host-page-per-vq) for vdpa use
> > > case to fix the same.
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > 
> > Looks good. I'd like to fail realize if both
> >    (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) and
> >    (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ) so users do not
> > start depending on this combination.
> Could you confirm if we can add assertion for this case in virtio_pci_mem_mult() function?

No, reporting an error would be better since it's user-triggerable -
it is not nice to report user errors through assertions,
assertions are for conditions that can not be reached.


> > 
> > 
> > 
> > > ---
> > > v2->v3:
> > > - Modified property name, page-per-vdpa-vq to host-page-per-vq.
> > >
> > > v1->v2:
> > > - Introduced a new property to get virtqueue mem multiplier for
> > >   vdpa use case.
> > >
> > >  hw/virtio/virtio-pci.c         | 10 ++++++++--
> > >  include/hw/virtio/virtio-pci.h |  5 +++++
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > > 1a7039fb0c..f29e60830b 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -320,8 +320,12 @@ static bool
> > > virtio_pci_ioeventfd_enabled(DeviceState *d)
> > >
> > >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > > *proxy)  {
> > > -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > > +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> > > +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> > > +    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
> > > +        return qemu_real_host_page_size();
> > > +    else
> > > +        return 4;
> > >  }
> > >
> > >  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier
> > > *notifier, @@ -2301,6 +2305,8 @@ static Property virtio_pci_properties[] =
> > {
> > >                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > >      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > >                      VIRTIO_PCI_FLAG_AER_BIT, false),
> > > +    DEFINE_PROP_BIT("host-page-per-vq", VirtIOPCIProxy, flags,
> > > +                    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT, false),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >
> > > diff --git a/include/hw/virtio/virtio-pci.h
> > > b/include/hw/virtio/virtio-pci.h index 59d88018c1..81b6de4291 100644
> > > --- a/include/hw/virtio/virtio-pci.h
> > > +++ b/include/hw/virtio/virtio-pci.h
> > > @@ -43,6 +43,7 @@ enum {
> > >      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> > >      VIRTIO_PCI_FLAG_AER_BIT,
> > >      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> > > +    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT,
> > >  };
> > >
> > >  /* Need to activate work-arounds for buggy guests at vmstate load. */
> > > @@ -89,6 +90,10 @@ enum {  #define
> > VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
> > >    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
> > >
> > > +/* page per vdpa vq flag to be used for vhost vdpa backends */
> > > +#define VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ \
> > > +    (1 << VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT)
> > > +
> > >  typedef struct {
> > >      MSIMessage msg;
> > >      int virq;
> > > --
> > > 2.25.1


