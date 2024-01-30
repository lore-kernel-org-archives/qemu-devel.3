Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FD1C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUvUC-0002Zy-La; Tue, 30 Jan 2024 16:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUvU9-0002Yg-Pk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUvU6-0007oJ-QQ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706649453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWnjwaSD+C36ig0k8XUXFoOr4IP1u4Bf377LRcKVObE=;
 b=RnfsusFBf23IkjBU/ZpTGk/mzHzcg2l/HxjE3HLqYCF9f0g69Cl8KK6GEzWTJC+mQj4eXo
 DCLM8z+HZthXDVqIFZ9t6WINW5twS4R7Y5LNuD3F494gHw6ZOFcc+jlzaU/Av1CNd3OTrA
 4LYW+HfHzchEETtlkI7QRAdooSYGCl8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-y8UofHOTM5GHOmY0dOhOjw-1; Tue,
 30 Jan 2024 16:17:31 -0500
X-MC-Unique: y8UofHOTM5GHOmY0dOhOjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8212D1C04332;
 Tue, 30 Jan 2024 21:17:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083B2492BE2;
 Tue, 30 Jan 2024 21:17:30 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:17:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH v2] block/blkio: Make s->mem_region_alignment be 64 bits
Message-ID: <20240130211729.GC320474@fedora>
References: <20240130122006.2977938-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lvBf1NCUIUtCuxln"
Content-Disposition: inline
In-Reply-To: <20240130122006.2977938-1-rjones@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--lvBf1NCUIUtCuxln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:20:01PM +0000, Richard W.M. Jones wrote:
> With GCC 14 the code failed to compile on i686 (and was wrong for any
> version of GCC):
>=20
> ../block/blkio.c: In function =E2=80=98blkio_file_open=E2=80=99:
> ../block/blkio.c:857:28: error: passing argument 3 of =E2=80=98blkio_get_=
uint64=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-type=
s]
>   857 |                            &s->mem_region_alignment);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                            |
>       |                            size_t * {aka unsigned int *}
> In file included from ../block/blkio.c:12:
> /usr/include/blkio.h:49:67: note: expected =E2=80=98uint64_t *=E2=80=99 {=
aka =E2=80=98long long unsigned int *=E2=80=99} but argument is of type =E2=
=80=98size_t *=E2=80=99 {aka =E2=80=98unsigned int *=E2=80=99}
>    49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t =
*value);
>       |                                                         ~~~~~~~~~=
~^~~~~
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  block/blkio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--lvBf1NCUIUtCuxln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW5Z2kACgkQnKSrs4Gr
c8icVAf/ZlDzVd4uy3HTksSNfH+dGu1ghl0Utdou882hXUwKJgTuKmSFGsmxOo5j
Au1f8czZA3wwLEUmPNuKGSVq8NZ2wswmKZzXzOzaG47BZ+q7E4BTBwPeA5b3sOu6
VxVw4gDavcnV9wfuVCBZXazQffFgYJdYRz4agBJx12CaATVK7+kyydVKp1KJubnT
s6pqn7ckCOsWJJromNjWlN87Ao4GaHZJgMJsDhUbL0SLNzt3ngDmq+gCgqGRbh2l
kaCJpAhtgl9OW9if7m54Hm9UC/EQLK2kMLi7tuRoABFYma8Z0bCpkEVxk/RBo2pT
0JyhiSfKQ2V1qxcdC9jREA4duq5edQ==
=kuDk
-----END PGP SIGNATURE-----

--lvBf1NCUIUtCuxln--


