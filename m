Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A4C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 08:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyo6x-0004u2-Vd; Sun, 30 Mar 2025 04:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyo6q-0004sN-5J
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:33:40 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyo6l-0004uN-DX
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:33:35 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso616902966b.2
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743323609; x=1743928409; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BDvQzn3XCdXQeciHucYyhsDpaWF2Gu/efC6QZtiGl0k=;
 b=a1rc+meI8Vc79Q31VTUs30zVTe0Ey1mIx2bsbbvx1SKH7DsaRZ2tX6+rE5c3DSkhlC
 22a2pOabPmkxO0ZU+r00k/Ll4hElcxHITuQ6S2VOTJYgVprs2MImZPnyCvd6itaNuBt1
 f9GMtDGVEke9f+j+dzOVCLiHxuekoSz2E6/ldFsci0RSnJeQd5O9Hg8KwnW2u7xISis7
 eq4mchmYGgPtyHMSZTUJT842OaU4gkL2IEfEZj/RVkJNZ0ib1rjs/juVKiUly2RwG6pq
 H/mBd98wegwuoOqHSnqtoUjLMW1Zu5HUFRVcJs/BUNBaa6mXhpoz5yoPd2R+UiR7itu1
 ljrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743323609; x=1743928409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BDvQzn3XCdXQeciHucYyhsDpaWF2Gu/efC6QZtiGl0k=;
 b=mN8kUoakqm8xAGqzPGRNkDFjwb74BV2+oKQT689s2NFHw3JaKy+nHIax/BwxLsKF9h
 cNRyrv+bOqpK4YLmoUWIFsGULbGHK4tz2D3kn8g05RCKhPpPM0cVyvqAM73sB40EVEyY
 OQfO8bFjqo/RRN8vw+BkElhL3W9fRnoiEhH1EINyo5AgoFb9VFpSyHcFObV2wQmkFE7l
 4gaV/zZr876Xp3ry4oHHa3EzDAwQEotRf1Nve3Mct/A9p+sN2wYtfIhRS1rkXgdc+WRK
 3kGQoO0rElUCAnqS4c+I4Rfd2rSiIqSFptuKIgCk6kb/+lg/ju1Jao9C6MTTRKX/WStJ
 oOjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy4T6k62OfdyXrdJ+SSblyKKprS2skbvQs4eOsCAnuVyakfdRmns1G++DxR63XCndGjtuebIieSfgV@nongnu.org
X-Gm-Message-State: AOJu0Yy0ijF2bTWTejGrrJWgdjbgtw/5jhpoQADk/mLqdB7dhZcvJJRw
 ir+BKEeujSFKen8sXxqNvQb+RK9XxyWO5xKdl+TBvLsjhMCrxQR2vbn3vOEbNabBX1RZ6tcomMP
 mZ5huha+OM4hOZT9WZJwBRaEMmug=
X-Gm-Gg: ASbGncvQcVjxeeWqmuu0Rj4h/Vwj4VLZvagskK8l9z3QaWnDrVhQoz5YpiXsgKFEBgf
 YOKOvh0mTq3wDJ10aNid5ly0453GDqmK+HSWkKE39ZOt5paDQ9rg5Tk47LZgfq9zGRCHddIX89C
 u8jFu+aLKtIibdIDya2YhiRrGIvdt6b4s7x6Oex+YOn2C0n6tWx1dMGUff4KNc
X-Google-Smtp-Source: AGHT+IE1jdIC+cIeKM0WlxH6nws0+7emJdkMIMWQ5OoCv7EOQqzP616zwgvC7efrk2mQ4HDCYsJbDLTcBl/Nv6sWL4c=
X-Received: by 2002:a17:907:869e:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-ac73898d4b7mr528433666b.7.1743323608958; Sun, 30 Mar 2025
 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250329004941.372000-1-rakeshjb010@gmail.com>
 <5cfc6e91-b50e-4541-b924-50306459a11b@linaro.org>
 <e4ad2e1d-4cfc-115b-5144-df389e70f027@eik.bme.hu>
