Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EADEEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbom-0003uQ-FN; Thu, 12 Feb 2026 13:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbok-0003tH-PK
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqboi-0003zl-5N
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WA/GZLGGPdjr4VlGKYqeIVW4SDLban5i69uc3dY0RA8=;
 b=aICdFAIitXW0hA+Sk5Jw9eT3liuApJdHNpRZT68NRAk5vm+K/2z/P5aaUps0Xozxpg7wyX
 RXfVeIpuU1Rw5tN35hCt3/fEmCWxMToCETSRKsPUReeLV/Mq9xK3mDHUoX4rUGnAXpWRu9
 yFmGS5krXxcqq9LM2XYnoE2fuWg/cHE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-oEKIbTbmOxqqo5iNmPhnUw-1; Thu,
 12 Feb 2026 13:53:29 -0500
X-MC-Unique: oEKIbTbmOxqqo5iNmPhnUw-1
X-Mimecast-MFC-AGG-ID: oEKIbTbmOxqqo5iNmPhnUw_1770922408
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35C1B19560A7; Thu, 12 Feb 2026 18:53:28 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E93830001B9; Thu, 12 Feb 2026 18:53:26 +0000 (UTC)
Date: Wed, 11 Feb 2026 15:28:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 1/7] aio-posix: enable 128-byte SQEs
Message-ID: <20260211202853.GA234157@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-2-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9pKd5KNZSIZtzHPQ"
Content-Disposition: inline
In-Reply-To: <20260207120901.17222-2-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--9pKd5KNZSIZtzHPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 08:08:55PM +0800, Brian Song wrote:
> This patch enables the IORING_SETUP_SQE128 flag during io_uring
> initialization to support the FUSE protocol requirements.
>=20
> The FUSE-over-io_uring implementation embeds a protocol-specific
> structure directly into the Submission Queue Entry (SQE)
> to pass metadata such as the queue ID and commit ID.
>=20
> Enabling SQE128 expands the SQE size to 128 bytes, providing 80 bytes
> of available command space. This ensures sufficient room for the FUSE
> headers and future protocol extensions.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  util/fdmon-io_uring.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9pKd5KNZSIZtzHPQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmM5oUACgkQnKSrs4Gr
c8iGmwgAxvUWGMIwt0t8TPBk3P764pzb0ZbqDwK8YuqSkgzSHCJPS0XzGwopTThC
8fjjr03CoBA0tovRSBhTxNtVJHDKemU4oZnyFpiUn/VIfaBCS+YiDp0mjy5wWEY0
J+yuEnyDqtAvDQSrQ5hUYUOloTOhhJVQWvKOr04s1cELwfz4esqqPBE6pr0BnOzB
x8gyUDStgs1/dzGwR3aMpxgOMU8EoofgiHmsYMfC3WGkRwbHQhHJFq0A5/wGH2AW
n6vnU4cj4vVu3rwARuD2run0K8345G5QC/Lh1xkWbEA6A2weOHKjVuDOOdpnPMXo
g7v9I+QVT6QuKxpUvC/cddS/0mMaog==
=qWel
-----END PGP SIGNATURE-----

--9pKd5KNZSIZtzHPQ--


