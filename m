Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E79C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsrV-0004FB-4K; Tue, 11 Aug 2026 16:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtsrL-0004DL-6w
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 16:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtsrH-0002yJ-Ji
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 16:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786479238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBtTGm5Ks5iXKZISqeAtCN2hqW4r+xpzqM8puzQTDAw=;
 b=cqzLU0fQ1D6HdGmNA0wOG52QLIgQaDa/seimt6/8/oiD+Twzdga9VJzV8Idl95i0pq4XlC
 t4o+ZRCr2jUhgqtEotzqvwrC4JP07Bfp5mazMa/uuyJSugp3Q8rlMFqlQzocRpKgYw5pLu
 xE6Ye70w+192wcQORt7zR2JOLgBSoj0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-6521w8SvOYKooZmVI0_P3w-1; Tue,
 11 Aug 2026 16:13:52 -0400
X-MC-Unique: 6521w8SvOYKooZmVI0_P3w-1
X-Mimecast-MFC-AGG-ID: 6521w8SvOYKooZmVI0_P3w_1786479231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A6E18001D7; Tue, 11 Aug 2026 20:13:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FE0319560AB; Tue, 11 Aug 2026 20:13:50 +0000 (UTC)
Date: Tue, 11 Aug 2026 16:13:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
Message-ID: <20260811201349.GB196609@fedora>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DrPzHyVsXfWSWGCD"
Content-Disposition: inline
In-Reply-To: <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--DrPzHyVsXfWSWGCD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:55:53AM -0400, Stefan Hajnoczi wrote:
> On Thu, Jul 30, 2026 at 4:14=E2=80=AFAM Denis V. Lunev <den@openvz.org> w=
rote:
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 902db77218..4628793dde 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
> >
> >  IDE
> >  M: John Snow <jsnow@redhat.com>
> > +M: Denis V. Lunev <den@openvz.org>
>=20
> Waiting for acknowledgement from John.
>=20
> Stefan
>=20

Thanks, applied to my staging tree:
https://gitlab.com/stefanha/qemu/commits/staging

Stefan

--DrPzHyVsXfWSWGCD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7gn0ACgkQnKSrs4Gr
c8jLKwf/TMxUYSldTFn2lyJ7RakMKrchtPwQo/8/YyMIrRnYpN4fR+OT1SxowFGl
KZzhU1vHfvOIi/W69H0Vf1Y1wvFySjcrZVdiAdC81leBHVlnrAceeOqwRIZOqU2K
U7dQCcsZvTb2VelB5r5/St5ApvaRAT50EMtZ+pyz8Z8AAY4wnYqvOvSrBsgO1Fis
a9t5OhCNMkAfpXgtzask9MBgvWZAK7Z/sJG3QsTMK9KrP/mQkwOdU0sFK+d0Cp35
UX/CultRx7FeabIJSe5DhyRRq5a2xeEEdVpsL2hFVveNtDbh/SMSCmJlpAq7+hdW
+TsDbPqSXW+KNh1NVAUMAuUhFZOlew==
=jVXN
-----END PGP SIGNATURE-----

--DrPzHyVsXfWSWGCD--


