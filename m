Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4B7E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 21:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPT3G-00042f-1P; Sun, 22 Dec 2024 15:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tPT3D-00042V-By
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 15:59:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tPT3B-0002lP-3o
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 15:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734901182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sv9mVOhOOhyuS1J1vP/COddgWZ3jWiAGQRVcBdvA0jo=;
 b=b6F3fjxRpjFsB3F8fDYgJZf5gYko/zeCNz5qVq7+0hd7+aqvnYW30xQsk6wezvDpW6kWy/
 kq0jVfbPod+hxIPHrvnw38tl8ex0rZbLTAmIlM8UUIKB8Ikw9eYu+xp2pX5ANu/vecRAH8
 t2qV7LZltxwXHZzgMtnEyVbE2tPxjMY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-tOYGxEeNPAehL1HlMEpuMw-1; Sun,
 22 Dec 2024 15:59:40 -0500
X-MC-Unique: tOYGxEeNPAehL1HlMEpuMw-1
X-Mimecast-MFC-AGG-ID: tOYGxEeNPAehL1HlMEpuMw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 421161956089; Sun, 22 Dec 2024 20:59:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31F001956086; Sun, 22 Dec 2024 20:59:35 +0000 (UTC)
Date: Sun, 22 Dec 2024 15:58:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PULL v2 00/15] Host Memory Backends and Memory devices queue
 2024-12-21
Message-ID: <20241222205831.GA872476@fedora>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QfyyuTFZQJ1TY2uV"
Content-Disposition: inline
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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


--QfyyuTFZQJ1TY2uV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--QfyyuTFZQJ1TY2uV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdofXcACgkQnKSrs4Gr
c8iveQgAjosMtlSATK15uZBcQHTNwLBdM1XqVz+RbTPpeThM3mc9Lx9HQRMq8ISw
rrKss0Tig8fe3/ZdTcCiH3hUYO/peei6EQSMcFSspdf7p4PVgz3o9GPf28DXTHvS
ypHiKYrvrzyLzpfVIXNLWek+jziYlo3B5/e1Rityd0ARnBtiWCPmxRRpKxvJjBE7
Je3CXArkKrddByaRsKiv4IDk3/xr4bsXlAT3lABwi7iyb0rcC5w3Pa+CQwEmIfDs
bhwCMJH88ZOF1kwoGp3kVihJkh99bcfhLAxaT8Pg2XVNcd26MDK7RBuO9rkQRT9E
xjUXuQZJdH/w/4dPtkTiML5UgOR8ug==
=MWtF
-----END PGP SIGNATURE-----

--QfyyuTFZQJ1TY2uV--


