Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCBFC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 19:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFWU-0005Do-Np; Fri, 28 Mar 2025 15:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tyFWT-0005Da-JD
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tyFWS-0004ar-5S
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743190662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2H+9ZmruxbOzrNauRCok2d6igIAipnkLWNmuQ0j+2Bo=;
 b=BvXZtJQp1mOeUWSbIJYipGmKMugEjUYHiPGo3MSaCWgtmKjM8XZhvHhmxv1n42LyTKOD/R
 yDZf40A/U2ADYbrQacgxJ4YsywPg9uMFmqoDjexpFFvlYp2Wj4YInEl7tc7YSnJaT8KvET
 XLa9IRJD8Tvo64kayPzUYictAzdlsfY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677--HrQFXnOOeCwWTiPlXcsQg-1; Fri,
 28 Mar 2025 15:37:37 -0400
X-MC-Unique: -HrQFXnOOeCwWTiPlXcsQg-1
X-Mimecast-MFC-AGG-ID: -HrQFXnOOeCwWTiPlXcsQg_1743190656
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F379196D2DE; Fri, 28 Mar 2025 19:37:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.238])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E50E180175A; Fri, 28 Mar 2025 19:37:34 +0000 (UTC)
Date: Fri, 28 Mar 2025 12:36:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 0/3] riscv-to-apply queue
Message-ID: <20250328163637.GA76664@fedora>
References: <20250328065318.1990698-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kiAl76ncsR/5qtPG"
Content-Disposition: inline
In-Reply-To: <20250328065318.1990698-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


--kiAl76ncsR/5qtPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--kiAl76ncsR/5qtPG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfm0BQACgkQnKSrs4Gr
c8hUbggAgwiy/dZ0D4qowVN6t1+DLEjpCzXCa3IZfOe84nzRxjYJiStrCDa5OSpq
9/eALk7uDInfvaflwhS8R2ZF45fiTCe1i4xdq0HPyrIpyy0p1TyKJuD3vI0IBHEG
slcTcKPufRC95tjLPLiesr9S8v1ooe6jkvCYJ1H2hK7/ePGuSEDkL/ylEpAGJyB2
hwXJTHhl85NmIBFVOaVko5J88RcRnwg5nOab7QIdnEPI7Dz6Aft4okXNFFUsKBB0
HtjXZuvzVKyp5Zbk0hTP7J6HHy/dkIf9kUEuxardHi1jEjAkJW9qJs4yraASil6y
qb61bqXXnOIbLwsRbVEahK7Njimp7Q==
=fRWT
-----END PGP SIGNATURE-----

--kiAl76ncsR/5qtPG--


