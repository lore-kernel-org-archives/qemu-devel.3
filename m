Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DD3C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXea-0006hR-Nr; Thu, 01 May 2025 13:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uAXeX-0006f7-4K
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uAXeS-0003mK-TW
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746120286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwObnzzThY3+zonLKz3VC2JUpgLaHKlX4Qb+c5J1LHQ=;
 b=A4Vx69NBQ9kW9SJvs3BWTtPRZfKS4sZP3juYqPNKjM0x2oZiil/LWUJYeRLVBJQOaPy24A
 4dsZqYN11oOZWiiAI07RDXpFQNccFT9EUCI5pXOTUaL3GrHahws1rxzlNTbl4uD08m9Rfp
 FYqMtrYi7LeCjvfY4pb8rR1DUaXl0jg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-MpQVhCwnNeGB6SYQsWCGLw-1; Thu,
 01 May 2025 13:24:41 -0400
X-MC-Unique: MpQVhCwnNeGB6SYQsWCGLw-1
X-Mimecast-MFC-AGG-ID: MpQVhCwnNeGB6SYQsWCGLw_1746120280
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 151CE180087B; Thu,  1 May 2025 17:24:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAF4C19560AD; Thu,  1 May 2025 17:24:38 +0000 (UTC)
Date: Thu, 1 May 2025 13:24:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 04/11] block: Add new bdrv_co_is_all_zeroes() function
Message-ID: <20250501172437.GE99177@fedora>
References: <20250425005439.2252467-13-eblake@redhat.com>
 <20250425005439.2252467-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZmkU+vxBg3EgNRLk"
Content-Disposition: inline
In-Reply-To: <20250425005439.2252467-17-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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


--ZmkU+vxBg3EgNRLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 07:52:04PM -0500, Eric Blake wrote:
> There are some optimizations that require knowing if an image starts
> out as reading all zeroes, such as making blockdev-mirror faster by
> skipping the copying of source zeroes to the destination.  The
> existing bdrv_co_is_zero_fast() is a good building block for answering
> this question, but it tends to give an answer of 0 for a file we just
> created via QMP 'blockdev-create' or similar (such as 'qemu-img create
> -f raw').  Why?  Because file-posix.c insists on allocating a tiny
> header to any file rather than leaving it 100% sparse, due to some
> filesystems that are unable to answer alignment probes on a hole.  But
> teaching file-posix.c to read the tiny header doesn't scale - the
> problem of a small header is also visible when libvirt sets up an NBD
> client to a just-created file on a migration destination host.
>=20
> So, we need a wrapper function that handles a bit more complexity in a
> common manner for all block devices - when the BDS is mostly a hole,
> but has a small non-hole header, it is still worth the time to read
> that header and check if it reads as all zeroes before giving up and
> returning a pessimistic answer.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v3: Use constant 128k as maximum data header size to read [Stefan]
> ---
>  include/block/block-io.h |  2 ++
>  block/io.c               | 62 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZmkU+vxBg3EgNRLk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgTrlUACgkQnKSrs4Gr
c8iwCggAyc9lVIprzjC1zC/+Q8xzLgxrESnwtrKJmzY2Ru+GyDEVd5bWwDVdV/6/
FKgaeSCo6KUz3ZkoNI6ZqPJhFbYFiLXbwqEUl9/G943hBNK50dspHK0zx3BAbClM
QDJaC+CxvXP4QULhuB9Fkh76BiCpTaKrLBDyR3p+osREwX9Chbm4Yxs0tfXqmid3
bgelFE+hnlVby8ePmV5Xcm5+yamzrAZUvwul8tdyxC3au3Z7Sx92gKiwDLCOuW9X
J4vEQ/nRfWCdL5iwiDdc6XO9lZit0w23odOA75o+gteUTe5oW0/+rFuhK6M8GzoW
iCHRHIvOCDNF443Lw1NF7UcZ6Ue63w==
=wlfo
-----END PGP SIGNATURE-----

--ZmkU+vxBg3EgNRLk--


