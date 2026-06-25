Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE4BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd79U-00059p-EQ; Fri, 26 Jun 2026 10:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79T-00059P-C4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79R-0006w6-8j
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782482602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1hzG2KBGvobW0DOiL09chPyvUxTNVFjeABERQ8QDdE=;
 b=WeYnI8C8bC0z3slj2wew4sRNVeCHjtU/oTLg2lNT9xTxyTXhnvk/RcUZ4zFi5eheiWaaNY
 7ahZ1ZbEBKv7uKFi0TyChTnEaaC6oQZmE1JOgQS/v/VwwN5gPs1Wfi5zkduSToGXBEHuKr
 8lUIAo+NAbdkvQCk6JW2REXNcWLCuDg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-2g1QV8DzMYSVlkmCm1sy6g-1; Fri,
 26 Jun 2026 10:03:20 -0400
X-MC-Unique: 2g1QV8DzMYSVlkmCm1sy6g-1
X-Mimecast-MFC-AGG-ID: 2g1QV8DzMYSVlkmCm1sy6g_1782482599
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6225B1805C14
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 14:03:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.186])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB818180049F; Fri, 26 Jun 2026 14:03:18 +0000 (UTC)
Date: Thu, 25 Jun 2026 18:53:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [GIT PULL 00/35] UI patches
Message-ID: <20260625225339.GA278650@fedora>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mjhpPNnpvLaR9rNC"
Content-Disposition: inline
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--mjhpPNnpvLaR9rNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--mjhpPNnpvLaR9rNC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9sXMACgkQnKSrs4Gr
c8hKwwf/YebYb+dTlC9mp6bLwkyDh/6Wrj/N6XiCBSy+oqna4QzMhZ5U3Z5G5x9Z
5O0CTfkIVPiug32RUFISjGYYEf1ZZhzwjwv4U2hBZh6MNmVrOUBC+Gno/NmgCGED
15qL4d71ejejV13renFPYEt21bNSg2885ebF2L/iAynoZHdccTMolYdqQCy2FjYI
4X5xyRV6zbmwsU69qzH11WKYxjGaKZSftfplbucnByKHLGvExU9tWNam2+myBUD2
IzhvJp/OmeEG7XGfVCarUGTIMTDq1qiCS15wf3V3qxZKYl8QPvbvTecGmQr2Yv2v
QmRfnKKF0g+96BeRXF/aqYP8nQIHSA==
=+iSC
-----END PGP SIGNATURE-----

--mjhpPNnpvLaR9rNC--


