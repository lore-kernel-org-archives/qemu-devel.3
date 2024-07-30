Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FAAC52D54
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWRd-0005ms-Nf; Thu, 01 Aug 2024 10:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sZWRZ-0005kV-9E
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sZWRX-0006pc-PL
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722521171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9enReR5JuFIrgnsIdk8Cd7I6rD+zZR0rzF/C7cWcVs4=;
 b=AMHDinvXazUGDa5e9RsCGYwAwbtymjfG1uCh8sAMyHZVIkVHUJ5VjWHp3C0CHbBhSyiYxX
 nyfX0952NoKGGO/g86UGvDtoWjKyLCuPShJZ1SK07i5E1gRVCU4TQ5ovCTlEUBrl7ivAwi
 AAn0JQGTt5s4y4tAF+kQSzN39zm6k/Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-fDjmYv-MOCi_ZtfmT_0rYA-1; Thu,
 01 Aug 2024 10:06:06 -0400
X-MC-Unique: fDjmYv-MOCi_ZtfmT_0rYA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D5E01955BFA
 for <qemu-devel@nongnu.org>; Thu,  1 Aug 2024 14:06:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2151E300019E; Thu,  1 Aug 2024 14:06:03 +0000 (UTC)
Date: Tue, 30 Jul 2024 12:53:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio: Allow .get_vhost() without vhost_started
Message-ID: <20240730165345.GA650820@fedora.redhat.com>
References: <20240723163941.48775-1-hreitz@redhat.com>
 <20240723163941.48775-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p4Rs4p5yfkuMd4ZM"
Content-Disposition: inline
In-Reply-To: <20240723163941.48775-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.131, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--p4Rs4p5yfkuMd4ZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 06:39:39PM +0200, Hanna Czenczek wrote:
> Historically, .get_vhost() was probably only called when
> vdev->vhost_started is true.  However, we now decidedly want to call it
> also when vhost_started is false, specifically so we can issue a reset
> to the vhost back-end while device operation is stopped.
>=20
> Some .get_vhost() implementations dereference some pointers (or return
> offsets from them) that are probably guaranteed to be non-NULL when
> vhost_started is true, but not necessarily otherwise.  This patch makes
> all such implementations check all such pointers, returning NULL if any
> is NULL.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/virtio.h  |  1 +
>  hw/display/vhost-user-gpu.c |  2 +-
>  hw/net/virtio-net.c         | 19 +++++++++++++++++--
>  hw/virtio/virtio-crypto.c   | 18 +++++++++++++++---
>  4 files changed, 34 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p4Rs4p5yfkuMd4ZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmapGpkACgkQnKSrs4Gr
c8i36Qf/RKjv4WcB2GA8BlTtC8Vb7vRBpCQJGGp5ScO9ksaTelp9a/ZeYCrNJx7b
vIy0lKWTD6xyZ1Jjf6aO89h5rBvzvuYNEEzVz89N3VtM4oQWzXxD7D1Z/FFYDIQE
WaRTn9qK7H+JB6Vhxs8K02VSC3dj19nEfj2eXhaV6D39MGL9MsZLiga4UgDQq5Xe
8eeYDcO9zF6P7UFMD086fIVgrsdznQ7VSU8gQfnE6MURI7W50iY0DFMhHYmoVVap
Dkuw98BUi/z1oEW1/utCK9LtWchB8nos6ysM+lr1R4pZVJkh7tD2FPDMIU2Pad0/
GqUlr1FpRtIb97CHyESmN29mbnkgWA==
=qE3j
-----END PGP SIGNATURE-----

--p4Rs4p5yfkuMd4ZM--


