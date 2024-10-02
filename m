Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DE3CF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzaO-00007A-NO; Wed, 02 Oct 2024 09:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1svza9-0008Q2-QZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:39:58 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1svza4-0001A7-Vz
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:39:57 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-50a87472832so931352e0c.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727876391; x=1728481191;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wnuOyP+3ophcGUwS6NkeSZvnaALLkKhq/zwZGQWfBFk=;
 b=W5Io1mBg/Yo0EVdAmCyfwS/rDC4GMU0OWC3FXLiEGs2UzuRTVFZwNTzsO/PJQ1DnTf
 xi0oejyF+UmNoEnbCZnlT9RSqqQlRryXdH+vSpmZ8hKpheFSN7e2YHDA/bcEy4L7TKd2
 leLaRl3fEyshsAsxCQKUuhUypENZjxYYx+VN9oleA+q8qwKpvzcuARuxXXZOFbXkrDki
 TbNh1zqOmLRbnoGVQQ/nRl7naE6jAIrpz9V/aKrEcDWYGkfk4aJUomQZ6UsOc8reduvF
 85sA9C1XqO7gJbaiDRb0BIBOTA7IpYfyWAIMkZ9tDSW/tAVS8A34QKCeyB9Pw0Q8PVjc
 xtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727876391; x=1728481191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnuOyP+3ophcGUwS6NkeSZvnaALLkKhq/zwZGQWfBFk=;
 b=GRoq/dzV+/I0OiFeD0i9JtM3GUdPl6RmU4YWICnT7kwbGa8jDM9+8gdkCvcIbFVrwT
 IF/DyCs3o6pjMSH8T7qNnpNjNAZC/B0DPwtVxwZZyD8Ix/wkESAwqqAyBe8lmH4bWk/K
 +ZvKbIHSxCBgdMNIgO9zy9brVqqu7BHV/f8JkmL/Hd4CPySHBG4kTJNcW+AQplPKea5k
 Uj22rTfiSLbb2G1v73OaXLn3GRPVuocz0Kwfx7MSDeXvIzLSuOv/0iVkW8euszDP6zl6
 PlMO/4E+EdLy4PmIZpTdczs4oBuOaj+5uCggH+/FPcQUJO4rxDiI+2xBiK29v1mPGi7m
 qivA==
X-Gm-Message-State: AOJu0YxYrp5y/t/iQPcq/fTHw3xPUq8AS9RNOUUP5v2/p4CHbGHMRid0
 1bTZnmwaHObYlQJVxJwp3ZM4UgArMyzedHImw1j6QzkgPqDTOaWI9jmux41Q95k132atBmYiySp
 QQQHj3jvyodYkajNyFIX1lJTH0flDGwX5X/VL
X-Google-Smtp-Source: AGHT+IHgSbPhkJQt44Z0KiwrTAFq8l7Ic7oiiWEXW3r9senX4q/M8lw+tn56y0EsgRF7dGwCHUpQB5sPsNTp5qc9nag=
X-Received: by 2002:a05:6122:3c89:b0:50a:bd30:c139 with SMTP id
 71dfb90a1353d-50c58254d36mr2517946e0c.11.1727876391148; Wed, 02 Oct 2024
 06:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-3-phil@philjordan.eu>
 <7d345ac4-249d-4865-9dcc-f137ae861214@daynix.com>
In-Reply-To: <7d345ac4-249d-4865-9dcc-f137ae861214@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 2 Oct 2024 15:39:40 +0200
Message-ID: <CAAibmn2+Q01MKmqGrp0aeXhS64Ff1bPHyLXgGz-bRthG0Nm5-A@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] hw/display/apple-gfx: Adds PCI implementation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000082b8b406237e9298"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2c.google.com
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

