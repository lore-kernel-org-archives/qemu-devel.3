Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA1C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUe8-0000Kp-O7; Wed, 13 Mar 2024 15:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkUe7-0000Kf-FS
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkUe6-0005rK-3A
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710359532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQsWka//6ymjwV/7sErKAw4yY0b0xjRLKfkbPEohjvk=;
 b=enQqcOoB83FiFrSIEknY4uW3Ev6mOgspYT3FlosBf4fUh0kKLOGMuW1zs8aNztLRv7cHPB
 h+aQoBNxOyHnlQ7xxMNou4cczRPGNmzvZAOivoGXc5gtI0lsJAUW1L9wM5IajSwo0gpsSL
 wvdsKRO0k3jMVtzPDnQofLCQtIWlCI4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WPQkOOJAMbaJCbXkPh_0dw-1; Wed, 13 Mar 2024 15:52:08 -0400
X-MC-Unique: WPQkOOJAMbaJCbXkPh_0dw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-568728e521bso162156a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710359527; x=1710964327;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQsWka//6ymjwV/7sErKAw4yY0b0xjRLKfkbPEohjvk=;
 b=GGrj1RxHs0SzzlZ7ClQ4k3QsSWeT6DEkppRDt6UgaP7o2ORQjj5jdiodSOQx1cl8Ws
 kqqEPglnOoyUl/cmeVirtuARQeEI5LVWhtTZmNbS/xrmRHUKXYnUIMFLCSnOHhPqFtA9
 kvKoVSP60F3fgO5SMGovnwZtbkD8Vm/qm9Ezy+2xz1n/DeiaQo+M+awG63VzIPAXUHMM
 S1iD1dD0BAgAiDQontdaz4fjGDE6Iua/bCGlCbyhJmodZ4fgluIkELyTibkR5rkLONvz
 AWLnUcccBviCoVV4/muGreDSGvQhWSaTuVsgANciMfczNpi9bZ3IbirvlQ6h0MH+GDb4
 2Lig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYxquelv96t/YBqh33TYhtGRAE/ByGEVQhGbHDodkH29P5UJqrdWzcFF10MAi1HfjtN9j7GgjM8iy+Bm7AwkOLaPOyeno=
X-Gm-Message-State: AOJu0YxAA8Q0WBp0SxF/+SD/OVafL6Tiz3GNcWLnvUhcJuZbwY1+R/aZ
 EbFyh0WL6ImeVFzaZOLcdugBUauGwD9ZL1pAGf80xtclMdVv5uYqRH2KgFEZdQ5NXjMKrQfczmy
 SiLIHUH+R+gxa9ueMygzDmflQyHDgZfAP9nhYagFp+XxgLrafG+NE
X-Received: by 2002:a17:907:c30a:b0:a45:ca21:7694 with SMTP id
 tl10-20020a170907c30a00b00a45ca217694mr4680297ejc.10.1710359527440; 
 Wed, 13 Mar 2024 12:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfBz/F8EorBi/m70VgrmKknI8Haug9fZzaJqWcw4rR/Cp4x3CR8chgIo5/mFhYp4WA3rIHiQ==
X-Received: by 2002:a17:907:c30a:b0:a45:ca21:7694 with SMTP id
 tl10-20020a170907c30a00b00a45ca217694mr4680282ejc.10.1710359526903; 
 Wed, 13 Mar 2024 12:52:06 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 h4-20020a170906260400b00a461e10094asm3760161ejc.95.2024.03.13.12.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:52:06 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:52:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Hao Chen <chenh@yusur.tech>, qemu-devel@nongnu.org, jasowang@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] hw/virtio: Add support for VDPA network simulation devices
Message-ID: <20240313155136-mutt-send-email-mst@kernel.org>
References: <20240221073802.2888022-1-chenh@yusur.tech>
 <d9e4f3b4-9c2e-466c-b5f4-3387ce88c6b9@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9e4f3b4-9c2e-466c-b5f4-3387ce88c6b9@t-8ch.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 13, 2024 at 07:51:08PM +0100, Thomas Weißschuh wrote:
> On 2024-02-21 15:38:02+0800, Hao Chen wrote:
> > This patch adds support for VDPA network simulation devices.
> > The device is developed based on virtio-net and tap backend,
> > and supports hardware live migration function.
> > 
> > For more details, please refer to "docs/system/devices/vdpa-net.rst"
> > 
> > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > ---
> >  MAINTAINERS                                 |   5 +
> >  docs/system/device-emulation.rst            |   1 +
> >  docs/system/devices/vdpa-net.rst            | 121 +++++++++++++
> >  hw/net/virtio-net.c                         |  16 ++
> >  hw/virtio/virtio-pci.c                      | 189 +++++++++++++++++++-
> >  hw/virtio/virtio.c                          |  39 ++++
> >  include/hw/virtio/virtio-pci.h              |   5 +
> >  include/hw/virtio/virtio.h                  |  19 ++
> >  include/standard-headers/linux/virtio_pci.h |   7 +
> >  9 files changed, 399 insertions(+), 3 deletions(-)
> >  create mode 100644 docs/system/devices/vdpa-net.rst
> 
> [..]
> 
> > diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
> > index b7fdfd0668..fb5391cef6 100644
> > --- a/include/standard-headers/linux/virtio_pci.h
> > +++ b/include/standard-headers/linux/virtio_pci.h
> > @@ -216,6 +216,13 @@ struct virtio_pci_cfg_cap {
> >  #define VIRTIO_PCI_COMMON_Q_NDATA	56
> >  #define VIRTIO_PCI_COMMON_Q_RESET	58
> >  
> > +#define LM_LOGGING_CTRL                 0
> > +#define LM_BASE_ADDR_LOW                4
> > +#define LM_BASE_ADDR_HIGH               8
> > +#define LM_END_ADDR_LOW                 12
> > +#define LM_END_ADDR_HIGH                16
> > +#define LM_VRING_STATE_OFFSET           0x20
> 
> These changes are not in upstream Linux and will be undone by
> ./scripts/update-linux-headers.sh.
> 
> Are they intentionally in this header?


Good point. Pls move.

> > +
> >  #endif /* VIRTIO_PCI_NO_MODERN */
> >  
> >  #endif


