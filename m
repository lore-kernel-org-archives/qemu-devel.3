Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35F2E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 15:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQSsJ-0001St-HL; Wed, 25 Dec 2024 10:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tQSsF-0001R6-Sp
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 10:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tQSsE-00051e-3e
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 10:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735138825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLyUAuNtZKW+Ol+IOS29wOr52TusHkygG+/ETFQDJHE=;
 b=O8ZD/rcKEoYXvohyl5n/p6vtGrvt02zXP1MueAMHBWtbhQ0GSDNy1kS7fbvmnyanq+z5Xe
 Csbkm01GIS/Ku9ryHjvezv8d6PYJiu/whENY6MYJbYRTwczpXFm4R2JeIobZKrRH92dfK6
 wUaHXHCz47Rb6RrSUwBCHS9GgBbgWsc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-Gq1PZBc9MwaA98cWnFkygw-1; Wed,
 25 Dec 2024 10:00:21 -0500
X-MC-Unique: Gq1PZBc9MwaA98cWnFkygw-1
X-Mimecast-MFC-AGG-ID: Gq1PZBc9MwaA98cWnFkygw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6100019560AB; Wed, 25 Dec 2024 15:00:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C429519560AA; Wed, 25 Dec 2024 15:00:18 +0000 (UTC)
Date: Wed, 25 Dec 2024 10:00:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/72] tcg patch queue
Message-ID: <20241225150017.GA948538@fedora>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fm7DSnrCmx0HlFWQ"
Content-Disposition: inline
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--Fm7DSnrCmx0HlFWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Fm7DSnrCmx0HlFWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdsHgEACgkQnKSrs4Gr
c8jrvQf4sdTQx6V7Qau3dR39PonayhHOLqD3tM3FsFt7yia/Q9QWpHHU8Psre0WM
X/VynqYVTF8WhdxBuLoWk03vmRwrrHejXJGP7r3AawCAXwXp+WRxnPFSj7MqD0Sh
6G5dT0cUFr4CHdgkRQ7r2PdiIGjdhzfI1zqnZQhWyBzZZvc5ZXFI6WBo5aI2xxq4
U52d+ierGWS0jNQ1552ynRTOLrXncLRgBTeFV+ryuMxv07vH6RG4rl+pyHyFjgak
2VpXjUljA8f48oyJqdV5FBy/hzHTRgNl8gVAcSk8ANSlN0BvH/QC6lnWAEKoxDkH
z4buPrC/76huTP9SfUOjv5MHqS4w
=z0NN
-----END PGP SIGNATURE-----

--Fm7DSnrCmx0HlFWQ--


