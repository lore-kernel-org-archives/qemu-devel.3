Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EECFC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOgwp-0003ap-Fj; Mon, 09 Jun 2025 14:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOgwl-0003aL-Vt
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOgwj-0001gf-Dj
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749492607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIY90yziHLVJVB/PrA7doeBgszGfUm8aDQJ3AJp6LkU=;
 b=ITWmm4y9j/P/K2npf+m7yoVbknbLKHNgANyIDXrSb2hw7hFVSk/2wRjh6A8n+A40OFkv0/
 10AtT6H/7s/dZO5Qb/2taHY1mhuD0EBp+yPlI/2KwJvq7gIguTZ3nKWREf01jMrDWto6YL
 JAP99hStGct1/8e4pV/iUstyAbLm0GM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-uO_lEH95N5mXTWXh9sGKEw-1; Mon,
 09 Jun 2025 14:10:05 -0400
X-MC-Unique: uO_lEH95N5mXTWXh9sGKEw-1
X-Mimecast-MFC-AGG-ID: uO_lEH95N5mXTWXh9sGKEw_1749492604
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C2561956095; Mon,  9 Jun 2025 18:10:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36C9319560AB; Mon,  9 Jun 2025 18:10:02 +0000 (UTC)
Date: Mon, 9 Jun 2025 14:10:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 18/21] fuse: Implement multi-threading
Message-ID: <20250609181001.GJ29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-19-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6TcR3qrKPcoiybd0"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-19-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--6TcR3qrKPcoiybd0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:10PM +0200, Hanna Czenczek wrote:
> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>=20
> We can use this to implement multi-threading.
>=20
> For configuration, we don't need any more information beyond the simple
> array provided by the core block export interface: The FUSE kernel
> driver feeds these FDs in a round-robin fashion, so all of them are
> equivalent and we want to have exactly one per thread.
>=20
> These are the benchmark results when using four threads (compared to a
> single thread); note that fio still only uses a single job, but
> performance can still be improved because of said round-robin usage for
> the queues.  (Not in the sync case, though, in which case I guess it
> just adds overhead.)
>=20
> file:
>   read:
>     seq aio:   264.8k =B10.8k (+120 %)
>     rand aio:  143.8k =B10.4k (+ 27 %)
>     seq sync:   49.9k =B10.5k (-  5 %)
>     rand sync:  10.3k =B10.1k (-  1 %)
>   write:
>     seq aio:   226.6k =B12.1k (+184 %)
>     rand aio:  225.9k =B11.8k (+186 %)
>     seq sync:   36.9k =B10.6k (- 11 %)
>     rand sync:  36.9k =B10.2k (- 11 %)
> null:
>   read:
>     seq aio:   315.2k =B111.0k (+18 %)
>     rand aio:  300.5k =B110.8k (+14 %)
>     seq sync:  114.2k =B1 3.6k (-16 %)
>     rand sync: 112.5k =B1 2.8k (-16 %)
>   write:
>     seq aio:   222.6k =B16.8k (-21 %)
>     rand aio:  220.5k =B16.8k (-23 %)
>     seq sync:  117.2k =B13.7k (-18 %)
>     rand sync: 116.3k =B14.4k (-18 %)
>=20
> (I don't know what's going on in the null-write AIO case, sorry.)
>=20
> Here's results for numjobs=3D4:
>=20
> "Before", i.e. without multithreading in QSD/FUSE (results compared to
> numjobs=3D1):
>=20
> file:
>   read:
>     seq aio:   104.7k =B1 0.4k (- 13 %)
>     rand aio:  111.5k =B1 0.4k (-  2 %)
>     seq sync:   71.0k =B113.8k (+ 36 %)
>     rand sync:  41.4k =B1 0.1k (+297 %)
>   write:
>     seq aio:    79.4k =B10.1k (-  1 %)
>     rand aio:   78.6k =B10.1k (=B1  0 %)
>     seq sync:   83.3k =B10.1k (+101 %)
>     rand sync:  82.0k =B10.2k (+ 98 %)
> null:
>   read:
>     seq aio:   260.5k =B11.5k (-  2 %)
>     rand aio:  260.1k =B11.4k (-  2 %)
>     seq sync:  291.8k =B11.3k (+115 %)
>     rand sync: 280.1k =B11.7k (+115 %)
>   write:
>     seq aio:   280.1k =B11.7k (=B1  0 %)
>     rand aio:  279.5k =B11.4k (-  3 %)
>     seq sync:  306.7k =B12.2k (+116 %)
>     rand sync: 305.9k =B11.8k (+117 %)
>=20
> (As probably expected, little difference in the AIO case, but great
> improvements in the sync case because it kind of gives it an artificial
> iodepth of 4.)
>=20
> "After", i.e. with four threads in QSD/FUSE (now results compared to the
> above):
>=20
> file:
>   read:
>     seq aio:   193.3k =B1 1.8k (+ 85 %)
>     rand aio:  329.3k =B1 0.3k (+195 %)
>     seq sync:   66.2k =B113.0k (-  7 %)
>     rand sync:  40.1k =B1 0.0k (-  3 %)
>   write:
>     seq aio:   219.7k =B10.8k (+177 %)
>     rand aio:  217.2k =B11.5k (+176 %)
>     seq sync:   92.5k =B10.2k (+ 11 %)
>     rand sync:  91.9k =B10.2k (+ 12 %)
> null:
>   read:
>     seq aio:   706.7k =B12.1k (+171 %)
>     rand aio:  714.7k =B13.2k (+175 %)
>     seq sync:  431.7k =B13.0k (+ 48 %)
>     rand sync: 435.4k =B12.8k (+ 50 %)
>   write:
>     seq aio:   746.9k =B12.8k (+167 %)
>     rand aio:  749.0k =B14.9k (+168 %)
>     seq sync:  420.7k =B13.1k (+ 37 %)
>     rand sync: 419.1k =B12.5k (+ 37 %)
>=20
> So this helps mainly for the AIO cases, but also in the null sync cases,
> because null is always CPU-bound, so more threads help.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 205 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 159 insertions(+), 46 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6TcR3qrKPcoiybd0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhHI3kACgkQnKSrs4Gr
c8jbJgf/UOkkds9x1k4wSyDs57952x9lobHWMWZiAZORHSQ+smhO+11ARRQckd+L
hHsCJ7yXy/x7qefLUmApmhCbwR32i2iA6iTyx/XhuRJ3yKxnIdbpoxXhCTsmvZ6d
6qLA5fZJkalntvkXFupPylDfp+nayPL1HqhEIKhvywUD/ciaI9FwmjtNSFdOV1xw
XXs7wcL0J+5hDj6Iup1ay6fpEBIJ/thKn23X4r5Ja4Vg1ToK0WAMsO3ZSj9NDDWs
yyv+WIkttvOTiHWbovVv14OfJPkfye2+eJKZoyNcLhPt/qWo2r1jA1N8UZgcefeI
TMU/NiMqD7j74ztk6HsIb3uaOretkQ==
=I2M3
-----END PGP SIGNATURE-----

--6TcR3qrKPcoiybd0--


