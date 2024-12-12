Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D180EE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 10:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLge6-0006Mk-0j; Thu, 12 Dec 2024 05:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tLgdw-00067k-Qy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:42:05 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tLgdt-0002Gj-VD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:42:04 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85c5adbca8eso127950241.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 02:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734000120; x=1734604920;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6x41EQI2hAzWEfd0DPNK+Ye3vtsyv+TVlwIaIkmNO/A=;
 b=wE2RAAL536XyE0eeN8XZSDPmauYVzZURqphR5hKfOa9l5sbe07zSYMtLvwZIgdXMe1
 XmzG4EbJ26kwZMIhpjfQY59d+LnUwYs94vCHyb34rfNKEdK4PRksI5Jq8q9PPA3qJwSd
 ACp5MdkKjLEO/1au+OjaFkqd9fm/qQ5W6u9X/GEoKloBtnKVpegVJ0Wc/dgzk/9UK3r3
 UaRz3Rvu1e/qjUo5BIgrmJEVX2/y7Oj+e1zXc+Xe4BLO07+mDxUVZoitvrCYwF4Uo6FB
 AgCfw5NQy6/2b1VOPAfD71D+5d7pX/1U6EqMAC/Bjbpq42pdNrURbZnGP3u8qpcrc5Y/
 ImDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734000120; x=1734604920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6x41EQI2hAzWEfd0DPNK+Ye3vtsyv+TVlwIaIkmNO/A=;
 b=cXq6tH3/ywnZaszORbGVkHnSkwSJ86Sp+qIDW3Ay5LjtvFgQkFFTyiqIxIQOOcOCGW
 eC4zQSXWn5FMyNamCb3qdHT4XiI/RrO1TNWsXnEC3zZUhn+JQzFKtPt+op/xTzSzBksf
 dP5qtnTneSjJ3MafQ9/lS7FAGt5qOKdKwx305LHjQAtOA2+irfe9JyeN7VGDhGW+w+jf
 WbeiYeDzehG/MjQFyagspltNzdJNX37pb6pHRDEnvql1k/JT++NzTwaWCGvgsqdRpZ7R
 I8tlnVXnTqU9aGD8fB8IpNwR6a/jDsfh9Ks9XCQAI4MoDXv7UbHnDAjf30Huc/FyaeMo
 CvMg==
X-Gm-Message-State: AOJu0Yxz/MXf2hO4aCX0MmbZgz3KgBNGfsS19G1O9IaCqkpxCecF87IZ
 8ZOc/7g179cZ0iMQqL67bNIh0BboJ9KCIvnMlYYChoLroqkTrhpHdPGEDasHkTDahTUZvXWeVgw
 iV0nc/Retth9+N3rgTiBP43fxwW3RTX3sUDvp
X-Gm-Gg: ASbGncs44MPHlB+mx+lYnoc1AgpBRfM2MGnwBxYfhF0mRFO2Lf73ttoXLPoWL8XP3hB
 vjvzKtR5cXd1BHxeIzhSpvei1HIwbbpbXtDbtpg==
X-Google-Smtp-Source: AGHT+IHezOp8lupjgvhlygl4m+6Rg8xXKCJRZMZAihnNRfYscC62xAorMZ0oJ2pKdonQ8lq/nWF5SYMjfjt/fZQUbII=
X-Received: by 2002:a05:6102:dca:b0:4b0:49ba:8278 with SMTP id
 ada2fe7eead31-4b2478d8e80mr2469224137.25.1734000120108; Thu, 12 Dec 2024
 02:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
In-Reply-To: <20241212085207.1439501-2-npiggin@gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Thu, 12 Dec 2024 11:41:49 +0100
Message-ID: <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000033368d0629105d17"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92f;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92f.google.com
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

--00000000000033368d0629105d17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Nicholas,

I'm not an XHCI & PCI expert (yet?) so apologies if I've got some of this
wrong, but I've asked some questions and made some comments inline:

On Thu, 12 Dec 2024 at 09:52, Nicholas Piggin <npiggin@gmail.com> wrote:

