Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D01C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 13:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rc7-0007Dh-Ud; Thu, 10 Apr 2025 09:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2rc6-0007DK-ET
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 09:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2rc4-0005Jh-Oi
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 09:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744290394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+EoEHuflXqCaeEY8G+qo4fPJ189er5U5VS5u2Y4Gts=;
 b=gXendQvAnOwcrmDugwJEHeNzb8W89RXU/KhFO0UtrW69go6iFsq9zOB09R5N/SlaziVUuu
 KxpQYeq3+0mV5UzDOxCAVCX8cbD6UJZlnZhHGeV/DDQHZDLy18azJPF5Mq9eRuf3MrZr2k
 mB9cYUxdpbIpX0gFMjsqEVOgd/H4G28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-uBkt-LFYNjiVen0Trztp1w-1; Thu,
 10 Apr 2025 09:06:29 -0400
X-MC-Unique: uBkt-LFYNjiVen0Trztp1w-1
X-Mimecast-MFC-AGG-ID: uBkt-LFYNjiVen0Trztp1w_1744290388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1014C180AF6E; Thu, 10 Apr 2025 13:06:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.107])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 859191801A69; Thu, 10 Apr 2025 13:06:27 +0000 (UTC)
Date: Thu, 10 Apr 2025 09:06:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: Re: Note improvements to QAPI-generated manuals in ChangeLog/10.0?
Message-ID: <20250410130626.GA33720@fedora>
References: <87h62x8n6b.fsf@pond.sub.org>
 <CAJSP0QUyZfV8UQmhR5ADgC5Cr9zVrJ53fcWLvY0GUUSKfj8iyw@mail.gmail.com>
 <87v7rc4nxa.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zsGT6pZXBM+zZKMt"
Content-Disposition: inline
In-Reply-To: <87v7rc4nxa.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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


--zsGT6pZXBM+zZKMt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 06:53:53AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Wed, Apr 9, 2025 at 9:44=E2=80=AFAM Markus Armbruster <armbru@redhat=
=2Ecom> wrote:
> >>
> >> John improved looks and usabilibity of the QAPI-generated manuals quite
> >> a bit.  These are
> >>
> >>     QEMU QMP Reference Manual
> >>     QEMU Storage Daemon QMP Reference Manual
> >>     QEMU Guest Agent Protocol Reference
> >>
> >> Where should it go?  https://wiki.qemu.org/ChangeLog/10.0 has no secti=
on
> >> dedicated to the manuals.  We could mention it under System Emulation /
> >> Monitor / QMP, and again under Guest Agent.  Thoughts?
> >
> > I would add a separate Documentation section for changes like this.
> > That's also where major docs infrastructure items like changes to
> > formats (rST), tooling (Sphinx), etc could be announced.
>=20
> Insert a "Documentation" section between "Guest agent" and "Build
> Information"?

Sounds good to me.

Stefan

--zsGT6pZXBM+zZKMt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf3wlIACgkQnKSrs4Gr
c8jJVQf+JbclF3Bq7c7pM3WkGhCXdCZVclNFVJJuIlGIJ55U+hof1Zc4+WZ+BfjE
33xdnOZ6klvMi7yH+C6DewZbu/y1ux6TH/oOHaxH64mzCCiTBDx1Lpoe89lf52BT
Xbw3oOrxt1NNYx/itwbjRpn8egA05QmNASmPD8nssKbQtVpRbPzWm68QtUPfAfxt
Gbq576n/xhF1pyqN7vAVfv4/+zuiXzSz0hkm0i33TnvbCim4btLBpSMeSUp+3p7O
IuScAl8lIUyq9Cvr1PG9pHj8pJ+5IwsLoXhQCPFiyyf5TAgFuJoBj9YjtEp0BZQh
Knl6UjhpXvTSKoOFdmnNQ2rk4GAY8Q==
=ODu+
-----END PGP SIGNATURE-----

--zsGT6pZXBM+zZKMt--


