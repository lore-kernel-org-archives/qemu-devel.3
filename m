Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2EBC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 19:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMu4-0002FK-Jx; Tue, 05 Aug 2025 15:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujMty-0002En-OW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 15:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujMtw-0003Ou-PG
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 15:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754420443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8i8ybnZk8Bz79fc1WArgjK0FCzTCgL7ruvSadp4RN8Y=;
 b=ZeEBE9OY0ldjsFAkO1s9Z+ziMhvW2EbpkSC3OT/z5G49+u7KNVdFm0Z+xMy5kU8tlubqIY
 A5uhQTlHX4VeTrRY0LnnpLQq+gIZIi/dx5ZdmE4L6WQVymwGiGr+Np2sEYFpSjyoJ9JlT7
 I0g5gS0z5hiuKDinx0o16e4UETRCy3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-2XRyAo2DP--Z_UOqquJBuA-1; Tue,
 05 Aug 2025 15:00:41 -0400
X-MC-Unique: 2XRyAo2DP--Z_UOqquJBuA-1
X-Mimecast-MFC-AGG-ID: 2XRyAo2DP--Z_UOqquJBuA_1754420439
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BAD19560B1; Tue,  5 Aug 2025 19:00:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.205])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CEDC1955E88; Tue,  5 Aug 2025 19:00:39 +0000 (UTC)
Date: Tue, 5 Aug 2025 15:00:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL for 10.1-rc2 0/3] doc and testing fixes
Message-ID: <20250805190038.GA22394@fedora>
References: <20250804151545.311042-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0JNp3yo9MgongqP7"
Content-Disposition: inline
In-Reply-To: <20250804151545.311042-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--0JNp3yo9MgongqP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--0JNp3yo9MgongqP7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiSVNYACgkQnKSrs4Gr
c8gVzAf/Sg1AqLjMI7txXtbFM4XY9/AAW21C+hH4Cm35Dx1EueJ1HTtGhTj/sJ3P
qeGmKikfqdG1HpBBohJVAVIqXrhZiYk29Sv9FW6yr26sw+9xP5KxRyF9mewT0M+g
Tb+9jRkBMm3uBoy3NiGcfNaSnDsgNrt1PcbYNNuAB5Q1GiaTyz5/X+l60dJwOFqg
tbkZlA+a6oKJED8t9lPrqNDTkHBhWTG/a04OwGZGxZSyXUNDtES/gUeSfjKaedIJ
h9si0FpGQwKLbmAn1UCr73LsLqdP7ghJL3x1a8y9m170CdQGNItq59CBt9U90kkh
EZ2aNur1Bxp3qPs1QllG9bQKDnDiOQ==
=HWNj
-----END PGP SIGNATURE-----

--0JNp3yo9MgongqP7--


