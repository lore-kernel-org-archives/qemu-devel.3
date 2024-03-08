Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821BBC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 19:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rig1u-0002OG-8q; Fri, 08 Mar 2024 14:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rig1s-0002Nr-Bt
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 14:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rig1q-0002lQ-I8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 14:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709926633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Jik3X5lzXjowN1WYmP3sEs1B7fRNPIdFC7+yEhCIm0=;
 b=S+DJ/5pyMyh+cIlQVV61mc44LzM7hpp+b9R2wCOOgSg41lArjFUC4PuT4V7ODEJ/bre7kk
 T2G3yCuPc9s/Byu/uR60OGtA1zg5RBbRcGv8PLSbCX7uLUPOTox9XCQl0uD86VF9jSYbz+
 OFxaXjlJQYKywbyucapBkV9knOWh+iQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-yAspadHUPRSnQegqhRD7mQ-1; Fri, 08 Mar 2024 14:37:11 -0500
X-MC-Unique: yAspadHUPRSnQegqhRD7mQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e0d943844so549460f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 11:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709926630; x=1710531430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Jik3X5lzXjowN1WYmP3sEs1B7fRNPIdFC7+yEhCIm0=;
 b=N0Gcrw4yN7z2u0d7xRyZftYnKKcV3yyUQgk5bfeGOc4Ie2B8T0C8f4hpoJcQSstQ6g
 5ErLUQyBP50vJzAYcMHlLr8ZzqZASOtR4L0r3X51naAJDgbk1OldV/fBjgLUMxLB3gDA
 ojoxg/thJqbHdw7VT4clddH61cNW8MLmE+Af2lx8x1lefsOL7TMCkLQFZP2Td6aeCosk
 0kt1PFhq0/M+9emv7qvEQ54QvWSbQGZjxWgahNp8T2vsHT+lHjcGugPnPAfg4tC7o88A
 poSL9MPWZCW1mW4OeeiNPynU3B/aL8qjrl6Z30qOcUv1IMoFjSSDl2uJGn5jJQaUyDEe
 zRDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5C/nVqgu3bml/Z5iCisjGdimilqK02aKyO62+fE6HGUPXAaEn4wjmVgDgiBbj5BlBNp9wfAqK7jdxJCME2nHrIc+QVwc=
X-Gm-Message-State: AOJu0YzSYLqnfko4Z25K/WeXj9hEBYrKmX8s0rqZ4eQdYN6f8scoi/6U
 nL0uZIDSx54rM6xvxJJVDtuiar3bKmW3XnvNnt+dA3OzCIQsDyVpA+jLAig+WRni/5ATn+L0jPN
 gPS0WMiCR2X1SGPODIXGzsdjYlNP3rVfl7BgHeZKGQno2uJQHHwHP
X-Received: by 2002:a5d:526c:0:b0:33e:7a49:fe3b with SMTP id
 l12-20020a5d526c000000b0033e7a49fe3bmr103719wrc.21.1709926629855; 
 Fri, 08 Mar 2024 11:37:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF23Dk4/2DqycU/fQxATm4+HeJ4K+O/2NWzTxCfll99NvUWizltEbs+l2Q3/gZTG0ertXCmCg==
X-Received: by 2002:a5d:526c:0:b0:33e:7a49:fe3b with SMTP id
 l12-20020a5d526c000000b0033e7a49fe3bmr103702wrc.21.1709926629234; 
 Fri, 08 Mar 2024 11:37:09 -0800 (PST)
Received: from redhat.com ([2a06:c701:73cd:f300:bc74:daca:b316:492a])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c45ce00b00413177c3f1dsm296642wmo.18.2024.03.08.11.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 11:37:08 -0800 (PST)
Date: Fri, 8 Mar 2024 14:37:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH] pci: Add option to disable device level INTx masking
Message-ID: <20240308143400-mutt-send-email-mst@kernel.org>
References: <20240307184645.104349-1-alex.williamson@redhat.com>
 <20240308115643-mutt-send-email-mst@kernel.org>
 <20240308102414.1826786c.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308102414.1826786c.alex.williamson@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On Fri, Mar 08, 2024 at 10:24:14AM -0700, Alex Williamson wrote:
> On Fri, 8 Mar 2024 11:57:38 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Mar 07, 2024 at 11:46:42AM -0700, Alex Williamson wrote:
> > > The PCI 2.3 spec added definitions of the INTx disable and status bits,
> > > in the command and status registers respectively.  The command register
> > > bit, commonly known as DisINTx in lspci, controls whether the device
> > > can assert the INTx signal.
> > > 
> > > Operating systems will often write to this bit to test whether a device
> > > supports this style of legacy interrupt masking.  When using device
> > > assignment, such as with vfio-pci, the result of this test dictates
> > > whether the device can use a shared or exclusive interrupt (ie. generic
> > > INTx masking at the device via DisINTx or IRQ controller level INTx
> > > masking).
> > > 
> > > Add an experimental option to the base set of properties for PCI
> > > devices which allows the DisINTx bit to be excluded from wmask, making
> > > it read-only to the guest for testing purposes related to INTx masking.
> > >   
> > 
> > Could you clarify the use a bit more? It's unstable - do you
> > expect to experiment with it and then make it permanent down
> > the road?
> 
> No, my aspirations end at providing an experimental option.
> Technically all devices should support and honor this bit, so I don't
> think we should provide a supported method of providing broken behavior,
> but there do exist physical devices where this feature is broken or
> unsupported.  Rather than implementing emulation of one of these broken
> devices, with bug for bug compatibility, it's much easier to be able to
> trigger broken DisINTx behavior on an arbitrary device, in an
> unsupported fashion.  Thanks,
> 
> Alex

Well, we tend not to merge patches for playing with random
bits in config space just so people can experiment with
whether this breaks guests, but given this is coming from
a long term contributor and a maintainer, it's a different
matter. So ok, to make another maintainer's life easier
I'm prepared to take this. I'd like to figure out though -
does your need extend to experimenting with all devices
or just with vfio ones? If the later maybe keep it there
where you understand what the actual need is... If the former
as I said I'll merge it.


> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  hw/pci/pci.c         | 14 ++++++++++----
> > >  include/hw/pci/pci.h |  2 ++
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 6496d027ca61..8c78326ad67f 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -85,6 +85,8 @@ static Property pci_props[] = {
> > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > +    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
> > > +                    QEMU_PCI_DISINTX_BITNR, true),
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >  
> > > @@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
> > >  static void pci_init_wmask(PCIDevice *dev)
> > >  {
> > >      int config_size = pci_config_size(dev);
> > > +    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> > > +                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> > >  
> > >      dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
> > >      dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
> > > -    pci_set_word(dev->wmask + PCI_COMMAND,
> > > -                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> > > -                 PCI_COMMAND_INTX_DISABLE);
> > > -    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
> > > +
> > > +    if (dev->cap_present & QEMU_PCI_DISINTX) {
> > > +        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
> > > +    }
> > > +
> > > +    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
> > >  
> > >      memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
> > >             config_size - PCI_CONFIG_HEADER_SIZE);
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index eaa3fc99d884..45f0fac435cc 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -212,6 +212,8 @@ enum {
> > >      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> > >  #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> > >      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> > > +#define QEMU_PCI_DISINTX_BITNR 13
> > > +    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
> > >  };
> > >  
> > >  typedef struct PCIINTxRoute {
> > > -- 
> > > 2.44.0  
> > 


