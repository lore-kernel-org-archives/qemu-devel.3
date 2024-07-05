Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7E7C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPg5E-0001nB-VQ; Fri, 05 Jul 2024 06:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPg5C-0001mh-O6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPg5B-0004e8-55
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720174944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QD8NxvMVKJZpNvMXjMnnhT2MFSBS9+TWu9Xr9cMZz1s=;
 b=M62X4cY7ecDtUaI8BvyQK4OYIg3YdwOgAljP+URNNzKUGmkE3rysbkTVOYhxv+oZZ5QoXr
 B8aaj9NfwrrJjjdGQal+lTTRfdRPsOifpW7lpXxyv8MIzjgOoPJaLNqEte6x4+p/cc159Z
 jN4LslWZRnir9cHrFu+I+Rs6j55nCVc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-xwAjeedRPnKPp2tX7pHkCQ-1; Fri,
 05 Jul 2024 06:22:21 -0400
X-MC-Unique: xwAjeedRPnKPp2tX7pHkCQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E28FD1937AB3; Fri,  5 Jul 2024 10:22:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.55])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E53651955F40; Fri,  5 Jul 2024 10:22:15 +0000 (UTC)
Date: Fri, 5 Jul 2024 12:22:12 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: Re: [PATCH v6 08/10] hw/nvme: enable ONCS and rescap function
Message-ID: <20240705102212.GA2703318@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-9-luchangqi.123@bytedance.com>
 <20240704182031.GG2529519@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AEwIDCpqwWacjn0R"
Content-Disposition: inline
In-Reply-To: <20240704182031.GG2529519@fedora.redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--AEwIDCpqwWacjn0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 08:20:31PM +0200, Stefan Hajnoczi wrote:
> On Thu, Jun 13, 2024 at 03:13:25PM +0800, Changqi Lu wrote:
> > This commit enables ONCS to support the reservation
> > function at the controller level. Also enables rescap
> > function in the namespace by detecting the supported reservation
> > function in the backend driver.
> >=20
> > Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >  hw/nvme/ctrl.c | 3 ++-
> >  hw/nvme/ns.c   | 5 +++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 127c3d2383..182307a48b 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice=
 *pci_dev)
> >      id->nn =3D cpu_to_le32(NVME_MAX_NAMESPACES);
> >      id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMEST=
AMP |
> >                             NVME_ONCS_FEATURES | NVME_ONCS_DSM |
> > -                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
> > +                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
> > +                           NVME_ONCS_RESRVATIONS);
>=20
> RESRVATIONS -> RESERVATIONS typo?
>=20
> > =20
> >      /*
> >       * NOTE: If this device ever supports a command set that does NOT =
use 0x0
> > diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> > index ea8db175db..320c9bf658 100644
> > --- a/hw/nvme/ns.c
> > +++ b/hw/nvme/ns.c
> > @@ -20,6 +20,7 @@
> >  #include "qemu/bitops.h"
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/block-backend.h"
> > +#include "block/block_int.h"
> > =20
> >  #include "nvme.h"
> >  #include "trace.h"
> > @@ -33,6 +34,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
> >      BlockDriverInfo bdi;
> >      int npdg, ret;
> >      int64_t nlbas;
> > +    uint8_t blk_pr_cap;
> > =20
> >      ns->lbaf =3D id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> >      ns->lbasz =3D 1 << ns->lbaf.ds;
> > @@ -55,6 +57,9 @@ void nvme_ns_init_format(NvmeNamespace *ns)
> >      }
> > =20
> >      id_ns->npda =3D id_ns->npdg =3D npdg - 1;
> > +
> > +    blk_pr_cap =3D blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
>=20
> Kevin: This unprotected block graph access and the assumption that
> ->file->bs exists could be problematic. What is the best practice for
> making this code safe and defensive?

I posted the following reply in another sub-thread and it seems worth
mentioning here:

"->file could be NULL if the SCSI disk points directly to
--blockdev file without a --blockdev raw on top. I think the block layer
should propagate pr_cap from the leaves of the block graph to the root
node via bdrv_merge_limits() so that traversing the graph (->file) is
not necessary. Instead this line should just be bs->bl.pr_cap."

I think ->file shouldn't be accessed at all. That also sidesteps the
block graph locking question.

>=20
> > +    id_ns->rescap =3D block_pr_cap_to_nvme(blk_pr_cap);
> >  }
> > =20
> >  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> > --=20
> > 2.20.1
> >=20



--AEwIDCpqwWacjn0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaHyVQACgkQnKSrs4Gr
c8gtHAf+K9i08FH9znWvIDp8S06v2AI7naPR3WH4PARdyH9oPNOMKhY8rAysh2tC
h+Nj1jpru2wTqDAf/ccxXTLi5iNPiPDDgC1sqze21XQlgBuQOmgXh+EspAfSF944
GE70J3KqQmfEIVi6cN2MQVthQOfK4E6ONtDdyKhZ06d/kSYOCYm+xVYEwOqgs3HI
Q4Fgur+pb1AnV14qzqzmHUZW5NR+tyrSPdeqzCZ5Tt/g2xASEgi2Ki/urqIxoNG/
n/wLL3ed9rsAauBzjO0C4QIyq/LF4Rk8KecxkTa6rjzCo5gONaAKKM+y4ov1cgPx
wDeLrp6MtAHitHqWYaMpmyfMV9FjdQ==
=jDvk
-----END PGP SIGNATURE-----

--AEwIDCpqwWacjn0R--