--00000000000082b8b406237e9298
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 at 09:14, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> > This change wires up the PCI variant of the paravirtualised
> > graphics device, mainly useful for x86-64 macOS guests, implemented
> > by macOS's ParavirtualizedGraphics.framework. It builds on code
> > shared with the vmapple/mmio variant of the PVG device.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   hw/display/Kconfig         |   5 ++
> >   hw/display/apple-gfx-pci.m | 138 ++++++++++++++++++++++++++++++++++++=
+
> >   hw/display/meson.build     |   1 +
> >   3 files changed, 144 insertions(+)
> >   create mode 100644 hw/display/apple-gfx-pci.m
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 179a479d220..c2ec268f8e9 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -152,3 +152,8 @@ config MAC_PVG_VMAPPLE
> >       bool
> >       depends on MAC_PVG
> >       depends on ARM
> > +
> > +config MAC_PVG_PCI
> > +    bool
> > +    depends on MAC_PVG && PCI
> > +    default y if PCI_DEVICES
> > diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
> > new file mode 100644
> > index 00000000000..9370258ee46
> > --- /dev/null
> > +++ b/hw/display/apple-gfx-pci.m
> > @@ -0,0 +1,138 @@
> > +/*
> > + * QEMU Apple ParavirtualizedGraphics.framework device, PCI variant
> > + *
> > + * Copyright =C2=A9 2023-2024 Phil Dennis-Jordan
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
>
> Please use SPDX-License-Identifier instead.
>
> > + *
> > + * ParavirtualizedGraphics.framework is a set of libraries that macOS
> provides
> > + * which implements 3d graphics passthrough to the host as well as a
> > + * proprietary guest communication channel to drive it. This device
> model
> > + * implements support to drive that library from within QEMU as a PCI
> device
> > + * aimed primarily at x86-64 macOS VMs.
> > + */
> > +
> > +#include "apple-gfx.h"
> > +#include "hw/pci/pci_device.h"
> > +#include "hw/pci/msi.h"
> > +#include "qapi/error.h"
> > +#include "trace.h"
> > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>
> Please add #include "qemu/osdep.h" at top and reorder according to
> "Include directives" section in: docs/devel/style.rst
>
> > +
> > +typedef struct AppleGFXPCIState {
> > +    PCIDevice parent_obj;
> > +
> > +    AppleGFXState common;
> > +} AppleGFXPCIState;
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXPCIState, APPLE_GFX_PCI)
> > +
> > +static const char* apple_gfx_pci_option_rom_path =3D NULL;
> > +
> > +static void apple_gfx_init_option_rom_path(void)
> > +{
> > +    NSURL *option_rom_url =3D PGCopyOptionROMURL();
> > +    const char *option_rom_path =3D
> option_rom_url.fileSystemRepresentation;
> > +    if (option_rom_url.fileURL && option_rom_path !=3D NULL) {
>
> option_rom_path !=3D NULL is unnecessary; NSURL.h has
> NS_HEADER_AUDIT_BEGIN(nullability, sendability), which means any
> non-annotated member is non-nullable.
>
> > +        apple_gfx_pci_option_rom_path =3D g_strdup(option_rom_path);
> > +    }
> > +    [option_rom_url release];
> > +}
> > +
> > +static void apple_gfx_pci_init(Object *obj)
> > +{
> > +    AppleGFXPCIState *s =3D APPLE_GFX_PCI(obj);
> > +
> > +    if (!apple_gfx_pci_option_rom_path) {
> > +        /* Done on device not class init to avoid -daemonize ObjC fork
> crash */
>
> It is unclear what "-daemonize ObjC fork crash" means. Please add more
> details.
>

When libvirt starts up a VM, it runs Qemu once in a dry-run state with the
-daemonize command line argument without actually running the VM. It then
queries various information about available features. It then shuts down
Qemu and re-runs it without -daemonize and actually lets the VM run.

The -daemonize command line argument causes fork() to be called. Apple's
Objective-C runtime does not support fork()ing and will immediately crash
the process when it detects it happening. QOM class init happens before the
fork(), so you can't call any Objective-C code from the class init
functions without causing a crash with -daemonize.

I can expand the comment somewhat for clarity.


> > +        PCIDeviceClass *pci =3D PCI_DEVICE_CLASS(object_get_class(obj)=
);
> > +        apple_gfx_init_option_rom_path();
> > +        pci->romfile =3D apple_gfx_pci_option_rom_path;
> > +    }
> > +
> > +    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_PCI);
> > +}
> > +
> > +static void apple_gfx_pci_interrupt(PCIDevice *dev, AppleGFXPCIState *=
s,
>
> s is unused.
>

Hmm, I suppose I should probably have a fallback legacy PCI IRQ trigger
here when MSI is not available.


> > +                                    uint32_t vector)
> > +{
> > +    bool msi_ok;
> > +    trace_apple_gfx_raise_irq(vector);
> > +
> > +    msi_ok =3D msi_enabled(dev);
> > +    if (msi_ok) {
> > +        msi_notify(dev, vector);
> > +    }
> > +}
> > +
> > +static void apple_gfx_pci_realize(PCIDevice *dev, Error **errp)
> > +{
> > +    AppleGFXPCIState *s =3D APPLE_GFX_PCI(dev);
> > +    Error *err =3D NULL;
> > +    int ret;
> > +
> > +    pci_register_bar(dev, PG_PCI_BAR_MMIO,
> > +                     PCI_BASE_ADDRESS_SPACE_MEMORY,
> &s->common.iomem_gfx);
> > +
> > +    ret =3D msi_init(dev, 0x0 /* config offset; 0 =3D find space */,
> > +                   PG_PCI_MAX_MSI_VECTORS, true /* msi64bit */,
> > +                   false /*msi_per_vector_mask*/, &err);
> > +    if (ret !=3D 0) {
> > +        error_propagate(errp, err);
>
> You can just pass errp to msi_init().
>
> > +        return;
> > +    }
> > +
> > +    @autoreleasepool {
> > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> > +        desc.raiseInterrupt =3D ^(uint32_t vector) {
> > +            apple_gfx_pci_interrupt(dev, s, vector);
> > +        };
> > +
> > +        apple_gfx_common_realize(&s->common, desc);
> > +        [desc release];
> > +        desc =3D nil;
> > +    }
> > +}
> > +
> > +static void apple_gfx_pci_reset(Object *obj, ResetType type)
> > +{
> > +    AppleGFXPCIState *s =3D APPLE_GFX_PCI(obj);
> > +    [s->common.pgdev reset];
> > +}
> > +
> > +static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    PCIDeviceClass *pci =3D PCI_DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +
> > +    assert(rc->phases.hold =3D=3D NULL);
> > +    rc->phases.hold =3D apple_gfx_pci_reset;
> > +    dc->desc =3D "macOS Paravirtualized Graphics PCI Display Controlle=
r";
> > +    dc->hotpluggable =3D false;
> > +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> > +
> > +    pci->vendor_id =3D PG_PCI_VENDOR_ID;
> > +    pci->device_id =3D PG_PCI_DEVICE_ID;
> > +    pci->class_id =3D PCI_CLASS_DISPLAY_OTHER;
> > +    pci->realize =3D apple_gfx_pci_realize;
> > +
> > +    // TODO: Property for setting mode list
> > +}
> > +
> > +static TypeInfo apple_gfx_pci_types[] =3D {
> > +    {
> > +        .name          =3D TYPE_APPLE_GFX_PCI,
> > +        .parent        =3D TYPE_PCI_DEVICE,
> > +        .instance_size =3D sizeof(AppleGFXPCIState),
> > +        .class_init    =3D apple_gfx_pci_class_init,
> > +        .instance_init =3D apple_gfx_pci_init,
> > +        .interfaces =3D (InterfaceInfo[]) {
> > +            { INTERFACE_PCIE_DEVICE },
> > +            { },
> > +        },
> > +    }
> > +};
> > +DEFINE_TYPES(apple_gfx_pci_types)
> > +
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 70d855749c0..ceb7bb07612 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -67,6 +67,7 @@ system_ss.add(when: 'CONFIG_ATI_VGA', if_true:
> [files('ati.c', 'ati_2d.c', 'ati_
> >
> >   system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> [files('apple-gfx.m'), pvg, metal])
> >   system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true:
> [files('apple-gfx-vmapple.m'), pvg, metal])
> > +system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true:
> [files('apple-gfx-pci.m'), pvg, metal])
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >     virtio_gpu_ss =3D ss.source_set()
>
>

