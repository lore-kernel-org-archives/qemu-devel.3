Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096E1CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3CK-0003Es-AR; Fri, 29 May 2026 15:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3CI-0003Eh-J6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3CG-0003ys-UJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780084122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7D/+vPdwhJheXE7YtF3tYqwwDxFglmpxGN/yyA/lS8=;
 b=fGFEk6u5gdadehZbSp5CDL4p8/JLtlONSLm1ZlAeFUHCQg0YpMRVCJGDEWvypc6Z9PYNVz
 M6J4Q90ckQfu0trtTgGRG2JcWXu2BV70tpbXh5akNdCLuofGor0Q6SZ4Ja1q1O/EVktGQv
 g9c2lu3unaVVOh+lsPbPkvsZcEBFbnw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-DV0H6owwOi-7aF2SxG0LIw-1; Fri,
 29 May 2026 15:48:40 -0400
X-MC-Unique: DV0H6owwOi-7aF2SxG0LIw-1
X-Mimecast-MFC-AGG-ID: DV0H6owwOi-7aF2SxG0LIw_1780084119
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F009019560AA; Fri, 29 May 2026 19:48:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 971C41800347; Fri, 29 May 2026 19:48:38 +0000 (UTC)
Date: Fri, 29 May 2026 15:48:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/22] Single binary patches for 2026-05-28
Message-ID: <20260529194837.GA200016@fedora>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OZ+hZ9IUvMoh0UvD"
Content-Disposition: inline
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--OZ+hZ9IUvMoh0UvD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--OZ+hZ9IUvMoh0UvD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoZ7ZUACgkQnKSrs4Gr
c8jI1QgAkRNEtjFWVUJhh/qdn/u8AluJb15OFxseO/W/+/o7EiI7dCwJ35ShKkXm
Fsga4qcqUdLQoKtVAmQw2XxW2qjsSHameiupIhpJCdqyfWNjg0nWirRjgsHXILxo
QaKJaj9tZvQvUx95oJViuKakRGrTRfLKrxLEzUh+eoI/K+xUjGRTKsTjO161A2eM
RissLR28SBmw4TTi7vNfohlWZ79zCBpMdRS0pyo/AB4h7Hh78J6sC13srUk6XHwh
1Rhh9F6UYk8LxhnM60Lab44leXenxx+25kr24f/7xCytNRRcyLNs9B8fekK2V5Ko
W/C4Abi4NoECzFlmro7xg8cIEynORA==
=/jjw
-----END PGP SIGNATURE-----

--OZ+hZ9IUvMoh0UvD--


