Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C9FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxyh-0007SJ-7u; Tue, 07 Jul 2026 01:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxyf-0007S9-6K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxyb-0003kE-HH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783400647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6izy6w+2fBXYIvuI36Jsa2Uu7a6JsED6koUXlxer84A=;
 b=iAW1QOpmfIwl0Vid0CN3o5TTDShUxJRkAuTZvCPfo8rsQpEOmxeJfJLO+cmtmSPKNwYymt
 kHCxOVvqp/cHO+PtfWHm97OKg96Tbi4RYe2F1OG9Gn7ORD6r8ZwxVLAIIuRYYFHAp+Yyqq
 /pWM78P9yelscssmkjHSK9fCTzMp/2k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-mW7GPFsqNQyMrg86rMHgEQ-1; Tue,
 07 Jul 2026 01:04:04 -0400
X-MC-Unique: mW7GPFsqNQyMrg86rMHgEQ-1
X-Mimecast-MFC-AGG-ID: mW7GPFsqNQyMrg86rMHgEQ_1783400643
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68C11955D59; Tue,  7 Jul 2026 05:04:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 087EE1955F71; Tue,  7 Jul 2026 05:04:01 +0000 (UTC)
Date: Tue, 7 Jul 2026 07:04:00 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com
Subject: Re: [PULL 00/44] pci, vhost, virtio, iommu: features, fixes, cleanups
Message-ID: <20260707050400.GA524460@fedora>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SwGaqw8lzzDGXB8H"
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--SwGaqw8lzzDGXB8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--SwGaqw8lzzDGXB8H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpMiL8ACgkQnKSrs4Gr
c8hBIAf/WkRQUkniK7dqIuyvHMMBz0RpXWVFBO7vXQ38LGUB49T5Q9GlW9zBXYGc
I6J9VasNmx5tsL3IxfY8z5Quh0o7zE8mLWuVss6wWX/mT/zn3DVOQLC1LbdETSX2
3a0Ght4jkABio0+5xUfimD0fbuPvp9v5tUnYjomPM8heUURMeWYM0VWWJCpBl/BS
jda9FzYDKG3mpcjHFf4uUuUy0fVoxhJoTW3VySDSXRsdybompdkk69XZlt+/liGn
nQYCAlQwbU4J2mv+4nYT4MXEcBpbqcTOoapUVwPxM4t/JJltQ4ixz3xzhbIUMVI9
hGvYKnkXgk0dVwEhm/pOLk+MZ1De/g==
=FoSB
-----END PGP SIGNATURE-----

--SwGaqw8lzzDGXB8H--


