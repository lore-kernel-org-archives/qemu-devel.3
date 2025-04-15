Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE9C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 12:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4fUM-0000jL-87; Tue, 15 Apr 2025 08:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4fU6-0000i2-3N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4fU0-0007a4-0j
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744720422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zTu5KEG67M4WYwet9a7oSVegeNiDRbUhPgTcgpv+b0=;
 b=Rz1E8jW3paORkJUZFKUZk3EMCyD9Efv7bFHbJYKhyd9IdGrmhX+Z8HCH8PEsNXDPnKfuzP
 n3rHKCKTGM+Eb2/3PgnYKef70zpBfDno4iWkuk9uNcsjHBZKM4uSegpytfp4wFVHsWZxCa
 onkpNWo49nzjOn4WdyQDwKi4j4SGpww=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-q3pXrH_-NW6-tbxi_W5vrQ-1; Tue,
 15 Apr 2025 08:33:36 -0400
X-MC-Unique: q3pXrH_-NW6-tbxi_W5vrQ-1
X-Mimecast-MFC-AGG-ID: q3pXrH_-NW6-tbxi_W5vrQ_1744720415
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAB47195609E; Tue, 15 Apr 2025 12:33:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A67A180B488; Tue, 15 Apr 2025 12:33:32 +0000 (UTC)
Date: Tue, 15 Apr 2025 08:33:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Message-ID: <20250415123330.GB270228@fedora>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <20250415030653-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7+slmqUSXtFty2Ya"
Content-Disposition: inline
In-Reply-To: <20250415030653-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--7+slmqUSXtFty2Ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 03:11:00AM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 15, 2025 at 06:18:08AM +0000, CLEMENT MATHIEU--DRIF wrote:
> > Address space creation might end up being called without holding the
> > bql as it is exposed through the IOMMU ops.
> >=20
> > Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>=20
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Stefan, want to pick this one up, too?

Not yet, it may need to wait until after the release:
- Discussion is still ongoing.
- Is this a regression in 10.0 or a long-standing issue?
- Who is affected and what is the impact?

There are still a few hours left before -rc4 is tagged. I will merge it
if consensus is reached and the missing information becomes clear.

Thanks,
Stefan

>=20
>=20
> > ---
> >  hw/i386/intel_iommu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index dffd7ee885..fea2220013 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus,
> >      vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
> >      if (!vtd_dev_as) {
> >          struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
> > +        bool take_bql =3D !bql_locked();
> > =20
> >          new_key->bus =3D bus;
> >          new_key->devfn =3D devfn;
> > @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState=
 *s, PCIBus *bus,
> >          vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
> >          vtd_dev_as->iova_tree =3D iova_tree_new();
> > =20
> > +        /* Some functions in this branch require the bql, make sure we=
 own it */
> > +        if (take_bql) {
> > +            bql_lock();
> > +        }
> > +
> >          memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_=
MAX);
> >          address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-ro=
ot");
> > =20
> > @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState=
 *s, PCIBus *bus,
> > =20
> >          vtd_switch_address_space(vtd_dev_as);
> > =20
> > +        if (take_bql) {
> > +            bql_unlock();
> > +        }
> > +
> >          g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as=
);
> >      }
> >      return vtd_dev_as;
> > --=20
> > 2.49.0
>=20

--7+slmqUSXtFty2Ya
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf+UhoACgkQnKSrs4Gr
c8haywf/Q8VKvDTVo3QFBtu2C+tFYjOMb+i0wYL+d4vx113xyvSm37cuSfkfDfPn
UCiylKnFEyx1++3lBzTxScHE4Lq8otGZcHULDROE+zOZuOm4jHzD8yQoweVKIIkm
WridKl6XHa8x+6kwrw5Fzfapn8B3KJB4MOTbUFQadQubVF4/W3cMveMIV3iTzY9F
Egztw1NJrZpEvoykAFgq6i1LMfHsjA/fp1smr1Sb/Ui4COtK7q202aMtLanKvQPl
aFzk7EgVFyCSKBo/7pSOS7yEVi1qCHqnbifElREgKK26DsgcYpfI0dgZmRVqfBNx
4QIpXRHh4BK0z720Ta7EVYkNp9NVRw==
=CDyL
-----END PGP SIGNATURE-----

--7+slmqUSXtFty2Ya--


