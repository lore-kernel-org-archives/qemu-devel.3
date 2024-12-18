Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A169E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1Fe-0000gi-Ut; Wed, 18 Dec 2024 16:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tO1Fc-0000fp-U8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:06:37 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tO1FZ-0005NM-K1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:06:36 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-51878d9511bso44561e0c.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 13:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734555992; x=1735160792;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hsvufAGFHMTzG6OJJWKAO97H2j+pqnT3HNwUhADDuNY=;
 b=KcEx8QDqBCK5kuCMDRTml/3kv5es4N03QdTgcTMDGeaXMruOyGd71VUhIqVTlTicYM
 KsFhObE22SLHFZfZjRq5jHu5z+vnA7KhVabS5mJioBvzdiriskn9jSPjz1Tc7p6Iy2O2
 Ng3uC/DzrQiTRiVKyyHFW3dwaWYkYBjGcOw2I18wzkpzzCT+utRE/o5DJoxL0cYFI6hy
 5aIB8w6U3bvmJSVdOQ4evvD/FvAZSqbzMHWWS2/K54WgS530TQTAkh0MQBUIrP6rgjm2
 E94Cbm3YQavSC9qq18bIBBlR/sclCc0haXbY76Av27TQPHJoh6dRfBMIdDrl0EUF2qZU
 qPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734555992; x=1735160792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hsvufAGFHMTzG6OJJWKAO97H2j+pqnT3HNwUhADDuNY=;
 b=qvO9dg7q+NLpP+9jrCxu3cuZiyWNCyTWZPLjwCuru9ixjhAWFkHzYpc7j4aAClv+nH
 vd+HIts42xmp60538gv6hKPy1hJ/RZJVzI/SALYpn/1Asj/V1nrV0thH9bcvVCnZTWzY
 Rs9vJFV/ACqEKQG+mtWESHAh/J2jd2XUPcXTqTWCRCQ+gtUk0GBxh8UAYEQ5WzLXrYH/
 a+CYnJCJ6PJ/fKeftqBhIqnuvsrSmADNKDukihJPRwz5p1kglwFz3n/jQWKI3bOZ8PWa
 9flZ1HfsK03pWWxa3yFFx84JbsbDnLPFyXIEZsDkvJH3wAufo3eMgrK744TqNUX1TZMa
 fYsw==
X-Gm-Message-State: AOJu0YzFtqnbDSVYupUlmdoJOZ/8JbBEoevlK72293BppjMRkL/8igzS
 T3ksa7Ao/1m5SY0MCjXmLmmwebC0L/zvUrz8TbhqfW9537uNY09qeH4BgOyq63Ww1OacZFn8aj6
 NRhRWqkkzu4B0FuZgV4ymQAVYuIZh1Rw/8EH3
X-Gm-Gg: ASbGncvgOnZXwM+L94ET7d3lwsZGYvesv+bMbPdEh6ojQSClWyEQjUECFMTHaoe40j0
 jlyYCaC+XA70+opA6pYfn5x+bgi7zStW7AvzqVQ==
X-Google-Smtp-Source: AGHT+IGOMZKUTG/+ZymEGjitQpXxzcSWD6t10XkBxdOS3pgDuSUw2XwqQgxNMw7GCxmgVOpuOXpniq62O1w4u/E6gU0=
X-Received: by 2002:a05:6122:17a9:b0:516:18cd:c1fc with SMTP id
 71dfb90a1353d-51b6481d21emr1379578e0c.8.1734555992070; Wed, 18 Dec 2024
 13:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
 <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
 <D6EFJHL1PDCX.2TZC2E8DZLNU3@gmail.com>
In-Reply-To: <D6EFJHL1PDCX.2TZC2E8DZLNU3@gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 18 Dec 2024 22:06:21 +0100
Message-ID: <CAAibmn3STc4hWJPfDtdp2rDscx_8cO=cO4JA=qhneif03Jf9QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c039cc062991c9ce"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a29;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000c039cc062991c9ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 at 02:19, Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu Dec 12, 2024 at 8:41 PM AEST, Phil Dennis-Jordan wrote:
> > Hey Nicholas,
> >
> > I'm not an XHCI & PCI expert (yet?) so apologies if I've got some of th=
is
> > wrong, but I've asked some questions and made some comments inline:
>
> Hey Phil,
>
> Thanks for the review, looks like you are the expert now :)
>