> To prepare to support another USB PCI Host Controller, make some PCI
> configuration dynamic.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/usb/hcd-xhci-pci.h |  9 ++++++
>  hw/usb/hcd-xhci-nec.c | 10 +++++++
>  hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 78 insertions(+), 10 deletions(-)
>
> diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
> index 08f70ce97cc..213076aabf6 100644
> --- a/hw/usb/hcd-xhci-pci.h
> +++ b/hw/usb/hcd-xhci-pci.h
> @@ -40,6 +40,15 @@ typedef struct XHCIPciState {
>      XHCIState xhci;
>      OnOffAuto msi;
>      OnOffAuto msix;
> +    uint8_t cache_line_size;
> +    uint8_t pm_cap_off;
> +    uint8_t pcie_cap_off;
> +    uint8_t msi_cap_off;
> +    uint8_t msix_cap_off;
> +    int msix_bar_nr;
> +    uint64_t msix_bar_size;
> +    uint32_t msix_table_off;
> +    uint32_t msix_pba_off;
>  } XHCIPciState;
>
>  #endif
> diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> index 0e61c6c4f06..6ac1dc7764c 100644
> --- a/hw/usb/hcd-xhci-nec.c
> +++ b/hw/usb/hcd-xhci-nec.c
> @@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj)
>
>      pci->xhci.numintrs =3D nec->intrs;
>      pci->xhci.numslots =3D nec->slots;
> +
> +    pci->cache_line_size =3D 0x10;
> +    pci->pm_cap_off =3D 0;
> +    pci->pcie_cap_off =3D 0xa0;
> +    pci->msi_cap_off =3D 0x70;
> +    pci->msix_cap_off =3D 0x90;
> +    pci->msix_bar_nr =3D 0;
> +    pci->msix_bar_size =3D 0;
> +    pci->msix_table_off =3D 0x3000;
> +    pci->msix_pba_off =3D 0x3800;
>  }


What about the "qemu-xhci" device, does that need similar treatment? I
suspect it does at least for a bunch of these settings. Perhaps
xhci_instance_init() in the abstract "pci-xhci" base might be a better
place for these "sensible defaults" and then override them only in the
specific implementations that need to do so, such as the new TI model?
And/or have suitably named helper init function for configuring single-BAR
PCI XHCI controllers so we can get some meaning behind all these magic
numbers?


>  static void nec_xhci_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index a039f5778a6..948d75b7379 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -32,8 +32,9 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>
> -#define OFF_MSIX_TABLE  0x3000
> -#define OFF_MSIX_PBA    0x3800
> +#define MSIX_BAR_SIZE   0x800000
>

MSIX_BAR_SIZE doesn't seem to be used anywhere, and patch 2/2 uses 0x800000
explicitly. (8 MiB also seems=E2=80=A6 huge? But I'm guessing you're matchi=
ng this
with the physical TI controller hardware - either way I don't think it
belongs in this file.)


> +#define OFF_MSIX_TABLE  0x0000
> +#define OFF_MSIX_PBA    0x1000
>

Maybe instead of redefining these constants to only apply to the split BAR
device variants, there should be 2 variants of them, one for single-BAR
controllers, and one for controllers with separate BARs. That would also
help make sense of the "magic numbers" in nec_xhci_instance_init().



