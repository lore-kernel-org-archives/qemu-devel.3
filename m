Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF086C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGfnM-0003bz-5d; Mon, 10 Jun 2024 10:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGfnK-0003bg-Cp
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGfnG-0003pr-EA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718028879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VVQAU5q7B02aIy7C1pErblWSsN5s1y8XfMDe6DpcDGU=;
 b=bS/sM14sj3rhKDwWdGUG7s/YNfaNuMEGJA4EM0F9yyVMY2UK32p8zlvIUDUEfoEkf2jz1z
 RC8HypxOrMbtAzP0gTiuIX6Xei8dICnbAesRB4k2+4creaUvNjFGk1KVuEOJwEgIMtGG4m
 BusWFUU8Y0v73qW8yks8ykT5ZZ87QAQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-8kednBntNK6ZJaNsG_RLpw-1; Mon,
 10 Jun 2024 10:14:36 -0400
X-MC-Unique: 8kednBntNK6ZJaNsG_RLpw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F67D19560AD; Mon, 10 Jun 2024 14:14:34 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7669D1956087; Mon, 10 Jun 2024 14:14:32 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:14:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] tracetool: Remove unused vcpu.py script
Message-ID: <20240610141430.GC313831@fedora.redhat.com>
References: <20240606102631.78152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9e59mGk9aI6PlFeJ"
Content-Disposition: inline
In-Reply-To: <20240606102631.78152-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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


--9e59mGk9aI6PlFeJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:26:31PM +0200, Philippe Mathieu-Daud=E9 wrote:
> vcpu.py is pointless since commit 89aafcf2a7 ("trace:
> remove code that depends on setting vcpu"), remote it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  meson.build                   |  1 -
>  scripts/tracetool/__init__.py |  8 +----
>  scripts/tracetool/vcpu.py     | 59 -----------------------------------
>  3 files changed, 1 insertion(+), 67 deletions(-)
>  delete mode 100644 scripts/tracetool/vcpu.py

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--9e59mGk9aI6PlFeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZnCkYACgkQnKSrs4Gr
c8gRawgAjOOU/NLhR1F8p2neGcFctYIPp4HMszw0tZis5pB4h0kf5PTd9f5fHu7H
ikIwLfXY3REm8qdmfmD6M5siSJS4KFbqI/c05CvSU3ZVS8Ll8pZmbQuXNUFPM8QT
FrNFnaTk/rzQaQvqrJm9LlcwJel0gqzGA1E/O1JOSixSIyzOdXHjiVgpQLkqkny3
Uid6PJ5tbO8oTgcO6F+8fZcKMrJY+YKOeWEcNk0drvb/wirCLjOWW/Ojxizc1usy
5T85wHZlcwDHW4FMAnpmt2DoXaGb9cY+0Zt4+4WmBSEhKD9NDKzJf0M0x6K08bml
8cUDmbEs9FL1y2kWFBxbt0NNns3LAA==
=loZ0
-----END PGP SIGNATURE-----

--9e59mGk9aI6PlFeJ--


