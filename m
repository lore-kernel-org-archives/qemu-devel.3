Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA224C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdnI6-0005Vb-SD; Sun, 28 Jun 2026 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wdnI2-0005Uk-AQ
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 07:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wdnI0-0003RC-8X
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 07:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782644582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCjXfT3bd4tncDeL6DmPJUjfqm8JZc9JfZlCUpjdyFI=;
 b=iriY9mvstsA+GrH36uoUVUT+BuxoSCidOBucrD8Mku/wphTQlo1n06DG6ZffGWWrmfoU7i
 7P9fXIYE8JSrnsoRob9IjC22xcMOGDHUzxMkgAaPhg2fIeTY1xZLrlmOVWPkXnkqqrZYW1
 51CLWU5195GLk4kHi0Ds+09M64PZRxA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-vHsq4xKmMC6Cb-ov8pS0TA-1; Sun,
 28 Jun 2026 07:03:00 -0400
X-MC-Unique: vHsq4xKmMC6Cb-ov8pS0TA-1
X-Mimecast-MFC-AGG-ID: vHsq4xKmMC6Cb-ov8pS0TA_1782644579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03FC619560AA; Sun, 28 Jun 2026 11:02:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED497195608E; Sun, 28 Jun 2026 11:02:57 +0000 (UTC)
Date: Sun, 28 Jun 2026 13:02:06 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] Docs update for 2026-06-26
Message-ID: <20260628110206.GA350847@fedora>
References: <20260626191148.107354-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uKF/ExeB9YT1A9TD"
Content-Disposition: inline
In-Reply-To: <20260626191148.107354-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--uKF/ExeB9YT1A9TD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--uKF/ExeB9YT1A9TD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpA/y4ACgkQnKSrs4Gr
c8iiHgf9EMu6M2uQQlxQT1ptXR3oq+WbikFH6lbYclthnaxmyMSFqK9XwacIj0dL
yM2sESS8UXkcJ5uChztf45Hw5PFYb1Pa4ZR9x8a0KpRIxnA5b4azB+Q83aYyOy1+
vWVQfL4sCuNK11NJg9gv3S9Ao31XQE2lPNCwlG8U00dlhSkvR/xXJ4pAGG7nXct/
Se7L8CQTHjrMj/uEZUtRhq63mmxnba7NUUz1eEftzLJizSspSMrJ3/mGxNO+GolQ
JpW67mQ97DCsWBQ5EuV6yANMkFDxmHk5HYCafSidWYi7sLJDYyrOaEPkEk5isYPJ
AloYE2URyyowgdzEo4cmpx6PhoQd1g==
=M/tr
-----END PGP SIGNATURE-----

--uKF/ExeB9YT1A9TD--


