Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8641BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublnS-000890-3Y; Tue, 15 Jul 2025 15:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkb-0002hr-6N
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkZ-0005Qt-GE
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752609338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nwAoXtg+8ah0z0aDeEZCnN/LpMJa4QJ9o0GQ/mlkdIo=;
 b=BJ8znszs27WSFsysLHGu8EtSQktCfr0S2ST1F8bV0IxK24zFqKDxH+vy8rWnYVkMcs8t68
 1Kzr3nWcpqQhtmOLVRmLa67e1tdiRNuMm6pAQR7rSmAg42vFDGx/eb9ldj+ChnoU+bKGnS
 130MEt2wHZH2nkpKv4TiTUeBj230fYI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-9Iz2TPUeOpOPz1T3y0fuXg-1; Tue,
 15 Jul 2025 15:55:35 -0400
X-MC-Unique: 9Iz2TPUeOpOPz1T3y0fuXg-1
X-Mimecast-MFC-AGG-ID: 9Iz2TPUeOpOPz1T3y0fuXg_1752609333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17AB319560B9; Tue, 15 Jul 2025 19:55:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A740D197702B; Tue, 15 Jul 2025 19:55:32 +0000 (UTC)
Date: Tue, 15 Jul 2025 15:50:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/8] maintainer updates for rc0 (gitlab, gdbstub, plugins, 
 docs)
Message-ID: <20250715195054.GA242470@fedora>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dIgXMtiRK7WvuESe"
Content-Disposition: inline
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--dIgXMtiRK7WvuESe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--dIgXMtiRK7WvuESe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh2sR4ACgkQnKSrs4Gr
c8i4Kgf/fyy5WoD0c8Fg6ZDC7nvzJlw3ZkQpifpn5mt+F8Sbhz7MdySqwdt1e4A1
btxeW12Bh9vE5ZyDOxB8BHIkYf/0lzFdjeobU4YkrJyYEMwnI7y6eLhNVOIm76qc
Ykk+cCl9BRJR7RP5EBLaxkfu6CrGGkV3MpPdft7fHLZ31vYzE65nk0wHx2QZDvNj
kEhvMSZ495bOXfAowQhAL9cGROQR3FoPY5bhC7IUPacUQmjzQWK4nKz6YP+HSnrg
GWCS4jvgziuf51zsWnpGnMxJU81aWWjqDVXFzJnhiA8V9XeDVkjIGG4UUp8csoae
HnT1KmmsOeWUPeKCyIdWRAXViCUOjg==
=PZ9m
-----END PGP SIGNATURE-----

--dIgXMtiRK7WvuESe--


