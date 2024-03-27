Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1976BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpaGM-0004Oq-Hn; Wed, 27 Mar 2024 16:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rpaGJ-0004OJ-Ks
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rpaGH-0006uQ-Tk
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711572760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pW0ojG3ndwgE/v4rM89IHsDuWEEg/21ioV3l/R79FY=;
 b=hCPZUZwSOa7uxvBV6O6ikoovCwpWXETeOSM0/+t/cBG8/GKg5h/WUFqfOkypc/neMXI89+
 QdA50ZrF37z/z1gx2VUgmyaNKw2eIs/OZJLvgggQXNmh31Sp0xzelJ06aUmGGl0lM/c/OL
 UyGX7HtCqfUtjXRlQotzfKRP1SM8XAU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-JdMkP-g_PC63z1TB9pIR0g-1; Wed, 27 Mar 2024 16:52:39 -0400
X-MC-Unique: JdMkP-g_PC63z1TB9pIR0g-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-368a41081baso1893655ab.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 13:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711572759; x=1712177559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pW0ojG3ndwgE/v4rM89IHsDuWEEg/21ioV3l/R79FY=;
 b=pXAQL4+excLLsLLUvtMhUR7XqWUMNA1aYfj7FWmWkKerYMZnYxaAUAKtO3hvIMxdqI
 BSPwpZOIJpY26FdxM4hrkSYRKLH0tJGjYW53fP14O796YAuMCwOt6Yo9p4v09B3FT/ID
 Sum5Lj7CNfm6n3yUzPSVAMRQxfj1U4heIPuw45xAkk5bCP7BlcX5wBb+pMfkq67suSBy
 ukWvrjlWwCeCwIquiNdyHylMEQjtGo/4ZKF0xJTZTBeorkQU2a5DAhjha6/ppwzQz55Z
 l74V8RDGwy3Contz1PfXVN9+POM+0vYAHKj94I5qKTqNWoIrcULXrZdJXaDy6Ciev4mX
 IVrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/kuMPvp128t/7Ci7sf9Wq58IxD5KJDRHDFIsAtUBVCGCpsAEICAyLNGAJ+G/gmd4rcwKUcDduNeQ8POl+LwwSlKnbpU=
X-Gm-Message-State: AOJu0Yzg0EUwVdw2VWeT+Y2AAcL9RzeLjNvMSwCg53cWO+KIRbbXVHei
 nOQfZm02YijcjtQlXNSz0QlApwoy3OZLKXxolisBLmWVe+UoFLdQyLxbQ4jQtu6xGoGXXU9ElUI
 hxuy1lcwx3CmI3WTzJxfdeugDApI4GHoWGJq0FmZGmCMCIejSvO6q
X-Received: by 2002:a05:6e02:1049:b0:366:4967:d932 with SMTP id
 p9-20020a056e02104900b003664967d932mr1106725ilj.7.1711572758769; 
 Wed, 27 Mar 2024 13:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE14A/bVgCYGg+01T0SI2mboM+uA0nIttgSzsyNCcRhYDWKZAjKcBE2LWekEf2+X3szOtVyXg==
X-Received: by 2002:a05:6e02:1049:b0:366:4967:d932 with SMTP id
 p9-20020a056e02104900b003664967d932mr1106711ilj.7.1711572758504; 
 Wed, 27 Mar 2024 13:52:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 t4-20020a92dc04000000b00366a7ec00f3sm1358370iln.40.2024.03.27.13.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:52:38 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:52:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vinayak Kale <vkale@nvidia.com>, qemu-devel@nongnu.org,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com, acurrid@nvidia.com,
 cjia@nvidia.com, zhiw@nvidia.com, targupta@nvidia.com, kvm@vger.kernel.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
Message-ID: <20240327145235.47338c2b.alex.williamson@redhat.com>
In-Reply-To: <20240327161108-mutt-send-email-mst@kernel.org>
References: <20240322064210.1520394-1-vkale@nvidia.com>
 <20240327113915.19f6256c.alex.williamson@redhat.com>
 <20240327161108-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 27 Mar 2024 16:11:37 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 27, 2024 at 11:39:15AM -0600, Alex Williamson wrote:
