Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9A3C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 20:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rigQ2-00082Y-LS; Fri, 08 Mar 2024 15:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rigQ1-00082P-Dn
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rigPv-0007dC-PZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709928126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXZgBEScRDwACfLjp/OlNp8bSNtrehpvJCPn+EuXeWg=;
 b=e8jXMU9dGSIx+k6UsyHP3D1GaNoq3wgp+4//Itkblhf3SgNbun6zs7bICD5h/hTs4A86Ge
 Lp3bBxS1R2vlV/crTkMisucj/vRBlz8L/CGA8NyTVvlam49BDskr8dLN1RiVp4aFWttVxb
 fnCfnd+O+kWLQXrAEBWUld1VZjfFUL0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-SYQ_FwK_MViK7NTzd06OOw-1; Fri, 08 Mar 2024 15:02:04 -0500
X-MC-Unique: SYQ_FwK_MViK7NTzd06OOw-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7c89d157c32so18856739f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 12:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709928124; x=1710532924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXZgBEScRDwACfLjp/OlNp8bSNtrehpvJCPn+EuXeWg=;
 b=a+waC+dyvsMtpN18ThBhuWvx0EFxBE5Q7N2JR1iOTOn7ey68Z2Sf0WYJBlXBV/QeCN
 42OXBzuuR+7IRsD0n0yicKJ66eS3idWdbBck0HsbTdcUBPHWlNY0MY/BJvyS98FCW/CG
 0dWA1n97uX9wyghHCIrCRgx+xcQKnOrjH6WqtteDsKkA08h175XJ/6LGDjoGxIWhp8UY
 VzMf7sfCxO3H9VJsIaDDA9y++JN9oqhOQwSAJStsFecbjYfymEcOMQizk+imaGLnvifm
 rAlO5en40hPO31L587/1JlKfT222uOpWaXL9MYxdV6IhZAp2f3cXnTKb5mI3AGfV5ywU
 U+xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAfLywzyKLlQGv2qAMUNI0EUlwqu3SU0R/AjZT7VtHk6ZjxhlnRKLtYP9q1HbK76B00yVZ4ORkWvyV/MWLyEqh6kZJdkA=
X-Gm-Message-State: AOJu0YwEaQWPfbChu6E3SPqaALnqjd52XSeRCJmWwZ5ZQYsDzaybSNXN
 bIzQ17y9Be1U7nc4zymFW+bmoy/R0qzBEBtUVj/lxL+NSP22pYRttpC6fQjgS17hnhpL5sJVj1/
 ZfRPJygfuRprbfO8YxehzJ1BECrYCCKWvTdtxqeTIHs4txjV/8ICB
X-Received: by 2002:a6b:e601:0:b0:7c8:6313:136f with SMTP id
 g1-20020a6be601000000b007c86313136fmr14963156ioh.2.1709928123718; 
 Fri, 08 Mar 2024 12:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuB2VKGN3gqlbw8qsZWyPOWKl4mzuU5fV15K078mmTU4sYddNqNZATGHNwpWJTHnv/QFEVkg==
X-Received: by 2002:a6b:e601:0:b0:7c8:6313:136f with SMTP id
 g1-20020a6be601000000b007c86313136fmr14963128ioh.2.1709928123389; 
 Fri, 08 Mar 2024 12:02:03 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 h2-20020a0566380f8200b00474d09e8f18sm42062jal.126.2024.03.08.12.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 12:02:02 -0800 (PST)
Date: Fri, 8 Mar 2024 13:02:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH] pci: Add option to disable device level INTx masking
Message-ID: <20240308130201.769e7135.alex.williamson@redhat.com>
In-Reply-To: <20240308143400-mutt-send-email-mst@kernel.org>
References: <20240307184645.104349-1-alex.williamson@redhat.com>
 <20240308115643-mutt-send-email-mst@kernel.org>
 <20240308102414.1826786c.alex.williamson@redhat.com>
 <20240308143400-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 14:37:06 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Mar 08, 2024 at 10:24:14AM -0700, Alex Williamson wrote:
