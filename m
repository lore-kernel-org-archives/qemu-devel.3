Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B8C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 14:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmZ7-0001uH-NW; Mon, 07 Jul 2025 10:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uYmR3-0006n6-Gz
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uYmR1-0000Ec-Ui
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751896983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V+owIKI0ZnKIwucwur0SGfcBQJKBiM6Mtfctkmiere4=;
 b=WTfEW18IAwa8tTSDGgZcKPfYeKgZdDZrGMEN5ABie9t35uF/w1rTeiGKSUgUWNv6hfNl2s
 nFLqDDdqZfigC3Py9PUvaEyKwSgeyR+1X9nRaGHsDK2fA7YqmJEyBXFtgM3lC3AAH/gPss
 Ktns16QCowRpfNDMnQOBlSU5qg54EOU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-pG4YEdn0M4Kt-_ugf1DTPg-1; Mon,
 07 Jul 2025 10:03:01 -0400
X-MC-Unique: pG4YEdn0M4Kt-_ugf1DTPg-1
X-Mimecast-MFC-AGG-ID: pG4YEdn0M4Kt-_ugf1DTPg_1751896977
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C15418011EE; Mon,  7 Jul 2025 14:02:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.81])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC93B19560AB; Mon,  7 Jul 2025 14:02:55 +0000 (UTC)
Date: Mon, 7 Jul 2025 10:02:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
Message-ID: <20250707140253.GA113082@fedora>
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
 <e3e2f53a-33ad-49b0-99fc-c7af4b76a0d8@linaro.org>
 <CAFEAcA82LrhSz47_Q_FwbBmC-Nve-WR2bhfWoWyvYi_60MSBaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YKKCCmn7SuFeMt/q"
Content-Disposition: inline
In-Reply-To: <CAFEAcA82LrhSz47_Q_FwbBmC-Nve-WR2bhfWoWyvYi_60MSBaw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--YKKCCmn7SuFeMt/q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 02:14:35PM +0100, Peter Maydell wrote:
> On Mon, 30 Jun 2025 at 17:53, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 6/30/25 6:09 AM, Philippe Mathieu-Daud=E9 wrote:
> > > It is useful to compare PSCI calls of the same guest running
> > > under TCG or HVF.
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> > > ---
> > >   target/arm/hvf/hvf.c    | 3 ++-
> > >   target/arm/tcg/psci.c   | 3 +++
> > >   target/arm/trace-events | 3 +++
> > >   3 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > > index 7a99118c8c2..6309c5b872e 100644
> > > --- a/target/arm/hvf/hvf.c
> > > +++ b/target/arm/hvf/hvf.c
> > > @@ -34,6 +34,7 @@
> > >   #include "target/arm/multiprocessing.h"
> > >   #include "target/arm/gtimer.h"
> > >   #include "trace.h"
> > > +#include "../trace.h"
>=20
>=20
> > Just a nit, using 'target/arm/trace.h' might be more readable than
> > '../trace.h'.
>=20
> Mmm. docs/devel/tracing.rst rather discourages this:
>=20
> # While it is possible to include a trace.h file from outside a source
> file's own
> # sub-directory, this is discouraged in general. It is strongly preferred=
 that
> # all events be declared directly in the sub-directory that uses them. Th=
e only
> # exception is where there are some shared trace events defined in the to=
p level
> # directory trace-events file.
>=20
> I don't know if we want to loosen that to permit events
> that are shared between multiple subdirs (cc'ing the
> trace subsystem maintainers for their view).

Code is generated from the trace-events files and my main concern is
that the build dependencies on the generated code may not be obvious if
a trace event from somewhere far away in the source tree hierarchy is
used. You might hit linker errors because the .o files needed for the
trace events are not being linked in.

I would try to stick with what's described in tracing.rst to avoid
difficulties now or in the future.

>=20
> git grep 'include.*trace.h' | grep -v '"trace.h"'| grep -v 'trace.h:'|less
>=20
> suggests that the only current place where we're including
> a trace.h not in the same directory is linux-user, where
> we opt to use the full linux-user/trace.h path. So probably
> for consistency we should use target/arm/trace.h here.
>=20
> (That grep also shows up that hw/uefi is missing its
> trace.h header and the .c files are including
> trace-hw_uefi.h directly...)
>=20
> -- PMM
>=20

--YKKCCmn7SuFeMt/q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhr040ACgkQnKSrs4Gr
c8hB5Qf/Yo7qT7Lu2HNxIak9tnRnQG3vUodTWxAZwD407g9lGuPMtMM5R46zO0OS
ije/VQknB9dElJE58X3/hToLqQdfx2DPUxMnKfa41WhRur4TV2O7J1f4MsJpQLuY
qqSL9n5e33v+Eq0SRXTNFw6kn8sTSblEr285BFAkxR6WkcwLLWdacavXJKUJ0jsu
hLNRkHhJE++D9oqCZlTryhH4UiCsdFTMYTqhQcVTokmKiDa4CXaDqe4EjvzfZR+E
yXdP9ShO4Ev9miVfD6QcYYse6QpvJma40eTjIq9RaZXofz/GiXRCMSZIQRMsTNOd
MpK49I7CrvdnSTqiX/aqn2R758b1qg==
=lqh8
-----END PGP SIGNATURE-----

--YKKCCmn7SuFeMt/q--


