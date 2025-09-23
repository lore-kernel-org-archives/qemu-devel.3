Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20447CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 17:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v17Hq-0003pc-Cl; Tue, 23 Sep 2025 13:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v17Hn-0003ng-Ta
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 13:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v17Hj-0003Jj-Pn
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 13:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758650318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6dt0WK7X/t+kzGUWVf2rXxcbie0XrHsG8meIrCOUJo=;
 b=hEh4jF1VvLnF8l770f9t72F/eoHCpHCLHneOVhGnV8tu1Upv+98N8jnVo7jU6DRcdKojuw
 Uw8CZFj0F9TlJVY2KX3cz02YxGn02i+3HwP/x0WXSA7cNxnbulDnhwLnPP8x3CF79IuIR6
 HQlqAat/jlEk2WfJv70uS7cBZnvRURA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-kRp6Sm9CN4u0FetS0mkYdA-1; Tue,
 23 Sep 2025 13:58:34 -0400
X-MC-Unique: kRp6Sm9CN4u0FetS0mkYdA-1
X-Mimecast-MFC-AGG-ID: kRp6Sm9CN4u0FetS0mkYdA_1758650313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3541E1956054; Tue, 23 Sep 2025 17:58:33 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A76131800451; Tue, 23 Sep 2025 17:58:32 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:58:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/3] docs/code-provenance: clarify scope very early
Message-ID: <20250923175831.GC509965@fedora>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m8ub2eQC8XTpK4Ab"
Content-Disposition: inline
In-Reply-To: <20250922154843.60233-2-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--m8ub2eQC8XTpK4Ab
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 05:48:40PM +0200, Paolo Bonzini wrote:
> The AI policy in QEMU is not about content generators, it is about genera=
ted
> content.  Other uses are explicitly not covered.  Rename the policy and c=
larify
> its scope in the TL;DR section, as a matter of convenience to the reader.
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--m8ub2eQC8XTpK4Ab
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS38cACgkQnKSrs4Gr
c8iOpAf/cYOIT0styt+Y8HWLeKKCTFJM0qFZQfazjbqnamniqgeUK+eZNPCR6gMf
SchsyuZDRPxuVVciUqPmwszQUXYWtjhwlm7UGOwK+spi9zhwLgNhtJ1GwKtNOp/F
y2j94XJWuB1FwuASCuzAB+9NRZdz1jhPj9q09fgb3Vkd9+JQfvbYpoWl2fE41r29
Y5oPK9HJn2lzUjS/1L0c11W9nQ5GA+ydnzAc/tXbwzXI05l/GAW4gNddFkOetF76
znOxgZLXrMr6Ky8OA5/54yv/g/OhAwX3pVAVflJPNB0r6F5pEDlWeR2T4zHPZTTS
gHv4a48X5z9WDW4f8aW2K78iczkCdA==
=VSTR
-----END PGP SIGNATURE-----

--m8ub2eQC8XTpK4Ab--


