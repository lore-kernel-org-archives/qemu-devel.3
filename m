Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B28C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwRt-0008DK-RB; Mon, 17 Feb 2025 03:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRr-0008Ab-Nu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRp-0001zC-OA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739780748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFRAqMjXrBcal1cwlLwxE/5+ZmE0PyV8w6wcxJSSizw=;
 b=YzqGo7pEAlGex023O+8QJWhGPpyD+agJRLsmyFWAFd3gKqVmmLJlHxFY5dJ6NRC1hvlNOs
 HaoPbKzgIWz8dpsXa6El31JzbNP5jPH/9vp7gcU15glRUfdKbacTjv5qHKgIa6MR3hBc4r
 B9XI1Cn9KQr26R/KHThy9Efi4dSkIWE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-WsXlNQYiMMKiDFsBjOLybg-1; Mon,
 17 Feb 2025 03:25:46 -0500
X-MC-Unique: WsXlNQYiMMKiDFsBjOLybg-1
X-Mimecast-MFC-AGG-ID: WsXlNQYiMMKiDFsBjOLybg_1739780745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A25C9180056F; Mon, 17 Feb 2025 08:25:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20CEC180056F; Mon, 17 Feb 2025 08:25:40 +0000 (UTC)
Date: Fri, 14 Feb 2025 11:58:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 0/4] Trivial patches for 2025-02-14
Message-ID: <20250214165851.GA757250@fedora>
References: <20250214055520.3159764-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QZCGoMWnwTZPQTrg"
Content-Disposition: inline
In-Reply-To: <20250214055520.3159764-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--QZCGoMWnwTZPQTrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--QZCGoMWnwTZPQTrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmevdksACgkQnKSrs4Gr
c8idjAf9EVp0r/PykhK6Fgp8XD2x/NgVLiA9jHaYIHyhyPcT5aiZ126ouaTTzZ73
jdRMyGftmnlVtaoYIvz0gA8vyV7/3XTB7bsSN/16+d5TfEfdf1B7CLAIh4Ok8O8J
OKYqZ2KcBdbnyrIjuXp03UmBNEdvljQH+XoN90SrJwxOb720ZB4pgwb/5G+ZRsL0
aKGyLlulTZMIO2AvAdKNelJaFghyv8My8YCbz1nUOKd1m8RcJKpjtlke3Hwl6U5g
2SyFQ4f7vCLOIjnv6TOY63EB04DCYtoAqIavyUGQAHFTlCdgv2EzPgH9TBofiMk9
7pSMNLOEu4dCeMehlQYqn0W6ImzLCw==
=COG/
-----END PGP SIGNATURE-----

--QZCGoMWnwTZPQTrg--


