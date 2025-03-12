Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FCC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPR5-0008Lc-Uf; Wed, 12 Mar 2025 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tsPQy-0008JR-UQ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:59:57 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tsPQv-0007qT-Qt
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:59:56 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e64700a38cso6867807a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1741798790; x=1742403590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ya+FjLCCjdR33uDqugDcilKzi1+6loZJ94oEWgLmenY=;
 b=Yvcg/yNyStG2c88OmL0Z77ADVYA0An68Luez0hcAi+nm6YyBopD8Agpy0xO2ORaRN7
 DBTJEp4XZC9p0kErFwbQXHWIKJob4r2Ka+XlYcMPROhLQ38/8yiZzPkxahdQw5geemyp
 sUIDOxzWntWBWt41QOuFTRmspKfZbGaJrRs+NrlvB7v74e99hB4gnzh7HXyNpppbqpBl
 2NQEWUYaIZDqV5F2/lfQQNX9yNuyEuDZ3fPD2QaY8vnnvvwLYD/PgCVPFLfj5JJfluVG
 xPwafhv7Mfvpj2UWxMecaxdg4mIDb6mGabCZeWZw3G8TyqRPS98CjeAJKicmg+NOkBFi
 pljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741798790; x=1742403590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ya+FjLCCjdR33uDqugDcilKzi1+6loZJ94oEWgLmenY=;
 b=j6CW6KqVIlocTK+AvvSpR3zffGuUkh7kBL34utSI4Cx70APheO4dd3t8iVGgYIRdqE
 B6xCDxpGGpmMToOgAgmlHeTJ9bQE8oRXgSBJlKOBdgwbHYGjEC60KLxj5QdVyCU5zCK7
 gYXclfqrRMXBjdBHmW3n3+gwWa5Yg4MJA9K4fS87VLUV85JpGih6zkI5fid7p3Rs+R7H
 /dcTncdd+8kLWSxBXeePUAWAFJZFl5sMVtG9jTgxIRSP3Vu3C0HojWRWhqM4FlECjJhZ
 Xm9Wyz05ZV0Qll7tg9V4iFZeZ3fkJg1gJIQ954mk/ezmA9xBdFkMtFLAG9ZabbNvAd6q
 mxTA==
X-Gm-Message-State: AOJu0YzK5vYnnHP7CSOCTIhHZif1bfxiOQ2yKOa6pqIE+b077dEGiCAZ
 ZFGamp50a4FqKK0vYWlAyPwgUqEVsa6xzQylk4Wm/MBIKKexKIEg99FHDw3jkt+TBZcAqW45Ymt
 UPX65gNE1j9jos9XmZlUhyUmKSTLQ9HUpQTT56Q==
X-Gm-Gg: ASbGncueB0h97AqAXzUUS084MCHOldroA2tEitE3lLM5p0SdS0XP8rR2Om30TJHfRqc
 sw/Txryx+czQuwEsxg42DngBq0eO8015F8zitwFhoJqgHQxzyTXN1ZpxyDWtYJDg2UthF1dR53y
 8+2kfh2I78RXQldzn05xqgm94=
X-Google-Smtp-Source: AGHT+IFqNiM2K4Uv0Q/WsDMai4EYmQGj9gu+VcvLxLjqsmM+7P4AutD8EWAyrJBH6OPlIkpy3E93hmBo2BTBKHJlrm0=
X-Received: by 2002:a05:6402:13cc:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5e617e69fefmr22364533a12.6.1741798790476; Wed, 12 Mar 2025
 09:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250302091209.20063-1-jason.chien@sifive.com>
 <20250302091209.20063-2-jason.chien@sifive.com>
 <0464a115-fbfe-4038-9e2d-409ad133647e@ventanamicro.com>
In-Reply-To: <0464a115-fbfe-4038-9e2d-409ad133647e@ventanamicro.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Thu, 13 Mar 2025 00:59:40 +0800
X-Gm-Features: AQ5f1JocGzvKzWUlmOX03k6U47g5PSIDeBU1tREq-bJHsm3de5rCEeQGe9hhPB8
Message-ID: <CADr__8p54Fp4PqkmSC_gWhiOwa9Yem0KU53woFFCQ_sA35sFHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] include/hw/pci: Attach BDF to Memory Attributes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002d65410630282267"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jason.chien@sifive.com; helo=mail-ed1-x534.google.com
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

--0000000000002d65410630282267
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Michael/Marcel, would you mind taking a look? Thanks!


Jason

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2025=E5=B9=B4=
3=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:40=E5=AF=AB=E9=
=81=93=EF=BC=9A