The "hot potato" method for determining maintainership. :-)


> >
> > On Thu, 12 Dec 2024 at 09:52, Nicholas Piggin <npiggin@gmail.com> wrote=
:
> >
> > > To prepare to support another USB PCI Host Controller, make some PCI
> > > configuration dynamic.
> > >
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >  hw/usb/hcd-xhci-pci.h |  9 ++++++
> > >  hw/usb/hcd-xhci-nec.c | 10 +++++++
> > >  hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++-----=
--
> > >  3 files changed, 78 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
> > > index 08f70ce97cc..213076aabf6 100644
> > > --- a/hw/usb/hcd-xhci-pci.h
> > > +++ b/hw/usb/hcd-xhci-pci.h
> > > @@ -40,6 +40,15 @@ typedef struct XHCIPciState {
> > >      XHCIState xhci;
> > >      OnOffAuto msi;
> > >      OnOffAuto msix;
> > > +    uint8_t cache_line_size;
> > > +    uint8_t pm_cap_off;
> > > +    uint8_t pcie_cap_off;
> > > +    uint8_t msi_cap_off;
> > > +    uint8_t msix_cap_off;
> > > +    int msix_bar_nr;
> > > +    uint64_t msix_bar_size;
> > > +    uint32_t msix_table_off;
> > > +    uint32_t msix_pba_off;
> > >  } XHCIPciState;
> > >
> > >  #endif
> > > diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> > > index 0e61c6c4f06..6ac1dc7764c 100644
> > > --- a/hw/usb/hcd-xhci-nec.c
> > > +++ b/hw/usb/hcd-xhci-nec.c
> > > @@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj)
> > >
> > >      pci->xhci.numintrs =3D nec->intrs;
> > >      pci->xhci.numslots =3D nec->slots;
> > > +
> > > +    pci->cache_line_size =3D 0x10;
> > > +    pci->pm_cap_off =3D 0;
> > > +    pci->pcie_cap_off =3D 0xa0;
> > > +    pci->msi_cap_off =3D 0x70;
> > > +    pci->msix_cap_off =3D 0x90;
> > > +    pci->msix_bar_nr =3D 0;
> > > +    pci->msix_bar_size =3D 0;
> > > +    pci->msix_table_off =3D 0x3000;
> > > +    pci->msix_pba_off =3D 0x3800;
> > >  }
> >
> >
> > What about the "qemu-xhci" device, does that need similar treatment? I
> > suspect it does at least for a bunch of these settings. Perhaps
> > xhci_instance_init() in the abstract "pci-xhci" base might be a better
> > place for these "sensible defaults" and then override them only in the
> > specific implementations that need to do so, such as the new TI model?
> > And/or have suitably named helper init function for configuring
> single-BAR
> > PCI XHCI controllers so we can get some meaning behind all these magic
> > numbers?
>
> No you're right, I missed this entirely and the qemu-xhci dev is
> indeed broken after this patch. Just moving it into the parent
> instance init gets it to work.
>
> > >  static void nec_xhci_class_init(ObjectClass *klass, void *data)
> > > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> > > index a039f5778a6..948d75b7379 100644
> > > --- a/hw/usb/hcd-xhci-pci.c
> > > +++ b/hw/usb/hcd-xhci-pci.c
> > > @@ -32,8 +32,9 @@
> > >  #include "trace.h"
> > >  #include "qapi/error.h"
> > >
> > > -#define OFF_MSIX_TABLE  0x3000
> > > -#define OFF_MSIX_PBA    0x3800
> > > +#define MSIX_BAR_SIZE   0x800000
> > >
> >
> > MSIX_BAR_SIZE doesn't seem to be used anywhere, and patch 2/2 uses
> 0x800000
> > explicitly. (8 MiB also seems=E2=80=A6 huge? But I'm guessing you're ma=
tching
> this
> > with the physical TI controller hardware - either way I don't think it
> > belongs in this file.)
> >
> >
> > > +#define OFF_MSIX_TABLE  0x0000
> > > +#define OFF_MSIX_PBA    0x1000
> > >
> >
> > Maybe instead of redefining these constants to only apply to the split
> BAR
> > device variants, there should be 2 variants of them, one for single-BAR
> > controllers, and one for controllers with separate BARs. That would als=
o
> > help make sense of the "magic numbers" in nec_xhci_instance_init().
>
> You're right on both counts, I tidied these up.
>
> > >  static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable=
)
> > >  {
> > > @@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void
> *opaque,
> > > int version_id)
> > >     return 0;
> > >  }
> > >
> > > +static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t
> offset,
> > > +                                      Error **errp)
> > > +{
> > > +    int err;
> > > +
> > > +    err =3D pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
> > > +                             PCI_PM_SIZEOF, errp);
> > > +    if (err < 0) {
> > > +        return err;
> > > +    }
> > > +
> > > +    pci_set_word(pci_dev->config + offset + PCI_PM_PMC,
> > > +                 PCI_PM_CAP_VER_1_2 |
> > > +                 PCI_PM_CAP_D1 | PCI_PM_CAP_D2 |
> > > +                 PCI_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |
> > > +                 PCI_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);
> > > +    pci_set_word(pci_dev->wmask + offset + PCI_PM_PMC, 0);
> > > +    pci_set_word(pci_dev->config + offset + PCI_PM_CTRL,
> > > +                 PCI_PM_CTRL_NO_SOFT_RESET);
> > > +    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
> > > +                 PCI_PM_CTRL_STATE_MASK);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp=
)
> > >  {
> > >      int ret;
> > > @@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice
> > > *dev, Error **errp)
> > >
> > >      dev->config[PCI_CLASS_PROG] =3D 0x30;    /* xHCI */
> > >      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin 1 */
> > > -    dev->config[PCI_CACHE_LINE_SIZE] =3D 0x10;
> > > +    dev->config[PCI_CACHE_LINE_SIZE] =3D s->cache_line_size;
> > >      dev->config[0x60] =3D 0x30; /* release number */
> > >
> > >      object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s),
> NULL);
> > > @@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevic=
e
> > > *dev, Error **errp)
> > >          s->xhci.nec_quirks =3D true;
> > >      }
> > >
> > > +    if (s->pm_cap_off) {
> > > +        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
> > > +            error_propagate(errp, err);
> > > +            return;
> > >
> >
> > Can't we just pass errp straight to xhci_pci_add_pm_capability and skip
> the
> > error_propagate() here?
>
> Yes I think so.
>
> > > +        }
> > > +    }
> > > +
> > >      if (s->msi !=3D ON_OFF_AUTO_OFF) {
> > > -        ret =3D msi_init(dev, 0x70, s->xhci.numintrs, true, false,
> &err);
> > > +        ret =3D msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
> > > +                       true, false, &err);
> > >          /*
> > >           * Any error other than -ENOTSUP(board's MSI support is
> broken)
> > >           * is a programming error
> > > @@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevi=
ce
> > > *dev, Error **errp)
> > >          /* With msi=3Dauto, we fall back to MSI off silently */
> > >          error_free(err);
> > >      }
> > > +
> > >      pci_register_bar(dev, 0,
> > >                       PCI_BASE_ADDRESS_SPACE_MEMORY |
> > >                       PCI_BASE_ADDRESS_MEM_TYPE_64,
> > >                       &s->xhci.mem);
> > >
> > >      if (pci_bus_is_express(pci_get_bus(dev))) {
> > > -        ret =3D pcie_endpoint_cap_init(dev, 0xa0);
> > > +        ret =3D pcie_endpoint_cap_init(dev, s->pcie_cap_off);
> > >          assert(ret > 0);
> > >      }
> > >
> > >      if (s->msix !=3D ON_OFF_AUTO_OFF) {
> > > -        /* TODO check for errors, and should fail when msix=3Don */
> > > -        msix_init(dev, s->xhci.numintrs,
> > > -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> > > -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> > > -                  0x90, NULL);
> > > +        MemoryRegion *msix_bar =3D &s->xhci.mem;
> > > +        if (s->msix_bar_nr !=3D 0) {
> > > +            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev)=
,
> > > +                               "xhci-msix", s->msix_bar_size);
> > > +            msix_bar =3D &dev->msix_exclusive_bar;
> > > +        }
> > > +
> > > +        ret =3D msix_init(dev, s->xhci.numintrs,
> > > +                        msix_bar, s->msix_bar_nr, s->msix_table_off,
> > > +                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
> > > +                        s->msix_cap_off, errp);
> > > +        if (ret) {
> > > +            return;
> > > +        }
> > >
> >
> > Surely we should only propagate the error and fail realize() iff s->msi=
x
> is
> > ON_OFF_AUTO_ON?
> >
> > For ON_OFF_AUTO_AUTO, msix_init returning failure isn't a critical erro=
r.
>
> Yep you're right... you had been testing with msix disabled. I wonder if
> there is a good way to force fail this in qtests?
>

