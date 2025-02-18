Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058B9C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQYv-0003mz-QV; Tue, 18 Feb 2025 11:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tkQYs-0003ku-88
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:35:06 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tkQYo-0001v5-VH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:35:04 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so10324576a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739896501; x=1740501301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj2LBoPlP2eaMdS3IVdJvncbUdSQpYhPrvDkgDRG8bE=;
 b=MFRVqmYO/0mZ4mwyJnW0Y7+EYNLhwpXvBg7IAYpV32XQkD+6tmCJ9i7GefEHs93KRZ
 kQDD6+ZfBAuCOxJmdlYwLoV4tqpSeK8H4ax4VHIv+b1dXFyotH651fLFTnE1fRM9MNpl
 svB8J4TbeWEwg49xxAEKNuXtCSVELZCX5ABfHvhO9qd4Jgqv6gnDVk+rnSsFhLJLmLwp
 3h8F7oahTNwYNMvJZfFhjYbsItlhP3Tb77U7Bd0LUQ1mXStxuG75z3hPWIsSCC72XU/k
 /NyBz4rGlwp3uZkhoVBFyTzldq5GxKAURGzOEjg/m7CrwzrqPmAitJ8Xo6TpNa2RSa3q
 ThIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896501; x=1740501301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dj2LBoPlP2eaMdS3IVdJvncbUdSQpYhPrvDkgDRG8bE=;
 b=skyJniGqW8BvYJ4jzkG0KYkvCTJ5bzr3d8Vz8A6BPwF7JJ8WoBuwS88qN3AZyoIxjF
 BH5W2owm7Fb6YeMvYRlCtX6raoKr727nWbISKtMQSilgdH99OGyKHrrgRinsqLBR/nof
 64+rOGj+CB1+JQ3fvdp/xG9hQffUM24+GFv5yzILWTtui4DaXdW5f247Rj8qF37J3t9m
 LYLdTQP1Ij5MrqCVtKi5AiIgTaSXedHbV9AOa2YYKGdgMtF6sSCQ6A/F3yVx5PuDlsEb
 9/uYU0iiAUinyY28ixQ4Lk4Auom90/PHT5HpWJZiGvq6epYiQTwjCXB1oKqTe48BBgbk
 oTVg==
X-Gm-Message-State: AOJu0YxtjBFtlRhgrjVqaJBeLc1bgoKDllGcpHY+vf/8GqSWqeB9M6xf
 gHJ40jP67dlaY6V2/75lGa2VDYkrtLnWtSFwmRdj6/SSKCMvI3csP2b1bZ9GCHqiY1BRmI+zAik
 VbPiXr6F+MZW3o40psBUFSiJuX18=
X-Gm-Gg: ASbGnctR0UexOO9hncGdYbwqqbz8yoGRw7/uKyQSl33eLqiRqDxfnrTdTZaHqA7xy8i
 4wjEqS0bebrVThF+HtK2C+ScW5wnQX7SfV/tuKc5CheuMPjlNbZ4XGyeygsi1ymv2ueW6jI2Z
X-Google-Smtp-Source: AGHT+IFptKE1EDaXhSZKBUdIQvETT0zVarz8BMzh40VQoM/kVeseRMJeLDD9p5o6TYL2cKXADAJ8W2r79tdjY79vS6U=
X-Received: by 2002:a05:6402:26cd:b0:5de:50b4:b71f with SMTP id
 4fb4d7f45d1cf-5e088de15e2mr478824a12.12.1739896500215; Tue, 18 Feb 2025
 08:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
 <20240904161537.664189-11-edgar.iglesias@gmail.com>
 <58d3fcc5-365d-4f20-ae34-5201fb9e7b3f@linaro.org>
In-Reply-To: <58d3fcc5-365d-4f20-ae34-5201fb9e7b3f@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 18 Feb 2025 10:34:47 -0600
X-Gm-Features: AWEUYZlrs1EjDPrUmNwtX1q2AMsgqM7n3BvGXNSheB6NGIaA_Qu6Q9Rf0LrIF6E
Message-ID: <CAJy5ezq__QCuORp5aqT7ehFamqXsO_pot9J5GyS6Tt2wEHdPtQ@mail.gmail.com>
Subject: Re: [PULL v1 10/12] hw/xen: pvh-common: Add support for creating
 PCIe/GPEX
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>, anthony@xenproject.org, paul@xen.org, 
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com, 
 jason.andryuk@amd.com, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Content-Type: multipart/alternative; boundary="000000000000d76709062e6d383d"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d76709062e6d383d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 6:02=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Edgar,
