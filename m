Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6A3C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYWQ-000707-Ef; Tue, 17 Jun 2025 11:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYJN-0001BQ-ES
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRX0L-0006dF-Kl
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 10:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750169374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsIKRaGBHvBhoEGe3IQh6uNquzQxyT8kbXR/Bh6y3rA=;
 b=Mc2+21kQDPvZmlCxnR9H55tGnT7qyaFDsdH/QX/RVOJyweINjJ3JlE3xmJqdNlw8RCo5sn
 A/5Npe1VuiV1Cp4uXuO6/3WZB1E7kTTBMeqXzsZsEyrwvEeom3VY2++oFCkXPi6eXOGJWE
 XgdNiTU/6+7vUZc9Ki3CzQ5GC8iKUn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-DV2AwAH_NESQSCoyZoLzeQ-1; Tue,
 17 Jun 2025 10:09:30 -0400
X-MC-Unique: DV2AwAH_NESQSCoyZoLzeQ-1
X-Mimecast-MFC-AGG-ID: DV2AwAH_NESQSCoyZoLzeQ_1750169369
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 270531809C94; Tue, 17 Jun 2025 14:09:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B9501956094; Tue, 17 Jun 2025 14:09:28 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:09:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/3] tracetool:cleanup "if(true)" check from trace_foo()
Message-ID: <20250617140927.GB117267@fedora>
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HT296jN3UK4qLfC2"
Content-Disposition: inline
In-Reply-To: <20250616201222.6416-1-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HT296jN3UK4qLfC2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 08:12:19PM +0000, Tanish Desai wrote:
> This series of patch aims to removes the leftover if (true) condition fro=
m trace_foo, a remnant from the TCG tracing feature removal.
> It replaces it with a proper trace_event_get_state(...) check where neces=
sary(for log/simple/syslog and ftrace backend).
> Additionally, this change centralizes the generation of trace_event_get_s=
tate(...) calls into format/h.py,
> eliminating redundant code across individual backends.
> This cleanup results in more consistent and less repetitive backend code.

CCing Alex Benn=E9e, who authored commit 126d4123c50a ("tracing: excise
the tcg related from tracetool").

>=20
> Tanish Desai (3):
>   tracetool: removed the unused vcpu property
>   tracetool: introduce generate_unconditional
>   tracetool: remove redundant event_get_state checks
>=20
>  scripts/tracetool/backend/__init__.py |  3 +++
>  scripts/tracetool/backend/dtrace.py   |  3 ++-
>  scripts/tracetool/backend/ftrace.py   |  3 ---
>  scripts/tracetool/backend/log.py      |  9 +--------
>  scripts/tracetool/backend/simple.py   | 11 +----------
>  scripts/tracetool/backend/syslog.py   | 11 +----------
>  scripts/tracetool/backend/ust.py      |  2 +-
>  scripts/tracetool/format/h.py         | 13 +++++++++----
>  8 files changed, 18 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.34.1
>=20

--HT296jN3UK4qLfC2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRdxcACgkQnKSrs4Gr
c8jRvAf+L0Qw2GEYA8uFAiXrufILeFj2depnhzikxEj3QIDK6/49lSgk8KfRn0q0
wUn//JbsvdR8gAv8FFCcnLyflc6RlqVgym+qdUhnLOWCX2eqjBy1/x9Us3PCOOZS
+8Fy/U3cATy3yvn38dJ8QLkyW9/7poDYv3FB5HvJz8DskevonzXSJvcLJd3OnrkD
/Jy4QUDd+GSsU952GLFvtUgwc7wdHF1NBpKQkR3Bmk0c8nsuht3dCB0CNAV3F/4L
2LIrzgbyVnDaS/8EdkGel8q6xD9bRq3mCG/HnGSd+TEKk1IJz34ingrCjdcFN5eT
2+txyo+MTPFoSeUocKh94MfcK9X3ow==
=kVsq
-----END PGP SIGNATURE-----

--HT296jN3UK4qLfC2--


