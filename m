Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A842C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 20:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uO0Pz-0002x7-Qm; Sat, 07 Jun 2025 16:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uO0Pw-0002wr-8o
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 16:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uO0Pt-0007UB-VF
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 16:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749329122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LNhCUSkYlJ2eCuzMZO1A6x4PCyMyRT929ivTnos7d64=;
 b=ManfYhR/a4WhRmYJsv/oYocu4clnuu7oHD5k5vVsPZMhcH1nSXEjj3eoE4D5IkBVsW1RW7
 +ctU12tYMGi6Q2A6UflCJ65/0RbMl2Mo/qA/KVhelPZQRk1Q0KZuWAkjm5ubL/DF+Chyx7
 4sRZuQKchPnZW/6JihQEwv9n6cEesA0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-whpZgus5OMKWXBZ3RNBB3w-1; Sat,
 07 Jun 2025 16:45:18 -0400
X-MC-Unique: whpZgus5OMKWXBZ3RNBB3w-1
X-Mimecast-MFC-AGG-ID: whpZgus5OMKWXBZ3RNBB3w_1749329118
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A89A3195608C; Sat,  7 Jun 2025 20:45:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 127EE18003FC; Sat,  7 Jun 2025 20:45:16 +0000 (UTC)
Date: Sat, 7 Jun 2025 16:45:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 00/11] maintainer updates for May (testing, plugins)
Message-ID: <20250607204515.GA556960@fedora>
References: <20250607154404.3810570-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AUeulAnv4Tji0S5J"
Content-Disposition: inline
In-Reply-To: <20250607154404.3810570-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--AUeulAnv4Tji0S5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--AUeulAnv4Tji0S5J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhEpNsACgkQnKSrs4Gr
c8iYIwf7B/3ZMZFmLkvnQ+J02ByvJVnhoe+vWVV0wl+d4fjPwtOhYV6u5WSDmfJ9
x5N0rzWpO2Szx+ro0XrTaRyQbIKosZOc4JHC7bfe9XNEutm84PjJTNMYlnOCQByH
hmFV8bSUqZG4NmxbpMFXz+eCGF3hZb73yEy9r9ueUAwl2543kt0TLhJZa5MVHEtW
TTh49Yguafu1fpOup+cvVki2zaqw4+hJ283SbjpfymAZkUDjuHUHXlud4JbogRBI
reBGiNxWO+FtNile5AgXay/L1jZPpUZuj2J2P6eyYZscOa5V2INa5Q1fp2CMMhoM
sDVw+Kb+mXSF9t73DrCxHfImklQhnQ==
=Mdb1
-----END PGP SIGNATURE-----

--AUeulAnv4Tji0S5J--