In-Reply-To: <e4ad2e1d-4cfc-115b-5144-df389e70f027@eik.bme.hu>
From: Rakesh J <rakeshjb010@gmail.com>
Date: Sun, 30 Mar 2025 14:03:16 +0530
X-Gm-Features: AQ5f1JonqXQuTALzCeR9rijwIjPxDi-vhMhnEpyCZVwfnM3HV0TKlQ1pFWv_-Xg
Message-ID: <CAD8nu1jZaJD=H_jh43EiODN92xtE3f6POv=wTguY=eL5+NjeAw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, thuth@redhat.com, 
 marcandre.lureau@redhat.com
Content-Type: multipart/alternative; boundary="00000000000070cddd06318b2895"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=rakeshjb010@gmail.com; helo=mail-ej1-x634.google.com
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

--00000000000070cddd06318b2895
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, BALATON
I looked into PCI_BUS_NUM and PCI_SLOT from include/hw/pci/pci.h (L15-24):
- PCI_BUS_NUM(x) (((x) >> 8) & 0xff)) --> bits 15-8.
- PCI_SLOT(devfn) (((devfn) >> 3) & 0x1f)),
which don=E2=80=99t align properly with the 32-bit phb->config_reg layout u=
sed in
your GT-64120 . Since these macros are intended for a 16-bit BDF
(Bus-Device-Function) format rather than the full 32-bit PCI config
address,  For phb->config_reg (32-bit: bus 23-16, device 15-11) these
extract the wrong bits

