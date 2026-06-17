Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D696CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvyP-00028Y-8L; Wed, 17 Jun 2026 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvyI-00027m-Op
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvyF-00034M-55
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781724642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y5XfiP1W8qexSNqw6aQ/orSvr1btMFBUIMGtCgHzfsI=;
 b=TpOivRJIFSrrsH3XhXWZTxZ3kOKs2ob5g2TzLw7v+1Ojf/HhUNGCnM0eKcW0DS9Rrjg+AG
 lUlaPJmnvj6k0FhM0oUJfi9qXeOmExXzH5W74SQ1IQ1/YKWfGjTk/h17sZX1GDCI+sjDDL
 +mb26fg7o2+JsAS/Kqp0KT6cEwEKAxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-OolRaY27PfS4D7R1OOa-eg-1; Wed,
 17 Jun 2026 15:30:39 -0400
X-MC-Unique: OolRaY27PfS4D7R1OOa-eg-1
X-Mimecast-MFC-AGG-ID: OolRaY27PfS4D7R1OOa-eg_1781724638
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F69919560AE; Wed, 17 Jun 2026 19:30:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90DC4180056E; Wed, 17 Jun 2026 19:30:37 +0000 (UTC)
Date: Wed, 17 Jun 2026 15:30:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/61] target-arm queue
Message-ID: <20260617193036.GA694319@fedora>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4k8f30x6qw/UdCWc"
Content-Disposition: inline
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--4k8f30x6qw/UdCWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--4k8f30x6qw/UdCWc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoy9dwACgkQnKSrs4Gr
c8iE4wf/f/QVGWoWZd6fvNYVLDp7XS8iLT/DQjc/jYnWvcf5FEr4bp737NGDPgTR
4UYEDOQAWe/Q4izjyNnQirV6clPIigrXMtSWmCSB3e9o0ZSf3AhUmXq0jd4vWncV
hJquQpQNCkPQs3mIIxrIkUV2rXEHEVPnIE2dZGD34zgviB2JUYze0pEHQjRpfKh+
3xYKiwcGttr2KUpqPeABxrQOA4BVqTXZT0HgdQLuppav43cg0MeKJdxDwLIScZ9e
2HevSOktLGsC6H9dkZivhjiKERaU1rK8bidVw9o1pOeQeZ4NXvzs/N2r3sec/hnS
B8eMWu1zMaTgqPN+ZjERPw/rztqBqA==
=t7NB
-----END PGP SIGNATURE-----

--4k8f30x6qw/UdCWc--


