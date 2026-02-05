Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CFBEE0AF3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 19:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voncH-0002Gm-NI; Sat, 07 Feb 2026 14:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1voncF-0002GM-T9
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 14:05:11 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1voncD-0006bT-OZ
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 14:05:11 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E2264140012A;
 Sat,  7 Feb 2026 14:05:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 14:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1770491106; x=1770577506; bh=mPG0KY30mW
 w3W52DZtGDNiriHYSuSa8tAbBCoHI4l/c=; b=jSvn0MuhN0RvlLmEGDV8Hu1SP5
 7km4GdgxWSvtmQ6dGUVIv1/15E6xvn46Icl2vFqewiFgyvaX1kA4ziOvQZ4jIZ5t
 zUdRkQ7/WIhjl2VrK9K8Z8N1E4V6I8vurq6N9cG7mwJZB6h75H79yXeBsEnDickx
 cY1NKMr9LL6hS3mvYnJim09Oz/PLMqWeTcvuk7zIQxdcg50dJJsPD7keFQiQRqMr
 5y+OYmFyPCC5JoWJGJBfMS4HQKVEIc1SjVlSVg8umZpkFvABmHpMLQs2eRfy0tjO
 kaCth8hwcgKD63Y9uScon69dmUSRjetogmrmEJmzw4l6L5XBwjD1//A8JzPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1770491106; x=1770577506; bh=mPG0KY30mWw3W52DZtGDNiriHYSuSa8tAbB
 CoHI4l/c=; b=HDY7E/P47c9c5g0SSSFTQ/FkI2xmghP5Xntb1Caf7Cxor0tmXgk
 IYr4sJaMrB6YbL4NuAPH5COAImN4R2w0hfg09ZIorNnOQPQTzjbLOS2vwUVfnC1r
 1aGNguS0jhMC0O12Fn7nLljKoPCuCl6G23NnyWs9gWKnoiCSu1I7VfAXoLY29Ebj
 58RWb5UEgsyoQR3Z9kKVSZ+nn2fLZnXqAQibkU4eDAKiT31QpUNi6M6F2vWIoXcD
 vToFtY2T3td5W+VxJ0l1Vja6l9y7oEiBqIASos7V/SPqegqaeVt9ELBO/UatdLJi
 pPP+BfZHaYB7BikLm1uuHDIFpxoCdEWbh9A==
X-ME-Sender: <xms:4oyHaSldBtAmkHG2p98kgr5Xd-bc4clmLGbic4R_sE1tuHPI5jOb0w>
 <xme:4oyHafbf523rja_oMqZ9qpng6ZZ3I2N12lVL0PQzkA-BUwbMDmKaoOzaUEaESTD7p
 knb71QghKrT0Q3Gui3QxMD8DOMcGODaPsFRJ7s7qMTVcKNbuJaa3A>
X-ME-Received: <xmr:4oyHaaPnCv6o808c2L7ko9geQGThpX4mbotsctsY-wahF_HfDbnqkgAEuHGyNHSa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledukeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefujghffffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeiudffue
 eilefgtefgtddttdekkeehkefgheekudefveetgeefiefftedvteeuveenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
 hishdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehsthgvvhgvnhhsugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghlvgigrd
 gsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrnhhoshdrphhithhs
 ihguihgrnhgrkhhisheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrghdprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrhes
 lhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuh
 drohhrghdprhgtphhtthhopegrvghsthgvvhgvsehrvgguhhgrthdrtghomhdprhgtphht
 thhopegusggrshhsvgihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrg
 hnghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:4oyHaXdQi7pEN0jbNwWzvffrxVJzPJFcM_5WMzASIVgdUX5QEjiS4w>
 <xmx:4oyHaYFITG1OvLwGCPiw1g8MAuig1DgfdhZOfzDsA_pZtFJnclJ4mg>
 <xmx:4oyHaasQ8ZjKyKGdAqT9ULs4bnr1kw5FnA7CcKFLKMEX1DpUSpQAMw>
 <xmx:4oyHaar4QCtklgUgprB4JJ46cVZSt5C_AAk4RnjlVY8-iHWKGjNkqg>
 <xmx:4oyHaRe0pZX43nPfstmxad0AoHFH3hX9d8eAHZ39NjMRvlniX-156e_1>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 14:05:06 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 6069C73DB08E; Thu, 05 Feb 2026 14:55:17 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, slp@redhat.com, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 manos.pitsidianakis@linaro.org, stevensd@chromium.org, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>,
 stefanha@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v12 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
In-Reply-To: <20260204093758.1250167-4-aesteve@redhat.com>
References: <20260204093758.1250167-1-aesteve@redhat.com>
 <20260204093758.1250167-4-aesteve@redhat.com>
Date: Thu, 05 Feb 2026 14:55:16 +0100
Message-ID: <87a4xnl2gr.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.152; envelope-from=hi@alyssa.is;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Albert Esteve <aesteve@redhat.com> writes:

> Add GET_SHMEM_CONFIG vhost-user frontend
> message to the spec documentation.
>
> Reviewed-by: Alyssa Ross <hi@alyssa.is>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 41 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 6c1d66d7d3..e314313806 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -371,6 +371,22 @@ MMAP request
>    - 0: Pages are mapped read-only
>    - 1: Pages are mapped read-write
>=20=20
> +VIRTIO Shared Memory Region configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+---------+------------+----+--------------+
> +| num regions | padding | mem size 0 | .. | mem size 255 |
> ++-------------+---------+------------+----+--------------+
> +
> +:num regions: a 32-bit number of regions
> +
> +:padding: 32-bit
> +
> +:mem size: an array of 256 64-bit fields representing the size of each
> +           VIRTIO Shared Memory Region. ``num regions`` specifies the
> +           number of valid regions (non-zero size). The array index
> +           corresponds to the shared memory ID (shmid).
> +
>  C structure
>  -----------
>=20=20
> @@ -397,6 +413,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserShared object;
>            VhostUserTransferDeviceState transfer_state;
>            VhostUserMMap mmap;
> +          VhostUserShMemConfig shmem;
>        };
>    } QEMU_PACKED VhostUserMsg;
>=20=20
> @@ -1761,6 +1778,30 @@ Front-end message types
>    Using this function requires prior negotiation of the
>    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
>=20=20
> +``VHOST_USER_GET_SHMEM_CONFIG``
> +  :id: 44
> +  :equivalent ioctl: N/A
> +  :request payload: N/A
> +  :reply payload: ``struct VhostUserShMemConfig``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the front-end
> +  to gather the VIRTIO Shared Memory Region configuration. The back-end =
will
> +  respond with the number of VIRTIO Shared Memory Regions it requires, a=
nd
> +  each shared memory region size in an array. The shared memory IDs are
> +  represented by the array index. The information returned shall comply
> +  with the following rules:
> +
> +  * The shared information will remain valid and unchanged for the entire
> +    lifetime of the connection.
> +
> +  * The Shared Memory Region size must be a multiple of the page size
> +    supported by mmap(2).
> +
> +  * The size may be 0 if the region is unused. This can happen when the
> +    device does not support an optional feature but does support a featu=
re
> +    that uses a higher shmid.

This is still phrased as if unused regions after the last used one can
be ommitted.  If 256 sizes are always sent, then size must be 0 for all
unused regions.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaYShRAAKCRBbRZGEIw/w
op1vAP9BGab1Mv52xrjH8JOaMIgZCWkzqxEQCbpYl2DG7UcPCQD9GKrWTMnQJzlL
9pr0l0Kk+B7YNGFiINupTqXTdz8MYww=
=nzn/
-----END PGP SIGNATURE-----
--=-=-=--

