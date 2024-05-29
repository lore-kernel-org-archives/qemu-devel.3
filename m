Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1551C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOEb-0008AL-41; Wed, 29 May 2024 14:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sCOEZ-00089s-So
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sCOEY-0002wV-AK
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717008069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfNiFsNFCe6aBViHuZ77mmFYGiiDoTzm0Qa9D7ExziQ=;
 b=Yuvw01MPk9OjMgnNb6wbmCeDnC3XbDQetwgG8YyZh2lBjYHLEvxcsyqPrUDAIStsBIbNb3
 vemVfswBIlD+EBAjG6wgxleOJXRUWVjRzLYsHQXghGreMgpjld3NMXVgfh2aZOx7qVWm6G
 KTvtch/oaZTk0xbac6li4WJswY9wn0Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-Z-N-wYXFMxScl3M3Snhrkg-1; Wed,
 29 May 2024 14:41:05 -0400
X-MC-Unique: Z-N-wYXFMxScl3M3Snhrkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E1363C025B9;
 Wed, 29 May 2024 18:41:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C5D492BC6;
 Wed, 29 May 2024 18:41:04 +0000 (UTC)
Date: Wed, 29 May 2024 14:41:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Message-ID: <20240529184103.GD1203999@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-2-zhao1.liu@intel.com>
 <20240527200504.GB913874@fedora.redhat.com>
 <ZlWNk46MF5uNa+ZC@intel.com>
 <20240528141401.GB993828@fedora.redhat.com>
 <Zlc79ZhJavATdvSs@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/OqMt/qTZlvi3nma"
Content-Disposition: inline
In-Reply-To: <Zlc79ZhJavATdvSs@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--/OqMt/qTZlvi3nma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:30:13PM +0800, Zhao Liu wrote:
> Hi Stefan,
>=20
> On Tue, May 28, 2024 at 10:14:01AM -0400, Stefan Hajnoczi wrote:
> > Date: Tue, 28 May 2024 10:14:01 -0400
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo
> >  framework
> >=20
> > On Tue, May 28, 2024 at 03:53:55PM +0800, Zhao Liu wrote:
> > > Hi Stefan,
> > >=20
> > > [snip]
> > >=20
> > > > > diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/sim=
pletrace-rust/.rustfmt.toml
> > > > > new file mode 100644
> > > > > index 000000000000..97a97c24ebfb
> > > > > --- /dev/null
> > > > > +++ b/scripts/simpletrace-rust/.rustfmt.toml
> > > > > @@ -0,0 +1,9 @@
> > > > > +brace_style =3D "AlwaysNextLine"
> > > > > +comment_width =3D 80
> > > > > +edition =3D "2021"
> > > > > +group_imports =3D "StdExternalCrate"
> > > > > +imports_granularity =3D "item"
> > > > > +max_width =3D 80
> > > > > +use_field_init_shorthand =3D true
> > > > > +use_try_shorthand =3D true
> > > > > +wrap_comments =3D true
> > > >=20
> > > > There should be QEMU-wide policy. That said, why is it necessary to=
 customize rustfmt?
> > >=20
> > > Indeed, but QEMU's style for Rust is currently undefined, so I'm tryi=
ng
> > > to add this to make it easier to check the style...I will separate it
> > > out as a style policy proposal.
> >=20
> > Why is a config file necessary? QEMU should use the default Rust style.
> >=20
>=20
> There are some that may be overdone, but I think some basic may still
> be necessary, like "comment_width =3D 80", "max_width =3D 80",
> "wrap_comments". Is it necessary to specify the width? As C.

Let's agree to follow the Rust coding style from the start, then the
problem is solved. My view is that deviating from the standard Rust
coding style in order to make QEMU Rust code resemble QEMU C code is
less helpful than following Rust conventions so our Rust code looks like
Rust.

>=20
> And, "group_imports" and "imports_granularity" (refered from crosvm),
> can also be used to standardize including styles and improve
> readability, since importing can be done in many different styles.
>=20
> This fmt config is something like ./script/check_patch.pl for QEMU/linux.
> Different programs have different practices, so I feel like that's an
> open too!

In languages like Rust that have a standard, let's follow the standard
instead of inventing our own way of formatting code.

> This certainly also depends on the maintainer's/your preferences, ;-)
> in what way looks more comfortable/convenient that is the best,
> completely according to the default is also good.

This will probably affect all Rust code in QEMU so everyone's opinion
counts.

Stefan

--/OqMt/qTZlvi3nma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZXdr8ACgkQnKSrs4Gr
c8i6SQgAgSEO/nwAYs2cYw7GI1x0Qidt/4CsJz3wcEGVzEcWrpLC8MYQAcWe1I9n
5EZRaD0goVE6nXCdrbr4g3ePJo1z5qoT9QnbAz6g6cMYGso9Bv2hJqNVzhBGKogG
Ip5Pt6WtBm3S6ih7HZ9lzVTlnsG+6YUJ0WfQutNaEAHH1qraxQc5umn6aZSfdVeE
pAGYzcpaTiiRZ3uhqjspbmPyLlXin2CZXpkoQWhD4HeVV1DYdJ8RFBGUBhygu3+Y
ST3xPzXz/hQ5FJpEdmYpowKn+i0qpsKEn3u0tRWobDOJopJfAlKaW+919IgrVUBa
Dwyv99K1PjuZ1ZTtd3aI7nNunkC3CA==
=8XsP
-----END PGP SIGNATURE-----

--/OqMt/qTZlvi3nma--


