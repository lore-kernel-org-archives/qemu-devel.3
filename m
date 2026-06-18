Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C000ECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGwq-00028U-Iy; Thu, 18 Jun 2026 13:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGwo-00028B-C9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGwm-0008VS-TW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781805276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6vtKOwmLT9jzwITmSrwTljdXn2wNJMvUp9WbGhA1Y2w=;
 b=ZHrS7H95trwZAws8OLHRcMbPpnOoZArPc7mnplGn2zjIM7EbZH3XdPCAb47pelhFlvLA3n
 N+U4GhWWrX2oVb/X4/MSFV/FMLwkctL6xLNxN1KbrWLXgxk0Ci1xlVQP6BddvxnT1+oCmP
 c+UX/yIYB4x1//Ta7bXf/V9EqAV7xbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-qbdbLkrGMZmDsUmaFF3D6g-1; Thu,
 18 Jun 2026 13:54:34 -0400
X-MC-Unique: qbdbLkrGMZmDsUmaFF3D6g-1
X-Mimecast-MFC-AGG-ID: qbdbLkrGMZmDsUmaFF3D6g_1781805273
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D93E195607F; Thu, 18 Jun 2026 17:54:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16D2118001D2; Thu, 18 Jun 2026 17:54:32 +0000 (UTC)
Date: Thu, 18 Jun 2026 13:54:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/48] Accel patches for 2026-06-18
Message-ID: <20260618175432.GA748677@fedora>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZAultR1MSsWzJRUn"
Content-Disposition: inline
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--ZAultR1MSsWzJRUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ZAultR1MSsWzJRUn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0MNcACgkQnKSrs4Gr
c8hqvAf/V/RGtTcr3c6msdiCXSibe35zO9G5ygP8aTGheF4GvEROiUg9esYdIXnS
9TzX5WkbpuKq3NNoWkFzOljI+a21BfrUuKmvWwP3gL7QlL4lDr8UpIQo1fCYi3Rk
mfZ8OPh8i+L2Uyo8EsB9qIc6TGLUp6EMVz900+HRpIpsEYJNVzUtEVpkj9r0MArt
KGJLXyl2Viz4/r1Cq/xKmam4THarTTYYyRcDz92284zpgntNOowEPiTCKHqWz5XA
yGpvP9yQz+QyRqLy1sesHMwwYVE5kgxa6dIA6wI4Z4G61HYL98LPy3y9Mq3Brcwp
RyfptUbScB5WXT0inWCJr4RWJufBFg==
=eGtg
-----END PGP SIGNATURE-----

--ZAultR1MSsWzJRUn--


