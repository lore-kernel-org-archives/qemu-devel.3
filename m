Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A74C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 12:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyrkv-0002Be-Rr; Sun, 30 Mar 2025 08:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyrku-0002B9-DP
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 08:27:12 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyrkr-0008BX-GN
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 08:27:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac73723b2d5so259750366b.3
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743337628; x=1743942428; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WzIe1jdACgIQ7UNeHp1tDyD9lG13/NhqSkcAVydV5TQ=;
 b=m+vyve29oRB8AiNhzA38EV5kVIQ7K63WLynopIEUD92kjJFK+espBN/OlvEk+biIrw
 LYx0LHATdL2IjDSu2RFBsZO2I0G2FLZrqhKnIZMtiNBUL0S1uOGG5hFhayMoIZu9Mhxw
 jLqjraFQWpS5Sqb+NDtOsE6MrhKhAdn7xjcEV5c6SeT1Nls1FlPNZemvntmg44rq5YZx
 ygkqpwtb+lSLje3DWlO2ViFHqEY3XDp/10suU/b7POStQQRhCZeQKE3vZ15Jc4KFzskN
 Y0qsjMYPqYBt+TqqHd4/rr9fiCRqqzRK0ALzERYnnjDmdGbcJIwR10fxR5eno2gt4iWK
 dDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743337628; x=1743942428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WzIe1jdACgIQ7UNeHp1tDyD9lG13/NhqSkcAVydV5TQ=;
 b=vLGt2XdSiuHf1WISOpHVNokJXJYKYhdlBuwDxg8Zzb5wF+E3Btwrjwbnl5JvhOq7Vm
 ASX926OIg1pW8vlDJ/DFXksOu3/5bOSOEIlK2PED4vvU0E5wJxZW46jjbirHBx0/mNMI
 N7n2mkEsD6WRMDKPuH7ZnvPB3//3NMAzdcTwOGryBpjzoPfo3Y72X+lqQ7v24IIxCqId
 2JxNXHIDKaFt4w85mWBBz0k12rpPYujvHYWiyNR7nbqAukgNGB+xaoCRM1O5gHbYYF4h
 r6olG4JbLO71bE4nkWSEeFpJlKkMdvoEVbegjGK7KN0G0WBOpRq+M7YQ7akSZtlnHyy0
 qheQ==
X-Gm-Message-State: AOJu0YxPJ1JMatrViJd2sMWARLoY5A700PmwyW2QvyyY8XJcuSyIv334
 zYJXy7qgYxTr7t79pPhzV50c+uPeMetKVrHGPo5IrEzpmY0uSeSc/yrqfqT2iEd35n6kMGCUcTH
 +2xsII3syY70wuM+vgkLd8OMC6tU=
X-Gm-Gg: ASbGncvVlHOAB2NAZ/nWFpLa5i/jBquplc/PnOwbGNZKigMvDfts1gBs+v7x9J2Vo9X
 qPEMienERN9+pyGxCmPkDkjXNnaBHAVw6ZFERKYe18btDorgvBzIvXPBg7MdbKbopPTB1xZtdZT
 FpS48bqFOWT/xNPeC0IVqVhlmDZP5027SnAxNgi5sQI31fNnxsAV/RCOsVKRES
X-Google-Smtp-Source: AGHT+IHJjUhGukoG8aCWNgjggqWbwR9Eo8SwHmpfA2/1QC3oKMcwkJMAZXE12NVjQCH15c1GyqnzFhQMJYV56olHFKY=
X-Received: by 2002:a17:907:9719:b0:ac3:8516:9cf2 with SMTP id
 a640c23a62f3a-ac738c27ec7mr495816566b.55.1743337627383; Sun, 30 Mar 2025
 05:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250329004941.372000-1-rakeshjb010@gmail.com>
 <5cfc6e91-b50e-4541-b924-50306459a11b@linaro.org>
