Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8CDD10DCF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI34q-0006pZ-SI; Mon, 02 Dec 2024 04:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tI33Z-0006R3-Iy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:49:29 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tI33W-0008Rs-0Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:49:29 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4addd900de1so1100103137.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733132963; x=1733737763;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PVT5FhmxHQ18fK/q3/FxsOfzvEVcMbFkl9IjIJ3I9MQ=;
 b=JuH5Tz4xZx4Q5oNZTMb7+c8aSDoF7yJhTSuycoatTuCz4FRhQDkqwjy2Zkfre6hHdP
 +YJUreOl1F7Ck7z5krLTQr+Svb7hw+jkka/LzQEY/uI1FWM55jKso5NanHXRBHATaVw8
 AJsRJFkShEFMePpojPTe9DlrrAYSzPTtDVxXLl9mf6Ke2haM2pB0+89dgxtw7AnkiNfB
 2qDtxUGcJaNEbhyNwWJwqmimTvmyH6gFzppAhddo/Wkx30JO+orp5+wJHMmgjoUQENP3
 4TE4kJ94LVHqxCKdvk8TWIugtqyOtVMEaJ8pmsXQENyvLRbtW+MQyWGFBAPopR+oNySi
 7/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733132963; x=1733737763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVT5FhmxHQ18fK/q3/FxsOfzvEVcMbFkl9IjIJ3I9MQ=;
 b=p+QuD3xG/DwtZzzJnbfvTLcutp21FumNeA6KT4ie7IgXVqQPph3psnAT/9P680mDiF
 K2Ly2YeaIlS1K6YLRWAuRzhaSqpRfBnkwY7V7ZU85Eod8SHhUyjSp17FjSNV3AJVUFNe
 Q/bd5eCPoq+9EamjnrJlyuhT2BzyMxyINWx5awpga/VSXGUBpPz8Lh9Nbqv5aCX4DFac
 qIxjpXeDgD4jdwXFqUIPDB6Nae9Fx/HG8JOxdVQP9mczJqWpibuxsCcqfaPqaWZr6nak
 D++Ao8ii9RDyleRhsGRE3ZxP3CBbHOgmuPqPn/aO8+ZthRC2V7hI38FiK37YQ5654Ezx
 jakg==
X-Gm-Message-State: AOJu0Yx6AlRaoloNSgftVpsTupdzT0xwYEmt3yZIDpssdMNBfMpvBEaO
 H7lrjYsUkUhXaVFet5nF1slja2KP0vVjq9ds4m9IlKqcwS4R+J/fyyTh3XMTnF3vJST+vUObrFH
 QUpLZ3nFuNLOvkJ7LsBjQcXkUnjB+ZLPmvYGz
X-Gm-Gg: ASbGnctUCE3Yowp4/rCy0rfTMxOBW40oFy7qK+jE91XVBHFSNA/GHWlCCLQy4yKb+OW
 TEFT421CEji2upDCrBmbNh2Am61m5v3Q=
X-Google-Smtp-Source: AGHT+IGiMsTrm5xJdEAYxwK1+eySE6NOB+g4vKkYx5gZSHs6uEtlnax6m9vlp4E5Gm9wsx3i1lFN84g55Sx+YXloMDg=
X-Received: by 2002:a05:6102:f0a:b0:4af:31c0:ce42 with SMTP id
 ada2fe7eead31-4af4460ecffmr29000762137.0.1733132963119; Mon, 02 Dec 2024
 01:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20241201160316.96121-1-phil@philjordan.eu>
 <a3812fbe-f5b7-442c-8140-54e87da6a78c@daynix.com>
In-Reply-To: <a3812fbe-f5b7-442c-8140-54e87da6a78c@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 2 Dec 2024 10:49:12 +0100
Message-ID: <CAAibmn1c45kjKkDZAmWmwwZZJ2hv88UgadBffid81=wXg91HYw@mail.gmail.com>
Subject: Re: [PATCH RFC-for-10.0] hw/usb/hcd-xhci-pci: Use event ring 0 if
 interrupter mapping unsupported
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 thuth@redhat.com, zhao1.liu@intel.com, imammedo@redhat.com
Content-Type: multipart/alternative; boundary="0000000000009d9c9906284676a1"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e35;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe35.google.com
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

