Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6CBC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueEHV-0007iT-SV; Tue, 22 Jul 2025 10:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueEFK-0006YO-Oh
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueEFH-0003ew-OM
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753195525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OTcc0GDCu71vaCiuDVrPEow9W2Ozmv7wX+MpK97Oyg=;
 b=TNd+Wp4XawoN0ort5SBkFmxspJAdY5JcCMXBK+u4tBuDEsfdzIy9wAuAT+LWDg37jB0Jz+
 rzborHvjtEwUuy0uoVWdho9w0HRA1bDy7GIxvFQPD8ehtKh9Ko4HAyuWJZPpSdoadoLQHo
 M+e4aGkHwsat0c2mk+1h/MXEcjxqY2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-2PiUBvy4ORm31cGjnTbxgQ-1; Tue,
 22 Jul 2025 10:45:20 -0400
X-MC-Unique: 2PiUBvy4ORm31cGjnTbxgQ-1
X-Mimecast-MFC-AGG-ID: 2PiUBvy4ORm31cGjnTbxgQ_1753195519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 722851977408; Tue, 22 Jul 2025 14:45:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E42DE195608D; Tue, 22 Jul 2025 14:45:18 +0000 (UTC)
Date: Tue, 22 Jul 2025 10:45:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH] tracetool: removed the unused vcpu property
Message-ID: <20250722144517.GC8264@fedora>
References: <20250722114352.3624-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hZ38NBZMb8ASKmdK"
Content-Disposition: inline
In-Reply-To: <20250722114352.3624-1-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--hZ38NBZMb8ASKmdK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:43:52AM +0000, Tanish Desai wrote:
> The vcpu property is no longer used in these backends. Removing it avoids
> unnecessary checks and simplifies the code generation for these trace
> backends.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/__init__.py       | 2 +-
>  scripts/tracetool/backend/log.py    | 6 +-----
>  scripts/tracetool/backend/simple.py | 6 +-----
>  scripts/tracetool/backend/syslog.py | 6 +-----
>  4 files changed, 4 insertions(+), 16 deletions(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--hZ38NBZMb8ASKmdK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh/o/0ACgkQnKSrs4Gr
c8gzugf9FQFR3Ljzflbn27A6EcZ5o3q2uTCPXuz6KWjWFL0SDW1bqnRrNjcIRnZ3
/iJOsDfLaw/47mbCfeZO9XtmObKv9QzmA4oLvWm5R5HPOzj67mjY7yeBNRkr8YV9
skCgoQ5CIOrmIF/xq7IUyxo8b2Ds8h4yRSFNA5MKk2GAjTzQWe6SoEQ5oU6R6sYC
jfphfYNnUAfPaw+RHZ/KIsMAfLw/XEdS3hkLaDogb3MGshhDb9uHEYO5+1D5HKJN
N7YD57yzGLz79AOp/QbJ+jPiXNOQbEMDXXKTByMCaBLFwskI5/uV+4kc8mUcxGa7
hy1Mx2lYNlD4nJ52qOGDjcOw3DrMRA==
=HmQw
-----END PGP SIGNATURE-----

--hZ38NBZMb8ASKmdK--