In-Reply-To: <5cfc6e91-b50e-4541-b924-50306459a11b@linaro.org>
From: Rakesh J <rakeshjb010@gmail.com>
Date: Sun, 30 Mar 2025 17:56:55 +0530
X-Gm-Features: AQ5f1JrJ9y6wH69db8LX5TJQCDu5TAtbAZCIiFwMTnIjn2ygpMMC6GP3L-V-wec
Message-ID: <CAD8nu1jE5Z2+VpZqPbVNO7SZU-JtPyPQrwz7ivYekHOs4tbziw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 thuth@redhat.com, 
 BALATON Zoltan <balaton@eik.bme.hu>, marcandre.lureau@redhat.com
Content-Type: multipart/alternative; boundary="00000000000001050406318e6ca5"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=rakeshjb010@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000001050406318e6ca5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Rakesh,
>
> On 29/3/25 01:49, rakeshj wrote:
> > The GT-64120 PCI controller requires special handling where:
> > 1. Host bridge (device 0) must use native endianness
> > 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
> >
> > Previous implementation accidentally swapped all accesses, breaking
> > host bridge detection (lspci -d 11ab:4620).
> >
> > This patch:
> > - Adds custom read/write handlers to preserve native big-endian for the
> host
> >    bridge (phb->config_reg & 0x00fff800 =3D=3D 0).
>
> Here you check for bus =3D=3D 0 && device =3D=3D 0, is that what you want=
? (I'm
> confused because you only describe "for the host bridge").


yes, I meant bus 0, device 0

>

