Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9026AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 20:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rigTc-0000ij-IN; Fri, 08 Mar 2024 15:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rigTa-0000h3-6i
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rigTW-0008Bu-0m
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709928348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fcx6Gwd5Vtq3CQy3iiMAxXkvRq31hoWYHk2mb56x/q8=;
 b=M1bYp8DjerGpwVXx4JnBP7m+7xiPpcUDp7IDAFfEba5N8WtFbygCIVf+URiQ1HnwQA9iKG
 zlBnmP9C2ZScHB9flLPd/YkPylZVz5ZW1QxYIRzTYaXkYhiWBdFa4pRAq+BB+kFCdJgXcH
 c3wMBGXj5qa762CrI7Up6oK0g/uNNug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-St1yl74AMLWUzquI94uG-g-1; Fri, 08 Mar 2024 15:05:46 -0500
X-MC-Unique: St1yl74AMLWUzquI94uG-g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412edc9d70aso14847895e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 12:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709928345; x=1710533145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fcx6Gwd5Vtq3CQy3iiMAxXkvRq31hoWYHk2mb56x/q8=;
 b=MH4P14KPaaGT+rMcGsM705zSnxyNbJOpHdWIlSmSXCM9if60SoKsfLB5FM6fPLqZm/
 z/OBf92lSC3dMaxq8VpuFg2MipOItfc+eEyKqCNfO9gfYVU1dpAAzUEeXYaBhjizM/nQ
 nqrTxNJ43b3M1v2G5Viv+8d1pfeRiNd+hdBVqU/N3Xt7oca+ONTVgMS06bfekfPAcwAX
 /iv8znzHPgKkwO1rpFAvW2wOLWXctb2XkX5WTwSpPUaWfa9dMAklCyR5Uyl15ZrG8Mjo
 tT9Mowl5FyDli/YjwbCx/zKaerrxmOhCSyBVMpMV6u2UkRZoOofE8Et5c8z0/qESKSzm
 HbbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV51m/GcJQX/8HB0JGEnmLQLsypE2Dwmx/CVdPK9MIPzZ2u/blcWK+YpbrxMKaFrMEvj36hvwyVFPbkjAt0JLmc7Ek7YhQ=
X-Gm-Message-State: AOJu0YzqOtiCo85rD8j+kMiIyg4+JVnopTkw2ZWmkf9spb+l8I2cyTQP
 i1dKkUvxy0m916RuZieAnt3rPSBjxzpknmk3zFws+GcgowPzAdFDglrl1pFdBClFKtEvKLzd7Dh
 /10LDas0MdC8RVqr+rqsiK2Ha7Shd5XnFHpP2Va2OcWjNR1xBr5hC
X-Received: by 2002:a05:600c:190e:b0:413:812:ce41 with SMTP id
 j14-20020a05600c190e00b004130812ce41mr207276wmq.34.1709928345344; 
 Fri, 08 Mar 2024 12:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW1xAsxvKqW0VarESnn09OG81+z/kwp6vnCjHjcrlnmprV8xwlGsWE2s2Nvne+Yt2n/Hx1ZQ==
X-Received: by 2002:a05:600c:190e:b0:413:812:ce41 with SMTP id
 j14-20020a05600c190e00b004130812ce41mr207242wmq.34.1709928344713; 
 Fri, 08 Mar 2024 12:05:44 -0800 (PST)
Received: from redhat.com ([2a06:c701:73cd:f300:bc74:daca:b316:492a])
 by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b004131ec07b8fsm213717wmb.44.2024.03.08.12.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 12:05:44 -0800 (PST)
Date: Fri, 8 Mar 2024 15:05:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH] pci: Add option to disable device level INTx masking
Message-ID: <20240308150359-mutt-send-email-mst@kernel.org>
References: <20240307184645.104349-1-alex.williamson@redhat.com>
 <20240308115643-mutt-send-email-mst@kernel.org>
 <20240308102414.1826786c.alex.williamson@redhat.com>
 <20240308143400-mutt-send-email-mst@kernel.org>
 <20240308130201.769e7135.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308130201.769e7135.alex.williamson@redhat.com>
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

