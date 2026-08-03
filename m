Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D40C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqx02-0004yU-Im; Mon, 03 Aug 2026 14:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wqwzx-0004yB-46
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wqwzv-0001s4-Bz
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785780166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LaIjBQzddi9bXdXWKhHbvioIYX5xzKyOJyibHmbA/6U=;
 b=UZMeIzsFOqnb/IZXsv0bdPKKoak0ZWDDAlmtPHgLCfXHIaykhoDGopeRY0VKPiglG5ebp6
 sPEoM6QfM1bYlehk1w5yXx1hfiC+dKqHRtQj6D1ulnNMwhnvzPnVUiN83xh+1IKTm5ja11
 tF/pms+/DETov31WngZzQi/c1oIWkMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-SqK_hOxEPEeJoehTG7juYQ-1; Mon,
 03 Aug 2026 14:02:32 -0400
X-MC-Unique: SqK_hOxEPEeJoehTG7juYQ-1
X-Mimecast-MFC-AGG-ID: SqK_hOxEPEeJoehTG7juYQ_1785780151
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17625195605F; Mon,  3 Aug 2026 18:02:31 +0000 (UTC)
Received: from localhost (unknown [10.2.17.42])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B8CA1800480; Mon,  3 Aug 2026 18:02:30 +0000 (UTC)
Date: Mon, 3 Aug 2026 14:02:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
Message-ID: <20260803180228.GA365806@fedora>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
 <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
 <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
 <7239bc2e-b180-42ab-ae56-454557cb3194@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gzC6LNYQiHggD/KO"
Content-Disposition: inline
In-Reply-To: <7239bc2e-b180-42ab-ae56-454557cb3194@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--gzC6LNYQiHggD/KO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 02, 2026 at 04:13:35PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 31/7/26 23:17, Denis V. Lunev wrote:
> > On 7/31/26 22:18, Stefan Hajnoczi wrote:
> > > On Fri, Jul 31, 2026 at 9:45=E2=80=AFAM Denis V. Lunev <den@virtuozzo=
=2Ecom> wrote:
> > > > On 7/30/26 16:55, Stefan Hajnoczi wrote:
> > > > > On Thu, Jul 30, 2026 at 4:14=E2=80=AFAM Denis V. Lunev <den@openv=
z.org> wrote:
> > > > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > > > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > > > > > ---
> > > > > >   MAINTAINERS | 1 +
> > > > > >   1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 902db77218..4628793dde 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
> > > > > >=20
> > > > > >   IDE
> > > > > >   M: John Snow <jsnow@redhat.com>
> > > > > > +M: Denis V. Lunev <den@openvz.org>
> > > > > Waiting for acknowledgement from John.
>=20
> Note, Denis is not removing / replacing John, but simply
> stepping up to co-maintain an area unattented since quite
> some time. I doubt John will oppose to that precious and
> scarce help.

I don't think so either, but he should be involved in the process of
adding a co-maintainer. There is no rush, let's give him a few more
days rather than making the decision for him.

Stefan

--gzC6LNYQiHggD/KO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpw17QACgkQnKSrs4Gr
c8jM7Qf/eKKxtAsNYNngqNDSe3CyWOC15JluORMh8/g5arHOj5DJMPrMSc1w2W0y
ToWLjJyNxqWO6m1BVukSI364QCOpUb2oa9vS8TTlLU5yJO/2Yp+VM9XrERJmWgCv
gL1DwDP7g0a91RD9uUiPD9dRqNRw1H0UKrjrTtPj9G2kTtQoqFy0/fjvjyS+WuTd
LJRfeDL0/yOcsAirlZ5dmot5i+nVbDPrjnbOwGQyRy7/nn9pMEcYPt0/Admg+Pbd
tuEpmxeqaaSdwPAjU7bRrKmY3uXOZV6DHHvNoVpOQBV8msHU9M17xMRq0z++vQuC
9pHFz+kn3uhWt1PXgBYpEZiRKqtCrg==
=YkZ9
-----END PGP SIGNATURE-----

--gzC6LNYQiHggD/KO--