--0000000000009d9c9906284676a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 06:39, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/12/02 1:03, Phil Dennis-Jordan wrote:
> > This change addresses an edge case that trips up macOS guest drivers
> > for PCI based XHCI controllers.
> >
> > The XHCI specification, section 4.17.1 specifies that "If Interrupter
> > Mapping is not supported, the Interrupter Target field shall be
> > ignored by the xHC and all Events targeted at Interrupter 0."
> >
> > The PCI XHCI controller supports MSI(-X) and maxintrs is therefore
> > reasonably set to 16. The specification does not address whether
> > interrupter mapping should be considered "supported" if the guest
> > driver does not enable MSI(-X) via the PCI configuration area, possibly
> > because the PCI host bus does not support it.
>
> This section says "an xHC implementation may support Interrupter
> Mapping," and section 3 says "Host Controller (xHC). The host controller
> is the specific hardware implementation of the host controller
> architecture." So the entity that "supports" interrupt mapping is the
> hardware and does not include the guest driver.
>

I wasn't talking about the driver in this context - I'm questioning whether
there is any reasonable interpretation where hardware should be considered
to support interrupter mapping when it is configured to use pin-based
interrupts.

>
> > QEMU's XHCI device has so far not specially addressed this case, and
> > no interrupt is generated for events delivered to event rings 1 and
> > above. The macOS guest driver does not get along with this
> > interpretation, so many events are not delivered to the guest OS when
> > MSI(-X) is off.
> >
> > This patch changes the xhci_event() function such that event ring 0
> > is always used when numintrs is 1 (as per spec section 4.17.1) or
> > if neither MSI nor MSI-X are enabled. The latter is checked by adding
> > a new, optional intr_mapping_supported function pointer field supplied
> > by the concrete XHCI controller implementation. The PCI implementation'=
s
> > supplied function calls msix_enabled and msi_enabled accordingly.
>
> I think the current behavior to drop interrupts is correct and targeting
> Interrupter 0 is a violation of the specification.
>
> As noted earlier, this xHC implementation supports Interrupter Mapping,
> so it must target Interrupters 1 to MaxInstrs-1 instead of always
> targeting Interrupter 0.
>
> At the beginning of section 4.7, the specification also says "an
> Interrupter shall assert an interrupt if it is enabled and its
> associated Event Ring contains Event TRBs that require an interrupt".


Unfortunately, this is an ambiguous wording - "it" could refer to either
the interrupt or the interrupter, and I suspect it is talking about the IE
flag. The IE flag is called "Interrupt Enable," not "InterruptER Enable."
(If it's off, you can still use the Event Ring in polling mode - the
interruptER includes the event ring, the flag only applies to interrupt
delivery.) On the other hand, there is an "InterruptER Enable" (INTE) flag
in the USBCMD register - but there's only one, which covers all the
interrupters available.

On the other hand, in 4.2 it says "Enable the Interrupter by writing a '1'
to the Interrupt Enable (IE) field=E2=80=A6".

So the terminology is not consistent.


> It
> also says "interrupters 1 to MaxIntrs-1 shall be disabled" "when the PCI
> Pin Interrupt is activated". So disabled Interrupters must drop interrupt=
s.
>

What does disabling the Interrupter (again, not the interrupt) mean? The
Event Ring is part of the Interrupter. So if the interrupter is disabled,
is the ring disabled? If the ring is disabled, should the hardware really
be dispatching events to it?

While the proposed behavior violates the specification, it is still
> crucial to run macOS guests. A possible solution is to add a property to
> enable this behavior not conforming to the specification, and requires
> users to opt-in it when running macOS.
>

It's certainly a possibility - but it adds user-facing complexity for no
discernible gain. Users of non-macOS guests won't care which way the flag
is set because it doesn't affect them, and the default setting won't work
for macOS guest users, meaning they need to research what's going on if
they're hit by the problem. OK, we can enable it by default for the vmapple
machine type, and most users of x86-64 macOS guests will be using the Q35
machine type, where MSI-X is functional. I'm just not convinced the higher
complexity(*) is worth a user setting that no user will ever change.