>
> On 4/9/24 18:15, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Add support for optionally creating a PCIe/GPEX controller.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > ---
> >   hw/xen/xen-pvh-common.c         | 76 ++++++++++++++++++++++++++++++++=
+
> >   include/hw/xen/xen-pvh-common.h | 29 +++++++++++++
> >   2 files changed, 105 insertions(+)
>
>
> > +/*
> > + * We use the GPEX PCIe controller with its internal INTX PCI interrup=
t
> > + * swizzling. This swizzling is emulated in QEMU and routes all INTX
> > + * interrupts from endpoints down to only 4 INTX interrupts.
> > + * See include/hw/pci/pci.h : pci_swizzle()
> > + */
> > +static inline void xenpvh_gpex_init(XenPVHMachineState *s,
> > +                                    XenPVHMachineClass *xpc,
> > +                                    MemoryRegion *sysmem)
> > +{
> > +    MemoryRegion *ecam_reg;
> > +    MemoryRegion *mmio_reg;
> > +    DeviceState *dev;
> > +    int i;
> > +
> > +    object_initialize_child(OBJECT(s), "gpex", &s->pci.gpex,
> > +                            TYPE_GPEX_HOST);
> > +    dev =3D DEVICE(&s->pci.gpex);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_add_subregion(sysmem, s->cfg.pci_ecam.base, ecam_reg=
);
> > +
> > +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > +
> > +    if (s->cfg.pci_mmio.size) {
> > +        memory_region_init_alias(&s->pci.mmio_alias, OBJECT(dev),
> "pcie-mmio",
> > +                                 mmio_reg,
> > +                                 s->cfg.pci_mmio.base,
> s->cfg.pci_mmio.size);
> > +        memory_region_add_subregion(sysmem, s->cfg.pci_mmio.base,
> > +                                    &s->pci.mmio_alias);
> > +    }
> > +
> > +    if (s->cfg.pci_mmio_high.size) {
> > +        memory_region_init_alias(&s->pci.mmio_high_alias, OBJECT(dev),
> > +                "pcie-mmio-high",
> > +                mmio_reg, s->cfg.pci_mmio_high.base,
> s->cfg.pci_mmio_high.size);
> > +        memory_region_add_subregion(sysmem, s->cfg.pci_mmio_high.base,
> > +                &s->pci.mmio_high_alias);
> > +    }
> > +
> > +    /*
> > +     * PVH implementations with PCI enabled must provide
> set_pci_intx_irq()
> > +     * and optionally an implementation of set_pci_link_route().
> > +     */
> > +    assert(xpc->set_pci_intx_irq);
> > +
> > +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +        qemu_irq irq =3D qemu_allocate_irq(xpc->set_pci_intx_irq, s, i=
);
> > +
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> > +        gpex_set_irq_num(GPEX_HOST(dev), i, s->cfg.pci_intx_irq_base +
> i);
> > +        if (xpc->set_pci_link_route) {
> > +            xpc->set_pci_link_route(i, s->cfg.pci_intx_irq_base + i);
> > +        }
> > +    }
> > +}
>
> Some Kconfig selector seems missing here:
>
> /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: in
> function `xenpvh_gpex_init':
> hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_num'
> /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in
> function `pci_dev_bus_num':
> include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
> /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_nu=
m'
> /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_nu=
m'
> /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_nu=
m'
> /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_nu=
m'
> /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in
> function `cpu_ioreq_config':
> hw/xen/xen-hvm-common.c:412: undefined reference to
> `pci_host_config_read_common'
> /usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to
> `pci_host_config_read_common'
> /usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to
> `pci_host_config_write_common'
>
> The current 'XEN' key represents both the "accelerator" part and
> the common Xen HW, which isn't helping to follow. Anyhow, this
> snippet fixes the build issue:
>
> -- >8 --
> diff --git a/accel/Kconfig b/accel/Kconfig
> index 794e0d18d2..4263cab722 100644
> --- a/accel/Kconfig
> +++ b/accel/Kconfig
> @@ -16,4 +16,5 @@ config KVM
>   config XEN
>       bool
>       select FSDEV_9P if VIRTFS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
>       select XEN_BUS
> ---
>
> I'll post a patch later.
>


Sounds good, thanks Phil!

Cheers,
Edgar


>
> Regards,
>
> Phil.
>

