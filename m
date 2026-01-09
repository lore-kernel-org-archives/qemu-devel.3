Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08E0D26D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 19:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veI1C-0001ka-LZ; Fri, 09 Jan 2026 14:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tphan@ventanamicro.com>)
 id 1veI0Q-0001gx-TL
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 14:18:45 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tphan@ventanamicro.com>)
 id 1veI0O-0002yr-Vp
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 14:18:42 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-5eea6f90d7fso1165992137.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767986311; x=1768591111; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X3VVui9TiP6wwXvGFG11MrSaNUb0WOIuWjdCNxEa6V4=;
 b=E/auu7/CPnDX6YcNuUKLrQSrQEgnVbWOGTqG3CAcuStNlH+GrifmyZA2zLwAYVBhXB
 bGaQWA9Qg2VY7+2RfXn018dJ4Dz6NZGkJg7nnZarMCtxudPNF2XAzIoRrcjOmLcs4b1O
 RBym/WChex2oWqVMYdTPKMihM/UaLCxoVe3vylemURu/xkaIUPOiZ70dldBOgKN1SGEY
 jQPidE2Zbyxu2lEbgUdVSxwd8QPKRvjeltiKW/dV9kr2603osLdfVuLGnkA9jnCzH9ud
 QoiCWh8sKuCpJbz6BFNNFj07Odf+0hN7VWCI62hGwQ92IXVSa4LmW1gyFfkJNVqlf8ub
 Ieiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767986311; x=1768591111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3VVui9TiP6wwXvGFG11MrSaNUb0WOIuWjdCNxEa6V4=;
 b=cat465UGiRgXvzehBQUCdUITei42kaOOLkzBFx7ouyGkYAQsWG7zyww64qOfJf0gHT
 CX/J/2TUmPcPDOFtREc/2/IvwDSmFK7uEidQ9qV/GYumOmYA49VgzBTpLae6eFOrEcoW
 9TKzIECbNu0wShXvRFZ37y9lSsuAPtHD/yr5MH24xURp8Nbwr5HritGpLAC5r4b0qFKs
 aWnf/RK12Y4Lu1RvEEQK7Q7R0sclJrY6ydkYzvpFTxkQUqznwZzJ5ZilwLZMpTZWXn5y
 FERs2Wt4FXvP5gtPrIrtiy6+xQg9mFv5pqcOePyk1rYu7+jkwC6EbGAxL15aa3AJnM3h
 sLrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWODQOgvlsr7GdNGYdEPZz6d4ZpcZWePLomO8VmcLqD+jIUh2PxXD5ha/fnb0UdhEgArHXIka3tcNcv@nongnu.org
X-Gm-Message-State: AOJu0YxmVRCMGkIYuapk8CL+fx8j0uh8RHiHnRp/koDHlzpG8hCU7jRu
 Jx/MptApYfOpTRY1Qr9wxLaYMB4A9eNkLj3EeQ3c6xsM7jZVamFdUX2VccrP0I+O6SBudU63icY
 k0Fmy3NK1HkA6DiscDemDzh6xLIE+dJ2O3McgAkgc1Q==
X-Gm-Gg: AY/fxX64zJX+vkSMM/jp+sU8nczo0oBxf8rrBF8AuRRa+InTfRtASaeKb36ak/Mr1Gv
 phFpsXirarBrFVvnPj7qs1GoNpcbZKmrNAEt6QjNjamOfuWwHYOpo+nJSjxbt4scsnxmo5FTc4x
 RfVm0MGwG4yUtWjvOKUKOBzGx/bTEE4WNDMAQBRzYeMlF8bSUIuuUekamK+bEax1rJM6USdqTf3
 JAs707/b8LCBRkJlx+up699OC0HGUeRXYDmt3B9lqmLPTRXNE+QHK8zTIosd11KdihKmaPiNzmv
 kIY5BEj9dDYpBG6YUs+9q7g=
X-Google-Smtp-Source: AGHT+IFZwe4VjhZE/j9kZ89wAj0SYYW2pFsLMuksqEDwFiPonDnFibvKNMyQU4uj3rtsayKidA5N8p8y/0o+2gbQdBc=
X-Received: by 2002:a05:6102:9d7:b0:5db:ebb4:fded with SMTP id
 ada2fe7eead31-5ecb68dbab3mr4471664137.25.1767986311347; Fri, 09 Jan 2026
 11:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20251203002259.2856-1-tphan@ventanamicro.com>
 <5ed187df-61ae-4a59-98b2-cb2cc32b084a@gmail.com>
In-Reply-To: <5ed187df-61ae-4a59-98b2-cb2cc32b084a@gmail.com>
From: Tuan Phan <tphan@ventanamicro.com>
Date: Fri, 9 Jan 2026 11:18:20 -0800
X-Gm-Features: AZwV_QjnYQ9LyJwlzmF0nbrdofD8wLGGwVqc-IsR9JrvNEvKNy7i4JexXUXvqck
Message-ID: <CABYABGSmSoMvyHDdy8OHBvVBwMhUNRM8EzO3szDiboeCSeh=Ag@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add TPM2 device node and ACPI
 table support
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 sunilvl@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="0000000000000e4bd90647f9644a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=tphan@ventanamicro.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000000e4bd90647f9644a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:30=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.co=
m> wrote:

