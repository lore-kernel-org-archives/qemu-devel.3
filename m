Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0332C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV70-0006Js-2d; Mon, 10 Feb 2025 09:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thV6x-0006I5-TQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thV6v-0002kC-3r
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739199007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nVbojvHLdslT1TAyMVvdj/of5DJ7diTZnVGJH+8VGL8=;
 b=JM0Qb+nPtsjNmeKniIJty2OlOocrQGn1Po9HY43jViuTP2r4NkhUq8gHQerCE77Jmf3iYm
 GsuOVMFkNipNPLIM9eWGyyvzq/q+H1ctv80qVf0rLL8n+QFLX4Y5/dHDi6umqSoZ2RQ1Z8
 WffBzxCq2GAyWqWAPgJQkeyMN6Nj+/k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-w7avR4wKNsS1Ch33gYULXQ-1; Mon,
 10 Feb 2025 09:50:04 -0500
X-MC-Unique: w7avR4wKNsS1Ch33gYULXQ-1
X-Mimecast-MFC-AGG-ID: w7avR4wKNsS1Ch33gYULXQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A226D1800874; Mon, 10 Feb 2025 14:50:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 109C91956094; Mon, 10 Feb 2025 14:50:01 +0000 (UTC)
Date: Sat, 8 Feb 2025 11:08:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/6] Hppa system for v10 diva artist patches
Message-ID: <20250208160848.GA59561@fedora>
References: <20250207210540.24594-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f8iewb7HTMEvJSqj"
Content-Disposition: inline
In-Reply-To: <20250207210540.24594-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-1.388, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--f8iewb7HTMEvJSqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--f8iewb7HTMEvJSqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmengZAACgkQnKSrs4Gr
c8hgWQgAkWXOEJwly0W8p4Uj39Nwq2UnwYlsGs22UaoDSsJD6rfM8IYmGbMJqWLW
sTtyUUEdVIsy8EjTn1nqoYUmNsZpNyVMmhxju26+l7Dj2wtcjE3w3EHmzTjWWo7L
NOf4TfNoBZcn9sC2bOKOSFjoDj4MjpKwMB90BqmFDO25kxMQdfqc3/fWRu1c7VW7
CTKuj9GWTPsTwpvjqQ+r3/Mxho23WJw2ScyuuwFnFyCRKQ1Lov4m8MGWN+BYHH8t
MEwTJHLdr9wBlAmyBXEKX4Ghp4OGUeWXgHZO6cQwpDPtgKYWgdUnpW56HYhQWzDZ
f5Zra5/+QFhMUX7cgqa8Y6CsCvuqsQ==
=Uqy6
-----END PGP SIGNATURE-----

--f8iewb7HTMEvJSqj--