If so I'd rather add a self-describing method:
>
>   static bool is_phb_dev0(const PCIHostState *phb)
>   {
>       return extract32(phb->config_reg, 11, 5 /* dev */ + 8 /* bus) =3D=
=3D 0;
>   }
>
> > - Swaps non-bridge devices when MByteSwap =3D 0, using size-appropriate
> swaps
> >    (bswap16 for 2-byte, bswap32 for 4-byte) to convert PCI's
> little-endian data
> >    to match the MIPS guest's big-endian expectation; no swap occurs for
> the host
> >    bridge or when MByteSwap =3D 1 (little-endian mode).
> > - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem
> initialization
> >    to gt64120_realize()
> > - Removes unused pci_host_data_be_ops and a misleading comment in dino.=
h.
> >
> > Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDG=
E
> MemoryRegionOps")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
> > Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
> > ---
> >   hw/pci-host/gt64120.c      | 83 ++++++++++++++++++++++---------------=
-
> >   hw/pci/pci_host.c          |  6 ---
> >   include/hw/pci-host/dino.h |  5 +--
> >   include/hw/pci/pci_host.h  |  1 -
> >   4 files changed, 50 insertions(+), 45 deletions(-)
> >
> > diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> > index d5c13a89b6..4e45d0aa53 100644
> > --- a/hw/pci-host/gt64120.c
> > +++ b/hw/pci-host/gt64120.c
> > @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
> >       memory_region_transaction_commit();
> >   }
> >
> > -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
> > -{
> > -    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset:
> 0xc00 */
> > -    static const MemoryRegionOps *pci_host_data_ops[] =3D {
> > -        &pci_host_data_be_ops, &pci_host_data_le_ops
> > -    };
> > -    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> > -
> > -    memory_region_transaction_begin();
> > -
> > -    /*
> > -     * The setting of the MByteSwap bit and MWordSwap bit in the PCI
> Internal
> > -     * Command Register determines how data transactions from the CPU
> to/from
> > -     * PCI are handled along with the setting of the Endianness bit in
> the CPU
> > -     * Configuration Register. See:
> > -     * - Table 16: 32-bit PCI Transaction Endianness
> > -     * - Table 158: PCI_0 Command, Offset: 0xc00
> > -     */
> > -
> > -    if (memory_region_is_mapped(&phb->data_mem)) {
> > -        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
> > -        object_unparent(OBJECT(&phb->data_mem));
> > -    }
> > -    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> > -                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
> > -                          s, "pci-conf-data", 4);
> > -    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA <=
<
> 2,
> > -                                        &phb->data_mem, 1);
> > -
> > -    memory_region_transaction_commit();
> > -}
> > -
> >   static void gt64120_pci_mapping(GT64120State *s)
> >   {
> >       memory_region_transaction_begin();
> > @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
> >       case GT_PCI0_CMD:
> >       case GT_PCI1_CMD:
> >           s->regs[saddr] =3D val & 0x0401fc0f;
> > -        gt64120_update_pci_cfgdata_mapping(s);
> >           break;
> >       case GT_PCI0_TOR:
> >       case GT_PCI0_BS_SCS10:
> > @@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops =3D {
> >       },
> >   };
> >
> > +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr,
> unsigned size)
> > +{
> > +    GT64120State *s =3D opaque;
> > +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> > +    uint32_t val =3D pci_data_read(phb->bus, phb->config_reg, size);
>
> You check the Enable bit in the write path but not here, any reason?
>

thanks for pointing it out, I missed to notice it

> > +
> > +    /* Only swap for non-bridge devices in big-endian mode */
> > +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800))=
 {
>
> Please use instead of (s->regs[GT_PCI0_CMD] & 1):
>
>    bswap =3D FIELD_EX32(s->regs[GT_PCI0_CMD]m GT_PCI0_CMD, MByteSwap);
>
> > +        if (size =3D=3D 2) {
> > +            val =3D bswap16(val);
> > +        } else if (size =3D=3D 4) {
> > +            val =3D bswap32(val);
> > +        }
> > +    }
> > +    return val;
> > +}
> > +
> > +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
> > +    uint64_t val, unsigned size)
> > +{
> > +    GT64120State *s =3D opaque;
> > +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> > +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800))=
 {
> > +        if (size =3D=3D 2) {
> > +            val =3D bswap16(val);
> > +        } else if (size =3D=3D 4) {
> > +            val =3D bswap32(val);
> > +        }
> > +    }
> > +    if (phb->config_reg & (1u << 31))
> > +        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val,
> size);
> > +}
> > +
> > +static const MemoryRegionOps gt64120_pci_data_ops =3D {
> > +    .read =3D gt64120_pci_data_read,
> > +    .write =3D gt64120_pci_data_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
>
> Per GT64120 rev 1.4, chapter "6.2.2 PCI Master CPU Byte Swapping":
>
>    When the GT=E2=80=9364120 is configured for 64-bit PCI mode, byte
>    swapping occurs across all 8 byte lanes when the ByteSwap
>    bit is set for PCI_0.
>
> >   static void gt64120_reset(DeviceState *dev)
> >   {
> >       GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(dev);
> > @@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)
> >
> >       gt64120_isd_mapping(s);
> >       gt64120_pci_mapping(s);
> > -    gt64120_update_pci_cfgdata_mapping(s);
> >   }
> >
> >   static void gt64120_realize(DeviceState *dev, Error **errp)
> > @@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *dev,
> Error **errp)
> >       memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR
> << 2,
> >                                           &phb->conf_mem, 1);
> >
> > +    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> > +                          &gt64120_pci_data_ops,
> > +                          s, "pci-conf-data", 4);
> > +    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA <=
<
> 2,
> > +                                        &phb->data_mem, 1);
> > +
> >
> >       /*
> >        * The whole address space decoded by the GT-64120A doesn't
> generate
>
> Please split the changes below in a distinct cleanup patch.
>
> > diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> > index 80f91f409f..56f7f28a1a 100644
> > --- a/hw/pci/pci_host.c
> > +++ b/hw/pci/pci_host.c
> > @@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops =3D {
> >       .endianness =3D DEVICE_LITTLE_ENDIAN,
> >   };
> >
> > -const MemoryRegionOps pci_host_data_be_ops =3D {
> > -    .read =3D pci_host_data_read,
> > -    .write =3D pci_host_data_write,
> > -    .endianness =3D DEVICE_BIG_ENDIAN,
> > -};
> > -
> >   static bool pci_host_needed(void *opaque)
> >   {
> >       PCIHostState *s =3D opaque;
> > diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
> > index fd7975c798..df509dbc18 100644
> > --- a/include/hw/pci-host/dino.h
> > +++ b/include/hw/pci-host/dino.h
> > @@ -109,10 +109,7 @@ static const uint32_t
> reg800_keep_bits[DINO800_REGS] =3D {
> >   struct DinoState {
> >       PCIHostState parent_obj;
> >
> > -    /*
> > -     * PCI_CONFIG_ADDR is parent_obj.config_reg, via
> pci_host_conf_be_ops,
> > -     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
> > -     */
> > +
> >       uint32_t config_reg_dino; /* keep original copy, including 2
> lowest bits */
> >
> >       uint32_t iar0;
> > diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> > index e52d8ec2cd..954dd446fa 100644
> > --- a/include/hw/pci/pci_host.h
> > +++ b/include/hw/pci/pci_host.h
> > @@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr,
> unsigned len);
> >   extern const MemoryRegionOps pci_host_conf_le_ops;
> >   extern const MemoryRegionOps pci_host_conf_be_ops;
> >   extern const MemoryRegionOps pci_host_data_le_ops;
> > -extern const MemoryRegionOps pci_host_data_be_ops;
> >
> >   #endif /* PCI_HOST_H */
>