On Fri, Mar 08, 2024 at 01:02:01PM -0700, Alex Williamson wrote:
> On Fri, 8 Mar 2024 14:37:06 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Mar 08, 2024 at 10:24:14AM -0700, Alex Williamson wrote:
> > > On Fri, 8 Mar 2024 11:57:38 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Thu, Mar 07, 2024 at 11:46:42AM -0700, Alex Williamson wrote:  
> > > > > The PCI 2.3 spec added definitions of the INTx disable and status bits,
> > > > > in the command and status registers respectively.  The command register
> > > > > bit, commonly known as DisINTx in lspci, controls whether the device
> > > > > can assert the INTx signal.
> > > > > 
> > > > > Operating systems will often write to this bit to test whether a device
> > > > > supports this style of legacy interrupt masking.  When using device
> > > > > assignment, such as with vfio-pci, the result of this test dictates
> > > > > whether the device can use a shared or exclusive interrupt (ie. generic
> > > > > INTx masking at the device via DisINTx or IRQ controller level INTx
> > > > > masking).
> > > > > 
> > > > > Add an experimental option to the base set of properties for PCI
> > > > > devices which allows the DisINTx bit to be excluded from wmask, making
> > > > > it read-only to the guest for testing purposes related to INTx masking.
> > > > >     
> > > > 
> > > > Could you clarify the use a bit more? It's unstable - do you
> > > > expect to experiment with it and then make it permanent down
> > > > the road?  
> > > 
> > > No, my aspirations end at providing an experimental option.
> > > Technically all devices should support and honor this bit, so I don't
> > > think we should provide a supported method of providing broken behavior,
> > > but there do exist physical devices where this feature is broken or
> > > unsupported.  Rather than implementing emulation of one of these broken
> > > devices, with bug for bug compatibility, it's much easier to be able to
> > > trigger broken DisINTx behavior on an arbitrary device, in an
> > > unsupported fashion.  Thanks,
> > > 
> > > Alex  
> > 
> > Well, we tend not to merge patches for playing with random
> > bits in config space just so people can experiment with
> > whether this breaks guests, but given this is coming from
> > a long term contributor and a maintainer, it's a different
> > matter. So ok, to make another maintainer's life easier
> > I'm prepared to take this. I'd like to figure out though -
> > does your need extend to experimenting with all devices
> > or just with vfio ones? If the later maybe keep it there
> > where you understand what the actual need is... If the former
> > as I said I'll merge it.
> 
> I'm actually looking at using it with non-vfio devices, for example I
> have a dummy nvme driver that can configure either INTx, MSI, or MSI-X
> interrupts.  The driver just stuffs nop commands into the admin queue to
> trigger an interrupt.  This tests DMA mapping and interrupt paths.  I
> intend to port this to a userspace vfio-pci driver that I can run in a
> guest on an emulated nvme device, thereby enabling targeted testing
> without any host hardware or device dependencies.  If I were to expose
> two emulated nvme devices to the guest, one with DisINTx disabled, then
> all variations could be tested.
> 
> For full disclosure, the vfio-pci kernel driver does have a nointxmask
> module option, so while I think it would be useful and provides a
> little more flexibility that devices in QEMU can be specified with this
> behavior, there are means to do it otherwise. The QEMU vfio-pci driver
> certainly has experimental options that don't necessarily have a path
> to become supported, I hadn't realized your intention/preference to
> make it a staging ground for to-be-supported options for PCIDevice.
> 
> If you have concerns about cluttering options or maintaining dead-end
> experimental options, let's hold off on this until there's a case that
> can't be met with the kernel module option.  Thanks,
> 
> Alex

That's the concern. But you decide. One maintainer's time is not more
important than other's. If it helps you - just merge it.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > ---
> > > > >  hw/pci/pci.c         | 14 ++++++++++----
> > > > >  include/hw/pci/pci.h |  2 ++
> > > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > index 6496d027ca61..8c78326ad67f 100644
> > > > > --- a/hw/pci/pci.c
> > > > > +++ b/hw/pci/pci.c
> > > > > @@ -85,6 +85,8 @@ static Property pci_props[] = {
> > > > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > > > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > > > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > > > +    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
> > > > > +                    QEMU_PCI_DISINTX_BITNR, true),
> > > > >      DEFINE_PROP_END_OF_LIST()
> > > > >  };
> > > > >  
> > > > > @@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
> > > > >  static void pci_init_wmask(PCIDevice *dev)
> > > > >  {
> > > > >      int config_size = pci_config_size(dev);
> > > > > +    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> > > > > +                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> > > > >  
> > > > >      dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
> > > > >      dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
> > > > > -    pci_set_word(dev->wmask + PCI_COMMAND,
> > > > > -                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> > > > > -                 PCI_COMMAND_INTX_DISABLE);
> > > > > -    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
> > > > > +
> > > > > +    if (dev->cap_present & QEMU_PCI_DISINTX) {
> > > > > +        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
> > > > > +    }
> > > > > +
> > > > > +    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
> > > > >  
> > > > >      memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
> > > > >             config_size - PCI_CONFIG_HEADER_SIZE);
> > > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > > index eaa3fc99d884..45f0fac435cc 100644
> > > > > --- a/include/hw/pci/pci.h
> > > > > +++ b/include/hw/pci/pci.h
> > > > > @@ -212,6 +212,8 @@ enum {
> > > > >      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> > > > >  #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> > > > >      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> > > > > +#define QEMU_PCI_DISINTX_BITNR 13
> > > > > +    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
> > > > >  };
> > > > >  
> > > > >  typedef struct PCIINTxRoute {
> > > > > -- 
> > > > > 2.44.0    
> > > >   
> > 


