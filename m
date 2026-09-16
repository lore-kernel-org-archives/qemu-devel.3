Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0E5C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sGr-0003zH-B6; Wed, 16 Sep 2026 12:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x6sGm-0003yr-RE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x6sGk-0002bY-Co
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789575236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeIEbpeU2EJW58VBcNC5Z8chHiGZwZjUNZD136kW/KE=;
 b=hH+qf0UHJe3Lppqn7zBUb4+gFUdD4KEm3+1HEA5vEWvVkcvcHkHGESTXNzUIk3CtFc2Vq1
 CzFDsMg/pKEwtmww7n8AYRljqJoGAMHg+5/lqZRw/fG4EZeOzdVyokazsXjKz+jz+f4mXi
 bHYCGw80QiGM8ZqiCtiLrUT2tAnJggw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-CUjGCff5OLi3_XLbpDvCUg-1; Wed,
 16 Sep 2026 12:13:52 -0400
X-MC-Unique: CUjGCff5OLi3_XLbpDvCUg-1
X-Mimecast-MFC-AGG-ID: CUjGCff5OLi3_XLbpDvCUg_1789575231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 811071944B32; Wed, 16 Sep 2026 16:13:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBF891800361; Wed, 16 Sep 2026 16:13:50 +0000 (UTC)
Date: Wed, 16 Sep 2026 12:13:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Fishman <afishman@redhat.com>, qemu-devel@nongnu.org,
 sgarzare@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v1 0/2] vhost: Handle vrings crossing virtio-mem slots
Message-ID: <20260916161349.GA149950@fedora>
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260916145903.GA145703@fedora>
 <20260916110929-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7RGlq1s+OQszzsvp"
Content-Disposition: inline
In-Reply-To: <20260916110929-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--7RGlq1s+OQszzsvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:10:00AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 16, 2026 at 10:59:03AM -0400, Stefan Hajnoczi wrote:
> > On Wed, Sep 09, 2026 at 03:59:21PM +0300, Alex Fishman wrote:
> > > Virtio-mem dynamic memslots are intentionally exposed as separate mem=
ory
> > > regions. If a guest places a vring part across two adjacent slots, a =
later
> > > memory update fails vhost ring verification because the complete ring=
 part
> > > is not contained in one vhost memory region.
> > >=20
> > > Coalesce coherent adjacent sections only when a descriptor table,
> > > available ring, or used ring crosses their boundary. Unrelated
> > > unmergeable sections remain separate so they can still be updated
> > > independently.
> > >=20
> > > Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user
> > > backend and virtio-mem dynamic memslots. It also verifies that a newly
> > > activated slot is not folded into the merge required by the crossing
> > > vring.
> > >=20
> > > Tested with the vhost-user/mem-slots/boundary qtest.
> > >=20
> > > Buglink: https://redhat.atlassian.net/browse/RHEL-146583
> > >=20
> > > Alex Fishman (2):
> > >   vhost: coalesce unmergeable sections across vring boundaries
> > >   tests/qtest: Add vhost-user memslot boundary test
> > >=20
> > >  hw/virtio/vhost.c             |  72 ++++++-
> > >  tests/qtest/vhost-user-test.c | 395 ++++++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 452 insertions(+), 15 deletions(-)
> > >=20
> > >=20
> > > base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
> > > --=20
> > > 2.52.0
> >=20
> > I'm pretty sure a similar problem exists with hw/virtio/virtio.c's
> > MemoryRegionCaches. If a vring spans virtio-mem dynamic memslots, then
> > the MemoryRegionCache won't work because the memory range crosses
> > MemoryRegions.
>=20
> IIUC address_space_cache_init does not check unmergeable, so virtio
> doesn't have this problem.

You are right: address_space_cache_init() ->
flatview_extend_translation() extends cache->ptr across active memslots.
flatview_extend_translation() effectively merges the
MemoryRegionSections whereas vhost.c's MemoryListener does not!

Stefan

--7RGlq1s+OQszzsvp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqqwD0ACgkQnKSrs4Gr
c8jj8gf/dZWDKAsJHTTAZPkv54RnFX5vDC95cYuGFTne8YJZtJWtuVDZzVaJE9uN
l3ykpd5QWJPMpD+lVayJCNd234IiFOqW95WF+1SGaYDbihlvUhgJZigDr8uGhZFj
Qo8CP3o60EZMLlQAKZ3FKnh8aWJlldONJ3AoaDR1InF1zWVF+mZxKQYRI9bxH/86
70kY5k4L0eZPHPVuFrbnfXaqDn+lum+ayMbilHwxVbPlZg8OLz2cca6lOZkNz5rG
cI72yCh/vLRe6Jh/SvbcGioEcP6/aHK0aSVlqj3xdcrPOTkh8tFqLfUIhTIeyUVb
WQkpG4+G3eqtX/sF9bia6AIqduR84Q==
=w+gB
-----END PGP SIGNATURE-----

--7RGlq1s+OQszzsvp--


