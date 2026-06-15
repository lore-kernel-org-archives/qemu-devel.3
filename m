Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2100CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ9do-0003vP-MJ; Mon, 15 Jun 2026 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZ9dn-0003v5-DV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZ9dl-0006sm-Lb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781538860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hu+5g/RchjMDQ29VQgzhHz85j/NwwIT6mmPIMKMJgpQ=;
 b=Tv2T99gqlGWpoi8tDYAmfNqYpKGVpfnCv6NNisFCPQU3wRwIszYHir6ESq6WKid5B3jRn1
 33qWf/rYHDQRH4HqBEr0Z5aGXWVGLodk2wkNYyMvv6fM8x5+JJz8Ubl/x6AcxP+V0iw1mg
 hf5ZTiMo7n2lrZLt34aQo/YtKkS7Rk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-NzETjdikM9q0PNt8LeniWg-1; Mon,
 15 Jun 2026 11:54:16 -0400
X-MC-Unique: NzETjdikM9q0PNt8LeniWg-1
X-Mimecast-MFC-AGG-ID: NzETjdikM9q0PNt8LeniWg_1781538855
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE84819560B2; Mon, 15 Jun 2026 15:54:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCA053008B38; Mon, 15 Jun 2026 15:54:13 +0000 (UTC)
Date: Mon, 15 Jun 2026 11:54:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260615155411.GA450713@fedora>
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
 <20260610165710-mutt-send-email-mst@kernel.org>
 <20260611142022.GA202155@fedora>
 <20260611103513-mutt-send-email-mst@kernel.org>
 <CAFEAcA8RAsmrAArKz0X7NU6sCnKTC-e413TgwLp1gt2vJGLgPw@mail.gmail.com>
 <20260611110543-mutt-send-email-mst@kernel.org>
 <20260611183708.GA222320@fedora>
 <20260611165238-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OJbP8W+pbUCDdIMd"
Content-Disposition: inline
In-Reply-To: <20260611165238-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--OJbP8W+pbUCDdIMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:54:36PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 02:37:08PM -0400, Stefan Hajnoczi wrote:
> > On Thu, Jun 11, 2026 at 11:09:35AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 11, 2026 at 04:04:20PM +0100, Peter Maydell wrote:
> > > > On Thu, 11 Jun 2026 at 15:46, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > > >
> > > > > On Thu, Jun 11, 2026 at 10:20:22AM -0400, Stefan Hajnoczi wrote:
> > > > > > Gavin posted the lspci output:
> > > > > >
> > > > > >   Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=
=3D16M]
> > > > > >   Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=
=3D128G]
> > > > > >   Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=
=3D32M]
> > > > > >
> > > > > > These are prefetchable memory BARs, so I would expect them to be
> > > > > > mmappable. Why does QEMU have no way of knowing upfront whether=
 they can
> > > > > > be mmapped?
> > > > >
> > > > >
> > > > > They can be mmapped.  The issue is just that after mmap flatview =
uses
> > > > > memcpy/memmove on them, and that might not match what guest drive=
r is
> > > > > expecting specifically for 1/2/4/8 byte accesses.
> > > >=20
> > > > Huh? The guest driver has nothing to do with it, surely.
> > >=20
> > > My answer is I don't know.
> > >=20
> > > But the commit that introduced the regression says:
> > >=20
> > > 	 The assumption here is that accesses initiated by the VM are
> > > 	    driven by a device specific driver, which knows the device
> > > 	    capabilities.=20
> > >=20
> > > > The
> > > > problem is that for some PCI devices (like the network card
> > > > mentioned in 4a2e242bbb30's commit message) the BAR is *not*
> > > > safe for arbitrary access (because the actual real host hardware
> > > > inside it is not RAM).
> > >=20
> > > But we don't do arbitrary access. Why would we?
> > >=20
> > > > That commit disabled direct access
> > > > for all vfio MRs, which is safe but overcautious. Would
> > > > "direct access is OK if this is a prefetchable memory BAR" be OK?
> > > > Or do some prefetchable memory BARs still have restrictions
> > > > beyond those of real RAM?
> >=20
> > I wonder the same thing.
>=20
> pci spec mostly made prefetcheable the default, and made
> it a very weak signal.
>=20
> but really, direct access is just always ok. bounce buffers
> just do not have the bug of memory core besides that
> they buy us nothing.

What is the next step here?

Stefan

> > > >=20
> > > > > Removing mmap is one solution, this is what vfio does now.
> > > > > Fixing flatview is another.
> > > >=20
> > > > No, you can't fix this in flatview. If a BAR is not safe for
> > > > direct access then it is not safe for direct access.
> > > >=20
> > > > -- PMM
> > >=20
> > > There's no such thing as "not safe for direct access" in PCI.
> > > All operations are memory operations.
> > > What can be unsafe is accesses of specific width and length.
> > >=20
> > > So we should not use variable length memcpy/memmove which
> > > do that. Fixes length memcpy/memmove exactly mimic what
> > > guest does, so they are safe.
> >=20
> > The bounce buffer approach doesn't seem like a solution to me: if the
> > device has alignment and size restrictions on accesses, then the bounce
> > buffer won't get them right because it doesn't know where the registers
> > live within the BAR.
> >=20
> > Also, the guest initiated I/O to a VIRTIO device pointing to a buffer in
> > another PCI device's BAR. In this case any failure to handle BAR
> > accesses would be the guest's problem. It cannot assume that the VIRTIO
> > device follows a specific DMA transfer pattern with respect to
> > alignment/size.
> >=20
> > Stefan
>=20
>=20

--OJbP8W+pbUCDdIMd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmowICMACgkQnKSrs4Gr
c8iqkAgAvUrTCeHS/l689fHJOqLMHeup6qbzsej6cmkpzqWV6ATNn4xG5+PpDv4l
5uj6vzo8W4TRW7X5kc1FndlbDWL3+eDK8ARx/M8X1n8sYruIM1FpeBwBWDJXjv+b
yWWbfQySFCiFYgGT9mTl+bh7TBwwbvmAnpKrMzHRs0jsyWCFQTDKNVXczDVO0fao
KBkdQ3T4mrSLg/L6g0hjeuyXZNXnMxLZOUiZpkYVdpxmt16ugbHU7qmFQwgwJubf
n5V8P+KmVuM1ytAUXLGRBmtwF2rva8Sc95JBxCWkpUVT5AftDvQ2kcDhco0a2ru2
F2sChd//6CItxLYirSZENpM0fE7aMw==
=eiPe
-----END PGP SIGNATURE-----

--OJbP8W+pbUCDdIMd--