(* And it WILL be higher complexity, because you definitely need to insert
the condition in xhci_event(). This isn't fixable with just a tweak in
xhci_pci_intr_raise, say - the HCI needs to behave as if interrupter
mapping was unsupported, or it won't work.)

>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
> > ---
> > I've been chasing this problem for a while, and I've finally figured
> > out the cause, and I think an acceptable solution. I've explained the
> > problem and quoted the relevant sections of the XHCI spec in more
> > detail in the linked GitLab issue:
> >
> > https://gitlab.com/qemu-project/qemu/-/issues/2705
> >
> > The fix provided is I think the simplest one in terms of lines of code,
> > but it's also a little ugly, as we're constantly checking msix_enabled
> > and msi_enabled via a callback function. Granted, we're already doing
> > that in xhci_pci_intr_raise and xhci_pci_intr_update, but this adds
> > a bunch more calls.
>
> The fact that macOS rejects xHC with numintrs < 4 implies macOS still
> expects multiple Interrupters are enabled, but all Interrupters assert
> the INTx# pin. Implementation of such a behavior will be contained in
> xhci_pci_intr_raise() so we can save an indirection call of
> intr_mapping_supported() as a bonus.
>

It's not as simple as redirecting xhci_pci_intr_raise for n !=3D 0 to still
trigger the pin-based interrupt when MSI(-X) is disabled with macOS guests.
For one, pin-based interrupts are level-triggered, so you have to cheat
with the IMAN_IP state. Even then though, the macOS guest will only process
event rings for which it received an interrupt, which makes some sense, as
there's no point having multiple rings if you're going to check all of them
when you receive an interrupt for only one of them.


> Regards,
> Akihiko Odaki
>
> >
> > The main alternative I can see is to "push" the state of whether
> > interrupter mapping is supported: provide a custom config_write
> > implementation for the PCI device, and every time the configuration
> > area is updated, evaluate whether or not this means that MSI or MSI-X
> > are enabled and update a corresponding flag inside XHCIState. We could
> > even use this opportunity to switch out different .intr_raise and
> > .intr_update functions depending on which interrupt delivery mechanism
> > is active in the PCI device.
> >
> >
> >   hw/usb/hcd-xhci-pci.c | 9 +++++++++
> >   hw/usb/hcd-xhci.c     | 5 +++++
> >   hw/usb/hcd-xhci.h     | 5 +++++
> >   3 files changed, 19 insertions(+)
> >
> > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> > index a039f5778a6..21802211cf7 100644
> > --- a/hw/usb/hcd-xhci-pci.c
> > +++ b/hw/usb/hcd-xhci-pci.c
> > @@ -81,6 +81,14 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int
> n, bool level)
> >       return false;
> >   }
> >
> > +static bool xhci_pci_intr_mapping_supported(XHCIState *xhci)
> > +{
> > +    XHCIPciState *s =3D container_of(xhci, XHCIPciState, xhci);
> > +    PCIDevice *pci_dev =3D PCI_DEVICE(s);
> > +
> > +    return msix_enabled(pci_dev) || msi_enabled(pci_dev);
> > +}
> > +
> >   static void xhci_pci_reset(DeviceState *dev)
> >   {
> >       XHCIPciState *s =3D XHCI_PCI(dev);
> > @@ -118,6 +126,7 @@ static void usb_xhci_pci_realize(struct PCIDevice
> *dev, Error **errp)
> >       object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s),
> NULL);
> >       s->xhci.intr_update =3D xhci_pci_intr_update;
> >       s->xhci.intr_raise =3D xhci_pci_intr_raise;
> > +    s->xhci.intr_mapping_supported =3D xhci_pci_intr_mapping_supported=
;
> >       if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
> >           return;
> >       }
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index d85adaca0dc..a2a878e4594 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -644,6 +644,11 @@ static void xhci_event(XHCIState *xhci, XHCIEvent
> *event, int v)
> >       dma_addr_t erdp;
> >       unsigned int dp_idx;
> >
> > +    if (xhci->numintrs =3D=3D 1 ||
> > +        (xhci->intr_mapping_supported &&
> !xhci->intr_mapping_supported(xhci))) {
> > +        v =3D 0; /* Per section 4.17.1 */
> > +    }
> > +
> >       if (v >=3D xhci->numintrs) {
> >           DPRINTF("intr nr out of range (%d >=3D %d)\n", v,
> xhci->numintrs);
> >           return;
> > diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> > index fe16d7ad055..6e901de6e6b 100644
> > --- a/hw/usb/hcd-xhci.h
> > +++ b/hw/usb/hcd-xhci.h
> > @@ -193,6 +193,11 @@ typedef struct XHCIState {
> >       uint32_t max_pstreams_mask;
> >       void (*intr_update)(XHCIState *s, int n, bool enable);
> >       bool (*intr_raise)(XHCIState *s, int n, bool level);
> > +    /*
> > +     * Device supports Interrupter Mapping per section 4.17.1 of XHCI
> spec.
> > +     * If NULL, assume true if numintrs > 1.
> > +     */
> > +    bool (*intr_mapping_supported)(XHCIState *s);
> >       DeviceState *hostOpaque;
> >
> >       /* Operational Registers */
>
>

--0000000000009d9c9906284676a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 2 Dec 2=
024 at 06:39, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com"=
>akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 2024/12/02 1:03, Phil Dennis-Jordan wrote:<br>
&gt; This change addresses an edge case that trips up macOS guest drivers<b=
r>
&gt; for PCI based XHCI controllers.<br>
&gt; <br>
&gt; The XHCI specification, section 4.17.1 specifies that &quot;If Interru=
pter<br>
&gt; Mapping is not supported, the Interrupter Target field shall be<br>
&gt; ignored by the xHC and all Events targeted at Interrupter 0.&quot;<br>
&gt; <br>
&gt; The PCI XHCI controller supports MSI(-X) and maxintrs is therefore<br>
&gt; reasonably set to 16. The specification does not address whether<br>
&gt; interrupter mapping should be considered &quot;supported&quot; if the =
guest<br>
&gt; driver does not enable MSI(-X) via the PCI configuration area, possibl=
y<br>
&gt; because the PCI host bus does not support it.<br>
<br>
This section says &quot;an xHC implementation may support Interrupter <br>
Mapping,&quot; and section 3 says &quot;Host Controller (xHC). The host con=
troller <br>
is the specific hardware implementation of the host controller <br>
architecture.&quot; So the entity that &quot;supports&quot; interrupt mappi=
ng is the <br>
hardware and does not include the guest driver.<br></blockquote><div><br></=
div><div>I wasn&#39;t talking about the driver in this context - I&#39;m qu=
estioning whether there is any reasonable interpretation where hardware sho=
uld be considered to support interrupter mapping when it is configured to u=
se pin-based interrupts.<br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
&gt; <br>
&gt; QEMU&#39;s XHCI device has so far not specially addressed this case, a=
nd<br>
&gt; no interrupt is generated for events delivered to event rings 1 and<br=
>
&gt; above. The macOS guest driver does not get along with this<br>
&gt; interpretation, so many events are not delivered to the guest OS when<=
br>
&gt; MSI(-X) is off.<br>
&gt; <br>
&gt; This patch changes the xhci_event() function such that event ring 0<br=
>
&gt; is always used when numintrs is 1 (as per spec section 4.17.1) or<br>
&gt; if neither MSI nor MSI-X are enabled. The latter is checked by adding<=
br>
&gt; a new, optional intr_mapping_supported function pointer field supplied=
<br>
&gt; by the concrete XHCI controller implementation. The PCI implementation=
&#39;s<br>
&gt; supplied function calls msix_enabled and msi_enabled accordingly.<br>
<br>
I think the current behavior to drop interrupts is correct and targeting <b=
r>
Interrupter 0 is a violation of the specification.<br>
<br>
As noted earlier, this xHC implementation supports Interrupter Mapping, <br=
>
so it must target Interrupters 1 to MaxInstrs-1 instead of always <br>
targeting Interrupter 0.<br>
<br>
At the beginning of section 4.7, the specification also says &quot;an <br>
Interrupter shall assert an interrupt if it is enabled and its <br>
associated Event Ring contains Event TRBs that require an interrupt&quot;. =
</blockquote><div><br></div><div>Unfortunately, this is an ambiguous wordin=
g - &quot;it&quot; could refer to either the interrupt or the interrupter, =
and I suspect it is talking about the IE flag. The IE flag is called &quot;=
Interrupt Enable,&quot; not &quot;InterruptER Enable.&quot; (If it&#39;s of=
f, you can still use the Event Ring in polling mode - the interruptER inclu=
des the event ring, the flag only applies to interrupt delivery.) On the ot=
her hand, there is an &quot;InterruptER Enable&quot; (INTE) flag in the USB=
CMD register - but there&#39;s only one, which covers all the interrupters =
available.</div><div><br></div>On the other hand, in 4.2 it says &quot;Enab=
le the Interrupter by writing a &#39;1&#39; to the Interrupt Enable (IE) fi=
eld=E2=80=A6&quot;.</div><div class=3D"gmail_quote gmail_quote_container"><=
br></div><div class=3D"gmail_quote gmail_quote_container">So the terminolog=
y is not consistent.<br></div><div class=3D"gmail_quote gmail_quote_contain=
er"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">It <=
br>
also says &quot;interrupters 1 to MaxIntrs-1 shall be disabled&quot; &quot;=
when the PCI <br>
Pin Interrupt is activated&quot;. So disabled Interrupters must drop interr=
upts.<br></blockquote><div><br></div><div>What does disabling the Interrupt=
er (again, not the interrupt) mean? The Event Ring is part of the Interrupt=
er. So if the interrupter is disabled, is the ring  disabled? If the ring i=
s disabled, should the hardware really be dispatching events to it?<br></di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
While the proposed behavior violates the specification, it is still <br>
crucial to run macOS guests. A possible solution is to add a property to <b=
r>
enable this behavior not conforming to the specification, and requires <br>
users to opt-in it when running macOS.<br></blockquote><div><br></div><div>=
It&#39;s certainly a possibility - but it adds user-facing complexity for n=
o discernible gain. Users of non-macOS guests won&#39;t care which way the =
flag is set because it doesn&#39;t affect them, and the default setting won=
&#39;t work for macOS guest users, meaning they need to research what&#39;s=
 going on if they&#39;re hit by the problem. OK, we can enable it by defaul=
t for the vmapple machine type, and most users of x86-64 macOS guests will =
be using the Q35 machine type, where MSI-X is functional. I&#39;m just not =
convinced the higher complexity(*) is worth a user setting that no user wil=
l ever change.</div><div><br></div><div>(* And it WILL be higher complexity=
, because you definitely need to insert the condition in xhci_event(). This=
 isn&#39;t fixable with just a tweak in xhci_pci_intr_raise, say - the HCI =
needs to behave as if interrupter mapping was unsupported, or it won&#39;t =
work.)</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/270=
5" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2705</a><br>
&gt; ---<br>
&gt; I&#39;ve been chasing this problem for a while, and I&#39;ve finally f=
igured<br>
&gt; out the cause, and I think an acceptable solution. I&#39;ve explained =
the<br>
&gt; problem and quoted the relevant sections of the XHCI spec in more<br>
&gt; detail in the linked GitLab issue:<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2705" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues=
/2705</a><br>
&gt; <br>
&gt; The fix provided is I think the simplest one in terms of lines of code=
,<br>
&gt; but it&#39;s also a little ugly, as we&#39;re constantly checking msix=
_enabled<br>
&gt; and msi_enabled via a callback function. Granted, we&#39;re already do=
ing<br>
&gt; that in xhci_pci_intr_raise and xhci_pci_intr_update, but this adds<br=
>
&gt; a bunch more calls.<br>
<br>
The fact that macOS rejects xHC with numintrs &lt; 4 implies macOS still <b=
r>
expects multiple Interrupters are enabled, but all Interrupters assert <br>
the INTx# pin. Implementation of such a behavior will be contained in <br>
xhci_pci_intr_raise() so we can save an indirection call of <br>
intr_mapping_supported() as a bonus.<br></blockquote><div><br></div><div>It=
&#39;s not as simple as redirecting xhci_pci_intr_raise for n !=3D 0 to sti=
ll trigger the pin-based interrupt when MSI(-X) is disabled with macOS gues=
ts. For one, pin-based interrupts are level-triggered, so you have to cheat=
 with the IMAN_IP state. Even then though, the macOS guest will only proces=
s event rings for which it received an interrupt, which makes some sense, a=
s there&#39;s no point having multiple rings if you&#39;re going to check a=
ll of them when you receive an interrupt for only one of them.<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Regards,<br>
Akihiko Odaki<br>
<br>
&gt; <br>
&gt; The main alternative I can see is to &quot;push&quot; the state of whe=
ther<br>
&gt; interrupter mapping is supported: provide a custom config_write<br>
&gt; implementation for the PCI device, and every time the configuration<br=
>
&gt; area is updated, evaluate whether or not this means that MSI or MSI-X<=
br>
&gt; are enabled and update a corresponding flag inside XHCIState. We could=
<br>
&gt; even use this opportunity to switch out different .intr_raise and<br>
&gt; .intr_update functions depending on which interrupt delivery mechanism=
<br>
&gt; is active in the PCI device.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.c | 9 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci.c=C2=A0 =C2=A0 =C2=A0| 5 +++++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci.h=C2=A0 =C2=A0 =C2=A0| 5 +++++<br>
&gt;=C2=A0 =C2=A03 files changed, 19 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c<br>
&gt; index a039f5778a6..21802211cf7 100644<br>
&gt; --- a/hw/usb/hcd-xhci-pci.c<br>
&gt; +++ b/hw/usb/hcd-xhci-pci.c<br>
&gt; @@ -81,6 +81,14 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, in=
t n, bool level)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static bool xhci_pci_intr_mapping_supported(XHCIState *xhci)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 XHCIPciState *s =3D container_of(xhci, XHCIPciState, xh=
ci);<br>
&gt; +=C2=A0 =C2=A0 PCIDevice *pci_dev =3D PCI_DEVICE(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return msix_enabled(pci_dev) || msi_enabled(pci_dev);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void xhci_pci_reset(DeviceState *dev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0XHCIPciState *s =3D XHCI_PCI(dev);<br>
&gt; @@ -118,6 +126,7 @@ static void usb_xhci_pci_realize(struct PCIDevice =
*dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_link(OBJECT(&amp;s-&gt;x=
hci), &quot;host&quot;, OBJECT(s), NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;xhci.intr_update =3D xhci_pci_intr_upd=
ate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;xhci.intr_raise =3D xhci_pci_intr_rais=
e;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;xhci.intr_mapping_supported =3D xhci_pci_intr_map=
ping_supported;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!qdev_realize(DEVICE(&amp;s-&gt;xhci), N=
ULL, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
&gt; index d85adaca0dc..a2a878e4594 100644<br>
&gt; --- a/hw/usb/hcd-xhci.c<br>
&gt; +++ b/hw/usb/hcd-xhci.c<br>
&gt; @@ -644,6 +644,11 @@ static void xhci_event(XHCIState *xhci, XHCIEvent=
 *event, int v)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t erdp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int dp_idx;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (xhci-&gt;numintrs =3D=3D 1 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (xhci-&gt;intr_mapping_supported &amp;&am=
p; !xhci-&gt;intr_mapping_supported(xhci))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D 0; /* Per section 4.17.1 */<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (v &gt;=3D xhci-&gt;numintrs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DPRINTF(&quot;intr nr out of r=
ange (%d &gt;=3D %d)\n&quot;, v, xhci-&gt;numintrs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h<br>
&gt; index fe16d7ad055..6e901de6e6b 100644<br>
&gt; --- a/hw/usb/hcd-xhci.h<br>
&gt; +++ b/hw/usb/hcd-xhci.h<br>
&gt; @@ -193,6 +193,11 @@ typedef struct XHCIState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_pstreams_mask;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*intr_update)(XHCIState *s, int n, boo=
l enable);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool (*intr_raise)(XHCIState *s, int n, bool=
 level);<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Device supports Interrupter Mapping per section=
 4.17.1 of XHCI spec.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If NULL, assume true if numintrs &gt; 1.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool (*intr_mapping_supported)(XHCIState *s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *hostOpaque;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Operational Registers */<br>
<br>
</blockquote></div></div>

--0000000000009d9c9906284676a1--

