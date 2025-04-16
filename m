Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB2C369C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Ov-0002lo-Vp; Wed, 16 Apr 2025 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u58Op-0002lU-KD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u58On-0007km-4I
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744831575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qT1ieZ434PvXCUh5GiA8je9Uykd0GsB5Mhjjw0dLnDw=;
 b=BRH9Dl/odJZEUPL3gieWcHGm1X1GZ4RjsE5nHwHfJS6e+4kEImdRmZXMdV0tvrde+Ut37W
 9s7PdcOKa4HlDyJ3VNsl40nWlDz9x6YkxRCmDpwEAk7aYYSmme11wEBWFMCd8krLfY2HlN
 SSvJ/N9xbrMtWYBZ8yoaej7QhrHnDdY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-EWm8UnHDP1q8Rx59TxPa1w-1; Wed,
 16 Apr 2025 15:26:11 -0400
X-MC-Unique: EWm8UnHDP1q8Rx59TxPa1w-1
X-Mimecast-MFC-AGG-ID: EWm8UnHDP1q8Rx59TxPa1w_1744831570
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 990B419560B5; Wed, 16 Apr 2025 19:26:10 +0000 (UTC)
Received: from localhost (unknown [10.2.17.14])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8CD219560A3; Wed, 16 Apr 2025 19:26:09 +0000 (UTC)
Date: Wed, 16 Apr 2025 15:26:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
Message-ID: <20250416192608.GB38698@fedora>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <87v7r5clft.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kOREZOrGlE4X9D/S"
Content-Disposition: inline
In-Reply-To: <87v7r5clft.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--kOREZOrGlE4X9D/S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 07:46:14PM +0100, Alex Benn=E9e wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>=20
> > A hang was observed when running a small kernel that exercised VIRTIO=
=20
> > GPU under TCG. This is an edge-case and won't happen under typical=20
> > conditions.
>=20
> Should I (or MST?) pull these into a tree for 10.0 or should they be
> grabbed for when the tree opens with a Cc qemu-stable?

QEMU 10.0.0-rc4 has already been tagged. No further patches will be
merged unless there is a show-stopper (build failure, security issue).

Please Cc qemu-stable so this can be merged for 10.0.1. Thanks!

>=20
> >
> > When unmapping a blob object, its MemoryRegion's freeing is deferred to=
=20
> > the RCU thread. The hang's cause was determined to be a busy main loop=
=20
> > not allowing for the RCU thread to run because the kernel did not setup=
=20
> > any timers or had any interrupts on the way. While fixing the RCU threa=
d=20
> > to run even if the guest CPU spins is a solution, it's easier to fix th=
e=20
> > reason why the MemoryRegion isn't freed from the main loop instead.
> >
> > While at it, also restructure the 3 stage cleanup to immediately respon=
d=20
> > to the guest if the MR happened to have had no other reference.
> >
> > PS: The hang can be reproduced by running this unikernel with TCG=20
> >
> > https://git.codelinaro.org/manos.pitsidianakis/virtio-tests/-/tree/8c0e=
be9395827e24aa5711186d499bf5de87cf63/virtio-test-suite
> >
> > v1 to v2:
> >   - Add patch by Alex to prevent double-free when FlatView is destroyed=
=20
> >     from RCU thread.
> >
> > Alex Benn=E9e (1):
> >   hw/display: re-arrange memory region tracking
> >
> > Manos Pitsidianakis (2):
> >   virtio-gpu: fix hang under TCG when unmapping blob
> >   virtio-gpu: refactor async blob unmapping
> >
> >  include/exec/memory.h         |  1 +
> >  hw/display/virtio-gpu-virgl.c | 60 ++++++++++++++++++++---------------
> >  2 files changed, 35 insertions(+), 26 deletions(-)
> >
> >
> > base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
>=20
> --=20
> Alex Benn=E9e
> Virtualisation Tech Lead @ Linaro
>=20

--kOREZOrGlE4X9D/S
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgABFAACgkQnKSrs4Gr
c8gHYQf+J6UmpiIpHJG8tlMxLlHpw0tWv3eILmcVg9u/LQ1mQCxnba2MPIWWO3MO
V2KcoUcSDUSKw2zhTTckVczW+RPIMnsmnOVHMVz8L4e8VUqBvvhSrN88m5Y5MW1E
XuyzAzW/G30ldegbWsNY3Fpqe6q9TwLfD9Yq41Z5vSiGieT3EACSAw2DKxiPeB13
V9ph3I7Kkvyxeu6hfd60YmVy8QJuKqjvSIPRZPfhEZP/WYmNvxGeYrDtrzIPl3Ei
zWwi/GgshmQY4nYeRzGTF54o+pFehPAoTU3QByfObLLchdOgO8SYfSyVPkISoq+8
5D0bDytrBTw/bRbftDceDXPUrRPtWw==
=1jvc
-----END PGP SIGNATURE-----

--kOREZOrGlE4X9D/S--


