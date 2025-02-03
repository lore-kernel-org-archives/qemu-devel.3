Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC2AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1WV-0000Ku-4I; Mon, 03 Feb 2025 13:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1WT-0000KO-Aa
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1WR-0005Ni-VN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6CB3SqSzv+Pdo0+mqSw/6Mj8G3HaWXg7qNxRej0FAPI=;
 b=NAeS0N8mWRwJ7ASc4nAoNaneN6N31l8p+/DjnRfFMNakA/N6ZOhF64vLE9aaVw9JfsZQtH
 xo5FLQT/K/GjSop6N7bXOiGmbtvl1NK6HHB4SD10CE+awoA5mejBl1hTmue/VQZSSeIxJq
 9oP/wCr6Qfjg48R1TUUldqWASAPWM0I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-wO4ZsJOgNSaWCzmocqv-4Q-1; Mon,
 03 Feb 2025 13:50:11 -0500
X-MC-Unique: wO4ZsJOgNSaWCzmocqv-4Q-1
X-Mimecast-MFC-AGG-ID: wO4ZsJOgNSaWCzmocqv-4Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1C151801F21; Mon,  3 Feb 2025 18:50:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F04AB30001BE; Mon,  3 Feb 2025 18:50:09 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:50:08 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/15] block: Don't attach inactive child to active node
Message-ID: <20250203185008.GF268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YPYU0bSS0kXX+7M+"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-5-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--YPYU0bSS0kXX+7M+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:35PM +0100, Kevin Wolf wrote:
> An active node makes unrestricted use of its children and would possibly
> run into assertion failures when it operates on an inactive child node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YPYU0bSS0kXX+7M+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehD+AACgkQnKSrs4Gr
c8gIVwgAsd8NHX3BbGMbN2VfiVtlS/turslumD5HDLj7UQvMBHolmUDqRIJz20jg
Iy6tDVZHVRkqP9OYuqPymF1Xi1gclSQzvY5kLl563iUgdmYaY6qDIuCZqDi9Mzm5
4ZBOhieIjfWREuMTeXJmdSAJFPD0WlfCGfeosqrL0W4y92eN+xLKfUvDukvaCnhd
WwecfE3l+fYNYwTXdMtQLibgHXtaNYScirIyfxEi+tVwgwWsU0PWpVAkDh+W+raQ
SzChumSvyz/OF5okuDZsFvD6GGMCZeve7BRQTWAaA8lnqRGh8isHgM0je0wD9beW
WG7AUGWGuA6K+R/+VeOKzqDkiSKvQg==
=Qm8M
-----END PGP SIGNATURE-----

--YPYU0bSS0kXX+7M+--