--000000000000d76709062e6d383d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 18, 202=
5 at 6:02=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:phil=
md@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Edgar,<br>
<br>
On 4/9/24 18:15, Edgar E. Iglesias wrote:<br>
&gt; From: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesi=
as@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; <br>
&gt; Add support for optionally creating a PCIe/GPEX controller.<br>
&gt; <br>
&gt; Signed-off-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@=
amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kern=
el.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/xen/xen-pvh-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 76 +++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/xen/xen-pvh-common.h | 29 +++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 105 insertions(+)<br>
<br>
<br>
&gt; +/*<br>
&gt; + * We use the GPEX PCIe controller with its internal INTX PCI interru=
pt<br>
&gt; + * swizzling. This swizzling is emulated in QEMU and routes all INTX<=
br>
&gt; + * interrupts from endpoints down to only 4 INTX interrupts.<br>
&gt; + * See include/hw/pci/pci.h : pci_swizzle()<br>
&gt; + */<br>
&gt; +static inline void xenpvh_gpex_init(XenPVHMachineState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 XenPVHMachineClass=
 *xpc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *sysm=
em)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *ecam_reg;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mmio_reg;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_initialize_child(OBJECT(s), &quot;gpex&quot;, &a=
mp;s-&gt;pci.gpex,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_GPEX_HOST);<br>
&gt; +=C2=A0 =C2=A0 dev =3D DEVICE(&amp;s-&gt;pci.gpex);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp;erro=
r_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev)=
, 0);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(sysmem, s-&gt;cfg.pci_ecam.=
base, ecam_reg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev)=
, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;cfg.pci_mmio.size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_alias(&amp;s-&gt;pci.m=
mio_alias, OBJECT(dev), &quot;pcie-mmio&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmio_reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cfg.pci_mmio.base, s=
-&gt;cfg.pci_mmio.size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(sysmem, s-&gt=
;cfg.pci_mmio.base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;pci.mmi=
o_alias);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;cfg.pci_mmio_high.size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_alias(&amp;s-&gt;pci.m=
mio_high_alias, OBJECT(dev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pcie-mm=
io-high&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_reg, s-&=
gt;cfg.pci_mmio_high.base, s-&gt;cfg.pci_mmio_high.size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(sysmem, s-&gt=
;cfg.pci_mmio_high.base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;pc=
i.mmio_high_alias);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* PVH implementations with PCI enabled must provi=
de set_pci_intx_irq()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and optionally an implementation of set_pci_lin=
k_route().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 assert(xpc-&gt;set_pci_intx_irq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq irq =3D qemu_allocate_irq(xpc-&g=
t;set_pci_intx_irq, s, i);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(dev), i=
, irq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpex_set_irq_num(GPEX_HOST(dev), i, s-&gt=
;cfg.pci_intx_irq_base + i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xpc-&gt;set_pci_link_route) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xpc-&gt;set_pci_link_route(=
i, s-&gt;cfg.pci_intx_irq_base + i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
Some Kconfig selector seems missing here:<br>
<br>
/usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: in <br>
function `xenpvh_gpex_init&#39;:<br>
hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_num&#39;<=
br>
/usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in <br>
function `pci_dev_bus_num&#39;:<br>
include/hw/pci/pci.h:337: undefined reference to `pci_bus_num&#39;<br>
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num&=
#39;<br>
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num&=
#39;<br>
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num&=
#39;<br>
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num&=
#39;<br>
/usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in <br>
function `cpu_ioreq_config&#39;:<br>
hw/xen/xen-hvm-common.c:412: undefined reference to <br>
`pci_host_config_read_common&#39;<br>
/usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to <br>
`pci_host_config_read_common&#39;<br>
/usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to <br>
`pci_host_config_write_common&#39;<br>
<br>
The current &#39;XEN&#39; key represents both the &quot;accelerator&quot; p=
art and<br>
the common Xen HW, which isn&#39;t helping to follow. Anyhow, this<br>
snippet fixes the build issue:<br>
<br>
-- &gt;8 --<br>
diff --git a/accel/Kconfig b/accel/Kconfig<br>
index 794e0d18d2..4263cab722 100644<br>
--- a/accel/Kconfig<br>
+++ b/accel/Kconfig<br>
@@ -16,4 +16,5 @@ config KVM<br>
=C2=A0 config XEN<br>
=C2=A0 =C2=A0 =C2=A0 bool<br>
=C2=A0 =C2=A0 =C2=A0 select FSDEV_9P if VIRTFS<br>
+=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRIDGE<br>
=C2=A0 =C2=A0 =C2=A0 select XEN_BUS<br>
---<br>
<br>
I&#39;ll post a patch later.<br></blockquote><div><br></div><div><br></div>=
<div>Sounds good, thanks Phil!</div><div><br></div><div>Cheers,</div><div>E=
dgar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Regards,<br>
<br>
Phil.<br>
</blockquote></div></div>

--000000000000d76709062e6d383d--