I'm really the wrong person to ask about qtest, I'm only just beginning to
get to grips with it. It seems the only real reason msix_init fails other
than misconfiguration of the device/BAR is when msi_nonbroken =3D false.

At least on x86(-64), msi_nonbroken=3Dtrue is unconditionally set in
apic_realize(). (I think real hardware would not support MSI(-X) on the
i440FX chipset - I was fairly certain it was the PCI root/southbridge
catching the writes to the reserved memory region, and I didn't think the
PIIX did this; but at least in QEMU it doesn't seem to be implemented in a
chipset-dependent way.) I'm not sure it's possible to run QEMU without an
APIC?

On aarch64, the GICv3 needs to explicitly enable support (via the ITS), so
perhaps it's possible to set up an aarch64 qtest with ITS disabled? It
looks like the 'virt' machine type only supports the ITS from version 6.2,
so older versions will disable it.

Sorry, clutching at straws here.


> > > +
> > > +        pci_register_bar(dev, s->msix_bar_nr,
> > > +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> > > +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> > > +                         msix_bar);
> > >
> >
> > Is it safe to call pci_register_bar() again for the msix_bar_nr =3D 0 c=
ase?
> > Even if it is safe, is it sensible? If we're calling it twice for the
> same
> > BAR, and the arguments of either of the calls changes in future, the
> other
> > needs to change too. Doesn't seem ideal.
>
> Good catch. It looks like it "works" so long as the bar wasn't mapped,
> but I'm sure bad practice... Interesting there is no assertion in
> there though. I'll fix it though.
>

