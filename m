Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF358C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5Qp-0005Re-IC; Thu, 06 Mar 2025 02:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tq5Qj-0005PI-2h
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tq5Qg-0001Ig-Ik
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741245241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2qM/lH7nKR1InuEF84msUvLqujSaMH348JNnsI9zNU=;
 b=Cj8m8eAXx3LQzabQTUH9PK09O168GIDo8RyT4aZdR9zhkCEW9i2fSupWmkj2AAdTJsCA7y
 OEbb05tgEpWGhBPVTYtw/HHJ1QufgIahz+M09vL9+3rg5JH86KH0oaZ14Yg7xchkifJj9W
 uns+Ljma4e4yEGKZzkipG5Xdpo8XJwo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-KlHvzzduOrGafZaimvRROg-1; Thu, 06 Mar 2025 02:12:05 -0500
X-MC-Unique: KlHvzzduOrGafZaimvRROg-1
X-Mimecast-MFC-AGG-ID: KlHvzzduOrGafZaimvRROg_1741245125
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6f3ff1ff13aso6903297b3.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741245125; x=1741849925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2qM/lH7nKR1InuEF84msUvLqujSaMH348JNnsI9zNU=;
 b=Wu1J4vhGjSMIeixV4eGIGRBGgPKNrjz/X3zvbINzrtW5sLs348QrLqLTeD+GIEvrLF
 Izwpd9qhGemMSlrAn3zxSFq2zFNbiEiXb3IcvfOvid1lNLyGNwDEiGCc8HiCuZ9YlcMs
 cPmXCUwVqZZfgXZKTI92l6q54SR39MuhscWvSWw///1WDH4+xLCY+YVpXCYoCvxNzPPl
 tMCENFy7akcYEeUBvIcpX4k+ToyKQTt+fo3i6csFB4nHqMLaN+L4keVJE1cYybnriIGR
 wB8tPRQOsGc4ktDH3PKZZ4QfnLbZGxaliFO4I/anNsDFBDVnznIPwalu/bAjr2oUXVbA
 +9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBbiMOSKEI3fzedYp7BJHYhNEgT88Yc5RyyejnsGWCIi/SlxHMaLjEHDXGdqKaklTjBLP9Bn66zUtf@nongnu.org
X-Gm-Message-State: AOJu0YwwFP19676eEvHt4dIx+GJB0XRL1pb5+LET8J2zVJL96ZbEbIHA
 ZhqZeVkXl7lg3UhFosHKUR5UiAQD2++iEO45ANV/9zhUsbieqK6XbwX1AfQVHkALwdxNQUoae4B
 UzXh3R2R3+ZnU0pg/H6AAaz9sRFfgc9x4vHbH88kn1oq3ehHtolaba2IOERh7qs0MseaEOHk6Rm
 BnE1GjNLOz4CEfCa6C+hEXy3EHQzU=
X-Gm-Gg: ASbGnctssqyxO6JpxBLoTm6ONfun/WbjNDNvE4fKBMZqq+IXAxQ33LbotzYSslm9jA7
 AJgAqGUwob+od2Wsprtu4uo79WzHzKrA4VNUu/6dJdTCMxVe41wFy2hJpM0EmbuUDjJr5cVcpFQ
 ==
X-Received: by 2002:a05:690c:748a:b0:6fb:9b8c:4b50 with SMTP id
 00721157ae682-6fda2fb5956mr79261767b3.13.1741245125230; 
 Wed, 05 Mar 2025 23:12:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF04XfRG+UVocNEtxuuihe0fMWLCp6wkr0dj/FAgSvZlg2CtP3UEFc9JpLF7Xf9TmL7quc2PlXyUjpVS0h3QBA=
X-Received: by 2002:a05:690c:748a:b0:6fb:9b8c:4b50 with SMTP id
 00721157ae682-6fda2fb5956mr79261627b3.13.1741245124969; Wed, 05 Mar 2025
 23:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250305015122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250305015122-mutt-send-email-mst@kernel.org>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Thu, 6 Mar 2025 09:11:53 +0200
X-Gm-Features: AQ5f1JpIULHDc8e1K9UmDDHrzgl02BWg087CqZBeWr2O20qzuXSz0uFu9XmiseA
Message-ID: <CAGoVJZzWqJt-XCOq0GSCg68HYp1DYEEhEUgE-c6a+rd0m-d+cA@mail.gmail.com>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, 
 pbonzini@redhat.com, mtosatti@redhat.com, marcel.apfelbaum@gmail.com, 
 jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
 Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, 
 ddutile@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002429e5062fa73939"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002429e5062fa73939
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> > The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD
> I/O
> > Virtualization Technology (IOMMU) Specification [1]. The PCI id for thi=
s
> > device is platform-specific.
> >
> > Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id an=
d
> > undefined device id.
>
> undefined?
>
> > Therefore, change the vendor id to Red Hat and request a new
> QEMU-specific
> > device id.
>
> Won't the drivers fail to load then?
>

Windows will not identify the device (it is a dummy device, without driver)
and SVVP certifications will fail as a result.
I suggest using ID that is already present in Windows machine.inf:
VEN_1002&DEV_5A23
VEN_1022&DEV_1419


