Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EEBC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCuN-0003VL-QP; Tue, 21 Jul 2026 12:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCto-0003Nn-Ry
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCtl-0005Np-7t
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mdRlkItxOHwe3wn17O77Ka632IBegG52pDUfY0QxwLs=;
 b=b+TrgCq1UEZ+P59gOuM+Pa/enqsl8q9TwTT/ry/iNbjzD4S1hwjBfjr2QXwH5ZfNegY1bd
 ul620BW6riBpaYNu6cqaAvKi5mVpqMO9t8PLrkTPbPnHrQVIMFoMfWhr+Au3A8A2V7GK4u
 Kz6O3GRzGCgq1GPym4GP2Di0/axCBV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-xnC40PEoN0C71A4MZ8RzlA-1; Tue,
 21 Jul 2026 12:00:43 -0400
X-MC-Unique: xnC40PEoN0C71A4MZ8RzlA-1
X-Mimecast-MFC-AGG-ID: xnC40PEoN0C71A4MZ8RzlA_1784649641
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 781F91800590; Tue, 21 Jul 2026 16:00:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2AA7159E; Tue, 21 Jul 2026 16:00:40 +0000 (UTC)
Date: Tue, 21 Jul 2026 12:00:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PULL 0/1] Block patches
Message-ID: <20260721160039.GA208425@fedora>
References: <20260720182950.176197-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h8mFC5zNdKG8Udz/"
Content-Disposition: inline
In-Reply-To: <20260720182950.176197-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

--h8mFC5zNdKG8Udz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--h8mFC5zNdKG8Udz/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpfl6cACgkQnKSrs4Gr
c8hgewf+K95Y2aJQprcdzKnlvGNH5iEV7MlLqMeo3g8+ph/x3A3GHianetzc0N30
m4vC7nc7jHwzGitWXq6mjemjsCy+Vq31oAg7LYcIUWtte6QSTSb/jc+AyBPZkOWF
NSBnZpr4jiq4n6psjEQ7V/aNtQgngA699Ny0o7DSALI+vxWWJ/RKJBsmEzU3xU2M
p1a/10oAetdGkCTFO/1n8p7VZxHFmM/OSjGCQuGpL8nJmZeU8QJgDzlkxCGpXG/W
KqbU7kc8hEtXeBmtbaJpJXAf663nAuu7ziCpGatAgnGgW9U0S0cnGmdK/ei4dwTq
tRGod8+4galrQLN6zF+4DT7aIvBKPw==
=l4hJ
-----END PGP SIGNATURE-----

--h8mFC5zNdKG8Udz/--