On Sat, Mar 29, 2025 at 6:48=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Sat, 29 Mar 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Rakesh,
> >
> > On 29/3/25 01:49, rakeshj wrote:
> >> The GT-64120 PCI controller requires special handling where:
> >> 1. Host bridge (device 0) must use native endianness
> >> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
> >>
> >> Previous implementation accidentally swapped all accesses, breaking
> >> host bridge detection (lspci -d 11ab:4620).
> >>
> >> This patch:
> >> - Adds custom read/write handlers to preserve native big-endian for th=
e
> >> host
> >>    bridge (phb->config_reg & 0x00fff800 =3D=3D 0).
> >
> > Here you check for bus =3D=3D 0 && device =3D=3D 0, is that what you wa=
nt? (I'm
> > confused because you only describe "for the host bridge").
> >
> > If so I'd rather add a self-describing method:
> >
> > static bool is_phb_dev0(const PCIHostState *phb)
> > {
> >     return extract32(phb->config_reg, 11, 5 /* dev */ + 8 /* bus) =3D=
=3D 0;
> > }
>
> There are already macros such as PCI_BUS_NUM PCI_FUNC. Are they any use
> instead of another function?
>
> Regards,
> BALATON Zoltan
>
> >> - Swaps non-bridge devices when MByteSwap =3D 0, using size-appropriat=
e
> swaps
> >>    (bswap16 for 2-byte, bswap32 for 4-byte) to convert PCI's
> little-endian
> >> data
> >>    to match the MIPS guest's big-endian expectation; no swap occurs fo=
r
> the
> >> host
> >>    bridge or when MByteSwap =3D 1 (little-endian mode).
> >> - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem
> >> initialization
> >>    to gt64120_realize()
> >> - Removes unused pci_host_data_be_ops and a misleading comment in
> dino.h.
> >>
> >> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using
> PCI_HOST_BRIDGE
> >> MemoryRegionOps")
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
> >> Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
> >> ---
> >>   hw/pci-host/gt64120.c      | 83 ++++++++++++++++++++++--------------=
--
> >>   hw/pci/pci_host.c          |  6 ---
> >>   include/hw/pci-host/dino.h |  5 +--
> >>   include/hw/pci/pci_host.h  |  1 -
> >>   4 files changed, 50 insertions(+), 45 deletions(-)
> >>
> >> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> >> index d5c13a89b6..4e45d0aa53 100644
> >> --- a/hw/pci-host/gt64120.c
> >> +++ b/hw/pci-host/gt64120.c
> >> @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
> >>       memory_region_transaction_commit();
> >>   }
> >>   -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
> >> -{
> >> -    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset=
:
> >> 0xc00 */
> >> -    static const MemoryRegionOps *pci_host_data_ops[] =3D {
> >> -        &pci_host_data_be_ops, &pci_host_data_le_ops
> >> -    };
> >> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> >> -
> >> -    memory_region_transaction_begin();
> >> -
> >> -    /*
> >> -     * The setting of the MByteSwap bit and MWordSwap bit in the PCI
> >> Internal
> >> -     * Command Register determines how data transactions from the CPU
> >> to/from
> >> -     * PCI are handled along with the setting of the Endianness bit i=
n
> the
> >> CPU
> >> -     * Configuration Register. See:
> >> -     * - Table 16: 32-bit PCI Transaction Endianness
> >> -     * - Table 158: PCI_0 Command, Offset: 0xc00
> >> -     */
> >> -
> >> -    if (memory_region_is_mapped(&phb->data_mem)) {
> >> -        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
> >> -        object_unparent(OBJECT(&phb->data_mem));
> >> -    }
> >> -    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> >> -                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1]=
,
> >> -                          s, "pci-conf-data", 4);
> >> -    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA
> << 2,
> >> -                                        &phb->data_mem, 1);
> >> -
> >> -    memory_region_transaction_commit();
> >> -}
> >> -
> >>   static void gt64120_pci_mapping(GT64120State *s)
> >>   {
> >>       memory_region_transaction_begin();
> >> @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr
> addr,
> >>       case GT_PCI0_CMD:
> >>       case GT_PCI1_CMD:
> >>           s->regs[saddr] =3D val & 0x0401fc0f;
> >> -        gt64120_update_pci_cfgdata_mapping(s);
> >>           break;
> >>       case GT_PCI0_TOR:
> >>       case GT_PCI0_BS_SCS10:
> >> @@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops =3D {
> >>       },
> >>   };
> >>   +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr,
> >> unsigned size)
> >> +{
> >> +    GT64120State *s =3D opaque;
> >> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> >> +    uint32_t val =3D pci_data_read(phb->bus, phb->config_reg, size);
> >
> > You check the Enable bit in the write path but not here, any reason?
> >> +
> >> +    /* Only swap for non-bridge devices in big-endian mode */
> >> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)=
)
> {
> >
> > Please use instead of (s->regs[GT_PCI0_CMD] & 1):
> >
> >  bswap =3D FIELD_EX32(s->regs[GT_PCI0_CMD]m GT_PCI0_CMD, MByteSwap);
> >
> >> +        if (size =3D=3D 2) {
> >> +            val =3D bswap16(val);
> >> +        } else if (size =3D=3D 4) {
> >> +            val =3D bswap32(val);
> >> +        }
> >> +    }
> >> +    return val;
> >> +}
> >> +
> >> +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
> >> +    uint64_t val, unsigned size)
> >> +{
> >> +    GT64120State *s =3D opaque;
> >> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> >> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)=
)
> {
> >> +        if (size =3D=3D 2) {
> >> +            val =3D bswap16(val);
> >> +        } else if (size =3D=3D 4) {
> >> +            val =3D bswap32(val);
> >> +        }
> >> +    }
> >> +    if (phb->config_reg & (1u << 31))
> >> +        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val,
> size);
> >> +}
> >> +
> >> +static const MemoryRegionOps gt64120_pci_data_ops =3D {
> >> +    .read =3D gt64120_pci_data_read,
> >> +    .write =3D gt64120_pci_data_write,
> >> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >> +    .valid =3D {
> >> +        .min_access_size =3D 1,
> >> +        .max_access_size =3D 4,
> >> +    },
> >> +};
> >
> > Per GT64120 rev 1.4, chapter "6.2.2 PCI Master CPU Byte Swapping":
> >
> >  When the GT=E2=80=9364120 is configured for 64-bit PCI mode, byte
> >  swapping occurs across all 8 byte lanes when the ByteSwap
> >  bit is set for PCI_0.
> >
> >>   static void gt64120_reset(DeviceState *dev)
> >>   {
> >>       GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(dev);
> >> @@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)
> >>         gt64120_isd_mapping(s);
> >>       gt64120_pci_mapping(s);
> >> -    gt64120_update_pci_cfgdata_mapping(s);
> >>   }
> >>     static void gt64120_realize(DeviceState *dev, Error **errp)
> >> @@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *dev,
> Error
> >> **errp)
> >>       memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR
> <<
> >> 2,
> >>                                           &phb->conf_mem, 1);
> >>   +    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> >> +                          &gt64120_pci_data_ops,
> >> +                          s, "pci-conf-data", 4);
> >> +    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA
> << 2,
> >> +                                        &phb->data_mem, 1);
> >> +
> >>         /*
> >>        * The whole address space decoded by the GT-64120A doesn't
> generate
> >
> > Please split the changes below in a distinct cleanup patch.
> >
> >> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> >> index 80f91f409f..56f7f28a1a 100644
> >> --- a/hw/pci/pci_host.c
> >> +++ b/hw/pci/pci_host.c
> >> @@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops =3D {
> >>       .endianness =3D DEVICE_LITTLE_ENDIAN,
> >>   };
> >>   -const MemoryRegionOps pci_host_data_be_ops =3D {
> >> -    .read =3D pci_host_data_read,
> >> -    .write =3D pci_host_data_write,
> >> -    .endianness =3D DEVICE_BIG_ENDIAN,
> >> -};
> >> -
> >>   static bool pci_host_needed(void *opaque)
> >>   {
> >>       PCIHostState *s =3D opaque;
> >> diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
> >> index fd7975c798..df509dbc18 100644
> >> --- a/include/hw/pci-host/dino.h
> >> +++ b/include/hw/pci-host/dino.h
> >> @@ -109,10 +109,7 @@ static const uint32_t
> reg800_keep_bits[DINO800_REGS] =3D
> >> {
> >>   struct DinoState {
> >>       PCIHostState parent_obj;
> >>   -    /*
> >> -     * PCI_CONFIG_ADDR is parent_obj.config_reg, via
> pci_host_conf_be_ops,
> >> -     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
> >> -     */
> >> +
> >>       uint32_t config_reg_dino; /* keep original copy, including 2
> lowest
> >> bits */
> >>         uint32_t iar0;
> >> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> >> index e52d8ec2cd..954dd446fa 100644
> >> --- a/include/hw/pci/pci_host.h
> >> +++ b/include/hw/pci/pci_host.h
> >> @@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr,
> unsigned
> >> len);
> >>   extern const MemoryRegionOps pci_host_conf_le_ops;
> >>   extern const MemoryRegionOps pci_host_conf_be_ops;
> >>   extern const MemoryRegionOps pci_host_data_le_ops;
> >> -extern const MemoryRegionOps pci_host_data_be_ops;
> >>     #endif /* PCI_HOST_H */
> >
> >