> On Tue,  2 Dec 2025 16:22:59 -0800, Tuan Phan wrote:
> > This patch enables TPM2 support in the RISC-V virt machine ACPI builder=
.
> >
> > Signed-off-by: Tuan Phan <tphan@ventanamicro.com>
> > ---
> >  hw/riscv/virt-acpi-build.c | 56 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index f1406cb68339..b5bf812a9d36 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -32,6 +32,7 @@
> >  #include "hw/intc/riscv_aclint.h"
> >  #include "hw/nvram/fw_cfg_acpi.h"
> >  #include "hw/pci-host/gpex.h"
> > +#include "hw/platform-bus.h"
> >  #include "hw/riscv/virt.h"
> >  #include "hw/riscv/numa.h"
> >  #include "hw/virtio/virtio-acpi.h"
> > @@ -39,6 +40,7 @@
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "system/reset.h"
> > +#include "system/tpm.h"
> >
> >  #define ACPI_BUILD_TABLE_SIZE             0x20000
> >  #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
> > @@ -224,6 +226,41 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope,
> const
> MemMapEntry *iommu_memmap,
> >      aml_append(scope, dev);
> >  }
> >
> > +#ifdef CONFIG_TPM
> > +static void acpi_dsdt_add_tpm(Aml *scope, RISCVVirtState *s)
> > +{
> > +    PlatformBusDevice *pbus =3D PLATFORM_BUS_DEVICE(s->platform_bus_de=
v);
> > +    hwaddr pbus_base =3D s->memmap[VIRT_PLATFORM_BUS].base;
> > +    SysBusDevice *sbdev =3D SYS_BUS_DEVICE(tpm_find());
> > +    MemoryRegion *sbdev_mr;
> > +    hwaddr tpm_base;
> > +
> > +    if (!sbdev) {
> > +        return;
> > +    }
> > +
> > +    tpm_base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
> > +    assert(tpm_base !=3D -1);
> > +
> I suggest reporting an error message when the tpm_base check fails.
>
>     if (tpm_base =3D=3D -1) {
>         error_report("Failed to get TPM MMIO address");
>         exit(1);
>     }
>
> Thanks,
> Chao
>

Thanks Chao, I will change it as per your suggestion. BTW, I will resend
this patch from my new email from Qualcomm.

--0000000000000e4bd90647f9644a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 19,=
 2025 at 12:30=E2=80=AFAM Chao Liu &lt;<a href=3D"mailto:chao.liu.zevorn@gm=
ail.com">chao.liu.zevorn@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>On Tue,=C2=A0 2 Dec 2025 16:22:59 -0800, Tuan Phan wrote:<br>
&gt; This patch enables TPM2 support in the RISC-V virt machine ACPI builde=
r.<br>
&gt;<br>
&gt; Signed-off-by: Tuan Phan &lt;<a href=3D"mailto:tphan@ventanamicro.com"=
 target=3D"_blank">tphan@ventanamicro.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/riscv/virt-acpi-build.c | 56 ++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 56 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c<b=
r>
&gt; index f1406cb68339..b5bf812a9d36 100644<br>
&gt; --- a/hw/riscv/virt-acpi-build.c<br>
&gt; +++ b/hw/riscv/virt-acpi-build.c<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt;=C2=A0 #include &quot;hw/intc/riscv_aclint.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/nvram/fw_cfg_acpi.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/pci-host/gpex.h&quot;<br>
&gt; +#include &quot;hw/platform-bus.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/riscv/virt.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/riscv/numa.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/virtio-acpi.h&quot;<br>
&gt; @@ -39,6 +40,7 @@<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 #include &quot;system/reset.h&quot;<br>
&gt; +#include &quot;system/tpm.h&quot;<br>
&gt;<br>
&gt;=C2=A0 #define ACPI_BUILD_TABLE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x20000<br>
&gt;=C2=A0 #define ACPI_BUILD_INTC_ID(socket, index) ((socket &lt;&lt; 24) =
| (index))<br>
&gt; @@ -224,6 +226,41 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, c=
onst<br>
MemMapEntry *iommu_memmap,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 aml_append(scope, dev);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +#ifdef CONFIG_TPM<br>
&gt; +static void acpi_dsdt_add_tpm(Aml *scope, RISCVVirtState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PlatformBusDevice *pbus =3D PLATFORM_BUS_DEVICE(s-&gt;p=
latform_bus_dev);<br>
&gt; +=C2=A0 =C2=A0 hwaddr pbus_base =3D s-&gt;memmap[VIRT_PLATFORM_BUS].ba=
se;<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbdev =3D SYS_BUS_DEVICE(tpm_find());<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *sbdev_mr;<br>
&gt; +=C2=A0 =C2=A0 hwaddr tpm_base;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!sbdev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tpm_base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0)=
;<br>
&gt; +=C2=A0 =C2=A0 assert(tpm_base !=3D -1);<br>
&gt; +<br>
I suggest reporting an error message when the tpm_base check fails.<br>
<br>
=C2=A0 =C2=A0 if (tpm_base =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to get TPM MMIO addre=
ss&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
=C2=A0 =C2=A0 }<br>
<br>
Thanks,<br>
Chao<br></blockquote><div><br></div><div>Thanks Chao, I will change it as p=
er your suggestion. BTW, I will resend this patch from my new email from Qu=
alcomm.=C2=A0</div></div></div>

--0000000000000e4bd90647f9644a--