> > On Fri, 22 Mar 2024 12:12:10 +0530
> > Vinayak Kale <vkale@nvidia.com> wrote:
> >  =20
> > > In case of migration, during restore operation, qemu checks config sp=
ace of the
> > > pci device with the config space in the migration stream captured dur=
ing save
> > > operation. In case of config space data mismatch, restore operation i=
s failed.
> > >=20
> > > config space check is done in function get_pci_config_device(). By de=
fault VSC
> > > (vendor-specific-capability) in config space is checked.
> > >=20
> > > Due to qemu's config space check for VSC, live migration is broken ac=
ross NVIDIA
> > > vGPU devices in situation where source and destination host driver is=
 different.
> > > In this situation, Vendor Specific Information in VSC varies on the d=
estination
> > > to ensure vGPU feature capabilities exposed to the guest driver are c=
ompatible
> > > with destination host.
> > >=20
> > > If a vfio-pci device is migration capable and vfio-pci vendor driver =
is OK with
> > > volatile Vendor Specific Info in VSC then qemu should exempt config s=
pace check
> > > for Vendor Specific Info. It is vendor driver's responsibility to ens=
ure that
> > > VSC is consistent across migration. Here consistency could mean that =
VSC format
> > > should be same on source and destination, however actual Vendor Speci=
fic Info
> > > may not be byte-to-byte identical.
> > >=20
> > > This patch skips the check for Vendor Specific Information in VSC for=
 VFIO-PCI
> > > device by clearing pdev->cmask[] offsets. Config space check is still=
 enforced
> > > for 3 byte VSC header. If cmask[] is not set for an offset, then qemu=
 skips
> > > config space check for that offset.
> > >=20
> > > Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> > > ---
> > > Version History
> > > v2->v3:
> > >     - Config space check skipped only for Vendor Specific Info in VSC=
, check is
> > >       still enforced for 3 byte VSC header.
> > >     - Updated commit description with live migration failure scenario.
> > > v1->v2:
> > >     - Limited scope of change to vfio-pci devices instead of all pci =
devices.
> > >=20
> > >  hw/vfio/pci.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+) =20
> >=20
> >=20
> > Acked-by: Alex Williamson <alex.williamson@redhat.com> =20
>=20
>=20
> A very reasonable way to do it.
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Merge through the VFIO tree I presume?

Yep, C=C3=A9dric said he=C2=B4d grab it for 9.1.  Thanks,

Alex
=20
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index d7fe06715c..1026cdba18 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2132,6 +2132,27 @@ static void vfio_check_af_flr(VFIOPCIDevice *v=
dev, uint8_t pos)
> > >      }
> > >  }
> > > =20
> > > +static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> > > +                                        uint8_t size, Error **errp)
> > > +{
> > > +    PCIDevice *pdev =3D &vdev->pdev;
> > > +
> > > +    pos =3D pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, err=
p);
> > > +    if (pos < 0) {
> > > +        return pos;
> > > +    }
> > > +
> > > +    /*
> > > +     * Exempt config space check for Vendor Specific Information dur=
ing restore/load.
> > > +     * Config space check is still enforced for 3 byte VSC header.
> > > +     */
> > > +    if (size > 3) {
> > > +        memset(pdev->cmask + pos + 3, 0, size - 3);
> > > +    }
> > > +
> > > +    return pos;
> > > +}
> > > +
> > >  static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error =
**errp)
> > >  {
> > >      PCIDevice *pdev =3D &vdev->pdev;
> > > @@ -2199,6 +2220,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev=
, uint8_t pos, Error **errp)
> > >          vfio_check_af_flr(vdev, pos);
> > >          ret =3D pci_add_capability(pdev, cap_id, pos, size, errp);
> > >          break;
> > > +    case PCI_CAP_ID_VNDR:
> > > +        ret =3D vfio_add_vendor_specific_cap(vdev, pos, size, errp);
> > > +        break;
> > >      default:
> > >          ret =3D pci_add_capability(pdev, cap_id, pos, size, errp);
> > >          break; =20
>=20


