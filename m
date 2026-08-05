Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990DEC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrPud-0002sH-LV; Tue, 04 Aug 2026 20:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPub-0002re-Um
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPua-0003fK-Hw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785891312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwKpmC/scxQ8GRTaNEWeHM9bj6yijvQy0cSWuTwWdr4=;
 b=gx4W/pQF9nWj5+6ywaUhiChf8bVdGAT2uMoYnK4kwNbgVhmZq/jwBZXPtsNa35KbbJMEbs
 3dJpHyuIhuvffRtYMq9FkRYsONUz8MdUoVOH2tP1HsGO6mWDAU1L34FbuoVBIdvNYWc959
 KKxkEgWsTvolzG4DKvjXyAYaw7cbcVY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-FPRklsZ3PKKiMS3RKt13sg-1; Tue,
 04 Aug 2026 20:55:05 -0400
X-MC-Unique: FPRklsZ3PKKiMS3RKt13sg-1
X-Mimecast-MFC-AGG-ID: FPRklsZ3PKKiMS3RKt13sg_1785891304
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88F0718004AD
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 00:55:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 919F9195608E; Wed,  5 Aug 2026 00:55:02 +0000 (UTC)
Date: Tue, 4 Aug 2026 20:55:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [GIT PULL v2 0/9] Fixes for 11.1-rc
Message-ID: <20260805005501.GA582221@fedora>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l+KQmjkkl2IPgPI3"
Content-Disposition: inline
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--l+KQmjkkl2IPgPI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--l+KQmjkkl2IPgPI3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyieUACgkQnKSrs4Gr
c8jfgAgAjvsiTmQVommMvye1u889nJdy+NNDPAw037q02KgrpQiO6NPWInx/ZkD7
HNv4YIwDdeLL0zrWksW6JruxPEaH2IUAxVMtXl2X1/gjKptxEAf+5Z0FFBsGGaDj
WDIoClycFysyRfDlRQMu/EtNHi37e+bTK3hB2wzI/FC6m+87e36DkGERDFcDfB15
4hepGrDSrcxK60yP3h4HIaF2WNEzGcmyHrTaiRAhhJeKnsBvZcTOdeofHlr2OI1J
lbJJfmh2zx4YAbj+RMO8dHHljY7vtBn18Qi07sExdM2I5UJ59JFbDPAIbOf/yOux
SUNmNItbMKPlnVpktBIxeadIUBvrDA==
=5gEj
-----END PGP SIGNATURE-----

--l+KQmjkkl2IPgPI3--


