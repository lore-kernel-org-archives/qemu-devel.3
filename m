Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E9C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS7j-0002x9-7d; Fri, 07 Mar 2025 02:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7h-0002wj-5s
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7f-0002Fi-HA
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741332474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L+3fwK4Er0PmrLQEgJMd+jvGcO1qtjtABAlayltj0xw=;
 b=ACZXbw283oF1coCo+wo58eoDboZMidklEByzRNJt/cHCOTt9YccRLCEH2c/mCBpRKMmplz
 7e8SGjauvPOd8+iJ64ybjxOqrh3DzqcGdvRJQUNdqG8u2P4xINmp7TemtooX3dONjUzGuz
 Mx6mjPeq3nYIs3stdeR1j9FGkKSCVwY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-chn49gpWP2K5vJwhLX64pQ-1; Fri,
 07 Mar 2025 02:27:49 -0500
X-MC-Unique: chn49gpWP2K5vJwhLX64pQ-1
X-Mimecast-MFC-AGG-ID: chn49gpWP2K5vJwhLX64pQ_1741332469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE7F1800349
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 07:27:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59A68180174D; Fri,  7 Mar 2025 07:27:46 +0000 (UTC)
Date: Fri, 7 Mar 2025 15:18:19 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] NBD patches through 2025-03-05
Message-ID: <20250307071819.GA362024@fedora>
References: <20250305230542.2225013-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LU8b+d1d9n3cm3o0"
Content-Disposition: inline
In-Reply-To: <20250305230542.2225013-6-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--LU8b+d1d9n3cm3o0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--LU8b+d1d9n3cm3o0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfKnbsACgkQnKSrs4Gr
c8j/2gf9FXbIc3EedlOQDNxmIOh7xioQjKFYmZUjiLgHisASEbTFWVlwctypOoSe
FlGljMxfAZyI/4fQxdswmSN6QaAIN7hrfS+3ejrHM9FUw9ceENL5WwovcLwn9xn+
5tqx1Cg2w8Kw4tz76MAKIVE7N/YiIM8NMMYcn06A3vfdcTNaqODUK5y7AC7f4nm3
dvgTUt1bDErKqkysJErrO3GOGLAlOQ1HfiIlb/5UTRzvwTCQR4cfESmLAqIHfyvz
RqM3ngvRGDlHrAdTOfGKZDDOf8994k9WKyPy0CL8iOvJKl8gZsn1SKWFFlW8Y3qI
kJS+1pVe/CgRwNhSE++H7okmXVQ90Q==
=LrtT
-----END PGP SIGNATURE-----

--LU8b+d1d9n3cm3o0--


