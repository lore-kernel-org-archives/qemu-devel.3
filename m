Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804A2C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6r6T-0002Gs-LR; Wed, 16 Sep 2026 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x6r6R-0002Gk-7w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x6r6O-00016d-62
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGKlLk+7PGa0yDjM1ZYp5n4187Ijm+pX6dAk979NvcE=;
 b=Ox1EaGbGJYJ+6nj/xbaQ9cLNbElqpogEibsWUs3QS1FCbn4CbupTbgu6LUyGdrBqnyzuBb
 0HaYOcqRV4M165veNt6Mdl3yquaiP5DJ4BzodBufcYUZfOBDiSPKmYjRMZ9vdnlKmd4RmS
 rKaD8Qq7Y9cHqfHY1dFgr3S2wIPIkKo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-YZgCWZq8OxiUHXuE1THf4w-1; Wed,
 16 Sep 2026 10:59:07 -0400
X-MC-Unique: YZgCWZq8OxiUHXuE1THf4w-1
X-Mimecast-MFC-AGG-ID: YZgCWZq8OxiUHXuE1THf4w_1789570746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC2EF1964CE1; Wed, 16 Sep 2026 14:59:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B98E18002B1; Wed, 16 Sep 2026 14:59:04 +0000 (UTC)
Date: Wed, 16 Sep 2026 10:59:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Fishman <afishman@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v1 0/2] vhost: Handle vrings crossing virtio-mem slots
Message-ID: <20260916145903.GA145703@fedora>
References: <20260909125923.75340-1-afishman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fcevn8N3cMHtIj/E"
Content-Disposition: inline
In-Reply-To: <20260909125923.75340-1-afishman@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Fcevn8N3cMHtIj/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 03:59:21PM +0300, Alex Fishman wrote:
> Virtio-mem dynamic memslots are intentionally exposed as separate memory
> regions. If a guest places a vring part across two adjacent slots, a later
> memory update fails vhost ring verification because the complete ring part
> is not contained in one vhost memory region.
>=20
> Coalesce coherent adjacent sections only when a descriptor table,
> available ring, or used ring crosses their boundary. Unrelated
> unmergeable sections remain separate so they can still be updated
> independently.
>=20
> Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user
> backend and virtio-mem dynamic memslots. It also verifies that a newly
> activated slot is not folded into the merge required by the crossing
> vring.
>=20
> Tested with the vhost-user/mem-slots/boundary qtest.
>=20
> Buglink: https://redhat.atlassian.net/browse/RHEL-146583
>=20
> Alex Fishman (2):
>   vhost: coalesce unmergeable sections across vring boundaries
>   tests/qtest: Add vhost-user memslot boundary test
>=20
>  hw/virtio/vhost.c             |  72 ++++++-
>  tests/qtest/vhost-user-test.c | 395 +++++++++++++++++++++++++++++++++-
>  2 files changed, 452 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
> --=20
> 2.52.0

I'm pretty sure a similar problem exists with hw/virtio/virtio.c's
MemoryRegionCaches. If a vring spans virtio-mem dynamic memslots, then
the MemoryRegionCache won't work because the memory range crosses
MemoryRegions.

Is it worth looking at that first (e.g. triggering the issue with a test
case that uses a built-in VIRTIO device instead of a vhost-user device)
before implementing a solution that is specific to vhost-user?

Stefan

--Fcevn8N3cMHtIj/E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqqrrcACgkQnKSrs4Gr
c8jilAgAhktzMnjIwJhh3noM+MoFq0kUL3fXWlUFLJvbVF8XzOUzMUJXXik7S4Mx
qUq5fvO53M3DlwLQoiCHbf5UmvqsiXXlHkt1+Cw4HV08UNifgKQGiAffbuqgJh4F
atx1190Gpq4iKdi0mXsA9yb378DGEVi+w/F/sGhbTvPX5Kj7AZT8VWyV+8a6cO6f
DiGeaj/cV49en2DcQvmNU615A/qekx0bYzHPu/jLnxSUkBS11DpTYaVrjzMcC5y8
l0B23YKCjZjVxtUFrjinNLqRG4XkM38XRSNcp2hzcg/Y8hjZZSuE9Wfb9GJFWM81
BdsLXGFORC1NpIcRAV86XDARHPrzCg==
=TPCZ
-----END PGP SIGNATURE-----

--Fcevn8N3cMHtIj/E--


