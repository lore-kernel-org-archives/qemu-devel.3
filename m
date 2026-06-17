Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC39CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvwi-0000ro-Ns; Wed, 17 Jun 2026 15:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvwg-0000qy-Qi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvwe-0002OG-Tn
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781724543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LV/qGH+4869/PsC3JQixqNzzr/DPtMbMuscsB2JSQg0=;
 b=ec3yRHO6Tba+NgJOajA1dU5odrDsABNo27vVQ34B4uCezGvj3kxg+NkHB/oap2tLmu/WKl
 LxPyPPrgnkpZOeZJEPZgyVf8jQJM2Oli7ecQECBPBPPhssrzAQpOgM2o18kOuhKij/2Cc1
 3rA6uJY1l67RQ7gBTcVdwMiGmUTBTbo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-i8obRLowMtyomYX-c0GdCg-1; Wed,
 17 Jun 2026 15:29:00 -0400
X-MC-Unique: i8obRLowMtyomYX-c0GdCg-1
X-Mimecast-MFC-AGG-ID: i8obRLowMtyomYX-c0GdCg_1781724538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A71E3195608E; Wed, 17 Jun 2026 19:28:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2319819560A2; Wed, 17 Jun 2026 19:28:57 +0000 (UTC)
Date: Wed, 17 Jun 2026 15:28:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] Docs update for 2026-06-16
Message-ID: <20260617192857.GA694098@fedora>
References: <20260616175535.268519-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MD1oxTtPan3Gfryj"
Content-Disposition: inline
In-Reply-To: <20260616175535.268519-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--MD1oxTtPan3Gfryj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--MD1oxTtPan3Gfryj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoy9XgACgkQnKSrs4Gr
c8h8gAf/fAPOc3L9S+OEo9+ZyOc/vSO66lOw7qPRROuIc7ZTjLv+8GX7EZZx/7pl
U1zjtX+yzF6Iz81jQa2AWiy4A3r/ouc2cp4F4ug0GsUYvW+nDIGcNTc2hoH4enXE
rLf6+t7ZCfWgFgLXxYUql6nCxTfGq8KNnikeam3a71txg+r6S1iHw+pNVktTNRLB
aS5CCkMnVEhDseqSFUlhQWjB+hCZcOYRyg9kjaFmMVmysdtsnUK12SITer++wGS5
thKsymOlox/GMSguDOp98fuI8qMtex+4xyiJD+f2jBJDKvS6+3c4uyBL8Y2X8JHY
kdxwtSnHnrkWZRNWz+0j5WAkAHZxNA==
=SN7e
-----END PGP SIGNATURE-----

--MD1oxTtPan3Gfryj--


