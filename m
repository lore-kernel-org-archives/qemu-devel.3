Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C05E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 09:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKaSq-00036f-JL; Mon, 09 Dec 2024 04:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKaSn-00036V-GE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:54:02 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKaSi-0004O5-HC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:53:59 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5174f298e18so277337e0c.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733738035; x=1734342835;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=suP2sxy9IUQnqxUxnZWbbZdqzTDaFYxPh5dsPK8l6lc=;
 b=GISLfmY0sEFsbpwr74v2GyQtUUlKw6V7gogviIMM3479lhv85VEdAeSl24qfD/vxIo
 MWgBTpzQRycuKNFan0lnseKt0RnihX3JXQgkYbWXKQEGwpVukkLdzf0TTrtRAXRUM++Q
 Dfz2bFawV5kirl3UfHWZZeBYHCjGMyPmz4UV9xq6VHiRHFc1wRKlPop+kJ5pZsCe3lb/
 th7vPUMSLmyCE3z0Oz3HgL0KQrFpltOt90k/Mf6R7UaY23MbUK3dF28S2vMDHkgHZvNE
 omtGN3N53EH2P1tn2tAaHFthNfhzaL/hhFOpmQiZ7lUC/PQWJqbfA5y27P+v7cT1SnUH
 bUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733738035; x=1734342835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suP2sxy9IUQnqxUxnZWbbZdqzTDaFYxPh5dsPK8l6lc=;
 b=rvhaU8xvaay5Z7PCxvG9LNB25giunaszS+hlSlDC4xMubvEHKG2VH6Lbm7+LBRFDUV
 aNrXPed5Cxpc7sAu8WHKW5Xpk8ef+GCTqHz3WAC09QGaNywxmS8SlNKyF0Sg2oha6EAr
 maDAh6SGzO7FHE2mWoDN9jyFaWKHxgeqRC3Cn1idzMCUJBdxRT/IKYV+toU4WNn1qQ6E
 hij0OIZgFSoRBTFpsRmNP5+L5yK8aTLpXaGq7xKJM9KnlHMQoAjzCwyl2JqqceThD1sw
 /TIA4sEt3PlPoE1vKCLlj/0OAztKHiiK0ev5CBBCm6d3/jS38IQGwAlIEeRkr2wccor+
 jbXg==
X-Gm-Message-State: AOJu0YyaWYILLIfMLf3tIl8nf3XXElaLTkQG8qsFlMhoOGKff5GZ6kXS
 YvSIUsc3LgX0C8/aEHDhi8wadnhrrQeu1/4CgkRAVlylJNrRPKF1L4/wl6CZw9UlEOzPZ+4w36z
 UcBehJEWn3JBLufWY5Hlzt0b0gpha9TJYlPg+
X-Gm-Gg: ASbGncsy0IvRbBPoevkdTO5uIUnFPjo3ZlL6RlcJbmr0Lk4QAmW9m1070yet84pLjIm
 PvaJI6VnmmLiCIZTBCHnJUKZx67YC8WI=
X-Google-Smtp-Source: AGHT+IGV1gLFrkbwsWdc1caRW0vZ05ohBIBWwdNJzzmIJJoS9zOI2G+7NdsHgrDc8kzu7iKAry+NO493v8D4mV1R5v0=
X-Received: by 2002:a05:6122:2517:b0:517:4fb0:74bc with SMTP id
 71dfb90a1353d-5174fb077c3mr1794902e0c.3.1733738034812; Mon, 09 Dec 2024
 01:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-5-phil@philjordan.eu>
 <a90fc398-2713-4b2b-a9e4-ab591e994ebd@daynix.com>
In-Reply-To: <a90fc398-2713-4b2b-a9e4-ab591e994ebd@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 9 Dec 2024 10:53:44 +0100
Message-ID: <CAAibmn25MBzpS4DAt4ENKjjgYk29y01Y4pJNH9Hj9q+dT0jCiA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/usb/hcd-xhci-pci: Adds property for disabling
 mapping in IRQ mode
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 thuth@redhat.com, zhao1.liu@intel.com, imammedo@redhat.com
Content-Type: multipart/alternative; boundary="000000000000b2f1ee0628d35729"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a30;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa30.google.com
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

