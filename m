Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C72FF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjA9-0004Ut-SZ; Sat, 25 Apr 2026 15:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA8-0004Ui-Tf
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA7-0002bs-GA
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3ZMgLC95n/lJAHY19nY0RcjFu8FcAI8DEeil+8Epv8=;
 b=FYPLS7lwS27a+NENpmTFveEcTRBnAba4soa1hOCsuBia/idfEN30LGkEz/lnazm5yxCnFm
 Df89ljxGXkqAvD0TCos/xIEZhFDLQY7lM9pLHi54Ex2sZq5jZEvkf50AVijBxGsQrO0V59
 IBKFiACB7gvmB+bLQZym72dJgvFya5o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-8Iq0CrOJN7yYbMXAVZKUbA-1; Sat,
 25 Apr 2026 15:59:32 -0400
X-MC-Unique: 8Iq0CrOJN7yYbMXAVZKUbA-1
X-Mimecast-MFC-AGG-ID: 8Iq0CrOJN7yYbMXAVZKUbA_1777147172
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE29F1800473; Sat, 25 Apr 2026 19:59:31 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F23461944CED; Sat, 25 Apr 2026 19:59:30 +0000 (UTC)
Date: Sat, 25 Apr 2026 12:58:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/43] Migration patches for 2026-04-23
Message-ID: <20260425165855.GA144105@fedora>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sXWuCANwbzZ0P1se"
Content-Disposition: inline
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--sXWuCANwbzZ0P1se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--sXWuCANwbzZ0P1se
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmns8s4ACgkQnKSrs4Gr
c8h9Ogf/Xf/kiFLnxRkL2YN5lPyKzCiokcCLxMeZenFU4RrjCea+QXJvtRGoIAYV
fsXwY/7dP/88XsFRPBxiTazgMENngpVvXs41sN8Z+TfrBfub8o7l7Ae+SlnupRxx
goiPwyyddku7FA1KGHDxTyhy1ppxuABAr5H6oeABbKxHDVIt0lcnlZAB81Yj2HtC
YnnBvafA6ucLYiXWBYrqlZP6PRx0drqq3tOK/I1qDiQgBYFYpATvRQ44x+n4sm1m
FeZVSdhdsoIHvFcB+CrHj+eCDtc2SHni8nDj9rtzQcaA440RAjuztaQwOdm2/59g
JAoCnU3j6ejPpgZo+hpj64Tzr6Byxw==
=x1z4
-----END PGP SIGNATURE-----

--sXWuCANwbzZ0P1se--


