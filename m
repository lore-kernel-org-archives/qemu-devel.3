Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D336DC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1Wv-0001jr-Hk; Wed, 16 Jul 2025 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1RW-0006Nk-ID
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1RP-0000D7-HN
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5W2+1JqLuxZr3RGcrgX5oDgf5VmNI5xVPzFFNT3dhw=;
 b=bSaesA2ZSICZmBRTp9xfrLjGjMn2e2LVwd/g7gEVOHWbL76WcHbo+bRY4Cr30XLkCluhX5
 NoY4PuZnVQtDj3WvMpN0Vo0OonqNkZDxNyCImYmBSYeJjkc/IVZXg9LKYg/HSznW4eF02t
 Xrt9uJO1S4TKg+UbPXjdZ4rg01yAyq4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-fjILiY4tOx2r41CnjQ-sqA-1; Wed,
 16 Jul 2025 08:40:48 -0400
X-MC-Unique: fjILiY4tOx2r41CnjQ-sqA-1
X-Mimecast-MFC-AGG-ID: fjILiY4tOx2r41CnjQ-sqA_1752669648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28051955F41
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 12:40:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CAC6180045B; Wed, 16 Jul 2025 12:40:47 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:40:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL v2 00/29] QAPI patches patches for 2025-07-14
Message-ID: <20250716124046.GA328242@fedora>
References: <20250715063525.3095313-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="48m/yGWijoSfT66P"
Content-Disposition: inline
In-Reply-To: <20250715063525.3095313-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--48m/yGWijoSfT66P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--48m/yGWijoSfT66P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3nc4ACgkQnKSrs4Gr
c8iJLQf+O3ymA3GeuqsWU29cSs8qek/2oVg+2CwwdFcLGejzVe9qTdTT/S4phRJH
Wc959cDZprwDwj7NjCAQjHQaBsquwmOhIohWt08Zx9ErkNlnHvMVTn54y9d6OLhF
H0R8UfJjQZoGdTWb1P7e1dLvcHbhqs2kZw2o/JUXSb4xZtBrqCKFhJHBdL/kpv9n
HXBZQ3f5QWRaIv6mhUj1CyJgRNXp7p7WYZV4CyTs5NVLjejKTigRZ1p3//XHijey
RwcFgw+B5wj/UjUFuwZa5/+qh1HTo1QXKlnQieUOO0eCnRDYS31UZU/qiWlxWS7U
Nzdy8X5RKzilcWKL7czJSSTYlE7Tuw==
=EGkw
-----END PGP SIGNATURE-----

--48m/yGWijoSfT66P--