I notice there's a msix_init_exclusive_bar()=E2=80=A6 I wonder if it'd be s=
impler
to use that and modify it so it allows you to choose a size and layout for
the BAR, rather than adding all that extra code to deal with the extra BAR
in the XHCI?
(It already calls pci_register_bar() and msix_init() internally, but seems
to set the BAR's size to 4096 and places the PBA at halfway through the
BAR. Perhaps rename it to something like
msix_init_exclusive_bar_with_layout and pass the bar_size and
bar_pba_offset in as parameters; then make msix_init_exclusive_bar() a
wrapper for that function with the existing defaults for those variables?)

Just kicking around some ideas here, I have no idea if that actually ends
up making things simpler=E2=80=A6


> Thanks,
> Nick
>

--000000000000c039cc062991c9ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 18 Dec =
2024 at 02:19, Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npi=
ggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Thu Dec 12, 2024 at 8:41 PM AEST, Phil Dennis-Jordan wrote=
:<br>
&gt; Hey Nicholas,<br>
&gt;<br>
&gt; I&#39;m not an XHCI &amp; PCI expert (yet?) so apologies if I&#39;ve g=
ot some of this<br>
&gt; wrong, but I&#39;ve asked some questions and made some comments inline=
:<br>
<br>
Hey Phil,<br>
<br>
Thanks for the review, looks like you are the expert now :)<br></blockquote=
><div><br></div><div>The &quot;hot potato&quot; method for determining main=
tainership. :-)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt;<br>
&gt; On Thu, 12 Dec 2024 at 09:52, Nicholas Piggin &lt;<a href=3D"mailto:np=
iggin@gmail.com" target=3D"_blank">npiggin@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; To prepare to support another USB PCI Host Controller, make some =
PCI<br>
&gt; &gt; configuration dynamic.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmai=
l.com" target=3D"_blank">npiggin@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/usb/hcd-xhci-pci.h |=C2=A0 9 ++++++<br>
&gt; &gt;=C2=A0 hw/usb/hcd-xhci-nec.c | 10 +++++++<br>
&gt; &gt;=C2=A0 hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++=
++++-------<br>
&gt; &gt;=C2=A0 3 files changed, 78 insertions(+), 10 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h<br>
&gt; &gt; index 08f70ce97cc..213076aabf6 100644<br>
&gt; &gt; --- a/hw/usb/hcd-xhci-pci.h<br>
&gt; &gt; +++ b/hw/usb/hcd-xhci-pci.h<br>
&gt; &gt; @@ -40,6 +40,15 @@ typedef struct XHCIPciState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 XHCIState xhci;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 OnOffAuto msi;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 OnOffAuto msix;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t cache_line_size;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t pm_cap_off;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t pcie_cap_off;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t msi_cap_off;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t msix_cap_off;<br>
&gt; &gt; +=C2=A0 =C2=A0 int msix_bar_nr;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t msix_bar_size;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t msix_table_off;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t msix_pba_off;<br>
&gt; &gt;=C2=A0 } XHCIPciState;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt; diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c<br>
&gt; &gt; index 0e61c6c4f06..6ac1dc7764c 100644<br>
&gt; &gt; --- a/hw/usb/hcd-xhci-nec.c<br>
&gt; &gt; +++ b/hw/usb/hcd-xhci-nec.c<br>
&gt; &gt; @@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj=
)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pci-&gt;xhci.numintrs =3D nec-&gt;intrs;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pci-&gt;xhci.numslots =3D nec-&gt;slots;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;cache_line_size =3D 0x10;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;pm_cap_off =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;pcie_cap_off =3D 0xa0;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;msi_cap_off =3D 0x70;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;msix_cap_off =3D 0x90;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;msix_bar_nr =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;msix_bar_size =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;msix_table_off =3D 0x3000;<br>
&gt; &gt; +=C2=A0 =C2=A0 pci-&gt;msix_pba_off =3D 0x3800;<br>
&gt; &gt;=C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt; What about the &quot;qemu-xhci&quot; device, does that need similar tr=
eatment? I<br>
&gt; suspect it does at least for a bunch of these settings. Perhaps<br>
&gt; xhci_instance_init() in the abstract &quot;pci-xhci&quot; base might b=
e a better<br>
&gt; place for these &quot;sensible defaults&quot; and then override them o=
nly in the<br>
&gt; specific implementations that need to do so, such as the new TI model?=
<br>
&gt; And/or have suitably named helper init function for configuring single=
-BAR<br>
&gt; PCI XHCI controllers so we can get some meaning behind all these magic=
<br>
&gt; numbers?<br>
<br>
No you&#39;re right, I missed this entirely and the qemu-xhci dev is<br>
indeed broken after this patch. Just moving it into the parent<br>
instance init gets it to work.<br>
<br>
&gt; &gt;=C2=A0 static void nec_xhci_class_init(ObjectClass *klass, void *d=
ata)<br>
&gt; &gt; diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c<br>
&gt; &gt; index a039f5778a6..948d75b7379 100644<br>
&gt; &gt; --- a/hw/usb/hcd-xhci-pci.c<br>
&gt; &gt; +++ b/hw/usb/hcd-xhci-pci.c<br>
&gt; &gt; @@ -32,8 +32,9 @@<br>
&gt; &gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; &gt;<br>
&gt; &gt; -#define OFF_MSIX_TABLE=C2=A0 0x3000<br>
&gt; &gt; -#define OFF_MSIX_PBA=C2=A0 =C2=A0 0x3800<br>
&gt; &gt; +#define MSIX_BAR_SIZE=C2=A0 =C2=A00x800000<br>
&gt; &gt;<br>
&gt;<br>
&gt; MSIX_BAR_SIZE doesn&#39;t seem to be used anywhere, and patch 2/2 uses=
 0x800000<br>