--00000000000070cddd06318b2895
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, BALATON<div>I looked into PCI_BUS_NUM and PCI_SLOT=
 from include/hw/pci/pci.h (L15-24):<br>- PCI_BUS_NUM(x) (((x) &gt;&gt; 8) =
&amp; 0xff)) --&gt; bits 15-8.<br>- PCI_SLOT(devfn) (((devfn) &gt;&gt; 3) &=
amp; 0x1f)),</div><div>which don=E2=80=99t align properly with the 32-bit p=
hb-&gt;config_reg layout used in your GT-64120 . Since these macros are int=
ended for a 16-bit BDF (Bus-Device-Function) format rather than the full 32=
-bit PCI config address,=C2=A0 For phb-&gt;config_reg (32-bit: bus 23-16, d=
evice 15-11) these extract the wrong bits</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat=
, Mar 29, 2025 at 6:48=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"mailto:bala=
ton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Sat, 29 Mar 2025, Philippe Mathieu-Dau=
d=C3=A9 wrote:<br>
&gt; Hi Rakesh,<br>
&gt;<br>
&gt; On 29/3/25 01:49, rakeshj wrote:<br>
&gt;&gt; The GT-64120 PCI controller requires special handling where:<br>
&gt;&gt; 1. Host bridge (device 0) must use native endianness<br>
&gt;&gt; 2. Other devices follow MByteSwap bit in GT_PCI0_CMD<br>
&gt;&gt; <br>
&gt;&gt; Previous implementation accidentally swapped all accesses, breakin=
g<br>
&gt;&gt; host bridge detection (lspci -d 11ab:4620).<br>
&gt;&gt; <br>
&gt;&gt; This patch:<br>
&gt;&gt; - Adds custom read/write handlers to preserve native big-endian fo=
r the <br>
&gt;&gt; host<br>
&gt;&gt;=C2=A0 =C2=A0 bridge (phb-&gt;config_reg &amp; 0x00fff800 =3D=3D 0)=
.<br>
&gt;<br>
&gt; Here you check for bus =3D=3D 0 &amp;&amp; device =3D=3D 0, is that wh=
at you want? (I&#39;m<br>
&gt; confused because you only describe &quot;for the host bridge&quot;).<b=
r>
&gt;<br>
&gt; If so I&#39;d rather add a self-describing method:<br>
&gt;<br>
&gt; static bool is_phb_dev0(const PCIHostState *phb)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0return extract32(phb-&gt;config_reg, 11, 5 /* dev *=
/ + 8 /* bus) =3D=3D 0;<br>
&gt; }<br>
<br>
There are already macros such as PCI_BUS_NUM PCI_FUNC. Are they any use <br=
>
instead of another function?<br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt;&gt; - Swaps non-bridge devices when MByteSwap =3D 0, using size-approp=
riate swaps<br>
&gt;&gt;=C2=A0 =C2=A0 (bswap16 for 2-byte, bswap32 for 4-byte) to convert P=
CI&#39;s little-endian <br>
&gt;&gt; data<br>
&gt;&gt;=C2=A0 =C2=A0 to match the MIPS guest&#39;s big-endian expectation;=
 no swap occurs for the <br>
&gt;&gt; host<br>
&gt;&gt;=C2=A0 =C2=A0 bridge or when MByteSwap =3D 1 (little-endian mode).<=
br>
&gt;&gt; - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem <b=
r>
&gt;&gt; initialization<br>
&gt;&gt;=C2=A0 =C2=A0 to gt64120_realize()<br>
&gt;&gt; - Removes unused pci_host_data_be_ops and a misleading comment in =
dino.h.<br>
&gt;&gt; <br>
&gt;&gt; Fixes: 145e2198 (&quot;hw/mips/gt64xxx_pci: Endian-swap using PCI_=
HOST_BRIDGE <br>
&gt;&gt; MemoryRegionOps&quot;)<br>
&gt;&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues=
/2826" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/issues/2826</a><br>
&gt;&gt; Signed-off-by: Rakesh Jeyasingh &lt;<a href=3D"mailto:rakeshjb010@=
gmail.com" target=3D"_blank">rakeshjb010@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/pci-host/gt64120.c=C2=A0 =C2=A0 =C2=A0 | 83 +++++++=
+++++++++++++++----------------<br>
&gt;&gt;=C2=A0 =C2=A0hw/pci/pci_host.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 6 ---<br>
&gt;&gt;=C2=A0 =C2=A0include/hw/pci-host/dino.h |=C2=A0 5 +--<br>
&gt;&gt;=C2=A0 =C2=A0include/hw/pci/pci_host.h=C2=A0 |=C2=A0 1 -<br>
&gt;&gt;=C2=A0 =C2=A04 files changed, 50 insertions(+), 45 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c<br>
&gt;&gt; index d5c13a89b6..4e45d0aa53 100644<br>
&gt;&gt; --- a/hw/pci-host/gt64120.c<br>
&gt;&gt; +++ b/hw/pci-host/gt64120.c<br>
&gt;&gt; @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State =
*s)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_commit();<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0-static void gt64120_update_pci_cfgdata_mapping(GT6412=
0State *s)<br>
&gt;&gt; -{<br>
&gt;&gt; -=C2=A0 =C2=A0 /* Indexed on MByteSwap bit, see Table 158: PCI_0 C=
ommand, Offset: <br>
&gt;&gt; 0xc00 */<br>
&gt;&gt; -=C2=A0 =C2=A0 static const MemoryRegionOps *pci_host_data_ops[] =
=3D {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pci_host_data_be_ops, &amp;pci_h=
ost_data_le_ops<br>
&gt;&gt; -=C2=A0 =C2=A0 };<br>
&gt;&gt; -=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 /*<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* The setting of the MByteSwap bit and MWordS=
wap bit in the PCI <br>
&gt;&gt; Internal<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* Command Register determines how data transa=
ctions from the CPU <br>
&gt;&gt; to/from<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* PCI are handled along with the setting of t=
he Endianness bit in the <br>
&gt;&gt; CPU<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* Configuration Register. See:<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* - Table 16: 32-bit PCI Transaction Endianne=
ss<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* - Table 158: PCI_0 Command, Offset: 0xc00<b=
r>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 if (memory_region_is_mapped(&amp;phb-&gt;data_mem))=
 {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_subregion(&amp;s-&g=
t;ISD_mem, &amp;phb-&gt;data_mem);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(&amp;phb-&gt;d=
ata_mem));<br>
&gt;&gt; -=C2=A0 =C2=A0 }<br>
&gt;&gt; -=C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data_mem, OBJECT=
(phb),<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_host_data_ops[s-&gt;regs[GT_PCI0_CMD] &amp;=
 1],<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s, &quot;pci-conf-data&quot;, 4);<br>
&gt;&gt; -=C2=A0 =C2=A0 memory_region_add_subregion_overlap(&amp;s-&gt;ISD_=
mem, GT_PCI0_CFGDATA &lt;&lt; 2,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;phb-&gt;data_mem, 1);<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 memory_region_transaction_commit();<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt;=C2=A0 =C2=A0static void gt64120_pci_mapping(GT64120State *s)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_begin();<br>
&gt;&gt; @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwadd=
r addr,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI0_CMD:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI1_CMD:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[saddr] =3D val =
&amp; 0x0401fc0f;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s)=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI0_TOR:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case GT_PCI0_BS_SCS10:<br>
&gt;&gt; @@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops =3D=
 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt;=C2=A0 =C2=A0};<br>
&gt;&gt;=C2=A0 =C2=A0+static uint64_t gt64120_pci_data_read(void *opaque, h=
waddr addr, <br>
&gt;&gt; unsigned size)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
&gt;&gt; +=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
&gt;&gt; +=C2=A0 =C2=A0 uint32_t val =3D pci_data_read(phb-&gt;bus, phb-&gt=
;config_reg, size);<br>
&gt;<br>
&gt; You check the Enable bit in the write path but not here, any reason?<b=
r>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Only swap for non-bridge devices in big-endian m=
ode */<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!(s-&gt;regs[GT_PCI0_CMD] &amp; 1) &amp;&amp; (=
phb-&gt;config_reg &amp; 0x00fff800)) {<br>
&gt;<br>
&gt; Please use instead of (s-&gt;regs[GT_PCI0_CMD] &amp; 1):<br>
&gt;<br>
&gt;=C2=A0 bswap =3D FIELD_EX32(s-&gt;regs[GT_PCI0_CMD]m GT_PCI0_CMD, MByte=
Swap);<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size =3D=3D 2) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap16(val);<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (size =3D=3D 4) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val);<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 return val;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void gt64120_pci_data_write(void *opaque, hwaddr addr,<br>
&gt;&gt; +=C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
&gt;&gt; +=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!(s-&gt;regs[GT_PCI0_CMD] &amp; 1) &amp;&amp; (=
phb-&gt;config_reg &amp; 0x00fff800)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size =3D=3D 2) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap16(val);<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (size =3D=3D 4) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val);<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 if (phb-&gt;config_reg &amp; (1u &lt;&lt; 31))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_data_write(phb-&gt;bus, phb-&gt;c=
onfig_reg | (addr &amp; 3), val, size);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static const MemoryRegionOps gt64120_pci_data_ops =3D {<br>
&gt;&gt; +=C2=A0 =C2=A0 .read =3D gt64120_pci_data_read,<br>
&gt;&gt; +=C2=A0 =C2=A0 .write =3D gt64120_pci_data_write,<br>
&gt;&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt;&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt;&gt; +=C2=A0 =C2=A0 },<br>
&gt;&gt; +};<br>
&gt;<br>
&gt; Per GT64120 rev 1.4, chapter &quot;6.2.2 PCI Master CPU Byte Swapping&=
quot;:<br>
&gt;<br>
&gt;=C2=A0 When the GT=E2=80=9364120 is configured for 64-bit PCI mode, byt=
e<br>
&gt;=C2=A0 swapping occurs across all 8 byte lanes when the ByteSwap<br>
&gt;=C2=A0 bit is set for PCI_0.<br>
&gt;<br>
&gt;&gt;=C2=A0 =C2=A0static void gt64120_reset(DeviceState *dev)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GT64120State *s =3D GT64120_PCI_HOST_BRI=
DGE(dev);<br>
&gt;&gt; @@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gt64120_isd_mapping(s);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gt64120_pci_mapping(s);<br>
&gt;&gt; -=C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s);<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0static void gt64120_realize(DeviceState *dev, E=
rror **errp)<br>
&gt;&gt; @@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *de=
v, Error <br>
&gt;&gt; **errp)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(&amp=
;s-&gt;ISD_mem, GT_PCI0_CFGADDR &lt;&lt; <br>
&gt;&gt; 2,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;phb-&gt;conf_mem, 1);<br>
&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data=
_mem, OBJECT(phb),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;gt64120_pci_data_ops,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s, &quot;pci-conf-data&quot;, 4);<br>
&gt;&gt; +=C2=A0 =C2=A0 memory_region_add_subregion_overlap(&amp;s-&gt;ISD_=
mem, GT_PCI0_CFGDATA &lt;&lt; 2,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;phb-&gt;data_mem, 1);<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The whole address space decoded by th=
e GT-64120A doesn&#39;t generate<br>
&gt;<br>
&gt; Please split the changes below in a distinct cleanup patch.<br>
&gt;<br>
&gt;&gt; diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c<br>
&gt;&gt; index 80f91f409f..56f7f28a1a 100644<br>
&gt;&gt; --- a/hw/pci/pci_host.c<br>
&gt;&gt; +++ b/hw/pci/pci_host.c<br>
&gt;&gt; @@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops =
=3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.endianness =3D DEVICE_LITTLE_ENDIAN,<br=
>
&gt;&gt;=C2=A0 =C2=A0};<br>
&gt;&gt;=C2=A0 =C2=A0-const MemoryRegionOps pci_host_data_be_ops =3D {<br>
&gt;&gt; -=C2=A0 =C2=A0 .read =3D pci_host_data_read,<br>
&gt;&gt; -=C2=A0 =C2=A0 .write =3D pci_host_data_write,<br>
&gt;&gt; -=C2=A0 =C2=A0 .endianness =3D DEVICE_BIG_ENDIAN,<br>
&gt;&gt; -};<br>
&gt;&gt; -<br>
&gt;&gt;=C2=A0 =C2=A0static bool pci_host_needed(void *opaque)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIHostState *s =3D opaque;<br>
&gt;&gt; diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino=
.h<br>
&gt;&gt; index fd7975c798..df509dbc18 100644<br>
&gt;&gt; --- a/include/hw/pci-host/dino.h<br>
&gt;&gt; +++ b/include/hw/pci-host/dino.h<br>
&gt;&gt; @@ -109,10 +109,7 @@ static const uint32_t reg800_keep_bits[DINO80=
0_REGS] =3D <br>
&gt;&gt; {<br>
&gt;&gt;=C2=A0 =C2=A0struct DinoState {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIHostState parent_obj;<br>
&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=A0 /*<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* PCI_CONFIG_ADDR is parent_obj.config_reg, v=
ia pci_host_conf_be_ops,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0* so that we can map PCI_CONFIG_DATA to pci_h=
ost_data_be_ops.<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t config_reg_dino; /* keep origin=
al copy, including 2 lowest <br>
&gt;&gt; bits */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t iar0;<br>
&gt;&gt; diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h=
<br>
&gt;&gt; index e52d8ec2cd..954dd446fa 100644<br>
&gt;&gt; --- a/include/hw/pci/pci_host.h<br>
&gt;&gt; +++ b/include/hw/pci/pci_host.h<br>
&gt;&gt; @@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr,=
 unsigned <br>
&gt;&gt; len);<br>
&gt;&gt;=C2=A0 =C2=A0extern const MemoryRegionOps pci_host_conf_le_ops;<br>
&gt;&gt;=C2=A0 =C2=A0extern const MemoryRegionOps pci_host_conf_be_ops;<br>
&gt;&gt;=C2=A0 =C2=A0extern const MemoryRegionOps pci_host_data_le_ops;<br>
&gt;&gt; -extern const MemoryRegionOps pci_host_data_be_ops;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0#endif /* PCI_HOST_H */<br>
&gt;<br>
&gt;</blockquote></div>

--00000000000070cddd06318b2895--

