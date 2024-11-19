Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E516D7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Ls-0002Ac-Ql; Thu, 21 Nov 2024 10:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tE9Lg-0001Gp-Ox
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tE9Le-00012L-VG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XidYgMZZPwTRwcnCJ0VMinOnUr88/ZhRmq5zijszjuA=;
 b=Kc18n8K4SLF+a4E3RR7GNzDO0JFaXZBEmLoNiwm+JcZ8e9q2VMku6L2c/rtljHL67OQSko
 svuZzIZeFq78ieXh2/d0DVFoHjelwvEJPCUfCTvI52EQ8RQYKto41xUrYWdTKV1OijUTCy
 yg+whs+mqXd/VMdJe4e3dK9LLgHVz5g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-myX8fJssMOaJdEsxofJfHQ-1; Thu,
 21 Nov 2024 10:43:56 -0500
X-MC-Unique: myX8fJssMOaJdEsxofJfHQ-1
X-Mimecast-MFC-AGG-ID: myX8fJssMOaJdEsxofJfHQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B2C1195609F; Thu, 21 Nov 2024 15:43:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E03D19560A3; Thu, 21 Nov 2024 15:43:54 +0000 (UTC)
Date: Tue, 19 Nov 2024 14:50:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] docs: explicitly permit a "commonly known identity" with
 SoB
Message-ID: <20241119195048.GD340853@fedora>
References: <20241021190939.1482466-1-berrange@redhat.com>
 <CAFEAcA894Mi+WnpHKb=0odOSo4_K9GZnVQeBJjLW5HxSiYfRJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2Y1LwsNaBaX6+4c+"
Content-Disposition: inline
In-Reply-To: <CAFEAcA894Mi+WnpHKb=0odOSo4_K9GZnVQeBJjLW5HxSiYfRJw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.14, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--2Y1LwsNaBaX6+4c+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 03:19:40PM +0000, Peter Maydell wrote:
> On Mon, 21 Oct 2024 at 20:10, Daniel P. Berrang=E9 <berrange@redhat.com> =
wrote:
> >
> > The docs for submitting a patch describe using your "Real Name" with
> > the Signed-off-by line. Although somewhat ambiguous, this has often
> > been interpreted to mean someone's legal name.
> >
> > In recent times, there's been a general push back[1] against the notion
> > that use of Signed-off-by in a project automatically requires / implies
> > the use of legal ("real") names and greater awareness of the downsides.
> >
> > Full discussion of the problems of such policies is beyond the scope of
> > this commit message, but at a high level they are liable to marginalize,
> > disadvantage, and potentially result in harm, to contributors.
> >
> > TL;DR: there are compelling reasons for a person to choose distinct
> > identities in different contexts & a decision to override that choice
> > should not be taken lightly.
> >
> > A number of key projects have responded to the issues raised by making
> > it clear that a contributor is free to determine the identity used in
> > SoB lines:
> >
> >  * Linux has clarified[2] that they merely expect use of the
> >    contributor's "known identity", removing the previous explicit
> >    rejection of pseudonyms.
> >
> >  * CNCF has clarified[3] that the real name is simply the identity
> >    the contributor chooses to use in the context of the community
> >    and does not have to be a legal name, nor birth name, nor appear
> >    on any government ID.
> >
> > Since we have no intention of ever routinely checking any form of ID
> > documents for contributors[4], realistically we have no way of knowing
> > anything about the name they are using, except through chance, or
> > through the contributor volunteering the information. IOW, we almost
> > certainly already have people using pseudonyms for contributions.
> >
> > This proposes to accept that reality and eliminate unnecessary friction,
> > by following Linux & the CNCF in merely asking that a contributors'
> > commonly known identity, of their choosing, be used with the SoB line.
>=20
> This all makes sense to me -- we've never really had our own
> independent take on the DCO, we just followed what the kernel did.
>=20
> I have cc'd people listed in MAINTAINERS under "project policy"
> and the more active members of the Leadership Committee to
> bring it to a slightly wider circle of attention.
>=20
> Unless there are any objections over the course of the next week,
> I think we should commit this change, so it has my
>=20
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
>=20
>=20
> > [1] Raised in many contexts at many times, but a decent overall summary
> >     can be read at https://drewdevault.com/2023/10/31/On-real-names.html
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
> > [3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines=
=2Emd
> > [4] Excluding the rare GPG key signing parties for regular maintainers
> >
> > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/check-dco.py         | 5 ++++-
> >  docs/devel/submitting-a-patch.rst | 7 ++++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
> > index 632c8bcce8..6a06afffe5 100755
> > --- a/.gitlab-ci.d/check-dco.py
> > +++ b/.gitlab-ci.d/check-dco.py
> > @@ -79,7 +79,10 @@
> >
> >  To indicate acceptance of the DCO every commit must have a tag
> >
> > -  Signed-off-by: REAL NAME <EMAIL>
> > +  Signed-off-by: YOUR NAME <EMAIL>
> > +
> > +where "YOUR NAME" is your commonly known identity in the context
> > +of the community.
> >
> >  This can be achieved by passing the "-s" flag to the "git commit" comm=
and.
> >
> > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-=
a-patch.rst
> > index 83e9092b8c..10b062eec2 100644
> > --- a/docs/devel/submitting-a-patch.rst
> > +++ b/docs/devel/submitting-a-patch.rst
> > @@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
> >
> >     * - Check
> >       - Reason
> > -   * - Patches contain Signed-off-by: Real Name <author@email>
> > +   * - Patches contain Signed-off-by: Your Name <author@email>
> >       - States you are legally able to contribute the code. See :ref:`p=
atch_emails_must_include_a_signed_off_by_line`
> >     * - Sent as patch emails to ``qemu-devel@nongnu.org``
> >       - The project uses an email list based workflow. See :ref:`submit=
ting_your_patches`
> > @@ -335,6 +335,11 @@ include a "From:" line in the body of the email (d=
ifferent from your
> >  envelope From:) that will give credit to the correct author; but again,
> >  that author's Signed-off-by: line is mandatory, with the same spelling.
> >
> > +The name used with "Signed-off-by" does not need to be your legal name,
> > +nor birth name, nor appear on any government ID. It is the identity you
> > +choose to be known by in the community, but should not be anonymous,
> > +nor misrepresent whom you are.
>=20
> Grammar nit: should be "who".
>=20
> > +
> >  There are various tooling options for automatically adding these tags
> >  include using ``git commit -s`` or ``git format-patch -s``. For more
> >  information see `SubmittingPatches 1.12
> > --
>=20
> thanks
> -- PMM
>=20

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--2Y1LwsNaBaX6+4c+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmc87BgACgkQnKSrs4Gr
c8hLCgf9EtmOWs/Xd6IBRk4jma8uIfwI040beEqEjbsS2LhCRa4JD8LU9S9jE19O
LYrvlLljvAJq+LORt9t0HAvPTZ+iUX/Ied0foiEUP0dNdggTWzMS2d0VjUfJ+DEK
jNe31oJfnt99th2SZZxduMHvz1wSd3v/5E1cAveC+cPIhvHH4Inz5Ewnqr0JRQEk
n7OPunibaWkathm2QD7XjJgrbKkyDtAf+WAWLKaIDhdBm+XGGaxhKpSJSscrnx98
krFFbsLukjKlCuAcChM2r621MEa9JYzNey6W+ZGH4BJN+Hg9trZX2MBOmSaanGRn
BDMaxqsRFgE1gIfkZyY+p2SMVl1v0g==
=qSFz
-----END PGP SIGNATURE-----

--2Y1LwsNaBaX6+4c+--


