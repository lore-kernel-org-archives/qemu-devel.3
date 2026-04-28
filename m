Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB53FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHidn-0008MY-68; Tue, 28 Apr 2026 09:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHidl-0008M2-Ma
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHidj-0002Fe-QB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777383495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1k1paErhz63kczZGm24j9b8ZgQ+q0Trs7CP07dXeXho=;
 b=LLaLD5talQL51gbn14Jn22RUKxhIysfFoS4SlksiQP6skjmFGDkee7dP8BWHYtbI2FUKug
 zqapl6nMHPHoZAFB2apOpE+U9kLPZ+n/9Ve1rby3kHddEABuARbE5E5n2fhz4s/2JAEo/G
 sElO9QueUZ0ibdXUx3rvxeZAbby4Iww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-cGpOHC9ZNdKPZGksBs2QwQ-1; Tue,
 28 Apr 2026 09:38:12 -0400
X-MC-Unique: cGpOHC9ZNdKPZGksBs2QwQ-1
X-Mimecast-MFC-AGG-ID: cGpOHC9ZNdKPZGksBs2QwQ_1777383491
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFD9180065A
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 13:38:11 +0000 (UTC)
Received: from localhost (unknown [10.44.33.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F665180047F; Tue, 28 Apr 2026 13:38:10 +0000 (UTC)
Date: Tue, 28 Apr 2026 08:02:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/10] Misc patches (cleanups, functional tests, GCC bump, 
 ...)
Message-ID: <20260428120219.GA254496@fedora>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y92LM09cQAxde8dX"
Content-Disposition: inline
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--y92LM09cQAxde8dX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--y92LM09cQAxde8dX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnwocsACgkQnKSrs4Gr
c8h/sgf/Z4yBEWUu0jJozTPvlcrD3ob1/pDtsTDYonxrRt79poCbMKIOEZiwMk7Y
Dx3kpRssJVG/t6kGJ6aC7IO1LGjWZRQd5oM6sPOYvSpe5GXzkph2GgbIJMae1Qmg
FFq80xYSEVQvzHjHs8kfcDl9z5L7Wn/qiKaxSUhtvwYYRzaSpS3zs53KNFSR/xcs
aAJ9hYWu8Xv3q5nbujPwPdYU42WftmDSTL9OObuIH/q1AZjMiuYHBhFE0o9ye0pg
w5xB5FA/cDLsmB4s9xTyZJQiKZF0phPtt31B0lncgrMdhZkwFlucqX/+b27xZ+LN
V2tfi7/yzjjW2x5xxUUgNDTzV8v7yg==
=Ijzw
-----END PGP SIGNATURE-----

--y92LM09cQAxde8dX--


