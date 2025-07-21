Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2915EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udr3P-0006gO-5O; Mon, 21 Jul 2025 09:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udr3N-0006Qo-8K
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udr3H-0003G2-JZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753106373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3a31UyoO+pWK+bF53H9mSuBbl3i9PKg6FwAp95uV1zU=;
 b=Rxn6ESjwL+9Mep1I87SQ/0qUfMMUW7p5mqzMqJ1SZ9MbzmFa4TCFAzes7xRP7Qqysg4Ayo
 i33KIo5+1D0uo4tv2Pv87GV8qRmUZW8qMsU65oFVxNmeMlelUpQDTN1JFf7LLtILBNA5Je
 Ox6hVaII5dLv3zaBALzaUvVHAUKyn60=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-GiFntohZPjikf4bayPTpPg-1; Mon,
 21 Jul 2025 09:59:31 -0400
X-MC-Unique: GiFntohZPjikf4bayPTpPg-1
X-Mimecast-MFC-AGG-ID: GiFntohZPjikf4bayPTpPg_1753106370
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 028111956055
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:59:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8ACDA19560AF; Mon, 21 Jul 2025 13:59:29 +0000 (UTC)
Date: Mon, 21 Jul 2025 09:59:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 00/12] Net patches
Message-ID: <20250721135927.GA51046@fedora>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KG1Am3r/Msmqacy/"
Content-Disposition: inline
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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


--KG1Am3r/Msmqacy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--KG1Am3r/Msmqacy/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+R78ACgkQnKSrs4Gr
c8jsFAf/UYUz50yEw9ierHCNKvdLvSxwqrFT+Vh0Rq9S2UN2jxtuc7Ey+nwbAVi3
Lqa9zjod6EMG29hdwCeCOn6VNAG631u4XmsylRyX388R//a4pouavDeUSSWCfJPn
m6QC00q9T6mLBHNy7mraBS87XZagDYAKmWYhxu/ZZhSpMxu+L9feglBvKWaSOEDp
1giMipecgooPWEbqb04YDtCiqvERK2ZA5svPsc+BvTvS0+uieaHQZvwvRn9i4M84
sQXYAvbi+kOgoiUdlgLChU/z/gzNDM1Em6ncnnwb7YcjaTmCNK8+CsBii2Sl6tpR
pzpqVfr8uBaL35NyMx0kmwU/ILWgng==
=e4HL
-----END PGP SIGNATURE-----

--KG1Am3r/Msmqacy/--