>
>
> On 3/2/25 6:12 AM, Jason Chien wrote:
> > This commit adds the BDF to the memory attributes for DMA operations.
> >
> > Signed-off-by: Jason Chien <jason.chien@sifive.com>
> > ---
>
> This looks sensible but I'll feel more comfortable if Michael/Marcel also
> takes a look. Thanks,
>
>
> Daniel
>
> >   include/hw/pci/pci_device.h | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> > index add208edfa..968f1ba3e9 100644
> > --- a/include/hw/pci/pci_device.h
> > +++ b/include/hw/pci/pci_device.h
> > @@ -244,6 +244,8 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev=
,
> dma_addr_t addr,
> >                                        void *buf, dma_addr_t len,
> >                                        DMADirection dir, MemTxAttrs
> attrs)
> >   {
> > +    attrs.unspecified =3D 0;
> > +    attrs.requester_id =3D pci_requester_id(dev);
> >       return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
> >                            dir, attrs);
> >   }
> > @@ -292,6 +294,8 @@ static inline MemTxResult pci_dma_write(PCIDevice
> *dev, dma_addr_t addr,
> >                                                  uint##_bits##_t *val, =
\
> >                                                  MemTxAttrs attrs) \
> >       { \
> > +        attrs.unspecified =3D 0; \
> > +        attrs.requester_id =3D pci_requester_id(dev); \
> >           return ld##_l##_dma(pci_get_address_space(dev), addr, val,
> attrs); \
> >       } \
> >       static inline MemTxResult st##_s##_pci_dma(PCIDevice *dev, \
> > @@ -299,6 +303,8 @@ static inline MemTxResult pci_dma_write(PCIDevice
> *dev, dma_addr_t addr,
> >                                                  uint##_bits##_t val, \
> >                                                  MemTxAttrs attrs) \
> >       { \
> > +        attrs.unspecified =3D 0; \
> > +        attrs.requester_id =3D pci_requester_id(dev); \
> >           return st##_s##_dma(pci_get_address_space(dev), addr, val,
> attrs); \
> >       }
> >
> > @@ -327,8 +333,8 @@ PCI_DMA_DEFINE_LDST(q_be, q_be, 64);
> >   static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
> >                                   dma_addr_t *plen, DMADirection dir)
> >   {
> > -    return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
> > -                          MEMTXATTRS_UNSPECIFIED);
> > +    MemTxAttrs attrs =3D {.requester_id =3D pci_requester_id(dev)};
> > +    return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
> attrs);
> >   }
> >
> >   static inline void pci_dma_unmap(PCIDevice *dev, void *buffer,
> dma_addr_t len,
>
>

--0000000000002d65410630282267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.<br><br>Michael/Marcel, would you mind taking a look?=
 Thanks!<br><br><br>Jason</div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">Daniel Henrique Barboza &lt;=
<a href=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&=
gt; =E6=96=BC 2025=E5=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=
=8B=E5=8D=888:40=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
<br>
On 3/2/25 6:12 AM, Jason Chien wrote:<br>
&gt; This commit adds the BDF to the memory attributes for DMA operations.<=
br>
&gt; <br>
&gt; Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.co=
m" target=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
&gt; ---<br>
<br>
This looks sensible but I&#39;ll feel more comfortable if Michael/Marcel al=
so<br>
takes a look. Thanks,<br>
<br>
<br>
Daniel<br>
<br>
&gt;=C2=A0 =C2=A0include/hw/pci/pci_device.h | 10 ++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h=
<br>
&gt; index add208edfa..968f1ba3e9 100644<br>
&gt; --- a/include/hw/pci/pci_device.h<br>
&gt; +++ b/include/hw/pci/pci_device.h<br>
&gt; @@ -244,6 +244,8 @@ static inline MemTxResult pci_dma_rw(PCIDevice *de=
v, dma_addr_t addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void =
*buf, dma_addr_t len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMADi=
rection dir, MemTxAttrs attrs)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 attrs.unspecified =3D 0;<br>
&gt; +=C2=A0 =C2=A0 attrs.requester_id =3D pci_requester_id(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return dma_memory_rw(pci_get_address_space(d=
ev), addr, buf, len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dir, attrs);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -292,6 +294,8 @@ static inline MemTxResult pci_dma_write(PCIDevice =
*dev, dma_addr_t addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint##_bits##_t *val, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAttrs attrs) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 attrs.unspecified =3D 0; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 attrs.requester_id =3D pci_requester_id(d=
ev); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ld##_l##_dma(pci_get_ad=
dress_space(dev), addr, val, attrs); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static inline MemTxResult st##_s##_pci_dma(P=
CIDevice *dev, \<br>
&gt; @@ -299,6 +303,8 @@ static inline MemTxResult pci_dma_write(PCIDevice =
*dev, dma_addr_t addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint##_bits##_t val, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAttrs attrs) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 attrs.unspecified =3D 0; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 attrs.requester_id =3D pci_requester_id(d=
ev); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return st##_s##_dma(pci_get_ad=
dress_space(dev), addr, val, attrs); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -327,8 +333,8 @@ PCI_DMA_DEFINE_LDST(q_be, q_be, 64);<br>
&gt;=C2=A0 =C2=A0static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t=
 addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t *plen, DM=
ADirection dir)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 return dma_memory_map(pci_get_address_space(dev), addr,=
 plen, dir,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 MEMTXATTRS_UNSPECIFIED);<br>
&gt; +=C2=A0 =C2=A0 MemTxAttrs attrs =3D {.requester_id =3D pci_requester_i=
d(dev)};<br>
&gt; +=C2=A0 =C2=A0 return dma_memory_map(pci_get_address_space(dev), addr,=
 plen, dir, attrs);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static inline void pci_dma_unmap(PCIDevice *dev, void *buf=
fer, dma_addr_t len,<br>
<br>
</blockquote></div>

--0000000000002d65410630282267--