&gt; explicitly. (8 MiB also seems=E2=80=A6 huge? But I&#39;m guessing you&=
#39;re matching this<br>
&gt; with the physical TI controller hardware - either way I don&#39;t thin=
k it<br>
&gt; belongs in this file.)<br>
&gt;<br>
&gt;<br>
&gt; &gt; +#define OFF_MSIX_TABLE=C2=A0 0x0000<br>
&gt; &gt; +#define OFF_MSIX_PBA=C2=A0 =C2=A0 0x1000<br>
&gt; &gt;<br>
&gt;<br>
&gt; Maybe instead of redefining these constants to only apply to the split=
 BAR<br>
&gt; device variants, there should be 2 variants of them, one for single-BA=
R<br>
&gt; controllers, and one for controllers with separate BARs. That would al=
so<br>
&gt; help make sense of the &quot;magic numbers&quot; in nec_xhci_instance_=
init().<br>
<br>
You&#39;re right on both counts, I tidied these up.<br>
<br>
&gt; &gt;=C2=A0 static void xhci_pci_intr_update(XHCIState *xhci, int n, bo=
ol enable)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; @@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *=
opaque,<br>
&gt; &gt; int version_id)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_=
t offset,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error=
 **errp)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 int err;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 err =3D pci_add_capability(pci_dev, PCI_CAP_ID_PM,=
 offset,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_SIZEOF, errp);<br>
