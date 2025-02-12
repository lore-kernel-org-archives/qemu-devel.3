Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60600C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEJa-0005c1-OT; Wed, 12 Feb 2025 10:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiEJX-0005bT-E3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiEJU-0005YT-Ru
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739372768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W6CTmRwq+Skwd2IKaARs9NcC6tO589tsiaGsq5jbeQI=;
 b=GJkYatNd1t3aSWA4qz/pIX9ITXxzHvw1f3XJRvJGuEc5Uif+NS9oYCu5UUXk1XsAOi2kj5
 NXh4AD3AQOXZckvGBR+u5t3+w72MQieRE4kR7OLKj5RnHiYFmigQPTqAoD3EV/gsuWktwX
 Hgzn9OgLH1IYj4kspOk2nn6D/8+H86I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-WiKMdW1rMlmEy1yheV-sqQ-1; Wed,
 12 Feb 2025 10:06:05 -0500
X-MC-Unique: WiKMdW1rMlmEy1yheV-sqQ-1
X-Mimecast-MFC-AGG-ID: WiKMdW1rMlmEy1yheV-sqQ_1739372765
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A051955D68; Wed, 12 Feb 2025 15:06:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 856B71955F1B; Wed, 12 Feb 2025 15:06:04 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:06:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] scripts: improve error from qemu-trace-stap on missing
 'stap'
Message-ID: <20250212150603.GA202073@fedora>
References: <20241206114524.1666664-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wENf6l5npP1QeVBk"
Content-Disposition: inline
In-Reply-To: <20241206114524.1666664-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--wENf6l5npP1QeVBk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 11:45:24AM +0000, Daniel P. Berrang=E9 wrote:
> If the 'stap' binary is missing in $PATH, a huge trace is thrown
>=20
>   $ qemu-trace-stap list /usr/bin/qemu-system-x86_64
>   Traceback (most recent call last):
>   File "/usr/bin/qemu-trace-stap", line 169, in <module>
>   main()
>   File "/usr/bin/qemu-trace-stap", line 165, in main
>   args.func(args)
>   File "/usr/bin/qemu-trace-stap", line 83, in cmd_run
>   subprocess.call(stapargs)
>   File "/usr/lib64/python3.12/subprocess.py", line 389, in call
>   with Popen(*popenargs, **kwargs) as p:
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib64/python3.12/subprocess.py", line 1026, in {}init{}
>   self._execute_child(args, executable, preexec_fn, close_fds,
>   File "/usr/lib64/python3.12/subprocess.py", line 1955, in _execute_child
>   raise child_exception_type(errno_num, err_msg, err_filename)
>   FileNotFoundError: [Errno 2] No such file or directory: 'stap'
>=20
> With this change the user now gets
>=20
>   $ qemu-trace-stap list /usr/bin/qemu-system-x86_64
>   Unable to find 'stap' in $PATH
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  scripts/qemu-trace-stap | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--wENf6l5npP1QeVBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmesuNsACgkQnKSrs4Gr
c8gz7AgAsQtOuYni6Vy9sU+dKlcSXGgH32GXqt2ZxmgAmmxYTI04aYn8ElItkxAH
SHFbfAvdOxHrARjqAODAwooAgcLlC82fFcETxSy9coiR9G2onhM9A8AbwEFnXesI
e2VvpU/p1YBpQtIGUuKiXgeLMnj435MKE2SVaRSWysvFzWonnycNIterkVLsZoF/
08ieyJ/RTUFMEuWO89pIlWfWHcOUR/ALex1yZa8k7a0+Gj4z+45/HZX7pB/0BHe9
SiVC0jXrnR2ulLt2ZOP8MoUzHr8aD9M8zu1XoI2wq0dkBrCYv+IR0FFy4iX2f0qX
p/aPRZUALLs+sbQNsBegqMY1ZJJqrg==
=DlIM
-----END PGP SIGNATURE-----

--wENf6l5npP1QeVBk--


