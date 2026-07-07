Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F01C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Ki-0002St-Ph; Tue, 07 Jul 2026 13:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wh9Kg-0002Si-Q0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wh9Ke-0003PI-Qg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783444299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/MKFuqXMIo/tgz49v1cSE6SbmloBI6LHu1JqnY97z0=;
 b=IDQtXr8oRGyhw+YsER1U0CIBwQZGAxDpCgF3cbRr2sV8nTngVIAZnuC4ZgNQaUFqAQlrmC
 qeAHdb/kkfJReSnNjh2p7h3q7yDIAMpgW1P5TTutjaU245WcOFXws0qoA0n/K5p9JAPjYt
 ous5a+wlMAvb0XKi62UmSeZB/U6QNR4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-7ZVFDAcmMNSsznBqysUdfg-1; Tue,
 07 Jul 2026 13:11:35 -0400
X-MC-Unique: 7ZVFDAcmMNSsznBqysUdfg-1
X-Mimecast-MFC-AGG-ID: 7ZVFDAcmMNSsznBqysUdfg_1783444294
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0F5D1955F3E; Tue,  7 Jul 2026 17:11:33 +0000 (UTC)
Received: from localhost (unknown [10.2.17.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEE4E1956068; Tue,  7 Jul 2026 17:11:32 +0000 (UTC)
Date: Tue, 7 Jul 2026 19:11:30 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 00/11] hw/nvme queue
Message-ID: <20260707171130.GA536597@fedora>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iQT9nkQbWYLurEFB"
Content-Disposition: inline
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--iQT9nkQbWYLurEFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--iQT9nkQbWYLurEFB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpNM0IACgkQnKSrs4Gr
c8hPgwf+JkBlHTlcZ9Fqkq3ttYplkUACxL6vnCQc6NnkQFF2t/WTDHpnBIRLIlNY
cYShHnGEATO2Nuye5zVGuFcu312H7phdJMGpkSjdh2Tdh5rWvBvRRXtI+jD/s4wR
na91d72TWHFQoANIVqrVJOhm1VnLny2YlObpTaDXFCiNHKEfeqOZa2FGNx9PqYfx
aY/7BnZYyjEo+p0PLj0eavv6Il5SdmKVYPCFf20kylAT74GCq93npuhiwbMSH10D
BgXkyLOrHvJrEHrFXXcyO2zUmM6trdWUxMRnAwWtSHpgJTxXZ2pZTdMPiRrHVegg
mRfuzDR6YGw/cD7gk3ekPRNuxN2xUg==
=CxQa
-----END PGP SIGNATURE-----

--iQT9nkQbWYLurEFB--