&gt; &gt; +=C2=A0 =C2=A0 if (err &lt; 0) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;config + offset + PCI_PM_=
PMC,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PC=
I_PM_CAP_VER_1_2 |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PC=
I_PM_CAP_D1 | PCI_PM_CAP_D2 |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PC=
I_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PC=
I_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);<br>
&gt; &gt; +=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;wmask + offset + PCI_PM_P=
MC, 0);<br>
&gt; &gt; +=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;config + offset + PCI_PM_=
CTRL,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PC=
I_PM_CTRL_NO_SOFT_RESET);<br>
&gt; &gt; +=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;wmask + offset + PCI_PM_C=
TRL,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PC=
I_PM_CTRL_STATE_MASK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 static void usb_xhci_pci_realize(struct PCIDevice *dev, Err=
or **errp)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; @@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDe=
vice<br>
&gt; &gt; *dev, Error **errp)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 dev-&gt;config[PCI_CLASS_PROG] =3D 0x30;=C2=
=A0 =C2=A0 /* xHCI */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 dev-&gt;config[PCI_INTERRUPT_PIN] =3D 0x01; /=
* interrupt pin 1 */<br>
&gt; &gt; -=C2=A0 =C2=A0 dev-&gt;config[PCI_CACHE_LINE_SIZE] =3D 0x10;<br>
&gt; &gt; +=C2=A0 =C2=A0 dev-&gt;config[PCI_CACHE_LINE_SIZE] =3D s-&gt;cach=
e_line_size;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 dev-&gt;config[0x60] =3D 0x30; /* release num=
ber */<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_link(OBJECT(&amp;s-&gt;xh=
ci), &quot;host&quot;, OBJECT(s), NULL);<br>
&gt; &gt; @@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCID=
evice<br>
&gt; &gt; *dev, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;xhci.nec_quirks =3D true;=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 if (s-&gt;pm_cap_off) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xhci_pci_add_pm_capability(dev, =
s-&gt;pm_cap_off, &amp;err)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, =
err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;<br>
&gt;<br>
&gt; Can&#39;t we just pass errp straight to xhci_pci_add_pm_capability and=
 skip the<br>