Proposed v3 Changes:
1. Use extract32 in is_phb_dev0() for bus 0, device 0 check (Philippe).
2. FIELD_EX32 instead of (s->regs[GT_PCI0_CMD] & 1) (Philippe).
3. Size-specific swaps: bswap16 for 2-byte, bswap32 for 4-byte (Paolo).
4.  check the Enable bit in the read path (Philippe).
5. Split cleanup into [PATCH v3 2/2].

--00000000000001050406318e6ca5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 29,=
 2025 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi Rakesh,<br>
<br>
On 29/3/25 01:49, rakeshj wrote:<br>
&gt; The GT-64120 PCI controller requires special handling where:<br>
&gt; 1. Host bridge (device 0) must use native endianness<br>
&gt; 2. Other devices follow MByteSwap bit in GT_PCI0_CMD<br>
&gt; <br>
&gt; Previous implementation accidentally swapped all accesses, breaking<br=
>
&gt; host bridge detection (lspci -d 11ab:4620).<br>
&gt; <br>
&gt; This patch:<br>
&gt; - Adds custom read/write handlers to preserve native big-endian for th=
e host<br>
&gt;=C2=A0 =C2=A0 bridge (phb-&gt;config_reg &amp; 0x00fff800 =3D=3D 0).<br=
>
<br>
Here you check for bus =3D=3D 0 &amp;&amp; device =3D=3D 0, is that what yo=
u want? (I&#39;m<br>
confused because you only describe &quot;for the host bridge&quot;).</block=
quote><div>=C2=A0</div><div>yes, I meant bus 0, device 0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
If so I&#39;d rather add a self-describing method:<br>
<br>
=C2=A0 static bool is_phb_dev0(const PCIHostState *phb)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 return extract32(phb-&gt;config_reg, 11, 5 /* dev */ +=
 8 /* bus) =3D=3D 0;<br>
=C2=A0 }<br>
<br>
&gt; - Swaps non-bridge devices when MByteSwap =3D 0, using size-appropriat=
e swaps<br>
&gt;=C2=A0 =C2=A0 (bswap16 for 2-byte, bswap32 for 4-byte) to convert PCI&#=
39;s little-endian data<br>
&gt;=C2=A0 =C2=A0 to match the MIPS guest&#39;s big-endian expectation; no =
swap occurs for the host<br>
&gt;=C2=A0 =C2=A0 bridge or when MByteSwap =3D 1 (little-endian mode).<br>
&gt; - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem initia=
lization<br>
&gt;=C2=A0 =C2=A0 to gt64120_realize()<br>
&gt; - Removes unused pci_host_data_be_ops and a misleading comment in dino=
.h.<br>
&gt; <br>
&gt; Fixes: 145e2198 (&quot;hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST=
_BRIDGE MemoryRegionOps&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/282=
6" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2826</a><br>
&gt; Signed-off-by: Rakesh Jeyasingh &lt;<a href=3D"mailto:rakeshjb010@gmai=
l.com" target=3D"_blank">rakeshjb010@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/pci-host/gt64120.c=C2=A0 =C2=A0 =C2=A0 | 83 +++++++++++=
+++++++++++----------------<br>
&gt;=C2=A0 =C2=A0hw/pci/pci_host.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 6 ---<br>
&gt;=C2=A0 =C2=A0include/hw/pci-host/dino.h |=C2=A0 5 +--<br>
&gt;=C2=A0 =C2=A0include/hw/pci/pci_host.h=C2=A0 |=C2=A0 1 -<br>
&gt;=C2=A0 =C2=A04 files changed, 50 insertions(+), 45 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c<br>
&gt; index d5c13a89b6..4e45d0aa53 100644<br>
&gt; --- a/hw/pci-host/gt64120.c<br>
&gt; +++ b/hw/pci-host/gt64120.c<br>
&gt; @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_commit();<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 /* Indexed on MByteSwap bit, see Table 158: PCI_0 Comma=
nd, Offset: 0xc00 */<br>
&gt; -=C2=A0 =C2=A0 static const MemoryRegionOps *pci_host_data_ops[] =3D {=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pci_host_data_be_ops, &amp;pci_host_=
data_le_ops<br>
&gt; -=C2=A0 =C2=A0 };<br>
&gt; -=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* The setting of the MByteSwap bit and MWordSwap =
bit in the PCI Internal<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* Command Register determines how data transactio=
ns from the CPU to/from<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* PCI are handled along with the setting of the E=
ndianness bit in the CPU<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* Configuration Register. See:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* - Table 16: 32-bit PCI Transaction Endianness<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0* - Table 158: PCI_0 Command, Offset: 0xc00<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (memory_region_is_mapped(&amp;phb-&gt;data_mem)) {<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_subregion(&amp;s-&gt;IS=
D_mem, &amp;phb-&gt;data_mem);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(&amp;phb-&gt;data_=
mem));<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data_mem, OBJECT(phb=
),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pci_host_data_ops[s-&gt;regs[GT_PCI0_CMD] &amp; 1],<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 s, &quot;pci-conf-data&quot;, 4);<br>
&gt; -=C2=A0 =C2=A0 memory_region_add_subregion_overlap(&amp;s-&gt;ISD_mem,=
 GT_PCI0_CFGDATA &lt;&lt; 2,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;phb-&gt;data_mem, 1);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 memory_region_transaction_commit();<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static void gt64120_pci_mapping(GT64120State *s)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_begin();<br>
