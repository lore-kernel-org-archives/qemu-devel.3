Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9655BCD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 22:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVzEC-0007er-1o; Sat, 06 Jun 2026 18:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVzEA-0007e9-RO
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 18:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVzE8-0006IQ-FH
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 18:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780783847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SrPoFaTK+cMk6fS5raD474pg/brgfVe9JO9xQGSvq48=;
 b=JDPug+HqyNTdVOW9xcGWzq4sGFmTxULSzu00sdE6WRy6ixv9swAonlJUH8hWyYqOixbKMq
 zKusqRkgBN6zKN7s0aX4X4CuNb91dtWJt2E/ZsBOs+eZusU0plA/5aVBuzI0A4eaiKWFM6
 wRWQUkDIZb1o0uUjRqr1FVBEQcjMGmo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-6Q-reWsKO3eSsuvKaa1eCg-1; Sat,
 06 Jun 2026 18:10:44 -0400
X-MC-Unique: 6Q-reWsKO3eSsuvKaa1eCg-1
X-Mimecast-MFC-AGG-ID: 6Q-reWsKO3eSsuvKaa1eCg_1780783843
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A87BF18003FC; Sat,  6 Jun 2026 22:10:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D23D027A; Sat,  6 Jun 2026 22:10:41 +0000 (UTC)
Date: Sat, 6 Jun 2026 18:10:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 0/7] s390x updates
Message-ID: <20260606221038.GA365828@fedora>
References: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="baVOW1ENpJRAoKeN"
Content-Disposition: inline
In-Reply-To: <20260605145647.272621-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--baVOW1ENpJRAoKeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--baVOW1ENpJRAoKeN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmokmt4ACgkQnKSrs4Gr
c8gh1AgAyYwq1ki457SwvVUJBoXTy2pSVnsBXEuLd+CbL+ZetAVVezQuUyed5/zi
evFqg1z1LxS/v6LjLl/wFEr6otxm8AABppOnw4HS20Ttt5OmEJLPvF6FdeMFaZwQ
qHEJvYugLStVR9zRHEN4WPFz2arCpIR+3ODhc3k5WsH2AQWOq9QnnJyscrvrd7sz
VG+MF2W6deOPGMDDwhAHH9dAnGmWXxgP9mBx/XoX7CaOJgHeBkXfmIlaGjcgkny3
WwVlpEmwoVPQ38M1mhdAIUfriMRbXfnF3vrPAJcbNKiyyTqyxCjRSsEJn8+Wbzj6
IbhUixURL1afjjjJA5fRh9mKgd2+iQ==
=abP7
-----END PGP SIGNATURE-----

--baVOW1ENpJRAoKeN--


