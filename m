Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08259CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEPJ-0000CB-3c; Thu, 18 Jun 2026 11:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waEPI-0000C2-6V
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waEPG-0002gX-H5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781795508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNlTT2IpdTS37cOifSBjZDa/pDAHO92MdR88jAriNRY=;
 b=TYgkKNG2xvArcRVxl66EevvYNCwMpvpVSTvU7Lk3rjOsfdhlt7OAJPLVA69CQdyGyB9mAe
 0hH7sDue6vr6YQCXFHh2+JxjaOXXt9AN8acFypOxnH5ip04CkLsVB4tMVkV5CcMKvYSoUV
 mW4FsqAnSAI7GQw87rOfS2nIv2UTipE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-CwCUgIwqO2Ow5D6sQiFcUA-1; Thu,
 18 Jun 2026 11:11:46 -0400
X-MC-Unique: CwCUgIwqO2Ow5D6sQiFcUA-1
X-Mimecast-MFC-AGG-ID: CwCUgIwqO2Ow5D6sQiFcUA_1781795505
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 888E91955F70
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:11:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04AEB1956089; Thu, 18 Jun 2026 15:11:44 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:11:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Tom Stellard <tstellar@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] trace/control: Fix -Wunused-but-set-global warning with
 clang 23+
Message-ID: <20260618151143.GD720244@fedora>
References: <20260617224145.1419961-1-tstellar@redhat.com>
 <ajOi79XcRVVMTzah@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j4LKgLT9Fu64aq85"
Content-Disposition: inline
In-Reply-To: <ajOi79XcRVVMTzah@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--j4LKgLT9Fu64aq85
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 08:55:07AM +0100, Daniel P. Berrang=E9 wrote:
> CC trace maintainer.
>=20
> On Wed, Jun 17, 2026 at 03:41:45PM -0700, Tom Stellard wrote:
> > ../trace/control.c:41:13: error: variable 'init_trace_on_startup' set b=
ut not used [-Werror,-Wunused-but-set-global]
> >    41 | static bool init_trace_on_startup;
> >       |             ^
> > 1 error generated.
> >=20
> > Signed-off-by: Tom Stellard <tstellar@redhat.com>
> > ---
> >  trace/control.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
> >=20
> > diff --git a/trace/control.c b/trace/control.c
> > index 1c8c50064a..49f0a4c5cd 100644
> > --- a/trace/control.c
> > +++ b/trace/control.c
> > @@ -38,7 +38,9 @@ static TraceEventGroup *event_groups;
> >  static size_t nevent_groups;
> >  static uint32_t next_id;
> >  static uint32_t next_vcpu_id;
> > +#ifdef CONFIG_TRACE_SIMPLE
> >  static bool init_trace_on_startup;
> > +#endif
> >  static char *trace_opts_file;
> > =20
> >  QemuOptsList qemu_trace_opts =3D {
> > @@ -295,7 +297,9 @@ void trace_opt_parse(const char *optstr)
> >          trace_enable_events(qemu_opt_get(opts, "enable"));
> >      }
> >      trace_init_events(qemu_opt_get(opts, "events"));
> > +#ifdef CONFIG_TRACE_SIMPLE
> >      init_trace_on_startup =3D true;
> > +#endif
> >      g_free(trace_opts_file);
> >      trace_opts_file =3D g_strdup(qemu_opt_get(opts, "file"));
> >      qemu_opts_del(opts);
> > --=20
> > 2.51.0
> >=20
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>=20

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--j4LKgLT9Fu64aq85
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0Cq8ACgkQnKSrs4Gr
c8ihbQf+POnCWFUsuDdumtD6A8qf50OtImmbLde9okrshWr7E4qRbfSI9fC0tbHw
ACMhftqMNp3o6zT56jYtr3DeZ+lT2fj9/4lMOO4pC8A4nTOuvgPYo3q4VnwRq941
9E0PsQafzZaA2yZkvbrorMDWdqPId8YQV5hLFIUo+Ixi9Je7sKvy/1Lb2r4JQyM4
SgCoKcuKPZ7UdqSTpcQhMZwr3Yf/xiIbRWNptP+q9MNfAcbljil9tFoSNX0llwzK
jJj80J++/NoZLXdyqwEXvZOsStOpmwJdzMJCbwlEc05BvFvJuQ4a3JELqddXLxFl
mY5f7xkNnfchoEJyX8+GM0bJR41jmg==
=D5Gv
-----END PGP SIGNATURE-----

--j4LKgLT9Fu64aq85--


