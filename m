Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FA6C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv6F-000445-8e; Tue, 13 Feb 2024 10:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZv6C-0003kL-Ad
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZv6A-0005tY-AI
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jn9Jk80ss7NgoLWEAVLXh3FQCpQPNAFN3Zri98i6GSg=;
 b=Scpojm3KaCawUoFGaAXhMYkOy1KInlHPp2yeBKlYmXA/K0ou1LaYzs9sV3ISRxXNUJfvry
 /Amwj9dIEO9deEhBkEdJCXPT6edoBuJAlzqh/w3jwH994fVGM580smvl0OCo8O1/gue4DL
 44lKb8RVS/1vqSfgJtbyyScrY5g0T5I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-hloKNXpcNxayh2cTPOUtAA-1; Tue, 13 Feb 2024 10:53:27 -0500
X-MC-Unique: hloKNXpcNxayh2cTPOUtAA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33cd8db37bcso397822f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839607; x=1708444407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jn9Jk80ss7NgoLWEAVLXh3FQCpQPNAFN3Zri98i6GSg=;
 b=tqid3Lx33pFLnakx1YN7rlZz6csY5XTfRcTS/P/tUw6v5OD8cGbIz5EkkqGPiVRMI+
 Nm05BAd+8cAsgmKD8vrIQLyuKzzf4PcjX0/Fvt82xGEn2m9uH766zbAie0TZRq2Z348f
 3SrzszGX6iiR7IN7OoNN9Kx87JeSgZlbkTg3mlP+xbpue+wu7Mfa5YbLw9cKLFTG+8iw
 HmTFRl5VbKYPeT14LPijKjlHET34wjx/gDjhux1qpe7a0yKyCrZUqqeqUrUHHMKFZXXH
 Ow+ybh7UMqwSv/GJ1tEnknQhP/LDrnajScbQqXL9M1ldnXhYqCApwVAlTi9jyV1JeDrU
 LIog==
X-Gm-Message-State: AOJu0Yx1XJ+Vk2nhALov0uQqvefygj0bXA29Cb0Ol9WrAqL/BUIwbr0F
 hu4lGfbkWvEbjkU61QADvJl2ztyLFT49xg9DfVHUjO7PctsZPOkZw+GpG7OvGaRJ/l5cVR5qA1G
 t+zm5KzMAFaltE19B5oAkM9CML1I4spRtiNeSZeY427HYeWEjI1C1
X-Received: by 2002:adf:b351:0:b0:33c:e310:8e3e with SMTP id
 k17-20020adfb351000000b0033ce3108e3emr479048wrd.10.1707839606802; 
 Tue, 13 Feb 2024 07:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEP1ECIp/66q502SVLSNKHFAIvEZi9ezNYOJ3fghul3RliX87auO4arSC2C80ioocnMnuUlQ==
X-Received: by 2002:adf:b351:0:b0:33c:e310:8e3e with SMTP id
 k17-20020adfb351000000b0033ce3108e3emr479036wrd.10.1707839606456; 
 Tue, 13 Feb 2024 07:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX9USCSZYLuKF5kyH0h1fsYpVo24YXkZfo93zKoQlP6Td+zEv/yx/SGpLPygxnJ9hXY4kICHwgRSe3iSoryxXMp3T2rlbht6pUYKGgBu9bS9fFzElTl0zCRdg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 r17-20020adfe691000000b0033aeb0afa8fsm9910442wrm.39.2024.02.13.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:53:24 -0800 (PST)
Date: Tue, 13 Feb 2024 10:53:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Message-ID: <20240213105249-mutt-send-email-mst@kernel.org>
References: <20240212075233.1507612-1-schalla@marvell.com>
 <20240213054513-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A9931C4B4E8E8E866066A04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240213070100-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368152CEB40AAD449E71ECCA04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR18MB5368152CEB40AAD449E71ECCA04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
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

On Tue, Feb 13, 2024 at 12:37:36PM +0000, Srujana Challa wrote:
> > Subject: Re: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
> > multiplier
> > 
> > On Tue, Feb 13, 2024 at 11:50:34AM +0000, Srujana Challa wrote:
> > > > Subject: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci
> > > > queue mem multiplier
> > > >
> > > > External Email
> > > >
> > > > --------------------------------------------------------------------
> > > > -- On Mon, Feb 12, 2024 at 01:22:33PM +0530, Srujana Challa wrote:
> > > > > Currently, virtio_pci_queue_mem_mult function returns 4K when
> > > > > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct when
> > > > > host has page size as 64K.
> > > > > This patch fixes the same.
> > > > >
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > >
> > > > You can't tweak guest visible values like this without compat
> > > > machinery. It's also going to consume a ton more phys memory - can this
> > break any configs?
> > > > Why is this a problem? Just with vdpa?
> > >
> > > We are observing the issue with vdpa when host has page size of 64K.
> > > We haven't verified any other backends. I think, any backend that uses
> > > below API would fail if host has page size other than 4K right?
> > > And also as per VIRTIO_PCI_FLAG_PAGE_PER_VQ, it should be equal to
> > > page_size right?
> > >
> > > static int virtio_pci_set_host_notifier_mr(DeviceState *d, int n,
> > >                                            MemoryRegion *mr, bool
> > > assign) {
> > >     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> > >     int offset;
> > >
> > >     if (n >= VIRTIO_QUEUE_MAX || !virtio_pci_modern(proxy) ||
> > >         virtio_pci_queue_mem_mult(proxy) != memory_region_size(mr)) {
> > >         return -1;
> > >     }
> > 
> > Yes but not everyone uses that right? Plain virtio in software with no tricks
> > doesn't care?
> Yes,  any other better ways to address this issue.?

Add a property that vdpa can set?


> > 
> > 
> > > >
> > > > > ---
> > > > >  hw/virtio/virtio-pci.c | 4 +---
> > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > > > > e433879542..028df99991 100644
> > > > > --- a/hw/virtio/virtio-pci.c
> > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > @@ -316,12 +316,10 @@ static bool
> > > > virtio_pci_ioeventfd_enabled(DeviceState *d)
> > > > >      return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
> > > > > }
> > > > >
> > > > > -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> > > > > -
> > > > >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > > > > *proxy)  {
> > > > >      return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > > > > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > > > > +        qemu_real_host_page_size()  : 4;
> > > > >  }
> > > > >
> > > > >  static int virtio_pci_ioeventfd_assign(DeviceState *d,
> > > > > EventNotifier *notifier,
> > > > > --
> > > > > 2.25.1


