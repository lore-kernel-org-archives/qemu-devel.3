Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91324CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRPq-0007OB-Q2; Tue, 19 May 2026 16:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPRPp-0007NR-9H
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPRPn-0006dH-U9
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g75etx+MUo2/kkOzIEmqL4O40MCwFOeh/XhHpQvHya8=;
 b=KYWdPc7R8ZQ4mSZB6Jmx93Ws1GkQdpvmMqs6sZSrIbbbAHUrOOgajQOlhuNTnjszx3q9KQ
 K6Z+K1RHCLZqQa5fUqcwtV1BLNLBeHKNMa++g/lXQorAcswtKmiaftl7ZIZHkcWGIFWeJu
 5A3K5F2HS1A/ebwM3da4i4vi/BdtcD8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-R2X1hBRRPEyR-NCeh0K_5A-1; Tue,
 19 May 2026 16:51:43 -0400
X-MC-Unique: R2X1hBRRPEyR-NCeh0K_5A-1
X-Mimecast-MFC-AGG-ID: R2X1hBRRPEyR-NCeh0K_5A_1779223903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1ECC18005BA; Tue, 19 May 2026 20:51:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10FA71800576; Tue, 19 May 2026 20:51:41 +0000 (UTC)
Date: Tue, 19 May 2026 16:51:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/18] Block layer patches
Message-ID: <20260519205141.GA340914@fedora>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BPjDH2A3J37Ca3Pj"
Content-Disposition: inline
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--BPjDH2A3J37Ca3Pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--BPjDH2A3J37Ca3Pj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMzV0ACgkQnKSrs4Gr
c8jGRQf9E1gilMZD0roJeQLOF/RnKJgsU/EDf+1gYDnaqR0j2hH/H0FQBFf2RSYQ
+uneNHxN1ZfkPXtYK/a+X6yKAvS3NVEmeG7XNgrfMvQBgSzc20glxtTmxoL20ibu
6OQG+TW23EGcWjg7Xm4VaKOf+6ejdCu+BS4ImX3dEd2CVTQgoTJcaY97vh9HtrZl
xJBnsQXBDLR5hgT+VV9BvjKY/cuyR2v7b0W+eD0LrPhfGb9dB+sFAwoVjKQwdrzn
19IoljW6+0mUgEYzBHm4WtkrYGybezNc77mFyOPa4o0pncV1V908Mbq97rOsGFt6
c+7CSbV/QWxIH0OKaQHuw8tWmj6LlA==
=3ArF
-----END PGP SIGNATURE-----

--BPjDH2A3J37Ca3Pj--


