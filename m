Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6CDCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVJ9-0003HC-St; Thu, 30 Apr 2026 13:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIv-0003CW-EF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIu-00007f-0V
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777570559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jMYL5CKBB6HMIwSVyRRg9+k3Wec8qJojH5yqf+e5N+4=;
 b=UawOlE6BdRZXl0RDtFviq+sPM0L4xgJ9rB3+SF8hc88X1pvCh4RTT3PG+7RRYr9ceBeeII
 twh4qAhDqSxAzRWrUy+IGGy0krvcposlaywiH21WmDwkyulo6fYR3qMMQHjQqQL0ufYcPE
 AZVCWh2KXOa2Hp9phNVVVA0vlEPGgKw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-mCDqmRAANTO2-6eMvcOFUg-1; Thu,
 30 Apr 2026 13:35:56 -0400
X-MC-Unique: mCDqmRAANTO2-6eMvcOFUg-1
X-Mimecast-MFC-AGG-ID: mCDqmRAANTO2-6eMvcOFUg_1777570555
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03CA118004A9; Thu, 30 Apr 2026 17:35:55 +0000 (UTC)
Received: from localhost (unknown [10.2.17.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A5C31953947; Thu, 30 Apr 2026 17:35:54 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:35:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/48] fpu patch queue
Message-ID: <20260430173553.GA31855@fedora>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z5SVsNEKyCFxDNQ4"
Content-Disposition: inline
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--z5SVsNEKyCFxDNQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--z5SVsNEKyCFxDNQ4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnzkvkACgkQnKSrs4Gr
c8jexQf/WXCLdDoIlFPs/9v9/SfcHCu6K1cWu5YF2j19hgitCTrFnjwewW2YucQb
bDiOVKP56sOslWPf3TWZFWcgj4SVMuy+i9KCLPqWQg7S4E2n6SfZldkHZxWg1+l6
ULNnEkgCWH7L9WNf26MPp3z6crGBKObSkdW2H95AE+FfPFOp+JaMcYX+HnSroOqT
XC0AP9yvRTooiI2EXi0nNzDRfGZPRIoIZ7qbXqtdhh1TlyvBBbauiaKYqUEl7/p5
+sk+APGvSHdZZjDWWcUGc4k7dG819L4IBdkwPDirXfmsW9xkKqg/FCWwYMylvyd3
BPRY5tIwAXKYwME7bRvWEePJuet6xQ==
=/4N3
-----END PGP SIGNATURE-----

--z5SVsNEKyCFxDNQ4--