--00000000000082b8b406237e9298
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, 2 Oct 2024 at 09:14, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt; This change wires up the PCI variant of the paravirtualised<br>
&gt; graphics device, mainly useful for x86-64 macOS guests, implemented<br=
>
&gt; by macOS&#39;s ParavirtualizedGraphics.framework. It builds on code<br=
>
&gt; shared with the vmapple/mmio variant of the PVG device.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/display/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A05 ++<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx-pci.m | 138 +++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
&gt;=C2=A0 =C2=A03 files changed, 144 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx-pci.m<br>
&gt; <br>
&gt; diff --git a/hw/display/Kconfig b/hw/display/Kconfig<br>
&gt; index 179a479d220..c2ec268f8e9 100644<br>
&gt; --- a/hw/display/Kconfig<br>
&gt; +++ b/hw/display/Kconfig<br>
&gt; @@ -152,3 +152,8 @@ config MAC_PVG_VMAPPLE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MAC_PVG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARM<br>
&gt; +<br>
&gt; +config MAC_PVG_PCI<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 depends on MAC_PVG &amp;&amp; PCI<br>
&gt; +=C2=A0 =C2=A0 default y if PCI_DEVICES<br>
&gt; diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m<b=
r>
&gt; new file mode 100644<br>
&gt; index 00000000000..9370258ee46<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx-pci.m<br>
&gt; @@ -0,0 +1,138 @@<br>
&gt; +/*<br>
&gt; + * QEMU Apple ParavirtualizedGraphics.framework device, PCI variant<b=
r>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023-2024 Phil Dennis-Jordan<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
<br>
Please use SPDX-License-Identifier instead.<br>
<br>
&gt; + *<br>
&gt; + * ParavirtualizedGraphics.framework is a set of libraries that macOS=
 provides<br>
&gt; + * which implements 3d graphics passthrough to the host as well as a<=
br>
&gt; + * proprietary guest communication channel to drive it. This device m=
odel<br>
&gt; + * implements support to drive that library from within QEMU as a PCI=
 device<br>
&gt; + * aimed primarily at x86-64 macOS VMs.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;apple-gfx.h&quot;<br>
&gt; +#include &quot;hw/pci/pci_device.h&quot;<br>
&gt; +#include &quot;hw/pci/msi.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
<br>
Please add #include &quot;qemu/osdep.h&quot; at top and reorder according t=
o <br>
&quot;Include directives&quot; section in: docs/devel/style.rst<br>
<br>
&gt; +<br>
&gt; +typedef struct AppleGFXPCIState {<br>
&gt; +=C2=A0 =C2=A0 PCIDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState common;<br>
&gt; +} AppleGFXPCIState;<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXPCIState, APPLE_GFX_PCI)<br>
&gt; +<br>
&gt; +static const char* apple_gfx_pci_option_rom_path =3D NULL;<br>
&gt; +<br>
&gt; +static void apple_gfx_init_option_rom_path(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 NSURL *option_rom_url =3D PGCopyOptionROMURL();<br>
&gt; +=C2=A0 =C2=A0 const char *option_rom_path =3D option_rom_url.fileSyst=
emRepresentation;<br>
&gt; +=C2=A0 =C2=A0 if (option_rom_url.fileURL &amp;&amp; option_rom_path !=
=3D NULL) {<br>
<br>
option_rom_path !=3D NULL is unnecessary; NSURL.h has <br>
NS_HEADER_AUDIT_BEGIN(nullability, sendability), which means any <br>
non-annotated member is non-nullable.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_pci_option_rom_path =3D g_strdu=
p(option_rom_path);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [option_rom_url release];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_pci_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXPCIState *s =3D APPLE_GFX_PCI(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!apple_gfx_pci_option_rom_path) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Done on device not class init to avoid=
 -daemonize ObjC fork crash */<br>