> > On Fri, 8 Mar 2024 11:57:38 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Thu, Mar 07, 2024 at 11:46:42AM -0700, Alex Williamson wrote:  
> > > > The PCI 2.3 spec added definitions of the INTx disable and status bits,
> > > > in the command and status registers respectively.  The command register
> > > > bit, commonly known as DisINTx in lspci, controls whether the device
> > > > can assert the INTx signal.
> > > > 
> > > > Operating systems will often write to this bit to test whether a device
> > > > supports this style of legacy interrupt masking.  When using device
> > > > assignment, such as with vfio-pci, the result of this test dictates
> > > > whether the device can use a shared or exclusive interrupt (ie. generic
> > > > INTx masking at the device via DisINTx or IRQ controller level INTx
> > > > masking).
> > > > 
> > > > Add an experimental option to the base set of properties for PCI
> > > > devices which allows the DisINTx bit to be excluded from wmask, making
> > > > it read-only to the guest for testing purposes related to INTx masking.
> > > >     
> > > 
> > > Could you clarify the use a bit more? It's unstable - do you
> > > expect to experiment with it and then make it permanent down
> > > the road?  
> > 
> > No, my aspirations end at providing an experimental option.
> > Technically all devices should support and honor this bit, so I don't
> > think we should provide a supported method of providing broken behavior,
> > but there do exist physical devices where this feature is broken or
> > unsupported.  Rather than implementing emulation of one of these broken
> > devices, with bug for bug compatibility, it's much easier to be able to
> > trigger broken DisINTx behavior on an arbitrary device, in an
> > unsupported fashion.  Thanks,
> > 
> > Alex  
> 
> Well, we tend not to merge patches for playing with random
> bits in config space just so people can experiment with
> whether this breaks guests, but given this is coming from
> a long term contributor and a maintainer, it's a different
> matter. So ok, to make another maintainer's life easier
> I'm prepared to take this. I'd like to figure out though -
> does your need extend to experimenting with all devices
> or just with vfio ones? If the later maybe keep it there
> where you understand what the actual need is... If the former
> as I said I'll merge it.

I'm actually looking at using it with non-vfio devices, for example I
have a dummy nvme driver that can configure either INTx, MSI, or MSI-X
interrupts.  The driver just stuffs nop commands into the admin queue to
trigger an interrupt.  This tests DMA mapping and interrupt paths.  I
intend to port this to a userspace vfio-pci driver that I can run in a
guest on an emulated nvme device, thereby enabling targeted testing
without any host hardware or device dependencies.  If I were to expose
two emulated nvme devices to the guest, one with DisINTx disabled, then
all variations could be tested.

For full disclosure, the vfio-pci kernel driver does have a nointxmask
module option, so while I think it would be useful and provides a
little more flexibility that devices in QEMU can be specified with this
behavior, there are means to do it otherwise. The QEMU vfio-pci driver
certainly has experimental options that don't necessarily have a path
to become supported, I hadn't realized your intention/preference to
make it a staging ground for to-be-supported options for PCIDevice.

If you have concerns about cluttering options or maintaining dead-end
experimental options, let's hold off on this until there's a case that
can't be met with the kernel module option.  Thanks,

Alex

> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > ---
> > > >  hw/pci/pci.c         | 14 ++++++++++----
> > > >  include/hw/pci/pci.h |  2 ++
> > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index 6496d027ca61..8c78326ad67f 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -85,6 +85,8 @@ static Property pci_props[] = {
> > > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > > +    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
> > > > +                    QEMU_PCI_DISINTX_BITNR, true),
> > > >      DEFINE_PROP_END_OF_LIST()
> > > >  };
> > > >  
> > > > @@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
> > > >  static void pci_init_wmask(PCIDevice *dev)
> > > >  {
> > > >      int config_size = pci_config_size(dev);
> > > > +    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> > > > +                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> > > >  
> > > >      dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
> > > >      dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
> > > > -    pci_set_word(dev->wmask + PCI_COMMAND,
> > > > -                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> > > > -                 PCI_COMMAND_INTX_DISABLE);
> > > > -    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
> > > > +
> > > > +    if (dev->cap_present & QEMU_PCI_DISINTX) {
> > > > +        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
> > > > +    }
> > > > +
> > > > +    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
> > > >  
> > > >      memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
> > > >             config_size - PCI_CONFIG_HEADER_SIZE);
> > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > index eaa3fc99d884..45f0fac435cc 100644
> > > > --- a/include/hw/pci/pci.h
> > > > +++ b/include/hw/pci/pci.h
> > > > @@ -212,6 +212,8 @@ enum {
> > > >      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> > > >  #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> > > >      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> > > > +#define QEMU_PCI_DISINTX_BITNR 13
> > > > +    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
> > > >  };
> > > >  
> > > >  typedef struct PCIINTxRoute {
> > > > -- 
> > > > 2.44.0    
> > >   
> 