>  static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)
>  {
> @@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *opaque,
> int version_id)
>     return 0;
>  }
>
> +static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t offset=
,
> +                                      Error **errp)
> +{
> +    int err;
> +
> +    err =3D pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
> +                             PCI_PM_SIZEOF, errp);
> +    if (err < 0) {
> +        return err;
> +    }
> +
> +    pci_set_word(pci_dev->config + offset + PCI_PM_PMC,
> +                 PCI_PM_CAP_VER_1_2 |
> +                 PCI_PM_CAP_D1 | PCI_PM_CAP_D2 |
> +                 PCI_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |
> +                 PCI_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);
> +    pci_set_word(pci_dev->wmask + offset + PCI_PM_PMC, 0);
> +    pci_set_word(pci_dev->config + offset + PCI_PM_CTRL,
> +                 PCI_PM_CTRL_NO_SOFT_RESET);
> +    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
> +                 PCI_PM_CTRL_STATE_MASK);
> +
> +    return 0;
> +}
> +
>  static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>  {
>      int ret;
> @@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice
> *dev, Error **errp)
>
>      dev->config[PCI_CLASS_PROG] =3D 0x30;    /* xHCI */
>      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin 1 */
> -    dev->config[PCI_CACHE_LINE_SIZE] =3D 0x10;
> +    dev->config[PCI_CACHE_LINE_SIZE] =3D s->cache_line_size;
>      dev->config[0x60] =3D 0x30; /* release number */
>
>      object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
> @@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevice
> *dev, Error **errp)
>          s->xhci.nec_quirks =3D true;
>      }
>
> +    if (s->pm_cap_off) {
> +        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
> +            error_propagate(errp, err);
> +            return;
>

Can't we just pass errp straight to xhci_pci_add_pm_capability and skip the
error_propagate() here?


> +        }
> +    }
> +
>      if (s->msi !=3D ON_OFF_AUTO_OFF) {
> -        ret =3D msi_init(dev, 0x70, s->xhci.numintrs, true, false, &err)=
;
> +        ret =3D msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
> +                       true, false, &err);
>          /*
>           * Any error other than -ENOTSUP(board's MSI support is broken)
>           * is a programming error
> @@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevice
> *dev, Error **errp)
>          /* With msi=3Dauto, we fall back to MSI off silently */
>          error_free(err);
>      }
> +
>      pci_register_bar(dev, 0,
>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>                       PCI_BASE_ADDRESS_MEM_TYPE_64,
>                       &s->xhci.mem);
>
>      if (pci_bus_is_express(pci_get_bus(dev))) {
> -        ret =3D pcie_endpoint_cap_init(dev, 0xa0);
> +        ret =3D pcie_endpoint_cap_init(dev, s->pcie_cap_off);
>          assert(ret > 0);
>      }
>
>      if (s->msix !=3D ON_OFF_AUTO_OFF) {
> -        /* TODO check for errors, and should fail when msix=3Don */
> -        msix_init(dev, s->xhci.numintrs,
> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> -                  0x90, NULL);
> +        MemoryRegion *msix_bar =3D &s->xhci.mem;
> +        if (s->msix_bar_nr !=3D 0) {
> +            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev),
> +                               "xhci-msix", s->msix_bar_size);
> +            msix_bar =3D &dev->msix_exclusive_bar;
> +        }
> +
> +        ret =3D msix_init(dev, s->xhci.numintrs,
> +                        msix_bar, s->msix_bar_nr, s->msix_table_off,
> +                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
> +                        s->msix_cap_off, errp);
> +        if (ret) {
> +            return;
> +        }
>

Surely we should only propagate the error and fail realize() iff s->msix is
ON_OFF_AUTO_ON?

For ON_OFF_AUTO_AUTO, msix_init returning failure isn't a critical error.


> +
> +        pci_register_bar(dev, s->msix_bar_nr,
> +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                         msix_bar);
>

Is it safe to call pci_register_bar() again for the msix_bar_nr =3D 0 case?
Even if it is safe, is it sensible? If we're calling it twice for the same
BAR, and the arguments of either of the calls changes in future, the other
needs to change too. Doesn't seem ideal.


>      }
>      s->xhci.as =3D pci_get_address_space(dev);
>  }
> --
> 2.45.2
>
>

