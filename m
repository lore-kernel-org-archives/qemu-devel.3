Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41C4C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiSu-0007WN-DO; Mon, 10 Jun 2024 13:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiSs-0007Vv-QX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiSr-0007ty-0B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/oM1gMtpMcgkADiOdKEqTcGvC51DXWws6wOH/J8C1A=;
 b=c90IsSbcltUReYZi0EB0efMdMRLO2ag3gpY4fRs7iNlxC46IaY6Fz8C/ZeFwa/WyN201LH
 8DZ06CwaSp6f2OlbG0qpmmW4CCpE9KUHLILuQua+kSq3VrjZRHp92H2ugFdSqNAFDM0RTk
 BuidwAZOafmQEZz6spxKhFfyY2Zv1/o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-6kPHOJMjPnerZZmXTSz46A-1; Mon,
 10 Jun 2024 13:05:44 -0400
X-MC-Unique: 6kPHOJMjPnerZZmXTSz46A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0E419560B5; Mon, 10 Jun 2024 17:05:42 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EE5219560AB; Mon, 10 Jun 2024 17:05:39 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:05:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] trace: Remove and forbid newline characters in event
 format
Message-ID: <20240610170533.GA343470@fedora.redhat.com>
References: <20240606103943.79116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HZHu1J2Shs2/l16y"
Content-Disposition: inline
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--HZHu1J2Shs2/l16y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:39:38PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Trace events aren't designed to be multi-lines.
> Few format use the newline character: remove it
> and forbid further uses.
>=20
> Philippe Mathieu-Daud=E9 (5):
>   backends/tpm: Remove newline character in trace event
>   hw/sh4: Remove newline character in trace events
>   hw/usb: Remove newline character in trace events
>   hw/vfio: Remove newline character in trace events
>   tracetool: Forbid newline character in event format
>=20
>  backends/tpm/tpm_util.c       | 5 +++--
>  backends/tpm/trace-events     | 3 ++-
>  hw/sh4/trace-events           | 4 ++--
>  hw/usb/trace-events           | 6 +++---
>  hw/vfio/trace-events          | 4 ++--
>  scripts/tracetool/__init__.py | 2 ++
>  6 files changed, 14 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.41.0
>=20

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--HZHu1J2Shs2/l16y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZnMl0ACgkQnKSrs4Gr
c8hBrwgAthjbg8Xycs0OsW2sPceMRRRLcKlofv8aGEJBDHa9J8g+qdHu6LdKVEPe
OwEVrPKnJUGN1VBPil6vgEPF5mMYd/jtJW+gZ9xM8a6rGIkE60aUEOtBNuqR2OhL
SQas95MoruyC9hvJHqiPvhziF+IpXjEK8W7zxLr2OJnQEqP1J6zecaB9gBxx5zFB
InTimFBpakatjMqPnO46XCQtpVCD9aTeBkkBbQ+3/KL+izAGRf9W+zpI1Cb08tlS
vKOHTV9Kew8o62P4zYyFoyHd8zcPP7gtaERf2GB5Ri8A/ZDXPzPF8NvVwpqKjX95
xwvl3W8ee2xJ17cI11fyGxb/3wkJqA==
=orl7
-----END PGP SIGNATURE-----

--HZHu1J2Shs2/l16y--