--000000000000b2f1ee0628d35729
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 at 07:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
> > This change addresses an edge case that trips up macOS guest drivers
> > for PCI based XHCI controllers. The guest driver would attempt to
> > schedule events to XHCI event rings 1 and 2 even when only one interrup=
t
> > line is available; interrupts would therefore be dropped, and events
> > only handled on timeout when using pin-based interrupts. Moreover,
> > when MSI is available, the macOS guest drivers would only configure 1
> > vector and leading to the same problem.
> >
> > So, in addition to disabling interrupter mapping if numintrs is 1, a
> > callback is added to xhci to check whether interrupter mapping should b=
e
> > enabled. The PCI XHCI device type now provides an implementation of
> > this callback if the new "conditional-intr-mapping" property is enabled=
.
> > (default: disabled) When enabled, interrupter mapping is only enabled
> > when MSI-X is active, or when MSI is active with more than 1 vector.
> >
> > This means that when using pin-based interrupts, or only 1 MSI vector,
> > events are only submitted to interrupter 0 regardless of selected
> > target. This allows the macOS guest drivers to work with the device in
> > those configurations.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
> > ---
> >   hw/usb/hcd-xhci-pci.c | 23 +++++++++++++++++++++++
> >   hw/usb/hcd-xhci-pci.h |  1 +
> >   hw/usb/hcd-xhci.c     |  3 ++-
> >   hw/usb/hcd-xhci.h     |  5 +++++
> >   4 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> > index 0278b0fbce2..8e293cd5951 100644
> > --- a/hw/usb/hcd-xhci-pci.c
> > +++ b/hw/usb/hcd-xhci-pci.c
> > @@ -81,6 +81,23 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int
> n, bool level)
> >       return false;
> >   }
> >
> > +static bool xhci_pci_intr_mapping_conditional(XHCIState *xhci)
> > +{
> > +    XHCIPciState *s =3D container_of(xhci, XHCIPciState, xhci);
> > +    PCIDevice *pci_dev =3D PCI_DEVICE(s);
> > +
> > +    /*
> > +     * Implementation of the "conditional-intr-mapping" property, whic=
h
> only
> > +     * enables interrupter mapping if there are actually multiple
> interrupt
> > +     * vectors available. Forces all events onto interrupter/event rin=
g
> 0
> > +     * in pin-based IRQ mode or when only 1 MSI vector is allocated.
> > +     * Provides compatibility with macOS guests on machine types where
> MSI-X is
> > +     * not available.
> > +     */
> > +    return msix_enabled(pci_dev) ||
> > +        (msi_enabled(pci_dev) && msi_nr_vectors_allocated(pci_dev) > 1=
);
>
> This will make it behave incosistently when
> msi_nr_vectors_allocated(pci_dev) is not sufficient to accomodate all
> Interrupters;  If > 1, overflowed Interrupters will be ignored, but if
> <=3D 1, overflowed Interrupters will be redirected to Interrupter 0.
> Remove the condition unless it is truly unnecessary.
>

After applying the existing patch 1/6 to fix the failed assertion, if you
run a VM with a macOS guest, and configure the XHCI controller so that MSI
is on and MSI-X is off:
-device nec-usb-xhci,msix=3Doff
You'll find that it exhibits the same apparent problem as when using
pin-based interrupts: the macOS driver configures only one MSI vector, and
then schedules events to event rings 1 and 2.

You have however just prompted me to re-check the specification on the
details of MSI, and it looks like I missed something in the "Implementation
note" in section 4.17 (Interrupters):

When MSI is activated:
>
[=E2=80=A6]
>
The Interrupt Vector associated with an Interrupter shall be defined as
> function of the value of the MSI Message Control register Multiple Messag=
e
> Enable field using the following algorithm.
>
>      Interrupt Vector =3D (Index of Interrupter) MODULUS (MSI Message
> Control:Multiple Message Enable)


So it seems that patch 1/6 should actually be changed to

    if (msi_enabled(pci_dev) && level) {
        n %=3D msi_nr_vectors_allocated(pci_dev);
        msi_notify(pci_dev, n);
        return true;
    }

To implement this modulus algorithm. (msi_nr_vectors_allocated() reads the
"Multiple Message Enable" field.) Then we can drop the vector count
condition in this patch. I have verified that the macOS guest's XHCI driver
handles this arrangement correctly.

> +}
> > +
> >   static void xhci_pci_reset(DeviceState *dev)
> >   {
> >       XHCIPciState *s =3D XHCI_PCI(dev);
> > @@ -118,6 +135,9 @@ static void usb_xhci_pci_realize(struct PCIDevice
> *dev, Error **errp)
> >       object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s),
> NULL);
> >       s->xhci.intr_update =3D xhci_pci_intr_update;
> >       s->xhci.intr_raise =3D xhci_pci_intr_raise;
> > +    if (s->conditional_intr_mapping) {
> > +        s->xhci.intr_mapping_supported =3D
> xhci_pci_intr_mapping_conditional;
> > +    }
> >       if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
> >           return;
> >       }
> > @@ -200,6 +220,9 @@ static void xhci_instance_init(Object *obj)
> >   static Property xhci_pci_properties[] =3D {
> >       DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi,
> ON_OFF_AUTO_AUTO),
> >       DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix,
> ON_OFF_AUTO_AUTO),
> > +    /* When true, disable interrupter mapping for IRQ mode or only 1
> vector */
> > +    DEFINE_PROP_BOOL("conditional-intr-mapping", XHCIPciState,
> > +                     conditional_intr_mapping, false),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
> > index 08f70ce97cc..5b61ae84555 100644
> > --- a/hw/usb/hcd-xhci-pci.h
> > +++ b/hw/usb/hcd-xhci-pci.h
> > @@ -40,6 +40,7 @@ typedef struct XHCIPciState {
> >       XHCIState xhci;
> >       OnOffAuto msi;
> >       OnOffAuto msix;
> > +    bool conditional_intr_mapping;
> >   } XHCIPciState;
> >
> >   #endif
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index 5fb140c2382..b607ddd1a93 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -644,7 +644,8 @@ static void xhci_event(XHCIState *xhci, XHCIEvent
> *event, int v)
> >       dma_addr_t erdp;
> >       unsigned int dp_idx;
> >
> > -    if (xhci->numintrs =3D=3D 1) {
> > +    if (xhci->numintrs =3D=3D 1 ||
> > +        (xhci->intr_mapping_supported &&
> !xhci->intr_mapping_supported(xhci))) {
> >           v =3D 0;
> >       }
> >
> > diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> > index fe16d7ad055..fdaa21ba7f6 100644
> > --- a/hw/usb/hcd-xhci.h
> > +++ b/hw/usb/hcd-xhci.h
> > @@ -193,6 +193,11 @@ typedef struct XHCIState {
> >       uint32_t max_pstreams_mask;
> >       void (*intr_update)(XHCIState *s, int n, bool enable);
> >       bool (*intr_raise)(XHCIState *s, int n, bool level);
> > +    /*
> > +     * Callback for special-casing interrupter mapping support. NULL
> for most
> > +     * implementations, for defaulting to enabled mapping unless
> numintrs =3D=3D 1.
> > +     */
> > +    bool (*intr_mapping_supported)(XHCIState *s);
> >       DeviceState *hostOpaque;
> >
> >       /* Operational Registers */
>
>

--000000000000b2f1ee0628d35729
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 9 Dec 2=
024 at 07:19, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com"=
>akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 2024/12/09 4:16, Phil Dennis-Jordan wrote:<br>
&gt; This change addresses an edge case that trips up macOS guest drivers<b=
r>
&gt; for PCI based XHCI controllers. The guest driver would attempt to<br>
&gt; schedule events to XHCI event rings 1 and 2 even when only one interru=
pt<br>
&gt; line is available; interrupts would therefore be dropped, and events<b=
r>
&gt; only handled on timeout when using pin-based interrupts. Moreover,<br>
&gt; when MSI is available, the macOS guest drivers would only configure 1<=
br>
&gt; vector and leading to the same problem.<br>
&gt; <br>
&gt; So, in addition to disabling interrupter mapping if numintrs is 1, a<b=
r>
&gt; callback is added to xhci to check whether interrupter mapping should =
be<br>
&gt; enabled. The PCI XHCI device type now provides an implementation of<br=
>
&gt; this callback if the new &quot;conditional-intr-mapping&quot; property=
 is enabled.<br>
&gt; (default: disabled) When enabled, interrupter mapping is only enabled<=
br>
&gt; when MSI-X is active, or when MSI is active with more than 1 vector.<b=
r>
&gt; <br>
&gt; This means that when using pin-based interrupts, or only 1 MSI vector,=
<br>
&gt; events are only submitted to interrupter 0 regardless of selected<br>
&gt; target. This allows the macOS guest drivers to work with the device in=
<br>
&gt; those configurations.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/270=
5" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2705</a><br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.c | 23 +++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A04 files changed, 31 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c<br>
&gt; index 0278b0fbce2..8e293cd5951 100644<br>
&gt; --- a/hw/usb/hcd-xhci-pci.c<br>
&gt; +++ b/hw/usb/hcd-xhci-pci.c<br>
&gt; @@ -81,6 +81,23 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, in=
t n, bool level)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static bool xhci_pci_intr_mapping_conditional(XHCIState *xhci)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 XHCIPciState *s =3D container_of(xhci, XHCIPciState, xh=
ci);<br>
&gt; +=C2=A0 =C2=A0 PCIDevice *pci_dev =3D PCI_DEVICE(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Implementation of the &quot;conditional-intr-ma=
pping&quot; property, which only<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* enables interrupter mapping if there are actual=
ly multiple interrupt<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* vectors available. Forces all events onto inter=
rupter/event ring 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* in pin-based IRQ mode or when only 1 MSI vector=
 is allocated.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Provides compatibility with macOS guests on mac=
hine types where MSI-X is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* not available.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 return msix_enabled(pci_dev) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (msi_enabled(pci_dev) &amp;&amp; msi_nr_v=
ectors_allocated(pci_dev) &gt; 1);<br>
<br>
This will make it behave incosistently when <br>
msi_nr_vectors_allocated(pci_dev) is not sufficient to accomodate all <br>
Interrupters;=C2=A0 If &gt; 1, overflowed Interrupters will be ignored, but=
 if <br>
&lt;=3D 1, overflowed Interrupters will be redirected to Interrupter 0. <br=
>
Remove the condition unless it is truly unnecessary.<br></blockquote><div><=
br></div><div>After applying the existing patch 1/6 to fix the failed asser=
tion, if you run a VM with a macOS guest, and configure the XHCI controller=
 so that MSI is on and MSI-X is off:</div><div>-device nec-usb-xhci,msix=3D=
off</div><div>You&#39;ll find that it exhibits the same apparent problem as=
 when using pin-based interrupts: the macOS driver configures only one MSI =
vector, and then schedules events to event rings 1 and 2.</div><div><br></d=
iv><div>You have however just prompted me to re-check the specification on =
the details of MSI, and it looks like I missed something in the &quot;Imple=
mentation note&quot; in section 4.17 (Interrupters):</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">When MSI is activated: <br>=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">[=E2=80=A6] =
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The Inte=
rrupt Vector associated with an Interrupter shall be defined as function of=
 the value of the MSI Message Control register Multiple Message Enable fiel=
d using the following algorithm.<br> <br></blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt Vector =3D =
(Index of Interrupter) MODULUS (MSI Message Control:Multiple Message Enable=
)</blockquote></div><div class=3D"gmail_quote gmail_quote_container"><br></=
div><div class=3D"gmail_quote gmail_quote_container">So it seems that patch=
 1/6 should actually be changed to<br></div><div class=3D"gmail_quote gmail=
_quote_container"><div><br></div><div><span style=3D"font-family:monospace"=
>=C2=A0 =C2=A0 if (msi_enabled(pci_dev) &amp;&amp; level) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 n %=3D msi_nr_vectors_allocated(pci_dev);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 msi_notify(pci_dev, n);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn true;<br>=C2=A0 =C2=A0 }<br></span></div><div><br></div><div>To implem=
ent this modulus algorithm. (msi_nr_vectors_allocated() reads the &quot;Mul=
tiple Message Enable&quot; field.) Then we can drop the vector count condit=
ion in this patch. I have verified that the macOS guest&#39;s XHCI driver h=
andles this arrangement correctly.<br></div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void xhci_pci_reset(DeviceState *dev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0XHCIPciState *s =3D XHCI_PCI(dev);<br>
&gt; @@ -118,6 +135,9 @@ static void usb_xhci_pci_realize(struct PCIDevice =
*dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_link(OBJECT(&amp;s-&gt;x=
hci), &quot;host&quot;, OBJECT(s), NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;xhci.intr_update =3D xhci_pci_intr_upd=
ate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;xhci.intr_raise =3D xhci_pci_intr_rais=
e;<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;conditional_intr_mapping) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;xhci.intr_mapping_supported =3D xhc=
i_pci_intr_mapping_conditional;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!qdev_realize(DEVICE(&amp;s-&gt;xhci), N=
ULL, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -200,6 +220,9 @@ static void xhci_instance_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0static Property xhci_pci_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ON_OFF_AUTO(&quot;msi&quot;, XHC=
IPciState, msi, ON_OFF_AUTO_AUTO),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ON_OFF_AUTO(&quot;msix&quot;, XH=
CIPciState, msix, ON_OFF_AUTO_AUTO),<br>
&gt; +=C2=A0 =C2=A0 /* When true, disable interrupter mapping for IRQ mode =
or only 1 vector */<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;conditional-intr-mapping&quot;, =
XHCIPciState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0conditional_intr_mapping, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h<br>
&gt; index 08f70ce97cc..5b61ae84555 100644<br>
&gt; --- a/hw/usb/hcd-xhci-pci.h<br>
&gt; +++ b/hw/usb/hcd-xhci-pci.h<br>
&gt; @@ -40,6 +40,7 @@ typedef struct XHCIPciState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0XHCIState xhci;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0OnOffAuto msi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0OnOffAuto msix;<br>
&gt; +=C2=A0 =C2=A0 bool conditional_intr_mapping;<br>
&gt;=C2=A0 =C2=A0} XHCIPciState;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
&gt; index 5fb140c2382..b607ddd1a93 100644<br>
&gt; --- a/hw/usb/hcd-xhci.c<br>
&gt; +++ b/hw/usb/hcd-xhci.c<br>
&gt; @@ -644,7 +644,8 @@ static void xhci_event(XHCIState *xhci, XHCIEvent =
*event, int v)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t erdp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int dp_idx;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (xhci-&gt;numintrs =3D=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 if (xhci-&gt;numintrs =3D=3D 1 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (xhci-&gt;intr_mapping_supported &amp;&am=
p; !xhci-&gt;intr_mapping_supported(xhci))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h<br>
&gt; index fe16d7ad055..fdaa21ba7f6 100644<br>
&gt; --- a/hw/usb/hcd-xhci.h<br>
&gt; +++ b/hw/usb/hcd-xhci.h<br>
&gt; @@ -193,6 +193,11 @@ typedef struct XHCIState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_pstreams_mask;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*intr_update)(XHCIState *s, int n, boo=
l enable);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool (*intr_raise)(XHCIState *s, int n, bool=
 level);<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Callback for special-casing interrupter mapping=
 support. NULL for most<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* implementations, for defaulting to enabled mapp=
ing unless numintrs =3D=3D 1.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool (*intr_mapping_supported)(XHCIState *s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *hostOpaque;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Operational Registers */<br>
<br>
</blockquote></div></div>

--000000000000b2f1ee0628d35729--