<br>
It is unclear what &quot;-daemonize ObjC fork crash&quot; means. Please add=
 more <br>
details.<br></blockquote><div><br></div><div>When libvirt starts up a VM, i=
t runs Qemu once in a dry-run state with the  -daemonize command line argum=
ent without actually running the VM. It then queries various information ab=
out available features. It then shuts down Qemu and re-runs it without -dae=
monize and actually lets the VM run.</div><div><br></div><div>The -daemoniz=
e command line argument causes fork() to be called. Apple&#39;s Objective-C=
 runtime does not support fork()ing and will immediately crash the process =
when it detects it happening. QOM class init happens before the fork(), so =
you can&#39;t call any Objective-C code from the class init functions witho=
ut causing a crash with -daemonize.</div><div><br></div><div>I can expand t=
he comment somewhat for clarity.<br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIDeviceClass *pci =3D PCI_DEVICE_CLASS(=
object_get_class(obj));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_init_option_rom_path();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci-&gt;romfile =3D apple_gfx_pci_option_=
rom_path;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_common_init(obj, &amp;s-&gt;common, TYPE_APPL=
E_GFX_PCI);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_pci_interrupt(PCIDevice *dev, AppleGFXPCIState =
*s,<br>
<br>
s is unused.<br></blockquote><div><br></div><div>Hmm, I suppose I should pr=
obably have a fallback legacy PCI IRQ trigger here when MSI is not availabl=
e.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t vector)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool msi_ok;<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_raise_irq(vector);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msi_ok =3D msi_enabled(dev);<br>
&gt; +=C2=A0 =C2=A0 if (msi_ok) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msi_notify(dev, vector);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_pci_realize(PCIDevice *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXPCIState *s =3D APPLE_GFX_PCI(dev);<br>
&gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pci_register_bar(dev, PG_PCI_BAR_MMIO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PCI_BASE_ADDRESS_SPACE_MEMORY, &amp;s-&gt;common.iomem_gfx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D msi_init(dev, 0x0 /* config offset; 0 =3D find =
space */,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
PG_PCI_MAX_MSI_VECTORS, true /* msi64bit */,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
false /*msi_per_vector_mask*/, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
<br>
You can just pass errp to msi_init().<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDes=
criptor new];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.raiseInterrupt =3D ^(uint32_t vector=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_pci_interrupt(dev=
, s, vector);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_common_realize(&amp;s-&gt;commo=
n, desc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc =3D nil;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_pci_reset(Object *obj, ResetType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXPCIState *s =3D APPLE_GFX_PCI(obj);<br>
&gt; +=C2=A0 =C2=A0 [s-&gt;common.pgdev reset];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 PCIDeviceClass *pci =3D PCI_DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(rc-&gt;phases.hold =3D=3D NULL);<br>
&gt; +=C2=A0 =C2=A0 rc-&gt;phases.hold =3D apple_gfx_pci_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;macOS Paravirtualized Graphics PC=
I Display Controller&quot;;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;hotpluggable =3D false;<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_DISPLAY, dc-&gt;categories);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pci-&gt;vendor_id =3D PG_PCI_VENDOR_ID;<br>
&gt; +=C2=A0 =C2=A0 pci-&gt;device_id =3D PG_PCI_DEVICE_ID;<br>
&gt; +=C2=A0 =C2=A0 pci-&gt;class_id =3D PCI_CLASS_DISPLAY_OTHER;<br>
&gt; +=C2=A0 =C2=A0 pci-&gt;realize =3D apple_gfx_pci_realize;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 // TODO: Property for setting mode list<br>
&gt; +}<br>
&gt; +<br>
&gt; +static TypeInfo apple_gfx_pci_types[] =3D {<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_APPLE_GFX_PCI,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_PCI_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AppleGFXPCIStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D apple_gfx_pc=
i_class_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D apple_gfx_pci_init,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .interfaces =3D (InterfaceInfo[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { INTERFACE_PCIE_DEVICE },<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +DEFINE_TYPES(apple_gfx_pci_types)<br>
&gt; +<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index 70d855749c0..ceb7bb07612 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -67,6 +67,7 @@ system_ss.add(when: &#39;CONFIG_ATI_VGA&#39;, if_tru=
e: [files(&#39;ati.c&#39;, &#39;ati_2d.c&#39;, &#39;ati_<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;,=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if_true: [files(&#39;apple-gfx.m&#39;), pvg, metal])<b=
r>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_MAC_PVG_VMAPPLE&#39;, if_t=
rue: [files(&#39;apple-gfx-vmapple.m&#39;), pvg, metal])<br>
&gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG_PCI&#39;,=C2=A0 =C2=A0 =C2=A0=
if_true: [files(&#39;apple-gfx-pci.m&#39;), pvg, metal])<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.source_set()<br>
<br>
</blockquote></div></div>

--00000000000082b8b406237e9298--

