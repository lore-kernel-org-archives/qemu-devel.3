Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EABCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 17:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v17Hp-0003pK-Dy; Tue, 23 Sep 2025 13:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v17Hn-0003n2-0e
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 13:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v17Hj-0003Hp-08
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 13:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758650312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=svf0TTqxjoBEdj/rDDy8hPRqa3QnBg6O5aGsfeXUVzY=;
 b=g2Jcbo1VE6vja3jb/KQzD4eahrqt+jrlAjBNNNXUQdZftttNZVHEDl4/63rHcXyu6qsbiL
 NtbS7umhQRJkxnRjQP4VINP6gsOjRYK0JAv7EAUNL3wCm2p4jnWpflepnimK5OGEmrV/ZS
 CWQO9dHusqifwNii79ozdzzVqveIgLM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-P_OM-tSINJaBIY4cM6U5KQ-1; Tue,
 23 Sep 2025 13:58:28 -0400
X-MC-Unique: P_OM-tSINJaBIY4cM6U5KQ-1
X-Mimecast-MFC-AGG-ID: P_OM-tSINJaBIY4cM6U5KQ_1758650308
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C13B1195608C; Tue, 23 Sep 2025 17:58:27 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CE8D300018D; Tue, 23 Sep 2025 17:58:27 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:58:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/3] docs/code-provenance: make the exception process
 more prominent
Message-ID: <20250923175826.GB509965@fedora>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y2IDlzQMWZkpdJPE"
Content-Disposition: inline
In-Reply-To: <20250922154843.60233-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Y2IDlzQMWZkpdJPE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 05:48:41PM +0200, Paolo Bonzini wrote:
> QEMU's AI generated content policy does not flesh out the exception
> process yet.  Do it, while at the same time keeping things informal: ask
> contributors to explain what they would like to use AI for, and let them
> reach a consensus with the project on why it is credible to claim DCO
> compliance in that specific scenario.
>=20
> In other words, exceptions do not "solve the AI copyright problem".  They
> take a position that a reasonable contributor could have, and assert that
> we're comfortable with the argument.
>=20
> Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index dba99a26f64..103e0a97d76 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -326,8 +326,13 @@ The QEMU project thus requires that contributors ref=
rain from using AI content
>  generation agents which are built on top of such tools.
> =20
>  This policy may evolve as AI tools mature and the legal situation is
> -clarifed. In the meanwhile, requests for exceptions to this policy will =
be
> -evaluated by the QEMU project on a case by case basis. To be granted an
> -exception, a contributor will need to demonstrate clarity of the license=
 and
> -copyright status for the tool's output in relation to its training model=
 and
> -code, to the satisfaction of the project maintainers.
> +clarified.
> +
> +Exceptions
> +^^^^^^^^^^
> +
> +The QEMU project welcomes discussion on any exceptions to this policy,
> +or more general revisions. This can be done by contacting the qemu-devel
> +mailing list with details of a proposed tool, model, usage scenario, etc.
> +that is beneficial to QEMU, while still mitigating the legal risks to the
> +project.  After discussion, any exception will be listed below.

"Legal risks to the project" is all-encompassing and vague. People may
not know how to start addressing the topic and might therefore not
attempt to request an exception.

I suggest replacing "legal risks to the project" with something more
concrete like "issues around license and copyright status required to
satisfy the Developer Certificate of Origin (DCO) requirements".

> --=20
> 2.51.0
>=20

--Y2IDlzQMWZkpdJPE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS38EACgkQnKSrs4Gr
c8jm2wf/bYYsxujMp71GCOU8Hr8OoXDRZN6BD2Jlb/JeXMGrFY4CbR+XJm8/ogm6
jHFX64QUtuzNF+0T8bAdMuhWYPRu8LA0J0hFVzLRZGhmsJjmxqyOEmZV5RYO5ARi
jtmeOfYitGOvmy6zMzyiaCu6iEmkP1HjCqapCX8BOj4cLKqg6RSwZsJWAgqzterA
3tbD1D0CZzWqlmhGW3FRq4byVzgUg9cwaAIYhc8yOvjf3NfjGhxDqrT+Q67JsLAu
w5FEeODMRkIdYG95UBAhJ7avGKNL6NDC9LYWUv4ZukhfYWCD+17GSwB1gMWA58YB
963OULzPatfcjWxmUPxszKhvb34Vfw==
=p/oS
-----END PGP SIGNATURE-----

--Y2IDlzQMWZkpdJPE--