>
> >
> > [1]
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/spec=
ifications/48882_IOMMU.pdf
>
> what is this link teaching us? It's a 300 page document. Where to look
> in there?
>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > ---
> >  docs/specs/pci-ids.rst | 2 ++
> >  hw/i386/amd_iommu.c    | 3 ++-
> >  include/hw/pci/pci.h   | 1 +
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> > index 261b0f359f..2416a70a2d 100644
> > --- a/docs/specs/pci-ids.rst
> > +++ b/docs/specs/pci-ids.rst
> > @@ -100,6 +100,8 @@ PCI devices (other than virtio):
> >    PCI UFS device (``-device ufs``)
> >  1b36:0014
> >    PCI RISC-V IOMMU device
> > +1b36:0015
> > +  PCI AMD IOMMU device (``-device amd-iommu``)
> >
> >  All these devices are documented in :doc:`index`.
> >
> > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > index dda1a5781f..4d8564249c 100644
> > --- a/hw/i386/amd_iommu.c
> > +++ b/hw/i386/amd_iommu.c
> > @@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass
> *klass, void *data)
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> >
> > -    k->vendor_id =3D PCI_VENDOR_ID_AMD;
> > +    k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> > +    k->device_id =3D PCI_DEVICE_ID_REDHAT_AMD_IOMMU;
> >      k->class_id =3D 0x0806;
> >      k->realize =3D amdvi_pci_realize;
> >
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 4002bbeebd..da44e6673d 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -117,6 +117,7 @@ extern bool pci_available;
> >  #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
> >  #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
> >  #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
> > +#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU   0x0015
> >  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
> >
> >  #define FMT_PCIBUS                      PRIx64
> > --
> > 2.34.1
>
>
>

--0000000000002429e5062fa73939
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, =
2025 at 8:54=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat=
.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Mar 0=
4, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:<br>
&gt; The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD=
 I/O<br>
&gt; Virtualization Technology (IOMMU) Specification [1]. The PCI id for th=
is<br>
&gt; device is platform-specific.<br>
&gt; <br>
&gt; Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id a=
nd<br>
&gt; undefined device id.<br>
<br>
undefined?<br>
<br>
&gt; Therefore, change the vendor id to Red Hat and request a new QEMU-spec=
ific<br>
&gt; device id.<br>
<br>
Won&#39;t the drivers fail to load then?<br></blockquote><div><br></div><di=
v>Windows will not identify the device (it is a dummy device, without drive=
r) and SVVP certifications will fail as a result.=C2=A0</div><div>I suggest=
 using ID that is already present in Windows machine.inf:</div><div>VEN_100=
2&amp;DEV_5A23</div><div>VEN_1022&amp;DEV_1419</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-l=
eft:1ex">
<br>
<br>
&gt; <br>
&gt; [1] <a href=3D"https://www.amd.com/content/dam/amd/en/documents/proces=
sor-tech-docs/specifications/48882_IOMMU.pdf" rel=3D"noreferrer" target=3D"=
_blank">https://www.amd.com/content/dam/amd/en/documents/processor-tech-doc=
s/specifications/48882_IOMMU.pdf</a><br>
<br>
what is this link teaching us? It&#39;s a 300 page document. Where to look<=
br>
in there?<br>
<br>
&gt; Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_=
blank">kraxel@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Suravee Suthikulpanit &lt;<a href=3D"mailto:suravee.sut=
hikulpanit@amd.com" target=3D"_blank">suravee.suthikulpanit@amd.com</a>&gt;=
<br>
&gt; ---<br>
&gt;=C2=A0 docs/specs/pci-ids.rst | 2 ++<br>
&gt;=C2=A0 hw/i386/amd_iommu.c=C2=A0 =C2=A0 | 3 ++-<br>
&gt;=C2=A0 include/hw/pci/pci.h=C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 3 files changed, 5 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst<br>
&gt; index 261b0f359f..2416a70a2d 100644<br>
&gt; --- a/docs/specs/pci-ids.rst<br>
&gt; +++ b/docs/specs/pci-ids.rst<br>
&gt; @@ -100,6 +100,8 @@ PCI devices (other than virtio):<br>
&gt;=C2=A0 =C2=A0 PCI UFS device (``-device ufs``)<br>
&gt;=C2=A0 1b36:0014<br>
&gt;=C2=A0 =C2=A0 PCI RISC-V IOMMU device<br>
&gt; +1b36:0015<br>
&gt; +=C2=A0 PCI AMD IOMMU device (``-device amd-iommu``)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 All these devices are documented in :doc:`index`.<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c<br>
&gt; index dda1a5781f..4d8564249c 100644<br>
&gt; --- a/hw/i386/amd_iommu.c<br>
&gt; +++ b/hw/i386/amd_iommu.c<br>
&gt; @@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass *kl=
ass, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 k-&gt;vendor_id =3D PCI_VENDOR_ID_AMD;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;vendor_id =3D PCI_VENDOR_ID_REDHAT;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;device_id =3D PCI_DEVICE_ID_REDHAT_AMD_IOMMU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 k-&gt;class_id =3D 0x0806;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 k-&gt;realize =3D amdvi_pci_realize;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h<br>
&gt; index 4002bbeebd..da44e6673d 100644<br>
&gt; --- a/include/hw/pci/pci.h<br>
&gt; +++ b/include/hw/pci/pci.h<br>
&gt; @@ -117,6 +117,7 @@ extern bool pci_available;<br>
&gt;=C2=A0 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST=C2=A0 =C2=A00x0012<br>
&gt;=C2=A0 #define PCI_DEVICE_ID_REDHAT_UFS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0013<br>
&gt;=C2=A0 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014<br>
&gt; +#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU=C2=A0 =C2=A00x0015<br>
&gt;=C2=A0 #define PCI_DEVICE_ID_REDHAT_QXL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0100<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define FMT_PCIBUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PRIx64<br>
&gt; -- <br>
&gt; 2.34.1<br>
<br>
<br>
</blockquote></div></div>

--0000000000002429e5062fa73939--


