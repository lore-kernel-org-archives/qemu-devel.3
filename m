Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4867CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 18:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6YYp-0007ao-VW; Wed, 08 Oct 2025 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YYo-0007af-8U
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YYb-00082P-VX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759946787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dRZM0gWyUaghq4QJOhOiqvtZZEcG0Sgzuf4BeVinvVM=;
 b=ASdPCRM/Xs0jjJ29UV9/3aCmdarM+nITPCKGFs21c3dold1T4IU1JHKsefXuIYOLr1Gl4x
 ChDoTvHgZviM7hALIpzcIL6S1gjLchmxTmGzlrzTzU63/mOmSh59fDsy1R6nSffYEf84eb
 7DCcZ2v3yXawGVw9cdJKZY0Y0fEXlns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-xHkpMILgNISTh0KQqPBKbg-1; Wed,
 08 Oct 2025 14:06:21 -0400
X-MC-Unique: xHkpMILgNISTh0KQqPBKbg-1
X-Mimecast-MFC-AGG-ID: xHkpMILgNISTh0KQqPBKbg_1759946777
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEDDB1800292; Wed,  8 Oct 2025 18:06:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBFBB3000198; Wed,  8 Oct 2025 18:06:15 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:06:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 3/6] tracetool: "import annotations"
Message-ID: <20251008180614.GD181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UbmlT02X1TGU5C/3"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--UbmlT02X1TGU5C/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:42AM +0200, Paolo Bonzini wrote:
> In preparations for adding type annotations, make Python process them laz=
ily.
>=20
> This avoids the need to express some annotations as strings.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool.py                         | 2 ++
>  scripts/tracetool/__init__.py                | 2 ++
>  scripts/tracetool/backend/__init__.py        | 2 ++
>  scripts/tracetool/backend/dtrace.py          | 2 ++
>  scripts/tracetool/backend/ftrace.py          | 2 ++
>  scripts/tracetool/backend/log.py             | 2 ++
>  scripts/tracetool/backend/simple.py          | 2 ++
>  scripts/tracetool/backend/syslog.py          | 2 ++
>  scripts/tracetool/backend/ust.py             | 2 ++
>  scripts/tracetool/format/__init__.py         | 2 ++
>  scripts/tracetool/format/c.py                | 2 ++
>  scripts/tracetool/format/d.py                | 2 ++
>  scripts/tracetool/format/h.py                | 2 ++
>  scripts/tracetool/format/log_stap.py         | 2 ++
>  scripts/tracetool/format/rs.py               | 2 ++
>  scripts/tracetool/format/simpletrace_stap.py | 2 ++
>  scripts/tracetool/format/stap.py             | 2 ++
>  scripts/tracetool/format/ust_events_c.py     | 2 ++
>  scripts/tracetool/format/ust_events_h.py     | 2 ++
>  19 files changed, 38 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UbmlT02X1TGU5C/3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmqBYACgkQnKSrs4Gr
c8j3yAf+IjTkGzyJ5XAGDF7fg3no/Lz6ZYroEqtYLLmrVkZodwk0yb3cK9zBMFkR
nbLuYjxGwBybwETc37yc6OCUzArY2DFSbpPvdW+k2aTyq4kNlZi0nzU1C0n8Y0JR
1wYc9ylOYvV+JHLY8oIDWKIcogzykFS6mNd1kXRYwqyavoAqmrb/2IrWU3jKGf5s
gjG9Ja2Ek4E8FjmLz/c9O+zWHrV2RJ36Oa9akcnnBKPodlOvsxVTUIg3bfJd7ePK
tvYAMBQo+1Z8Q/xAHOKifzitX2O/VIUuPwBmGqmdesBGq7mpTPT++q/UnYaDizCB
1QP7gQl6l/OuxXxUXTEOORN9faknfQ==
=MKyT
-----END PGP SIGNATURE-----

--UbmlT02X1TGU5C/3--


