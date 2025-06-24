Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33962C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 19:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU8vr-0003he-96; Tue, 24 Jun 2025 15:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU8vo-0003hB-LI
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU8vm-0003jF-Pd
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750791821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fO5nzUSZsoPREty4nMDWd8v7wzhBUf5/F/5B5WNj480=;
 b=SZ9n5rRrrnzizdLpecuRyF2S/yjzYgKnljKTE+GzGSezgVrdjo2Gh/cHSael+CO3AsIk+/
 KhqLZN74Db+ZnBHb6kQRkLbxDq8tpCdqfEtRN5XoEShTrBtrw7/zTzdrGAEVslGeX+WG0M
 Lb+eml22Kkv7X2dE9Zi61iXqPBs0Ys8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-eszjeGCKOvqmga1dnebsNw-1; Tue,
 24 Jun 2025 15:03:39 -0400
X-MC-Unique: eszjeGCKOvqmga1dnebsNw-1
X-Mimecast-MFC-AGG-ID: eszjeGCKOvqmga1dnebsNw_1750791818
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1620B18011FB; Tue, 24 Jun 2025 19:03:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5885030001A1; Tue, 24 Jun 2025 19:03:37 +0000 (UTC)
Date: Tue, 24 Jun 2025 15:03:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] tracetool: introduce generate_unconditional
Message-ID: <20250624190336.GA19307@fedora>
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
 <20250620143720.3143-3-tanishdesai37@gmail.com>
 <20250624143701.GA5519@fedora>
 <CAH_Y1jd9CSUZB502Vj4tYFXEsqymAGVJQ93TZ5oEZF726KGHKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C6x+YL7oXhjK0+I2"
Content-Disposition: inline
In-Reply-To: <CAH_Y1jd9CSUZB502Vj4tYFXEsqymAGVJQ93TZ5oEZF726KGHKw@mail.gmail.com>
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


--C6x+YL7oXhjK0+I2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:07:34PM +0530, Tanish Desai wrote:
> > 1. nocheck isn't necessary anymore. The body of nocheck could be inlined
> >   here instead to simplify the generated code.
> Yes I agree.I will remove nocheck and inline the body of nocheck in
> trace-foo
> > 2. "if (%(cond)s) {" is only useful for backends that implement
> >   .generate(). For example, if only the dtrace backend is enabled then
> >   "if (trace_event_get_state(...)) {}" will be emitted unnecessarily.
> Yes, we should remove unnecessary if (trace_event_get_state(...)){}
> blocks.
>=20
> But It is difficult because backend.generate() calls
> _run_function("generate_%s", event, group) which in turn loops on all
> backends.Format can't call generate for individual backends.I will need
> to make this map in scripts/tracetool/backend/__init__.py:_run_function()=
=2E(I
> think this
> will not be a good thing to do).
>=20
> possible fix would be to create in scripts/tracetool/backend/__init__.py
> def is_conditional(self, cond_check):
>     self._run_function("generate_%s_conditional", cond_check)
> now cond_check will be passed to all backends and backend's will have
> def is_h_conditional(cond_check):
>     cond_check =3D cond_check or True
>=20
> Finally if cond_check=3D=3DTrue in h.py I will generate "if
> (trace_event_get_state(...)) {"
> else not. As the same condition is re-used this solution would work well.
> Since h.py only handles reused/shared logic, it's safe to assume consiste=
nt
> conditions.
> If a new backend requires a different condition, it's better handled
> directly in backend/*.py.

To me a generic solution that doesn't hard-code trace_event_get_state()
is nicer, but it's okay if you want to introduce the concept of
"conditional" meaning specifically trace_event_get_state() since there
are no other cases where we want to merge two conditionals. I don't
really mind.

>=20
>=20
> On Tue, Jun 24, 2025 at 8:07=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
>=20
> > On Fri, Jun 20, 2025 at 02:37:19PM +0000, Tanish Desai wrote:
> > > diff --git a/scripts/tracetool/format/h.py
> > b/scripts/tracetool/format/h.py
> > > index ea126b07ea..89d54b9aff 100644
> > > --- a/scripts/tracetool/format/h.py
> > > +++ b/scripts/tracetool/format/h.py
> > > @@ -76,13 +76,17 @@ def generate(events, backend, group):
> > >          out('',
> > >              'static inline void %(api)s(%(args)s)',
> > >              '{',
> > > -            '    if (%(cond)s) {',
> > > +            api=3De.api(),
> > > +            args=3De.args)
> > > +
> > > +        if "disable" not in e.properties:
> > > +            backend.generate_unconditional(e, group)
> > > +
> > > +        out('    if (%(cond)s) {',
> > >              '        %(api_nocheck)s(%(names)s);',
> > >              '    }',
> > >              '}',
> > > -            api=3De.api(),
> > >              api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
> > > -            args=3De.args,
> > >              names=3D", ".join(e.args.names()),
> > >              cond=3Dcond)
> >
> > Two thoughts:
> >
> > 1. nocheck isn't necessary anymore. The body of nocheck could be inlined
> >    here instead to simplify the generated code.
> >
> > 2. "if (%(cond)s) {" is only useful for backends that implement
> >    .generate(). For example, if only the dtrace backend is enabled then
> >    "if (trace_event_get_state(...)) {}" will be emitted unnecessarily.
> >
> > Maybe backends should have a .condition() interface so that
> > scripts/tracetool/format/h.py:generate() can first collect a dict[cond]
> > -> backend. Then it iterates over the map, calling backend.generate()
> > within "if (%(cond)s) { ... }". That way only the conditions that are
> > actually needed are generated and multiple backends that have the same
> > condition will share the same if statement.
> >
> > Stefan
> >

--C6x+YL7oXhjK0+I2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmha9ogACgkQnKSrs4Gr
c8hLIgf8CSO89rROdyrCdLrKvq4uXgWG80m21z3eTpfdahAzJhVuAxb9pMgtH4Gm
CCBEhB3riAurOrLOBHae/Tz62oKokqH/ZsWrd+jEymB1sR9VKeFedJkI3Fl7iAiN
ZpMt6BdDlRSys4S3XqtaLDE4IFunpwhMVqrfh88sHRAg+AH81kw2nqxHWM1A6Xd5
9LeBVaPsdum2oEgSxAGQxvLvhVWOFl+TRydz+nbUvWFgOlYVkMrBR68JPU93/XgA
L3wZFY9yafXxIaA9cCCNH/28ApT9TzhLnHM7rkmIAeg+wACEp7vgYL+XYfzU1Mpw
71GltIJUbzao5z3em/H8RNKOIXjQQw==
=Hkox
-----END PGP SIGNATURE-----

--C6x+YL7oXhjK0+I2--


