Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B9C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5W1j-00005O-Nn; Thu, 17 Apr 2025 16:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5W1i-0008WO-NJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5W1g-0004ld-L3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744922399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P9YJx4n2EopSzFLdz9XqkfgsKejePOIIVdlFCF28cs8=;
 b=WAdIh6ecaR+x1Crrj3VeyzIEvJEUjsphXuOoUNXJf2YkDoip2ZlGeGwsQ3McIb6EwB/hEk
 BbFCyaIWHrZC2WOZ7VT+8cPOsnpoeID4xpvmdBsawilCZNgq+o1Px8OBLJ/2izRlIaj4+/
 S0668Yvd6eoYsHXcihnKG5JalEO74yE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-1LVqJUnjN86j_VEhfGnumA-1; Thu,
 17 Apr 2025 16:39:55 -0400
X-MC-Unique: 1LVqJUnjN86j_VEhfGnumA-1
X-Mimecast-MFC-AGG-ID: 1LVqJUnjN86j_VEhfGnumA_1744922395
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D51A1945CB3; Thu, 17 Apr 2025 20:39:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1AC4180094C; Thu, 17 Apr 2025 20:39:47 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:39:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 05/11] iotests: Improve iotest 194 to mirror data
Message-ID: <20250417203946.GD85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-18-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="biN0tLixsb0Hvy6B"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-18-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--biN0tLixsb0Hvy6B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:10PM -0500, Eric Blake wrote:
> Mirroring a completely sparse image to a sparse destination should be
> practically instantaneous.  It isn't yet, but the test will be more
> realistic if it has some non-zero to mirror as well as the holes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/194 | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--biN0tLixsb0Hvy6B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBZxIACgkQnKSrs4Gr
c8iTdQgAsTFdxj3OK8qCr5obBZ7eyBD2ZjPdt5unRm6D60s7ka8KQShkTuWpxhi2
AK7iAHclSP6vj7VK6KCwqkKf4S+u5rvIyjEb6V/5RBP6qQqPR3wO2Ilwxl2Z5Nng
kkZpdc6lGnLmn+xEb5sdrC/xH0a9AQosXsbRpEgBKpkwhYpmOWlvxWOFzv61nqcO
6grUzycwWAUbYyglahLR2om7XxUuGcZttlNEljgnsCna+2BP5/nmiG1LsnU/QCEu
FKffMkQB/5o30lk+9BVEr6XhMEAux2IUWeXp2MG2TDjkBZ4MNRAdOCuCkzdTVAS7
eT+Ag/9BW0FouVtbMdfARiF4wbpHQw==
=Sx81
-----END PGP SIGNATURE-----

--biN0tLixsb0Hvy6B--


