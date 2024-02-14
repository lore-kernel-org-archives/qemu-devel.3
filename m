Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A297C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHYV-0004Vp-VA; Wed, 14 Feb 2024 10:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHYG-0004Rg-AJ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:52:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHYE-0000E9-Py
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707925916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhCrzwYmujSQXBAwffvxfCgjAQu9k7R2wXKXQlqobXg=;
 b=grZHeUtIf9C3PaXjlQpj335yYO0eXolTWTmK/ZOcvSlIjUkQNhHAOGajpCqj/RcCz8ZstD
 Ey3TxUKCUGkkznwZtUSMZpAn8v1Hne4rc4jdYuobaXQyr2Kbbx1X9AhUXV2N157yNV6SS7
 z2I9VON6f2zdgekqZdci5A56IlOYFX4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-S06pmc0_O_Ky-LGgVK8oYA-1; Wed, 14 Feb 2024 10:51:55 -0500
X-MC-Unique: S06pmc0_O_Ky-LGgVK8oYA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33cf6777722so14206f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707925914; x=1708530714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhCrzwYmujSQXBAwffvxfCgjAQu9k7R2wXKXQlqobXg=;
 b=dKbeOqMywgOMA3KEe3kRPJKAaJRwAzwVvaNunoxDPXnqB1MXDkP2oZHOBbXBRrQbfl
 A9kmAkv3MCFKyeBZNMDlV4LF7rOg6B1V9sJsDzHUJ6xBrVXfvDfH0ONhL4u2yfRvb2a7
 QVvwAy/aTsbwhIxdA3FqIUIQo+YhGQ7L5R0qpuwuKJ/BqdhWP0LH2tua54NCWvBp8CUZ
 wr2vcVfqYDAdY7RP7lpA1lDuCbNUYOpoLu3KoJPHMxYtMIr0x4Si33HWERpJ/VwIJr/3
 jFpo4pgs7ahMHKgQu0j8t7WuUcNOqyB+O0WRNvRIpl0iDab1ajTeKIYB6oPdTGN2l4Xn
 xN9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Mb+tgo2sOwpkaL978+Q8kYAPyQbfnjetB73YwweWOjZ8DT589FXTmxuwVK0e0fZGCvv+vFY1WKFKP7GH+baN+EUGovs=
X-Gm-Message-State: AOJu0YwZhxrxTq1X2UVOHG1U0gZwRM+a1CLP2pVMqq8y6zAUMzF9QvDG
 Y4ncLg9uABsp9B4lBlVAKnvu9xvEE/T3DSa7urx9zDMI9yhx6J2Kk5WZvgFxtbdGtzxlX8il4tZ
 QUXLF4c9e3j3o07Xe7DvcG1KNpOcpAGBIOnzEf37jAPAiIcWbW0wm
X-Received: by 2002:a05:600c:511f:b0:40f:bdf3:3426 with SMTP id
 o31-20020a05600c511f00b0040fbdf33426mr2453457wms.31.1707925914083; 
 Wed, 14 Feb 2024 07:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF3eJdN+Du9PrYwM/Bqrx3TDFb4TonW5e7N0Z96ll4j8CKL1rt23M5rAdjjka2MqdaUSzzvw==
X-Received: by 2002:a05:600c:511f:b0:40f:bdf3:3426 with SMTP id
 o31-20020a05600c511f00b0040fbdf33426mr2453442wms.31.1707925913772; 
 Wed, 14 Feb 2024 07:51:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUR6bYG+yd5nLodLVMAXWGZZH+oB3gMIVJw/GpnUXVDp3FubXbVL6/TnKVW7GCdWQZSkA6t4xU+QEgnR5L8zTkvPD9ZiCGJRY0t9yPBCj0P0Dxp0wMHzYWBBslzYgctIYsdpRv99aIrgHvjXOo8EkPBZHkKpFDG4E9FGQFKc843IezKsJNUSC5iObyFjlQuUeCWGaYW8A9UyyjZARt8MlaSAlpgI2AuRey1bmhOH7zOdgCP5Nbmhv8AiESD+OI/pOISz6XM5LfpqyUZ9VXuU/Y6YjJCskjWs1Q//OQEklcIlV0RezuAlYUZhYV5mqhPPEeuwrCQumfbRyBNh7ueqxmmhfuj6gB5HuNKmgvzf1etqwF7+uDEh2/ihg7QU5OSfGmTj48UJ+TMfwdMJqemcG+YMd2hXf6N/VbTGg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 l10-20020a5d674a000000b0033cefb84b16sm1829236wrw.52.2024.02.14.07.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 07:51:53 -0800 (PST)
Date: Wed, 14 Feb 2024 10:51:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 8/9] pcie_sriov: Do not reset NumVFs after
 unregistering VFs
Message-ID: <20240214104637-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-8-89ad093a07f4@daynix.com>
 <20240214015322-mutt-send-email-mst@kernel.org>
 <a20793a9-87b0-4a3d-9032-590502454dd0@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20793a9-87b0-4a3d-9032-590502454dd0@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
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

On Wed, Feb 14, 2024 at 11:32:11PM +0900, Akihiko Odaki wrote:
> On 2024/02/14 15:53, Michael S. Tsirkin wrote:
> > On Wed, Feb 14, 2024 at 02:13:46PM +0900, Akihiko Odaki wrote:
> > > I couldn't find such a behavior specified.
> > 
> > Is it fixing a bug or just removing unnecessary code?
> > Is this guest visible at all?
> 
> My intention is just to remove unnecessary code, but it is guest-visible.
> The original behavior causes a problem and it should be considered as a bug
> fix if a guest expects VFs can be restored by setting VF Enable after
> clearing it, but I don't know such an example.

Ah ok.  So:

	According to the spec, PCI_SRIOV_NUM_VF isn't reset when
	VFs are disabled. Clearing it is guest visible and out of spec,
	even though guests mostly don't rely on this value being
	preserved, so we never noticed.

I wonder however what happens on reset.
How come we don't have a reset callback for sriov cap?
I suspect this hack serves as a work around to avoid leaking
this register, and we really should fix that too here?

> > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   hw/pci/pcie_sriov.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > > index 9d668b8d6c17..410bc090fc58 100644
> > > --- a/hw/pci/pcie_sriov.c
> > > +++ b/hw/pci/pcie_sriov.c
> > > @@ -209,7 +209,6 @@ static void unregister_vfs(PCIDevice *dev)
> > >           pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
> > >       }
> > >       dev->exp.sriov_pf.num_vfs = 0;
> > > -    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
> > >   }
> > >   void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> > > 
> > > -- 
> > > 2.43.0
> > 


