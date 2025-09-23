Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53878CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 18:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v17JB-0006PR-FN; Tue, 23 Sep 2025 14:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v17J9-0006PD-LE
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v17J5-0003ZW-A6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758650402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eacQxv6pgrHdboqFFU3dcqFS04smjIBxLfh6YOLugaU=;
 b=JGrCOO9LeNssSt5ZmNJ+1+K6FIxGT17LYIeol5bd1hA87E9eslfRP1W8ia0VGfi5jJZ7S2
 jxkGxM49N8BoKomDyaexnNk3mzzMsUV7MhDxY1dwNUYScy89sXb4CMLb2NHx4IzJxMStv0
 DVpEE3qF+Yhy2SW7v3d/uC5MhKi1l8k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-F2Xh0YGKP9muvRbO5bQ_7g-1; Tue,
 23 Sep 2025 14:00:00 -0400
X-MC-Unique: F2Xh0YGKP9muvRbO5bQ_7g-1
X-Mimecast-MFC-AGG-ID: F2Xh0YGKP9muvRbO5bQ_7g_1758650399
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C42E1800577; Tue, 23 Sep 2025 17:59:59 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7742D1955F19; Tue, 23 Sep 2025 17:59:58 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:59:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition
 to DCO
Message-ID: <20250923175957.GD509965@fedora>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sYSeXdabDD4a1k8m"
Content-Disposition: inline
In-Reply-To: <20250922154843.60233-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--sYSeXdabDD4a1k8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 05:48:42PM +0200, Paolo Bonzini wrote:
> Using phrasing from https://openinfra.org/legal/ai-policy (with just
> "commit" replaced by "submission", because we do not submit changes
> as commits but rather emails), clarify that the contributor remains
> responsible for its copyright or license status.
>=20
> [This is not my preferred phrasing.  I would prefer something lighter
> like "the "Signed-off-by" label in the contribution gives the author
> responsibility".  But for the sake of not reinventing the wheel I am
> keeping the exact words from the OpenInfra policy.]
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sYSeXdabDD4a1k8m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS4BwACgkQnKSrs4Gr
c8gWeAf+IMZtwZl4OGRW8MmUVTKPUHn9R5jdKnA7Kh/gvoidvaCrvdyVor2eXqqP
rEhszfJtoxrvOUmEZWiEWn3oXjNMZi2Wsn//Z06C8lG5takl5lXJAjlkt21ZQL7L
FMXgO/MiW6VIktnlDloVJ11Clh/BVXeTjnqxiinXsv19qQJZhtx7gt1KY19gWbqu
odnnH8Yoq7ZTYUM1/j+1pSLHMuY1Hv9go397I5F4246wLqWNL1j1ZI97AFXL1qcK
WS1o6vqrgRTLqXqXDIRv/4wWGOyoymiDa9lbOlZYqwGr8YTQpvr0snJWaM9K+5dj
x/WCVfVljwaD9Oi+CW42SA23LDy3+Q==
=aj03
-----END PGP SIGNATURE-----

--sYSeXdabDD4a1k8m--


