Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26DAC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOkq-0004Rj-Qd; Tue, 06 Feb 2024 11:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXOko-0004RN-VR
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:57:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXOkn-0008Mn-JD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707238620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ztxho7oBB6inUtD3Sj7SmQfF6+CBLGoyXGPsDrDKIP8=;
 b=NxR9OrL9iAOi9I0jpRFrhaIiR4+7EwSmD96zumvrc8Gq3+0E/+DD74N2v6wOebP+DGCPMY
 zGYmkCAnjYFYxPjZOLxlrywm1YJBAn0Lw3uN3rTy4lgQaFX67DKHe1mrgZPZrMnFe63dSl
 VrveVBUJUz3tcFTkgzPZUzGXj90b4Ds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-oxWs2-kBNs2RN7PGlSGVNw-1; Tue, 06 Feb 2024 11:56:57 -0500
X-MC-Unique: oxWs2-kBNs2RN7PGlSGVNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 996E184ACA5;
 Tue,  6 Feb 2024 16:56:56 +0000 (UTC)
Received: from localhost (unknown [10.39.195.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4BD01C060AF;
 Tue,  6 Feb 2024 16:56:55 +0000 (UTC)
Date: Tue, 6 Feb 2024 11:56:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 2/2] scsi: Await request purging
Message-ID: <20240206165654.GD66397@fedora>
References: <20240202144755.671354-1-hreitz@redhat.com>
 <20240202144755.671354-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x3y+hhpOs+HwHZNX"
Content-Disposition: inline
In-Reply-To: <20240202144755.671354-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--x3y+hhpOs+HwHZNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 03:47:55PM +0100, Hanna Czenczek wrote:
> scsi_device_for_each_req_async() currently does not provide any way to
> be awaited.  One of its callers is scsi_device_purge_requests(), which
> therefore currently does not guarantee that all requests are fully
> settled when it returns.
>=20
> We want all requests to be settled, because scsi_device_purge_requests()
> is called through the unrealize path, including the one invoked by
> virtio_scsi_hotunplug() through qdev_simple_device_unplug_cb(), which
> most likely assumes that all SCSI requests are done then.
>=20
> In fact, scsi_device_purge_requests() already contains a blk_drain(),
> but this will not fully await scsi_device_for_each_req_async(), only the
> I/O requests it potentially cancels (not the non-I/O requests).
> However, we can have scsi_device_for_each_req_async() increment the BB
> in-flight counter, and have scsi_device_for_each_req_async_bh()
> decrement it when it is done.  This way, the blk_drain() will fully
> await all SCSI requests to be purged.
>=20
> This also removes the need for scsi_device_for_each_req_async_bh() to
> double-check the current context and potentially re-schedule itself,
> should it now differ from the BB's context: Changing a BB's AioContext
> with a root node is done through bdrv_try_change_aio_context(), which
> creates a drained section.  With this patch, we keep the BB in-flight
> counter elevated throughout, so we know the BB's context cannot change.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x3y+hhpOs+HwHZNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCZNYACgkQnKSrs4Gr
c8jmfAf+MlOnPD9UT/LFzfN9+2d8kruKUFc/VL6EPgpXnC5qfxde0wWiWOJC/xLp
h9czpC1EaTqVTvacjK5fsQQXX68knvITgbig48AWH3/tF+0eg3hSVTWWPLYzZuaz
Aa5JzyZloNaPWPXd0E1Tufs1H+47WE2zACQg3gROcitQRqJpskT1zTg4sM5g4Wds
lStjLnkta6isF7KChVkdFpPt4my3kZvVs0nbBa6LwmHc3kiBgDFlZ97csX0PVPFz
K3Mc8K3EU5r1/odoYpEEtQFh3Lm6/GCaJLK4Gw8vndmK2ggmW65FEMrEmsl9xzVo
/AQfuUxQ1yV5ZYYDo/UJN9giRo/KTw==
=9z9H
-----END PGP SIGNATURE-----

--x3y+hhpOs+HwHZNX--