&gt; error_propagate() here?<br>
<br>
Yes I think so.<br>
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (s-&gt;msi !=3D ON_OFF_AUTO_OFF) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D msi_init(dev, 0x70, s-&gt;xh=
ci.numintrs, true, false, &amp;err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D msi_init(dev, s-&gt;msi_cap_=
off, s-&gt;xhci.numintrs,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0true, false, &amp;err);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Any error other than -E=
NOTSUP(board&#39;s MSI support is broken)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is a programming error<=
br>
&gt; &gt; @@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCI=
Device<br>
&gt; &gt; *dev, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* With msi=3Dauto, we fall bac=
k to MSI off silently */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(err);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pci_register_bar(dev, 0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PCI_BASE_ADDRESS_SPACE_MEMORY |<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PCI_BASE_ADDRESS_MEM_TYPE_64,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;s-&gt;xhci.mem);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (pci_bus_is_express(pci_get_bus(dev))) {<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pcie_endpoint_cap_init(dev, =
0xa0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pcie_endpoint_cap_init(dev, =
s-&gt;pcie_cap_off);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ret &gt; 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (s-&gt;msix !=3D ON_OFF_AUTO_OFF) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO check for errors, and should=
 fail when msix=3Don */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 msix_init(dev, s-&gt;xhci.numintrs,<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;s-&gt;xhci.mem, 0, OFF_MSIX_TABLE,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;s-&gt;xhci.mem, 0, OFF_MSIX_PBA,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
x90, NULL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *msix_bar =3D &amp;s-&g=
t;xhci.mem;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;msix_bar_nr !=3D 0) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init(&am=
p;dev-&gt;msix_exclusive_bar, OBJECT(dev),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;xhci-msix&quot;, s-&g=
t;msix_bar_size);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msix_bar =3D &amp;dev-=
&gt;msix_exclusive_bar;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D msix_init(dev, s-&gt;xhci.nu=
mintrs,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 msix_bar, s-&gt;msix_bar_nr, s-&gt;msix_table_off,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 msix_bar, s-&gt;msix_bar_nr, s-&gt;msix_pba_off,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s-&gt;msix_cap_off, errp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt;<br>
&gt; Surely we should only propagate the error and fail realize() iff s-&gt=
;msix is<br>
&gt; ON_OFF_AUTO_ON?<br>
&gt;<br>
&gt; For ON_OFF_AUTO_AUTO, msix_init returning failure isn&#39;t a critical=
 error.<br>
<br>
Yep you&#39;re right... you had been testing with msix disabled. I wonder i=
f<br>
there is a good way to force fail this in qtests?<br></blockquote><div><br>=
</div><div>I&#39;m really the wrong person to ask about qtest, I&#39;m only=
 just beginning to get to grips with it. It seems the only real reason msix=
_init fails other than misconfiguration of the device/BAR is when msi_nonbr=
oken =3D false.</div><div><br></div><div>At least on x86(-64), msi_nonbroke=
n=3Dtrue is unconditionally set in apic_realize(). (I think real hardware w=
ould not support MSI(-X) on the i440FX chipset - I was fairly certain it wa=
s the PCI root/southbridge catching the writes to the reserved memory regio=
n, and I didn&#39;t think the PIIX did this; but at least in QEMU it doesn&=
#39;t seem to be implemented in a chipset-dependent way.) I&#39;m not sure =
it&#39;s possible to run QEMU without an APIC?</div><div><br></div><div>On =
aarch64, the GICv3 needs to explicitly enable support (via the ITS), so per=
haps it&#39;s possible to set up an aarch64 qtest with ITS disabled? It loo=
ks like the &#39;virt&#39; machine type only supports the ITS from version =
6.2, so older versions will disable it.</div><div><br></div><div>Sorry, clu=
tching at straws here.<br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_register_bar(dev, s-&gt;msix_bar=
_nr,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_BASE_ADDRESS_SPACE_MEMORY |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_BASE_ADDRESS_MEM_TYPE_64,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0msix_bar);<br>
&gt; &gt;<br>
&gt;<br>
&gt; Is it safe to call pci_register_bar() again for the msix_bar_nr =3D 0 =
case?<br>
&gt; Even if it is safe, is it sensible? If we&#39;re calling it twice for =
the same<br>
&gt; BAR, and the arguments of either of the calls changes in future, the o=
ther<br>
&gt; needs to change too. Doesn&#39;t seem ideal.<br>
<br>
Good catch. It looks like it &quot;works&quot; so long as the bar wasn&#39;=
t mapped,<br>
but I&#39;m sure bad practice... Interesting there is no assertion in<br>
there though. I&#39;ll fix it though.<br></blockquote><div><br></div><div>I=
 notice there&#39;s a msix_init_exclusive_bar()=E2=80=A6 I wonder if it&#39=
;d be simpler to use that and modify it so it allows you to choose a size a=
nd layout for the BAR, rather than adding all that extra code to deal with =
the extra BAR in the XHCI?</div><div>(It already calls pci_register_bar() a=
nd msix_init() internally, but seems to set the BAR&#39;s size to 4096 and =
places the PBA at halfway through the BAR. Perhaps rename it to something l=
ike msix_init_exclusive_bar_with_layout and pass the bar_size and bar_pba_o=
ffset in as parameters; then make msix_init_exclusive_bar() a wrapper for t=
hat function with the existing defaults for those variables?)<br></div><div=
><br></div><div>Just kicking around some ideas here, I have no idea if that=
 actually ends up making things simpler=E2=80=A6<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
Nick<br>
</blockquote></div></div>

--000000000000c039cc062991c9ce--