&gt; @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr ad=
dr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI0_CMD:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI1_CMD:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[saddr] =3D val &amp=
; 0x0401fc0f;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI0_TOR:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI0_BS_SCS10:<br>
&gt; @@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops =3D {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsi=
gned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
&gt; +=C2=A0 =C2=A0 uint32_t val =3D pci_data_read(phb-&gt;bus, phb-&gt;con=
fig_reg, size);<br>
<br>
You check the Enable bit in the write path but not here, any reason?<br></b=
lockquote><div><br></div><div>thanks for pointing it out, I missed to notic=
e it=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Only swap for non-bridge devices in big-endian mode =
*/<br>
&gt; +=C2=A0 =C2=A0 if (!(s-&gt;regs[GT_PCI0_CMD] &amp; 1) &amp;&amp; (phb-=
&gt;config_reg &amp; 0x00fff800)) {<br>
<br>
Please use instead of (s-&gt;regs[GT_PCI0_CMD] &amp; 1):<br>
<br>
=C2=A0 =C2=A0bswap =3D FIELD_EX32(s-&gt;regs[GT_PCI0_CMD]m GT_PCI0_CMD, MBy=
teSwap);<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size =3D=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap16(val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (size =3D=3D 4) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void gt64120_pci_data_write(void *opaque, hwaddr addr,<br>
&gt; +=C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
&gt; +=C2=A0 =C2=A0 if (!(s-&gt;regs[GT_PCI0_CMD] &amp; 1) &amp;&amp; (phb-=
&gt;config_reg &amp; 0x00fff800)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size =3D=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap16(val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (size =3D=3D 4) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (phb-&gt;config_reg &amp; (1u &lt;&lt; 31))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_data_write(phb-&gt;bus, phb-&gt;confi=
g_reg | (addr &amp; 3), val, size);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps gt64120_pci_data_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D gt64120_pci_data_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D gt64120_pci_data_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
<br>
Per GT64120 rev 1.4, chapter &quot;6.2.2 PCI Master CPU Byte Swapping&quot;=
:<br>
<br>
=C2=A0 =C2=A0When the GT=E2=80=9364120 is configured for 64-bit PCI mode, b=
yte<br>
=C2=A0 =C2=A0swapping occurs across all 8 byte lanes when the ByteSwap<br>
=C2=A0 =C2=A0bit is set for PCI_0.<br>
<br>
&gt;=C2=A0 =C2=A0static void gt64120_reset(DeviceState *dev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(=
dev);<br>
&gt; @@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gt64120_isd_mapping(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gt64120_pci_mapping(s);<br>
&gt; -=C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void gt64120_realize(DeviceState *dev, Error **errp=
)<br>
&gt; @@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *dev, E=
rror **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(&amp;s-&=
gt;ISD_mem, GT_PCI0_CFGADDR &lt;&lt; 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;phb-&gt;conf_mem, 1);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data_mem, OBJECT(phb=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;gt64120_pci_data_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 s, &quot;pci-conf-data&quot;, 4);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion_overlap(&amp;s-&gt;ISD_mem,=
 GT_PCI0_CFGDATA &lt;&lt; 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;phb-&gt;data_mem, 1);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The whole address space decoded by the GT=
-64120A doesn&#39;t generate<br>
<br>
Please split the changes below in a distinct cleanup patch.<br>
<br>
&gt; diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c<br>
&gt; index 80f91f409f..56f7f28a1a 100644<br>
&gt; --- a/hw/pci/pci_host.c<br>
&gt; +++ b/hw/pci/pci_host.c<br>
&gt; @@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -const MemoryRegionOps pci_host_data_be_ops =3D {<br>
&gt; -=C2=A0 =C2=A0 .read =3D pci_host_data_read,<br>
&gt; -=C2=A0 =C2=A0 .write =3D pci_host_data_write,<br>
&gt; -=C2=A0 =C2=A0 .endianness =3D DEVICE_BIG_ENDIAN,<br>
&gt; -};<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static bool pci_host_needed(void *opaque)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIHostState *s =3D opaque;<br>
&gt; diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h<b=
r>
&gt; index fd7975c798..df509dbc18 100644<br>
&gt; --- a/include/hw/pci-host/dino.h<br>
&gt; +++ b/include/hw/pci-host/dino.h<br>
&gt; @@ -109,10 +109,7 @@ static const uint32_t reg800_keep_bits[DINO800_RE=
GS] =3D {<br>
&gt;=C2=A0 =C2=A0struct DinoState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIHostState parent_obj;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* PCI_CONFIG_ADDR is parent_obj.config_reg, via p=
ci_host_conf_be_ops,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* so that we can map PCI_CONFIG_DATA to pci_host_=
data_be_ops.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t config_reg_dino; /* keep original c=
opy, including 2 lowest bits */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t iar0;<br>
&gt; diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h<br>
&gt; index e52d8ec2cd..954dd446fa 100644<br>
&gt; --- a/include/hw/pci/pci_host.h<br>
&gt; +++ b/include/hw/pci/pci_host.h<br>
&gt; @@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, uns=
igned len);<br>
&gt;=C2=A0 =C2=A0extern const MemoryRegionOps pci_host_conf_le_ops;<br>
&gt;=C2=A0 =C2=A0extern const MemoryRegionOps pci_host_conf_be_ops;<br>
&gt;=C2=A0 =C2=A0extern const MemoryRegionOps pci_host_data_le_ops;<br>
&gt; -extern const MemoryRegionOps pci_host_data_be_ops;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* PCI_HOST_H */<br></blockquote><div><br></div><di=
v>Proposed v3 Changes:<br>1. Use extract32 in is_phb_dev0() for bus 0, devi=
ce 0 check (Philippe).<br>2. FIELD_EX32 instead of (s-&gt;regs[GT_PCI0_CMD]=
 &amp; 1)=C2=A0(Philippe).<br>3. Size-specific swaps: bswap16 for 2-byte, b=
swap32 for 4-byte (Paolo).<br>4.=C2=A0=C2=A0check the Enable bit in the rea=
d path (Philippe).</div><div>5. Split cleanup into [PATCH v3 2/2].</div><di=
v>=C2=A0</div></div></div>

--00000000000001050406318e6ca5--

