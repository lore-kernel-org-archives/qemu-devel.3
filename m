Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16335C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCTk-0007dh-Ch; Wed, 30 Jul 2025 15:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhALd-0001NJ-Qw
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhALc-0002hX-A8
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753895531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYinM+MkzJ4b8URPirUoyqbodX7NKVeYC12lYXb/gRw=;
 b=Kp5tGuThFDVd739bT5GMWygQPBeUeN5/t1dcZnNsMsryJasNwZ/H6UijCV4zx63MLDY2VY
 YyXbWywTKSREKMHzmwKsaataqUfbW2HMESZgpVnHzB+J5c399PP16Xf96YgZwpy0Fbn5pd
 +6k2FzXGsjbb20EkCgIEdAaEJOLbjpQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-tnFBjMr8P56NWCknsucJFA-1; Wed,
 30 Jul 2025 13:12:07 -0400
X-MC-Unique: tnFBjMr8P56NWCknsucJFA-1
X-Mimecast-MFC-AGG-ID: tnFBjMr8P56NWCknsucJFA_1753895526
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A111800284; Wed, 30 Jul 2025 17:12:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2468F1800286; Wed, 30 Jul 2025 17:12:05 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:12:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 17/21] iotests/307: Test multi-thread export interface
Message-ID: <20250730171204.GB74304@fedora>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-18-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6aBc8MYW468Ls+hw"
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-18-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--6aBc8MYW468Ls+hw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 01:44:33PM +0200, Hanna Czenczek wrote:
> Test the QAPI interface for multi-threaded exports.  None of our exports
> currently support multi-threading, so it's always an error in the end,
> but we can still test the specific errors.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/307     | 47 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/307.out | 18 +++++++++++++++
>  2 files changed, 65 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6aBc8MYW468Ls+hw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiKUmQACgkQnKSrs4Gr
c8h5Qgf/XmDJoNbQrvJvbId2Z5PL2QIvi+11Oo+lXgQMH3LosF+CIGAHmh+gxy3u
ZGsbxxuiS5BzmPi9OVA7JhPhHpg46QKC2ORn6LZM3mVkWi8PvFLrw20SYDbNFDR4
Sjw0iThU7bNDWAFmthwVrVSan6Sb5vLI+9Al3GvVIkjUTx+ZmFKA0tnWjCMUFs0n
ISYRuxuN+xKDJfywg9YLcKczXV9Z9Bs1VJut+D9aEZWKSM069t9C1fIP0bK1DcMB
ygL+niV9a8goJMW3FzuCd8qp2HR7H1wCsK3KX+fso/qtR6Do1dWwK8pwkafNQTlk
BoF6OwyEewPa2Wk18P009afvDCqMHw==
=ynMf
-----END PGP SIGNATURE-----

--6aBc8MYW468Ls+hw--


