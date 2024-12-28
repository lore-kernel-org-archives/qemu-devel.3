Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB372E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 18:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRb6y-0002r6-5N; Sat, 28 Dec 2024 13:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tRb6i-0002ml-11
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 13:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tRb6c-0005xl-Ht
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 13:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735408804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+0rS91l/fZ2E9Vvjp5ubIjNqc7c2BhUyMszT7r2gXnU=;
 b=fyO8hUZ0HCGjCF07bg9hy9/fcC6yqNjKv3rG4LNJZtkLPKJCuIlE+FsmdharV3qjd5XqIe
 Z8NpNz3MutSm6ZvaLM5fe78bfKT/d8J/j1RONykOF9le18p53U2WjzIPo2l4MPLThwC4mT
 NwJrfpIn2268EiqoltkSAhzUYSUZwyc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-BSL5GvG2MzWo5lt-L0SVyw-1; Sat,
 28 Dec 2024 12:59:59 -0500
X-MC-Unique: BSL5GvG2MzWo5lt-L0SVyw-1
X-Mimecast-MFC-AGG-ID: BSL5GvG2MzWo5lt-L0SVyw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B17F01956086; Sat, 28 Dec 2024 17:59:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BBBF19560B1; Sat, 28 Dec 2024 17:59:48 +0000 (UTC)
Date: Sat, 28 Dec 2024 12:58:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 00/11] Trivial patches for 2024-12-28
Message-ID: <20241228175827.GA1024359@fedora>
References: <20241228115446.2478706-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nX4/hvIHGZ5V5RAS"
Content-Disposition: inline
In-Reply-To: <20241228115446.2478706-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--nX4/hvIHGZ5V5RAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--nX4/hvIHGZ5V5RAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdwPEMACgkQnKSrs4Gr
c8hs7Af+JmR0dAXZP2zqwdDn9G6Yo8MtkyyM+JmUVPu/os7wSq6SNr78HO6bs6sh
iI3wag3EahabtfIrEGYD/t3bkqeEH75HbIBZw8ylTill9+2hjYoViQAf/qObHGIo
vM8NHyDrif3cpJVlL4wXTSA3cl7TPIdsvhQuahYDkZ+TDpQfRHlvghCYLQJEXZb7
NswGqn1wlHh5ObZOlR2uo0ptB2wqZELMFVTNZ42co9m0JeHl++0aKBGoJN89ekS2
ZS97PriUYgI5bCI8lpSRIUroi6vNV5sS/rmCsli5QWQ6c7nOA2N+8iRMhPRWKZ0p
rlV40VebFxyters2pB8fT1ONHZEBFg==
=Cd31
-----END PGP SIGNATURE-----

--nX4/hvIHGZ5V5RAS--


