Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D52C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 22:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdzLc-0004lE-BT; Fri, 31 Jan 2025 17:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdzLa-0004ku-Ad
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 17:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdzLX-0006Kf-VH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 17:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738361915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykd4KWVGtB8bbTokSGExYHVf2x1MaCrwew+nDL9J+F0=;
 b=FX3XYBf9nyc0RRxgme6uv6GPrdDteW2BepXi2VT8h1vDqo6seyFOeBWW3aMynX/BkmJnRf
 0DEVjB3+nx7fyPhpb8cGH+NVTBmpgQ9jPQwDmmokmYEDhZ0Gm/A7NGkA2yjD9X3grZzI9A
 q4ryRPjyikEzXfeA9cGhBDZyjsnm/so=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ZFWOAJDwNmKJL0lR43ahnA-1; Fri, 31 Jan 2025 17:18:32 -0500
X-MC-Unique: ZFWOAJDwNmKJL0lR43ahnA-1
X-Mimecast-MFC-AGG-ID: ZFWOAJDwNmKJL0lR43ahnA
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71fbb6e5b38so236850a34.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 14:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361912; x=1738966712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykd4KWVGtB8bbTokSGExYHVf2x1MaCrwew+nDL9J+F0=;
 b=HpUGCqMZaYNGfLRaKz2+vbd2mZU8yBSxWGQY4LAeoEN1xs6Qbe/pm4epYGBg2+Qrfi
 Z4x3B8tY96HUr9Im1Gst93//iMYimx4m/xcOnV1SNmfpllzH8vpxr2lB+UX5SYs/4a0k
 1M3jNeLPrqocrXpDg+75nBw5ENVjsU0YqszaqRZvT42ju7SsDd6+9CU+qMHUdPdbJpWg
 qyKGGQWF16huD28a9U8pRvu+qMV53zogucAblNOWzsROYA46YM8HRm2517zv6FbK23zX
 lRmiYt6uwXNb7Y3Kz19kifPsqpkGo5ZF33JYG11xchpAaIXVvqDXkNURbV/nbzYCUMce
 E4fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOJO6fVeC6TAHDUVz0i4SuVcO4eXhw5fPRBwR0PWqLYTDOyLh7APjstGoawo1AePL/xS5tLWN1aMPG@nongnu.org
X-Gm-Message-State: AOJu0Yzo5v9vVKPp5xAuK4mA/rJztERjx9Wg7uDFatcHX5tnAmUF9oC3
 fG40bBe1TwEICTVEGBGT5D96bNME7M/GLw08mmrLnvh/WsLdp0UghGvZ28KJmKkoxIDjzbmWXlt
 IawZd3uyXHF9AI/mU99sKTpwIxsLZSafdkTD/l+GbJcs8S4ZBsK5y
X-Gm-Gg: ASbGncuCHKfv/KUbatrgnQfs/ixmxQOyk4LoY7u1vkHlBpQPoeCGIIK7DzEuJYJKksX
 krEzl6FhOk9DT6EMhQytJZEvmGT7wTHBt8beQiGnQNzYMATN7zhzDe/rWDClSsfB2D13alnBV8G
 CZmOGA+z5rbI5VV81hKE7QcqYfzxmnT0f7ajx07k+p85tPocfycsfyqJUU9NIWHR9vB/BX5zBp8
 geMWx9BaInpRitfXyr4Y5X/PvyJbPhVzMK/hc9CJ3YtabFQskyV/SAVgs91c8ZlYcAc2gAm9EmO
 1hCZR1F2
X-Received: by 2002:a05:6808:23c3:b0:3eb:612e:34c3 with SMTP id
 5614622812f47-3f330a5f13amr2272797b6e.9.1738361911793; 
 Fri, 31 Jan 2025 14:18:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgBsv0yCs15jTKS/hKI+PBrwoxk5Ei5tD9bnS7nFUzhf74ribfY5SrkEzhLDLjhME7hZnQbg==
X-Received: by 2002:a05:6808:23c3:b0:3eb:612e:34c3 with SMTP id
 5614622812f47-3f330a5f13amr2272793b6e.9.1738361911457; 
 Fri, 31 Jan 2025 14:18:31 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f33368be99sm1032358b6e.47.2025.01.31.14.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:18:30 -0800 (PST)
Date: Fri, 31 Jan 2025 15:18:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU
 address space width
Message-ID: <20250131151829.6461eeb0.alex.williamson@redhat.com>
In-Reply-To: <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
 <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
 <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 31 Jan 2025 14:23:58 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Fri, Jan 31, 2025 at 01:42:31PM +0100, C=C3=A9dric Le Goater wrote:
> > + Gerd for insights regarding vIOMMU support in edk2.
> >  =20
> > > > +static bool vfio_device_check_address_space(VFIODevice *vbasedev, =
Error **errp)
> > > > +{
> > > > +    uint32_t cpu_aw_bits =3D cpu_get_phys_bits(first_cpu);
> > > > +    uint32_t iommu_aw_bits =3D vfio_device_get_aw_bits(vbasedev);
> > > > +
> > > > +    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) { =20
> > >=20
> > > Should we be testing the 64-bit MMIO window and maximum RAM GPA rather
> > > than the vCPU physical address width? =20
>=20
> Placing the 64-bit  mmio window is done by the guest firmware,
> so this isn't something qemu can check before boot.
>=20
> > > However, we've decided to do exactly that for the 64-bit MMIO window.
> > > It's not that the vCPU width being greater than the IOMMU width is a
> > > fundamental problem, it's that we've chosen a 64-bit MMIO policy that
> > > makes this become a problem and QEMU only has a convenient mechanism =
to
> > > check the host IOMMU width when a vfio device is present.  Arguably,
> > > when a vIOMMU is present guest firmware should be enlightened to
> > > understand the address width of that vIOMMU when placing the 64-bit
> > > MMIO window.  I'd say the failure to do so is a current firmware bug.=
 =20
>=20
> edk2 has no iommu driver ...
>=20
> Is there some simple way to figure what the iommu width is (inside the
> guest)?

If the guest firmware is exposing a DMAR table (VT-d), there's a host
address width field in that table.  Otherwise there are capability
registers on the DRHD units that could be queried.  AMD-Vi seems to
have similar information in the IVinfo table linked from the IVRS
table.  Maybe an iterative solution is ok, starting with the most
common IOMMU types and assuming others are 64-bits wide until proven
otherwise.

>=20
> Note that there is a 'guest-phys-bits' property for x86 CPUs, which is a
> hint for the guest what the usable address width is.  It was added
> because there are cases where the guest simply can't figure that it is
> not possible to use the full physical address space of the cpu.  There
> are some non-obvious limitations around 5-level paging.  Intel has some
> CPUs with phys-bits > 48 but only 4-level EPT for example.
>=20
> So one option to handle this is to make sure guest-phys-bits is not
> larger than the iommu width.

Right, as C=C3=A9dric notes that's sort of what happens here, but my concern
was that the we're kind of incorrectly linking the cpu address width to
the platform address width, which isn't specifically the requirement.
It's valid to have CPU physical address width great than IOMMU address
width, that exists on bare metal, but guest firmware needs to take
IOMMU address width into account in placing the 64-bit MMIO window if
we want PCI BARs to be DMA addressable.  Thanks,

Alex