--00000000000033368d0629105d17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>He=
y Nicholas,</div><div><br></div><div>I&#39;m not an XHCI &amp; PCI expert (=
yet?) so apologies if I&#39;ve got some of this wrong, but I&#39;ve asked s=
ome questions and made some comments inline:<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 12 Dec 2024 at 09:5=
2, Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" target=3D"_blan=
k">npiggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">To prepare to support another USB PCI Host Controller, =
make some PCI<br>
configuration dynamic.<br>
<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/usb/hcd-xhci-pci.h |=C2=A0 9 ++++++<br>
=C2=A0hw/usb/hcd-xhci-nec.c | 10 +++++++<br>
=C2=A0hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++------=
-<br>
=C2=A03 files changed, 78 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h<br>
index 08f70ce97cc..213076aabf6 100644<br>
--- a/hw/usb/hcd-xhci-pci.h<br>
+++ b/hw/usb/hcd-xhci-pci.h<br>
@@ -40,6 +40,15 @@ typedef struct XHCIPciState {<br>
=C2=A0 =C2=A0 =C2=A0XHCIState xhci;<br>
=C2=A0 =C2=A0 =C2=A0OnOffAuto msi;<br>
=C2=A0 =C2=A0 =C2=A0OnOffAuto msix;<br>
+=C2=A0 =C2=A0 uint8_t cache_line_size;<br>
+=C2=A0 =C2=A0 uint8_t pm_cap_off;<br>
+=C2=A0 =C2=A0 uint8_t pcie_cap_off;<br>
+=C2=A0 =C2=A0 uint8_t msi_cap_off;<br>
+=C2=A0 =C2=A0 uint8_t msix_cap_off;<br>
+=C2=A0 =C2=A0 int msix_bar_nr;<br>
+=C2=A0 =C2=A0 uint64_t msix_bar_size;<br>
+=C2=A0 =C2=A0 uint32_t msix_table_off;<br>
+=C2=A0 =C2=A0 uint32_t msix_pba_off;<br>
=C2=A0} XHCIPciState;<br>
<br>
=C2=A0#endif<br>
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c<br>
index 0e61c6c4f06..6ac1dc7764c 100644<br>
--- a/hw/usb/hcd-xhci-nec.c<br>
+++ b/hw/usb/hcd-xhci-nec.c<br>
@@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj)<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci-&gt;xhci.numintrs =3D nec-&gt;intrs;<br>
=C2=A0 =C2=A0 =C2=A0pci-&gt;xhci.numslots =3D nec-&gt;slots;<br>
+<br>
+=C2=A0 =C2=A0 pci-&gt;cache_line_size =3D 0x10;<br>
+=C2=A0 =C2=A0 pci-&gt;pm_cap_off =3D 0;<br>
+=C2=A0 =C2=A0 pci-&gt;pcie_cap_off =3D 0xa0;<br>
+=C2=A0 =C2=A0 pci-&gt;msi_cap_off =3D 0x70;<br>
+=C2=A0 =C2=A0 pci-&gt;msix_cap_off =3D 0x90;<br>
+=C2=A0 =C2=A0 pci-&gt;msix_bar_nr =3D 0;<br>
+=C2=A0 =C2=A0 pci-&gt;msix_bar_size =3D 0;<br>
+=C2=A0 =C2=A0 pci-&gt;msix_table_off =3D 0x3000;<br>
+=C2=A0 =C2=A0 pci-&gt;msix_pba_off =3D 0x3800;<br>
=C2=A0}</blockquote><div><br></div><div>What about the &quot;qemu-xhci&quot=
; device, does that need similar treatment? I suspect it does at least for =
a bunch of these settings. Perhaps xhci_instance_init() in the abstract &qu=
ot;pci-xhci&quot; base might be a better place for these &quot;sensible def=
aults&quot; and then override them only in the specific implementations tha=
t need to do so, such as the new TI model? And/or have suitably named helpe=
r init function for configuring single-BAR PCI XHCI controllers so we can g=
et some meaning behind all these magic numbers?<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0static void nec_xhci_class_init(ObjectClass *klass, void *data)<br>
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c<br>
index a039f5778a6..948d75b7379 100644<br>
--- a/hw/usb/hcd-xhci-pci.c<br>
+++ b/hw/usb/hcd-xhci-pci.c<br>
@@ -32,8 +32,9 @@<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
<br>
-#define OFF_MSIX_TABLE=C2=A0 0x3000<br>
-#define OFF_MSIX_PBA=C2=A0 =C2=A0 0x3800<br>
+#define MSIX_BAR_SIZE=C2=A0 =C2=A00x800000<br></blockquote><div><br></div>=
<div>MSIX_BAR_SIZE doesn&#39;t seem to be used anywhere, and patch 2/2 uses=
 0x800000 explicitly. (8 MiB also seems=E2=80=A6 huge? But I&#39;m guessing=
 you&#39;re matching this with the physical TI controller hardware - either=
 way I don&#39;t think it belongs in this file.)<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+#define OFF_MSIX_TABLE=C2=A0 0x0000<br>
+#define OFF_MSIX_PBA=C2=A0 =C2=A0 0x1000<br></blockquote><div><br></div><d=
iv>Maybe instead of redefining these constants to only apply to the split B=
AR device variants, there should be 2 variants of them, one for single-BAR =
controllers, and one for controllers with separate BARs. That would also he=
lp make sense of the &quot;magic numbers&quot; in nec_xhci_instance_init().=
</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
=C2=A0static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)=
<br>
=C2=A0{<br>
@@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *opaque, in=
t version_id)<br>
=C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t offset,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<b=
r>
+{<br>
+=C2=A0 =C2=A0 int err;<br>
+<br>
+=C2=A0 =C2=A0 err =3D pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_SIZEOF, errp);<br>
+=C2=A0 =C2=A0 if (err &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;config + offset + PCI_PM_PMC,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_CAP_V=
ER_1_2 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_CAP_D=
1 | PCI_PM_CAP_D2 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_CAP_P=
ME_D0 | PCI_PM_CAP_PME_D1 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_CAP_P=
ME_D2 | PCI_PM_CAP_PME_D3hot);<br>
+=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;wmask + offset + PCI_PM_PMC, 0);<br=
>
+=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;config + offset + PCI_PM_CTRL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_CTRL_=
NO_SOFT_RESET);<br>
+=C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;wmask + offset + PCI_PM_CTRL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_PM_CTRL_=
STATE_MASK);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
=C2=A0static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
@@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev,=
 Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;config[PCI_CLASS_PROG] =3D 0x30;=C2=A0 =C2=A0 /=
* xHCI */<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrup=
t pin 1 */<br>
-=C2=A0 =C2=A0 dev-&gt;config[PCI_CACHE_LINE_SIZE] =3D 0x10;<br>
+=C2=A0 =C2=A0 dev-&gt;config[PCI_CACHE_LINE_SIZE] =3D s-&gt;cache_line_siz=
e;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;config[0x60] =3D 0x30; /* release number */<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_link(OBJECT(&amp;s-&gt;xhci), &quot=
;host&quot;, OBJECT(s), NULL);<br>
@@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev=
, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;xhci.nec_quirks =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (s-&gt;pm_cap_off) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xhci_pci_add_pm_capability(dev, s-&gt;pm_c=
ap_off, &amp;err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br></blockquote><div><br=
></div><div>Can&#39;t we just pass errp straight to xhci_pci_add_pm_capabil=
ity and skip the error_propagate() here?<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;msi !=3D ON_OFF_AUTO_OFF) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D msi_init(dev, 0x70, s-&gt;xhci.numintr=
s, true, false, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D msi_init(dev, s-&gt;msi_cap_off, s-&gt=
;xhci.numintrs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0true, false, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Any error other than -ENOTSUP(board&#3=
9;s MSI support is broken)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * is a programming error<br>
@@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevice *de=
v, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* With msi=3Dauto, we fall back to MSI o=
ff silently */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_free(err);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0pci_register_bar(dev, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 PCI_BASE_ADDRESS_SPACE_MEMORY |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 PCI_BASE_ADDRESS_MEM_TYPE_64,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;s-&gt;xhci.mem);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (pci_bus_is_express(pci_get_bus(dev))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pcie_endpoint_cap_init(dev, 0xa0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pcie_endpoint_cap_init(dev, s-&gt;pcie=
_cap_off);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(ret &gt; 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;msix !=3D ON_OFF_AUTO_OFF) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO check for errors, and should fail when=
 msix=3Don */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msix_init(dev, s-&gt;xhci.numintrs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;=
xhci.mem, 0, OFF_MSIX_TABLE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;=
xhci.mem, 0, OFF_MSIX_PBA,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x90, NULL)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *msix_bar =3D &amp;s-&gt;xhci.mem=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;msix_bar_nr !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init(&amp;dev-&gt;=
msix_exclusive_bar, OBJECT(dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;xhci-msix&quot;, s-&gt;msix_bar=
_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msix_bar =3D &amp;dev-&gt;msix_e=
xclusive_bar;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D msix_init(dev, s-&gt;xhci.numintrs,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msix_bar, s-&gt;msix_bar_nr, s-&gt;msix_table_off,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msix_bar, s-&gt;msix_bar_nr, s-&gt;msix_pba_off,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s-&gt;msix_cap_off, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Surely w=
e should only propagate the error and fail realize() iff s-&gt;msix is ON_O=
FF_AUTO_ON?</div><div><br></div><div>For ON_OFF_AUTO_AUTO, msix_init return=
ing failure isn&#39;t a critical error.<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_register_bar(dev, s-&gt;msix_bar_nr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PCI_BASE_ADDRESS_SPACE_MEMORY |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PCI_BASE_ADDRESS_MEM_TYPE_64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0msix_bar);<br></blockquote><div><br></div><div>Is it safe =
to call pci_register_bar() again for the msix_bar_nr =3D 0 case? Even if it=
 is safe, is it sensible? If we&#39;re calling it twice for the same BAR, a=
nd the arguments of either of the calls changes in future, the other needs =
to change too. Doesn&#39;t seem ideal.<br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;<a href=3D"http://xhci.as" rel=3D"noreferrer" tar=
get=3D"_blank">xhci.as</a> =3D pci_get_address_space(dev);<br>
=C2=A0}<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div>
</div>
</div>
</div>

--00000000000033368d0629105d17--

